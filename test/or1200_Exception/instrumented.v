// Following code segment is generated from ./src/or1200_except.v:65
module or1200_except(clk, rst, sig_ibuserr, sig_dbuserr, sig_illegal, sig_align, sig_range, sig_dtlbmiss, sig_dmmufault, sig_int, sig_syscall, sig_trap, sig_itlbmiss, sig_immufault, sig_tick, ex_branch_taken, genpc_freeze, id_freeze, ex_freeze, wb_freeze, if_stall, if_pc, id_pc, ex_pc, wb_pc, id_flushpipe, ex_flushpipe, extend_flush, except_flushpipe, except_type, except_start, except_started, except_stop, except_trig, ex_void, abort_mvspr, branch_op, spr_dat_ppc, spr_dat_npc, datain, du_dsr, epcr_we, eear_we, esr_we, pc_we, epcr, eear, du_dmr1, du_hwbkpt, du_hwbkpt_ls_r, esr, sr_we, to_sr, sr, lsu_addr, abort_ex, icpu_ack_i, icpu_err_i, dcpu_ack_i, dcpu_err_i, sig_fp, fpcsr_fpee, dsx, __obs);
    input clk;
    input rst;
    input sig_ibuserr;
    input sig_dbuserr;
    input sig_illegal;
    input sig_align;
    input sig_range;
    input sig_dtlbmiss;
    input sig_dmmufault;
    input sig_int;
    input sig_syscall;
    input sig_trap;
    input sig_itlbmiss;
    input sig_immufault;
    input sig_tick;
    input ex_branch_taken;
    input genpc_freeze;
    input id_freeze;
    input ex_freeze;
    input wb_freeze;
    input if_stall;
    input [31:0] if_pc;
    output [31:0] id_pc;
    output [31:0] ex_pc;
    output [31:0] wb_pc;
    input id_flushpipe;
    input ex_flushpipe;
    output extend_flush;
    output except_flushpipe;
    output [3:0] except_type;
    output except_start;
    output except_started;
    output [13:0] except_stop;
    output [13:0] except_trig;
    input ex_void;
    output abort_mvspr;
    input [2:0] branch_op;
    output [31:0] spr_dat_ppc;
    output [31:0] spr_dat_npc;
    input [31:0] datain;
    input [13:0] du_dsr;
    input epcr_we;
    input eear_we;
    input esr_we;
    input pc_we;
    output [31:0] epcr;
    output [31:0] eear;
    input [24:0] du_dmr1;
    input du_hwbkpt;
    input du_hwbkpt_ls_r;
    output [16:0] esr;
    input sr_we;
    input [16:0] to_sr;
    input [16:0] sr;
    input [31:0] lsu_addr;
    output abort_ex;
    input icpu_ack_i;
    input icpu_err_i;
    input dcpu_ack_i;
    input dcpu_err_i;
    input sig_fp;
    input fpcsr_fpee;
    output dsx;
    input __obs;

    reg abort_ex = 1'b0;
    reg abort_mvspr = 1'b0;
    reg delayed1_ex_dslot = 1'b0;
    reg delayed2_ex_dslot = 1'b0;
    reg [2:0] delayed_iee = 3'b0;
    reg [2:0] delayed_tee = 3'b0;
    reg [31:0] dl_pc = 32'b0;
    reg dmr1_bt = 1'b0;
    reg dmr1_bt_prev = 1'b0;
    reg dmr1_st = 1'b0;
    reg dmr1_st_prev = 1'b0;
    reg dsr_te = 1'b0;
    reg dsr_te_prev = 1'b0;
    reg dsx = 1'b0;
    reg [31:0] eear = 32'b0;
    reg [31:0] epcr = 32'b0;
    reg [16:0] esr = 17'b0;
    reg ex_dslot = 1'b0;
    reg [2:0] ex_exceptflags = 3'b0;
    reg ex_freeze_prev = 1'b0;
    reg [31:0] ex_pc = 32'b0;
    reg ex_pc_val = 1'b0;
    reg except_flushpipe = 1'b0;
    reg except_start = 1'b0;
    reg except_started = 1'b0;
    reg [13:0] except_stop = 14'b0;
    reg [13:0] except_trig = 14'b0;
    reg [3:0] except_type = 4'b0;
    reg extend_flush = 1'b0;
    reg extend_flush_last = 1'b0;
    reg fp_pending = 1'b0;
    reg [2:0] id_exceptflags = 3'b0;
    reg [31:0] id_pc = 32'b0;
    reg id_pc_val = 1'b0;
    reg int_pending = 1'b0;
    reg range_pending = 1'b0;
    reg [31:0] spr_dat_npc = 32'b0;
    reg [31:0] spr_dat_ppc = 32'b0;
    reg sr_ted = 1'b0;
    reg sr_ted_prev = 1'b0;
    reg [2:0] state = 3'b0;
    reg tick_pending = 1'b0;
    reg trace_cond = 1'b0;
    reg trace_trap = 1'b0;
    reg [31:0] wb_pc = 32'b0;

    always @(*) begin
dsr_te = (ex_freeze_prev ? dsr_te_prev : du_dsr[13]); $display(";A 0");		//(assert (= @dsr_te    (ite (= #ex_freeze_prev  0b1) #dsr_te_prev  (bv-extract 13 13 #du_dsr )))) ;0 BL
    end
    always @(*) begin
sr_ted = (ex_freeze_prev ? sr_ted_prev : sr[16]); $display(";A 1");		//(assert (= @sr_ted    (ite (= #ex_freeze_prev  0b1) #sr_ted_prev  (bv-extract 16 16 #sr )))) ;1 BL
    end
    always @(*) begin
dmr1_st = (ex_freeze_prev ? dmr1_st_prev : du_dmr1[22]); $display(";A 2");		//(assert (= @dmr1_st    (ite (= #ex_freeze_prev  0b1) #dmr1_st_prev  (bv-extract 22 22 #du_dmr1 )))) ;2 BL
    end
    always @(*) begin
dmr1_bt = (ex_freeze_prev ? dmr1_bt_prev : du_dmr1[23]); $display(";A 3");		//(assert (= @dmr1_bt    (ite (= #ex_freeze_prev  0b1) #dmr1_bt_prev  (bv-extract 23 23 #du_dmr1 )))) ;3 BL
    end
    always @(*) begin
