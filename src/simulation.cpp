#include "concolic.h"
#include "smt_lib.h"
#include <cstdio>
#include <cstring>
#include <vector>
#include <cstdlib>
#include <string>
#include <fstream>
#include <set>
#include <ctime>
#include <iomanip>
#include <algorithm>

using namespace std;

typedef enum{
    SEARCH_ALGO_PARTIAL_DFS,
    SEARCH_ALGO_HARD_CGS,
    SEARCH_ALGO_SOFT_CGS,
    SEARCH_ALGO_SOFT_CGS_2,
    SEARCH_ALGO_CD,
	SEARCH_ALGO_CFG_DIRECTED
}search_algo_t;

//configuration
const bool		enable_error_check = true;
const bool		enable_obs_padding = true;
const bool		enable_sim_copy = false;
const bool      enable_concrete_states = false;
const bool		enable_k_permit = false;
const uint      symbolic_input_depth = 2;
const search_algo_t search_algo = SEARCH_ALGO_CFG_DIRECTED;
const uint		k_permit_effort = 1;
const bool		enable_unsolvable_branch_elimination = true;
const bool      enable_ud_chain = false;				//can not be activated with yices_incremental
const bool		enable_yices_api = true;
const bool		enable_yices_debug = false;
const bool		enable_yices_incremental = false;	//push/pop
const bool		enable_fsm_cfg_hybrid = true;



static SMTBranch* target_branch;
static inline void free_stack();
static clock_t start_time;
context_t *yices_context;
static vector<constraint_t*> constraints_stack;
static char sim_file_name[64];
static char cnst_file_name[64];
static char mem_file_name[64];
static uint hash_table[1024*16];
static uint sim_num;
FILE* f_dbg;
uint total_constraints_before = 0;
uint total_constraints_after = 0;
constraint_t* last_cnst = NULL;
static vector<constraint_t*> dumped_cnsts;

static SMTBranch* selected_branch;
static uint selected_clock;
static uint selected_idx = 0;
static uint min_selected_clock = 0x8FFFFFFF;

static void build_define_stream() {
    ofstream out("defines.ys");
    for (uint clk = 0; clk <= g_unroll+1; clk++) {
        SMTSigCore::print_all_defines(out, clk);
    }
	SMTSigCore::print_reg_init(out);
    out << '\n';
    out.close();
	if(enable_sim_copy){
		system("cp defines.ys tests/defines.ys");
	}
}

static inline void compile() {
	system("iverilog_orig tb_concolic.v instrumented.v -o conc_run.vvp");
}

static constraint_t* create_clock(uint clock){
	constraint_t* cnst = new constraint_t;
	cnst->type = CNST_CLK;
	cnst->clock = clock;
	cnst->obj = NULL;
	cnst->constraint = "\n;------------------------------------------------CLK " \
            + to_string(clock) + "-----------------------------------------------\n";
	cnst->val = clock;
    cnst->hash_value = 0;
    return cnst;
}

static set<uint> path_hash_map;
static uint g_hash_value;
static void update_path_hash_map(constraint_t* cnst){
    cnst->hash_value = g_hash_value;
    g_hash_value += hash_table[cnst->obj->id % 16384]*cnst->index;
    path_hash_map.insert(g_hash_value);
}

static constraint_t* create_constraint(uint clock, SMTAssign* assign){
	constraint_t* cnst = new constraint_t;
	cnst->clock = clock;
	cnst->obj = assign;
	cnst->val = assign->id;
	cnst->is_dumped = false;
	cnst->index = constraints_stack.size();
	last_cnst = cnst;
	if(enable_yices_api){
		cnst->yices_term = assign->update_term();
		cnst->yices_term_lval = assign->lval->yices_term;
		if(cnst->yices_term <= 0){
			yices_print_error(stdout);
			error("Term evaluation failed at assign id: %u", assign->id);
		}
	} else{
		cnst->constraint = assign->print_cnst();
	}
	last_cnst = NULL;
    
	if(assign->assign_type == SMT_ASSIGN_BRANCH){
		cnst->type = CNST_BRANCH;
		SMTBranch* br = dynamic_cast<SMTBranch*>(assign);
		assert(br);
        update_path_hash_map(cnst);
        if(!br->is_covered()){
            //printf("[COVERED NEW] %s", br->print(SMT_CLK_CURR).c_str());
            if(search_algo == SEARCH_ALGO_CD){
                SMTBranch::clear_k_permit();
            }
        }
    	br->set_covered_clk(sim_num, clock);
        if(search_algo == SEARCH_ALGO_SOFT_CGS_2){
            static SMTBranch* prev_br = NULL;
            if(prev_br){
                br->prev_branches.insert(prev_br);
            }
            prev_br = br;
        }
		if(br->is_dep && enable_yices_incremental){
			smt_yices_push();
		}
	} else{
        cnst->type = CNST_ASSIGN;
		assign->set_covered(sim_num);
    }
	if(enable_yices_incremental){
		smt_yices_assert(yices_context, cnst->yices_term, assign);
	}
    return cnst;
}

