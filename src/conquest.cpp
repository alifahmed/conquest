#include <cstdlib>
#include <iostream>
#include <tclap/CmdLine.h>
#include "types.h"

using namespace std;

int main(int argc, char** argv){
    //Parsing command line arguments using TCLAP library.
    try{
        TCLAP::CmdLine cmd("Command line arguments supported by Conquest", ' ', "1.0");
        
        //Configuration file
        TCLAP::ValueArg<string> cmd_config_file("f", "config-file", "Location of configuration file", false, "", "string");
        cmd.add(cmd_config_file);
        
        //Unroll cycles
        TCLAP::ValueArg<uint> cmd_unroll("u", "unroll", "Number of unrolled cycles", true, 10, "integer");
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
        
        cmd.parse(argc, argv);
    } catch (TCLAP::ArgException &e){
        cerr << "error: " << e.error() << " for arg " << e.argId() << endl;
    }
	return 0;
}
