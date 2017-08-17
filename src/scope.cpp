#include <cinttypes>
#include <cstring>
#include <vector>
#include "concolic.h"
#include <cstdlib>

using namespace std;

static void emit_sig_id(ivl_signal_t sig) {
	emit_id(ivl_signal_basename(sig));
	fprintf(g_out, " = %u\'b0;\n", ivl_signal_width(sig));
}

static void emit_var_def(ivl_signal_t sig) {
	if (ivl_signal_local(sig)) return;
    new SMTSigCore(sig);
	fprintf(g_out, "%*c", g_ind, ' ');
	int msb, lsb;
	get_sig_msb_lsb(sig, &msb, &lsb);
	fprintf(g_out, "reg ");
	if(ivl_signal_signed(sig)){
		fprintf(g_out, "signed ");
	}
	if (msb != 0 || lsb != 0) fprintf(g_out, "[%d:%d] ", msb, lsb);
	emit_id(ivl_signal_basename(sig));
	if (ivl_signal_dimensions(sig) > 0) {
		unsigned wd_count = ivl_signal_array_count(sig);
		int first = ivl_signal_array_base(sig);
		int last = first + wd_count - 1;
		if (ivl_signal_array_addr_swapped(sig)) {
			fprintf(g_out, " [%d:%d]", last, first);
		} else {
			fprintf(g_out, " [%d:%d]", first, last);
		}
	}
	fprintf(g_out, " = %u\'b0;\n", ivl_signal_width(sig));
}

/*
 * Keep a list of constants that drive nets and need to be emitted as
 * a continuous assignment.
 */
static vector<ivl_signal_t> net_const_list;

static void add_net_const_to_list(ivl_signal_t net_const) {
	net_const_list.push_back(net_const);
}

static unsigned emit_and_free_net_const_list(ivl_scope_t scope) {
	const uint count = net_const_list.size();
	for (uint idx = 0; idx < count; idx++) {
		emit_signal_net_const_as_ca(scope, net_const_list[idx]);
	}
	net_const_list.clear();
	return count;
}

static void save_net_constants(ivl_scope_t scope, ivl_signal_t sig) {
	ivl_nexus_t nex = ivl_signal_nex(sig, 0);
	unsigned idx, count = ivl_nexus_ptrs(nex);
	for (idx = 0; idx < count; idx += 1) {
		ivl_nexus_ptr_t nex_ptr = ivl_nexus_ptr(nex, idx);
		ivl_net_const_t net_const = ivl_nexus_ptr_con(nex_ptr);
		if (!net_const) continue;
		if (scope != ivl_const_scope(net_const)) continue;
		add_net_const_to_list(sig);
	}
}

static void emit_net_def(ivl_scope_t scope, ivl_signal_t sig) {
	int msb, lsb;
	get_sig_msb_lsb(sig, &msb, &lsb);
	if (ivl_signal_local(sig)) return;
    new SMTSigCore(sig);
	fprintf(g_out, "%*c", g_ind, ' ');
	switch (ivl_signal_type(sig)) {
		case IVL_SIT_TRI:
		case IVL_SIT_UWIRE:
			// HERE: Need to add support for supply nets. Probably supply strength
			//       with a constant 0/1 driver for all the bits.
			fprintf(g_out, "reg ");
			break;
		default:
			fprintf(g_out, "<unknown> ");
			fprintf(stderr, "%s:%u: vlog95 error: Unknown net type "
					"(%d).\n", ivl_signal_file(sig),
					ivl_signal_lineno(sig), (int) ivl_signal_type(sig));
			g_errors += 1;
			break;
	}
	if(ivl_signal_signed(sig)){
		fprintf(g_out, "signed ");
	}
	if (msb != 0 || lsb != 0) fprintf(g_out, "[%d:%d] ", msb, lsb);
	emit_sig_id(sig);
	/* A constant driving a net does not create an lpm or logic
	 * element in the design so save them from the definition. */
	save_net_constants(scope, sig);
}

/*
 * This function is called for each process in the design so that we
 * can extract the processes for the given scope.
 */
static int find_process(ivl_process_t proc, void* scope) {
	if (scope == ivl_process_scope(proc)) {
		emit_process((ivl_scope_t)scope, proc);
	}
	return 0;
}