static void set_input_version(uint clock){
    const uint size = g_in_port_list.size();
    for(uint i=0; i<size; i++){
        g_in_port_list[i]->curr_version = clock;
    }
}

static void check_stack_integrity(FILE* f_test, uint &clk){
	char tag[16];
	uint val;
	
	for(uint i=0; i<selected_idx; i++){
		fscanf(f_test, "%s%u", tag, &val);
		if(val != constraints_stack[i]->val){
			//reset context
			yices_reset_context(yices_context);

			//insert initial assertion to zero for registers
			SMTSigCore::yices_insert_reg_init(yices_context);

			//reset file pointer
			rewind(f_test);

			//free constraint stack
			free_stack();

			//reset variable versions to zero
			SMTSigCore::clear_all_versions();
			SMTSigCore::clear_states();
			
			//reset clock
			clk = 0;
			
			//print reset message
			info("Context mismatch: Recovered");
			
			return;
		}
		else if(tag[2] == 'C'){
			clk = val;
		}
	}
}

static void build_stack() {
	FILE* f_test = NULL;
	if(enable_sim_copy){
		f_test = fopen(sim_file_name, "r");
	} else{
		f_test = fopen("sim.log", "r");
	}
	assert(f_test);
	uint clock = 0;
    g_hash_value = 0;
	char tag[16];
	uint val;
	
	if(enable_yices_incremental){
		//check is inter simulation stack can be reused
		check_stack_integrity(f_test, clock);
	}
	
	//constraints_stack.push_back(create_clock(0));
	while(true){
		fscanf(f_test, "%s%u", tag, &val);
		if(strcmp(tag, ";_C") == 0){
			clock = val;
            if(enable_concrete_states){
                SMTSigCore::commit_states();
            }
			if(clock == g_unroll + 1)	break;
			constraints_stack.push_back(create_clock(clock));
            set_input_version(clock);
            SMTSigCore::commit_versions();
		}
		else if (strcmp(tag, ";A") == 0){
			SMTDispAssign* assign = SMTDispAssign::get_assign(val);
			constraints_stack.push_back(create_constraint(clock, assign));
		}
        else if(enable_concrete_states){
            SMTSigCore* sig = g_name_sig_map[tag];
            assert(sig);
            sig->temp_state = val;
        }
		total_constraints_after++;
	}

	fclose(f_test);
}

static inline void free_stack() {
	while(!constraints_stack.empty()){
		delete constraints_stack.back();
		constraints_stack.pop_back();
	}
}

void init_hash_table(){
    for(uint i=0; i< 1024*16; i++){
        hash_table[i] = rand();
    }
}

static void init() {
    init_hash_table();
	if(enable_yices_api){
		if(enable_yices_debug){
			f_dbg = fopen("debug.log", "w");
		}
		ctx_config_t *config = yices_new_config();
		yices_default_config_for_logic(config, "QF_BV");
		yices_context = yices_new_context(config);
		yices_free_config(config);
		if(enable_yices_incremental){
			//insert initial assertion to zero for registers
			SMTSigCore::yices_insert_reg_init(yices_context);
		}
	} else{
		build_define_stream();
	}
	compile();
	if(enable_unsolvable_branch_elimination){
		SMTSigCore::update_is_dep();
		SMTBranch::update_is_dep();
	}
	if(enable_fsm_cfg_hybrid && (search_algo == SEARCH_ALGO_CFG_DIRECTED)){
		SMTBranch::update_fsm();
	}
}

static void set_sim_log_name(uint sim_num) {
	sprintf(sim_file_name, "tests/sim_%04u.log", sim_num);
}

static void set_cnst_log_name(uint sim_num) {
	sprintf(cnst_file_name, "tests/constraints_%04u.ys", sim_num);
}

