`timescale 1ns/100ps


module u_rec (	
				sys_rst_l,
				sys_clk,

				
				uart_dataH,

				
				rec_dataH,
				rec_readyH

				);


`include "./src/inc.h"

input			sys_rst_l;	
input			sys_clk;	

input			uart_dataH;	

output	[7:0]	rec_dataH;	
output			rec_readyH;	
reg rec_readyH;


reg		[2:0]	next_state, state;
reg				rec_datH, rec_datSyncH;
reg		[3:0]	bitCell_cntrH;
reg				cntr_resetH;
reg		[7:0]	par_dataH;
reg				shiftH;
reg		[3:0]	recd_bitCntrH;
reg				countH;
reg				rstCountH;
reg				rec_readyH_temp;
reg				rec_readyInH;


wire	[7:0]	rec_dataH;
wire    rec_data_cntrH_1; 
wire    rec_data_cntrH_2;
wire    rec_data_cntrH_3;
wire    ena;

assign rec_dataH = par_dataH;
assign rec_data_cntrH_1=rec_dataH[0]&rec_dataH[1]&rec_dataH[2]&rec_dataH[3]&rec_dataH[4]&rec_dataH[5]&rec_dataH[6]&rec_dataH[7];
assign rec_data_cntrH_2= (~bitCell_cntrH[0])& bitCell_cntrH[1]& bitCell_cntrH[2]& bitCell_cntrH[3]&recd_bitCntrH[0]&recd_bitCntrH[1]&(~recd_bitCntrH[2])&(~recd_bitCntrH[3]);
assign rec_data_cntrH_3= (state[0])&(state[1])&(~state[2]);

assign ena= rec_data_cntrH_1&rec_data_cntrH_2&rec_data_cntrH_3;
always @(*) begin
	if(ena) begin
		rec_readyH = 1'b0;
	end
	else begin
		rec_readyH = rec_readyH_temp;
	end
end

always @(posedge sys_clk or negedge sys_rst_l)
  if (~sys_rst_l) begin
     rec_datSyncH <= 1'b1;
     rec_datH     <= 1'b1;
  end else begin
     rec_datSyncH <= uart_dataH;
     rec_datH     <= rec_datSyncH;
  end


always @(posedge sys_clk or negedge sys_rst_l)
  if (~sys_rst_l) bitCell_cntrH <= 4'b0;
  else if (cntr_resetH) bitCell_cntrH <= 4'b0;
  else bitCell_cntrH <= bitCell_cntrH + 4'b1;


always @(posedge sys_clk or negedge sys_rst_l)
  if (~sys_rst_l) par_dataH <= 8'b0;
  else if(shiftH) begin
  	par_dataH <= {rec_datH, par_dataH[7:1]};
  end


always @(posedge sys_clk or negedge sys_rst_l)
  if (~sys_rst_l) recd_bitCntrH <= 4'b0;
  else if (countH) recd_bitCntrH <= recd_bitCntrH + 4'b1;
  else if (rstCountH) recd_bitCntrH <= 4'b0;




always @(posedge sys_clk or negedge sys_rst_l)
  if (~sys_rst_l) state <= r_START;
  else state <= next_state;


always @(state or rec_datH or bitCell_cntrH or recd_bitCntrH)
begin

  next_state  = state;
  cntr_resetH = HI;
  shiftH      = LO;
  countH      = LO;
  rstCountH   = LO;
  rec_readyInH= LO;

  case (state)
     
    r_START: begin
       if (~rec_datH ) next_state = r_CENTER;
       else begin 
         next_state = r_START;
         rstCountH  = HI; 
         rec_readyInH = HI; 
       end
    end

    r_CENTER: begin
       if (bitCell_cntrH == 4'h4) begin
         if (~rec_datH) next_state = r_WAIT;
         else next_state = r_START;
       end else begin
         next_state  = r_CENTER;
		 cntr_resetH = LO;        
       end
    end


	r_WAIT: begin
		if (bitCell_cntrH == 4'hE) begin
           if (recd_bitCntrH == WORD_LEN)
             next_state = r_STOP; 
           else begin
             next_state = r_SAMPLE;
           end
        end else begin
             next_state  = r_WAIT;
             cntr_resetH = LO;  
        end
    end

	r_SAMPLE: begin
		shiftH = HI; 
		countH = HI; 
		next_state = r_WAIT;
	end	


    r_STOP: begin
		next_state = r_START;
        rec_readyInH = HI;
    end


  endcase


end


always @(posedge sys_clk or negedge sys_rst_l)
  if (~sys_rst_l) rec_readyH_temp <= 1'b0;
  else rec_readyH_temp <= rec_readyInH;




endmodule
