#include <cstdlib>
#include <iostream>
#include <fstream>
#include <tclap/CmdLine.h>
#include <cstring>
#include <string>
#include "types.h"

using namespace std;

static void parse_cmd_line(int agrc, char** argv);

int main(int argc, char** argv){
	getchar();
    parse_cmd_line(argc, argv);
	
	
	return 0;
}

static void build_string(int argc, char** argv, vector<string> &args){
	for(int i=0; i<argc; i++){
		args.push_back(argv[i]);
	}
}

static void parse_config_file(const string &file_name, vector<string> args){
	ifstream config_file(file_name);
	if(!config_file.is_open()){
		cerr << "Cannot open configuration file: " << file_name << endl;
	}
	const char *str = new char[1024];
	config_file.getline(str, 1024);
	do{
		const char *begin = str;
		while(*str != ' ' && *str)
			str++;
		args.push_back(string(begin, str));
	} while (0 != *str++);
}

void parse_cmd_line(int argc, char** argv){
	vector<string> args;
	build_string(argc, argv, args);
	
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
		
    } catch (TCLAP::ArgException &e){
        cerr << "error: " << e.error() << " for arg " << e.argId() << endl;
    }
}