static void set_mem_log_name(uint sim_num) {
	sprintf(mem_file_name, "tests/data_%04u.mem", sim_num);
}

static void sim() {
	if(enable_sim_copy){
		string cmd = "cp data.mem " + string(mem_file_name);
		system(cmd.c_str());
		cmd = "vvp conc_run.vvp > " + string(sim_file_name);
		system(cmd.c_str());
	} else{
		system("vvp conc_run.vvp > sim.log");
	}
}

static void dump_yices_constraints(uint top_idx) {
	for(uint i=0; i<=top_idx; i++){
		constraint_t* cnst = constraints_stack[i];
		if(cnst->type != CNST_CLK){
			smt_yices_assert(yices_context, cnst->yices_term, cnst->obj);
		}
	}
}

static void dump_yices_ud(constraint_t* cnst){
	for(auto it:cnst->sig_list){
		cnst_list_t* cnst_list = it;
		const uint size = cnst_list->size();
		for(uint i=0; i<size; i++){
			constraint_t* next_cnst = cnst_list->at(i);
			if(!next_cnst->is_dumped && (next_cnst->index < constraints_stack.size())){
				next_cnst->is_dumped = true;
				dumped_cnsts.push_back(next_cnst);
				smt_yices_assert(yices_context, next_cnst->yices_term, cnst->obj);
				dump_yices_ud(next_cnst);
			}
		}
	}
}

static void dump_file_ud(constraint_t* cnst, ofstream &f_cons){
	for(auto it:cnst->sig_list){
		cnst_list_t* cnst_list = it;
		const uint size = cnst_list->size();
		for(uint i=0; i<size; i++){
			constraint_t* next_cnst = cnst_list->at(i);
			if(!next_cnst->is_dumped && (next_cnst->index < constraints_stack.size())){
				next_cnst->is_dumped = true;
				dumped_cnsts.push_back(next_cnst);
				f_cons << next_cnst->constraint;
				f_cons.flush();
				dump_file_ud(next_cnst, f_cons);
			}
		}
	}
}

static inline void dump_constraints_check(ofstream &f_cons, uint top_idx) {
	for(uint i=0; i<=top_idx; i++){
		f_cons << constraints_stack[i]->constraint;
	}
}

static inline void dump_constraints(ofstream &f_cons, uint top_idx) {
    if(enable_concrete_states){
        int min_clock = constraints_stack[top_idx]->clock - symbolic_input_depth + 1;
		if(min_clock < 1){
			min_clock = 1;
		}
		SMTSigCore::print_states(f_cons, min_clock);
		uint idx = top_idx - 1;
		while(constraints_stack[idx]->clock >= (uint)min_clock){
            idx--;
        }
        
        for(idx++; idx <= top_idx; idx++){
            f_cons << constraints_stack[idx]->constraint;
        }
    }
    else{
        for(uint i=0; i<=top_idx; i++){
            f_cons << constraints_stack[i]->constraint;
        }
    }
}

static inline bool check_sat(ifstream &f_in, const string &sim_cnst){
	string cmd = "yices --logic=QF_BV " + sim_cnst + " > model.log";
	system(cmd.c_str());
	f_in.open("model.log");
	string sat;
    getline(f_in, sat);
    if(sat == "sat"){
        return true;
    } else if(sat == "unsat"){
        return false;
    } else{
        error("Syntax error in constraints.ys");
        return false;
    }
}

static bool check_yices_status(){
	smt_status_t status = yices_check_context(yices_context, NULL);
	if(status == STATUS_SAT){
		return true;
	}
	else if(status == STATUS_UNSAT){
		return false;
	}
	else{
		error("Syntax error in constraints");
		return false;
	}
}

static bool solve_constraints(uint clock) {
	bool is_sat = check_yices_status();
	if(is_sat){
		model_t *model = yices_get_model(yices_context, true);
		FILE *f_out = fopen("model.log", "w");
		yices_print_model(f_out, model);
		fclose(f_out);
		g_data.update_and_dump("model.log", g_data_mem);
		yices_free_model(model);
	}
	return is_sat;
}

static void clear_branch_covered(SMTBranch* br, uint start_clock){
    for(uint i=start_clock; i<=g_unroll; i++){
        br->clear_covered_clk(i);
    }
}

static uint call_to_solver = 0;

typedef struct{
	constraint_t* cnst;
	SMTBranch* br;
}br_cnst_t;

