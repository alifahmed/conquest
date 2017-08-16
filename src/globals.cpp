#include "ivl_target.h"
#include "smt_lib.h"
#include <sstream>
#include <vector>
#include <map>
#include <unordered_map>
#include <string>

using namespace std;

//global variables
FILE*			g_out;
int				g_errors = 0;
unsigned		g_ind = 0;
unsigned		g_ind_incr = 4;
ivl_design_t	g_design = 0;
const char*     g_output_file = "conquest_dut.v";
const char*     g_tb_file = "conquest_tb.v";
const char*		g_data_mem = "data.mem";
const char*     g_data_mem_raw = "data_raw.mem";

//Parameters
uint			g_unroll;
const char*     g_clock_sig_name;
const char*     g_reset_sig_name;
const char*     g_reset_edge_active;


std::map<std::string, sig_t> g_in_port_map;
std::unordered_map<std::string, SMTSigCore*> g_name_sig_map;
std::vector<SMTSigCore*> g_in_port_list;
std::ofstream g_define_out;