spr_dat_npc = (ex_void ? id_pc : ex_pc); $display(";A 4");		//(assert (= @spr_dat_npc    (ite (= #ex_void  0b1) #id_pc  #ex_pc ))) ;4 BL
    end
    always @(*) begin
except_trig = {(ex_exceptflags[1] & (~ du_dsr[9])), (ex_exceptflags[0] & (~ du_dsr[3])), (ex_exceptflags[2] & (~ du_dsr[1])), (sig_illegal & (~ du_dsr[6])), (sig_align & (~ du_dsr[5])), (sig_dtlbmiss & (~ du_dsr[8])), (sig_trap & (~ du_dsr[13])), ((sig_syscall & (~ du_dsr[11])) & (~ ex_freeze)), (sig_dmmufault & (~ du_dsr[2])), (sig_dbuserr & (~ du_dsr[1])), (range_pending & (~ du_dsr[10])), (fp_pending & (~ du_dsr[12])), (int_pending & (~ du_dsr[7])), (tick_pending & (~ du_dsr[4]))}; $display(";A 5");		//(assert (= @except_trig    (bv-concat (bv-and (bv-extract 1 1 #ex_exceptflags ) (bv-not (bv-extract 9 9 #du_dsr ))) (bv-and (bv-extract 0 0 #ex_exceptflags ) (bv-not (bv-extract 3 3 #du_dsr ))) (bv-and (bv-extract 2 2 #ex_exceptflags ) (bv-not (bv-extract 1 1 #du_dsr ))) (bv-and #sig_illegal  (bv-not (bv-extract 6 6 #du_dsr ))) (bv-and #sig_align  (bv-not (bv-extract 5 5 #du_dsr ))) (bv-and #sig_dtlbmiss  (bv-not (bv-extract 8 8 #du_dsr ))) (bv-and #sig_trap  (bv-not (bv-extract 13 13 #du_dsr ))) (bv-and (bv-and #sig_syscall  (bv-not (bv-extract 11 11 #du_dsr ))) (bv-not #ex_freeze )) (bv-and #sig_dmmufault  (bv-not (bv-extract 2 2 #du_dsr ))) (bv-and #sig_dbuserr  (bv-not (bv-extract 1 1 #du_dsr ))) (bv-and #range_pending  (bv-not (bv-extract 10 10 #du_dsr ))) (bv-and #fp_pending  (bv-not (bv-extract 12 12 #du_dsr ))) (bv-and #int_pending  (bv-not (bv-extract 7 7 #du_dsr ))) (bv-and #tick_pending  (bv-not (bv-extract 4 4 #du_dsr )))))) ;5 BL
    end
    always @(*) begin
except_stop = {(tick_pending & du_dsr[4]), (int_pending & du_dsr[7]), (ex_exceptflags[1] & du_dsr[9]), (ex_exceptflags[0] & du_dsr[3]), (ex_exceptflags[2] & du_dsr[1]), (sig_illegal & du_dsr[6]), (sig_align & du_dsr[5]), (sig_dtlbmiss & du_dsr[8]), (sig_dmmufault & du_dsr[2]), (sig_dbuserr & du_dsr[1]), (range_pending & du_dsr[10]), (sig_trap & du_dsr[13]), (fp_pending & du_dsr[12]), ((sig_syscall & du_dsr[11]) & (~ ex_freeze))}; $display(";A 6");		//(assert (= @except_stop    (bv-concat (bv-and #tick_pending  (bv-extract 4 4 #du_dsr )) (bv-and #int_pending  (bv-extract 7 7 #du_dsr )) (bv-and (bv-extract 1 1 #ex_exceptflags ) (bv-extract 9 9 #du_dsr )) (bv-and (bv-extract 0 0 #ex_exceptflags ) (bv-extract 3 3 #du_dsr )) (bv-and (bv-extract 2 2 #ex_exceptflags ) (bv-extract 1 1 #du_dsr )) (bv-and #sig_illegal  (bv-extract 6 6 #du_dsr )) (bv-and #sig_align  (bv-extract 5 5 #du_dsr )) (bv-and #sig_dtlbmiss  (bv-extract 8 8 #du_dsr )) (bv-and #sig_dmmufault  (bv-extract 2 2 #du_dsr )) (bv-and #sig_dbuserr  (bv-extract 1 1 #du_dsr )) (bv-and #range_pending  (bv-extract 10 10 #du_dsr )) (bv-and #sig_trap  (bv-extract 13 13 #du_dsr )) (bv-and #fp_pending  (bv-extract 12 12 #du_dsr )) (bv-and (bv-and #sig_syscall  (bv-extract 11 11 #du_dsr )) (bv-not #ex_freeze ))))) ;6 BL
    end
    always @(*) begin
except_started = (extend_flush & except_start); $display(";A 7");		//(assert (= @except_started    (bv-and #extend_flush  #except_start ))) ;7 BL
    end
    always @(*) begin