bool compare_dist(br_cnst_t* a, br_cnst_t* b){
    if(a->br->block->distance == b->br->block->distance){
        return a->br->k_permit_covered < b->br->k_permit_covered;
    }
	return a->br->block->distance < b->br->block->distance;
}

static bool is_path_taken(br_cnst_t* alt_path){
    uint alt_path_hash = alt_path->cnst->hash_value + hash_table[alt_path->br->id % 16384]*alt_path->cnst->index;
    return path_hash_map.find(alt_path_hash) != path_hash_map.end();
}

static bool find_next_cfg(){
	const uint size = constraints_stack.size();
	vector<br_cnst_t*> branches;
	
	//create branches
	for(uint i=0; i < size; i++){
		constraint_t* cnst = constraints_stack[i];
		if(cnst->type == CNST_BRANCH){
			SMTBranch* br = dynamic_cast<SMTBranch*>(cnst->obj);
			assert(br);
            if(!br->is_dep){
                continue;
            }
			
			//add all selectable branches for sorting
			SMTBranchNode* node = br->parent_node;
			for(auto it:node->branch_list){
				//if((it != br) && (it->is_covered_clk(clock) == false)){
				if(it != br){
					br_cnst_t* alt_br = new br_cnst_t;
					alt_br->br = it;
					alt_br->cnst = cnst;
                    if(is_path_taken(alt_br) == false){
                        branches.push_back(alt_br);
                    }
				}
			}
		}
	}
	
	//sort by distance
	sort(branches.begin(), branches.end(), compare_dist);
	for(auto it:branches){
		//if(enable_yices_api){
			//reset context
			yices_reset_context(yices_context);
			
			//insert initial assertion to zero for registers
			SMTSigCore::yices_insert_reg_init(yices_context);
			
			uint i = 0;
			while(constraints_stack[i] != it->cnst){
				constraint_t* cnst = constraints_stack[i];
				if(cnst->type != CNST_CLK){
					smt_yices_assert(yices_context, cnst->yices_term, cnst->obj);
				}
				i++;
			}
			
			term_t yices_term = yices_eq(it->cnst->yices_term_lval, it->br->rval->eval_term(SMT_CLK_CURR));
			
			//add mutated branch
			smt_yices_assert(yices_context, yices_term, it->br);
			uint clock = it->cnst->clock;
			call_to_solver++;
			if(solve_constraints(clock)){
				selected_branch = it->br;
				selected_clock = clock;
				selected_idx = constraints_stack.size();
                selected_branch->k_permit_covered++;
				selected_branch->block->distance++;
				if(!enable_error_check){
					it->br->set_covered_clk(sim_num+1, clock);
				}
				printf("[FOUND %d] %s", clock, it->br->print(SMT_CLK_CURR).c_str());
				return true;
			}
		//}
	}
	
	return false;
}

