module concolic_tb();

    // Generated top module signals
    reg  clk;
    reg  rst;
    reg  sig_ibuserr;
    reg  sig_dbuserr;
    reg  sig_illegal;
    reg  sig_align;
    reg  sig_range;
    reg  sig_dtlbmiss;
    reg  sig_dmmufault;
    reg  sig_int;
    reg  sig_syscall;
    reg  sig_trap;
    reg  sig_itlbmiss;
    reg  sig_immufault;
    reg  sig_tick;
    reg  ex_branch_taken;
    reg  genpc_freeze;
    reg  id_freeze;
    reg  ex_freeze;
    reg  wb_freeze;
    reg  if_stall;
    reg  [31:0] if_pc;
    wire [31:0] id_pc;
    wire [31:0] ex_pc;
    wire [31:0] wb_pc;
    reg  id_flushpipe;
    reg  ex_flushpipe;
    wire extend_flush;
    wire except_flushpipe;
    wire [3:0] except_type;
    wire except_start;
    wire except_started;
    wire [13:0] except_stop;
    wire [13:0] except_trig;
    reg  ex_void;
    wire abort_mvspr;
    reg  [2:0] branch_op;
    wire [31:0] spr_dat_ppc;
    wire [31:0] spr_dat_npc;
    reg  [31:0] datain;
    reg  [13:0] du_dsr;
    reg  epcr_we;
    reg  eear_we;
    reg  esr_we;
    reg  pc_we;
    wire [31:0] epcr;
    wire [31:0] eear;
    reg  [24:0] du_dmr1;
    reg  du_hwbkpt;
    reg  du_hwbkpt_ls_r;
    wire [16:0] esr;
    reg  sr_we;
    reg  [16:0] to_sr;
    reg  [16:0] sr;
    reg  [31:0] lsu_addr;
    wire abort_ex;
    reg  icpu_ack_i;
    reg  icpu_err_i;
    reg  dcpu_ack_i;
    reg  dcpu_err_i;
    reg  sig_fp;
    reg  fpcsr_fpee;
    wire dsx;
    reg  __obs;

    // Generated top module instance
    or1200_except _conc_top_inst(
            .clk       ( clk ),
            .rst       ( rst ),
            .sig_ibuserr( sig_ibuserr ),
            .sig_dbuserr( sig_dbuserr ),
            .sig_illegal( sig_illegal ),
            .sig_align ( sig_align ),
            .sig_range ( sig_range ),
            .sig_dtlbmiss( sig_dtlbmiss ),
            .sig_dmmufault( sig_dmmufault ),
            .sig_int   ( sig_int ),
            .sig_syscall( sig_syscall ),
            .sig_trap  ( sig_trap ),
            .sig_itlbmiss( sig_itlbmiss ),
            .sig_immufault( sig_immufault ),
            .sig_tick  ( sig_tick ),
            .ex_branch_taken( ex_branch_taken ),
            .genpc_freeze( genpc_freeze ),
            .id_freeze ( id_freeze ),
            .ex_freeze ( ex_freeze ),
            .wb_freeze ( wb_freeze ),
            .if_stall  ( if_stall ),
            .if_pc     ( if_pc ),
            .id_pc     ( id_pc ),
            .ex_pc     ( ex_pc ),
            .wb_pc     ( wb_pc ),
            .id_flushpipe( id_flushpipe ),
            .ex_flushpipe( ex_flushpipe ),
            .extend_flush( extend_flush ),
            .except_flushpipe( except_flushpipe ),
            .except_type( except_type ),
            .except_start( except_start ),
            .except_started( except_started ),
            .except_stop( except_stop ),
            .except_trig( except_trig ),
            .ex_void   ( ex_void ),
            .abort_mvspr( abort_mvspr ),
            .branch_op ( branch_op ),
            .spr_dat_ppc( spr_dat_ppc ),
            .spr_dat_npc( spr_dat_npc ),
            .datain    ( datain ),
            .du_dsr    ( du_dsr ),
            .epcr_we   ( epcr_we ),
            .eear_we   ( eear_we ),
            .esr_we    ( esr_we ),
            .pc_we     ( pc_we ),
            .epcr      ( epcr ),
            .eear      ( eear ),
            .du_dmr1   ( du_dmr1 ),
            .du_hwbkpt ( du_hwbkpt ),
            .du_hwbkpt_ls_r( du_hwbkpt_ls_r ),
            .esr       ( esr ),
            .sr_we     ( sr_we ),
            .to_sr     ( to_sr ),
            .sr        ( sr ),
            .lsu_addr  ( lsu_addr ),
            .abort_ex  ( abort_ex ),
            .icpu_ack_i( icpu_ack_i ),
            .icpu_err_i( icpu_err_i ),
            .dcpu_ack_i( dcpu_ack_i ),
            .dcpu_err_i( dcpu_err_i ),
            .sig_fp    ( sig_fp ),
            .fpcsr_fpee( fpcsr_fpee ),
            .dsx       ( dsx ),
            .__obs     ( __obs ));

    // Generated internal use signals
    reg  [31:0] _conc_pc;
    reg  [207:0] _conc_opcode;
    reg  [207:0] _conc_ram[0:15];


    // Generated clock pulse
    always begin
        #5 clk = ~clk;
    end

    // Generated program counter
    always @(posedge clk) begin
        _conc_pc <= #1 _conc_pc + 32'b1;
        _conc_opcode = _conc_ram[_conc_pc + 1];
        __obs <= #1 _conc_opcode[207];
        branch_op <= #1 _conc_opcode[56:54];
        datain <= #1 _conc_opcode[88:57];
        dcpu_ack_i <= #1 _conc_opcode[203];
        dcpu_err_i <= #1 _conc_opcode[204];
        du_dmr1 <= #1 _conc_opcode[131:107];
        du_dsr <= #1 _conc_opcode[102:89];
        du_hwbkpt <= #1 _conc_opcode[132];
        du_hwbkpt_ls_r <= #1 _conc_opcode[133];
        eear_we <= #1 _conc_opcode[104];
        epcr_we <= #1 _conc_opcode[103];
        esr_we <= #1 _conc_opcode[105];
        ex_branch_taken <= #1 _conc_opcode[13];
        ex_flushpipe <= #1 _conc_opcode[52];
        ex_freeze <= #1 _conc_opcode[16];
        ex_void <= #1 _conc_opcode[53];
        fpcsr_fpee <= #1 _conc_opcode[206];
        genpc_freeze <= #1 _conc_opcode[14];
        icpu_ack_i <= #1 _conc_opcode[201];
        icpu_err_i <= #1 _conc_opcode[202];
        id_flushpipe <= #1 _conc_opcode[51];
        id_freeze <= #1 _conc_opcode[15];
        if_pc <= #1 _conc_opcode[50:19];
        if_stall <= #1 _conc_opcode[18];
        lsu_addr <= #1 _conc_opcode[200:169];
        pc_we <= #1 _conc_opcode[106];
        sig_align <= #1 _conc_opcode[3];
        sig_dbuserr <= #1 _conc_opcode[1];
        sig_dmmufault <= #1 _conc_opcode[6];
        sig_dtlbmiss <= #1 _conc_opcode[5];
        sig_fp <= #1 _conc_opcode[205];
        sig_ibuserr <= #1 _conc_opcode[0];
        sig_illegal <= #1 _conc_opcode[2];
        sig_immufault <= #1 _conc_opcode[11];
        sig_int <= #1 _conc_opcode[7];
        sig_itlbmiss <= #1 _conc_opcode[10];
        sig_range <= #1 _conc_opcode[4];
        sig_syscall <= #1 _conc_opcode[8];
        sig_tick <= #1 _conc_opcode[12];
        sig_trap <= #1 _conc_opcode[9];
        sr <= #1 _conc_opcode[168:152];
        sr_we <= #1 _conc_opcode[134];
        to_sr <= #1 _conc_opcode[151:135];
        wb_freeze <= #1 _conc_opcode[17];
        $strobe(";_C %d", _conc_pc);
    end

    // Generated initial block
    initial begin
        clk = 1'b0;
        rst = 1'b0;
        _conc_pc = 32'b0;
        $readmemb("data.mem", _conc_ram);
        _conc_opcode = _conc_ram[0];
        __obs = _conc_opcode[207];
        branch_op = _conc_opcode[56:54];
        datain = _conc_opcode[88:57];
        dcpu_ack_i = _conc_opcode[203];
        dcpu_err_i = _conc_opcode[204];
        du_dmr1 = _conc_opcode[131:107];
        du_dsr = _conc_opcode[102:89];
        du_hwbkpt = _conc_opcode[132];
        du_hwbkpt_ls_r = _conc_opcode[133];
        eear_we = _conc_opcode[104];
        epcr_we = _conc_opcode[103];
        esr_we = _conc_opcode[105];
        ex_branch_taken = _conc_opcode[13];
        ex_flushpipe = _conc_opcode[52];
        ex_freeze = _conc_opcode[16];
        ex_void = _conc_opcode[53];
        fpcsr_fpee = _conc_opcode[206];
        genpc_freeze = _conc_opcode[14];
        icpu_ack_i = _conc_opcode[201];
        icpu_err_i = _conc_opcode[202];
        id_flushpipe = _conc_opcode[51];
        id_freeze = _conc_opcode[15];
        if_pc = _conc_opcode[50:19];
        if_stall = _conc_opcode[18];
        lsu_addr = _conc_opcode[200:169];
        pc_we = _conc_opcode[106];
        sig_align = _conc_opcode[3];
        sig_dbuserr = _conc_opcode[1];
        sig_dmmufault = _conc_opcode[6];
        sig_dtlbmiss = _conc_opcode[5];
        sig_fp = _conc_opcode[205];
        sig_ibuserr = _conc_opcode[0];
        sig_illegal = _conc_opcode[2];
        sig_immufault = _conc_opcode[11];
        sig_int = _conc_opcode[7];
        sig_itlbmiss = _conc_opcode[10];
        sig_range = _conc_opcode[4];
        sig_syscall = _conc_opcode[8];
        sig_tick = _conc_opcode[12];
        sig_trap = _conc_opcode[9];
        sr = _conc_opcode[168:152];
        sr_we = _conc_opcode[134];
        to_sr = _conc_opcode[151:135];
        wb_freeze = _conc_opcode[17];
        #2 clk = 1'b1;
        rst = 1'b1;
        #5 rst = 1'b0;
        #150 $finish;
    end

endmodule
