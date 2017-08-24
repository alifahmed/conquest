#include <cstdio>
#include "smt_lib.h"
#include "concolic.h"
#include <cstring>
#include <map>
#include <fstream>
#include <iomanip>
#include <cstdlib>
#include <queue>
#include <valarray>

using namespace std;

//-------------------------------Utilities -------------------------------------
static inline bool skip_assign(const string &str) {
	if (str.find(g_reset_sig_name) != string::npos) {
		return true;
	}
	return false;
}

char* smt_zeros(uint width){
    char* str = new char[width+3];
    memset(str, 0x30303030, width + 2);
    str[width+2] = 0;
    str[1] = 'b';
    return str;
}

static bool check_assign_dependency(SMTExpr* expr){
	SMTSignal* sig = dynamic_cast<SMTSignal*>(expr);
	if(sig){
		if(sig->parent->is_dep){
			return true;
		}
	}
	else{
		for(auto it:(expr->expr_list)){
			if(check_assign_dependency(it)){
				return true;
			}
		}
	}
	return false;
}

void add_to_rval(set<SMTSigCore*> &assign_set, SMTExpr* expr){
	SMTSignal* sig = dynamic_cast<SMTSignal*>(expr);
	if(sig){
		assign_set.insert(sig->parent);
	}
	else{
		for(auto it:(expr->expr_list)){
			add_to_rval(assign_set, it);
		}
	}
}

void smt_yices_assert(context_t *ctx, term_t term, SMTAssign* assign){
	yices_assert_formula(ctx, term);
	if(enable_yices_debug){
		if(assign){
			//printf(";%s", assign->print(SMT_CLK_CURR).c_str());
			yices_pp_term(stdout, term, 0xFFFFFF, 1, 0);
		}
	}
}

static uint level = 0;

void smt_yices_push(){
	assert(yices_push(yices_context) == 0);
	if(enable_yices_debug){
		printf(";---------[PUSH %u]---------\n", level++);
	}
}

void smt_yices_pop(){
	assert(yices_pop(yices_context) == 0);
	if(enable_yices_debug){
		printf(";---------[POP %u]----------\n", --level);
	}
}

//----------------------------SMT Expr------------------------------------------
std::vector<SMTExpr*>  SMTExpr::all_expr_list;
SMTExpr::SMTExpr(const SMTExprType _type) : type(_type) {
	all_expr_list.push_back(this);
	is_bool = false;
	is_inverted = false;
	yices_term = NULL_TERM;
	is_term_eval_needed = true;
}

SMTExpr::~SMTExpr() {
	
}

void SMTExpr::add(SMTExpr* expr) {
	expr_list.push_back(expr);
}

SMTExpr* SMTExpr::get_child(uint idx) {
    if(idx < expr_list.size()){
        return expr_list[idx];
    }
    return NULL;
}

void SMTExpr::free_all() {
	while(!all_expr_list.empty()){
		delete all_expr_list.back();
		all_expr_list.back() = NULL;
		all_expr_list.pop_back();
	}
}


//----------------------------SMT Unspecified-----------------------------------
SMTUnspecified::SMTUnspecified() : SMTExpr(SMT_EXPR_UNSPECIFIED){
}

void SMTUnspecified::print(std::stringstream& ss) {
	ss << "_UNSPECIFIED_";
    error("Unspecified");
}

term_t SMTUnspecified::eval_term(SMTClkType clk) {
	yices_term = NULL_TERM;
	is_term_eval_needed = false;
	return NULL_TERM;
}


//----------------------------SMT Concat----------------------------------------
SMTConcat::SMTConcat() : SMTExpr(SMT_EXPR_CONCAT){
	repeat = 1;
}

void SMTConcat::print(std::stringstream &ss) {
	const uint count = expr_list.size();
	if(repeat != 1){
		ss << "(bv-repeat ";
	}
	if(count > 1){
		ss << "(bv-concat";
		for(uint i=0; i<count; i++){
			if(expr_list[i] == NULL){
				error("Concatenation failed");
			}
			ss << " ";
			expr_list[i]->print(ss);
		}
		ss << ")";
	}
	else{
		expr_list[0]->print(ss);
	}
	if(repeat != 1){
		ss << " " << repeat << ")";
	}
}

term_t SMTConcat::eval_term(SMTClkType clk) {
	if(is_term_eval_needed){
		is_term_eval_needed = false;
		const uint size = expr_list.size();
		term_t* arr = new term_t[size];
		for(uint i = 0; i < size; i++){
			arr[i] = expr_list[i]->eval_term(clk);
			if(expr_list[i]->is_term_eval_needed){
				is_term_eval_needed = true;
			}
		}
		yices_term = yices_bvconcat(size, arr);
		if(repeat != 1){
			yices_term = yices_bvrepeat(yices_term, repeat);
		}
		delete [] arr;
	}
	return yices_term;
}


//-----------------------------SMT Cust-----------------------------------------
SMTCust::SMTCust(std::string _operand) : SMTExpr(SMT_EXPR_CUSTOM){
    operand = _operand;
}

