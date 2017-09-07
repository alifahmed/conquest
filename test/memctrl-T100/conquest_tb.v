module conquest_tb();

    // Generated top module signals
    reg  clk_i;
    reg  rst_i;
    reg  [31:0] wb_data_i = 32'b0;
    wire [31:0] wb_data_o;
    reg  [31:0] wb_addr_i = 32'b0;
    reg  [3:0] wb_sel_i = 4'b0;
    reg  wb_we_i = 1'b0;
    reg  wb_cyc_i = 1'b0;
    reg  wb_stb_i = 1'b0;
    wire wb_ack_o;
    wire wb_err_o;
    reg  susp_req_i = 1'b0;
    reg  resume_req_i = 1'b0;
    wire suspended_o;
    wire [31:0] poc_o;
    reg  mc_clk_i = 1'b0;
    reg  mc_br_pad_i = 1'b0;
    wire mc_bg_pad_o;
    reg  mc_ack_pad_i = 1'b0;
    wire [23:0] mc_addr_pad_o;
    reg  [31:0] mc_data_pad_i = 32'b0;
    wire [31:0] mc_data_pad_o;
    reg  [3:0] mc_dp_pad_i = 4'b0;
    wire [3:0] mc_dp_pad_o;
    wire mc_doe_pad_doe_o;
    wire [3:0] mc_dqm_pad_o;
    wire mc_oe_pad_o_;
    wire mc_we_pad_o_;
    wire mc_cas_pad_o_;
    wire mc_ras_pad_o_;
    wire mc_cke_pad_o_;
    wire [7:0] mc_cs_pad_o_;
    reg  mc_sts_pad_i = 1'b0;
    wire mc_rp_pad_o_;
    wire mc_vpen_pad_o;
    wire mc_adsc_pad_o_;
    wire mc_adv_pad_o_;
    wire mc_zz_pad_o;
    wire mc_coe_pad_coe_o;
    reg  __obs;

    // Generated top module instance
    mc_top _conc_top_inst(
            .clk_i     ( clk_i ),
            .rst_i     ( rst_i ),
            .wb_data_i ( wb_data_i ),
            .wb_data_o ( wb_data_o ),
            .wb_addr_i ( wb_addr_i ),
            .wb_sel_i  ( wb_sel_i ),
            .wb_we_i   ( wb_we_i ),
            .wb_cyc_i  ( wb_cyc_i ),
            .wb_stb_i  ( wb_stb_i ),
            .wb_ack_o  ( wb_ack_o ),
            .wb_err_o  ( wb_err_o ),
            .susp_req_i( susp_req_i ),
            .resume_req_i( resume_req_i ),
            .suspended_o( suspended_o ),
            .poc_o     ( poc_o ),
            .mc_clk_i  ( mc_clk_i ),
            .mc_br_pad_i( mc_br_pad_i ),
            .mc_bg_pad_o( mc_bg_pad_o ),
            .mc_ack_pad_i( mc_ack_pad_i ),
            .mc_addr_pad_o( mc_addr_pad_o ),
            .mc_data_pad_i( mc_data_pad_i ),
            .mc_data_pad_o( mc_data_pad_o ),
            .mc_dp_pad_i( mc_dp_pad_i ),
            .mc_dp_pad_o( mc_dp_pad_o ),
            .mc_doe_pad_doe_o( mc_doe_pad_doe_o ),
            .mc_dqm_pad_o( mc_dqm_pad_o ),
            .mc_oe_pad_o_( mc_oe_pad_o_ ),
            .mc_we_pad_o_( mc_we_pad_o_ ),
            .mc_cas_pad_o_( mc_cas_pad_o_ ),
            .mc_ras_pad_o_( mc_ras_pad_o_ ),
            .mc_cke_pad_o_( mc_cke_pad_o_ ),
            .mc_cs_pad_o_( mc_cs_pad_o_ ),
            .mc_sts_pad_i( mc_sts_pad_i ),
            .mc_rp_pad_o_( mc_rp_pad_o_ ),
            .mc_vpen_pad_o( mc_vpen_pad_o ),
            .mc_adsc_pad_o_( mc_adsc_pad_o_ ),
            .mc_adv_pad_o_( mc_adv_pad_o_ ),
            .mc_zz_pad_o( mc_zz_pad_o ),
            .mc_coe_pad_coe_o( mc_coe_pad_coe_o ),
            .__obs     ( __obs ));

    // Generated internal use signals
    reg  [31:0] _conc_pc;
    reg  [113:0] _conc_opcode;
    reg  [113:0] _conc_ram[0:10];


    // Generated clock pulse
    always begin
        #5 clk_i = ~clk_i;
    end

    // Generated program counter
    always @(posedge clk_i) begin
        _conc_pc = _conc_pc + 32'b1;
        _conc_opcode = _conc_ram[_conc_pc];
        __obs <= #1 _conc_opcode[113];
        mc_ack_pad_i <= #1 _conc_opcode[75];
        mc_br_pad_i <= #1 _conc_opcode[74];
        mc_clk_i <= #1 _conc_opcode[73];
        mc_data_pad_i <= #1 _conc_opcode[107:76];
        mc_dp_pad_i <= #1 _conc_opcode[111:108];
        mc_sts_pad_i <= #1 _conc_opcode[112];
        resume_req_i <= #1 _conc_opcode[72];
        susp_req_i <= #1 _conc_opcode[71];
        wb_addr_i <= #1 _conc_opcode[63:32];
        wb_cyc_i <= #1 _conc_opcode[69];
        wb_data_i <= #1 _conc_opcode[31:0];
        wb_sel_i <= #1 _conc_opcode[67:64];
        wb_stb_i <= #1 _conc_opcode[70];
        wb_we_i <= #1 _conc_opcode[68];
        $strobe(";_C %d", _conc_pc);
    end

    // Generated initial block
    initial begin
        clk_i = 1'b0;
        rst_i = 1'b0;
        _conc_pc = 32'b0;
        $readmemb("data.mem", _conc_ram);
        #2 clk_i = 1'b1;
        rst_i = 1'b1;
        #5 rst_i = 1'b0;
        #100 $finish;
    end

endmodule
