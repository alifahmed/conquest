#pragma once

#include "ivl_target.h"
#include <yices.h>
#include <yices_limits.h>
#include <yices_types.h>
#include "smt_lib.h"
#include <cstdio>
#include <cassert>
#include <sstream>
#include <vector>
#include <map>
#include <unordered_map>
#include <fstream>
#include "globals.h"

typedef unsigned uint;


//Configuration declarations
//#define conc_flush(X)   fflush(X)
#define conc_flush(X) 
extern const bool		enable_error_check;
extern const bool		enable_obs_padding;
extern const bool		enable_sim_copy;
extern const bool       enable_concrete_states;
extern const uint		k_permit_effort;
extern const bool		enable_yices_api;
extern const bool		enable_yices_debug;
extern const bool		enable_yices_incremental;
extern const bool		enable_ud_chain;
//extern const uint		target_branch_id;


class SMTSignal;
class SMTExpr;
class SMTSigCore;
class SMTAssign;
struct constraint_t;

extern uint single_indent;
extern std::vector<SMTExpr*> g_expr_list;
extern std::unordered_map<std::string, SMTSigCore*> g_name_sig_map;
extern std::vector<SMTSigCore*> g_in_port_list;
extern std::ofstream g_define_out;
extern FILE* f_dbg;
extern constraint_t* last_cnst;

/*
 * Emit various Verilog types.
 */
class SMTExpr;
class SMTSignal;
class SMTNumber;

extern void emit_event(ivl_scope_t scope, ivl_statement_t stmt);
extern SMTExpr* emit_expr(ivl_scope_t scope, ivl_expr_t expr, unsigned width,
		unsigned is_lval_width, unsigned can_skip_unsigned,
		unsigned is_full_prec);
extern void emit_logic(ivl_scope_t scope, ivl_net_logic_t nlogic);
extern void emit_lpm(ivl_scope_t scope, ivl_lpm_t lpm);
extern void emit_process(ivl_scope_t scope, ivl_process_t proc);
extern int emit_scope(ivl_scope_t scope, ivl_scope_t parent);
void emit_stmt(ivl_scope_t scope, ivl_statement_t stmt);
extern void emit_tran(ivl_scope_t scope, ivl_switch_t tran);

extern void emit_scaled_delay(ivl_scope_t scope, uint64_t delay);
extern void emit_scaled_delayx(ivl_scope_t scope, ivl_expr_t expr,
		unsigned is_stmt);
extern void emit_scaled_expr(ivl_scope_t scope, ivl_expr_t expr,
		int msb, int lsb, SMTSignal* smt_sig);
extern void emit_scaled_range(ivl_scope_t scope, ivl_expr_t expr,
		unsigned width, int msb, int lsb, SMTSignal* smt_sig);
extern void emit_scope_path(ivl_scope_t scope, ivl_scope_t call_scope);
extern void emit_scope_variables(ivl_scope_t scope);
extern void emit_scope_call_path(ivl_scope_t scope, ivl_scope_t call_scope);
extern void emit_scope_module_path(ivl_scope_t scope, ivl_scope_t call_scope);
extern SMTExpr* emit_name_of_nexus(ivl_scope_t scope, ivl_nexus_t nex,
		unsigned allow_UD);
extern SMTExpr* emit_nexus_as_ca(ivl_scope_t scope, ivl_nexus_t nex, uint allow_UD, uint sign_extend);
extern void emit_nexus_port_driver_as_ca(ivl_scope_t scope, ivl_nexus_t nex);
extern SMTNumber* emit_const_nexus(ivl_scope_t scope, ivl_net_const_t const_net);
extern void emit_signal_net_const_as_ca(ivl_scope_t scope, ivl_signal_t sig);
extern void emit_icarus_generated_udps(void);

extern void add_udp_to_list(ivl_udp_t udp);
extern void emit_udp_list(void);
extern void emit_sig_file_line(ivl_signal_t sig);

extern void emit_id(const char *id);
extern void emit_real_number(double value);
extern SMTNumber* emit_number(const char *bits, unsigned nbits, bool is_signed);
extern void emit_string(const char *string);
extern void SMTFreeAll();
extern uint get_indent(void);
extern void end_concolic();
extern void create_context(std::vector<uint> &cntx);

/*
 * Find the enclosing module scope.
 */
extern ivl_scope_t get_module_scope(ivl_scope_t scope);

/*
 * Get an int32_t/uint64_t from a number is possible. The return type is
 * 0 for a valid value, negative for a number with undefined bits and
 * positive it the value is too large. The positive value is the minimum
 * number of bits required to represent the value.
 */
extern int32_t get_int32_from_number(ivl_expr_t expr, int *return_type);
extern int64_t get_int64_from_number(ivl_expr_t expr, int *return_type);
extern uint64_t get_uint64_from_number(ivl_expr_t expr, int *return_type);

/*
 * A package is translated to a module with a special name. This routine
 * does that translation. To avoid a memory leak the calling routine must
 * use free() to cleanup the string returned.
 */
extern char * get_package_name(ivl_scope_t scope);

/*
 * Get the appropriate MSB and LSB for a signal.
 */
extern void get_sig_msb_lsb(ivl_signal_t sig, int *msb, int *lsb);

/*
 * Cleanup functions.
 */
extern void free_emitted_scope_list(void);

//emit_root
void emit_root(ivl_scope_t module);
extern void start_concolic();
extern char* smt_zeros(uint width);

extern context_t *yices_context;
extern void smt_yices_assert(context_t *ctx,  term_t term, SMTAssign* assign);
extern void smt_yices_push();
extern void smt_yices_pop();

/*
 * Debug routine to dump the various pieces of nexus information.
 */
//extern void dump_nexus_information(ivl_scope_t scope, ivl_nexus_t nex);


//Utility functions 
extern void error(const char *fmt, ...);
extern void info(const char *fmt, ...);
extern bool is_file_exists(const char* file);
extern void copy_file(const char* src_file, const char* dest_file);
