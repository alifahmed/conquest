#pragma once
#include <string>
#include <vector>


//Class for managing data file
class CTDataMem{
public:
    CTDataMem(uint width, uint unroll);
    virtual ~CTDataMem();
    
    //Load a data file and create corresponding data structure
    void load(const char* file);
    
    //Dump data structure to a file
    void dump(const char* file);
    
    //write a specific bit
    void writeb(uint cycle, uint pos, char value);
    
    void generate(uint width, uint unroll, bool use_existing);
    
    
    
private:
    //structure for holding data
    std::vector<std::string> data;
    
    const uint width;
    const uint unroll;
};