void SMTCust::print(std::stringstream& ss) {
    if(expr_list.size()){
        ss << "(" << operand;
        for(auto it:expr_list){
            ss << " ";
			it->print(ss);
        }
        ss << ")";
    }
    else{
        ss << operand;
    }
}

term_t SMTCust::eval_term(SMTClkType clk) {
	if(is_term_eval_needed){
		if(operand == "and"){
			is_term_eval_needed = false;
			const uint size = expr_list.size();
			term_t* arr = new term_t[size];
			for(uint i = 0; i < size; i++){
				arr[i] = expr_list[i]->eval_term(clk);
				if(expr_list[i]->is_term_eval_needed){
					is_term_eval_needed = true;
				}
			}
			yices_term = yices_and(size, arr);
			delete [] arr;
		}
		else if(operand == "/="){
			yices_term = yices_neq(expr_list[0]->eval_term(clk), expr_list[1]->eval_term(clk));
			is_term_eval_needed = expr_list[0]->is_term_eval_needed | expr_list[1]->is_term_eval_needed;
		}
		else if(operand == "true"){
			is_term_eval_needed = false;
			yices_term = yices_true();
		}
		else{
			error("wrong SMTCust type");
		}
	}
	return yices_term;
}

//-----------------------------SMT Unary----------------------------------------
SMTUnary::SMTUnary() : SMTExpr(SMT_EXPR_UNARY) {
    opcode = "invalid";
    //opcode = SMT_INVALID;
	func = NULL;
}

/*SMTUnary::SMTUnary(SMTUnaryOpcode opcode) {
    set_opcode(opcode);
}*/

void SMTUnary::set_opcode(char ivl_code) {
	switch (ivl_code) {
		case '-': opcode = "bv-neg";
            //set_opcode(SMT_BV_NOT);
			func = yices_bvneg;
			break;
		case '~': opcode = "bv-not";
            //set_opcode(SMT_BV_NOT);
			func = yices_bvnot;
			break;
		case '&': opcode = "bv-redand";
            //set_opcode(SMT_RE_AND);
			func = yices_redand;
			break;
		case '|': opcode = "bv-redor";
            //set_opcode(SMT_RE_OR);
			func = yices_redor;
			break;
		case '^': 
			error("TODO: add support for unary \'^\'");
			opcode = "bv-redcomp";
			//info("inverted bv-redcomp used");
			is_inverted = true;
			break;
		case 'A': opcode = "bv-redand";
			//info("inverted bv-redand used");
			func = yices_redand;
			is_inverted = true;
			break;
        case '!':                               //converted from bool to bitvector
		case 'N': opcode = "bv-redor";
			//info("inverted bv-redor used");
			func = yices_redor;
			is_inverted = true;
			break;
		case 'X': 
			error("TODO: add support for unary \'^\'");
			opcode = "bv-redcomp";
			//info("bv-redcomp used");
			break;
		default: 
			;
	}
}

void SMTUnary::set_opcode(const ivl_expr_t expr) {
	const char ivl_code = ivl_expr_opcode(expr);
	set_opcode(ivl_code);
	if(opcode == "invalid"){
		error("Unsupported unary opcode for conversion: %c (%s:%u)", ivl_code, ivl_expr_file(expr), ivl_expr_lineno(expr));
	}
}

void SMTUnary::print(std::stringstream& ss) {
	assert(expr_list.size() == 1);

	//print
	if(is_inverted){
		ss << "(bv-not ";
	}
	ss << "(" << opcode << " ";
	expr_list[0]->print(ss);
	ss << ")";
	if(is_inverted){
		ss << ")";
	}
}

term_t SMTUnary::eval_term(SMTClkType clk) {
	if(is_term_eval_needed){
		yices_term = func(expr_list[0]->eval_term(clk));
		is_term_eval_needed = expr_list[0]->is_term_eval_needed;
		if(is_inverted){
			yices_term = yices_bvnot(yices_term);
		}
	}
	return yices_term;
}


//----------------------------SMT Binary----------------------------------------
SMTBinary::SMTBinary() : SMTExpr(SMT_EXPR_BINARY) {
	opcode = "invalid";
	func = NULL;
	is_signed = false;
}

