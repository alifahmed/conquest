#pragma once

#include "ivl_target.h"
#include "concolic.h"
#include <vector>
#include <stack>
#include <string>
#include <sstream>
#include <map>
#include <fstream>
#include <set>

//Forward declarations
class SMTAssign;
class SMTSignal;
class SMTExpr;
class SMTConcat;
class SMTCust;
class SMTBinary;
class SMTUnary;
class SMTTernary;
class SMTNumber;
class SMTBranchNode;
class SMTBranch;
class SMTSigCore;
class SMTDispAssign;
class SMTBasicBlock;
class SMTProcess;
struct constraint_t;


//----------------------------SMT Commons---------------------------------------
typedef enum{
	SMT_CLK_CURR,
	SMT_CLK_NEXT
}SMTClkType;

typedef enum{
	SMT_ASSIGN_CONT,
	SMT_ASSIGN_BLOCKING,
	SMT_ASSIGN_NON_BLOCKING,
	SMT_ASSIGN_BRANCH
}SMTAssignType;

typedef enum{
    SMT_BRANCH_CONDIT,
    SMT_BRANCH_CASE
}SMTBranchType;

typedef enum{
	SMT_EXPR_UNSPECIFIED,	// Unspecified leaf node.

	SMT_EXPR_CONCAT,		// Concatenation of nodes
	SMT_EXPR_UNARY,			// Unary node
	SMT_EXPR_BINARY,		// Binary node
	SMT_EXPR_LOGIC,			// Logic gate node
    SMT_EXPR_CUSTOM,        // Custom node
	SMT_EXPR_TERNARY,		// Ternary node
	SMT_EXPR_NUMBER,		// Number node, for constants. Leaf node.
	SMT_EXPR_SIGNAL			// Signal node, for nets. Leaf Node.
}SMTExprType;

typedef enum{
	CNST_CLK,
	CNST_ASSIGN,
	CNST_BRANCH
}constraint_type_t;

struct constraint_t;
typedef std::vector<constraint_t*> cnst_list_t;

typedef struct constraint_t{
	constraint_type_t type;
	std::string constraint;
	uint clock;
	SMTAssign* obj;
	term_t yices_term;
	term_t yices_term_lval;
	uint val;
	std::vector<cnst_list_t*> sig_list;
	bool is_dumped;
	uint index;
    uint hash_value;
}constraint_t;

class SMTCommons{
public:	
	std::stringstream bv_str;
	bool skip = false;
	bool is_init = false;

	virtual std::string print(SMTClkType clk_type);		//print statement with placeholder only
	virtual void redraw(SMTClkType clk_type) = 0;
};


//----------------------------SMT Expr------------------------------------------
class SMTExpr: public SMTCommons{
protected:	
	SMTExpr(const SMTExprType _type);
		
public:
	const SMTExprType type;
	bool is_bool;		//bool or bitvector
	bool is_inverted;	//inverted if true
	std::vector<SMTExpr*> exprList;
	term_t yices_term;
	
	virtual ~SMTExpr();
	virtual void add(SMTExpr *expr);
    virtual SMTExpr* get_child(uint idx);
	
	virtual term_t eval_term(SMTClkType clk) = 0;
	bool is_term_eval_needed;
};


//----------------------------SMT Unspecified-----------------------------------
class SMTUnspecified: public SMTExpr{
public:
	SMTUnspecified();
	void redraw(SMTClkType clk_type) override;
	term_t eval_term(SMTClkType clk) override;
};


//----------------------------SMT Assign----------------------------------------
class SMTAssign: public SMTCommons{
protected:
    const SMTClkType clk_type;
	bool covered_any_clock;
    uint covered_in_sim;
	
	SMTAssign(SMTClkType clk_type, SMTAssignType assign_type, uint id);
    virtual void redraw(SMTClkType clk_type) override = 0;
    virtual std::string pad_and_update(bool is_commit);
    
public:
    const SMTAssignType assign_type;
    const uint id;
	SMTExpr* lval;
	SMTExpr* rval;
    bool is_commit;
	term_t yices_term;
	SMTBasicBlock* block;
	
    virtual void instrument() = 0;
    virtual std::string print_cnst();
	virtual term_t update_term();
	
	bool is_covered();
	void set_covered(uint sim_num);
    void partial_assign_check();
    SMTSigCore* get_lval_sig_core();
};


//--------------------------SMT Cont Assign-------------------------------------
class SMTContAssign: public SMTAssign{
private:
	static std::vector<SMTContAssign*> assign_map;
    static std::string *print_map;
    static bool print_map_init;
	void redraw(SMTClkType clk_type) override;
    
public:
	SMTContAssign();
	void instrument() override;
	
	static void print_all(std::vector<constraint_t*> &cnst_stack, uint clock);
	static SMTContAssign* get_assign(uint id);
    static void free_print_map();
};


