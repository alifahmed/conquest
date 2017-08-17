#include "data_mem.h"
#include <fstream>
#include "globals.h"
#include "concolic.h"

using namespace std;

CTDataMem::CTDataMem(){
	unroll = 0;
	width = 0;
    is_allocated = false;
}

CTDataMem::~CTDataMem(){
	_free_data();
}

void CTDataMem::load(const char* file) {
    ifstream mem(file);
    if(!mem.is_open()){
        error("Cannot open file: %s", file);
    }
    string line;
    while(mem >> line){
        data.push_back(line);
    }
}

void CTDataMem::dump(const char* file) {
    ofstream mem(file);
    for(auto line:data){
        mem << line << '\n';
    }
}

void CTDataMem::writeb(uint cycle, uint pos, char value) {
    data[cycle][pos] = value;
}

void CTDataMem::_alloc_data(){
    if(!is_allocated){
        is_allocated = true;
        string ref;
        for(uint i=0; i<width; i++){
            ref.append("0");
        }
        for(uint i=0; i<=unroll; i++){
            data.push_back(ref);
        }
    }
}

void CTDataMem::_free_data() {
    if(is_allocated){
        data.clear();
        is_allocated = false;
    }
}

void CTDataMem::generate(bool use_existing) {
    unroll = g_unroll;
    assert(unroll);
    assert(width);
    if(use_existing){
        use_existing = false;
        //check if previous data file exists and valid
        if(is_file_exists(g_data_mem_raw)){
            ifstream f_mem(g_data_mem_raw, ifstream::ate | ifstream::binary);
            const uint size = f_mem.tellg();
            if(size == (width+1)*(unroll+1)){
                use_existing = true;
				load(g_data_mem_raw);
            }
            f_mem.close();
        }
    }
    
    if(!use_existing){
		_alloc_data();
		uint temp_width = width;
        if(enable_obs_padding){
            width--;
        }
        const uint count = width >> 5;
        const uint extra = width & 0b11111;
        for(uint k=0; k<=unroll; k++){
			uint pos = 0;
            if(enable_obs_padding){
				writeb(k, pos++, '0' + (k & 1));
            }
            uint num = rand();
            for(uint j=0; j < extra; j++){
				writeb(k, pos++, '0' + (num & 1));
                num >>= 1;
            }
            for(uint i=0; i < count; i++){
                num = rand();
                for(uint j=0; j < 32; j++){
					writeb(k, pos++, '0' + (num & 1));
                    num >>= 1;
                }
            }
        }
		width = temp_width;
        dump(g_data_mem_raw);
    }
    copy_file(g_data_mem_raw, g_data_mem);
}

sig_t* CTDataMem::add_input(string name, uint port_width){
	sig_t* sig = new sig_t;
	sig->lsb = width;
	sig->msb = width + port_width - 1;
	sig->width = port_width;
	in_ports[name] = sig;
	width += port_width;
	return sig;
}

uint CTDataMem::get_width(){
	return width;
}

void CTDataMem::modify(uint clock, const sig_t* sig, const std::string &value){
	string &str = data[clock];
    str.replace(str.length() - sig->msb - 1, sig->width, value);
}

void CTDataMem::update_input_vectors(const char* src_file){
	ifstream f_in(src_file);
	if(!f_in.is_open()){
		error("Cannot open file: %s", src_file);
	}
	while(true){
		string line;
        getline(f_in, line);
		if(f_in.eof()){
			break;
		}
        string name;
        uint clock = 0;
        
        //parse
        uint pos = 3;
        while(line[pos] != ' ') pos++;
        uint mark1 = pos + 3;
        line[pos] = 0;
        pos--;
        while(line[pos] != '_') pos--;
        name = line.substr(3, (pos-3));
        map<string, sig_t*>::iterator it = in_ports.find(name);
        if(it != in_ports.end()){
            pos++;
            while(line[pos]){
                clock = clock*10 + line[pos]-'0';
                pos++;
            }
            pos = mark1 + 1;
            while(line[pos] != ')') pos++;
            modify(clock, it->second, line.substr(mark1, pos - mark1));
        }
    }
}

void CTDataMem::update_and_dump(const char* src_file, const char* dest_file){
	update_input_vectors(src_file);
	dump(dest_file);
}