void SMTBinary::set_opcode(char ivl_code) {
	switch (ivl_code) {
		case '+':
			opcode = "bv-add";
			func = yices_bvadd;
			break;
		case '-':
			opcode = "bv-sub";
			func = yices_bvsub;
			break;
		case '*':
			opcode = "bv-mul";
			func = yices_bvmul;
			break;
		case 'p':
            error("TODO: bvpower");
			opcode = "bv-pow";
			break;
        case 'n':
			opcode = "bv-comp";				//converted from bool to bitvector
			func = yices_redcomp;
            is_inverted = true;
			break;
		case 'e':
			opcode = "bv-comp";				//converted from bool to bitvector
			func = yices_redcomp;
			break;
		case '<':
			if(is_signed){
				opcode = "bv-slt";
				func = yices_bvslt_atom;
			}
			else{
				opcode = "bv-lt";
				func = yices_bvlt_atom;
			}
			is_bool = true;
			break;
		case 'L':
			if(is_signed){
				opcode = "bv-sle";
				func = yices_bvsle_atom;
			}
			else{
				opcode = "bv-le";
				func = yices_bvle_atom;
			}
			is_bool = true;		
			break;
		case '>':
			if(is_signed){
				opcode = "bv-sgt";
				func = yices_bvsgt_atom;
			}
			else{
				opcode = "bv-gt";
				func = yices_bvgt_atom;
			}
			is_bool = true;
			break;
		case 'G':
			if(is_signed){
				opcode = "bv-sge";
				func = yices_bvsge_atom;
			}
			else{
				opcode = "bv-ge";
				func = yices_bvge_atom;
			}
			is_bool = true;
			break;
		case '&':
			opcode = "bv-and";
			func = yices_bvand2;
			break;
		case '|':
			opcode = "bv-or";
			func = yices_bvor2;
			break;
		case '^':
			opcode = "bv-xor";
			func = yices_bvxor2;
			break;
		case 'A':
			opcode = "bv-nand";
			func = yices_bvnand;
			break;
		case 'O':
			opcode = "bv-nor";
			func = yices_bvnor;
			break;
		case 'X':
			opcode = "bv-xnor";
			func = yices_bvxnor;
			break;
		case 'a':
			opcode = "bv-and";
			func = yices_bvand2;
			break;      //converted from bool to bitvector
		case 'o':
			opcode = "bv-or";
			func = yices_bvor2;
			break;      //converted from bool to bitvector
		case 'l':
			opcode = "bv-shl";
			func = yices_bvshl;
			break;
		case 'r':
			opcode = "bv-lshr";
			func = yices_bvlshr;
			break;
		case 'R':
			opcode = "bv-ashr";
			func = yices_bvashr;
			break;
		default: 
			;	
	}
}

void SMTBinary::set_opcode_from_expr(const ivl_expr_t expr) {
	const char ivl_code = ivl_expr_opcode(expr);
	set_opcode(ivl_code);
	if(opcode == "invalid") {
		error("Unsupported binary opcode for conversion: %c (%s:%u)", ivl_code, ivl_expr_file(expr), ivl_expr_lineno(expr));
	}
}

void SMTBinary::print(std::stringstream& ss) {
	assert(expr_list.size() == 2);
		
	if(is_inverted){ ss << "(bv-not "; }
	if(is_bool){ ss << "(bool-to-bv "; }
	ss << "(" << opcode << " ";
	expr_list[0]->print(ss);
	ss << " ";
	expr_list[1]->print(ss);
	ss << ")";
	if(is_bool){ ss << ")"; }
	if(is_inverted){ ss << ")"; }
}

term_t SMTBinary::eval_term(SMTClkType clk) {
	if(is_term_eval_needed){
		yices_term = func(expr_list[0]->eval_term(clk), expr_list[1]->eval_term(clk));
		if(is_bool){
			term_t p[1];
			p[0] = yices_term;
			yices_term = yices_bvarray(1, p);
		}
		if(is_inverted){
			yices_term = yices_bvnot(yices_term);
		}
		is_term_eval_needed = expr_list[0]->is_term_eval_needed | expr_list[1]->is_term_eval_needed;
	}
	return yices_term;
}


//----------------------------SMT Logic-----------------------------------------
SMTLogic::SMTLogic() : SMTExpr(SMT_EXPR_LOGIC) {
	opcode = 0;
	func = NULL;
}

void SMTLogic::set_opcode(char ivl_code, bool is_inverted) {
	opcode = ivl_code;
    SMTLogic::is_inverted = is_inverted;
}

string SMTLogic::get_opcode() {
	switch (opcode) {
		case '&': 
			if(is_inverted){
				func = yices_bvnand;
				return "bv-nand";
			}
			else{
				func = yices_bvand2;
				return "bv-and";
			}
			break;
		case '|': 
			if(is_inverted){
				func = yices_bvnor;
				return "bv-nor";
			}
			else{
				func = yices_bvor2;
				return "bv-or";
			}
			break;
		case '^': 
			if(is_inverted){
				func = yices_bvxnor;
				return "bv-xnor";
			}
			else{
				func = yices_bvxor2;
				return "bv-xor";
			}
			break;
		default: 
			error("Unknown opcode for SMTLogic");	
	}
    return NULL;
}

void SMTLogic::print(std::stringstream& ss) {
	//info("SMTLogic used. Implement invert inheritance to improve perf");
	assert(expr_list.size() == 2);
	ss << "(" << get_opcode();
	vector<SMTExpr*>::iterator it;
	for(auto it:expr_list){
		ss << " ";
		it->print(ss);
	}
	ss << ")";
}

term_t SMTLogic::eval_term(SMTClkType clk) {
	if(is_term_eval_needed){
		yices_term = func(expr_list[0]->eval_term(clk), expr_list[1]->eval_term(clk));
		is_term_eval_needed = expr_list[0]->is_term_eval_needed | expr_list[1]->is_term_eval_needed;
	}
	return yices_term;
}


//----------------------------SMT Ternary----------------------------------------
SMTTernary::SMTTernary() : SMTExpr(SMT_EXPR_TERNARY) {
}

