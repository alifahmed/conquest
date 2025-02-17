module conquest_tb();

    // Generated top module signals
    reg  clock;
    reg  reset;
    reg  [7:0] in = 8'b0;
    wire out;
    reg  __obs;

    // Generated top module instance
    top _conc_top_inst(
            .clock     ( clock ),
            .reset     ( reset ),
            .in        ( in ),
            .out       ( out ),
            .__obs     ( __obs ));

    // Generated internal use signals
    reg  [31:0] _conc_pc;
    reg  [8:0] _conc_opcode;
    reg  [8:0] _conc_ram[0:10];


    // Generated clock pulse
    always begin
        #5 clock = ~clock;
    end

    // Generated program counter
    always @(posedge clock) begin
        _conc_pc = _conc_pc + 32'b1;
        _conc_opcode = _conc_ram[_conc_pc];
        __obs <= #1 _conc_opcode[8];
        in <= #1 _conc_opcode[7:0];
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
