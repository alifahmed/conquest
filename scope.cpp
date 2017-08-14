#include <cinttypes>
#include <cstring>
#include <vector>
#include "concolic.h"
#include <cstdlib>

using namespace std;
const char *func_rtn_name = 0;

static const char*get_time_const(int time_value) {
	switch (time_value) {
		case 2: return "100s";
		case 1: return "10s";
		case 0: return "1s";
		case -1: return "100ms";
		case -2: return "10ms";
		case -3: return "1ms";
		case -4: return "100us";
		case -5: return "10us";
		case -6: return "1us";
		case -7: return "100ns";
		case -8: return "10ns";
		case -9: return "1ns";
		case -10: return "100ps";
		case -11: return "10ps";
		case -12: return "1ps";
		case -13: return "100fs";
		case -14: return "10fs";
		case -15: return "1fs";
		default:
			fprintf(stderr, "Invalid time constant value %d.\n", time_value);
			return "N/A";
	}
}

/*static void emit_func_return(ivl_signal_t sig) {
	if (ivl_signal_dimensions(sig) > 0) {
		fprintf(stderr, "%s:%u: vlog95 error: A function cannot return "
				"an array.\n", ivl_signal_file(sig),
				ivl_signal_lineno(sig));
		g_errors += 1;
	} else if (ivl_signal_integer(sig)) {
		fprintf(g_out, " integer");
	} else if (ivl_signal_data_type(sig) == IVL_VT_REAL) {
		fprintf(g_out, " real");
	} else {
		int msb, lsb;
		get_sig_msb_lsb(sig, &msb, &lsb);
		if (msb != 0 || lsb != 0) fprintf(g_out, " [%d:%d]", msb, lsb);
	}
}*/

void emit_sig_file_line(ivl_signal_t sig) {
	if (g_emit_file_line) {
		fprintf(g_out, " /* %s:%u */",
				ivl_signal_file(sig),
				ivl_signal_lineno(sig));
	}
}

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

