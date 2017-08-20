module conquest_tb();

    // Generated top module signals
    reg  wb_clk_i;
    reg  rst_i;
    reg  [2:0] wb_adr_i = 3'b0;
    reg  [7:0] wb_dat_i = 8'b0;
    wire [7:0] wb_dat_o = 8'b0;
    reg  wb_we_i = 1'b0;
    reg  wb_stb_i = 1'b0;
    reg  wb_cyc_i = 1'b0;
    wire wb_ack_o = 1'b0;
    wire wb_inta_o = 1'b0;
    reg  scl_pad_i = 1'b0;
    wire scl_pad_o = 1'b0;
    wire scl_padoen_o = 1'b0;
    reg  sda_pad_i = 1'b0;
    wire sda_pad_o = 1'b0;
    wire sda_padoen_o = 1'b0;
    reg  __obs;

    // Generated top module instance
    i2c_master_top _conc_top_inst(
            .wb_clk_i  ( wb_clk_i ),
            .rst_i     ( rst_i ),
            .wb_adr_i  ( wb_adr_i ),
            .wb_dat_i  ( wb_dat_i ),
            .wb_dat_o  ( wb_dat_o ),
            .wb_we_i   ( wb_we_i ),
            .wb_stb_i  ( wb_stb_i ),
            .wb_cyc_i  ( wb_cyc_i ),
            .wb_ack_o  ( wb_ack_o ),
            .wb_inta_o ( wb_inta_o ),
            .scl_pad_i ( scl_pad_i ),
            .scl_pad_o ( scl_pad_o ),
            .scl_padoen_o( scl_padoen_o ),
            .sda_pad_i ( sda_pad_i ),
            .sda_pad_o ( sda_pad_o ),
            .sda_padoen_o( sda_padoen_o ),
            .__obs     ( __obs ));

    // Generated internal use signals
    reg  [31:0] _conc_pc;
    reg  [16:0] _conc_opcode;
    reg  [16:0] _conc_ram[0:20];


    // Generated clock pulse
    always begin
        #5 wb_clk_i = ~wb_clk_i;
    end

    // Generated program counter
    always @(posedge wb_clk_i) begin
        _conc_pc = _conc_pc + 32'b1;
        _conc_opcode = _conc_ram[_conc_pc];
        __obs <= #1 _conc_opcode[16];
        scl_pad_i <= #1 _conc_opcode[14];
        sda_pad_i <= #1 _conc_opcode[15];
        wb_adr_i <= #1 _conc_opcode[2:0];
        wb_cyc_i <= #1 _conc_opcode[13];
        wb_dat_i <= #1 _conc_opcode[10:3];
        wb_stb_i <= #1 _conc_opcode[12];
        wb_we_i <= #1 _conc_opcode[11];
        $strobe(";_C %d", _conc_pc);
    end

    // Generated initial block
    initial begin
        $display(";_C 1");
        wb_clk_i = 1'b0;
        rst_i = 1'b1;
        _conc_pc = 32'b1;
        $readmemb("data.mem", _conc_ram);
        _conc_opcode = _conc_ram[1];
        __obs <= #1 _conc_opcode[16];
        scl_pad_i <= #1 _conc_opcode[14];
        sda_pad_i <= #1 _conc_opcode[15];
        wb_adr_i <= #1 _conc_opcode[2:0];
        wb_cyc_i <= #1 _conc_opcode[13];
        wb_dat_i <= #1 _conc_opcode[10:3];
        wb_stb_i <= #1 _conc_opcode[12];
        wb_we_i <= #1 _conc_opcode[11];
        #2 wb_clk_i = 1'b1;
        rst_i = 1'b0;
        #5 rst_i = 1'b1;
        #200 $finish;
    end

endmodule
