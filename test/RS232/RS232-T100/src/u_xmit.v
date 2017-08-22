


module u_xmit(	sys_clk,
				sys_rst_l,

				uart_xmitH,
				xmitH,
				xmit_dataH,
				xmit_doneH
			);


`include "./src/inc.h"
input			sys_clk;	
input			sys_rst_l;	
output			uart_xmitH;	
input			xmitH;		
input	[7:0]	xmit_dataH;
output			xmit_doneH;	



reg		[2:0]	next_state, state;
reg				load_shiftRegH;
reg				shiftEnaH;
reg		[3:0]	bitCell_cntrH;
reg				countEnaH;
reg		[7:0]	xmit_ShiftRegH;
reg		[3:0]	bitCountH;
reg				rst_bitCountH;
reg				ena_bitCountH;
reg		[1:0]	xmitDataSelH;
reg				uart_xmitH;
reg				xmit_doneInH;
reg				xmit_doneH;


always @(xmit_ShiftRegH or xmitDataSelH)
  case (xmitDataSelH)
	x_STARTbit: uart_xmitH = LO;
	x_STOPbit:  uart_xmitH = HI;
	x_ShiftReg: uart_xmitH = xmit_ShiftRegH[0];	
  endcase


always @(posedge sys_clk or negedge sys_rst_l)
  if (~sys_rst_l) bitCell_cntrH <= 4'b0;
  else if (countEnaH) bitCell_cntrH <= bitCell_cntrH + 4'b1;
  else bitCell_cntrH <= 4'b0;



always @(posedge sys_clk or negedge sys_rst_l)
  if (~sys_rst_l) xmit_ShiftRegH <= 8'b0;
  else 
	if (load_shiftRegH) xmit_ShiftRegH <= xmit_dataH;
	else if (shiftEnaH) begin
		xmit_ShiftRegH <= {HI, xmit_ShiftRegH[7:1]};
	end else xmit_ShiftRegH <= xmit_ShiftRegH;



always @(posedge sys_clk or negedge sys_rst_l)
  if (~sys_rst_l) bitCountH <= 4'b0;
  else if (rst_bitCountH) bitCountH <= 4'b0;
  else if (ena_bitCountH) bitCountH <= bitCountH + 4'b1;



always @(posedge sys_clk or negedge sys_rst_l)
  if (~sys_rst_l) state <= x_IDLE;
  else state <= next_state;


always @(state or xmitH or bitCell_cntrH or bitCountH)
begin
   
	next_state 		= state;
	load_shiftRegH	= LO;
	countEnaH       = LO;
	shiftEnaH       = LO;
	rst_bitCountH   = LO;
	ena_bitCountH   = LO;
    xmitDataSelH    = x_STOPbit;
	xmit_doneInH	= LO;

	case (state)
    	
		x_IDLE: begin
			if (xmitH) begin 
                next_state = x_START;
				load_shiftRegH = HI;
				
			end else begin
				next_state    = x_IDLE;
				rst_bitCountH = HI; 
                xmit_doneInH  = HI;
			end
		end
  


		x_START: begin
            xmitDataSelH    = x_STARTbit;
			if (bitCell_cntrH == 4'hF)
				next_state = x_WAIT;
			else begin 
				next_state = x_START;
				countEnaH  = HI; 
			end				
		end


		x_WAIT: begin
            xmitDataSelH    = x_ShiftReg;
			if (bitCell_cntrH == 4'hE) begin
				if (bitCountH == WORD_LEN)
					next_state = x_STOP;
				else begin
					next_state = x_SHIFT;
					ena_bitCountH = HI; 
				end
			end else begin
				next_state = x_WAIT;
				countEnaH  = HI;
			end		
		end



		x_SHIFT: begin
            xmitDataSelH    = x_ShiftReg;
			next_state = x_WAIT;
			shiftEnaH  = HI; 
		end


		x_STOP: begin
            xmitDataSelH    = x_STOPbit;
			if (bitCell_cntrH == 4'hF) begin
				next_state   = x_IDLE;
                xmit_doneInH = HI;
			end else begin
				next_state = x_STOP;
				countEnaH = HI; 
			end
		end

    endcase

end


always @(posedge sys_clk or negedge sys_rst_l)
  if (~sys_rst_l) xmit_doneH <= 1'b0;
  else xmit_doneH <= xmit_doneInH;


endmodule
