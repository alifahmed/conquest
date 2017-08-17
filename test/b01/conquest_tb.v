module conquest_tb();

    // Generated top module signals
    reg  clock;
    reg  line1 = 1'b0;
    reg  line2 = 1'b0;
    reg  reset;
    wire outp = 1'b0;
    wire overflw = 1'b0;
    reg  __obs;

    // Generated top module instance
    b01 _conc_top_inst(
            .clock     ( clock ),
            .line1     ( line1 ),
            .line2     ( line2 ),
            .reset     ( reset ),
            .outp      ( outp ),
            .overflw   ( overflw ),
            .__obs     ( __obs ));

    // Generated internal use signals
    reg  [31:0] _conc_pc;
    reg  [2:0] _conc_opcode;
    reg  [2:0] _conc_ram[0:10];


    // Generated clock pulse
    always begin
        #5 clock = ~clock;
    end

    // Generated program counter
    always @(posedge clock) begin
        _conc_pc = _conc_pc + 32'b1;
        _conc_opcode = _conc_ram[_conc_pc];
        __obs <= #1 _conc_opcode[2];
        line1 <= #1 _conc_opcode[0];
        line2 <= #1 _conc_opcode[1];
        $strobe(";_C %d", _conc_pc);
    end

    // Generated initial block
    initial begin
        $display(";_C 1");
        clock = 1'b0;
        reset = 1'b0;
        _conc_pc = 32'b1;
        $readmemb("data.mem", _conc_ram);
        _conc_opcode = _conc_ram[1];
        __obs <= #1 _conc_opcode[2];
        line1 <= #1 _conc_opcode[0];
        line2 <= #1 _conc_opcode[1];
        #2 clock = 1'b1;
        reset = 1'b1;
        #5 reset = 1'b0;
        #100 $finish;
    end

endmodule
