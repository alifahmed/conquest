/*
 * This is the Concolic testing target module. It generates a flattened verilog
 * behavioral code from the input verilog code. It also generates CFG for use by
 * extension programs.
 * 
 * @Author: Alif Ahmed (alifahmed@ufl.edu)
 * 
 */

#include "concolic.h"
#include <cstdlib>
#include <cstring>
#include <vector>
#include <sstream>
#include <valarray>

using namespace std;

void generate_data_file(uint width, uint unroll){
	if(enable_obs_padding){
		width--;
	}
	FILE* f_mem = fopen(g_data_mem, "w");
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
	system("cp data.mem data_raw.mem");
}

void generate_tb(ivl_scope_t root){
	ivl_design_t design = g_design;
	
	const char* unroll_cyc;
	unroll_cyc = ivl_design_flag(design, "unroll");
	if(unroll_cyc == NULL){
		error("Unroll cycle not given");
	}
	g_unroll = atoi(unroll_cyc);
	
	const char* tb_path = ivl_design_flag(design, "tb");
	if(tb_path){
		const char* name;
		
		//if already exists, then skip
		FILE* f_tb = fopen(tb_path, "w");
		//if(f_tb){
		//	fclose(f_tb);
		//	return;
		//}
		//f_tb = fopen(tb_path, "w");
		
		bool have_reset = false;
		const char *clk_sig, *reset_active, *reset_inactive;
		
		//need to generate testbench. Check for required parameters
		clk_sig = ivl_design_flag(design, "clk");
		if(clk_sig == NULL){
			error("Clk signal name not given");
		}
		
		g_reset_sig_name = ivl_design_flag(design, "reset");
		if((g_reset_sig_name == NULL) || (strcmp(g_reset_sig_name, "") == 0)){
			info("Reset signal name not given");
            g_reset_sig_name = NULL;
		} else {
			have_reset = true;
			reset_active = ivl_design_flag(design, "reset_edge");
			if(strcmp(reset_active,"1") == 0){
				reset_active = "1'b1";
				reset_inactive = "1'b0";
			}
			else if(strcmp(reset_active,"0") == 0){
				reset_active = "1'b0";
				reset_inactive = "1'b1";
			}
			else{
				error("Wrong reset parameters");
			}
		}
		
		fprintf(f_tb, "module concolic_tb();\n\n");
		uint width = 0;
		const uint count = ivl_scope_mod_module_ports(root);
		if(count == 0){
			error("Top module do not have any ports");
		}
		
		bool clk_found = false, reset_found = false;

		fprintf(f_tb, "%*c// Generated top module signals\n", 4, ' ');
		for(uint i=0; i<count; i++){
			name = ivl_scope_mod_module_port_name(root, i);
			uint temp_width = ivl_scope_mod_module_port_width(root, i);
			const char* type;
			bool is_init_val_req = true;
			if(strcmp(name, clk_sig) == 0){
				if(temp_width != 1){
					error("Clock signal width is not 1");
				}
				type = "reg ";
				clk_found = true;
				is_init_val_req = false;
			}
			else if(strcmp(name, g_reset_sig_name) == 0){
				if(temp_width != 1){
					error("Reset signal width is not 1");
				}
				type = "reg ";
				reset_found = true;
				is_init_val_req = false;
			} else{
				type = "reg ";
                ivl_signal_port_t port_type = ivl_scope_mod_module_port_type(root, i);
                if(port_type == IVL_SIP_INPUT){
                    sig_t temp;
                    temp.lsb = width;
                    temp.msb = width + temp_width - 1;
                    temp.width = temp_width;
                    g_in_port_map[string(name)] = temp;
                    width += temp_width;
                } else if(port_type == IVL_SIP_OUTPUT){
					type = "wire";
				}
			}
			
			if(temp_width == 1){
				fprintf(f_tb, "%*c%s %s", 4, ' ', type, name);
			} else {
				fprintf(f_tb, "%*c%s [%u:0] %s", 4, ' ', type, temp_width - 1, name);
			}
			
			if(is_init_val_req){
				fprintf(f_tb, " = %d\'b0", temp_width);
			}
			
			fprintf(f_tb, ";\n");
		}
		if(enable_obs_padding){
			fprintf(f_tb, "%*creg  __obs;\n", 4, ' ');
			sig_t temp = {width, width, 1};
			g_in_port_map["__obs"] = temp;
			width++;
		}
		if(clk_found == false){
			error("Clock signal not found in top module");
		}
		if(have_reset && !reset_found){
			error("Specified reset signal not found");
		}
		
		//Dump top module instantiation
		fprintf(f_tb, "\n%*c// Generated top module instance\n", 4, ' ');
		fprintf(f_tb, "%*c%s _conc_top_inst(\n", 4, ' ', ivl_scope_tname(root));
		if(count){
			name = ivl_scope_mod_module_port_name(root, 0);
			fprintf(f_tb, "%*c.%-10s( %s )", 12, ' ', name, name);
		}
		for(uint i=1; i<count; i++){
			name = ivl_scope_mod_module_port_name(root, i);
			fprintf(f_tb, ",\n%*c.%-10s( %s )", 12, ' ', name, name);
		}
		if(enable_obs_padding){
			fprintf(f_tb, ",\n%*c.__obs     ( __obs )", 12, ' ');
		}
		fprintf(f_tb, ");\n");
		
		if(width > 1){
#if defined(DATA_MEM_TYPE_HEX)
			//make ram width multiple of 4
			if(width & 0b11){
				width += 4;
			}
			width = (width >> 2) << 2;
#endif
			
			//Dump internal use signals
			fprintf(f_tb, "\n%*c// Generated internal use signals\n", 4, ' ');
			fprintf(f_tb, "%*creg  [31:0] _conc_pc;\n", 4, ' ');
			fprintf(f_tb, "%*creg  [%u:0] _conc_opcode;\n", 4, ' ', width-1);
			fprintf(f_tb, "%*creg  [%u:0] _conc_ram[0:%s];\n\n", 4, ' ', width-1, unroll_cyc);
			
			//Dump clk toggle
			fprintf(f_tb, "\n%*c// Generated clock pulse\n", 4, ' ');
			fprintf(f_tb, "%*calways begin\n", 4, ' ');
			fprintf(f_tb, "%*c#5 %s = ~%s;\n", 8, ' ', clk_sig, clk_sig);
			fprintf(f_tb, "%*cend\n", 4, ' ');
			
			//Dump pc increment
			fprintf(f_tb, "\n%*c// Generated program counter\n", 4, ' ');
			fprintf(f_tb, "%*calways @(posedge %s) begin\n", 4, ' ', clk_sig);
			fprintf(f_tb, "%*c_conc_pc = _conc_pc + 32'b1;\n", 8, ' ');
			fprintf(f_tb, "%*c_conc_opcode = _conc_ram[_conc_pc];\n", 8, ' ');
			map<std::string, sig_t>::iterator it = g_in_port_map.begin();
            for(;it != g_in_port_map.end(); it++){
                if(it->second.width > 1){
                    fprintf(f_tb, "%*c%s <= #1 _conc_opcode[%u:%u];\n", 8, ' ', it->first.c_str(), it->second.msb, it->second.lsb);
                } else {
					fprintf(f_tb, "%*c%s <= #1 _conc_opcode[%u];\n", 8, ' ', it->first.c_str(), it->second.msb);
				}
            }
			fprintf(f_tb, "%*c$strobe(\";_C %%d\", _conc_pc);\n", 8, ' ');
			fprintf(f_tb, "%*cend\n", 4, ' ');
			
			//Dump initial block
			fprintf(f_tb, "\n%*c// Generated initial block\n", 4, ' ');
			fprintf(f_tb, "%*cinitial begin\n", 4, ' ');
			fprintf(f_tb, "%*c$display(\";_C 1\");\n", 8, ' ');
			fprintf(f_tb, "%*c%s = 1'b0;\n", 8, ' ', clk_sig);
			if(have_reset){
				fprintf(f_tb, "%*c%s = %s;\n", 8, ' ', g_reset_sig_name, reset_inactive);
			}
			fprintf(f_tb, "%*c_conc_pc = 32'b1;\n", 8, ' ');
#if defined(DATA_MEM_TYPE_HEX)
			fprintf(f_tb, "%*c$readmemh(\"%s\", _conc_ram);\n", 8, ' ', g_data_mem);
#elif defined(DATA_MEM_TYPE_BIN)
			fprintf(f_tb, "%*c$readmemb(\"%s\", _conc_ram);\n", 8, ' ', g_data_mem);
#endif
			
			fprintf(f_tb, "%*c_conc_opcode = _conc_ram[1];\n", 8, ' ');
			it = g_in_port_map.begin();
            for(;it != g_in_port_map.end(); it++){
                if(it->second.width > 1){
                    fprintf(f_tb, "%*c%s <= #1 _conc_opcode[%u:%u];\n", 8, ' ', it->first.c_str(), it->second.msb, it->second.lsb);
                } else {
					fprintf(f_tb, "%*c%s <= #1 _conc_opcode[%u];\n", 8, ' ', it->first.c_str(), it->second.msb);
				}
            }
			fprintf(f_tb, "%*c#2 %s = 1'b1;\n", 8, ' ', clk_sig);
			if(have_reset){
				fprintf(f_tb, "%*c%s = %s;\n", 8, ' ', g_reset_sig_name, reset_active);
				fprintf(f_tb, "%*c#5 %s = %s;\n", 8, ' ', g_reset_sig_name, reset_inactive);
			}
			fprintf(f_tb, "%*c#%d $finish;\n", 8, ' ', (atoi(unroll_cyc)) * 10);
			fprintf(f_tb, "%*cend\n\n", 4, ' ');
			
			generate_data_file(width, g_unroll);
		} else{
			error("TODO: Testbench for input width of 1");
		}
		
		fprintf(f_tb, "endmodule\n");
		fclose(f_tb);
	}
}