void SMTTernary::print(std::stringstream& ss) {
	assert(expr_list.size() == 3);
    
	ss << "(ite (= ";
	expr_list[0]-> print(ss);
	ss << " 0b1) ";
	expr_list[1]->print(ss);
	ss << " ";
    expr_list[2]->print(ss);
	ss << ")";
}

term_t SMTTernary::eval_term(SMTClkType clk) {
	if(is_term_eval_needed){
		term_t cond = yices_eq(expr_list[0]->eval_term(clk), yices_bvconst_one(1));
		yices_term = yices_ite(cond, expr_list[1]->eval_term(clk), expr_list[2]->eval_term(clk));
		is_term_eval_needed = expr_list[0]->is_term_eval_needed | expr_list[1]->is_term_eval_needed | expr_list[2]->is_term_eval_needed;
	}
	return yices_term;
}



//----------------------------SMT Assign----------------------------------------
vector<SMTAssign*> SMTAssign::assign_map;
SMTAssign::SMTAssign(SMTClkType _clk_type, SMTAssignType _assign_type,
		SMTExpr* _lval, SMTExpr* _rval, bool _is_commit):
			clk_type(_clk_type), assign_type(_assign_type), id(assign_map.size()),
			lval(_lval), rval(_rval), is_commit(_is_commit){
	covered_any_clock = false;
	yices_term = NULL_TERM;
	block = NULL;
	assign_map.push_back(this);
	process = SMTProcess::curr_proc;
	assert(process);
	is_first_time = true;
}

void SMTAssign::init_assign() {
    instrument();
	partial_assign_check();
    SMTProcess::curr_proc->add_assign(this);
    SMTSigCore* lval_sig = get_lval_sig_core();
	lval_sig->assignments.push_back(this);
	if(rval->type != SMT_EXPR_NUMBER){
		lval_sig->is_state_variable = false;
	}
}

term_t SMTAssign::update_term() {
	SMTSignal* sig = dynamic_cast<SMTSignal*>(lval);
	assert(sig);
	sig->parent->update_next_version();
	yices_term = yices_eq(lval->eval_term(SMT_CLK_NEXT), rval->eval_term(SMT_CLK_CURR));
	if(is_commit){
		sig->parent->commit();
	}
	return yices_term;
}

term_t SMTAssign::get_current_term() {
	return yices_eq(lval->eval_term(SMT_CLK_CURR), rval->eval_term(SMT_CLK_CURR));
}

bool SMTAssign::is_covered() {
	return covered_any_clock;
}

std::string SMTAssign::print() {
	if(is_first_time){
		is_first_time = false;
		ss << "(assert (= ";
		lval->print(ss);
		ss << "   ";
		rval->print(ss);
		ss << ")) ;" << id << "\n";
	}
	return ss.str();
}

void SMTAssign::set_covered(uint sim_num) {
    if(covered_any_clock == false){
        covered_any_clock = true;
        covered_in_sim = sim_num;
    }
}

void SMTAssign::partial_assign_check() {
	SMTSignal* sig = dynamic_cast<SMTSignal*>(lval);
	assert(sig);
	SMTSigCore* parent = sig->parent;
	if((sig->msb - sig->lsb) != (parent->width - 1)){
		error("Part select lval for assignment: %s", parent->name.c_str());
	}
}

SMTSigCore* SMTAssign::get_lval_sig_core() {
    SMTSignal* lval_sig = dynamic_cast<SMTSignal*>(lval);
    assert(lval_sig);
    return lval_sig->parent;
}

SMTAssign* SMTAssign::get_assign(uint id) {
	assert(id < assign_map.size());
    return assign_map[id];
}

uint SMTAssign::get_assign_count() {
	return assign_map.size();
}

void SMTAssign::instrument() {
	const string &str = print();
    if(skip_assign(str)){
		this->set_covered(0);
        return;
    }
	//fprintf(g_out, " $display(\";A %u\");\t\t//%s", id, str.c_str());
	conc_flush(g_out);
}

void SMTAssign::print_coverage(std::ofstream& report) {
    //report << "      BRANCH |         SIM |\n";
    //report << "----------------------------\n";
    //puts("\n------------------------------------REPORT------------------------------------");
	uint total_stmt = 0;
	uint total_branch = 0;
	uint covered_stmt = 0;
	uint covered_branch = 0;
	const uint count = assign_map.size();
	for(uint i=0; i<count; i++){
		SMTAssign* assign = assign_map[i];
		switch(assign->assign_type){
			case SMT_ASSIGN_BLOCKING:
			case SMT_ASSIGN_NON_BLOCKING:
				total_stmt++;
				if(assign->is_covered()){
					covered_stmt++;
				}
				break;
			case SMT_ASSIGN_BRANCH:
				total_branch++;
				if(assign->is_covered()){
					covered_branch++;
                    report << setw(12) << assign->id << " ";
                    report << setw(12) << assign->covered_in_sim << " \n";
				}
				else{
					printf("[UNC BRANCH] %s", assign->print().c_str());
                    report << setw(12) << assign->id << " ";
                    report << setw(12) << "UNC" << " \n";
				}
				break;
			default:
				error("Invalid assign type");
		}
	}
	printf("[TOTAL BRANCH]   %u\n", total_branch);
	printf("[COVERED BRANCH] %u\n", covered_branch);
}


