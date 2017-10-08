module conquest_tb();

    // Generated top module signals
    reg  clk;
    reg  rst;
    reg  ic_en = 1'b0;
    reg  icqmem_cycstb_i = 1'b0;
    reg  icqmem_ci_i = 1'b0;
    reg  tagcomp_miss = 1'b0;
    reg  biudata_valid = 1'b0;
    reg  biudata_error = 1'b0;
    reg  [31:0] start_addr = 32'b0;
    wire [31:0] saved_addr;
    wire [3:0] icram_we;
    wire tag_we;
    wire biu_read;
    wire first_hit_ack;
    wire first_miss_ack;
    wire first_miss_err;
    wire burst;
    reg  __obs;

    // Generated top module instance
    or1200_ic_fsm _conc_top_inst(
            .clk       ( clk ),
            .rst       ( rst ),
            .ic_en     ( ic_en ),
            .icqmem_cycstb_i( icqmem_cycstb_i ),
            .icqmem_ci_i( icqmem_ci_i ),
            .tagcomp_miss( tagcomp_miss ),
            .biudata_valid( biudata_valid ),
            .biudata_error( biudata_error ),
            .start_addr( start_addr ),
            .saved_addr( saved_addr ),
            .icram_we  ( icram_we ),
            .tag_we    ( tag_we ),
            .biu_read  ( biu_read ),
            .first_hit_ack( first_hit_ack ),
            .first_miss_ack( first_miss_ack ),
            .first_miss_err( first_miss_err ),
            .burst     ( burst ),
            .__obs     ( __obs ));

    // Generated internal use signals
    reg  [31:0] _conc_pc;
    reg  [38:0] _conc_opcode;
    reg  [38:0] _conc_ram[0:50];


    // Generated clock pulse
    always begin
        #5 clk = ~clk;
    end

    // Generated program counter
    always @(posedge clk) begin
        _conc_pc = _conc_pc + 32'b1;
        _conc_opcode = _conc_ram[_conc_pc];
        __obs <= #1 _conc_opcode[38];
        biudata_error <= #1 _conc_opcode[5];
        biudata_valid <= #1 _conc_opcode[4];
        ic_en <= #1 _conc_opcode[0];
        icqmem_ci_i <= #1 _conc_opcode[2];
        icqmem_cycstb_i <= #1 _conc_opcode[1];
        start_addr <= #1 _conc_opcode[37:6];
        tagcomp_miss <= #1 _conc_opcode[3];
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
        #500 $finish;
    end

endmodule