extern "C" int target_design(ivl_design_t design) {
	//set globals
	g_design = design;
	g_precision = ivl_design_time_precision(design);
	g_allow_signed = 0;
	
	//init yices API
	if(enable_yices_api) {
		yices_init();
	}
	
	//open output file
	const char *path = ivl_design_flag(design, "-o");
	g_out = fopen(path, "w");
	if (g_out == 0) {
		error("Could not open output file %s", path);
	}

	//Get root module
	ivl_scope_t *roots;
	unsigned nroots;
	ivl_design_roots(design, &roots, &nroots);
	if(nroots != 1){
		error("Number of root is %u", nroots);
	}
	if(ivl_scope_type(roots[0]) != IVL_SCT_MODULE){
		error("Root scope type is not module");
	}
	
	generate_tb(roots[0]);
	
	//draw all scopes
	emit_root(roots[0]);

	//free_emitted_scope_list();

	/* Emit any UDP definitions that the design used. */
	//emit_udp_list();

	/* Emit any UDPs that are Icarus generated (D-FF). */
	//emit_icarus_generated_udps();

	SMTSigCore::print_state_variables();
	
	fclose(g_out);
	g_out = NULL;
	
	//compile
	//system("iverilog instrumented.v tb_concolic.v -o conc_run.vvp");
    
	start_concolic();
	

	/* A do nothing call to prevent warnings about this routine not
	 * being used. */
	//dump_nexus_information(0, 0);

	return g_errors;
}

extern "C" const char* target_query(const char*key) {
	if (strcmp(key, "version") == 0) {
		return g_version_string;
	}

	return 0;
}