//------------------------SMT Blocking Assign-----------------------------------
SMTBlockingAssign::SMTBlockingAssign(SMTExpr* lval, SMTExpr* rval) : 
	SMTAssign(SMT_CLK_CURR, SMT_ASSIGN_BLOCKING, lval, rval, true){
    init_assign();
}

//----------------------SMT Non Blocking Assign---------------------------------
SMTNonBlockingAssign::SMTNonBlockingAssign(SMTExpr* lval, SMTExpr* rval) :
	SMTAssign(SMT_CLK_NEXT, SMT_ASSIGN_NON_BLOCKING, lval, rval, false) {
    init_assign();
}

//-----------------------------SMT Branch---------------------------------------
uint SMTBranch::total_branch_count;
uint SMTBranch::covered_branch_count;
uint SMTBranch::saved_total_branch;
uint SMTBranch::saved_covered_branch;
vector<SMTBranch*> SMTBranch::all_branches_list;
SMTBranch::SMTBranch(SMTBranchNode* _parent_node, SMTBranchType type, 
			SMTExpr* lval, SMTExpr* rval) :
		SMTAssign(SMT_CLK_CURR, SMT_ASSIGN_BRANCH, lval, rval, false), 
        type(type),
		list_idx(_parent_node->branch_list.size()),
		parent_node(_parent_node){
	coverage = new bool[g_unroll+2];
	memset(coverage, false, sizeof(bool)*(g_unroll+2));
	parent_node->branch_list.push_back(this);
	covered_any_clock = false;
	k_permit_covered = 0;
	all_branches_list.push_back(this);
	is_dep = true;
}

bool SMTBranch::is_covered_clk(uint clock) {
	assert(clock <= g_unroll);
	return coverage[clock];
}

SMTBranch::~SMTBranch() {
	delete [] coverage;
}

void SMTBranch::set_covered_clk(uint sim_num, uint clock) {
	assert(clock <= g_unroll);
	coverage[clock] = true;
	if(!is_covered()){
		set_covered(sim_num);
		covered_branch_count++;
		//if(covered_branch_count == total_branch_count){
		//	end_concolic();
		//}
	}
}

void SMTBranch::clear_covered_clk(uint clock) {
    coverage[clock] = false;
}

void SMTBranch::update_distance() {
	update_edge();
    block->update_distance();
}

void SMTBranch::get_state_variables(std::set<SMTSigCore*> &sigs, SMTExpr* expr) {
	SMTSignal* sig = dynamic_cast<SMTSignal*>(expr);
	if(sig){
		if(sig->parent->is_state_variable){
			sigs.insert(sig->parent);
		}
	}
	else{
		for(auto it:(expr->expr_list)){
			get_state_variables(sigs, it);
		}
	}
}

void SMTBranch::update_edge() {
	block->is_edge_updated = true;
	set<SMTSigCore*> sigs;
	get_state_variables(sigs, lval);
	if(sigs.size()){
		//delete all predecessor edges
		block->predecessors.clear();
		
		//get condition term
		term_t cond_term = get_current_term();
		
		for(auto a_sig:sigs){
			for(auto assign:a_sig->assignments){
				//get assignment term
				term_t assign_term = assign->get_current_term();
				
				//check if (c & p) is satisfiable
				yices_reset_context(yices_context);
				yices_assert_formula(yices_context, yices_and2(cond_term, assign_term));
				if(yices_check_context(yices_context, NULL) == STATUS_SAT){
					SMTBasicBlock* assign_bb = assign->block;
					block->predecessors.insert(assign_bb);
					if(!assign_bb->is_edge_updated){
						assign_bb->update_edge();
					}
				}
			}
		}
	}
}

void SMTBranch::instrument() {
    const string &str = print();
	total_branch_count++;
    if(skip_assign(str)){
		covered_branch_count++;
		this->set_covered(0);
        return;
    }
	//fprintf(g_out, "%*c$display(\";A %u\");\t\t//%s", get_indent(), ' ', id, str.c_str());
	conc_flush(g_out);
}

SMTBranch* SMTBranch::create_case_branch(SMTBranchNode* parent, SMTExpr* case_expr) {
	return new SMTBranch(parent, SMT_BRANCH_CASE, parent->cond, case_expr);
}

SMTBranch* SMTBranch::_create_condit_branch(SMTBranchNode* parent, const char* num_expr) {
	if(parent->cond_width > 1){
		SMTUnary* un = new SMTUnary();
		un->set_opcode('|');
		un->add(parent->cond);
		parent->cond = un;
		parent->cond_width = 1;
	} 
	SMTNumber* smt_number = new SMTNumber(num_expr, 1, false);
	return new SMTBranch(parent, SMT_BRANCH_CONDIT, parent->cond, smt_number);
}

SMTBranch* SMTBranch::create_true_branch(SMTBranchNode* parent) {
	return _create_condit_branch(parent, "1");
}

SMTBranch* SMTBranch::create_false_branch(SMTBranchNode* parent) {
	return _create_condit_branch(parent, "0");
}

