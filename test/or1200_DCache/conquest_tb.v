module conquest_tb();

    // Generated top module signals
    reg  clk;
    reg  rst;
    reg  dc_en = 1'b0;
    reg  dcqmem_cycstb_i = 1'b0;
    reg  dcqmem_ci_i = 1'b0;
    reg  dcqmem_we_i = 1'b0;
    reg  [3:0] dcqmem_sel_i = 4'b0;
    reg  tagcomp_miss = 1'b0;
    reg  biudata_valid = 1'b0;
    reg  biudata_error = 1'b0;
    reg  [31:0] lsu_addr = 32'b0;
    wire [3:0] dcram_we;
    wire biu_read;
    wire biu_write;
    wire biu_do_sel;
    wire dcram_di_sel;
    wire first_hit_ack;
    wire first_miss_ack;
    wire first_miss_err;
    wire burst;
    wire tag_we;
    wire tag_valid;
    wire [31:0] dc_addr;
    reg  dc_no_writethrough = 1'b0;
    wire tag_dirty;
    reg  dirty = 1'b0;
    reg  [18:0] tag = 19'b0;
    reg  tag_v = 1'b0;
    reg  dc_block_flush = 1'b0;
    reg  dc_block_writeback = 1'b0;
    reg  [31:0] spr_dat_i = 32'b0;
    wire mtspr_dc_done;
    reg  spr_cswe = 1'b0;
    reg  __obs;

    // Generated top module instance
    or1200_dc_fsm _conc_top_inst(
            .clk       ( clk ),
            .rst       ( rst ),
            .dc_en     ( dc_en ),
            .dcqmem_cycstb_i( dcqmem_cycstb_i ),
            .dcqmem_ci_i( dcqmem_ci_i ),
            .dcqmem_we_i( dcqmem_we_i ),
            .dcqmem_sel_i( dcqmem_sel_i ),
            .tagcomp_miss( tagcomp_miss ),
            .biudata_valid( biudata_valid ),
            .biudata_error( biudata_error ),
            .lsu_addr  ( lsu_addr ),
            .dcram_we  ( dcram_we ),
            .biu_read  ( biu_read ),
            .biu_write ( biu_write ),
            .biu_do_sel( biu_do_sel ),
            .dcram_di_sel( dcram_di_sel ),
            .first_hit_ack( first_hit_ack ),
            .first_miss_ack( first_miss_ack ),
            .first_miss_err( first_miss_err ),
            .burst     ( burst ),
            .tag_we    ( tag_we ),
            .tag_valid ( tag_valid ),
            .dc_addr   ( dc_addr ),
            .dc_no_writethrough( dc_no_writethrough ),
            .tag_dirty ( tag_dirty ),
            .dirty     ( dirty ),
            .tag       ( tag ),
            .tag_v     ( tag_v ),
            .dc_block_flush( dc_block_flush ),
            .dc_block_writeback( dc_block_writeback ),
            .spr_dat_i ( spr_dat_i ),
            .mtspr_dc_done( mtspr_dc_done ),
            .spr_cswe  ( spr_cswe ),
            .__obs     ( __obs ));

    // Generated internal use signals
    reg  [31:0] _conc_pc;
    reg  [100:0] _conc_opcode;
    reg  [100:0] _conc_ram[0:100];


    // Generated clock pulse
    always begin
        #5 clk = ~clk;
    end

    // Generated program counter
    always @(posedge clk) begin
        _conc_pc = _conc_pc + 32'b1;
        _conc_opcode = _conc_ram[_conc_pc];
        __obs <= #1 _conc_opcode[100];
        biudata_error <= #1 _conc_opcode[10];
        biudata_valid <= #1 _conc_opcode[9];
        dc_block_flush <= #1 _conc_opcode[65];
        dc_block_writeback <= #1 _conc_opcode[66];
        dc_en <= #1 _conc_opcode[0];
        dc_no_writethrough <= #1 _conc_opcode[43];
        dcqmem_ci_i <= #1 _conc_opcode[2];
        dcqmem_cycstb_i <= #1 _conc_opcode[1];
        dcqmem_sel_i <= #1 _conc_opcode[7:4];
        dcqmem_we_i <= #1 _conc_opcode[3];
        dirty <= #1 _conc_opcode[44];
        lsu_addr <= #1 _conc_opcode[42:11];
        spr_cswe <= #1 _conc_opcode[99];
        spr_dat_i <= #1 _conc_opcode[98:67];
        tag <= #1 _conc_opcode[63:45];
        tag_v <= #1 _conc_opcode[64];
        tagcomp_miss <= #1 _conc_opcode[8];
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
        #1000 $finish;
    end

endmodule
