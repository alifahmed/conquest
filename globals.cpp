#include "ivl_target.h"
#include "smt_lib.h"
#include <sstream>
#include <vector>
#include <map>
#include <unordered_map>

//global variables
const char*		g_version_string = "Concolic testing framework";
FILE*			g_out;
int				g_errors = 0;
int				g_precision = 0;
unsigned		g_ind = 0;
unsigned		g_ind_incr = 4;
unsigned		g_emit_file_line = 0;
unsigned		g_allow_signed = 0;
ivl_design_t	g_design = 0;
const char*		g_data_mem = "data.mem";
uint			g_unroll;
const char*     g_reset_sig_name;

std::map<std::string, sig_t> g_in_port_map;
std::unordered_map<std::string, SMTSigCore*> g_name_sig_map;
std::vector<SMTSigCore*> g_in_port_list;
std::ofstream g_define_out;