except_start = ((except_type != 4'b0000) & extend_flush); $display(";A 8");		//(assert (= @except_start    (bv-and (bv-not (bv-comp #except_type  0b0000)) #extend_flush ))) ;8 BL
    end
    always @(*) begin
int_pending = (((((((sig_int & (sr[2] | (sr_we & to_sr[2]))) & id_pc_val) & delayed_iee[2]) & (~ ex_freeze)) & (~ ex_branch_taken)) & (~ ex_dslot)) & (~ (sr_we & (~ to_sr[2])))); $display(";A 9");		//(assert (= @int_pending    (bv-and (bv-and (bv-and (bv-and (bv-and (bv-and (bv-and #sig_int  (bv-or (bv-extract 2 2 #sr ) (bv-and #sr_we  (bv-extract 2 2 #to_sr )))) #id_pc_val ) (bv-extract 2 2 #delayed_iee )) (bv-not #ex_freeze )) (bv-not #ex_branch_taken )) (bv-not #ex_dslot )) (bv-not (bv-and #sr_we  (bv-not (bv-extract 2 2 #to_sr ))))))) ;9 BL
    end
    always @(*) begin
tick_pending = (((((((sig_tick & (sr[1] | (sr_we & to_sr[1]))) & id_pc_val) & delayed_tee[2]) & (~ ex_freeze)) & (~ ex_branch_taken)) & (~ ex_dslot)) & (~ (sr_we & (~ to_sr[1])))); $display(";A 10");		//(assert (= @tick_pending    (bv-and (bv-and (bv-and (bv-and (bv-and (bv-and (bv-and #sig_tick  (bv-or (bv-extract 1 1 #sr ) (bv-and #sr_we  (bv-extract 1 1 #to_sr )))) #id_pc_val ) (bv-extract 2 2 #delayed_tee )) (bv-not #ex_freeze )) (bv-not #ex_branch_taken )) (bv-not #ex_dslot )) (bv-not (bv-and #sr_we  (bv-not (bv-extract 1 1 #to_sr ))))))) ;10 BL
    end
    always @(*) begin
fp_pending = ((((sig_fp & fpcsr_fpee) & (~ ex_freeze)) & (~ ex_branch_taken)) & (~ ex_dslot)); $display(";A 11");		//(assert (= @fp_pending    (bv-and (bv-and (bv-and (bv-and #sig_fp  #fpcsr_fpee ) (bv-not #ex_freeze )) (bv-not #ex_branch_taken )) (bv-not #ex_dslot )))) ;11 BL
    end
    always @(*) begin
range_pending = ((((sig_range & sr[12]) & (~ ex_freeze)) & (~ ex_branch_taken)) & (~ ex_dslot)); $display(";A 12");		//(assert (= @range_pending    (bv-and (bv-and (bv-and (bv-and #sig_range  (bv-extract 12 12 #sr )) (bv-not #ex_freeze )) (bv-not #ex_branch_taken )) (bv-not #ex_dslot )))) ;12 BL
    end
    always @(*) begin
abort_ex = (((((sig_dbuserr | sig_dmmufault) | sig_dtlbmiss) | sig_align) | sig_illegal) | ((((du_hwbkpt | trace_trap) & ex_pc_val) & (~|sr_ted)) & (~|dsr_te))); $display(";A 13");		//(assert (= @abort_ex    (bv-or (bv-or (bv-or (bv-or (bv-or #sig_dbuserr  #sig_dmmufault ) #sig_dtlbmiss ) #sig_align ) #sig_illegal ) (bv-and (bv-and (bv-and (bv-or #du_hwbkpt  #trace_trap ) #ex_pc_val ) (bv-not (bv-redor #sr_ted ))) (bv-not (bv-redor #dsr_te )))))) ;13 BL
    end
    always @(*) begin
abort_mvspr = (sig_illegal | ((((du_hwbkpt | trace_trap) & ex_pc_val) & (~|sr_ted)) & (~|dsr_te))); $display(";A 14");		//(assert (= @abort_mvspr    (bv-or #sig_illegal  (bv-and (bv-and (bv-and (bv-or #du_hwbkpt  #trace_trap ) #ex_pc_val ) (bv-not (bv-redor #sr_ted ))) (bv-not (bv-redor #dsr_te )))))) ;14 BL
    end
    always @(*) begin
spr_dat_ppc = wb_pc; $display(";A 15");		//(assert (= @spr_dat_ppc    #wb_pc )) ;15 BL
    end
    always @(*) begin
trace_cond = (((~|ex_freeze) & (~|ex_void)) & ((1'b0 | dmr1_st) | (((branch_op != 3'b000) & (branch_op != 3'b110)) & dmr1_bt))); $display(";A 16");		//(assert (= @trace_cond    (bv-and (bv-and (bv-not (bv-redor #ex_freeze )) (bv-not (bv-redor #ex_void ))) (bv-or (bv-or 0b0 #dmr1_st ) (bv-and (bv-and (bv-not (bv-comp #branch_op  0b000)) (bv-not (bv-comp #branch_op  0b110))) #dmr1_bt ))))) ;16 BL
    end
    always @(*) begin
except_flushpipe = ((|except_trig) & (~|state)); $display(";A 17");		//(assert (= @except_flushpipe    (bv-and (bv-redor #except_trig ) (bv-not (bv-redor #state ))))) ;17 BL
    end
    // Following code segment is generated from ./src/or1200_except.v:278
    always @(posedge rst or posedge clk) begin
        if ((rst == 1'b1)) begin
            trace_trap <= #1 1'b0; $display(";A 20");		//(assert (= @trace_trap    0b0)) ;20 NB
        end
        else begin
            if ((!(trace_trap && (!ex_pc_val)))) begin
                $display(";A 21");		//(assert (= (bv-not (bv-redor (bv-and #trace_trap  (bv-not (bv-redor #ex_pc_val )))))   0b1)) ;21 BR
                trace_trap <= #1 ((trace_cond & (!dsr_te)) & (!sr_ted)); $display(";A 23");		//(assert (= @trace_trap    (bv-and (bv-and #trace_cond  (bv-not (bv-redor #dsr_te ))) (bv-not (bv-redor #sr_ted ))))) ;23 NB
            end
            else begin
                $display(";A 22");		//(assert (= (bv-not (bv-redor (bv-and #trace_trap  (bv-not (bv-redor #ex_pc_val )))))   0b0)) ;22 BR
            end
        end
    end

    // Following code segment is generated from ./src/or1200_except.v:287
    always @(posedge rst or posedge clk) begin
        if ((rst == 1'b1)) begin
            ex_freeze_prev <= #1 1'b0; $display(";A 26");		//(assert (= @ex_freeze_prev    0b0)) ;26 NB
            sr_ted_prev <= #1 1'b0; $display(";A 27");		//(assert (= @sr_ted_prev    0b0)) ;27 NB
            dsr_te_prev <= #1 1'b0; $display(";A 28");		//(assert (= @dsr_te_prev    0b0)) ;28 NB
            dmr1_st_prev <= #1 1'b0; $display(";A 29");		//(assert (= @dmr1_st_prev    0b0)) ;29 NB
            dmr1_bt_prev <= #1 1'b0; $display(";A 30");		//(assert (= @dmr1_bt_prev    0b0)) ;30 NB
        end
        else begin
            ex_freeze_prev <= #1 ex_freeze; $display(";A 31");		//(assert (= @ex_freeze_prev    #ex_freeze )) ;31 NB
            if (((!ex_freeze_prev) || ex_void)) begin
                $display(";A 32");		//(assert (= (bv-or (bv-not (bv-redor #ex_freeze_prev )) #ex_void )   0b1)) ;32 BR
                sr_ted_prev <= #1 sr[16]; $display(";A 34");		//(assert (= @sr_ted_prev    (bv-extract 16 16 #sr ))) ;34 NB
                dsr_te_prev <= #1 du_dsr[13]; $display(";A 35");		//(assert (= @dsr_te_prev    (bv-extract 13 13 #du_dsr ))) ;35 NB
                dmr1_st_prev <= #1 du_dmr1[22]; $display(";A 36");		//(assert (= @dmr1_st_prev    (bv-extract 22 22 #du_dmr1 ))) ;36 NB
                dmr1_bt_prev <= #1 du_dmr1[23]; $display(";A 37");		//(assert (= @dmr1_bt_prev    (bv-extract 23 23 #du_dmr1 ))) ;37 NB
            end
            else begin
                $display(";A 33");		//(assert (= (bv-or (bv-not (bv-redor #ex_freeze_prev )) #ex_void )   0b0)) ;33 BR
            end
        end
    end

    // Following code segment is generated from ./src/or1200_except.v:344
    always @(posedge rst or posedge clk) begin
        if ((rst == 1'b1)) begin
            id_pc <= #1 32'b00000000000000000000000000000000; $display(";A 40");		//(assert (= @id_pc    0b00000000000000000000000000000000)) ;40 NB
            id_pc_val <= #1 1'b0; $display(";A 41");		//(assert (= @id_pc_val    0b0)) ;41 NB
            id_exceptflags <= #1 3'b000; $display(";A 42");		//(assert (= @id_exceptflags    0b000)) ;42 NB
        end
        else begin
            if (id_flushpipe) begin
                $display(";A 43");		//(assert (= #id_flushpipe    0b1)) ;43 BR
                id_pc_val <= #1 1'b0; $display(";A 45");		//(assert (= @id_pc_val    0b0)) ;45 NB
                id_exceptflags <= #1 3'b000; $display(";A 46");		//(assert (= @id_exceptflags    0b000)) ;46 NB
            end
            else begin
                $display(";A 44");		//(assert (= #id_flushpipe    0b0)) ;44 BR
                if ((!id_freeze)) begin
                    $display(";A 47");		//(assert (= (bv-not (bv-redor #id_freeze ))   0b1)) ;47 BR
                    id_pc <= #1 if_pc; $display(";A 49");		//(assert (= @id_pc    #if_pc )) ;49 NB
                    id_pc_val <= #1 1'b1; $display(";A 50");		//(assert (= @id_pc_val    0b1)) ;50 NB
                    id_exceptflags <= #1 {sig_ibuserr, sig_itlbmiss, sig_immufault}; $display(";A 51");		//(assert (= @id_exceptflags    (bv-concat #sig_ibuserr  #sig_itlbmiss  #sig_immufault ))) ;51 NB
                end
                else begin
                    $display(";A 48");		//(assert (= (bv-not (bv-redor #id_freeze ))   0b0)) ;48 BR
                end
            end
        end
    end

    // Following code segment is generated from ./src/or1200_except.v:369
    always @(posedge clk or posedge rst) begin
        if ((rst == 1'b1)) begin
            delayed_iee <= #1 3'b000; $display(";A 54");		//(assert (= @delayed_iee    0b000)) ;54 NB
        end
        else begin
            if ((!sr[2])) begin
                $display(";A 55");		//(assert (= (bv-not (bv-redor (bv-extract 2 2 #sr )))   0b1)) ;55 BR
                delayed_iee <= #1 3'b000; $display(";A 57");		//(assert (= @delayed_iee    0b000)) ;57 NB
            end
            else begin
                $display(";A 56");		//(assert (= (bv-not (bv-redor (bv-extract 2 2 #sr )))   0b0)) ;56 BR
                delayed_iee <= #1 {delayed_iee[1:0], 1'b1}; $display(";A 58");		//(assert (= @delayed_iee    (bv-concat (bv-extract 1 0 #delayed_iee ) 0b1))) ;58 NB
            end
        end
    end

    // Following code segment is generated from ./src/or1200_except.v:385
    always @(posedge clk or posedge rst) begin
        if ((rst == 1'b1)) begin
            delayed_tee <= #1 3'b000; $display(";A 61");		//(assert (= @delayed_tee    0b000)) ;61 NB
        end
        else begin
            if ((!sr[1])) begin
                $display(";A 62");		//(assert (= (bv-not (bv-redor (bv-extract 1 1 #sr )))   0b1)) ;62 BR
                delayed_tee <= #1 3'b000; $display(";A 64");		//(assert (= @delayed_tee    0b000)) ;64 NB
            end
            else begin
                $display(";A 63");		//(assert (= (bv-not (bv-redor (bv-extract 1 1 #sr )))   0b0)) ;63 BR
                delayed_tee <= #1 {delayed_tee[1:0], 1'b1}; $display(";A 65");		//(assert (= @delayed_tee    (bv-concat (bv-extract 1 0 #delayed_tee ) 0b1))) ;65 NB
            end
        end
    end

    // Following code segment is generated from ./src/or1200_except.v:396
    always @(posedge rst or posedge clk) begin
        if ((rst == 1'b1)) begin
            ex_dslot <= #1 1'b0; $display(";A 68");		//(assert (= @ex_dslot    0b0)) ;68 NB
            ex_pc <= #1 32'b00000000000000000000000000000000; $display(";A 69");		//(assert (= @ex_pc    0b00000000000000000000000000000000)) ;69 NB
            ex_pc_val <= #1 1'b0; $display(";A 70");		//(assert (= @ex_pc_val    0b0)) ;70 NB
            ex_exceptflags <= #1 3'b000; $display(";A 71");		//(assert (= @ex_exceptflags    0b000)) ;71 NB
            delayed1_ex_dslot <= #1 1'b0; $display(";A 72");		//(assert (= @delayed1_ex_dslot    0b0)) ;72 NB
            delayed2_ex_dslot <= #1 1'b0; $display(";A 73");		//(assert (= @delayed2_ex_dslot    0b0)) ;73 NB
        end
        else begin
            if (ex_flushpipe) begin
                $display(";A 74");		//(assert (= #ex_flushpipe    0b1)) ;74 BR
                ex_dslot <= #1 1'b0; $display(";A 76");		//(assert (= @ex_dslot    0b0)) ;76 NB
                ex_pc_val <= #1 1'b0; $display(";A 77");		//(assert (= @ex_pc_val    0b0)) ;77 NB
                ex_exceptflags <= #1 3'b000; $display(";A 78");		//(assert (= @ex_exceptflags    0b000)) ;78 NB
                delayed1_ex_dslot <= #1 1'b0; $display(";A 79");		//(assert (= @delayed1_ex_dslot    0b0)) ;79 NB
                delayed2_ex_dslot <= #1 1'b0; $display(";A 80");		//(assert (= @delayed2_ex_dslot    0b0)) ;80 NB
            end
            else begin
                $display(";A 75");		//(assert (= #ex_flushpipe    0b0)) ;75 BR
                if (((!ex_freeze) & id_freeze)) begin
                    $display(";A 81");		//(assert (= (bv-and (bv-not (bv-redor #ex_freeze )) #id_freeze )   0b1)) ;81 BR
                    ex_dslot <= #1 1'b0; $display(";A 83");		//(assert (= @ex_dslot    0b0)) ;83 NB
                    ex_pc <= #1 id_pc; $display(";A 84");		//(assert (= @ex_pc    #id_pc )) ;84 NB
                    ex_pc_val <= #1 id_pc_val; $display(";A 85");		//(assert (= @ex_pc_val    #id_pc_val )) ;85 NB
                    ex_exceptflags <= #1 3'b000; $display(";A 86");		//(assert (= @ex_exceptflags    0b000)) ;86 NB
                    delayed1_ex_dslot <= #1 ex_dslot; $display(";A 87");		//(assert (= @delayed1_ex_dslot    #ex_dslot )) ;87 NB
                    delayed2_ex_dslot <= #1 delayed1_ex_dslot; $display(";A 88");		//(assert (= @delayed2_ex_dslot    #delayed1_ex_dslot )) ;88 NB
                end
                else begin
                    $display(";A 82");		//(assert (= (bv-and (bv-not (bv-redor #ex_freeze )) #id_freeze )   0b0)) ;82 BR
                    if ((!ex_freeze)) begin
                        $display(";A 89");		//(assert (= (bv-not (bv-redor #ex_freeze ))   0b1)) ;89 BR
                        ex_dslot <= #1 ex_branch_taken; $display(";A 91");		//(assert (= @ex_dslot    #ex_branch_taken )) ;91 NB
                        ex_pc <= #1 id_pc; $display(";A 92");		//(assert (= @ex_pc    #id_pc )) ;92 NB
                        ex_pc_val <= #1 id_pc_val; $display(";A 93");		//(assert (= @ex_pc_val    #id_pc_val )) ;93 NB
                        ex_exceptflags <= #1 id_exceptflags; $display(";A 94");		//(assert (= @ex_exceptflags    #id_exceptflags )) ;94 NB
                        delayed1_ex_dslot <= #1 ex_dslot; $display(";A 95");		//(assert (= @delayed1_ex_dslot    #ex_dslot )) ;95 NB
                        delayed2_ex_dslot <= #1 delayed1_ex_dslot; $display(";A 96");		//(assert (= @delayed2_ex_dslot    #delayed1_ex_dslot )) ;96 NB
                    end
                    else begin
                        $display(";A 90");		//(assert (= (bv-not (bv-redor #ex_freeze ))   0b0)) ;90 BR
                    end
                end
            end
        end
    end

    // Following code segment is generated from ./src/or1200_except.v:433
    always @(posedge rst or posedge clk) begin
        if ((rst == 1'b1)) begin
            wb_pc <= #1 32'b00000000000000000000000000000000; $display(";A 99");		//(assert (= @wb_pc    0b00000000000000000000000000000000)) ;99 NB
            dl_pc <= #1 32'b00000000000000000000000000000000; $display(";A 100");		//(assert (= @dl_pc    0b00000000000000000000000000000000)) ;100 NB
        end
        else begin
            if ((!wb_freeze)) begin
                $display(";A 101");		//(assert (= (bv-not (bv-redor #wb_freeze ))   0b1)) ;101 BR
                wb_pc <= #1 ex_pc; $display(";A 103");		//(assert (= @wb_pc    #ex_pc )) ;103 NB
                dl_pc <= #1 wb_pc; $display(";A 104");		//(assert (= @dl_pc    #wb_pc )) ;104 NB
            end
            else begin
                $display(";A 102");		//(assert (= (bv-not (bv-redor #wb_freeze ))   0b0)) ;102 BR
            end
        end
    end

    // Following code segment is generated from ./src/or1200_except.v:457
    always @(posedge rst or posedge clk) begin
        if ((rst == 1'b1)) begin
            state <= #1 3'b000; $display(";A 107");		//(assert (= @state    0b000)) ;107 NB
            except_type <= #1 4'b0000; $display(";A 108");		//(assert (= @except_type    0b0000)) ;108 NB
            extend_flush <= #1 1'b0; $display(";A 109");		//(assert (= @extend_flush    0b0)) ;109 NB
            epcr <= #1 32'b00000000000000000000000000000000; $display(";A 110");		//(assert (= @epcr    0b00000000000000000000000000000000)) ;110 NB
            eear <= #1 32'b00000000000000000000000000000000; $display(";A 111");		//(assert (= @eear    0b00000000000000000000000000000000)) ;111 NB
            esr <= #1 17'b01000000000000001; $display(";A 112");		//(assert (= @esr    0b01000000000000001)) ;112 NB
            extend_flush_last <= #1 1'b0; $display(";A 113");		//(assert (= @extend_flush_last    0b0)) ;113 NB
            dsx <= #1 1'b0; $display(";A 114");		//(assert (= @dsx    0b0)) ;114 NB
        end
        else begin
            case (state)
                3'b000 :
                    begin
                        $display(";A 115");		//(assert (= #state    0b000)) ;115 CS
                        if (except_flushpipe) begin
                            $display(";A 116");		//(assert (= #except_flushpipe    0b1)) ;116 BR
                            state <= #1 3'b001; $display(";A 118");		//(assert (= @state    0b001)) ;118 NB
                            extend_flush <= #1 1'b1; $display(";A 119");		//(assert (= @extend_flush    0b1)) ;119 NB
                            esr <= #1 (sr_we ? to_sr : sr); $display(";A 120");		//(assert (= @esr    (ite (= #sr_we  0b1) #to_sr  #sr ))) ;120 NB
                            casez (except_trig)
                                14'b10000000000000 :
                                    begin
                                        $display(";A 121");		//(assert (= #except_trig    0b10000000000000)) ;121 CS
                                        except_type <= #1 4'b1010; $display(";A 122");		//(assert (= @except_type    0b1010)) ;122 NB
                                        eear <= #1 (ex_dslot ? ex_pc : ex_pc); $display(";A 123");		//(assert (= @eear    (ite (= #ex_dslot  0b1) #ex_pc  #ex_pc ))) ;123 NB
                                        epcr <= #1 (ex_dslot ? wb_pc : ex_pc); $display(";A 124");		//(assert (= @epcr    (ite (= #ex_dslot  0b1) #wb_pc  #ex_pc ))) ;124 NB
                                        dsx <= #1 ex_dslot; $display(";A 125");		//(assert (= @dsx    #ex_dslot )) ;125 NB
                                    end
                                14'b01000000000000 :
                                    begin
                                        $display(";A 126");		//(assert (= #except_trig    0b01000000000000)) ;126 CS
                                        except_type <= #1 4'b0100; $display(";A 127");		//(assert (= @except_type    0b0100)) ;127 NB
                                        eear <= #1 (ex_dslot ? ex_pc : (delayed1_ex_dslot ? id_pc : (delayed2_ex_dslot ? id_pc : id_pc))); $display(";A 128");		//(assert (= @eear    (ite (= #ex_dslot  0b1) #ex_pc  (ite (= #delayed1_ex_dslot  0b1) #id_pc  (ite (= #delayed2_ex_dslot  0b1) #id_pc  #id_pc ))))) ;128 NB
                                        epcr <= #1 (ex_dslot ? wb_pc : (delayed1_ex_dslot ? id_pc : (delayed2_ex_dslot ? id_pc : id_pc))); $display(";A 129");		//(assert (= @epcr    (ite (= #ex_dslot  0b1) #wb_pc  (ite (= #delayed1_ex_dslot  0b1) #id_pc  (ite (= #delayed2_ex_dslot  0b1) #id_pc  #id_pc ))))) ;129 NB
                                        dsx <= #1 ex_dslot; $display(";A 130");		//(assert (= @dsx    #ex_dslot )) ;130 NB
                                    end
                                14'b00100000000000 :
                                    begin
                                        $display(";A 131");		//(assert (= #except_trig    0b00100000000000)) ;131 CS
                                        except_type <= #1 4'b0010; $display(";A 132");		//(assert (= @except_type    0b0010)) ;132 NB
                                        eear <= #1 (ex_dslot ? wb_pc : ex_pc); $display(";A 133");		//(assert (= @eear    (ite (= #ex_dslot  0b1) #wb_pc  #ex_pc ))) ;133 NB
                                        epcr <= #1 (ex_dslot ? wb_pc : ex_pc); $display(";A 134");		//(assert (= @epcr    (ite (= #ex_dslot  0b1) #wb_pc  #ex_pc ))) ;134 NB
                                        dsx <= #1 ex_dslot; $display(";A 135");		//(assert (= @dsx    #ex_dslot )) ;135 NB
                                    end
                                14'b00010000000000 :
                                    begin
                                        $display(";A 136");		//(assert (= #except_trig    0b00010000000000)) ;136 CS
                                        except_type <= #1 4'b0111; $display(";A 137");		//(assert (= @except_type    0b0111)) ;137 NB
                                        eear <= #1 ex_pc; $display(";A 138");		//(assert (= @eear    #ex_pc )) ;138 NB
                                        epcr <= #1 (ex_dslot ? wb_pc : ex_pc); $display(";A 139");		//(assert (= @epcr    (ite (= #ex_dslot  0b1) #wb_pc  #ex_pc ))) ;139 NB
                                        dsx <= #1 ex_dslot; $display(";A 140");		//(assert (= @dsx    #ex_dslot )) ;140 NB
                                    end
                                14'b00001000000000 :
                                    begin
                                        $display(";A 141");		//(assert (= #except_trig    0b00001000000000)) ;141 CS
                                        except_type <= #1 4'b0110; $display(";A 142");		//(assert (= @except_type    0b0110)) ;142 NB
                                        eear <= #1 lsu_addr; $display(";A 143");		//(assert (= @eear    #lsu_addr )) ;143 NB
                                        epcr <= #1 (ex_dslot ? wb_pc : ex_pc); $display(";A 144");		//(assert (= @epcr    (ite (= #ex_dslot  0b1) #wb_pc  #ex_pc ))) ;144 NB
                                        dsx <= #1 ex_dslot; $display(";A 145");		//(assert (= @dsx    #ex_dslot )) ;145 NB
                                    end
                                14'b00000100000000 :
                                    begin
                                        $display(";A 146");		//(assert (= #except_trig    0b00000100000000)) ;146 CS
                                        except_type <= #1 4'b1001; $display(";A 147");		//(assert (= @except_type    0b1001)) ;147 NB
                                        eear <= #1 lsu_addr; $display(";A 148");		//(assert (= @eear    #lsu_addr )) ;148 NB
                                        epcr <= #1 (ex_dslot ? wb_pc : (delayed1_ex_dslot ? dl_pc : ex_pc)); $display(";A 149");		//(assert (= @epcr    (ite (= #ex_dslot  0b1) #wb_pc  (ite (= #delayed1_ex_dslot  0b1) #dl_pc  #ex_pc )))) ;149 NB
                                        dsx <= #1 ex_dslot; $display(";A 150");		//(assert (= @dsx    #ex_dslot )) ;150 NB
                                    end
                                14'b00000010000000 :
                                    begin
                                        $display(";A 151");		//(assert (= #except_trig    0b00000010000000)) ;151 CS
                                        except_type <= #1 4'b1110; $display(";A 152");		//(assert (= @except_type    0b1110)) ;152 NB
                                        epcr <= #1 (ex_dslot ? wb_pc : (delayed1_ex_dslot ? id_pc : ex_pc)); $display(";A 153");		//(assert (= @epcr    (ite (= #ex_dslot  0b1) #wb_pc  (ite (= #delayed1_ex_dslot  0b1) #id_pc  #ex_pc )))) ;153 NB
                                        dsx <= #1 ex_dslot; $display(";A 154");		//(assert (= @dsx    #ex_dslot )) ;154 NB
                                    end
                                14'b00000001000000 :
                                    begin
                                        $display(";A 155");		//(assert (= #except_trig    0b00000001000000)) ;155 CS
                                        except_type <= #1 4'b1100; $display(";A 156");		//(assert (= @except_type    0b1100)) ;156 NB
                                        epcr <= #1 (ex_dslot ? wb_pc : (delayed1_ex_dslot ? id_pc : (delayed2_ex_dslot ? id_pc : id_pc))); $display(";A 157");		//(assert (= @epcr    (ite (= #ex_dslot  0b1) #wb_pc  (ite (= #delayed1_ex_dslot  0b1) #id_pc  (ite (= #delayed2_ex_dslot  0b1) #id_pc  #id_pc ))))) ;157 NB
                                        dsx <= #1 ex_dslot; $display(";A 158");		//(assert (= @dsx    #ex_dslot )) ;158 NB
                                    end
                                14'b00000000100000 :
                                    begin
                                        $display(";A 159");		//(assert (= #except_trig    0b00000000100000)) ;159 CS
                                        except_type <= #1 4'b0011; $display(";A 160");		//(assert (= @except_type    0b0011)) ;160 NB
                                        eear <= #1 lsu_addr; $display(";A 161");		//(assert (= @eear    #lsu_addr )) ;161 NB
                                        epcr <= #1 (ex_dslot ? wb_pc : (delayed1_ex_dslot ? dl_pc : ex_pc)); $display(";A 162");		//(assert (= @epcr    (ite (= #ex_dslot  0b1) #wb_pc  (ite (= #delayed1_ex_dslot  0b1) #dl_pc  #ex_pc )))) ;162 NB
                                        dsx <= #1 ex_dslot; $display(";A 163");		//(assert (= @dsx    #ex_dslot )) ;163 NB
                                    end
                                14'b00000000010000 :
                                    begin
                                        $display(";A 164");		//(assert (= #except_trig    0b00000000010000)) ;164 CS
                                        except_type <= #1 4'b0010; $display(";A 165");		//(assert (= @except_type    0b0010)) ;165 NB
                                        eear <= #1 lsu_addr; $display(";A 166");		//(assert (= @eear    #lsu_addr )) ;166 NB
                                        epcr <= #1 (ex_dslot ? wb_pc : (delayed1_ex_dslot ? dl_pc : ex_pc)); $display(";A 167");		//(assert (= @epcr    (ite (= #ex_dslot  0b1) #wb_pc  (ite (= #delayed1_ex_dslot  0b1) #dl_pc  #ex_pc )))) ;167 NB
                                        dsx <= #1 ex_dslot; $display(";A 168");		//(assert (= @dsx    #ex_dslot )) ;168 NB
                                    end
                                14'b00000000001000 :
                                    begin
                                        $display(";A 169");		//(assert (= #except_trig    0b00000000001000)) ;169 CS
                                        except_type <= #1 4'b1011; $display(";A 170");		//(assert (= @except_type    0b1011)) ;170 NB
                                        epcr <= #1 (ex_dslot ? wb_pc : (delayed1_ex_dslot ? dl_pc : (delayed2_ex_dslot ? id_pc : ex_pc))); $display(";A 171");		//(assert (= @epcr    (ite (= #ex_dslot  0b1) #wb_pc  (ite (= #delayed1_ex_dslot  0b1) #dl_pc  (ite (= #delayed2_ex_dslot  0b1) #id_pc  #ex_pc ))))) ;171 NB
                                        dsx <= #1 ex_dslot; $display(";A 172");		//(assert (= @dsx    #ex_dslot )) ;172 NB
                                    end
                                14'b00000000000100 :
                                    begin
                                        $display(";A 173");		//(assert (= #except_trig    0b00000000000100)) ;173 CS
                                        except_type <= #1 4'b1101; $display(";A 174");		//(assert (= @except_type    0b1101)) ;174 NB
                                        epcr <= #1 id_pc; $display(";A 175");		//(assert (= @epcr    #id_pc )) ;175 NB
                                        dsx <= #1 ex_dslot; $display(";A 176");		//(assert (= @dsx    #ex_dslot )) ;176 NB
                                    end
                                14'b00000000000010 :
                                    begin
                                        $display(";A 177");		//(assert (= #except_trig    0b00000000000010)) ;177 CS
                                        except_type <= #1 4'b1000; $display(";A 178");		//(assert (= @except_type    0b1000)) ;178 NB
                                        epcr <= #1 id_pc; $display(";A 179");		//(assert (= @epcr    #id_pc )) ;179 NB
                                        dsx <= #1 ex_dslot; $display(";A 180");		//(assert (= @dsx    #ex_dslot )) ;180 NB
                                    end
                                14'b00000000000001 :
                                    begin
                                        $display(";A 181");		//(assert (= #except_trig    0b00000000000001)) ;181 CS
                                        except_type <= #1 4'b0101; $display(";A 182");		//(assert (= @except_type    0b0101)) ;182 NB
                                        epcr <= #1 id_pc; $display(";A 183");		//(assert (= @epcr    #id_pc )) ;183 NB
                                        dsx <= #1 ex_dslot; $display(";A 184");		//(assert (= @dsx    #ex_dslot )) ;184 NB
                                    end
                                default:
                                    begin
                                        $display(";A 185");		//(assert (= (and (/= #except_trig  0b10000000000000) (/= #except_trig  0b01000000000000) (/= #except_trig  0b00100000000000) (/= #except_trig  0b00010000000000) (/= #except_trig  0b00001000000000) (/= #except_trig  0b00000100000000) (/= #except_trig  0b00000010000000) (/= #except_trig  0b00000001000000) (/= #except_trig  0b00000000100000) (/= #except_trig  0b00000000010000) (/= #except_trig  0b00000000001000) (/= #except_trig  0b00000000000100) (/= #except_trig  0b00000000000010) (/= #except_trig  0b00000000000001))   true)) ;185 CS
                                        except_type <= #1 4'b0000; $display(";A 186");		//(assert (= @except_type    0b0000)) ;186 NB
                                    end
                            endcase
                        end
                        else begin
                            $display(";A 117");		//(assert (= #except_flushpipe    0b0)) ;117 BR
                            if (pc_we) begin
                                $display(";A 187");		//(assert (= #pc_we    0b1)) ;187 BR
                                state <= #1 3'b001; $display(";A 189");		//(assert (= @state    0b001)) ;189 NB
                                extend_flush <= #1 1'b1; $display(";A 190");		//(assert (= @extend_flush    0b1)) ;190 NB
                            end
                            else begin
                                $display(";A 188");		//(assert (= #pc_we    0b0)) ;188 BR
                                if (epcr_we) begin
                                    $display(";A 191");		//(assert (= #epcr_we    0b1)) ;191 BR
                                    epcr <= #1 datain; $display(";A 193");		//(assert (= @epcr    #datain )) ;193 NB
                                end
                                else begin
                                    $display(";A 192");		//(assert (= #epcr_we    0b0)) ;192 BR
                                end
                                if (eear_we) begin
                                    $display(";A 194");		//(assert (= #eear_we    0b1)) ;194 BR
                                    eear <= #1 datain; $display(";A 196");		//(assert (= @eear    #datain )) ;196 NB
                                end
                                else begin
                                    $display(";A 195");		//(assert (= #eear_we    0b0)) ;195 BR
                                end
                                if (esr_we) begin
                                    $display(";A 197");		//(assert (= #esr_we    0b1)) ;197 BR
                                    esr <= #1 {datain[16], 1'b1, datain[14:0]}; $display(";A 199");		//(assert (= @esr    (bv-concat (bv-extract 16 16 #datain ) 0b1 (bv-extract 14 0 #datain )))) ;199 NB
                                end
                                else begin
                                    $display(";A 198");		//(assert (= #esr_we    0b0)) ;198 BR
                                end
                            end
                        end
                    end
                3'b001 :
                    begin
                        $display(";A 200");		//(assert (= #state    0b001)) ;200 CS
                        if (((icpu_ack_i | icpu_err_i) | genpc_freeze)) begin
                            $display(";A 201");		//(assert (= (bv-or (bv-or #icpu_ack_i  #icpu_err_i ) #genpc_freeze )   0b1)) ;201 BR
                            state <= #1 3'b010; $display(";A 203");		//(assert (= @state    0b010)) ;203 NB
                        end
                        else begin
                            $display(";A 202");		//(assert (= (bv-or (bv-or #icpu_ack_i  #icpu_err_i ) #genpc_freeze )   0b0)) ;202 BR
                        end
                    end
                3'b010 :
                    begin
                        $display(";A 204");		//(assert (= #state    0b010)) ;204 CS
                        if ((except_type == 4'b1110)) begin
                            $display(";A 205");		//(assert (= (bv-comp #except_type  0b1110)   0b1)) ;205 BR
                            state <= #1 3'b000; $display(";A 207");		//(assert (= @state    0b000)) ;207 NB
                            extend_flush <= #1 1'b0; $display(";A 208");		//(assert (= @extend_flush    0b0)) ;208 NB
                            extend_flush_last <= #1 1'b0; $display(";A 209");		//(assert (= @extend_flush_last    0b0)) ;209 NB
                            except_type <= #1 4'b0000; $display(";A 210");		//(assert (= @except_type    0b0000)) ;210 NB
                        end
                        else begin
                            $display(";A 206");		//(assert (= (bv-comp #except_type  0b1110)   0b0)) ;206 BR
                            state <= #1 3'b011; $display(";A 211");		//(assert (= @state    0b011)) ;211 NB
                        end
                    end
                3'b011 :
                    begin
                        $display(";A 212");		//(assert (= #state    0b011)) ;212 CS
                        state <= #1 3'b100; $display(";A 213");		//(assert (= @state    0b100)) ;213 NB
                    end
                3'b100 :
                    begin
                        $display(";A 214");		//(assert (= #state    0b100)) ;214 CS
                        state <= #1 3'b101; $display(";A 215");		//(assert (= @state    0b101)) ;215 NB
                        extend_flush <= #1 1'b0; $display(";A 216");		//(assert (= @extend_flush    0b0)) ;216 NB
                        extend_flush_last <= #1 1'b0; $display(";A 217");		//(assert (= @extend_flush_last    0b0)) ;217 NB
                    end
                default:
                    begin
                        $display(";A 218");		//(assert (= (and (/= #state  0b000) (/= #state  0b001) (/= #state  0b010) (/= #state  0b011) (/= #state  0b100))   true)) ;218 CS
                        if (((!if_stall) && (!id_freeze))) begin
                            $display(";A 219");		//(assert (= (bv-and (bv-not (bv-redor #if_stall )) (bv-not (bv-redor #id_freeze )))   0b1)) ;219 BR
                            state <= #1 3'b000; $display(";A 221");		//(assert (= @state    0b000)) ;221 NB
                            except_type <= #1 4'b0000; $display(";A 222");		//(assert (= @except_type    0b0000)) ;222 NB
                            extend_flush_last <= #1 1'b0; $display(";A 223");		//(assert (= @extend_flush_last    0b0)) ;223 NB
                        end
                        else begin
                            $display(";A 220");		//(assert (= (bv-and (bv-not (bv-redor #if_stall )) (bv-not (bv-redor #id_freeze )))   0b0)) ;220 BR
                        end
                    end
            endcase
        end
    end

endmodule

