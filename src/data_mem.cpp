#include "data_mem.h"
#include <fstream>
#include "concolic.h"

using namespace std;

CTDataMem::CTDataMem(uint width, uint unroll) {
    for(uint i=0; i<=unroll; i++){
        string line;
        line.reserve(width+2);
        line[width] = '\n';
        line[width+1] = 0;
        data.push_back(line);
    }
}

void CTDataMem::load(const char* file) {
    ifstream mem(file);
    if(!mem.is_open()){
        error("Cannot open file: %s", file);
    }
    string line;
    while(getline(mem, line)){
        data.push_back(line);
    }
}

void CTDataMem::dump(const char* file) {
    ofstream mem(file);
    for(auto line:data){
        mem << line;
    }
}

void CTDataMem::writeb(uint cycle, uint pos, char value) {
    data[cycle][pos] = value;
}


void CTDataMem::generate(uint width, uint unroll, bool use_existing) {
    if(use_existing){
        use_existing = false;
        //check if previous data file exists
        if(is_file_exists(g_data_mem_raw)){
            ifstream f_mem(g_data_mem_raw, ifstream::ate | ifstream::binary);
            const uint size = f_mem.tellg();
            if(size == (width+1)*unroll){
                use_existing = true;
            }
            f_mem.close();
        }
    }
    
    if(!use_existing){
        //File not valid. Create one...
        FILE* f_mem = fopen(g_data_mem_raw, "w");
        
        if(enable_obs_padding){
            width--;
        }
        const uint count = width >> 5;
        const uint extra = width & 0b11111;
        for(uint k=0; k<=unroll; k++){
            if(enable_obs_padding){
                fputc('0' + (k&1), f_mem);
            }
            uint num = rand();
            for(uint j=0; j < extra; j++){
                fputc('0' + (num & 1), f_mem);
                num >>= 1;
            }
            for(uint i=0; i < count; i++){
                num = rand();
                for(uint j=0; j < 32; j++){
                    fputc('0' + (num & 1), f_mem);
                    num >>= 1;
                }
            }
            fputc('\n', f_mem);
        }
        fclose(f_mem);
    }
    copy_file(g_data_mem_raw, g_data_mem);
}
