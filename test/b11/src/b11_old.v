module b11(
		input [5:0] x_in,
		input stbi,
		input clock,
		input reset,
		output reg [5:0] x_out
	);

reg [5:0] r_in ;
reg [3:0] stato ;
reg [5:0] cont ;

reg [8:0] cont1 ;
reg [8:0] zeros ;

parameter s_reset   = 4'b0000;
parameter s_datain  = 4'b0001;
parameter s_spazio  = 4'b0010;
parameter s_mul     = 4'b0011;
parameter s_somma   = 4'b0100;
parameter s_rsum    = 4'b0101;
parameter s_rsot    = 4'b0110;
parameter s_compl   = 4'b0111;
parameter s_dataout = 4'b1000;

always@(posedge clock)
	if(reset == 1'b1)
		begin
			stato  <=  s_reset;
			r_in  <=  6'b0;
			cont  <=  6'b0;
			cont1  <=  9'b0;
			x_out <= 6'b0;
			zeros <= 9'b0;
		end
	else
		case(stato)
		s_reset:
			begin
				cont <= 6'b0;
				r_in <= x_in;
				x_out<=6'b0;
				stato <= s_datain;
			end
		s_datain:
			begin
				r_in <= x_in;
				if(stbi == 1'b1)
					stato <= s_datain;
				else
					stato <= s_spazio;        
			end
		s_spazio:
			if(r_in == 6'b0 || r_in == 6'b111111)
			begin
				if(cont<6'b11001)
					cont  <=  cont+1'b1;
				else
					cont <= 6'b0;
				cont1 <= {3'b0,r_in};
				stato <= s_dataout;
			end
			else if(r_in <= 6'b011010) 
				stato <= s_mul;
			else
				stato <= s_datain;
		s_mul:
			begin
			if( r_in[0]==1'b1 )
				cont1 <= {3'b0 , cont} + {3'b0, cont};
			else 
				cont1 <= {3'b0,cont};
				
			stato <= s_somma;
			end
		s_somma:
			if (r_in[1]==1'b1)
				begin
					cont1 <= {3'b0,r_in} + cont1;                                               
					stato <= s_rsum;
				end
			else
				begin
					cont1 <= {3'b0,r_in} - cont1;
					stato <= s_rsot;
				end
		s_rsum:
			if(cont1>9'b011010)
				begin
					cont1 <= cont1-6'b011010;
					stato <= s_rsum;
				end
			else
				stato <= s_compl;
		s_rsot:
			if(cont1>9'b111111)
				begin
					cont1 <= cont1+6'b011010;
					stato <= s_rsot;
				end
			else
				stato <= s_compl;
				
		s_compl:
			begin
				if ( r_in[3:2] ==2'b00 )
					cont1 <= cont1 - 6'b010101;
				else if (r_in[3:2] ==2'b01)
					cont1 <= cont1 - 6'b101010;
				else if (r_in[3:2] ==2'b10)
					cont1 <= cont1 + 3'b111;
				else
					cont1 <= cont1 + 6'b011100;
				stato <= s_dataout;
			end
		s_dataout:
			begin
				if (cont1 < zeros )
//					  x_out<= (-cont1) mod 64;
					  x_out<= cont1[5:0];
				else
					  x_out<= cont1[5:0];
				stato <= s_datain;
			end
		endcase
endmodule