void emit_scope_variables(ivl_scope_t scope) {
	// Output the signals for this scope.
	const uint count = ivl_scope_sigs(scope);
	for (uint idx = 0; idx < count; idx += 1) {
		ivl_signal_t sig = ivl_scope_sig(scope, idx);
		if (ivl_signal_type(sig) == IVL_SIT_REG) {
			emit_var_def(sig);
		} 
        else if (ivl_signal_port(sig) != IVL_SIP_INPUT){
			emit_net_def(scope, sig);
		}
        else if(ivl_signal_port(sig) == IVL_SIP_INPUT){
            SMTSigCore* sig_core = new SMTSigCore(sig);
            g_in_port_list.push_back(sig_core);
        }
	}
	if (count) fprintf(g_out, "\n");
	if (emit_and_free_net_const_list(scope)){
		fprintf(g_out, "\n");
	}
}

static void emit_scope_file_line(ivl_scope_t scope) {
	fprintf(g_out, "// Following code segment is generated from %s:%u\n",
			ivl_scope_file(scope), ivl_scope_lineno(scope));
}

static void emit_top_module_ports(ivl_scope_t module) {
	uint count = ivl_scope_mod_module_ports(module);
	if (count == 0) return;
	fprintf(g_out, "(%s", ivl_scope_mod_module_port_name(module, 0));
	for (uint i = 1; i < count; i++) {
		fprintf(g_out, ", %s", ivl_scope_mod_module_port_name(module, i));
	}
	if(enable_obs_padding){
		fprintf(g_out, ", __obs");
	}
	fprintf(g_out, ");\n");
}

static ivl_signal_t get_port_from_nexus(ivl_scope_t scope, ivl_nexus_t nex,
		unsigned *word) {
	assert(nex);
	unsigned idx, count = ivl_nexus_ptrs(nex);
	ivl_signal_t sig = 0;
	*word = 0;
	for (idx = 0; idx < count; idx += 1) {
		ivl_nexus_ptr_t nex_ptr = ivl_nexus_ptr(nex, idx);
		ivl_signal_t t_sig = ivl_nexus_ptr_sig(nex_ptr);
		if (t_sig) {
			if (ivl_signal_scope(t_sig) != scope) continue;
			assert(!sig);
			sig = t_sig;
			*word = ivl_nexus_ptr_pin(nex_ptr);
		}
	}
	return sig;
}

static void emit_sig_type(ivl_signal_t sig) {
	ivl_signal_type_t type = ivl_signal_type(sig);
	if (ivl_signal_dimensions(sig) != 0) {
		fprintf(stderr, "%s:%u: vlog95 error: Array ports (%s) are not "
				"supported.\n",
				ivl_signal_file(sig),
				ivl_signal_lineno(sig),
				ivl_signal_basename(sig));
		g_errors += 1;
	}
	/* Check to see if we have a variable (reg) or a net. */
	if (type == IVL_SIT_REG) {
		/* The variable data type will be declared later, so here
	   we just want to declare the range and whether or not it
	   is signed. */
		if (ivl_signal_integer(sig)) {
			/* nothing to do */
		} else if (ivl_signal_data_type(sig) == IVL_VT_REAL) {
			/* nothing to do */
		} else {
			int msb, lsb;
			get_sig_msb_lsb(sig, &msb, &lsb);
			if (ivl_signal_signed(sig)) {
				fprintf(g_out, " signed");
			}
			if (msb != 0 || lsb != 0) {
				fprintf(g_out, " [%d:%d]", msb, lsb);
			}
		}
	} else {
		assert((type == IVL_SIT_TRI) ||
				(type == IVL_SIT_TRI0) ||
				(type == IVL_SIT_TRI1) ||
				(type == IVL_SIT_UWIRE));
		if (ivl_signal_data_type(sig) == IVL_VT_REAL) {
			fprintf(stderr, "%s:%u: vlog95 error: Real net ports (%s) "
					"are not supported.\n",
					ivl_signal_file(sig),
					ivl_signal_lineno(sig),
					ivl_signal_basename(sig));
			g_errors += 1;
		} else {
			int msb, lsb;
			get_sig_msb_lsb(sig, &msb, &lsb);
			if (ivl_signal_signed(sig)) {
				fprintf(g_out, " signed");
			}
			if (msb != 0 || lsb != 0) {
				fprintf(g_out, " [%d:%d]", msb, lsb);
			}
		}
	}
}

static void emit_port(ivl_signal_t port) {
	assert(port);
	fprintf(g_out, "%*c", g_ind, ' ');

	switch (ivl_signal_port(port)) {
		case IVL_SIP_INPUT:
			fprintf(g_out, "input");
			break;
		case IVL_SIP_OUTPUT:
			fprintf(g_out, "output");
			break;
		case IVL_SIP_INOUT:
			fprintf(g_out, "inout");
			break;
		default:
			fprintf(g_out, "<unknown>");
			fprintf(stderr, "%s:%u: vlog95 error: Unknown port direction (%d) "
					"for signal %s.\n", ivl_signal_file(port),
					ivl_signal_lineno(port), (int) ivl_signal_port(port),
					ivl_signal_basename(port));
			g_errors += 1;
			break;
	}
	emit_sig_type(port);
	fprintf(g_out, " ");
	/* Split port (arg[7:4],arg[3:0]) are generated using local signals. */
	if (ivl_signal_local(port)) {
		fprintf(g_out, "ivlog%s", ivl_signal_basename(port));
	} else {
		emit_id(ivl_signal_basename(port));
	}
	fprintf(g_out, ";\n");
}

