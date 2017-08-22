module conquest_tb();

    // Generated top module signals
    reg  sys_clk;
    reg  sys_rst_l;
    wire uart_XMIT_dataH = 1'b0;
    reg  xmitH = 1'b0;
    reg  [7:0] xmit_dataH = 8'b0;
    wire xmit_doneH = 1'b0;
    reg  uart_REC_dataH = 1'b0;
    wire [7:0] rec_dataH = 8'b0;
    wire rec_readyH = 1'b0;
    reg  __obs;

    // Generated top module instance
    uart _conc_top_inst(
            .sys_clk   ( sys_clk ),
            .sys_rst_l ( sys_rst_l ),
            .uart_XMIT_dataH( uart_XMIT_dataH ),
            .xmitH     ( xmitH ),
            .xmit_dataH( xmit_dataH ),
            .xmit_doneH( xmit_doneH ),
            .uart_REC_dataH( uart_REC_dataH ),
            .rec_dataH ( rec_dataH ),
            .rec_readyH( rec_readyH ),
            .__obs     ( __obs ));

    // Generated internal use signals
    reg  [31:0] _conc_pc;
    reg  [10:0] _conc_opcode;
    reg  [10:0] _conc_ram[0:200];


    // Generated clock pulse
    always begin
        #5 sys_clk = ~sys_clk;
    end

    // Generated program counter
    always @(posedge sys_clk) begin
        _conc_pc = _conc_pc + 32'b1;
        _conc_opcode = _conc_ram[_conc_pc];
        __obs <= #1 _conc_opcode[10];
        uart_REC_dataH <= #1 _conc_opcode[9];
        xmitH <= #1 _conc_opcode[0];
        xmit_dataH <= #1 _conc_opcode[8:1];
        $strobe(";_C %d", _conc_pc);
    end

    // Generated initial block
    initial begin
        $display(";_C 1");
        sys_clk = 1'b0;
        sys_rst_l = 1'b1;
        _conc_pc = 32'b1;
        $readmemb("data.mem", _conc_ram);
        _conc_opcode = _conc_ram[1];
        __obs <= #1 _conc_opcode[10];
        uart_REC_dataH <= #1 _conc_opcode[9];
        xmitH <= #1 _conc_opcode[0];
        xmit_dataH <= #1 _conc_opcode[8:1];
        #2 sys_clk = 1'b1;
        sys_rst_l = 1'b0;
        #5 sys_rst_l = 1'b1;
        #2000 $finish;
    end

endmodule