static bool find_next_uncovered() {
	SMTBranch* unc_br = NULL;
	while(!constraints_stack.empty()){
        constraint_t* cnst = constraints_stack.back();
		constraints_stack.pop_back();
		if(cnst->type == CNST_BRANCH){
			SMTBranch* br = dynamic_cast<SMTBranch*>(cnst->obj);
			assert(br);
            if(!br->is_dep){
                continue;
            }
			
			if(enable_yices_incremental){
				smt_yices_pop();
			}
			
			const uint clock = cnst->clock;
			
			if(search_algo == SEARCH_ALGO_CD){
				if(clock < min_selected_clock){
					min_selected_clock = clock;
					SMTBranch::clear_k_permit();
				}
			}
			
            while(true){
                if(search_algo == SEARCH_ALGO_HARD_CGS){
                    unc_br = br->get_next_uncovered();
                }
				else if(enable_k_permit){
					while((unc_br = br->get_next_uncovered(clock))){
						if(unc_br->k_permit_covered < k_permit_effort){
							break;
						}
					}
                }
				else{
					unc_br = br->get_next_uncovered(clock);
				}
                if(!unc_br)     break;
				
				if(enable_yices_api){
					if(!enable_yices_incremental){
						//reset context
						yices_reset_context(yices_context);

						//insert initial assertion to zero for registers
						SMTSigCore::yices_insert_reg_init(yices_context);

						if(enable_ud_chain){
							cnst->is_dumped = true;
							dumped_cnsts.push_back(cnst);
							dump_yices_ud(cnst);
						}
						else{
							//dump yices constraints
							dump_yices_constraints(constraints_stack.size()-1);
						}
					}
					else{
						smt_yices_push();
					}
					
					//add mutated branch
					smt_yices_assert(yices_context, unc_br->update_term(), unc_br);
				}
				else{
					//found an uncovered branch. try to generate input vector for this
					ofstream f_cons("constraints_temp.ys");
					//print_defines(f_cons, clock);
					f_cons << "(include \"defines.ys\")\n";
					
					if(enable_ud_chain){
						cnst->is_dumped = true;
						dumped_cnsts.push_back(cnst);
						dump_file_ud(cnst, f_cons);
					}
					else{
						dump_constraints(f_cons, constraints_stack.size()-1);
					}
					
					//dump uncovered branch constraint
					f_cons << unc_br->print_cnst();
					f_cons << "(check)\n(show-model)\n";
					f_cons.close();
				}
				
				if(enable_ud_chain){
					//clear dumped cnst
					for(auto it:dumped_cnsts){
						it->is_dumped = false;
					}
					dumped_cnsts.clear();
				}
				
                call_to_solver++;
                
				total_constraints_before += constraints_stack.size() + 1;
				total_constraints_after++;
				
                if(solve_constraints(clock)){
                    selected_branch = unc_br;
                    selected_clock = clock;
					selected_idx = constraints_stack.size();
					unc_br->k_permit_covered++;
					if(!enable_error_check){
						unc_br->set_covered_clk(sim_num+1, clock);
					}
                    printf("[FOUND %d] %s", clock, unc_br->print(SMT_CLK_CURR).c_str());
					if(enable_yices_incremental){
						smt_yices_pop();
					}					
                    if((search_algo == SEARCH_ALGO_PARTIAL_DFS) || (search_algo == SEARCH_ALGO_CD)){
                        clear_branch_covered(selected_branch, clock + 1);
                        //SMTBranch::clear_coverage(clock + 1);
                    }
                    return true;
                }
				if(enable_yices_incremental){
					smt_yices_pop();
				}
            }
			br->clear_flag();
		}
        else if(cnst->type == CNST_ASSIGN){
			//revert variable versions
			SMTExpr* smt_concat = cnst->obj->lval;
			const uint count = smt_concat->exprList.size();
			for(uint i=0; i<count; i++){
				SMTSignal* smt_sig = dynamic_cast<SMTSignal*>(smt_concat->exprList[i]);
				assert(smt_sig);
				if(cnst->obj->is_commit){
					smt_sig->parent->revert();
				}
				smt_sig->parent->next_version--;
			}
        }
        else if(cnst->type == CNST_CLK){
            //revert input versions
            set_input_version(cnst->clock - 1);
            SMTSigCore::revert_versions();
			if(cnst->clock == 2){
				break;
			}
        }
	}
    return false;
}

static void check_satisfiability(){
	if(enable_yices_api){
		if(!enable_yices_incremental){
			//reset context
			yices_reset_context(yices_context);

			//insert initial assertion to zero for registers
			SMTSigCore::yices_insert_reg_init(yices_context);

			//dump yices constraints
			dump_yices_constraints(constraints_stack.size()-1);

			if(enable_yices_debug){
				fflush(f_dbg);
			}
		}
		
		//check status
		if(!check_yices_status()){
			error("Simulation not satisfiable");
		}
	} else{
		ofstream f_cons("sim_constraints.ys");
		f_cons << "(include \"defines.ys\")\n";
		dump_constraints_check(f_cons, constraints_stack.size()-1);
		f_cons << "(check)\n";
		f_cons.close();
		ifstream f_in;
		bool is_sat = check_sat(f_in, "sim_constraints.ys");
		f_in.close();
		if(!is_sat){
			error("Simulation not satisfiable");
		}
	}
}

ofstream iter_out("report_iter.log");