static void emit_module_port_defs(ivl_scope_t scope) {
	unsigned word, idx, count = ivl_scope_ports(scope);
	for (idx = 0; idx < count; idx += 1) {
		ivl_nexus_t nex = ivl_scope_mod_port(scope, idx);
		ivl_signal_t port = get_port_from_nexus(scope, nex, &word);
		// HERE: Do we need to use word?
		if (port) emit_port(port);
		else {
			error("Port not found");
		}
	}
	if(enable_obs_padding){
		fprintf(g_out, "%*cinput __obs;\n", g_ind, ' ');
	}
	if (count) fprintf(g_out, "\n");
}

/*
 * Recursively look for the named block in the given statement.
 */
static int has_named_block(ivl_scope_t scope, ivl_statement_t stmt) {
	unsigned idx, count;
	int rtn = 0;
	if (!stmt) return 0;
	switch (ivl_statement_type(stmt)) {
			/* Block or fork items can contain a named block. */
		case IVL_ST_BLOCK:
		case IVL_ST_FORK:
		case IVL_ST_FORK_JOIN_ANY:
		case IVL_ST_FORK_JOIN_NONE:
			if (ivl_stmt_block_scope(stmt) == scope) return 1;
			count = ivl_stmt_block_count(stmt);
			for (idx = 0; (idx < count) && !rtn; idx += 1) {
				rtn |= has_named_block(scope,
						ivl_stmt_block_stmt(stmt, idx));
			}
			break;
			/* Case items can contain a named block. */
		case IVL_ST_CASE:
		case IVL_ST_CASER:
		case IVL_ST_CASEX:
		case IVL_ST_CASEZ:
			count = ivl_stmt_case_count(stmt);
			for (idx = 0; (idx < count) && !rtn; idx += 1) {
				rtn |= has_named_block(scope,
						ivl_stmt_case_stmt(stmt, idx));
			}
			break;
			/* Either the true or false clause may have a named block. */
		case IVL_ST_CONDIT:
			rtn = has_named_block(scope, ivl_stmt_cond_true(stmt));
			if (!rtn) {
				rtn = has_named_block(scope, ivl_stmt_cond_false(stmt));
			}
			break;
			/* The looping statements may have a named block. */
		case IVL_ST_DO_WHILE:
		case IVL_ST_FOREVER:
		case IVL_ST_REPEAT:
		case IVL_ST_WHILE:
			/* The delay and wait statements may have a named block. */
		case IVL_ST_DELAY:
		case IVL_ST_DELAYX:
		case IVL_ST_WAIT:
			rtn = has_named_block(scope, ivl_stmt_sub_stmt(stmt));
			break;
		default: /* The rest cannot have a named block. */;
	}
	return rtn;
}

/*
 * Look for a disable in the statement (function body) for this scope.
 */
