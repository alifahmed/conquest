module conquest_tb();

    // Generated top module signals
    reg  clock;
    reg  line1 = 1'b0;
    reg  line2 = 1'b0;
    reg  reset;
    wire outp;
    wire overflw;

    // Generated top module instance
    b01 _conc_top_inst(
            .clock     ( clock ),
            .line1     ( line1 ),
            .line2     ( line2 ),
            .reset     ( reset ),
            .outp      ( outp ),
            .overflw   ( overflw ));

    // Generated internal use signals
    reg  [31:0] _conc_pc;
    reg  [1:0] _conc_opcode;
    reg  [1:0] _conc_ram[0:10];


    // Generated clock pulse
    always begin
        #5 clock = ~clock;
    end

    // Generated program counter
    always @(posedge clock) begin
        _conc_pc = _conc_pc + 32'b1;
        _conc_opcode = _conc_ram[_conc_pc];
        line1 <= #1 _conc_opcode[0];
        line2 <= #1 _conc_opcode[1];
        $strobe(";_C %d", _conc_pc);
    end

    // Generated initial block
    initial begin
        clock = 1'b0;
        reset = 1'b0;
        _conc_pc = 32'b0;
        $readmemb("data.mem", _conc_ram);
        #2 clock = 1'b1;
        reset = 1'b1;
        #5 reset = 1'b0;
        #100 $finish;
    end

endmodule