static bool concolic_iteration(uint sim_num) {
	if(enable_yices_debug){
		printf("---------------------------------------------new sim---------------------------------------\n");
	}
	set_sim_log_name(sim_num);
    set_cnst_log_name(sim_num);
    set_mem_log_name(sim_num);
	
    //generates sim_x.log
    sim();
    
	if(!enable_yices_incremental){
		//reset variable versions to zero
		SMTSigCore::clear_all_versions();
		SMTSigCore::clear_states();
	}
    
	if(!enable_yices_api){
		g_define_out.open("defines.ys", ios_base::app);
	}
	
    //builds stack and also updates coverage
    build_stack();
	if(target_branch->is_covered() && search_algo == SEARCH_ALGO_CFG_DIRECTED){
		if(!enable_yices_incremental){
			free_stack();
		}
		printf("[TARGET COVERED %u]\n", target_branch->id);
		return false;
	}
	if(enable_yices_debug){
		printf("\n");
	}
	
	if(!enable_yices_api){
		g_define_out.close();
	}
	
	if(SMTBranch::total_branch_count ==  SMTBranch::covered_branch_count){
		printf("humba\n");
		exit(0);
		return false;
	}
    
	iter_out << SMTBranch::covered_branch_count << endl;

	if(enable_error_check){
		//check satisfiability
		check_satisfiability();

		//check if selected branch is covered
		if(selected_branch){
			if(!selected_branch->is_covered_clk(selected_clock)){
				error("Selected branch is not covered by simulation");
			}
		}
	}
    
	bool is_found;
	if(search_algo == SEARCH_ALGO_CFG_DIRECTED){
		is_found = find_next_cfg();
	}
	else{
		is_found = find_next_uncovered();
	}
	
	if(!enable_yices_incremental){
		free_stack();
	}
	if(enable_ud_chain){
		SMTSigCore::free_connected_cnst();
	}
	return is_found;
}

void start_concolic() {
    freopen("/dev/null", "w", stderr);
	init();
	SMTBranch::save_coverage();
	if(search_algo == SEARCH_ALGO_CFG_DIRECTED){
		const uint count = SMTDispAssign::get_assign_count();
		ofstream report("report_cov.log");
		for(uint i=0; i<count; i++){
			SMTDispAssign* assign = SMTDispAssign::get_assign(i);
			if(assign->assign_type == SMT_ASSIGN_BRANCH){
				system("cp -f data_raw.mem data.mem");
				target_branch = dynamic_cast<SMTBranch*>(assign);
				assert(target_branch);
				target_branch->k_permit_covered = 0;
				SMTBasicBlock::reset_distances();
				SMTBranch::clear_coverage(0);
				SMTBranch::restore_coverage();
				path_hash_map.clear();
				SMTProcess::curr_proc->update_distances(target_branch);
				sim_num = 0;
				selected_branch = NULL;
				while (concolic_iteration(sim_num)) {
					sim_num++;
					if(sim_num >= 2000){
						break;
					}
				}
				if(target_branch->is_covered() == false){
					sim_num = 2000;
				}
				report << setw(12) << assign->id << " ";
                report << setw(12) << sim_num << " \n";
			}
		}
		report.close();
		if(enable_yices_api){
			yices_free_context(yices_context);
			yices_exit();
		}
		SMTContAssign::free_print_map();
		SMTFreeAll();
		exit(0);
	}
	else{
		sim_num = 0;
		start_time = clock();
		while (concolic_iteration(sim_num)) {
			sim_num++;
		}
		end_concolic();
	}
}

void end_concolic(){
    clock_t end_time = clock();
	fflush(stdout);
    iter_out.close();
	if(enable_yices_debug){
		fclose(f_dbg);
	}
    
    ofstream report("report_cov.log");
    //report << "[TIME] " << difftime(end_time, start_time) << " sec\n";
	//report << "[TIME] " << (end_time - start_time)/double(CLOCKS_PER_SEC) << " sec\n";
	//report << "[ITER] " << sim_num << '\n';
    //report << "[SOLVER CALL] " << call_to_solver << '\n';
	//report << "[CNST BEFORE] " << total_constraints_before << '\n';
	//report << "[CNST AFTER] " << total_constraints_after << '\n';
	//report << "[TOTAL BRANCH] " << SMTBranch::total_branch_count << '\n';
	//report << "[COVERED BRANCH] " << SMTBranch::covered_branch_count << '\n';
    SMTDispAssign::print_coverage(report);
    report.close();
    
    //printf("[TIME] %.0lf sec\n", difftime(end_time, start_time));
	printf("[TIME] %.2lf sec\n", (end_time - start_time)/double(CLOCKS_PER_SEC));
    printf("[ITER] %u\n", sim_num);
    printf("[SOLVER CALL] %u\n", call_to_solver);
	printf("[CNST BEFORE] %u\n", total_constraints_before);
	printf("[CNST AFTER] %u\n", total_constraints_after);
	
	if(enable_yices_api){
		yices_free_context(yices_context);
		yices_exit();
	}
    SMTContAssign::free_print_map();
    SMTFreeAll();
    exit(0);
}