SMTBranch* SMTBranch::create_default_branch(SMTBranchNode* parent) {
    SMTExpr* smt_and = new SMTCust("and");
    SMTExpr* cond = parent->cond;
    const uint size = parent->branch_list.size();
    for(uint i = 0; i < size; i++){
        SMTExpr* smt_neq = new SMTCust("/=");
        smt_neq->add(cond);
        smt_neq->add(parent->branch_list[i]->rval);
        smt_and->add(smt_neq);
    }
    
	return new SMTBranch(parent, SMT_BRANCH_CASE, smt_and, new SMTCust("true"));
}

void SMTBranch::clear_k_permit() {
    for(auto it:all_branches_list){
		it->k_permit_covered = 0;
	}
}

void SMTBranch::clear_coverage(uint min_clock) {
    for(auto it:all_branches_list){
		for(uint clock = min_clock; clock <= g_unroll; clock++){
            it->coverage[clock] = false;
        }
	}
}

void SMTBranch::save_coverage() {
	saved_total_branch = total_branch_count;
	saved_covered_branch = covered_branch_count;
	for(auto it:all_branches_list){
		it->saved_coverage =  it->covered_any_clock;
	}
}

void SMTBranch::restore_coverage() {
	total_branch_count = saved_covered_branch;
	covered_branch_count = saved_covered_branch;
	for(auto it:all_branches_list){
		it->covered_any_clock = it->saved_coverage;
	}
}

term_t SMTBranch::update_term() {
	//printf("%s", print(clk_type).c_str());
	yices_term = yices_eq(lval->eval_term(SMT_CLK_CURR), rval->eval_term(SMT_CLK_CURR));
	return yices_term;
}

void SMTBranch::update_fsm() {
	for(auto br:all_branches_list){
		if(br->is_dep == false){
			//check if lval is a signal
			if(br->lval->type == SMT_EXPR_SIGNAL){
				SMTSigCore* sig_core = dynamic_cast<SMTSignal*>(br->lval)->parent;
				if(sig_core->is_state_variable){
					//is a state variable. First clear the predecessors of this block
					br->block->predecessors.clear();
					
					SMTNumber* value = dynamic_cast<SMTNumber*>(br->rval);
					assert(value);
					//check which assignments have same number
					for(auto assign:sig_core->assignments){
						SMTNumber* comp_value = dynamic_cast<SMTNumber*>(assign->rval);
						assert(comp_value);
						if(value->is_equal(comp_value)){
							//found an assignment which matches the branch condition
							br->block->predecessors.insert(assign->block);
						}
					}
				}
			}
		}
	}
}

//-------------------------SMT Branch Node--------------------------------------
SMTBranchNode::SMTBranchNode() {
}

//-------------------------SMT Branch Case--------------------------------------
/*SMTBranchCase::SMTBranchCase() : SMTBranchNode(SMT_BRANCH_CASE){
	error("TODO: Branch case");
}

SMTBranch* SMTBranchCase::get_switch_cond() {
	error("TODO: Branch case");
    return NULL;
}*/


//----------------------------SMT Number----------------------------------------
const char hex_map[16] = {	'0', '1', '2', '3', '4', '5', '6', '7',
							'8', '9', 'A', 'B', 'C', 'D', 'E', 'F'};

SMTNumber::SMTNumber(const char* bits, int bit_width, bool is_signed) : SMTExpr(SMT_EXPR_NUMBER) {
	has_undef = false;
    this->is_signed = is_signed;
    assert(bit_width);
	width = bit_width;
	value_hex = "";
    
	const int nbits = bit_width - 1;
	//print in binary
	value_bin = "";
	value_bin.reserve(width+1);
	for(int i = nbits; i>=0; i--){
		if((bits[i] != '0') && (bits[i] != '1')){
			value_bin += '0';
            has_undef = true;
            //info("Number expression has x or z or ?");
		}
		else{
			value_bin += bits[i];
		}
	}
    
    if(!(width & 3)){
        uint sum = 0;
        for(uint i=0; i<width; i++){
            uint offset = 3 - (i & 3);
            sum += (value_bin[i] - '0') << offset;
            if(offset == 0){
                value_hex += hex_map[sum];
                sum = 0;
            }
        }
    }
}

void SMTNumber::print(std::stringstream& ss) {
	if(width & 3){
        ss << "0b" << value_bin;
    }
    else{
        ss << "0h" << value_hex;
    }
}

void SMTNumber::emit_verilog_value() {
    if(is_signed){
        fprintf(g_out, "%u\'s", width);
    }
    else{
        fprintf(g_out, "%u\'", width);
    }
    
    if(width & 3){
        fprintf(g_out, "b%s", value_bin.c_str());
    }
    else{
        fprintf(g_out, "h%s", value_hex.c_str());
    }
}

term_t SMTNumber::eval_term(SMTClkType clk) {
	if(is_term_eval_needed){
		yices_term = yices_parse_bvbin(value_bin.c_str());
		is_term_eval_needed = false;
	}
	return yices_term;
}

bool SMTNumber::is_equal(SMTNumber* num) {
	return (value_bin == num->value_bin);
}

