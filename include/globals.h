#pragma once

#include "types.h"
#include "ivl_target.h"
#include <cstdio>

//global variables
extern FILE*			g_out;
extern int				g_errors;
extern unsigned         g_ind;
extern unsigned         g_ind_incr;
extern ivl_design_t     g_design;
extern const char*      g_output_file;
extern const char*      g_tb_file;
extern const char*		g_data_mem;
extern const char*		g_data_mem_raw;

//Parameters
extern uint     		g_unroll;
extern const char*      g_clock_sig_name;
extern const char*      g_reset_sig_name;
extern const char*      g_reset_edge_active;
