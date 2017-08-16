#include <cstdlib>
#include <iostream>
#include <fstream>
#include <tclap/CmdLine.h>
#include <cstring>
#include <string>
#include "types.h"

using namespace std;

static void parse_cmd_line(int agrc, char** argv);
static uint g_unroll_cycle;
static string g_clock_name;
static string g_reset_name;
static uint g_reset_edge;

int main(int argc, char** argv){
	getchar();
    parse_cmd_line(argc, argv);
	
	//call Concolic tester
    
    
	return 0;
}

static void build_args(int argc, char** argv, vector<string> &args){
	for(int i=0; i<argc; i++){
		args.push_back(argv[i]);
	}
}

static void parse_config_file(const string &file_name, vector<string> args){
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
}

void parse_cmd_line(int argc, char** argv){
	vector<string> args;
	build_args(argc, argv, args);
	
	//Parsing command line arguments using TCLAP library.
    try{
        TCLAP::CmdLine cmd("Command line arguments supported by Conquest", '=', "1.0");
        
        //Configuration file
        TCLAP::ValueArg<string> cmd_config_file("f", "config-file", "Location of configuration file", false, "", "string");
        cmd.add(cmd_config_file);		
        
        //Unroll cycles
        TCLAP::ValueArg<uint> cmd_unroll("u", "unroll", "Number of unrolled cycles", false, 0, "integer");
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
        
        cmd.parse(args);
		
		if(cmd_config_file.getValue() != ""){
			//Configuration file given. Append to args
			parse_config_file(cmd_config_file.getValue(), args);			
			cmd.parse(args);
		}
	
        //assign values
        g_unroll_cycle = cmd_unroll.getValue();
        g_clock_name = cmd_clock.getValue();
        g_reset_name = cmd_reset.getValue();
        g_reset_edge = cmd_reset_edge.getValue();
        
        //check for error
        if(g_unroll_cycle == 0){
            cerr << "Invalid unroll cycles. Use -u or --unroll to specify unroll cycles." << endl;
            cerr << "Use -h or --help to see available options." << endl;
            exit(-1);
        }
    } catch (TCLAP::ArgException &e){
        cerr << "error: " << e.error() << " for arg " << e.argId() << endl;
    }
}