#include <stdlib.h>
#include <string.h>
#include "config.h"
#include "concolic.h"

void emit_event(ivl_scope_t scope, ivl_statement_t stmt) {
	unsigned eidx, nevents, first = 1;
	bool has_any_edge = false;
	nevents = ivl_stmt_nevent(stmt);
	for (eidx = 0; eidx < nevents; eidx += 1) {
		SMTSignal* smt_expr;
		unsigned idx, count, had_edge = 0;
		ivl_event_t event = ivl_stmt_events(stmt, eidx);

		/* Check for any edge events. */
		count = ivl_event_nany(event);
		if (count) had_edge = 1;
		for (idx = 0; idx < count; idx += 1) {
			if (first) first = 0;
			else fprintf(g_out, " or ");
			smt_expr = dynamic_cast<SMTSignal*>(emit_nexus_as_ca(scope, ivl_event_any(event, idx), 0, 0));
			assert(smt_expr);
			smt_expr->print(SMT_CLK_CURR);
			SMTProcess::curr_proc->sensitivity_list.insert(smt_expr->parent);
			SMTProcess::curr_proc->is_edge_triggered = false;
            smt_expr->parent->dependent_process.push_back(SMTProcess::curr_proc);
		}

		/* Check for positive edge events. */
		count = ivl_event_npos(event);
		if (count) {
			had_edge = 1;
			has_any_edge = true;
		}
		for (idx = 0; idx < count; idx += 1) {
			if (first) first = 0;
			else fprintf(g_out, " or ");
			fprintf(g_out, "posedge ");
			smt_expr = dynamic_cast<SMTSignal*>(emit_nexus_as_ca(scope, ivl_event_pos(event, idx), 0, 0));
			assert(smt_expr);
			smt_expr->print(SMT_CLK_CURR);
			SMTProcess::curr_proc->sensitivity_list.insert(smt_expr->parent);
			SMTProcess::curr_proc->is_edge_triggered = true;
            smt_expr->parent->dependent_process.push_back(SMTProcess::curr_proc);
		}

		/* Check for negative edge events. */
		count = ivl_event_nneg(event);
		if (count) {
			had_edge = 1;
			has_any_edge = true;
		}
		for (idx = 0; idx < count; idx += 1) {
			if (first) first = 0;
			else fprintf(g_out, " or ");
			fprintf(g_out, "negedge ");
			smt_expr = dynamic_cast<SMTSignal*>(emit_nexus_as_ca(scope, ivl_event_neg(event, idx), 0, 0));
			assert(smt_expr);
			smt_expr->print(SMT_CLK_CURR);
			SMTProcess::curr_proc->sensitivity_list.insert(smt_expr->parent);
			SMTProcess::curr_proc->is_edge_triggered = true;
            smt_expr->parent->dependent_process.push_back(SMTProcess::curr_proc);
		}

		/* We have a named event if there were no edge events. */
		if (!had_edge) {
			error("named event");
			ivl_scope_t ev_scope = ivl_event_scope(event);
			if (first) first = 0;
			else fprintf(g_out, " or ");
			emit_scope_module_path(scope, ev_scope);
			emit_id(ivl_event_basename(event));
		}
	}
	if(!has_any_edge && enable_obs_padding){
		fprintf(g_out, " or __obs");
	}
}