//---------------------------SMT Signal Core------------------------------------
std::unordered_map<ivl_signal_t, SMTSigCore*> SMTSigCore::sig_to_core_map;
vector<SMTSigCore*> SMTSigCore::reg_list;
vector<SMTSigCore*> SMTSigCore::input_list;
SMTSigCore::SMTSigCore(ivl_signal_t sig){
    name = ivl_signal_basename(sig);
    width = ivl_signal_width(sig);
    zeros = smt_zeros(width);
	sig_to_core_map[sig] = this;
    int msb;
    int lsb;
    get_sig_msb_lsb(sig, &msb, &lsb);
    if(msb < lsb){
        error("msb < lsb => currently not supported");
    }
    assert(width == (msb-lsb+1));
    if(ivl_signal_port(sig) != IVL_SIP_INPUT){
        reg_list.push_back(this);
		is_dep = false;
		is_state_variable = true;
    } else{
        input_list.push_back(this);
		is_dep = true;
		is_state_variable = false;
    }
	curr_version = 0;
    next_version = 0;
	was_in_queue = false;
    //set width type
    bv_type = yices_bv_type(width);

    //create g_unroll number of terms
    for(uint i = 0; i <= g_unroll; i++){
        term_t new_term = yices_new_uninterpreted_term(bv_type);
        yices_set_term_name(new_term, (name + string("_") + to_string(i)).c_str());
        term_stack.push_back(new_term);
    }

    //create zero term
    init_term = yices_eq(term_stack[0], yices_bvconst_zero(width));
	version_at_clock.resize(g_unroll + 2);
}

SMTSigCore::~SMTSigCore() {
}

void SMTSigCore::update_next_version() {
    next_version++;
	
    if(next_version == term_stack.size()){
        term_t new_term = yices_new_uninterpreted_term(bv_type);
        yices_set_term_name(new_term, (name + string("_") + std::to_string(next_version)).c_str());
        term_stack.push_back(new_term);
    }
}

term_t SMTSigCore::get_term(SMTClkType clk) {
	uint version;
	if(clk == SMT_CLK_CURR){
		version = curr_version;
	} else {
		version = next_version;
	}
	
	return term_stack[version];
}

void SMTSigCore::free_all() {
	for(auto it:reg_list){
		delete it;
	}
	reg_list.clear();
	for(auto it:input_list){
		delete it;
	}
	input_list.clear();
}

SMTSigCore* SMTSigCore::get_parent(ivl_signal_t sig) {
	return sig_to_core_map[sig];
}

void SMTSigCore::clear_all_versions() {
    for(auto it:reg_list){
        it->curr_version = 0;
        it->next_version = 0;
    }
    for(auto it:input_list){
        it->curr_version = 0;
        it->next_version = 0;
    }
}

void SMTSigCore::commit() {
    curr_version = next_version;
}

void SMTSigCore::commit_versions(uint clock) {
	for(auto it:reg_list){
		it->commit();
		it->version_at_clock[clock] = it->curr_version;
	}
}

void SMTSigCore::restore_versions(uint clock) {
	for(auto it:reg_list){
		it->curr_version = it->version_at_clock[clock];
		it->next_version = it->curr_version;
	}
	set_input_version(clock);
}

void SMTSigCore::yices_insert_reg_init(context_t* ctx) {
	for(auto it:reg_list){
		smt_yices_assert(ctx, it->init_term, NULL);
	}
}

void SMTSigCore::print_state_variables(ofstream &out) {
	out << "//state variables:";
	for(auto it:reg_list){
		if(it->is_state_variable){
			out << ' ' << it->name;
		}
	}
    out << "\n\n";
}

void SMTSigCore::set_input_version(uint version) {
    for(auto it:input_list){
        it->curr_version = version;
    }
}


//----------------------------SMT Signal----------------------------------------
SMTSignal::SMTSignal() : SMTExpr(SMT_EXPR_SIGNAL) {
}

SMTSignal::SMTSignal(ivl_signal_t sig) : SMTExpr(SMT_EXPR_SIGNAL) {
    parent = SMTSigCore::get_parent(sig);
    get_sig_msb_lsb(sig, &msb, &lsb);
}

void SMTSignal::print(std::stringstream& ss) {
	if((msb - lsb) == (parent->width - 1)){
		ss << parent->name << ' ';
	}
	else{	//part select
		ss << "(bv-extract " << msb << " " << lsb << " " << parent->name << " )";
	}
}

term_t SMTSignal::eval_term(SMTClkType clk) {
	yices_term = parent->get_term(clk);
	if((msb - lsb) != (parent->width - 1)){
		yices_term = yices_bvextract(yices_term, lsb, msb);
	}
	return yices_term;
}

//----------------------------SMT Process---------------------------------------
SMTProcess* SMTProcess::curr_proc;
vector<SMTProcess*> SMTProcess::process_list;
SMTProcess SMTProcess::g_comb_process;

SMTProcess::SMTProcess() {
    process_list.push_back(this);
	is_edge_triggered = false;
    entry_block = new SMTBasicBlock();
    exit_block = entry_block;
    top_bb = entry_block;
    is_expanded = false;
    expanding_now = false;
}

