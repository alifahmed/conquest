module conquest_tb();

    // Generated top module signals
    reg  [7:0] in = 8'b0;
    wire [7:0] out;
    reg  clk;
    reg  rst;
    reg  __obs;

    // Generated top module instance
    top _conc_top_inst(
            .in        ( in ),
            .out       ( out ),
            .clk       ( clk ),
            .rst       ( rst ),
            .__obs     ( __obs ));

    // Generated internal use signals
    reg  [31:0] _conc_pc;
    reg  [8:0] _conc_opcode;
    reg  [8:0] _conc_ram[0:10];


    // Generated clock pulse
    always begin
        #5 clk = ~clk;
    end

    // Generated program counter
    always @(posedge clk) begin
        _conc_pc = _conc_pc + 32'b1;
        _conc_opcode = _conc_ram[_conc_pc];
        __obs <= #1 _conc_opcode[8];
        in <= #1 _conc_opcode[7:0];
        $strobe(";_C %d", _conc_pc);
    end

    // Generated initial block
    initial begin
        clk = 1'b0;
        rst = 1'b0;
        _conc_pc = 32'b0;
        $readmemb("data.mem", _conc_ram);
        #2 clk = 1'b1;
        rst = 1'b1;
        #5 rst = 1'b0;
        #100 $finish;
    end

endmodule