//--------------------------SMT Disp Assign-------------------------------------
class SMTDispAssign: public SMTAssign{
private:
	static std::vector<SMTDispAssign*> assign_map;
	
protected:
    virtual void redraw(SMTClkType clk_type) override = 0;
    
public:
	SMTDispAssign(SMTClkType clk_type, SMTAssignType assign_type);
	static SMTDispAssign* get_assign(uint id);
	static uint get_assign_count();
    virtual void instrument() override;
	static void print_coverage(std::ofstream &report);
};


//------------------------SMT Blocking Assign-----------------------------------
class SMTBlockingAssign: public SMTDispAssign{
private:
    void redraw(SMTClkType clk_type) override;
    
public:
	SMTBlockingAssign();
};


//----------------------SMT Non Blocking Assign---------------------------------
class SMTNonBlockingAssign: public SMTDispAssign{
private:
    void redraw(SMTClkType clk_type) override;
    
public:
	SMTNonBlockingAssign();
};


//-----------------------------SMT Branch---------------------------------------
class SMTBranch: public SMTDispAssign{
private:
	static std::vector<SMTBranch*> all_branches_list;
	bool* coverage;			//coverage at index clock
	
	SMTBranch(SMTBranchNode* parent_node, SMTBranchType type);
	static SMTBranch* _create_condit_branch(SMTBranchNode* parent, const char* num_expr);
    void redraw(SMTClkType clk_type) override;
	//bool check_is_dep_expr(SMTExpr* expr);
	bool saved_coverage;
    static uint saved_total_branch;
	static uint saved_covered_branch;
	
public:
	static uint total_branch_count;
	static uint covered_branch_count;
	const SMTBranchType type;
    const uint list_idx;    //index in parent's branch list
	SMTBranchNode*  parent_node;
    std::set<SMTBranch*> prev_branches;
	uint k_permit_covered;
	uint last_selected_clock;
	bool is_dep;
	//SMTBasicBlock* block;
	
	virtual ~SMTBranch();
	
	bool is_covered_clk(uint clock);
	void set_covered_clk(uint sim_num, uint clock);
    void clear_covered_clk(uint clock);
	void clear_flag();
	
	void instrument() override;
	static SMTBranch* create_true_branch(SMTBranchNode* parent);
	static SMTBranch* create_false_branch(SMTBranchNode* parent);
	static SMTBranch* create_case_branch(SMTBranchNode* parent, SMTExpr* case_expr);
	static SMTBranch* create_default_branch(SMTBranchNode* parent);
	static void clear_last_selected_clocks();
	static void clear_k_permit();
    static void clear_coverage(uint min_clock);
	static void save_coverage();
	static void restore_coverage();
	static void update_is_dep();
	term_t update_term() override;
	static void update_fsm();
};


//-------------------------SMT Branch Node--------------------------------------
class SMTBranchNode{
private:
	uint curr_check_idx;
	
public:
    SMTBranchNode();
    std::vector<SMTBranch*> branch_list;
    SMTExpr* cond;
    uint cond_width;
    constraint_t* mult_last_node;
    uint mult_last_id = 0xFFFFFFFF;
    
	void clear_flag();
};


//----------------------------SMT Concat----------------------------------------
class SMTConcat : public SMTExpr{
public:
	uint repeat;
	SMTConcat();
	void redraw(SMTClkType clk_type) override;
	term_t eval_term(SMTClkType clk) override;
};

//-----------------------------SMT Cust-----------------------------------------
class SMTCust : public SMTExpr{
private:
    std::string operand;
    
public:
    SMTCust(std::string operand);
    void redraw(SMTClkType clk_type) override;
	term_t eval_term(SMTClkType clk) override;
};



//----------------------------SMT Unary----------------------------------------
class SMTUnary : public SMTExpr{
private:
    std::string opcode;
	term_t (*func)(term_t inp);
	
public:
	SMTUnary();
    //SMTUnary(SMTUnaryOpcode opcode);
    
    void set_opcode(const ivl_expr_t expr);
	void set_opcode(char ivl_code);
    //void set_opcode(SMTUnaryOpcode opcode);
	void redraw(SMTClkType clk_type) override;
	term_t eval_term(SMTClkType clk) override;
};


//----------------------------SMT Binary----------------------------------------
class SMTBinary : public SMTExpr{
private:
	std::string opcode;
	term_t (*func)(term_t in1, term_t in2);
	
public:
	bool is_signed;
	SMTBinary();
	void redraw(SMTClkType clk_type) override;
	void set_opcode_from_expr(const ivl_expr_t expr);
	void set_opcode(char ivl_code);
	term_t eval_term(SMTClkType clk) override;
};


