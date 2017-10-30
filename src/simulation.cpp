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

//configuration
const bool		enable_error_check = true;
const bool		enable_obs_padding = true;
const bool		enable_sim_copy = false;
const bool		enable_yices_debug = false;
const bool		enable_all_target = false;
const bool		enable_cfg_directed = false;
const bool		enable_multi_target = true;


static SMTBranch* target_branch = NULL;
static inline void free_stack();
context_t *yices_context;
static vector<constraint_t*> constraints_stack;
static char sim_file_name[64];
static char cnst_file_name[64];
static char mem_file_name[64];
static uint hash_table[1024*16];
static uint sim_num;

static SMTBranch* selected_branch;
static uint selected_clock;

static inline void compile() {
    string cmd = "iverilog " + string(g_output_file) + " " + \
                  string(g_tb_file) + " -o conc_run.vvp";
	system(cmd.c_str());
}

static constraint_t* create_clock(uint clock){
	constraint_t* cnst = new constraint_t;
	cnst->type = CNST_CLK;
	cnst->clock = clock;
	cnst->obj = NULL;
    cnst->hash_value = 0;
	cnst->index = 0;
	cnst->yices_term = -1;
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
	cnst->index = constraints_stack.size();
    cnst->yices_term = assign->update_term();
    if(cnst->yices_term <= 0){
        yices_print_error(stdout);
        error("Term evaluation failed at assign id: %u", assign->id);
    }
    
	if(assign->assign_type == SMT_ASSIGN_BRANCH){
		cnst->type = CNST_BRANCH;
		SMTBranch* br = dynamic_cast<SMTBranch*>(assign);
		assert(br);
        update_path_hash_map(cnst);
    	br->set_covered_clk(sim_num, clock);
	} else{
        cnst->type = CNST_ASSIGN;
		assign->set_covered(sim_num);
    }
    return cnst;
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
	
	//constraints_stack.push_back(create_clock(0));
	while(true){
		fscanf(f_test, "%s%u", tag, &val);
		if(strcmp(tag, ";_C") == 0){
			clock = val;
			if(clock == g_unroll + 1)	break;
			constraints_stack.push_back(create_clock(clock));
            SMTSigCore::set_input_version(clock);
            SMTSigCore::commit_versions(clock);
		}
		else if (strcmp(tag, ";A") == 0){
			SMTAssign* assign = SMTAssign::get_assign(val);
			constraints_stack.push_back(create_constraint(clock, assign));
		}
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
    compile();
    init_hash_table();
    ctx_config_t *config = yices_new_config();
    yices_default_config_for_logic(config, "QF_BV");
    yices_context = yices_new_context(config);
    yices_free_config(config);
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
	static bool is_first_time = true;
	if(enable_sim_copy){
		string cmd = "cp data.mem " + string(mem_file_name);
		system(cmd.c_str());
		cmd = "vvp conc_run.vvp > " + string(sim_file_name);
		system(cmd.c_str());
	} else{
		system("vvp conc_run.vvp > sim.log");
	}
	if(is_first_time){
		is_first_time = false;
		copy_file("sim.log", "first_sim.log");
	}
}

static void dump_yices_constraints(uint top_idx) {
	for(uint i=0; i<=top_idx; i++){
		constraint_t* cnst = constraints_stack[i];
		if(cnst->type != CNST_CLK){
            yices_assert_formula(yices_context, cnst->yices_term);
		}
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

static uint call_to_solver = 0;

typedef struct{
	constraint_t* cnst;
	SMTBranch* br;
}br_cnst_t;

bool compare_dist(br_cnst_t* a, br_cnst_t* b){
    if(a->br->block->distance == b->br->block->distance){
        return a->cnst->clock < b->cnst->clock;
    }
	return a->br->block->distance < b->br->block->distance;
}

static void update_path_taken(br_cnst_t* alt_path){
    uint alt_path_hash = alt_path->cnst->hash_value + hash_table[alt_path->br->id % 16384]*alt_path->cnst->index;
	path_hash_map.insert(alt_path_hash);
}

static bool is_path_taken(br_cnst_t* alt_path){
    uint alt_path_hash = alt_path->cnst->hash_value + hash_table[alt_path->br->id % 16384]*alt_path->cnst->index;
    return path_hash_map.find(alt_path_hash) != path_hash_map.end();
}

static bool find_next_cfg(){
	const uint size = constraints_stack.size();
	vector<br_cnst_t*> branches;
	
	//create branches
	uint idx = 0;
	while(constraints_stack[idx]->clock == 0){
		idx++;
	}
	for(; idx < size; idx++){
		constraint_t* cnst = constraints_stack[idx];
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
		uint clock = it->cnst->clock;
		//reset context
		yices_reset_context(yices_context);

		//insert initial assertion to zero for registers
		SMTSigCore::yices_insert_reg_init(yices_context);

		/*uint i = 0;
		while(constraints_stack[i] != it->cnst){
			constraint_t* cnst = constraints_stack[i];
			if(cnst->type != CNST_CLK){
				smt_yices_assert(yices_context, cnst->yices_term, cnst->obj);
			}
			i++;
		}

		term_t yices_term = yices_eq(it->cnst->yices_term_lval, it->br->rval->eval_term(SMT_CLK_CURR));

		//add mutated branch
		smt_yices_assert(yices_context, yices_term, it->br);*/
		
		constraint_t** cnst = constraints_stack.data();
		while((*cnst)->clock != clock){
			if((*cnst)->type != CNST_CLK){
				smt_yices_assert(yices_context, (*cnst)->yices_term, (*cnst)->obj);
			}
			cnst++;
		}
		assert((*cnst)->type == CNST_CLK);
		cnst++;
		
		//restore version
		SMTSigCore::restore_versions(clock);
		const SMTProcess* target_process = it->cnst->obj->process;
		while(*cnst != it->cnst){
			const SMTProcess* process = (*cnst)->obj->process;
			if(!process->is_edge_triggered || (process == target_process)){
				term_t term = (*cnst)->obj->update_term();
				smt_yices_assert(yices_context, term, (*cnst)->obj);
			}
			cnst++;
		}

		//add mutated branch
		smt_yices_assert(yices_context, it->br->update_term(), it->br);
		

		call_to_solver++;
		if(solve_constraints(clock)){
			selected_branch = it->br;
			selected_clock = clock;
			//insert hash value even if potentially incorrect
			update_path_taken(it);
			if(!enable_error_check){
				it->br->set_covered_clk(sim_num+1, clock);
			}
			printf("[FOUND %u--%u] %s", clock, selected_branch->block->distance, it->br->print().c_str());
			selected_branch->k_permit_covered++;
			selected_branch->block->distance++;
			return true;
		}
	}
	
	return false;
}

static void smt_yices_dump_error(){
    //reset context
    yices_reset_context(yices_context);

    //insert initial assertion to zero for registers
    SMTSigCore::yices_insert_reg_init(yices_context);

    FILE* f_dbg = fopen("debug.txt", "w");
    
    //dump yices constraints
    for(auto it:constraints_stack){
		if(it->type != CNST_CLK){
            fprintf(f_dbg, "[%3u]    ", it->obj->id);
            yices_pp_term(f_dbg, it->yices_term, 1000, 1, 0);
            yices_assert_formula(yices_context, it->yices_term);
            if(yices_check_context(yices_context, NULL) == STATUS_UNSAT){
                break;
            }
		}
	}
    
    fclose(f_dbg);
}

static void check_satisfiability(){
    //reset context
    yices_reset_context(yices_context);

    //insert initial assertion to zero for registers
    SMTSigCore::yices_insert_reg_init(yices_context);

    //dump yices constraints
    dump_yices_constraints(constraints_stack.size()-1);

    //check status
    if(!check_yices_status()){
        smt_yices_dump_error();
        error("Simulation not satisfiable");
    }
}

static bool concolic_iteration(uint sim_num) {
	set_sim_log_name(sim_num);
    set_cnst_log_name(sim_num);
    set_mem_log_name(sim_num);
	
    //generates sim_x.log
    sim();
    
    //reset variable versions to zero
    SMTSigCore::clear_all_versions();
    
    //builds stack and also updates coverage
    build_stack();
	if(target_branch->is_covered()){
        clock_t end_time = clock();
		free_stack();
		printf("Branch %u covered in %u iterations\n", target_branch->id, sim_num);
        printf("Time: %0.2lf sec\n", (end_time - start_time)/double(CLOCKS_PER_SEC));
		return false;
	}
	
	if(SMTBranch::total_branch_count ==  SMTBranch::covered_branch_count){
		printf("humba\n");
		exit(0);
		return false;
	}
    
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
	is_found = find_next_cfg();
	
	free_stack();
	return is_found;
}

void start_concolic() {
    //freopen("/dev/null", "w", stderr);
	init();
	
	if(enable_multi_target){
		SMTBranch::save_coverage();
		SMTBasicBlock::save_predecessors();
		ofstream report("report_cov.log");
		info("Total targets: %d", SMTBasicBlock::target_list.size());
		uint iterations = 1;
		for(auto it:SMTBasicBlock::target_list){
			copy_file(g_data_mem_raw, g_data_mem);
			g_data.load(g_data_mem);
			target_branch = dynamic_cast<SMTBranch*>(it->assign_list[0]);
			assert(target_branch);
			target_branch->k_permit_covered = 0;
			SMTBasicBlock::restore_predecessors();
			SMTBasicBlock::reset_flags();
			SMTBranch::clear_coverage(0);
			SMTBranch::restore_coverage();
			path_hash_map.clear();
			target_branch->update_distance();
			sim_num = 0;
			selected_branch = NULL;
			while (concolic_iteration(sim_num)) {
				iterations++;
				sim_num++;
				if(sim_num >= 200){
					break;
				}
			}
			if(target_branch->is_covered() == false){
				sim_num = 200;
			}
			report << setw(12) << it->assign_list[0]->id << " ";
			report << setw(12) << sim_num << endl;
		}
		info("Total Iterations: %d", iterations);
		report.close();
		yices_free_context(yices_context);
		yices_exit();
		SMTFreeAll();
		exit(0);
	}
	else if(enable_all_target){
		SMTBranch::save_coverage();
		SMTBasicBlock::save_predecessors();
		const uint count = SMTAssign::get_assign_count();
		ofstream report("report_cov.log");
		for(uint i=0; i<count; i++){
			SMTAssign* assign = SMTAssign::get_assign(i);
			if(assign->assign_type == SMT_ASSIGN_BRANCH){
				copy_file(g_data_mem_raw, g_data_mem);
				g_data.load(g_data_mem);
				target_branch = dynamic_cast<SMTBranch*>(assign);
				assert(target_branch);
				target_branch->k_permit_covered = 0;
				SMTBasicBlock::restore_predecessors();
				SMTBasicBlock::reset_flags();
				SMTBranch::clear_coverage(0);
				SMTBranch::restore_coverage();
				path_hash_map.clear();
				target_branch->update_distance();
				sim_num = 0;
				selected_branch = NULL;
				while (concolic_iteration(sim_num)) {
					sim_num++;
					if(sim_num >= 200){
						break;
					}
				}
				if(target_branch->is_covered() == false){
					sim_num = 200;
				}
				report << setw(12) << assign->id << " ";
				report << setw(12) << sim_num << endl;
			}
		}
		report.close();
		yices_free_context(yices_context);
		yices_exit();
		SMTFreeAll();
		exit(0);
	}
	else{
		target_branch = SMTBasicBlock::get_target();
		target_branch->update_distance();
		ofstream out("cfg_info.txt");
		SMTBasicBlock::print_all(out);
		SMTSigCore::print_state_variables(out);
		out.close();
		sim_num = 0;
		selected_branch = NULL;
		while (concolic_iteration(sim_num)) {
			sim_num++;
			if(sim_num >= 200){
				break;
			}
		}
		if(target_branch->is_covered() == false){
			printf("Target not covered\n");
		}
	}
}

void end_concolic(){
    clock_t end_time = clock();
	fflush(stdout);
    
    ofstream report("report_cov.log");
    //report << "[TIME] " << difftime(end_time, start_time) << " sec\n";
	//report << "[TIME] " << (end_time - start_time)/double(CLOCKS_PER_SEC) << " sec\n";
	//report << "[ITER] " << sim_num << '\n';
    //report << "[SOLVER CALL] " << call_to_solver << '\n';
	//report << "[CNST BEFORE] " << total_constraints_before << '\n';
	//report << "[CNST AFTER] " << total_constraints_after << '\n';
	//report << "[TOTAL BRANCH] " << SMTBranch::total_branch_count << '\n';
	//report << "[COVERED BRANCH] " << SMTBranch::covered_branch_count << '\n';
    SMTAssign::print_coverage(report);
    report.close();
    
    //printf("[TIME] %.0lf sec\n", difftime(end_time, start_time));
	printf("[TIME] %.2lf sec\n", (end_time - start_time)/double(CLOCKS_PER_SEC));
    printf("[ITER] %u\n", sim_num);
    printf("[SOLVER CALL] %u\n", call_to_solver);
	
    yices_free_context(yices_context);
    yices_exit();
    SMTFreeAll();
    exit(0);
}