static unsigned has_func_disable(ivl_scope_t scope, ivl_statement_t stmt) {
	unsigned idx, count, rtn = 0;
	/* If there is a statement then look to see if it is or has a
	 * disable for this function scope. */
	if (!stmt) return 0;
	assert(ivl_scope_type(scope) == IVL_SCT_FUNCTION);
	switch (ivl_statement_type(stmt)) {
			/* These are not allowed in a function. */
		case IVL_ST_ASSIGN_NB:
		case IVL_ST_DELAY:
		case IVL_ST_DELAYX:
		case IVL_ST_FORK:
		case IVL_ST_FORK_JOIN_ANY:
		case IVL_ST_FORK_JOIN_NONE:
		case IVL_ST_UTASK:
		case IVL_ST_WAIT:
			assert(0);
			break;
			/* These are allowed in a function and cannot have a disable. */
		case IVL_ST_NOOP:
		case IVL_ST_ALLOC:
		case IVL_ST_ASSIGN:
		case IVL_ST_CASSIGN:
		case IVL_ST_DEASSIGN:
		case IVL_ST_FORCE:
		case IVL_ST_FREE:
		case IVL_ST_RELEASE:
		case IVL_ST_STASK:
		case IVL_ST_TRIGGER:
			break;
			/* Look for a disable in each block statement. */
		case IVL_ST_BLOCK:
			count = ivl_stmt_block_count(stmt);
			for (idx = 0; (idx < count) && !rtn; idx += 1) {
				rtn |= has_func_disable(scope,
						ivl_stmt_block_stmt(stmt, idx));
			}
			break;
			/* Look for a disable in each case branch. */
		case IVL_ST_CASE:
		case IVL_ST_CASER:
		case IVL_ST_CASEX:
		case IVL_ST_CASEZ:
			count = ivl_stmt_case_count(stmt);
			for (idx = 0; (idx < count) && !rtn; idx += 1) {
				rtn |= has_func_disable(scope,
						ivl_stmt_case_stmt(stmt, idx));
			}
			break;
			/* Either the true or false clause may have a disable. */
		case IVL_ST_CONDIT:
			rtn = has_func_disable(scope, ivl_stmt_cond_true(stmt));
			if (!rtn) {
				rtn = has_func_disable(scope, ivl_stmt_cond_false(stmt));
			}
			break;
			/* These have a single sub-statement so look for a disable there. */
		case IVL_ST_DO_WHILE:
		case IVL_ST_FOREVER:
		case IVL_ST_REPEAT:
		case IVL_ST_WHILE:
			rtn = has_func_disable(scope, ivl_stmt_sub_stmt(stmt));
			break;
			/* The function has a disable if the disable scope matches the
			 * function scope. */
		case IVL_ST_DISABLE:
			rtn = scope == ivl_stmt_call(stmt);
			break;
		default:
			fprintf(stderr, "%s:%u: vlog95 error: Unknown statement type (%d) "
					"in function disable check.\n",
					ivl_stmt_file(stmt),
					ivl_stmt_lineno(stmt),
					(int) ivl_statement_type(stmt));

			g_errors += 1;
			break;
	}
	return rtn;
}

/*
 * This search method may be slow for a large structural design with a
 * large number of gate types. That's not what this converter was built
 * for so this is probably OK. If this becomes an issue then we need a
 * better method/data structure.
 */
static vector<const char*> scopes_emitted_list;

static void check_scope_unsupported(ivl_scope_t scope) {
	//check for unsupported features
	if (ivl_scope_type(scope) != IVL_SCT_MODULE) {
		error("Unsupported scope type");
	}		//else if(ivl_scope_lpms(scope)){
		//	error("LPM not supported");
		//} 
		//else if(ivl_scope_logs(scope)){
		//	error("Logic device not supported");
		//} 
	else if (ivl_scope_switches(scope)) {
		error("Switches not supported");
	}
}

/*static int emit_child_module(ivl_scope_t module, void* parent) {
	check_scope_unsupported(module);
	
	//emit variables
	emit_scope_variables(module);

	uint count = ivl_scope_lpms(module);
	for (uint idx = 0; idx < count; idx += 1) {
		emit_lpm(module, ivl_scope_lpm(module, idx));
	}

	count = ivl_scope_logs(module);
	for (uint idx = 0; idx < count; idx += 1) {
		emit_logic(module, ivl_scope_log(module, idx));
	}
	
	count = ivl_scope_switches(module);
	for (uint idx = 0; idx < count; idx += 1) {
		emit_tran(module, ivl_scope_switch(module, idx));
	}
	
	//output design process
	ivl_design_process(g_design, find_process, module);
	
	return 0;
}*/

// Emit root module
void emit_root(ivl_scope_t root) {
	check_scope_unsupported(root);

	// Output module declaration
	emit_scope_file_line(root);
	fprintf(g_out, "module %s", ivl_scope_basename(root));
	emit_top_module_ports(root);

	// Output module port definitions
	g_ind = g_ind_incr;
	emit_module_port_defs(root);
	emit_scope_variables(root);

	uint count = ivl_scope_lpms(root);
	for (uint idx = 0; idx < count; idx += 1) {
		emit_lpm(root, ivl_scope_lpm(root, idx));
	}

	count = ivl_scope_logs(root);
	for (uint idx = 0; idx < count; idx += 1) {
		emit_logic(root, ivl_scope_log(root, idx));
	}

	count = ivl_scope_switches(root);
	for (uint idx = 0; idx < count; idx += 1) {
		error("check: emit_tran");
	}

	/* Output the initial/always blocks for this module. */
	ivl_design_process(g_design, (ivl_process_f) find_process, root);

    if(enable_concrete_states){
        SMTSigCore::print_reg_monitor();
    }
	
	//check if hierarchy is flattened 
	assert(ivl_scope_childs(root) == 0);
	//ivl_scope_children(root, emit_child_module, root);

	fprintf(g_out, "endmodule\n\n");
}

