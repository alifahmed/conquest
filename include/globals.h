#pragma once

#include "types.h"
#include "ivl_target.h"
#include "data_mem.h"
#include <cstdio>
#include <ctime>

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
extern CTDataMem		g_data;
extern clock_t          start_time;

//Parameters
extern uint     		g_unroll;
extern const char*      g_clock_sig_name;
extern const char*      g_reset_sig_name;
extern const char*      g_reset_edge_active;
extern uint				g_branch_id;

//Configuration declarations
//#define conc_flush(X)   fflush(X)
#define conc_flush(X) 
extern const bool		enable_error_check;
extern const bool		enable_obs_padding;
extern const bool		enable_sim_copy;
extern const bool		enable_yices_debug;
