#include <cstdlib>
#include <iostream>
#include <fstream>
#include <tclap/CmdLine.h>
#include <cstring>
#include <string>
#include "types.h"

using namespace std;

static void parse_cmd_line(int agrc, char** argv);
static string   g_src_file;
static uint     g_unroll_cycle;
static string   g_clock_name;
static string   g_reset_name;
static uint     g_reset_edge;
static uint     g_branch_id = 0xDEADBEEF;

int main(int argc, char** argv){
    parse_cmd_line(argc, argv);
	
	string cmd;
	if(g_branch_id == 0xDEADBEEF){
		//call Concolic tester
		cmd = "iverilog_dev -t conquest -o conquest_dut.v -f " + g_src_file + 
            " -pclk=" + g_clock_name + " -preset=" + g_reset_name + 
            " -preset_edge=" + to_string(g_reset_edge) + " -punroll=" + 
            to_string(g_unroll_cycle);
	}
	else{
		//call Concolic tester
		cmd = "iverilog_dev -t conquest -o conquest_dut.v -f " + g_src_file + 
            " -pclk=" + g_clock_name + " -preset=" + g_reset_name + 
            " -preset_edge=" + to_string(g_reset_edge) + " -punroll=" + 
            to_string(g_unroll_cycle) + " -pbid=" + to_string(g_branch_id);
	}
	
	
    system(cmd.c_str());
	return 0;
}

static void build_args(int argc, char** argv, vector<string> &args){
	for(int i=0; i<argc; i++){
		args.push_back(argv[i]);
	}
}

/*static void parse_config_file(const string &file_name, vector<string> args){
	ifstream config_file(file_name);
	if(!config_file.is_open()){
		cerr << "Cannot open configuration file: " << file_name << endl;
	}
	char line[1024];
	config_file.getline(line, 1024);
    const char* end=line;
	do{
		const char *begin = end;
		while(*end != ' ' && *end)
			end++;
		args.push_back(string(begin, end));
	} while (0 != *end++);
}*/

void parse_cmd_line(int argc, char** argv){
	vector<string> args;
	build_args(argc, argv, args);
	
	//Parsing command line arguments using TCLAP library.
    try{
        TCLAP::CmdLine cmd("Command line arguments supported by Conquest", '=', "1.0");
        
        //Verilog source files
        TCLAP::ValueArg<string> cmd_src_file("f", "files", "Location of source files", true, "", "string");
        cmd.add(cmd_src_file);		
        
        //Unroll cycles
        TCLAP::ValueArg<uint> cmd_unroll("u", "unroll", "Number of unrolled cycles", false, 10, "integer");
        cmd.add(cmd_unroll);
        
        //clock signal name
        TCLAP::ValueArg<string> cmd_clock("c", "clock", "Name of clock signal", false, "clock", "string");
        cmd.add(cmd_clock);
        
        //reset signal name
        TCLAP::ValueArg<string> cmd_reset("r", "reset", "Name of reset signal", false, "reset", "string");
        cmd.add(cmd_reset);
        
        //reset signal edge
        TCLAP::ValueArg<bool> cmd_reset_edge("e", "reset-edge", "Edge of reset signal", false, true, "bool");
        cmd.add(cmd_reset_edge);
        
		//branch id
        TCLAP::ValueArg<uint> cmd_branch_id("b", "branch-id", "Target branch id", false, 0xDEADBEEF, "integer");
        cmd.add(cmd_branch_id);
		
        cmd.parse(args);
		
		/*if(cmd_config_file.getValue() != ""){
			//Configuration file given. Append to args
			parse_config_file(cmd_config_file.getValue(), args);			
			cmd.parse(args);
		}*/
	
        //assign values
        g_src_file = cmd_src_file.getValue();
        g_unroll_cycle = cmd_unroll.getValue();
        g_clock_name = cmd_clock.getValue();
        g_reset_name = cmd_reset.getValue();
        g_reset_edge = cmd_reset_edge.getValue();
		g_branch_id = cmd_branch_id.getValue();
    } catch (TCLAP::ArgException &e){
        cerr << "error: " << e.error() << " for arg " << e.argId() << endl;
    }
}