//----------------------------SMT Logic-----------------------------------------
class SMTLogic : public SMTExpr{
private:
	char opcode;
    std::string get_opcode();
	term_t (*func)(term_t in1, term_t in2);
	
public:
	SMTLogic();
	void redraw(SMTClkType clk_type) override;
	void set_opcode(char ivl_code, bool is_inverted);
	term_t eval_term(SMTClkType clk) override;
};


//----------------------------SMT Ternary----------------------------------------
class SMTTernary : public SMTExpr{	
public:
	SMTTernary();
	void redraw(SMTClkType clk_type) override;
	term_t eval_term(SMTClkType clk) override;
};


//----------------------------SMT Number----------------------------------------
extern const char hex_map[16];
class SMTNumber: public SMTExpr{
private:
	std::string value;
	bool is_signed;
	
public:
	bool has_undef;
	uint width;
	
	SMTNumber(const char* bits, int bit_width, bool is_signed);
	void redraw(SMTClkType clk_type);
	void emit_verilog_value();
	term_t eval_term(SMTClkType clk) override;
	bool is_equal(SMTNumber* num);
};


//---------------------------SMT Signal Core------------------------------------
typedef std::map<ivl_signal_t, SMTSigCore*> core_map_t;
typedef enum{
    SMT_SIG_REG,
    SMT_SIG_WIRE
}SMTSigType;

class SMTSigCore {
private:
    static core_map_t regDir;
    static core_map_t wireDir;
    char *zeros;
    std::vector<uint> version_stack;
    std::vector<std::string> states;
	std::vector<uint> version_at_clock;
	std::vector<uint> term_stack;
	bool was_in_queue;
	type_t bv_type;
	term_t init_term;
	void free_connected();
    
public:
	uint curr_version;
    uint next_version;
    uint last_defined_version;
    std::string name;
    int width;
    SMTSigType type;
    uint temp_state;
    bool is_dep;
	bool is_state_variable;
	//bool is_signed;
	
	std::vector<SMTAssign*> assignments;
	std::set<SMTSigCore*> assigned_to;
    std::vector<SMTProcess*> dependent_process;
	cnst_list_t* connected_cnst_at_ver;
	static std::vector<SMTSigCore*> state_variables;
    static std::vector<SMTSigCore*> input_port_list;
	
	
    SMTSigCore(ivl_signal_t sig);
    virtual ~SMTSigCore();
    
    void commit();
    void revert();
    void print_define(std::ofstream &strm, uint clock);
    void update_next_version();     //increments and prints next version define
	term_t get_term(SMTClkType clk);
    
    static void free_all();
    static void print_all_defines(std::ofstream &strm, uint clock);
    static SMTSigCore* get_parent(ivl_signal_t sig);
    static void clear_all_versions();
    static void commit_versions();
    static void revert_versions();
	static void print_reg_init(std::ofstream &out);
    static void print_reg_monitor();
    static void commit_states();
    static void print_states(std::ofstream &out, uint clock);
	static void debug_print_state();
	static void clear_states();
	static void update_is_dep();
	static void yices_insert_reg_init(context_t * ctx);
	static void free_connected_cnst();
	static void print_state_variables();
    static void set_input_version(uint version);
};


//----------------------------SMT Signal----------------------------------------
void add_to_rval(std::set<SMTSigCore*>& assign_set, SMTExpr* expr);
class SMTSignal: public SMTExpr{
public:
    SMTSigCore* parent;
	int lsb;
	int msb;
	
    SMTSignal();	
    SMTSignal(ivl_signal_t sig);
    
	void redraw(SMTClkType clk_type) override;
	term_t eval_term(SMTClkType clk) override;
};


//----------------------------SMT Process---------------------------------------
class SMTProcess{
public:
    SMTProcess();
	//SMTProcess(SMTProcess &obj);
    virtual ~SMTProcess();
    
    bool is_edge_triggered;
    std::set<SMTSigCore*> sensitivity_list;
    std::set<SMTSigCore*> sig_assign_list;
    std::set<SMTBasicBlock*> sig_assign_blocks;
    
    SMTBasicBlock* entry_block;
    SMTBasicBlock* exit_block;
    SMTBasicBlock* top_bb;
	static SMTProcess* curr_proc;
    void add_assign(SMTAssign* assign);
    void print();
    void expand();
    static void combine_processes();
    void update_distances(SMTBranch* target_br);
	
private:
    bool is_expanded;
    bool expanding_now;
    static std::vector<SMTProcess*> process_list;
    static SMTProcess g_comb_process;
};


//--------------------------SMT Basic Block-------------------------------------
class SMTBasicBlock{
public:
	SMTBasicBlock();
    const uint id;
    std::vector<SMTAssign*> assign_list;
    std::set<SMTBasicBlock*> successors;
    std::set<SMTBasicBlock*> predecessors;
	uint weight;
	uint distance;
    
    void print();
    static void print_all();
	static void reset_distances();
	
private:
    void print_assigns();
    static uint id_counter;
    static std::vector<SMTBasicBlock*> block_list;
};
