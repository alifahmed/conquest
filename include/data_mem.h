#pragma once
#include <string>
#include <vector>
#include <map>
#include "types.h"

typedef struct{
    uint msb;
    uint lsb;
    uint width;
}sig_t;

//Class for managing data file
class CTDataMem{
public:
    CTDataMem();
    virtual ~CTDataMem();
    
    //Load a data file and create corresponding data structure
    void load(const char* src_file);
    
    //Dump data structure to a file
    void dump(const char* dest_file);
    
    //write a specific bit
    void writeb(uint cycle, uint pos, char value);
    
    void generate(bool use_existing);
    
    sig_t* add_input(std::string name, uint port_width);
	
	uint get_width();
	
	//modify a range of bits
	void modify(uint clock, const sig_t* sig, const std::string &value);
	
	//Read src_file (output of constraint solver) and update variables
	void update_input_vectors(const char* src_file);
	
	//Read src_file (output of constraint solver), update variables, and dump output
	void update_and_dump(const char* src_file, const char* dest_file);
	
	std::map<std::string, sig_t*> in_ports;	//Input ports mapped with their name
    
private:
    std::vector<std::string> data;			 //structure for holding data
	void _alloc_data();
    
    uint width;
    uint unroll;
};