static void emit_mangled_name(ivl_scope_t scope, unsigned root) {
	/* If the module has parameters and it's not a root module then it
	 * may not be unique so we create a mangled name version instead.
	 * The mangled name is of the form:
	 *   <module_name>[<full_instance_scope>]. */
	if (ivl_scope_params(scope) && !root) {
		char *name;
		size_t len = strlen(ivl_scope_name(scope)) +
				strlen(ivl_scope_tname(scope)) + 3;
		name = (char *) malloc(len);
		(void) strcpy(name, ivl_scope_tname(scope));
		(void) strcat(name, "[");
		(void) strcat(name, ivl_scope_name(scope));
		(void) strcat(name, "]");
		assert(name[len - 1] == 0);
		/* Emit the mangled name as an escaped identifier. */
		fprintf(g_out, "\\%s ", name);
		free(name);
	} else {
		emit_id(ivl_scope_tname(scope));
	}
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

static void emit_module_ports(ivl_scope_t scope) {
	unsigned idx, count = ivl_scope_ports(scope);

	if (count == 0) return;

	fprintf(g_out, "(");
	emit_nexus_as_ca(scope, ivl_scope_mod_port(scope, 0), 0, 0);
	for (idx = 1; idx < count; idx += 1) {
		fprintf(g_out, ", ");
		emit_nexus_as_ca(scope, ivl_scope_mod_port(scope, idx), 0, 0);
	}
	fprintf(g_out, ")");
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
	fprintf(g_out, ";");
	emit_sig_file_line(port);
	fprintf(g_out, "\n");
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

static void emit_module_call_expr(ivl_scope_t scope, unsigned idx) {
	unsigned word;
	ivl_nexus_t nex = ivl_scope_mod_port(scope, idx);
	ivl_signal_t port = get_port_from_nexus(scope, nex, &word);
	/* For an input port we need to emit the driving expression. */
	if (ivl_signal_port(port) == IVL_SIP_INPUT) {
		emit_nexus_port_driver_as_ca(ivl_scope_parent(scope),
				ivl_signal_nex(port, word));
		/* For an output we need to emit the signal the output is driving. */
	} else {
		emit_nexus_as_ca(ivl_scope_parent(scope),
				ivl_signal_nex(port, word), 0, 0);
	}
}

static void emit_module_call_expressions(ivl_scope_t scope) {
	unsigned idx, count = ivl_scope_ports(scope);
	if (count == 0) return;
	emit_module_call_expr(scope, 0);
	for (idx = 1; idx < count; idx += 1) {
		fprintf(g_out, ", ");
		emit_module_call_expr(scope, idx);
	}
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
 * Look at all the processes to see if we can find one with the expected
 * scope. If we don't find one then we can assume the block only has
 * variable definitions and needs to be emitted here in the scope code.
 */
/*static int no_stmts_in_process(ivl_process_t proc, ivl_scope_t scope) {
	return has_named_block(scope, ivl_process_stmt(proc));
}*/

/*
 * In SystemVerilog a task or function can have a process to initialize
 * variables. In reality SystemVerilog requires this to be before the
 * initial/always blocks are processed, but that's not how it is currently
 * implemented in Icarus!
 */
static int find_tf_process(ivl_process_t proc, ivl_scope_t scope) {
	if (scope == ivl_process_scope(proc)) {
		ivl_scope_t mod_scope = scope;
		/* A task or function can only have initial processes that
		 * are used to set local variables. */
		assert(ivl_process_type(proc) == IVL_PR_INITIAL);
		/* Find the module scope for this task/function. */
		while (ivl_scope_type(mod_scope) != IVL_SCT_MODULE) {
			mod_scope = ivl_scope_parent(mod_scope);
			assert(mod_scope);
		}
		/* Emit the process in the module scope since that is where
		 * this all started. */
		emit_process(mod_scope, proc);
	}
	return 0;
}

/*
 * Emit any initial blocks for the tasks or functions in a module.
 */
static int emit_tf_process(ivl_scope_t scope, ivl_scope_t parent) {
	ivl_scope_type_t sc_type = ivl_scope_type(scope);
	(void) parent; /* Parameter is not used. */
	if ((sc_type == IVL_SCT_FUNCTION) || (sc_type == IVL_SCT_TASK)) {
		/* Output the initial/always blocks for this module. */
		ivl_design_process(g_design, (ivl_process_f) find_tf_process, scope);
	}
	return 0;
}

static void emit_path_delay(ivl_scope_t scope, ivl_delaypath_t dpath) {
	unsigned idx, count = 6;
	uint64_t pdlys [12];
	pdlys[0] = ivl_path_delay(dpath, IVL_PE_01);
	pdlys[1] = ivl_path_delay(dpath, IVL_PE_10);
	pdlys[2] = ivl_path_delay(dpath, IVL_PE_0z);
	pdlys[3] = ivl_path_delay(dpath, IVL_PE_z1);
	pdlys[4] = ivl_path_delay(dpath, IVL_PE_1z);
	pdlys[5] = ivl_path_delay(dpath, IVL_PE_z0);
	pdlys[6] = ivl_path_delay(dpath, IVL_PE_0x);
	pdlys[7] = ivl_path_delay(dpath, IVL_PE_x1);
	pdlys[8] = ivl_path_delay(dpath, IVL_PE_1x);
	pdlys[9] = ivl_path_delay(dpath, IVL_PE_x0);
	pdlys[10] = ivl_path_delay(dpath, IVL_PE_xz);
	pdlys[11] = ivl_path_delay(dpath, IVL_PE_zx);
	/* If the first six pdlys match then this may be a 1 delay form. */
	if ((pdlys[0] == pdlys[1]) &&
			(pdlys[0] == pdlys[2]) &&
			(pdlys[0] == pdlys[3]) &&
			(pdlys[0] == pdlys[4]) &&
			(pdlys[0] == pdlys[5])) count = 1;
		/* Check to see if only a rise and fall value are given for the first
		 * six pdlys. */
	else if ((pdlys[0] == pdlys[2]) &&
			(pdlys[0] == pdlys[3]) &&
			(pdlys[1] == pdlys[4]) &&
			(pdlys[1] == pdlys[5])) count = 2;
		/* Check to see if a rise, fall and high-Z value are given for the
		 * first six pdlys. */
	else if ((pdlys[0] == pdlys[3]) &&
			(pdlys[1] == pdlys[5]) &&
			(pdlys[2] == pdlys[4])) count = 3;
	/* Now check to see if the 'bx related pdlys match the reduced
	 * delay form. If not then this is a twelve delay value. */
	if ((pdlys[6] != ((pdlys[0] < pdlys[2]) ? pdlys[0] : pdlys[2])) ||
			(pdlys[8] != ((pdlys[1] < pdlys[4]) ? pdlys[1] : pdlys[4])) ||
			(pdlys[11] != ((pdlys[3] < pdlys[5]) ? pdlys[3] : pdlys[5])) ||
			(pdlys[7] != ((pdlys[0] > pdlys[3]) ? pdlys[0] : pdlys[3])) ||
			(pdlys[9] != ((pdlys[1] > pdlys[5]) ? pdlys[1] : pdlys[5])) ||
			(pdlys[10] != ((pdlys[2] > pdlys[4]) ? pdlys[2] : pdlys[4]))) {
		count = 12;
	}
	emit_scaled_delay(scope, pdlys[0]);
	for (idx = 1; idx < count; idx += 1) {
		fprintf(g_out, ", ");
		emit_scaled_delay(scope, pdlys[idx]);
	}
}

static void emit_specify_paths(ivl_scope_t scope, ivl_signal_t sig) {
	unsigned idx, count = ivl_signal_npath(sig);
	for (idx = 0; idx < count; idx += 1) {
		ivl_delaypath_t dpath = ivl_signal_path(sig, idx);
		ivl_nexus_t cond = ivl_path_condit(dpath);
		ivl_nexus_t source = ivl_path_source(dpath);
		unsigned has_edge = 0;
		fprintf(g_out, "%*c", g_ind, ' ');
		if (cond) {
			fprintf(g_out, "if (");
			emit_nexus_as_ca(scope, cond, 0, 0);
			fprintf(g_out, ") ");
		} else if (ivl_path_is_condit(dpath)) {
			fprintf(g_out, "ifnone ");
		}
		fprintf(g_out, "(");
		if (ivl_path_source_posedge(dpath)) {
			fprintf(g_out, "posedge ");
			has_edge = 1;
		}
		if (ivl_path_source_negedge(dpath)) {
			fprintf(g_out, "negedge ");
			has_edge = 1;
		}
		emit_nexus_as_ca(scope, source, 0, 0);
		fprintf(g_out, " =>");
		/* The compiler does not keep the source expression for an edge
		 * sensitive path so add a constant to get the syntax right. */
		if (has_edge) {
			fprintf(g_out, "(%s : 1'bx /* Missing */)",
					ivl_signal_basename(sig));
		} else {
			fprintf(g_out, "%s", ivl_signal_basename(sig));
		}
		fprintf(g_out, ") = (");
		emit_path_delay(scope, dpath);
		fprintf(g_out, ");\n");
	}
}

/*
 * The path delay information from the specify block is attached to the
 * output ports.
 */
static void emit_specify(ivl_scope_t scope) {
	unsigned word, idx, count = ivl_scope_ports(scope);
	unsigned need_specify = 0;
	for (idx = 0; idx < count; idx += 1) {
		ivl_nexus_t nex = ivl_scope_mod_port(scope, idx);
		ivl_signal_t port = get_port_from_nexus(scope, nex, &word);
		// HERE: Do we need to use word? See emit_module_port_def().
		assert(port);
		if (ivl_signal_npath(port)) {
			if (!need_specify) {
				fprintf(g_out, "\n%*cspecify\n", g_ind, ' ');
				need_specify = 1;
				g_ind += g_ind_incr;
			}
			emit_specify_paths(scope, port);
		}
	}
	if (need_specify) {
		g_ind -= g_ind_incr;
		fprintf(g_out, "%*cendspecify\n", g_ind, ' ');
	}
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
 * This is the block name used when a SystemVerilog return is used in a
 * function and the body does not already have an enclosing named block.
 * This is needed since the actual function cannot be disabled.
 */
/*static char *get_func_return_name(ivl_scope_t scope) {
	const char *name_func = ivl_scope_basename(scope);
	const char *name_head = "_ivl_";
	const char *name_tail = "_return";
	char *name_return;
	name_return = (char *) malloc(strlen(name_head) +
			strlen(name_func) +
			strlen(name_tail) + 1);
	name_return[0] = 0;
	(void) strcpy(name_return, name_head);
	(void) strcat(name_return, name_func);
	(void) strcat(name_return, name_tail);
	return name_return;
}*/

/*
 * This search method may be slow for a large structural design with a
 * large number of gate types. That's not what this converter was built
 * for so this is probably OK. If this becomes an issue then we need a
 * better method/data structure.
 */
static vector<const char*> scopes_emitted_list;

static unsigned scope_has_been_emitted(ivl_scope_t scope) {
	const uint count = scopes_emitted_list.size();
	for (uint idx = 0; idx < count; idx += 1) {
		if (!strcmp(ivl_scope_tname(scope), scopes_emitted_list[idx])){
			return 1;
		}
	}
	return 0;
}

static void add_scope_to_list(ivl_scope_t scope) {
	scopes_emitted_list.push_back(ivl_scope_tname(scope));
}

void free_emitted_scope_list() {
	scopes_emitted_list.clear();
}

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
		emit_tran(root, ivl_scope_switch(root, idx));
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

/*
 * A list of module scopes that need to have their definition emitted when
 * the current root scope (module) is finished is kept here.
 */
static vector<ivl_scope_t> scopes_pending_list;
static unsigned emitting_scopes = 0;

int emit_scope(ivl_scope_t scope, ivl_scope_t parent) {
	ivl_scope_type_t sc_type = ivl_scope_type(scope);

	/* Output the scope definition. */
	switch (sc_type) {
		case IVL_SCT_MODULE:
			/* This is an instantiation. */
			if (parent) {
				assert(g_ind != 0);
				/* If the module has parameters then it may not be unique
				 * so we create a mangled name version instead. */
				fprintf(g_out, "\n%*c", g_ind, ' ');
				emit_mangled_name(scope, !parent && !emitting_scopes);
				fprintf(g_out, " ");
				emit_id(ivl_scope_basename(scope));
				fprintf(g_out, "(");
				emit_module_call_expressions(scope);
				fprintf(g_out, ");");
				emit_scope_file_line(scope);
				fprintf(g_out, "\n");
				scopes_pending_list.push_back(scope);
				return 0;
			}
			assert(g_ind == 0);
			/* Set the time scale for this scope. */
			fprintf(g_out, "\n`timescale %s/%s\n",
					get_time_const(ivl_scope_time_units(scope)),
					get_time_const(ivl_scope_time_precision(scope)));
			if (ivl_scope_is_cell(scope)) {
				fprintf(g_out, "`celldefine\n");
			}
			fprintf(g_out, "/* This module was originally defined in "
					"file %s at line %u. */\n",
					ivl_scope_def_file(scope),
					ivl_scope_def_lineno(scope));
			fprintf(g_out, "module ");
			emit_mangled_name(scope, !parent && !emitting_scopes);
			emit_module_ports(scope);
			break;
		default:
			error("Unsupported scope type: %u (%s:%u)", sc_type, ivl_scope_file(scope), ivl_scope_lineno(scope));
	}
	fprintf(g_out, ";\n");
	g_ind += g_ind_incr;

	/* Output the scope ports for this scope. */
	emit_module_port_defs(scope);

	emit_scope_variables(scope);

	unsigned count = ivl_scope_lpms(scope);
	/* Output the LPM devices. */
	for (uint idx = 0; idx < count; idx += 1) {
		emit_lpm(scope, ivl_scope_lpm(scope, idx));
	}

	/* Output any logic devices. */
	count = ivl_scope_logs(scope);
	for (uint idx = 0; idx < count; idx += 1) {
		emit_logic(scope, ivl_scope_log(scope, idx));
	}

	/* Output any switch (logic) devices. */
	count = ivl_scope_switches(scope);
	for (uint idx = 0; idx < count; idx += 1) {
		emit_tran(scope, ivl_scope_switch(scope, idx));
	}

	/* Output any initial blocks for tasks or functions defined
	 * in this module. Used to initialize local variables. */
	ivl_scope_children(scope, (ivl_scope_f*) emit_tf_process, scope);

	/* Output the initial/always blocks for this module. */
	ivl_design_process(g_design, (ivl_process_f) find_process, scope);

	/* Print any sub-scopes. */
	ivl_scope_children(scope, (ivl_scope_f*) emit_scope, scope);

	/* And finally print a specify block when needed. */
	emit_specify(scope);

	/* Output the scope ending. */
	assert(g_ind >= g_ind_incr);
	g_ind -= g_ind_incr;

	assert(g_ind == 0);
	fprintf(g_out, "endmodule\n");
	if (ivl_scope_is_cell(scope)) {
		fprintf(g_out, "`endcelldefine\n");
	}
	/* If this is a root scope then emit any saved instance scopes.
	 * Save any scope that does not have parameters/a mangled name
	 * to a list so we don't print duplicate module definitions. */
	if (!emitting_scopes) {
		emitting_scopes = 1;
		const uint count = scopes_pending_list.size();
		for (uint idx = 0; idx < count; idx++) {
			ivl_scope_t scope_to_emit = scopes_pending_list[idx];
			if (scope_has_been_emitted(scope_to_emit)) continue;
			(void) emit_scope(scope_to_emit, 0);
			/* If we used a mangled name then the instance is
			 * unique so don't add it to the list. */
			if (ivl_scope_params(scope_to_emit)) continue;
			add_scope_to_list(scope_to_emit);
		}
		scopes_pending_list.clear();
		emitting_scopes = 0;
	}
	return 0;
}