/*SMTProcess::SMTProcess(SMTProcess& obj) {
	process_list.push_back(this);
	is_edge_triggered = obj.is_edge_triggered;
    is_expanded = obj.is_expanded;
	expanding_now = obj.expanding_now;
	sensitivity_list = obj.sensitivity_list;
	signal_assign_list = obj.sig_assign_list;
	
	
    exit_block = NULL;
    top_bb = entry_block;
}*/


SMTProcess::~SMTProcess() {
    delete entry_block;
    entry_block = NULL;
}

void SMTProcess::add_assign(SMTAssign* assign) {
    top_bb->assign_list.push_back(assign);
    assign->block = top_bb;
}

//static void merge(SMTBasicBlock* block, uint pos, SMTProcess* proc){
    
//}

void SMTProcess::expand() {
    /*if(expanding_now){
        error("Cyclic dependency");
    }
    expanding_now = true;
    if(is_expanded == false){
        if(sig_assign_blocks.size()){
            //Some value is assigned within this process. Need to expand.
            //Go through basic blocks having blocking assignments and expand.
            for(auto blk:sig_assign_blocks){
                const uint size = blk->assign_list.size();
                for(uint i = 0; i < size; i++){
                    SMTAssign* assign = blk->assign_list[i];
                    if(assign->assign_type == SMT_ASSIGN_BLOCKING){
                        SMTSigCore* sig = assign->get_lval_sig_core();
                        const uint size_dep = sig->dependent_process.size();
                        //pad expanded version of all the processes that are sensitive to this assign
                        if(size_dep){
                            sig->dependent_process[0]->expand();
                            SMTBasicBlock* entry_block = sig->dependent_process[0]->entry_block;
                            SMTBasicBlock* exit_block = sig->dependent_process[0]->exit_block;
                            for(uint i = 1; i < size_dep; i++){
                                SMTProcess* proc = sig->dependent_process[i];
                                proc->expand();
                                proc->entry_block->predecessors.push_back(exit_block);
                                exit_block->successors.push_back(proc->entry_block);
                                exit_block = proc->exit_block;
                            }
                        }
                    }
                }
            }
        }
        is_expanded = true;
    }
    expanding_now = false;*/
}

void SMTProcess::combine_processes() {
    //only need to combine processes when size is more than 1
    if(process_list.size() > 1){
        //first we need to expand all processes based on dependency
        for(auto it:process_list){
            it->expand();
        }
    }
}

void SMTProcess::make_circular() {
    for(auto it:process_list){
        if(it->entry_block != it->exit_block){
            if(it->entry_block->predecessors.size() == 0){
                it->entry_block->predecessors.insert(it->exit_block);
            }
        }
    }
}

//--------------------------SMT Basic Block-------------------------------------
uint SMTBasicBlock::id_counter = 0;
std::vector<SMTBasicBlock*> SMTBasicBlock::block_list;
SMTBasicBlock::SMTBasicBlock() : id(id_counter) {
    id_counter++;
    block_list.push_back(this);
	weight = 0;
	distance = initial_distance;
	is_edge_updated = false;
}

/*SMTBasicBlock::SMTBasicBlock(SMTBasicBlock& obj) : id(id_counter) {
	id_counter++;
	block_list.push_back(this);
	assign_list = obj.assign_list;
	
}*/

void SMTBasicBlock::print_assigns(ofstream &out) {
    for(auto it:assign_list){
        out << it->print();
    }
}

void SMTBasicBlock::print(ofstream &out) {
    out << "[" << id << "] weight: " << weight << " distance: " << distance << '\n';
    print_assigns(out);
    if(successors.size()){
        out << "[S]";
        for(auto it:successors){
            out << ' ' << it->id;
        }
        out << '\n';
    }
    if(predecessors.size()){
        out << "[P]";
        for(auto it:predecessors){
            out << ' ' << it->id;
        }
        out << '\n';
    }
    out << '\n';
}

void SMTBasicBlock::update_distance() {
	distance = 0;
	queue<SMTBasicBlock*> bb_queue;
	bb_queue.push(this);
	while(!bb_queue.empty()){
		SMTBasicBlock* top_bb = bb_queue.front();
		bb_queue.pop();
		const uint curr_dist = top_bb->distance;
		for(auto it:top_bb->predecessors){
			if((curr_dist + it->weight) < it->distance){
				it->distance = curr_dist + it->weight;
				bb_queue.push(it);
			}
		}
	}
}

void SMTBasicBlock::update_edge() {
	if(assign_list[0]->assign_type == SMT_ASSIGN_BRANCH){
		SMTBranch* br = dynamic_cast<SMTBranch*>(assign_list[0]);
		br->update_edge();
	}
}


void SMTBasicBlock::print_all(ofstream &out) {
    out << "/*\n";
    for(auto it:block_list){
        it->print(out);
    }
    out << "*/\n\n";
}

void SMTBasicBlock::reset_distances() {
    for(auto it:block_list){
        it->distance = initial_distance;
    }
}

//----------------------------SMT Globals---------------------------------------
void SMTFreeAll(){
	SMTExpr::free_all();
    SMTSigCore::free_all();
}
