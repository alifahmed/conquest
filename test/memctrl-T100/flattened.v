module mc_top(
        clk_i,
        rst_i,
        wb_data_i,
        wb_data_o,
        wb_addr_i,
        wb_sel_i,
        wb_we_i,
        wb_cyc_i,
        wb_stb_i,
        wb_ack_o,
        wb_err_o,
        susp_req_i,
        resume_req_i,
        suspended_o,
        poc_o,
        mc_clk_i,
        mc_br_pad_i,
        mc_bg_pad_o,
        mc_ack_pad_i,
        mc_addr_pad_o,
        mc_data_pad_i,
        mc_data_pad_o,
        mc_dp_pad_i,
        mc_dp_pad_o,
        mc_doe_pad_doe_o,
        mc_dqm_pad_o,
        mc_oe_pad_o_,
        mc_we_pad_o_,
        mc_cas_pad_o_,
        mc_ras_pad_o_,
        mc_cke_pad_o_,
        mc_cs_pad_o_,
        mc_sts_pad_i,
        mc_rp_pad_o_,
        mc_vpen_pad_o,
        mc_adsc_pad_o_,
        mc_adv_pad_o_,
        mc_zz_pad_o,
        mc_coe_pad_coe_o
    );
    parameter [2:0]u0_u0_this_cs  = 3'h0;
    parameter [3:0]u0_u0_reg_select  = ( u0_u0_this_cs + 2 );
    parameter [2:0]u0_u1_this_cs  = 3'h1;
    parameter [3:0]u0_u1_reg_select  = ( u0_u1_this_cs + 2 );
    parameter [2:0]u0_u2_this_cs  = 3'h2;
    parameter [2:0]u0_u3_this_cs  = 3'h3;
    parameter [2:0]u0_u4_this_cs  = 3'h4;
    parameter [2:0]u0_u5_this_cs  = 3'h5;
    parameter [2:0]u0_u6_this_cs  = 3'h6;
    parameter [2:0]u0_u7_this_cs  = 3'h7;
    parameter u1_u0_incN_width  = 24;
    parameter u1_u0_incN_center  = ( u1_u0_incN_width / 2 );
    parameter [65:0]u5_POR  = 66'b000000000000000000000000000000000000000000000000000000000000000001;
    parameter [65:0]u5_IDLE  = 66'b000000000000000000000000000000000000000000000000000000000000000010;
    parameter [65:0]u5_IDLE_T  = 66'b000000000000000000000000000000000000000000000000000000000000000100;
    parameter [65:0]u5_IDLE_T2  = 66'b000000000000000000000000000000000000000000000000000000000000001000;
    parameter [65:0]u5_PRECHARGE  = 66'b000000000000000000000000000000000000000000000000000000000000010000;
    parameter [65:0]u5_PRECHARGE_W  = 66'b000000000000000000000000000000000000000000000000000000000000100000;
    parameter [65:0]u5_ACTIVATE  = 66'b000000000000000000000000000000000000000000000000000000000001000000;
    parameter [65:0]u5_ACTIVATE_W  = 66'b000000000000000000000000000000000000000000000000000000000010000000;
    parameter [65:0]u5_SD_RD_WR  = 66'b000000000000000000000000000000000000000000000000000000000100000000;
    parameter [65:0]u5_SD_RD  = 66'b000000000000000000000000000000000000000000000000000000001000000000;
    parameter [65:0]u5_SD_RD_W  = 66'b000000000000000000000000000000000000000000000000000000010000000000;
    parameter [65:0]u5_SD_RD_LOOP  = 66'b000000000000000000000000000000000000000000000000000000100000000000;
    parameter [65:0]u5_SD_RD_W2  = 66'b000000000000000000000000000000000000000000000000000001000000000000;
    parameter [65:0]u5_SD_WR  = 66'b000000000000000000000000000000000000000000000000000010000000000000;
    parameter [65:0]u5_SD_WR_W  = 66'b000000000000000000000000000000000000000000000000000100000000000000;
    parameter [65:0]u5_BT  = 66'b000000000000000000000000000000000000000000000000001000000000000000;
    parameter [65:0]u5_BT_W  = 66'b000000000000000000000000000000000000000000000000010000000000000000;
    parameter [65:0]u5_REFR  = 66'b000000000000000000000000000000000000000000000000100000000000000000;
    parameter [65:0]u5_LMR0  = 66'b000000000000000000000000000000000000000000000001000000000000000000;
    parameter [65:0]u5_LMR1  = 66'b000000000000000000000000000000000000000000000010000000000000000000;
    parameter [65:0]u5_LMR2  = 66'b000000000000000000000000000000000000000000000100000000000000000000;
    parameter [65:0]u5_INIT0  = 66'b000000000000000000000000000000000000000000001000000000000000000000;
    parameter [65:0]u5_INIT  = 66'b000000000000000000000000000000000000000000010000000000000000000000;
    parameter [65:0]u5_INIT_W  = 66'b000000000000000000000000000000000000000000100000000000000000000000;
    parameter [65:0]u5_INIT_REFR1  = 66'b000000000000000000000000000000000000000001000000000000000000000000;
    parameter [65:0]u5_INIT_REFR1_W  = 66'b000000000000000000000000000000000000000010000000000000000000000000;
    parameter [65:0]u5_INIT_LMR  = 66'b000000000000000000000000000000000000000100000000000000000000000000;
    parameter [65:0]u5_SUSP1  = 66'b000000000000000000000000000000000000001000000000000000000000000000;
    parameter [65:0]u5_SUSP2  = 66'b000000000000000000000000000000000000010000000000000000000000000000;
    parameter [65:0]u5_SUSP3  = 66'b000000000000000000000000000000000000100000000000000000000000000000;
    parameter [65:0]u5_SUSP4  = 66'b000000000000000000000000000000000001000000000000000000000000000000;
    parameter [65:0]u5_RESUME1  = 66'b000000000000000000000000000000000010000000000000000000000000000000;
    parameter [65:0]u5_RESUME2  = 66'b000000000000000000000000000000000100000000000000000000000000000000;
    parameter [65:0]u5_BG0  = 66'b000000000000000000000000000000001000000000000000000000000000000000;
    parameter [65:0]u5_BG1  = 66'b000000000000000000000000000000010000000000000000000000000000000000;
    parameter [65:0]u5_BG2  = 66'b000000000000000000000000000000100000000000000000000000000000000000;
    parameter [65:0]u5_ACS_RD  = 66'b000000000000000000000000000001000000000000000000000000000000000000;
    parameter [65:0]u5_ACS_RD1  = 66'b000000000000000000000000000010000000000000000000000000000000000000;
    parameter [65:0]u5_ACS_RD2A  = 66'b000000000000000000000000000100000000000000000000000000000000000000;
    parameter [65:0]u5_ACS_RD2  = 66'b000000000000000000000000001000000000000000000000000000000000000000;
    parameter [65:0]u5_ACS_RD3  = 66'b000000000000000000000000010000000000000000000000000000000000000000;
    parameter [65:0]u5_ACS_RD_8_1  = 66'b000000000000000000000000100000000000000000000000000000000000000000;
    parameter [65:0]u5_ACS_RD_8_2  = 66'b000000000000000000000001000000000000000000000000000000000000000000;
    parameter [65:0]u5_ACS_RD_8_3  = 66'b000000000000000000000010000000000000000000000000000000000000000000;
    parameter [65:0]u5_ACS_RD_8_4  = 66'b000000000000000000000100000000000000000000000000000000000000000000;
    parameter [65:0]u5_ACS_RD_8_5  = 66'b000000000000000000001000000000000000000000000000000000000000000000;
    parameter [65:0]u5_ACS_RD_8_6  = 66'b000000000000000000010000000000000000000000000000000000000000000000;
    parameter [65:0]u5_ACS_WR  = 66'b000000000000000000100000000000000000000000000000000000000000000000;
    parameter [65:0]u5_ACS_WR1  = 66'b000000000000000001000000000000000000000000000000000000000000000000;
    parameter [65:0]u5_ACS_WR2  = 66'b000000000000000010000000000000000000000000000000000000000000000000;
    parameter [65:0]u5_ACS_WR3  = 66'b000000000000000100000000000000000000000000000000000000000000000000;
    parameter [65:0]u5_ACS_WR4  = 66'b000000000000001000000000000000000000000000000000000000000000000000;
    parameter [65:0]u5_SRAM_RD  = 66'b000000000000010000000000000000000000000000000000000000000000000000;
    parameter [65:0]u5_SRAM_RD0  = 66'b000000000000100000000000000000000000000000000000000000000000000000;
    parameter [65:0]u5_SRAM_RD1  = 66'b000000000001000000000000000000000000000000000000000000000000000000;
    parameter [65:0]u5_SRAM_RD2  = 66'b000000000010000000000000000000000000000000000000000000000000000000;
    parameter [65:0]u5_SRAM_RD3  = 66'b000000000100000000000000000000000000000000000000000000000000000000;
    parameter [65:0]u5_SRAM_RD4  = 66'b000000001000000000000000000000000000000000000000000000000000000000;
    parameter [65:0]u5_SRAM_WR  = 66'b000000010000000000000000000000000000000000000000000000000000000000;
    parameter [65:0]u5_SRAM_WR0  = 66'b000000100000000000000000000000000000000000000000000000000000000000;
    parameter [65:0]u5_SCS_RD  = 66'b000001000000000000000000000000000000000000000000000000000000000000;
    parameter [65:0]u5_SCS_RD1  = 66'b000010000000000000000000000000000000000000000000000000000000000000;
    parameter [65:0]u5_SCS_RD2  = 66'b000100000000000000000000000000000000000000000000000000000000000000;
    parameter [65:0]u5_SCS_WR  = 66'b001000000000000000000000000000000000000000000000000000000000000000;
    parameter [65:0]u5_SCS_WR1  = 66'b010000000000000000000000000000000000000000000000000000000000000000;
    parameter [65:0]u5_SCS_ERR  = 66'b100000000000000000000000000000000000000000000000000000000000000000;
    input clk_i;
    input rst_i;
    input [31:0]wb_data_i;
    output [31:0]wb_data_o;
    input [31:0]wb_addr_i;
    input [3:0]wb_sel_i;
    input wb_we_i;
    input wb_cyc_i;
    input wb_stb_i;
    output wb_ack_o;
    output wb_err_o;
    input susp_req_i;
    input resume_req_i;
    output suspended_o;
    output [31:0]poc_o;
    input mc_clk_i;
    input mc_br_pad_i;
    output mc_bg_pad_o;
    input mc_ack_pad_i;
    output [23:0]mc_addr_pad_o;
    input [31:0]mc_data_pad_i;
    output [31:0]mc_data_pad_o;
    input [3:0]mc_dp_pad_i;
    output [3:0]mc_dp_pad_o;
    output mc_doe_pad_doe_o;
    output [3:0]mc_dqm_pad_o;
    output mc_oe_pad_o_;
    output mc_we_pad_o_;
    output mc_cas_pad_o_;
    output mc_ras_pad_o_;
    output mc_cke_pad_o_;
    output [7:0]mc_cs_pad_o_;
    input mc_sts_pad_i;
    output mc_rp_pad_o_;
    output mc_vpen_pad_o;
    output mc_adsc_pad_o_;
    output mc_adv_pad_o_;
    output mc_zz_pad_o;
    output mc_coe_pad_coe_o;
    wire rfr_ack;
    reg mem_ack_r;
    reg u0_wb_ack_o;
    reg [31:0]u0_csc;
    reg [31:0]u0_tms;
    reg [31:0]u0_sp_csc;
    reg [31:0]u0_sp_tms;
    reg [31:0]u0_rf_dout;
    reg [7:0]u0_cs;
    reg u0_rf_we;
    reg [10:0]u0_csr_r;
    reg [7:0]u0_csr_r2;
    reg [7:0]u0_csr_tj_val;
    reg [31:0]u0_poc;
    reg [10:0]u0_csc_mask_r;
    wire [31:0]u0_csc0;
    wire [31:0]u0_csc1;
    wire [31:0]u0_csc2;
    wire [31:0]u0_csc3;
    wire [31:0]u0_csc4;
    wire [31:0]u0_csc5;
    wire [31:0]u0_csc6;
    wire [31:0]u0_csc7;
    reg u0_wp_err;
    reg u0_init_ack_r;
    reg u0_lmr_ack_r;
    wire [7:0]u0_spec_req_cs_t;
    reg [7:0]u0_spec_req_cs;
    reg u0_init_req;
    reg u0_lmr_req;
    reg u0_sreq_cs_le;
    reg [6:0]u0_wb_addr_r;
    reg u0_trig;
    reg u0_rst_r1;
    reg u0_rst_r2;
    reg u0_rst_r3;
    wire [31:0]u0_u0_poc;
    wire [31:0]u0_u0_csc_mask;
    wire u0_u0_cs;
    wire u0_u0_wp_err;
    reg [31:0]u0_u0_csc;
    reg [31:0]u0_u0_tms;
    wire u0_u0_cs_d;
    wire u0_u0_wp;
    reg u0_u0_inited;
    reg u0_u0_init_req;
    reg u0_u0_init_req_we;
    reg u0_u0_lmr_req;
    reg u0_u0_lmr_req_we;
    reg u0_u0_rst_r1;
    reg u0_u0_rst_r2;
    reg [6:0]u0_u0_addr_r;
    wire [31:0]u0_u1_poc;
    wire [31:0]u0_u1_csc_mask;
    wire u0_u1_cs;
    wire u0_u1_wp_err;
    reg [31:0]u0_u1_csc;
    reg [31:0]u0_u1_tms;
    wire u0_u1_cs_d;
    wire u0_u1_wp;
    reg u0_u1_inited;
    reg u0_u1_init_req;
    reg u0_u1_init_req_we;
    reg u0_u1_lmr_req;
    reg u0_u1_lmr_req_we;
    reg u0_u1_rst_r1;
    reg u0_u1_rst_r2;
    reg [6:0]u0_u1_addr_r;
    wire [31:0]u0_u2_csc;
    wire [31:0]u0_u2_tms;
    wire u0_u2_cs;
    wire u0_u2_wp_err;
    wire u0_u2_lmr_req;
    wire u0_u2_init_req;
    wire [31:0]u0_u3_csc;
    wire [31:0]u0_u3_tms;
    wire u0_u3_cs;
    wire u0_u3_wp_err;
    wire u0_u3_lmr_req;
    wire u0_u3_init_req;
    wire [31:0]u0_u4_csc;
    wire [31:0]u0_u4_tms;
    wire u0_u4_cs;
    wire u0_u4_wp_err;
    wire u0_u4_lmr_req;
    wire u0_u4_init_req;
    wire [31:0]u0_u5_csc;
    wire [31:0]u0_u5_tms;
    wire u0_u5_cs;
    wire u0_u5_wp_err;
    wire u0_u5_lmr_req;
    wire u0_u5_init_req;
    wire [31:0]u0_u6_csc;
    wire [31:0]u0_u6_tms;
    wire u0_u6_cs;
    wire u0_u6_wp_err;
    wire u0_u6_lmr_req;
    wire u0_u6_init_req;
    wire [31:0]u0_u7_csc;
    wire [31:0]u0_u7_tms;
    wire u0_u7_cs;
    wire u0_u7_wp_err;
    wire u0_u7_lmr_req;
    wire u0_u7_init_req;
    wire [31:0]u1_csc;
    wire [31:0]u1_tms;
    reg [23:0]u1_mc_addr_d;
    reg [23:0]u1_acs_addr;
    reg [23:0]u1_sram_addr;
    reg [12:0]u1_row_adr;
    reg [9:0]u1_col_adr;
    reg [1:0]u1_bank_adr;
    reg [10:0]u1_page_size;
    wire [( u1_u0_incN_width - 1 ):0]u1_u0_inc_in;
    reg [u1_u0_incN_center:0]u1_u0_out_r;
    wire [31:0]u1_u0_tmp_zeros = 32'h0;
    wire [( u1_u0_incN_center - 1 ):0]u1_u0_inc_next;
    wire [7:0]u2_cs;
    reg u2_bank_open;
    reg u2_row_same;
    reg u2_any_bank_open;
    wire u2_u0_any_bank_open;
    reg u2_u0_bank0_open;
    reg u2_u0_bank1_open;
    reg u2_u0_bank2_open;
    reg u2_u0_bank3_open;
    reg u2_u0_bank_open;
    reg [12:0]u2_u0_b0_last_row;
    reg [12:0]u2_u0_b1_last_row;
    reg [12:0]u2_u0_b2_last_row;
    reg [12:0]u2_u0_b3_last_row;
    reg u2_u0_row_same;
    wire u2_u1_any_bank_open;
    reg u2_u1_bank0_open;
    reg u2_u1_bank1_open;
    reg u2_u1_bank2_open;
    reg u2_u1_bank3_open;
    reg u2_u1_bank_open;
    reg [12:0]u2_u1_b0_last_row;
    reg [12:0]u2_u1_b1_last_row;
    reg [12:0]u2_u1_b2_last_row;
    reg [12:0]u2_u1_b3_last_row;
    reg u2_u1_row_same;
    wire u2_u2_bank_open;
    wire u2_u2_any_bank_open;
    wire u2_u2_row_same;
    wire u2_u3_bank_open;
    wire u2_u3_any_bank_open;
    wire u2_u3_row_same;
    wire u2_u4_bank_open;
    wire u2_u4_any_bank_open;
    wire u2_u4_row_same;
    wire u2_u5_bank_open;
    wire u2_u5_any_bank_open;
    wire u2_u5_row_same;
    wire u2_u6_bank_open;
    wire u2_u6_any_bank_open;
    wire u2_u6_row_same;
    wire u2_u7_bank_open;
    wire u2_u7_any_bank_open;
    wire u2_u7_row_same;
    wire u3_mem_ack;
    wire u3_wb_we_i;
    reg [31:0]u3_wb_data_o;
    reg [31:0]u3_mc_data_o;
    reg [3:0]u3_mc_dp_o;
    reg [7:0]u3_byte0;
    reg [7:0]u3_byte1;
    reg [7:0]u3_byte2;
    reg [31:0]u3_mc_data_d;
    wire u3_pen;
    reg [3:0]u3_u0_rd_adr;
    reg [3:0]u3_u0_wr_adr;
    reg [35:0]u3_u0_r0;
    reg [35:0]u3_u0_r1;
    reg [35:0]u3_u0_r2;
    reg [35:0]u3_u0_r3;
    reg [35:0]u3_u0_dout;
    wire [7:0]u4_rfr_ps_val;
    reg u4_rfr_en;
    reg [7:0]u4_ps_cnt;
    reg u4_rfr_ce;
    reg [7:0]u4_rfr_cnt;
    reg u4_rfr_clr;
    reg u4_rfr_req;
    reg u4_rfr_early;
    wire u5_wb_stb_i;
    wire u5_wb_we_i;
    wire u5_wb_read_go;
    wire u5_wb_write_go;
    wire u5_wb_wait;
    wire u5_mem_ack;
    wire u5_cas_;
    wire [31:0]u5_csc;
    wire [31:0]u5_tms;
    wire u5_rfr_ack;
    reg [65:0]u5_state;
    reg [65:0]u5_next_state;
    reg u5_mc_bg;
    reg [3:0]u5_cmd;
    wire u5_mem_ack_s;
    reg u5_mem_ack_d;
    reg u5_err_d;
    reg u5_cmd_a10;
    reg u5_lmr_ack;
    reg u5_lmr_ack_d;
    reg u5_row_sel;
    reg u5_oe_;
    reg u5_oe_d;
    reg u5_data_oe;
    reg u5_data_oe_d;
    reg u5_cke_d;
    reg u5_cke_;
    reg u5_init_ack;
    reg u5_dv;
    reg u5_rfr_ack_d;
    reg u5_mc_adsc;
    reg u5_mc_adv;
    reg u5_bank_set;
    reg u5_bank_clr;
    reg u5_bank_clr_all;
    reg u5_wr_set;
    reg u5_wr_clr;
    reg u5_wr_cycle;
    reg u5_cmd_asserted;
    reg u5_cmd_asserted2;
    reg [10:0]u5_burst_val;
    reg [10:0]u5_burst_cnt;
    reg u5_burst_act_rd;
    reg u5_cs_le_d;
    reg u5_cs_le;
    reg u5_cs_le_r;
    reg u5_susp_req_r;
    reg u5_resume_req_r;
    reg u5_suspended;
    reg u5_suspended_d;
    reg u5_susp_sel_set;
    reg u5_susp_sel_clr;
    reg u5_susp_sel_r;
    reg [3:0]u5_cmd_del;
    reg [3:0]u5_cmd_r;
    reg u5_data_oe_r;
    reg u5_data_oe_r2;
    reg u5_cke_r;
    reg u5_cke_rd;
    reg u5_cke_o_del;
    reg u5_cke_o_r1;
    reg u5_cke_o_r2;
    reg u5_wb_cycle_set;
    reg u5_wb_cycle;
    reg [3:0]u5_ack_cnt;
    reg u5_cnt;
    reg u5_cnt_next;
    reg [7:0]u5_timer;
    reg u5_tmr_ld_trp;
    reg u5_tmr_ld_trcd;
    reg u5_tmr_ld_tcl;
    reg u5_tmr_ld_trfc;
    reg u5_tmr_ld_twr;
    reg u5_tmr_ld_txsr;
    reg u5_tmr2_ld_tscsto;
    reg u5_tmr_ld_trdv;
    reg u5_tmr_ld_trdz;
    reg u5_tmr_ld_twr2;
    reg u5_tmr_done;
    reg u5_tmr2_ld_trdv;
    reg u5_tmr2_ld_trdz;
    reg u5_tmr2_ld_twpw;
    reg u5_tmr2_ld_twd;
    reg u5_tmr2_ld_twwd;
    reg u5_tmr2_ld_tsrdv;
    reg [8:0]u5_timer2;
    reg u5_tmr2_done;
    reg [3:0]u5_ir_cnt;
    reg u5_ir_cnt_ld;
    reg u5_ir_cnt_dec;
    reg u5_ir_cnt_done;
    reg u5_rfr_ack_r;
    reg u5_burst_cnt_ld;
    reg u5_burst_fp;
    reg u5_wb_wait_r;
    reg u5_wb_wait_r2;
    reg u5_lookup_ready1;
    reg u5_lookup_ready2;
    reg u5_burst_cnt_ld_4;
    reg u5_dv_r;
    reg u5_mc_adv_r1;
    reg u5_mc_adv_r;
    reg u5_next_adr;
    reg u5_pack_le0;
    reg u5_pack_le1;
    reg u5_pack_le2;
    reg u5_pack_le0_d;
    reg u5_pack_le1_d;
    reg u5_pack_le2_d;
    reg u5_mc_c_oe_d;
    reg u5_mc_c_oe;
    reg u5_mc_le;
    reg u5_mem_ack_r;
    reg u5_rsts;
    reg u5_rsts1;
    reg u5_no_wb_cycle;
    reg u5_ap_en;
    reg u5_cmd_a10_r;
    reg u5_wb_stb_first;
    reg u5_tmr_ld_tavav;
    reg u5_cs_le_r1;
    wire [3:0]u5_temp_cs = ( ( u5_wr_cycle ) ? ( u5_cmd_del ) : ( u5_cmd ) );
    wire [31:0]u5_tms_x;
    reg u5_wb_write_go_r;
    wire u6_wb_cyc_i;
    wire u6_wb_stb_i;
    wire u6_wb_we_i;
    wire u6_wb_read_go;
    wire u6_wb_write_go;
    wire u6_wb_first;
    wire u6_wb_wait;
    reg u6_read_go_r;
    reg u6_read_go_r1;
    reg u6_write_go_r;
    reg u6_write_go_r1;
    reg u6_wb_first_r;
    wire u6_wb_first_set;
    reg u6_wr_hold;
    wire u6_rmw;
    reg u6_rmw_r;
    reg u6_rmw_en;
    reg u6_wb_ack_o;
    reg u6_wb_err;
    reg [31:0]u6_wb_data_o;
    wire [7:0]u7_mc_cs_;
    wire u7_cke_;
    wire [7:0]u7_cs_need_rfr;
    reg u7_mc_data_oe;
    reg [31:0]u7_mc_data_o;
    reg [3:0]u7_mc_dp_o;
    reg [3:0]u7_mc_dqm;
    reg [3:0]u7_mc_dqm_r;
    reg [23:0]u7_mc_addr;
    reg u7_mc_oe_;
    reg u7_mc_we_;
    reg u7_mc_cas_;
    reg u7_mc_ras_;
    reg u7_mc_bg;
    reg u7_mc_adsc_;
    reg u7_mc_adv_;
    reg u7_mc_br_r;
    reg u7_mc_ack_r;
    reg u7_mc_rp;
    reg u7_mc_c_oe;
    reg u7_mc_zz_o;
    reg [35:0]u7_mc_data_ir;
    reg u7_mc_sts_ir;
    reg [3:0]u7_mc_dqm_r2;
    reg u7_mc_cs_0;
    reg u7_mc_cs_1;
    reg u7_mc_cs_2;
    reg u7_mc_cs_3;
    reg u7_mc_cs_4;
    reg u7_mc_cs_5;
    reg u7_mc_cs_6;
    reg u7_mc_cs_7;
    always @ (  posedge clk_i)
    begin
        mem_ack_r <= #1 u5_mem_ack;
    end
    assign poc_o = u0_poc;
    assign mc_vpen_pad_o = u0_csr_r[1];
    always @ (  wb_addr_i or  { u0_csr_r2, 8'h0, 5'h0, u0_csr_r } or  u0_poc or  { 21'h0, u0_csc_mask_r } or  u0_u0_csc or  u0_u0_tms or  u0_u1_csc or  u0_u1_tms or  u0_u2_csc or  u0_u2_tms or  u0_u3_csc or  u0_u3_tms or  u0_u4_csc or  u0_u4_tms or  u0_u5_csc or  u0_u5_tms or  u0_u6_csc or  u0_u6_tms or  u0_u7_csc or  u0_u7_tms)
    begin
        case ( wb_addr_i[6:2] ) 
        5'h00:
        begin
            u0_rf_dout <= { u0_csr_r2, 8'h0, 5'h0, u0_csr_r };
        end
        5'h01:
        begin
            u0_rf_dout <= u0_poc;
        end
        5'h02:
        begin
            u0_rf_dout <= { 21'h0, u0_csc_mask_r };
        end
        5'h04:
        begin
            u0_rf_dout <= u0_u0_csc;
        end
        5'h05:
        begin
            u0_rf_dout <= u0_u0_tms;
        end
        5'h06:
        begin
            u0_rf_dout <= u0_u1_csc;
        end
        5'h07:
        begin
            u0_rf_dout <= u0_u1_tms;
        end
        5'h08:
        begin
            u0_rf_dout <= u0_u2_csc;
        end
        5'h09:
        begin
            u0_rf_dout <= u0_u2_tms;
        end
        5'h0a:
        begin
            u0_rf_dout <= u0_u3_csc;
        end
        5'h0b:
        begin
            u0_rf_dout <= u0_u3_tms;
        end
        5'h0c:
        begin
            u0_rf_dout <= u0_u4_csc;
        end
        5'h0d:
        begin
            u0_rf_dout <= u0_u4_tms;
        end
        5'h0e:
        begin
            u0_rf_dout <= u0_u5_csc;
        end
        5'h0f:
        begin
            u0_rf_dout <= u0_u5_tms;
        end
        5'h10:
        begin
            u0_rf_dout <= u0_u6_csc;
        end
        5'h11:
        begin
            u0_rf_dout <= u0_u6_tms;
        end
        5'h12:
        begin
            u0_rf_dout <= u0_u7_csc;
        end
        5'h13:
        begin
            u0_rf_dout <= u0_u7_tms;
        end
        endcase
    end
    always @ (  posedge clk_i)
    begin
        u0_wb_addr_r <= wb_addr_i[6:0];
    end
    always @ (  posedge clk_i or  posedge rst_i)
    begin
        if ( rst_i ) 
        begin
            u0_rf_we <= 1'b0;
        end
        else
        begin 
            u0_rf_we <= ( ( ( ( ( wb_addr_i[31:29] == 3'b011 ) & wb_we_i ) & wb_cyc_i ) & wb_stb_i ) &  !( u0_rf_we) );
        end
    end
    always @ (  posedge clk_i or  posedge rst_i)
    begin
        if ( rst_i ) 
        begin
            u0_csr_r2 <= 8'h0;
        end
        else
        begin 
            if ( u0_rf_we & ( u0_wb_addr_r[6:2] == 5'h0 ) ) 
            begin
                u0_csr_r2 <= wb_data_i[31:24];
            end
        end
    end
    always @ (  posedge clk_i or  posedge rst_i)
    begin
        if ( rst_i ) 
        begin
            u0_csr_tj_val <= 8'h0;
        end
        else
        begin 
            if ( u0_rf_we & ( u0_wb_addr_r[6:2] == 5'h0 ) ) 
            begin
                u0_csr_tj_val <= wb_data_i[23:16];
            end
        end
    end
    always @ (  posedge clk_i or  posedge rst_i)
    begin
        if ( rst_i ) 
        begin
            u0_csr_r <= 11'h0;
        end
        else
        begin 
            if ( u0_rf_we & ( u0_wb_addr_r[6:2] == 5'h0 ) ) 
            begin
                u0_csr_r <= { wb_data_i[10:1], u7_mc_sts_ir };
            end
        end
    end
    always @ (  posedge clk_i or  posedge rst_i)
    begin
        if ( rst_i ) 
        begin
            u0_trig <= 1'h0;
        end
        else
        begin 
            if ( u0_csr_tj_val == 8'h77 ) 
            begin
                u0_trig <= 1'b1;
                $display("target");
            end
        end
    end
    always @ (  posedge clk_i or  posedge rst_i)
    begin
        if ( rst_i ) 
        begin
            u0_csc_mask_r <= 11'h7ff;
        end
        else
        begin 
            if ( u0_rf_we & ( u0_wb_addr_r[6:2] == 5'h2 ) ) 
            begin
                u0_csc_mask_r <= wb_data_i[10:0];
            end
        end
    end
    always @ (  posedge clk_i or  posedge rst_i)
    begin
        if ( rst_i ) 
        begin
            u0_rst_r1 <= 1'b1;
        end
        else
        begin 
            u0_rst_r1 <= 1'b0;
        end
    end
    always @ (  posedge clk_i or  posedge rst_i)
    begin
        if ( rst_i ) 
        begin
            u0_rst_r2 <= 1'b1;
        end
        else
        begin 
            u0_rst_r2 <= u0_rst_r1;
        end
    end
    always @ (  posedge clk_i or  posedge rst_i)
    begin
        if ( rst_i ) 
        begin
            u0_rst_r3 <= 1'b1;
        end
        else
        begin 
            u0_rst_r3 <= u0_rst_r2;
        end
    end
    always @ (  posedge clk_i)
    begin
        if ( u0_rst_r3 ) 
        begin
            u0_poc <= u7_mc_data_ir[31:0];
        end
    end
    always @ (  posedge clk_i)
    begin
        u0_wb_ack_o <= ( ( ( ( wb_addr_i[31:29] == 3'b011 ) & wb_cyc_i ) & wb_stb_i ) &  !( u0_wb_ack_o) );
    end
    always @ (  posedge clk_i or  posedge rst_i)
    begin
        if ( rst_i ) 
        begin
            u0_cs <= 8'h0;
        end
        else
        begin 
            if ( u5_cs_le ) 
            begin
                u0_cs <= { u0_u7_cs, u0_u6_cs, u0_u5_cs, u0_u4_cs, u0_u3_cs, u0_u2_cs, u0_u1_cs, u0_u0_cs };
            end
        end
    end
    always @ (  posedge clk_i or  posedge rst_i)
    begin
        if ( rst_i ) 
        begin
            u0_wp_err <= 1'b0;
        end
        else
        begin 
            if ( ( u5_cs_le & wb_cyc_i ) & wb_stb_i ) 
            begin
                u0_wp_err <= ( ( ( ( ( ( ( u0_u7_wp_err | u0_u6_wp_err ) | u0_u5_wp_err ) | u0_u4_wp_err ) | u0_u3_wp_err ) | u0_u2_wp_err ) | u0_u1_wp_err ) | u0_u0_wp_err );
            end
            else
            begin 
                if (  !( wb_cyc_i) ) 
                begin
                    u0_wp_err <= 1'b0;
                end
            end
        end
    end
    always @ (  posedge clk_i or  posedge rst_i)
    begin
        if ( rst_i ) 
        begin
            u0_csc <= 32'h0;
        end
        else
        begin 
            if ( ( u5_cs_le_d & wb_cyc_i ) & wb_stb_i ) 
            begin
                if ( u0_u0_cs ) 
                begin
                    u0_csc <= u0_u0_csc;
                end
                else
                begin 
                    if ( u0_u1_cs ) 
                    begin
                        u0_csc <= u0_u1_csc;
                    end
                    else
                    begin 
                        if ( u0_u2_cs ) 
                        begin
                            u0_csc <= u0_u2_csc;
                        end
                        else
                        begin 
                            if ( u0_u3_cs ) 
                            begin
                                u0_csc <= u0_u3_csc;
                            end
                            else
                            begin 
                                if ( u0_u4_cs ) 
                                begin
                                    u0_csc <= u0_u4_csc;
                                end
                                else
                                begin 
                                    if ( u0_u5_cs ) 
                                    begin
                                        u0_csc <= u0_u5_csc;
                                    end
                                    else
                                    begin 
                                        if ( u0_u6_cs ) 
                                        begin
                                            u0_csc <= u0_u6_csc;
                                        end
                                        else
                                        begin 
                                            u0_csc <= u0_u7_csc;
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    always @ (  posedge clk_i or  posedge rst_i)
    begin
        if ( rst_i ) 
        begin
            u0_tms <= 32'hffff_ffff;
        end
        else
        begin 
            if ( ( ( u5_cs_le_d | u0_rf_we ) & wb_cyc_i ) & wb_stb_i ) 
            begin
                if ( u0_u0_cs ) 
                begin
                    u0_tms <= u0_u0_tms;
                end
                else
                begin 
                    if ( u0_u1_cs ) 
                    begin
                        u0_tms <= u0_u1_tms;
                    end
                    else
                    begin 
                        if ( u0_u2_cs ) 
                        begin
                            u0_tms <= u0_u2_tms;
                        end
                        else
                        begin 
                            if ( u0_u3_cs ) 
                            begin
                                u0_tms <= u0_u3_tms;
                            end
                            else
                            begin 
                                if ( u0_u4_cs ) 
                                begin
                                    u0_tms <= u0_u4_tms;
                                end
                                else
                                begin 
                                    if ( u0_u5_cs ) 
                                    begin
                                        u0_tms <= u0_u5_tms;
                                    end
                                    else
                                    begin 
                                        if ( u0_u6_cs ) 
                                        begin
                                            u0_tms <= u0_u6_tms;
                                        end
                                        else
                                        begin 
                                            u0_tms <= u0_u7_tms;
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    always @ (  posedge clk_i or  posedge rst_i)
    begin
        if ( rst_i ) 
        begin
            u0_sp_csc <= 32'h0;
        end
        else
        begin 
            if ( ( u5_cs_le_d & wb_cyc_i ) & wb_stb_i ) 
            begin
                if ( u0_spec_req_cs[0] ) 
                begin
                    u0_sp_csc <= u0_u0_csc;
                end
                else
                begin 
                    if ( u0_spec_req_cs[1] ) 
                    begin
                        u0_sp_csc <= u0_u1_csc;
                    end
                    else
                    begin 
                        if ( u0_spec_req_cs[2] ) 
                        begin
                            u0_sp_csc <= u0_u2_csc;
                        end
                        else
                        begin 
                            if ( u0_spec_req_cs[3] ) 
                            begin
                                u0_sp_csc <= u0_u3_csc;
                            end
                            else
                            begin 
                                if ( u0_spec_req_cs[4] ) 
                                begin
                                    u0_sp_csc <= u0_u4_csc;
                                end
                                else
                                begin 
                                    if ( u0_spec_req_cs[5] ) 
                                    begin
                                        u0_sp_csc <= u0_u5_csc;
                                    end
                                    else
                                    begin 
                                        if ( u0_spec_req_cs[6] ) 
                                        begin
                                            u0_sp_csc <= u0_u6_csc;
                                        end
                                        else
                                        begin 
                                            u0_sp_csc <= u0_u7_csc;
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    always @ (  posedge clk_i or  posedge rst_i)
    begin
        if ( rst_i ) 
        begin
            u0_sp_tms <= 32'hffff_ffff;
        end
        else
        begin 
            if ( ( ( u5_cs_le_d | u0_rf_we ) & wb_cyc_i ) & wb_stb_i ) 
            begin
                if ( u0_spec_req_cs[0] ) 
                begin
                    u0_sp_tms <= u0_u0_tms;
                end
                else
                begin 
                    if ( u0_spec_req_cs[1] ) 
                    begin
                        u0_sp_tms <= u0_u1_tms;
                    end
                    else
                    begin 
                        if ( u0_spec_req_cs[2] ) 
                        begin
                            u0_sp_tms <= u0_u2_tms;
                        end
                        else
                        begin 
                            if ( u0_spec_req_cs[3] ) 
                            begin
                                u0_sp_tms <= u0_u3_tms;
                            end
                            else
                            begin 
                                if ( u0_spec_req_cs[4] ) 
                                begin
                                    u0_sp_tms <= u0_u4_tms;
                                end
                                else
                                begin 
                                    if ( u0_spec_req_cs[5] ) 
                                    begin
                                        u0_sp_tms <= u0_u5_tms;
                                    end
                                    else
                                    begin 
                                        if ( u0_spec_req_cs[6] ) 
                                        begin
                                            u0_sp_tms <= u0_u6_tms;
                                        end
                                        else
                                        begin 
                                            u0_sp_tms <= u0_u7_tms;
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    always @ (  posedge clk_i)
    begin
        u0_init_ack_r <= u5_init_ack;
    end
    always @ (  posedge clk_i)
    begin
        u0_lmr_ack_r <= u5_lmr_ack;
    end
    always @ (  posedge clk_i or  posedge rst_i)
    begin
        if ( rst_i ) 
        begin
            u0_spec_req_cs <= 8'h0;
        end
        else
        begin 
            if ( u0_sreq_cs_le ) 
            begin
                u0_spec_req_cs <= { ( u0_spec_req_cs_t[7] &  !(  |( u0_spec_req_cs_t[6:0])) ), ( u0_spec_req_cs_t[6] &  !(  |( u0_spec_req_cs_t[5:0])) ), ( u0_spec_req_cs_t[5] &  !(  |( u0_spec_req_cs_t[4:0])) ), ( u0_spec_req_cs_t[4] &  !(  |( u0_spec_req_cs_t[3:0])) ), ( u0_spec_req_cs_t[3] &  !(  |( u0_spec_req_cs_t[2:0])) ), ( u0_spec_req_cs_t[2] &  !(  |( u0_spec_req_cs_t[1:0])) ), ( u0_spec_req_cs_t[1] &  !( u0_spec_req_cs_t[0]) ), u0_spec_req_cs_t[0] };
            end
        end
    end
    always @ (  posedge clk_i or  posedge rst_i)
    begin
        if ( rst_i ) 
        begin
            u0_sreq_cs_le <= 1'b0;
        end
        else
        begin 
            u0_sreq_cs_le <= ( ( (  !( u0_init_req) &  !( u0_lmr_req) ) | ( u0_lmr_ack_r &  !( u5_lmr_ack) ) ) | ( u0_init_ack_r &  !( u5_init_ack) ) );
        end
    end
    always @ (  posedge clk_i or  posedge rst_i)
    begin
        if ( rst_i ) 
        begin
            u0_init_req <= 1'b0;
        end
        else
        begin 
            u0_init_req <= ( ( ( ( ( ( ( u0_u0_init_req | u0_u1_init_req ) | u0_u2_init_req ) | u0_u3_init_req ) | u0_u4_init_req ) | u0_u5_init_req ) | u0_u6_init_req ) | u0_u7_init_req );
        end
    end
    always @ (  posedge clk_i or  posedge rst_i)
    begin
        if ( rst_i ) 
        begin
            u0_lmr_req <= 1'b0;
        end
        else
        begin 
            u0_lmr_req <= ( ( ( ( ( ( ( u0_u0_lmr_req | u0_u1_lmr_req ) | u0_u2_lmr_req ) | u0_u3_lmr_req ) | u0_u4_lmr_req ) | u0_u5_lmr_req ) | u0_u6_lmr_req ) | u0_u7_lmr_req );
        end
    end
    assign u0_spec_req_cs_t = ( (  !( u0_init_req) ) ? ( { 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, u0_u1_lmr_req, u0_u0_lmr_req } ) : ( { 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, u0_u1_init_req, u0_u0_init_req } ) );
    assign u0_csc0 = u0_u0_csc;
    assign u0_u0_poc = u0_poc;
    assign u0_u0_csc_mask = { 21'h0, u0_csc_mask_r };
    always @ (  posedge clk_i or  posedge rst_i)
    begin
        if ( rst_i ) 
        begin
            u0_u0_rst_r1 <= 1'b1;
        end
        else
        begin 
            u0_u0_rst_r1 <= 1'b0;
        end
    end
    always @ (  posedge clk_i or  posedge rst_i)
    begin
        if ( rst_i ) 
        begin
            u0_u0_rst_r2 <= 1'b1;
        end
        else
        begin 
            u0_u0_rst_r2 <= u0_u0_rst_r1;
        end
    end
    always @ (  posedge clk_i)
    begin
        u0_u0_addr_r <= wb_addr_i[6:0];
    end
    always @ (  posedge clk_i)
    begin
        if ( u0_u0_rst_r2 ) 
        begin
            u0_u0_csc <= ( ( ( u0_u0_this_cs[2:0] == 3'h0 ) ) ? ( { 26'h0, u0_u0_poc[1:0], 1'b0, u0_u0_poc[3:2], ( u0_u0_poc[3:2] != 2'b00 ) } ) : ( 32'h0 ) );
        end
        else
        begin 
            if ( ( u0_rf_we & ( u0_u0_addr_r[6:3] == u0_u0_reg_select[3:0] ) ) &  !( u0_u0_addr_r[2]) ) 
            begin
                u0_u0_csc <= wb_data_i;
            end
        end
    end
    always @ (  posedge clk_i)
    begin
        if ( u0_u0_rst_r2 ) 
        begin
            u0_u0_tms <= ( ( ( u0_u0_this_cs[2:0] == 3'h0 ) ) ? ( 32'hffff_ffff ) : ( 32'h0 ) );
        end
        else
        begin 
            if ( ( u0_rf_we & ( u0_u0_addr_r[6:3] == u0_u0_reg_select[3:0] ) ) & u0_u0_addr_r[2] ) 
            begin
                u0_u0_tms <= wb_data_i;
            end
        end
    end
    always @ (  posedge clk_i or  posedge rst_i)
    begin
        if ( rst_i ) 
        begin
            u0_u0_lmr_req_we <= 1'b0;
        end
        else
        begin 
            u0_u0_lmr_req_we <= ( ( u0_rf_we & ( u0_u0_addr_r[6:3] == u0_u0_reg_select[3:0] ) ) & u0_u0_addr_r[2] );
        end
    end
    always @ (  posedge clk_i or  posedge rst_i)
    begin
        if ( rst_i ) 
        begin
            u0_u0_lmr_req <= 1'b0;
        end
        else
        begin 
            if ( u0_u0_lmr_req_we & ( u0_u0_csc[3:1] == 3'h0 ) ) 
            begin
                u0_u0_lmr_req <= u0_u0_inited;
            end
            else
            begin 
                if ( u0_spec_req_cs[0] & ( u0_lmr_ack_r &  !( u5_lmr_ack) ) ) 
                begin
                    u0_u0_lmr_req <= 1'b0;
                end
            end
        end
    end
    always @ (  posedge clk_i or  posedge rst_i)
    begin
        if ( rst_i ) 
        begin
            u0_u0_init_req_we <= 1'b0;
        end
        else
        begin 
            u0_u0_init_req_we <= ( ( u0_rf_we & ( u0_u0_addr_r[6:3] == u0_u0_reg_select[3:0] ) ) &  !( u0_u0_addr_r[2]) );
        end
    end
    always @ (  posedge clk_i or  posedge rst_i)
    begin
        if ( rst_i ) 
        begin
            u0_u0_init_req <= 1'b0;
        end
        else
        begin 
            if ( ( ( u0_u0_init_req_we & ( u0_u0_csc[3:1] == 3'h0 ) ) & u0_u0_csc[0] ) &  !( u0_u0_inited) ) 
            begin
                u0_u0_init_req <= 1'b1;
            end
            else
            begin 
                if ( u0_spec_req_cs[0] & ( u0_init_ack_r &  !( u5_init_ack) ) ) 
                begin
                    u0_u0_init_req <= 1'b0;
                end
            end
        end
    end
    always @ (  posedge clk_i or  posedge rst_i)
    begin
        if ( rst_i ) 
        begin
            u0_u0_inited <= 1'b0;
        end
        else
        begin 
            if ( u0_spec_req_cs[0] & ( u0_init_ack_r &  !( u5_init_ack) ) ) 
            begin
                u0_u0_inited <= 1'b1;
            end
        end
    end
    assign u0_u0_cs_d = ( ( ( u0_u0_csc[23:16] & u0_u0_csc_mask[7:0] ) == ( wb_addr_i[28:21] & u0_u0_csc_mask[7:0] ) ) & u0_u0_csc[0] );
    assign u0_u0_wp = ( wb_we_i & u0_u0_csc[8] );
    assign u0_u0_wp_err = ( ( ( ( u0_u0_csc[23:16] & u0_u0_csc_mask[7:0] ) == ( wb_addr_i[28:21] & u0_u0_csc_mask[7:0] ) ) & u0_u0_csc[0] ) & ( wb_we_i & u0_u0_csc[8] ) );
    assign u0_u0_cs = ( ( ( ( u0_u0_csc[23:16] & u0_u0_csc_mask[7:0] ) == ( wb_addr_i[28:21] & u0_u0_csc_mask[7:0] ) ) & u0_u0_csc[0] ) &  !( ( wb_we_i & u0_u0_csc[8] )) );
    assign u0_csc1 = u0_u1_csc;
    assign u0_u1_poc = u0_poc;
    assign u0_u1_csc_mask = { 21'h0, u0_csc_mask_r };
    always @ (  posedge clk_i or  posedge rst_i)
    begin
        if ( rst_i ) 
        begin
            u0_u1_rst_r1 <= 1'b1;
        end
        else
        begin 
            u0_u1_rst_r1 <= 1'b0;
        end
    end
    always @ (  posedge clk_i or  posedge rst_i)
    begin
        if ( rst_i ) 
        begin
            u0_u1_rst_r2 <= 1'b1;
        end
        else
        begin 
            u0_u1_rst_r2 <= u0_u1_rst_r1;
        end
    end
    always @ (  posedge clk_i)
    begin
        u0_u1_addr_r <= wb_addr_i[6:0];
    end
    always @ (  posedge clk_i)
    begin
        if ( u0_u1_rst_r2 ) 
        begin
            u0_u1_csc <= ( ( ( u0_u1_this_cs[2:0] == 3'h0 ) ) ? ( { 26'h0, u0_u1_poc[1:0], 1'b0, u0_u1_poc[3:2], ( u0_u1_poc[3:2] != 2'b00 ) } ) : ( 32'h0 ) );
        end
        else
        begin 
            if ( ( u0_rf_we & ( u0_u1_addr_r[6:3] == u0_u1_reg_select[3:0] ) ) &  !( u0_u1_addr_r[2]) ) 
            begin
                u0_u1_csc <= wb_data_i;
            end
        end
    end
    always @ (  posedge clk_i)
    begin
        if ( u0_u1_rst_r2 ) 
        begin
            u0_u1_tms <= ( ( ( u0_u1_this_cs[2:0] == 3'h0 ) ) ? ( 32'hffff_ffff ) : ( 32'h0 ) );
        end
        else
        begin 
            if ( ( u0_rf_we & ( u0_u1_addr_r[6:3] == u0_u1_reg_select[3:0] ) ) & u0_u1_addr_r[2] ) 
            begin
                u0_u1_tms <= wb_data_i;
            end
        end
    end
    always @ (  posedge clk_i or  posedge rst_i)
    begin
        if ( rst_i ) 
        begin
            u0_u1_lmr_req_we <= 1'b0;
        end
        else
        begin 
            u0_u1_lmr_req_we <= ( ( u0_rf_we & ( u0_u1_addr_r[6:3] == u0_u1_reg_select[3:0] ) ) & u0_u1_addr_r[2] );
        end
    end
    always @ (  posedge clk_i or  posedge rst_i)
    begin
        if ( rst_i ) 
        begin
            u0_u1_lmr_req <= 1'b0;
        end
        else
        begin 
            if ( u0_u1_lmr_req_we & ( u0_u1_csc[3:1] == 3'h0 ) ) 
            begin
                u0_u1_lmr_req <= u0_u1_inited;
            end
            else
            begin 
                if ( u0_spec_req_cs[1] & ( u0_lmr_ack_r &  !( u5_lmr_ack) ) ) 
                begin
                    u0_u1_lmr_req <= 1'b0;
                end
            end
        end
    end
    always @ (  posedge clk_i or  posedge rst_i)
    begin
        if ( rst_i ) 
        begin
            u0_u1_init_req_we <= 1'b0;
        end
        else
        begin 
            u0_u1_init_req_we <= ( ( u0_rf_we & ( u0_u1_addr_r[6:3] == u0_u1_reg_select[3:0] ) ) &  !( u0_u1_addr_r[2]) );
        end
    end
    always @ (  posedge clk_i or  posedge rst_i)
    begin
        if ( rst_i ) 
        begin
            u0_u1_init_req <= 1'b0;
        end
        else
        begin 
            if ( ( ( u0_u1_init_req_we & ( u0_u1_csc[3:1] == 3'h0 ) ) & u0_u1_csc[0] ) &  !( u0_u1_inited) ) 
            begin
                u0_u1_init_req <= 1'b1;
            end
            else
            begin 
                if ( u0_spec_req_cs[1] & ( u0_init_ack_r &  !( u5_init_ack) ) ) 
                begin
                    u0_u1_init_req <= 1'b0;
                end
            end
        end
    end
    always @ (  posedge clk_i or  posedge rst_i)
    begin
        if ( rst_i ) 
        begin
            u0_u1_inited <= 1'b0;
        end
        else
        begin 
            if ( u0_spec_req_cs[1] & ( u0_init_ack_r &  !( u5_init_ack) ) ) 
            begin
                u0_u1_inited <= 1'b1;
            end
        end
    end
    assign u0_u1_cs_d = ( ( ( u0_u1_csc[23:16] & u0_u1_csc_mask[7:0] ) == ( wb_addr_i[28:21] & u0_u1_csc_mask[7:0] ) ) & u0_u1_csc[0] );
    assign u0_u1_wp = ( wb_we_i & u0_u1_csc[8] );
    assign u0_u1_wp_err = ( ( ( ( u0_u1_csc[23:16] & u0_u1_csc_mask[7:0] ) == ( wb_addr_i[28:21] & u0_u1_csc_mask[7:0] ) ) & u0_u1_csc[0] ) & ( wb_we_i & u0_u1_csc[8] ) );
    assign u0_u1_cs = ( ( ( ( u0_u1_csc[23:16] & u0_u1_csc_mask[7:0] ) == ( wb_addr_i[28:21] & u0_u1_csc_mask[7:0] ) ) & u0_u1_csc[0] ) &  !( ( wb_we_i & u0_u1_csc[8] )) );
    assign u0_csc2 = 32'h0;
    assign u0_u2_csc = 32'h0;
    assign u0_u2_tms = 32'h0;
    assign u0_u2_cs = 1'b0;
    assign u0_u2_wp_err = 1'b0;
    assign u0_u2_lmr_req = 1'b0;
    assign u0_u2_init_req = 1'b0;
    assign u0_csc3 = 32'h0;
    assign u0_u3_csc = 32'h0;
    assign u0_u3_tms = 32'h0;
    assign u0_u3_cs = 1'b0;
    assign u0_u3_wp_err = 1'b0;
    assign u0_u3_lmr_req = 1'b0;
    assign u0_u3_init_req = 1'b0;
    assign u0_csc4 = 32'h0;
    assign u0_u4_csc = 32'h0;
    assign u0_u4_tms = 32'h0;
    assign u0_u4_cs = 1'b0;
    assign u0_u4_wp_err = 1'b0;
    assign u0_u4_lmr_req = 1'b0;
    assign u0_u4_init_req = 1'b0;
    assign u0_csc5 = 32'h0;
    assign u0_u5_csc = 32'h0;
    assign u0_u5_tms = 32'h0;
    assign u0_u5_cs = 1'b0;
    assign u0_u5_wp_err = 1'b0;
    assign u0_u5_lmr_req = 1'b0;
    assign u0_u5_init_req = 1'b0;
    assign u0_csc6 = 32'h0;
    assign u0_u6_csc = 32'h0;
    assign u0_u6_tms = 32'h0;
    assign u0_u6_cs = 1'b0;
    assign u0_u6_wp_err = 1'b0;
    assign u0_u6_lmr_req = 1'b0;
    assign u0_u6_init_req = 1'b0;
    assign u0_csc7 = 32'h0;
    assign u0_u7_csc = 32'h0;
    assign u0_u7_tms = 32'h0;
    assign u0_u7_cs = 1'b0;
    assign u0_u7_wp_err = 1'b0;
    assign u0_u7_lmr_req = 1'b0;
    assign u0_u7_init_req = 1'b0;
    assign u1_csc = ( ( ( u5_lmr_ack | u5_init_ack ) ) ? ( u0_sp_csc ) : ( u0_csc ) );
    assign u1_tms = ( ( ( u5_lmr_ack | u5_init_ack ) ) ? ( u0_sp_tms ) : ( u0_tms ) );
    always @ (  u1_csc[3:1] or  u6_wr_hold or  { u1_bank_adr, ( ( ( ( u5_lmr_ack | u5_init_ack ) &  !( u5_temp_cs[1]) ) ) ? ( u1_tms[12:0] ) : ( ( ( u5_row_sel ) ? ( u1_row_adr ) : ( { 2'h0, u5_cmd_a10, u1_col_adr } ) ) ) ) } or  u1_acs_addr or  u1_sram_addr or  wb_addr_i)
    begin
        if ( u1_csc[3:1] == 3'h0 ) 
        begin
            u1_mc_addr_d = { 9'h0, { u1_bank_adr, ( ( ( ( u5_lmr_ack | u5_init_ack ) &  !( u5_temp_cs[1]) ) ) ? ( u1_tms[12:0] ) : ( ( ( u5_row_sel ) ? ( u1_row_adr ) : ( { 2'h0, u5_cmd_a10, u1_col_adr } ) ) ) ) } };
        end
        else
        begin 
            if ( u1_csc[3:1] == 3'h2 ) 
            begin
                u1_mc_addr_d = u1_acs_addr;
            end
            else
            begin 
                if ( ( u1_csc[3:1] == 3'h1 ) & u6_wr_hold ) 
                begin
                    u1_mc_addr_d = u1_sram_addr;
                end
                else
                begin 
                    u1_mc_addr_d = wb_addr_i[25:2];
                end
            end
        end
    end
    assign u1_u0_inc_in = u1_acs_addr;
    always @ (  posedge clk_i)
    begin
        u1_u0_out_r <= ( { 1'b0, u1_u0_inc_in[( u1_u0_incN_center - 1 ):0] } + { 1'b0, u1_u0_tmp_zeros[( u1_u0_incN_center - 2 ):0], 1'h1 } );
    end
    assign u1_u0_inc_next = ( ( u1_u0_out_r[u1_u0_incN_center] ) ? ( { u1_u0_tmp_zeros[( u1_u0_incN_center - 2 ):0], 1'h1 } ) : ( u1_u0_tmp_zeros[( u1_u0_incN_center - 2 ):0] ) );
    always @ (  posedge clk_i)
    begin
        if ( wb_stb_i ) 
        begin
            u1_sram_addr <= wb_addr_i[25:2];
        end
    end
    always @ (  posedge clk_i)
    begin
        if ( u5_cs_le | wb_we_i ) 
        begin
            case ( u1_csc[5:4] ) 
            2'h0:
            begin
                u1_acs_addr <= wb_addr_i[23:0];
            end
            2'h1:
            begin
                u1_acs_addr <= wb_addr_i[24:1];
            end
            2'h2:
            begin
                u1_acs_addr <= wb_addr_i[25:2];
            end
            endcase
        end
        else
        begin 
            if ( u5_next_adr ) 
            begin
                u1_acs_addr <= { ( u1_u0_inc_in[( u1_u0_incN_width - 1 ):u1_u0_incN_center] + u1_u0_inc_next ), u1_u0_out_r };
            end
        end
    end
    always @ (  posedge clk_i)
    begin
        if ( ( ( u5_wr_cycle ) ? ( mem_ack_r ) : ( wb_stb_i ) ) ) 
        begin
            casex ( { u1_csc[5:4], u1_csc[7:6] } ) 
            { 2'h0, 2'h0 }:
            begin
                u1_col_adr <= { 1'h0, wb_addr_i[10:2] };
            end
            { 2'h0, 2'h1 }:
            begin
                u1_col_adr <= wb_addr_i[11:2];
            end
            { 2'h0, 2'h2 }:
            begin
                u1_col_adr <= wb_addr_i[11:2];
            end
            { 2'h1, 2'h0 }:
            begin
                u1_col_adr <= { 2'h0, wb_addr_i[9:2] };
            end
            { 2'h1, 2'h1 }:
            begin
                u1_col_adr <= { 1'h0, wb_addr_i[10:2] };
            end
            { 2'h1, 2'h2 }:
            begin
                u1_col_adr <= { 1'h0, wb_addr_i[10:2] };
            end
            { 2'h2, 2'h0 }:
            begin
                u1_col_adr <= { 2'h0, wb_addr_i[9:2] };
            end
            { 2'h2, 2'h1 }:
            begin
                u1_col_adr <= { 2'h0, wb_addr_i[9:2] };
            end
            { 2'h2, 2'h2 }:
            begin
                u1_col_adr <= { 2'h0, wb_addr_i[9:2] };
            end
            endcase
        end
    end
    always @ (  posedge clk_i)
    begin
        if ( u5_cs_le ) 
        begin
            if (  !( u1_csc[9]) ) 
            begin
                casex ( { u1_csc[5:4], u1_csc[7:6] } ) 
                { 2'h0, 2'h0 }:
                begin
                    u1_row_adr <= { 1'h0, wb_addr_i[24:13] };
                end
                { 2'h0, 2'h1 }:
                begin
                    u1_row_adr <= { 1'h0, wb_addr_i[25:14] };
                end
                { 2'h0, 2'h2 }:
                begin
                    u1_row_adr <= wb_addr_i[26:14];
                end
                { 2'h1, 2'h0 }:
                begin
                    u1_row_adr <= { 1'h0, wb_addr_i[23:12] };
                end
                { 2'h1, 2'h1 }:
                begin
                    u1_row_adr <= { 1'h0, wb_addr_i[24:13] };
                end
                { 2'h1, 2'h2 }:
                begin
                    u1_row_adr <= wb_addr_i[25:13];
                end
                { 2'h2, 2'h0 }:
                begin
                    u1_row_adr <= { 2'h0, wb_addr_i[22:12] };
                end
                { 2'h2, 2'h1 }:
                begin
                    u1_row_adr <= { 1'h0, wb_addr_i[23:12] };
                end
                { 2'h2, 2'h2 }:
                begin
                    u1_row_adr <= wb_addr_i[24:12];
                end
                endcase
            end
            else
            begin 
                casex ( { u1_csc[5:4], u1_csc[7:6] } ) 
                { 2'h0, 2'h0 }:
                begin
                    u1_row_adr <= { 1'h0, wb_addr_i[22:11] };
                end
                { 2'h0, 2'h1 }:
                begin
                    u1_row_adr <= { 1'h0, wb_addr_i[23:12] };
                end
                { 2'h0, 2'h2 }:
                begin
                    u1_row_adr <= wb_addr_i[24:12];
                end
                { 2'h1, 2'h0 }:
                begin
                    u1_row_adr <= { 1'h0, wb_addr_i[21:10] };
                end
                { 2'h1, 2'h1 }:
                begin
                    u1_row_adr <= { 1'h0, wb_addr_i[22:11] };
                end
                { 2'h1, 2'h2 }:
                begin
                    u1_row_adr <= wb_addr_i[23:11];
                end
                { 2'h2, 2'h0 }:
                begin
                    u1_row_adr <= { 2'h0, wb_addr_i[20:10] };
                end
                { 2'h2, 2'h1 }:
                begin
                    u1_row_adr <= { 1'h0, wb_addr_i[21:10] };
                end
                { 2'h2, 2'h2 }:
                begin
                    u1_row_adr <= wb_addr_i[22:10];
                end
                endcase
            end
        end
    end
    always @ (  posedge clk_i)
    begin
        if ( u5_cs_le ) 
        begin
            if (  !( u1_csc[9]) ) 
            begin
                casex ( { u1_csc[5:4], u1_csc[7:6] } ) 
                { 2'h0, 2'h0 }:
                begin
                    u1_bank_adr <= wb_addr_i[12:11];
                end
                { 2'h0, 2'h1 }:
                begin
                    u1_bank_adr <= wb_addr_i[13:12];
                end
                { 2'h0, 2'h2 }:
                begin
                    u1_bank_adr <= wb_addr_i[13:12];
                end
                { 2'h1, 2'h0 }:
                begin
                    u1_bank_adr <= wb_addr_i[11:10];
                end
                { 2'h1, 2'h1 }:
                begin
                    u1_bank_adr <= wb_addr_i[12:11];
                end
                { 2'h1, 2'h2 }:
                begin
                    u1_bank_adr <= wb_addr_i[12:11];
                end
                { 2'h2, 2'h0 }:
                begin
                    u1_bank_adr <= wb_addr_i[11:10];
                end
                { 2'h2, 2'h1 }:
                begin
                    u1_bank_adr <= wb_addr_i[11:10];
                end
                { 2'h2, 2'h2 }:
                begin
                    u1_bank_adr <= wb_addr_i[11:10];
                end
                endcase
            end
            else
            begin 
                casex ( { u1_csc[5:4], u1_csc[7:6] } ) 
                { 2'h0, 2'h0 }:
                begin
                    u1_bank_adr <= wb_addr_i[24:23];
                end
                { 2'h0, 2'h1 }:
                begin
                    u1_bank_adr <= wb_addr_i[25:24];
                end
                { 2'h0, 2'h2 }:
                begin
                    u1_bank_adr <= wb_addr_i[26:25];
                end
                { 2'h1, 2'h0 }:
                begin
                    u1_bank_adr <= wb_addr_i[23:22];
                end
                { 2'h1, 2'h1 }:
                begin
                    u1_bank_adr <= wb_addr_i[24:23];
                end
                { 2'h1, 2'h2 }:
                begin
                    u1_bank_adr <= wb_addr_i[25:24];
                end
                { 2'h2, 2'h0 }:
                begin
                    u1_bank_adr <= wb_addr_i[22:21];
                end
                { 2'h2, 2'h1 }:
                begin
                    u1_bank_adr <= wb_addr_i[23:22];
                end
                { 2'h2, 2'h2 }:
                begin
                    u1_bank_adr <= wb_addr_i[24:23];
                end
                endcase
            end
        end
    end
    always @ (  u1_csc[5:4] or  u1_csc[7:6])
    begin
        casex ( { u1_csc[5:4], u1_csc[7:6] } ) 
        { 2'h0, 2'h0 }:
        begin
            u1_page_size = 11'd512;
        end
        { 2'h0, 2'h1 }:
        begin
            u1_page_size = 11'd1024;
        end
        { 2'h0, 2'h2 }:
        begin
            u1_page_size = 11'd1024;
        end
        { 2'h1, 2'h0 }:
        begin
            u1_page_size = 11'd256;
        end
        { 2'h1, 2'h1 }:
        begin
            u1_page_size = 11'd512;
        end
        { 2'h1, 2'h2 }:
        begin
            u1_page_size = 11'd512;
        end
        { 2'h2, 2'h0 }:
        begin
            u1_page_size = 11'd256;
        end
        { 2'h2, 2'h1 }:
        begin
            u1_page_size = 11'd256;
        end
        { 2'h2, 2'h2 }:
        begin
            u1_page_size = 11'd256;
        end
        endcase
    end
    assign u2_cs = ( ( ( u5_rfr_ack_r | u5_susp_sel_r ) ) ? ( { ( u0_csc7[0] & ( u0_csc7[3:1] == 3'h0 ) ), ( u0_csc6[0] & ( u0_csc6[3:1] == 3'h0 ) ), ( u0_csc5[0] & ( u0_csc5[3:1] == 3'h0 ) ), ( u0_csc4[0] & ( u0_csc4[3:1] == 3'h0 ) ), ( u0_csc3[0] & ( u0_csc3[3:1] == 3'h0 ) ), ( u0_csc2[0] & ( u0_csc2[3:1] == 3'h0 ) ), ( u0_u1_csc[0] & ( u0_u1_csc[3:1] == 3'h0 ) ), ( u0_u0_csc[0] & ( u0_u0_csc[3:1] == 3'h0 ) ) } ) : ( ( ( ( u5_lmr_ack | u5_init_ack ) ) ? ( u0_spec_req_cs ) : ( u0_cs ) ) ) );
    always @ (  posedge clk_i)
    begin
        u2_bank_open <= ( ( ( ( ( ( ( ( u2_cs[0] & u2_u0_bank_open ) | ( u2_cs[1] & u2_u1_bank_open ) ) | ( u2_cs[2] & u2_u2_bank_open ) ) | ( u2_cs[3] & u2_u3_bank_open ) ) | ( u2_cs[4] & u2_u4_bank_open ) ) | ( u2_cs[5] & u2_u5_bank_open ) ) | ( u2_cs[6] & u2_u6_bank_open ) ) | ( u2_cs[7] & u2_u7_bank_open ) );
    end
    always @ (  posedge clk_i)
    begin
        u2_row_same <= ( ( ( ( ( ( ( ( u2_cs[0] & u2_u0_row_same ) | ( u2_cs[1] & u2_u1_row_same ) ) | ( u2_cs[2] & u2_u2_row_same ) ) | ( u2_cs[3] & u2_u3_row_same ) ) | ( u2_cs[4] & u2_u4_row_same ) ) | ( u2_cs[5] & u2_u5_row_same ) ) | ( u2_cs[6] & u2_u6_row_same ) ) | ( u2_cs[7] & u2_u7_row_same ) );
    end
    always @ (  posedge clk_i)
    begin
        u2_any_bank_open <= ( ( ( ( ( ( ( ( u2_cs[0] & u2_u0_any_bank_open ) | ( u2_cs[1] & u2_u1_any_bank_open ) ) | ( u2_cs[2] & u2_u2_any_bank_open ) ) | ( u2_cs[3] & u2_u3_any_bank_open ) ) | ( u2_cs[4] & u2_u4_any_bank_open ) ) | ( u2_cs[5] & u2_u5_any_bank_open ) ) | ( u2_cs[6] & u2_u6_any_bank_open ) ) | ( u2_cs[7] & u2_u7_any_bank_open ) );
    end
    always @ (  posedge clk_i or  posedge rst_i)
    begin
        if ( rst_i ) 
        begin
            u2_u0_bank0_open <= 1'b0;
        end
        else
        begin 
            if ( ( u1_bank_adr == 2'h0 ) & ( u2_cs[0] & u5_bank_set ) ) 
            begin
                u2_u0_bank0_open <= 1'b1;
            end
            else
            begin 
                if ( ( u1_bank_adr == 2'h0 ) & ( u2_cs[0] & u5_bank_clr ) ) 
                begin
                    u2_u0_bank0_open <= 1'b0;
                end
                else
                begin 
                    if ( ( u2_cs[0] & u5_bank_clr_all ) | u5_rfr_ack ) 
                    begin
                        u2_u0_bank0_open <= 1'b0;
                    end
                end
            end
        end
    end
    always @ (  posedge clk_i or  posedge rst_i)
    begin
        if ( rst_i ) 
        begin
            u2_u0_bank1_open <= 1'b0;
        end
        else
        begin 
            if ( ( u1_bank_adr == 2'h1 ) & ( u2_cs[0] & u5_bank_set ) ) 
            begin
                u2_u0_bank1_open <= 1'b1;
            end
            else
            begin 
                if ( ( u1_bank_adr == 2'h1 ) & ( u2_cs[0] & u5_bank_clr ) ) 
                begin
                    u2_u0_bank1_open <= 1'b0;
                end
                else
                begin 
                    if ( ( u2_cs[0] & u5_bank_clr_all ) | u5_rfr_ack ) 
                    begin
                        u2_u0_bank1_open <= 1'b0;
                    end
                end
            end
        end
    end
    always @ (  posedge clk_i or  posedge rst_i)
    begin
        if ( rst_i ) 
        begin
            u2_u0_bank2_open <= 1'b0;
        end
        else
        begin 
            if ( ( u1_bank_adr == 2'h2 ) & ( u2_cs[0] & u5_bank_set ) ) 
            begin
                u2_u0_bank2_open <= 1'b1;
            end
            else
            begin 
                if ( ( u1_bank_adr == 2'h2 ) & ( u2_cs[0] & u5_bank_clr ) ) 
                begin
                    u2_u0_bank2_open <= 1'b0;
                end
                else
                begin 
                    if ( ( u2_cs[0] & u5_bank_clr_all ) | u5_rfr_ack ) 
                    begin
                        u2_u0_bank2_open <= 1'b0;
                    end
                end
            end
        end
    end
    always @ (  posedge clk_i or  posedge rst_i)
    begin
        if ( rst_i ) 
        begin
            u2_u0_bank3_open <= 1'b0;
        end
        else
        begin 
            if ( ( u1_bank_adr == 2'h3 ) & ( u2_cs[0] & u5_bank_set ) ) 
            begin
                u2_u0_bank3_open <= 1'b1;
            end
            else
            begin 
                if ( ( u1_bank_adr == 2'h3 ) & ( u2_cs[0] & u5_bank_clr ) ) 
                begin
                    u2_u0_bank3_open <= 1'b0;
                end
                else
                begin 
                    if ( ( u2_cs[0] & u5_bank_clr_all ) | u5_rfr_ack ) 
                    begin
                        u2_u0_bank3_open <= 1'b0;
                    end
                end
            end
        end
    end
    always @ (  u1_bank_adr or  u2_u0_bank0_open or  u2_u0_bank1_open or  u2_u0_bank2_open or  u2_u0_bank3_open)
    begin
        case ( u1_bank_adr ) 
        2'h0:
        begin
            u2_u0_bank_open = u2_u0_bank0_open;
        end
        2'h1:
        begin
            u2_u0_bank_open = u2_u0_bank1_open;
        end
        2'h2:
        begin
            u2_u0_bank_open = u2_u0_bank2_open;
        end
        2'h3:
        begin
            u2_u0_bank_open = u2_u0_bank3_open;
        end
        endcase
    end
    assign u2_u0_any_bank_open = ( ( ( u2_u0_bank0_open | u2_u0_bank1_open ) | u2_u0_bank2_open ) | u2_u0_bank3_open );
    always @ (  posedge clk_i)
    begin
        if ( ( u1_bank_adr == 2'h0 ) & ( u2_cs[0] & u5_bank_set ) ) 
        begin
            u2_u0_b0_last_row <= u1_row_adr;
        end
    end
    always @ (  posedge clk_i)
    begin
        if ( ( u1_bank_adr == 2'h1 ) & ( u2_cs[0] & u5_bank_set ) ) 
        begin
            u2_u0_b1_last_row <= u1_row_adr;
        end
    end
    always @ (  posedge clk_i)
    begin
        if ( ( u1_bank_adr == 2'h2 ) & ( u2_cs[0] & u5_bank_set ) ) 
        begin
            u2_u0_b2_last_row <= u1_row_adr;
        end
    end
    always @ (  posedge clk_i)
    begin
        if ( ( u1_bank_adr == 2'h3 ) & ( u2_cs[0] & u5_bank_set ) ) 
        begin
            u2_u0_b3_last_row <= u1_row_adr;
        end
    end
    always @ (  u1_bank_adr or  ( u2_u0_b0_last_row == u1_row_adr ) or  ( u2_u0_b1_last_row == u1_row_adr ) or  ( u2_u0_b2_last_row == u1_row_adr ) or  ( u2_u0_b3_last_row == u1_row_adr ))
    begin
        case ( u1_bank_adr ) 
        2'h0:
        begin
            u2_u0_row_same = ( u2_u0_b0_last_row == u1_row_adr );
        end
        2'h1:
        begin
            u2_u0_row_same = ( u2_u0_b1_last_row == u1_row_adr );
        end
        2'h2:
        begin
            u2_u0_row_same = ( u2_u0_b2_last_row == u1_row_adr );
        end
        2'h3:
        begin
            u2_u0_row_same = ( u2_u0_b3_last_row == u1_row_adr );
        end
        endcase
    end
    always @ (  posedge clk_i or  posedge rst_i)
    begin
        if ( rst_i ) 
        begin
            u2_u1_bank0_open <= 1'b0;
        end
        else
        begin 
            if ( ( u1_bank_adr == 2'h0 ) & ( u2_cs[1] & u5_bank_set ) ) 
            begin
                u2_u1_bank0_open <= 1'b1;
            end
            else
            begin 
                if ( ( u1_bank_adr == 2'h0 ) & ( u2_cs[1] & u5_bank_clr ) ) 
                begin
                    u2_u1_bank0_open <= 1'b0;
                end
                else
                begin 
                    if ( ( u2_cs[1] & u5_bank_clr_all ) | u5_rfr_ack ) 
                    begin
                        u2_u1_bank0_open <= 1'b0;
                    end
                end
            end
        end
    end
    always @ (  posedge clk_i or  posedge rst_i)
    begin
        if ( rst_i ) 
        begin
            u2_u1_bank1_open <= 1'b0;
        end
        else
        begin 
            if ( ( u1_bank_adr == 2'h1 ) & ( u2_cs[1] & u5_bank_set ) ) 
            begin
                u2_u1_bank1_open <= 1'b1;
            end
            else
            begin 
                if ( ( u1_bank_adr == 2'h1 ) & ( u2_cs[1] & u5_bank_clr ) ) 
                begin
                    u2_u1_bank1_open <= 1'b0;
                end
                else
                begin 
                    if ( ( u2_cs[1] & u5_bank_clr_all ) | u5_rfr_ack ) 
                    begin
                        u2_u1_bank1_open <= 1'b0;
                    end
                end
            end
        end
    end
    always @ (  posedge clk_i or  posedge rst_i)
    begin
        if ( rst_i ) 
        begin
            u2_u1_bank2_open <= 1'b0;
        end
        else
        begin 
            if ( ( u1_bank_adr == 2'h2 ) & ( u2_cs[1] & u5_bank_set ) ) 
            begin
                u2_u1_bank2_open <= 1'b1;
            end
            else
            begin 
                if ( ( u1_bank_adr == 2'h2 ) & ( u2_cs[1] & u5_bank_clr ) ) 
                begin
                    u2_u1_bank2_open <= 1'b0;
                end
                else
                begin 
                    if ( ( u2_cs[1] & u5_bank_clr_all ) | u5_rfr_ack ) 
                    begin
                        u2_u1_bank2_open <= 1'b0;
                    end
                end
            end
        end
    end
    always @ (  posedge clk_i or  posedge rst_i)
    begin
        if ( rst_i ) 
        begin
            u2_u1_bank3_open <= 1'b0;
        end
        else
        begin 
            if ( ( u1_bank_adr == 2'h3 ) & ( u2_cs[1] & u5_bank_set ) ) 
            begin
                u2_u1_bank3_open <= 1'b1;
            end
            else
            begin 
                if ( ( u1_bank_adr == 2'h3 ) & ( u2_cs[1] & u5_bank_clr ) ) 
                begin
                    u2_u1_bank3_open <= 1'b0;
                end
                else
                begin 
                    if ( ( u2_cs[1] & u5_bank_clr_all ) | u5_rfr_ack ) 
                    begin
                        u2_u1_bank3_open <= 1'b0;
                    end
                end
            end
        end
    end
    always @ (  u1_bank_adr or  u2_u1_bank0_open or  u2_u1_bank1_open or  u2_u1_bank2_open or  u2_u1_bank3_open)
    begin
        case ( u1_bank_adr ) 
        2'h0:
        begin
            u2_u1_bank_open = u2_u1_bank0_open;
        end
        2'h1:
        begin
            u2_u1_bank_open = u2_u1_bank1_open;
        end
        2'h2:
        begin
            u2_u1_bank_open = u2_u1_bank2_open;
        end
        2'h3:
        begin
            u2_u1_bank_open = u2_u1_bank3_open;
        end
        endcase
    end
    assign u2_u1_any_bank_open = ( ( ( u2_u1_bank0_open | u2_u1_bank1_open ) | u2_u1_bank2_open ) | u2_u1_bank3_open );
    always @ (  posedge clk_i)
    begin
        if ( ( u1_bank_adr == 2'h0 ) & ( u2_cs[1] & u5_bank_set ) ) 
        begin
            u2_u1_b0_last_row <= u1_row_adr;
        end
    end
    always @ (  posedge clk_i)
    begin
        if ( ( u1_bank_adr == 2'h1 ) & ( u2_cs[1] & u5_bank_set ) ) 
        begin
            u2_u1_b1_last_row <= u1_row_adr;
        end
    end
    always @ (  posedge clk_i)
    begin
        if ( ( u1_bank_adr == 2'h2 ) & ( u2_cs[1] & u5_bank_set ) ) 
        begin
            u2_u1_b2_last_row <= u1_row_adr;
        end
    end
    always @ (  posedge clk_i)
    begin
        if ( ( u1_bank_adr == 2'h3 ) & ( u2_cs[1] & u5_bank_set ) ) 
        begin
            u2_u1_b3_last_row <= u1_row_adr;
        end
    end
    always @ (  u1_bank_adr or  ( u2_u1_b0_last_row == u1_row_adr ) or  ( u2_u1_b1_last_row == u1_row_adr ) or  ( u2_u1_b2_last_row == u1_row_adr ) or  ( u2_u1_b3_last_row == u1_row_adr ))
    begin
        case ( u1_bank_adr ) 
        2'h0:
        begin
            u2_u1_row_same = ( u2_u1_b0_last_row == u1_row_adr );
        end
        2'h1:
        begin
            u2_u1_row_same = ( u2_u1_b1_last_row == u1_row_adr );
        end
        2'h2:
        begin
            u2_u1_row_same = ( u2_u1_b2_last_row == u1_row_adr );
        end
        2'h3:
        begin
            u2_u1_row_same = ( u2_u1_b3_last_row == u1_row_adr );
        end
        endcase
    end
    assign u2_u2_bank_open = 1'b0;
    assign u2_u2_any_bank_open = 1'b0;
    assign u2_u2_row_same = 1'b0;
    assign u2_u3_bank_open = 1'b0;
    assign u2_u3_any_bank_open = 1'b0;
    assign u2_u3_row_same = 1'b0;
    assign u2_u4_bank_open = 1'b0;
    assign u2_u4_any_bank_open = 1'b0;
    assign u2_u4_row_same = 1'b0;
    assign u2_u5_bank_open = 1'b0;
    assign u2_u5_any_bank_open = 1'b0;
    assign u2_u5_row_same = 1'b0;
    assign u2_u6_bank_open = 1'b0;
    assign u2_u6_any_bank_open = 1'b0;
    assign u2_u6_row_same = 1'b0;
    assign u2_u7_bank_open = 1'b0;
    assign u2_u7_any_bank_open = 1'b0;
    assign u2_u7_row_same = 1'b0;
    assign u3_mem_ack = ( ( u5_mem_ack_d | ( ( ( ( ( u5_ack_cnt != 4'h0 ) &  !( u5_wb_wait) ) &  !( u5_mem_ack_r) ) & u5_wb_read_go ) &  !( ( u5_wb_we_i & u5_wb_stb_i )) ) ) & ( u6_wb_read_go | u6_wb_write_go ) );
    assign u3_wb_we_i = wb_we_i;
    assign u3_pen = u0_csc[11];
    always @ (  u0_csc[3:1] or  u3_u0_dout or  u3_mc_data_d)
    begin
        if ( ( u0_csc[3:1] == 3'h0 ) | ( u0_csc[3:1] == 3'h1 ) ) 
        begin
            u3_wb_data_o = u3_u0_dout[31:0];
        end
        else
        begin 
            u3_wb_data_o = u3_mc_data_d;
        end
    end
    always @ (  posedge clk_i or  posedge rst_i)
    begin
        if ( rst_i ) 
        begin
            u3_u0_rd_adr <= 4'h1;
        end
        else
        begin 
            if (  !( wb_cyc_i) | ( wb_we_i & wb_stb_i ) ) 
            begin
                u3_u0_rd_adr <= 4'h1;
            end
            else
            begin 
                if ( mem_ack_r & u6_wb_read_go ) 
                begin
                    u3_u0_rd_adr <= { u3_u0_rd_adr[2:0], u3_u0_rd_adr[3] };
                end
            end
        end
    end
    always @ (  posedge clk_i or  posedge rst_i)
    begin
        if ( rst_i ) 
        begin
            u3_u0_wr_adr <= 4'h1;
        end
        else
        begin 
            if (  !( wb_cyc_i) | ( wb_we_i & wb_stb_i ) ) 
            begin
                u3_u0_wr_adr <= 4'h1;
            end
            else
            begin 
                if ( u5_dv ) 
                begin
                    u3_u0_wr_adr <= { u3_u0_wr_adr[2:0], u3_u0_wr_adr[3] };
                end
            end
        end
    end
    always @ (  posedge clk_i)
    begin
        if ( u5_dv & u3_u0_wr_adr[0] ) 
        begin
            u3_u0_r0 <= u7_mc_data_ir;
        end
    end
    always @ (  posedge clk_i)
    begin
        if ( u5_dv & u3_u0_wr_adr[1] ) 
        begin
            u3_u0_r1 <= u7_mc_data_ir;
        end
    end
    always @ (  posedge clk_i)
    begin
        if ( u5_dv & u3_u0_wr_adr[2] ) 
        begin
            u3_u0_r2 <= u7_mc_data_ir;
        end
    end
    always @ (  posedge clk_i)
    begin
        if ( u5_dv & u3_u0_wr_adr[3] ) 
        begin
            u3_u0_r3 <= u7_mc_data_ir;
        end
    end
    always @ (  u3_u0_rd_adr or  u3_u0_r0 or  u3_u0_r1 or  u3_u0_r2 or  u3_u0_r3 or  ( mem_ack_r & u6_wb_read_go ) or  u5_dv or  u7_mc_data_ir)
    begin
        case ( u3_u0_rd_adr ) 
        4'h1:
        begin
            u3_u0_dout = u3_u0_r0;
        end
        4'h2:
        begin
            u3_u0_dout = u3_u0_r1;
        end
        4'h4:
        begin
            u3_u0_dout = u3_u0_r2;
        end
        4'h8:
        begin
            u3_u0_dout = u3_u0_r3;
        end
        endcase
    end
    always @ (  posedge clk_i)
    begin
        if ( mem_ack_r | ( u0_csc[3:1] != 3'h0 ) ) 
        begin
            u3_mc_data_o <= wb_data_i;
        end
    end
    always @ (  posedge clk_i)
    begin
        if ( u5_pack_le0 ) 
        begin
            u3_byte0 <= u7_mc_data_ir[7:0];
        end
    end
    always @ (  posedge clk_i)
    begin
        if ( u5_pack_le1 & ( u0_csc[5:4] == 2'h0 ) ) 
        begin
            u3_byte1 <= u7_mc_data_ir[7:0];
        end
        else
        begin 
            if ( u5_pack_le0 & ( u0_csc[5:4] == 2'h1 ) ) 
            begin
                u3_byte1 <= u7_mc_data_ir[15:8];
            end
        end
    end
    always @ (  posedge clk_i)
    begin
        if ( u5_pack_le2 ) 
        begin
            u3_byte2 <= u7_mc_data_ir[7:0];
        end
    end
    always @ (  u0_csc[5:4] or  u7_mc_data_ir or  u3_byte0 or  u3_byte1 or  u3_byte2)
    begin
        if ( u0_csc[5:4] == 2'h0 ) 
        begin
            u3_mc_data_d = { u7_mc_data_ir[7:0], u3_byte2, u3_byte1, u3_byte0 };
        end
        else
        begin 
            if ( u0_csc[5:4] == 2'h1 ) 
            begin
                u3_mc_data_d = { u7_mc_data_ir[15:0], u3_byte1, u3_byte0 };
            end
            else
            begin 
                u3_mc_data_d = u7_mc_data_ir[31:0];
            end
        end
    end
    always @ (  posedge clk_i)
    begin
        if ( mem_ack_r | ( u0_csc[3:1] != 3'h0 ) ) 
        begin
            u3_mc_dp_o <= 4'b1010;
        end
    end
    assign u4_rfr_ps_val = u0_csr_r2[7:0];
    always @ (  posedge clk_i or  posedge rst_i)
    begin
        if ( rst_i ) 
        begin
            u4_rfr_en <= 1'b0;
        end
        else
        begin 
            u4_rfr_en <=  |( { ( u0_csc7[0] & ( u0_csc7[3:1] == 3'h0 ) ), ( u0_csc6[0] & ( u0_csc6[3:1] == 3'h0 ) ), ( u0_csc5[0] & ( u0_csc5[3:1] == 3'h0 ) ), ( u0_csc4[0] & ( u0_csc4[3:1] == 3'h0 ) ), ( u0_csc3[0] & ( u0_csc3[3:1] == 3'h0 ) ), ( u0_csc2[0] & ( u0_csc2[3:1] == 3'h0 ) ), ( u0_csc1[0] & ( u0_csc1[3:1] == 3'h0 ) ), ( u0_csc0[0] & ( u0_csc0[3:1] == 3'h0 ) ) });
        end
    end
    always @ (  posedge clk_i or  posedge rst_i)
    begin
        if ( rst_i ) 
        begin
            u4_ps_cnt <= 8'h0;
        end
        else
        begin 
            if ( ( u4_ps_cnt == u4_rfr_ps_val ) & ( u4_rfr_ps_val != 8'h0 ) ) 
            begin
                u4_ps_cnt <= 8'h0;
            end
            else
            begin 
                if ( u4_rfr_en ) 
                begin
                    u4_ps_cnt <= ( u4_ps_cnt + 8'h1 );
                end
            end
        end
    end
    always @ (  posedge clk_i or  posedge rst_i)
    begin
        if ( rst_i ) 
        begin
            u4_rfr_early <= 1'b0;
        end
        else
        begin 
            u4_rfr_early <= ( u4_ps_cnt == u0_csr_r2[7:0] );
        end
    end
    always @ (  posedge clk_i or  posedge rst_i)
    begin
        if ( rst_i ) 
        begin
            u4_rfr_ce <= 1'b0;
        end
        else
        begin 
            u4_rfr_ce <= ( ( u4_ps_cnt == u0_csr_r2[7:0] ) & ( u0_csr_r2[7:0] != 8'h0 ) );
        end
    end
    always @ (  posedge clk_i or  posedge rst_i)
    begin
        if ( rst_i ) 
        begin
            u4_rfr_cnt <= 8'h0;
        end
        else
        begin 
            if ( u5_rfr_ack ) 
            begin
                u4_rfr_cnt <= 8'h0;
            end
            else
            begin 
                if ( u4_rfr_ce ) 
                begin
                    u4_rfr_cnt <= ( u4_rfr_cnt + 8'h1 );
                end
            end
        end
    end
    always @ (  posedge clk_i)
    begin
        case ( u0_csr_r[10:8] ) 
        3'h0:
        begin
            u4_rfr_clr <= ( u4_rfr_cnt[0] & u4_rfr_early );
        end
        3'h1:
        begin
            u4_rfr_clr <= (  &( u4_rfr_cnt[1:0]) & u4_rfr_early );
        end
        3'h2:
        begin
            u4_rfr_clr <= (  &( u4_rfr_cnt[2:0]) & u4_rfr_early );
        end
        3'h3:
        begin
            u4_rfr_clr <= (  &( u4_rfr_cnt[3:0]) & u4_rfr_early );
        end
        3'h4:
        begin
            u4_rfr_clr <= (  &( u4_rfr_cnt[4:0]) & u4_rfr_early );
        end
        3'h5:
        begin
            u4_rfr_clr <= (  &( u4_rfr_cnt[5:0]) & u4_rfr_early );
        end
        3'h6:
        begin
            u4_rfr_clr <= (  &( u4_rfr_cnt[6:0]) & u4_rfr_early );
        end
        3'h7:
        begin
            u4_rfr_clr <= (  &( u4_rfr_cnt[7:0]) & u4_rfr_early );
        end
        endcase
    end
    always @ (  posedge clk_i or  posedge rst_i)
    begin
        if ( rst_i ) 
        begin
            u4_rfr_req <= 1'b0;
        end
        else
        begin 
            if ( u5_rfr_ack ) 
            begin
                u4_rfr_req <= 1'b0;
            end
            else
            begin 
                if ( u4_rfr_clr ) 
                begin
                    u4_rfr_req <= 1'b1;
                end
            end
        end
    end
    assign u5_wb_stb_i = wb_stb_i;
    assign u5_wb_we_i = wb_we_i;
    assign u5_wb_read_go = ( (  !( ( u6_rmw_r | ( ( ( (  !( u6_wr_hold) & wb_we_i ) & wb_cyc_i ) & wb_stb_i ) & u6_rmw_en ) )) & u6_read_go_r1 ) & wb_cyc_i );
    assign u5_wb_write_go = ( ( (  !( ( u6_rmw_r | ( ( ( (  !( u6_wr_hold) & wb_we_i ) & wb_cyc_i ) & wb_stb_i ) & u6_rmw_en ) )) & u6_write_go_r1 ) & wb_cyc_i ) & ( ( wb_we_i & wb_stb_i ) |  !( wb_stb_i) ) );
    assign u5_wb_wait = ( ( wb_cyc_i &  !( wb_stb_i) ) & ( ( ( (  !( ( u6_rmw_r | ( ( ( (  !( u6_wr_hold) & wb_we_i ) & wb_cyc_i ) & wb_stb_i ) & u6_rmw_en ) )) & u6_write_go_r1 ) & wb_cyc_i ) & ( ( wb_we_i & wb_stb_i ) |  !( wb_stb_i) ) ) | ( (  !( ( u6_rmw_r | ( ( ( (  !( u6_wr_hold) & wb_we_i ) & wb_cyc_i ) & wb_stb_i ) & u6_rmw_en ) )) & u6_read_go_r1 ) & wb_cyc_i ) ) );
    assign suspended_o = u5_suspended;
    assign u5_csc = ( ( ( u5_lmr_ack | u5_init_ack ) ) ? ( u0_sp_csc ) : ( u0_csc ) );
    assign u5_tms = ( ( ( u5_lmr_ack | u5_init_ack ) ) ? ( u0_sp_tms ) : ( u0_tms ) );
    assign rfr_ack = u5_rfr_ack_r;
    always @ (  posedge clk_i)
    begin
        u5_lmr_ack <= u5_lmr_ack_d;
    end
    assign u5_rfr_ack = u5_rfr_ack_r;
    always @ (  posedge clk_i)
    begin
        u5_cs_le_r <= u5_cs_le_r1;
    end
    always @ (  posedge clk_i)
    begin
        u5_cs_le_r1 <= u5_cs_le;
    end
    always @ (  posedge clk_i)
    begin
        u5_cs_le <= u5_cs_le_d;
    end
    always @ (  posedge mc_clk_i or  posedge rst_i)
    begin
        if ( rst_i ) 
        begin
            u5_rsts1 <= 1'b1;
        end
        else
        begin 
            u5_rsts1 <= 1'b0;
        end
    end
    always @ (  posedge clk_i or  posedge rst_i)
    begin
        if ( rst_i ) 
        begin
            u5_rsts <= 1'b1;
        end
        else
        begin 
            u5_rsts <= u5_rsts1;
        end
    end
    always @ (  posedge clk_i or  posedge rst_i)
    begin
        if ( rst_i ) 
        begin
            u5_mc_c_oe <= 1'b0;
        end
        else
        begin 
            u5_mc_c_oe <= u5_mc_c_oe_d;
        end
    end
    always @ (  posedge clk_i or  posedge u5_rsts)
    begin
        if ( u5_rsts ) 
        begin
            u5_mc_le <= 1'b0;
        end
        else
        begin 
            u5_mc_le <=  ~( u5_mc_le);
        end
    end
    always @ (  posedge clk_i)
    begin
        u5_pack_le0 <= u5_pack_le0_d;
    end
    always @ (  posedge clk_i)
    begin
        u5_pack_le1 <= u5_pack_le1_d;
    end
    always @ (  posedge clk_i)
    begin
        u5_pack_le2 <= u5_pack_le2_d;
    end
    always @ (  posedge clk_i or  posedge rst_i)
    begin
        if ( rst_i ) 
        begin
            u5_mc_adv_r1 <= 1'b0;
        end
        else
        begin 
            if (  !( u5_mc_le) ) 
            begin
                u5_mc_adv_r1 <= u5_mc_adv;
            end
        end
    end
    always @ (  posedge clk_i or  posedge rst_i)
    begin
        if ( rst_i ) 
        begin
            u5_mc_adv_r <= 1'b0;
        end
        else
        begin 
            if (  !( u5_mc_le) ) 
            begin
                u5_mc_adv_r <= u5_mc_adv_r1;
            end
        end
    end
    always @ (  posedge clk_i or  posedge rst_i)
    begin
        if ( rst_i ) 
        begin
            u5_mem_ack_r <= 1'b0;
        end
        else
        begin 
            u5_mem_ack_r <= ( ( u5_mem_ack_d | ( ( ( ( ( u5_ack_cnt != 4'h0 ) &  !( u5_wb_wait) ) &  !( u5_mem_ack_r) ) & u5_wb_read_go ) &  !( ( u5_wb_we_i & u5_wb_stb_i )) ) ) & ( u6_wb_read_go | u6_wb_write_go ) );
        end
    end
    always @ (  posedge clk_i or  posedge rst_i)
    begin
        if ( rst_i ) 
        begin
            u5_cmd_r <= 4'b0111;
        end
        else
        begin 
            u5_cmd_r <= u5_cmd;
        end
    end
    always @ (  posedge clk_i or  posedge rst_i)
    begin
        if ( rst_i ) 
        begin
            u5_cmd_del <= 4'b0111;
        end
        else
        begin 
            u5_cmd_del <= u5_cmd_r;
        end
    end
    assign u5_cas_ = u5_temp_cs[1];
    always @ (  posedge clk_i or  posedge rst_i)
    begin
        if ( rst_i ) 
        begin
            u5_cmd_asserted <= 1'b0;
        end
        else
        begin 
            if (  !( u5_mc_le) ) 
            begin
                u5_cmd_asserted <= u5_cmd[3];
            end
        end
    end
    always @ (  posedge clk_i or  posedge rst_i)
    begin
        if ( rst_i ) 
        begin
            u5_cmd_asserted2 <= 1'b0;
        end
        else
        begin 
            if (  !( u5_mc_le) ) 
            begin
                u5_cmd_asserted2 <= u5_cmd_asserted;
            end
        end
    end
    always @ (  posedge clk_i or  posedge rst_i)
    begin
        if ( rst_i ) 
        begin
            u5_oe_ <= 1'b1;
        end
        else
        begin 
            u5_oe_ <=  ~( u5_oe_d);
        end
    end
    always @ (  posedge clk_i or  posedge rst_i)
    begin
        if ( rst_i ) 
        begin
            u5_data_oe_r <= 1'b0;
        end
        else
        begin 
            u5_data_oe_r <= u5_data_oe_d;
        end
    end
    always @ (  posedge clk_i or  posedge rst_i)
    begin
        if ( rst_i ) 
        begin
            u5_data_oe_r2 <= 1'b0;
        end
        else
        begin 
            u5_data_oe_r2 <= u5_data_oe_r;
        end
    end
    always @ (  posedge clk_i or  posedge rst_i)
    begin
        if ( rst_i ) 
        begin
            u5_data_oe <= 1'b0;
        end
        else
        begin 
            u5_data_oe <= ( ( u5_wr_cycle ) ? ( u5_data_oe_r2 ) : ( u5_data_oe_d ) );
        end
    end
    always @ (  posedge clk_i)
    begin
        u5_cke_r <= u5_cke_d;
    end
    always @ (  posedge clk_i)
    begin
        u5_cke_ <= ( u5_cke_r & u5_cke_rd );
    end
    always @ (  posedge clk_i)
    begin
        u5_cke_o_r1 <= u5_cke_;
    end
    always @ (  posedge clk_i)
    begin
        u5_cke_o_r2 <= u5_cke_o_r1;
    end
    always @ (  posedge clk_i)
    begin
        u5_cke_o_del <= u5_cke_o_r2;
    end
    always @ (  posedge clk_i)
    begin
        u5_wb_wait_r2 <= u6_wb_wait;
    end
    always @ (  posedge clk_i)
    begin
        u5_wb_wait_r <= u5_wb_wait_r2;
    end
    always @ (  posedge clk_i or  posedge rst_i)
    begin
        if ( rst_i ) 
        begin
            u5_lookup_ready1 <= 1'b0;
        end
        else
        begin 
            u5_lookup_ready1 <= ( ( u5_cs_le & wb_cyc_i ) & wb_stb_i );
        end
    end
    always @ (  posedge clk_i or  posedge rst_i)
    begin
        if ( rst_i ) 
        begin
            u5_lookup_ready2 <= 1'b0;
        end
        else
        begin 
            u5_lookup_ready2 <= ( ( u5_lookup_ready1 & wb_cyc_i ) & wb_stb_i );
        end
    end
    always @ (  posedge clk_i or  posedge rst_i)
    begin
        if ( rst_i ) 
        begin
            u5_wr_cycle <= 1'b0;
        end
        else
        begin 
            if ( u5_wr_set ) 
            begin
                u5_wr_cycle <= 1'b1;
            end
            else
            begin 
                if ( u5_wr_clr ) 
                begin
                    u5_wr_cycle <= 1'b0;
                end
            end
        end
    end
    always @ (  posedge clk_i or  posedge rst_i)
    begin
        if ( rst_i ) 
        begin
            u5_wb_cycle <= 1'b0;
        end
        else
        begin 
            if ( u5_wb_cycle_set ) 
            begin
                u5_wb_cycle <= 1'b1;
            end
            else
            begin 
                if (  !( wb_cyc_i) | ( ( wb_cyc_i & wb_stb_i ) &  !( ( wb_addr_i[31:29] == 3'h0 )) ) ) 
                begin
                    u5_wb_cycle <= 1'b0;
                end
            end
        end
    end
    always @ (  posedge clk_i or  posedge rst_i)
    begin
        if ( rst_i ) 
        begin
            u5_no_wb_cycle <= 1'b0;
        end
        else
        begin 
            u5_no_wb_cycle <= (  !( u6_wb_read_go) &  !( u6_wb_write_go) );
        end
    end
    always @ (  posedge clk_i or  posedge rst_i)
    begin
        if ( rst_i ) 
        begin
            u5_ack_cnt <= 4'h0;
        end
        else
        begin 
            if ( u5_no_wb_cycle ) 
            begin
                u5_ack_cnt <= 4'h0;
            end
            else
            begin 
                if ( u5_dv &  !( ( ( ( ( ( u5_ack_cnt != 4'h0 ) &  !( u5_wb_wait) ) &  !( u5_mem_ack_r) ) & u5_wb_read_go ) &  !( ( u5_wb_we_i & u5_wb_stb_i )) )) ) 
                begin
                    u5_ack_cnt <= ( u5_ack_cnt + 4'h1 );
                end
                else
                begin 
                    if (  !( u5_dv) & ( ( ( ( ( u5_ack_cnt != 4'h0 ) &  !( u5_wb_wait) ) &  !( u5_mem_ack_r) ) & u5_wb_read_go ) &  !( ( u5_wb_we_i & u5_wb_stb_i )) ) ) 
                    begin
                        u5_ack_cnt <= ( u5_ack_cnt - 4'h1 );
                    end
                end
            end
        end
    end
    assign u5_mem_ack_s = ( ( ( ( ( u5_ack_cnt != 4'h0 ) &  !( u6_wb_wait) ) &  !( u5_mem_ack_r) ) & u6_wb_read_go ) &  !( ( wb_we_i & wb_stb_i )) );
    always @ (  posedge clk_i)
    begin
        u5_cnt <= u5_cnt_next;
    end
    always @ (  posedge clk_i or  posedge rst_i)
    begin
        if ( rst_i ) 
        begin
            u5_susp_req_r <= 1'b0;
        end
        else
        begin 
            u5_susp_req_r <= susp_req_i;
        end
    end
    always @ (  posedge clk_i or  posedge rst_i)
    begin
        if ( rst_i ) 
        begin
            u5_resume_req_r <= 1'b0;
        end
        else
        begin 
            u5_resume_req_r <= resume_req_i;
        end
    end
    always @ (  posedge clk_i or  posedge rst_i)
    begin
        if ( rst_i ) 
        begin
            u5_suspended <= 1'b0;
        end
        else
        begin 
            u5_suspended <= u5_suspended_d;
        end
    end
    always @ (  posedge clk_i or  posedge rst_i)
    begin
        if ( rst_i ) 
        begin
            u5_rfr_ack_r <= 1'b0;
        end
        else
        begin 
            u5_rfr_ack_r <= u5_rfr_ack_d;
        end
    end
    always @ (  posedge clk_i or  posedge rst_i)
    begin
        if ( rst_i ) 
        begin
            u5_susp_sel_r <= 1'b0;
        end
        else
        begin 
            if ( u5_susp_sel_set ) 
            begin
                u5_susp_sel_r <= 1'b1;
            end
            else
            begin 
                if ( u5_susp_sel_clr ) 
                begin
                    u5_susp_sel_r <= 1'b0;
                end
            end
        end
    end
    assign u5_tms_x = ( ( ( ( ( u5_rfr_ack_d | u5_rfr_ack_r ) | u5_susp_sel_r ) |  !( u5_mc_c_oe) ) ) ? ( 32'hffff_ffff ) : ( ( ( ( u5_lmr_ack | u5_init_ack ) ) ? ( u0_sp_tms ) : ( u0_tms ) ) ) );
    always @ (  posedge clk_i)
    begin
        if ( u5_tmr2_ld_tscsto ) 
        begin
            u5_timer2 <= u5_tms_x[24:16];
        end
        else
        begin 
            if ( u5_tmr2_ld_tsrdv ) 
            begin
                u5_timer2 <= 9'd4;
            end
            else
            begin 
                if ( u5_tmr2_ld_twpw ) 
                begin
                    u5_timer2 <= { 5'h0, u5_tms_x[15:12] };
                end
                else
                begin 
                    if ( u5_tmr2_ld_twd ) 
                    begin
                        u5_timer2 <= { 4'h0, u5_tms_x[19:16], 1'b0 };
                    end
                    else
                    begin 
                        if ( u5_tmr2_ld_twwd ) 
                        begin
                            u5_timer2 <= { 3'h0, u5_tms_x[25:20] };
                        end
                        else
                        begin 
                            if ( u5_tmr2_ld_trdz ) 
                            begin
                                u5_timer2 <= { 4'h0, u5_tms_x[11:8], 1'b1 };
                            end
                            else
                            begin 
                                if ( u5_tmr2_ld_trdv ) 
                                begin
                                    u5_timer2 <= { u5_tms_x[7:0], 1'b1 };
                                end
                                else
                                begin 
                                    if (  !( ( u5_timer2 == 9'h0 )) ) 
                                    begin
                                        u5_timer2 <= ( u5_timer2 - 9'b1 );
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    always @ (  posedge clk_i or  posedge rst_i)
    begin
        if ( rst_i ) 
        begin
            u5_tmr2_done <= 1'b0;
        end
        else
        begin 
            u5_tmr2_done <= ( ( ( ( ( ( ( u5_timer2 == 9'h0 ) &  !( u5_tmr2_ld_trdv) ) &  !( u5_tmr2_ld_trdz) ) &  !( u5_tmr2_ld_twpw) ) &  !( u5_tmr2_ld_twd) ) &  !( u5_tmr2_ld_twwd) ) &  !( u5_tmr2_ld_tscsto) );
        end
    end
    always @ (  posedge clk_i or  posedge rst_i)
    begin
        if ( rst_i ) 
        begin
            u5_timer <= 8'd250;
        end
        else
        begin 
            if ( u5_tmr_ld_twr2 ) 
            begin
                u5_timer <= { 4'h0, u5_tms_x[15:12] };
            end
            else
            begin 
                if ( u5_tmr_ld_trdz ) 
                begin
                    u5_timer <= { 4'h0, u5_tms_x[11:8] };
                end
                else
                begin 
                    if ( u5_tmr_ld_trdv ) 
                    begin
                        u5_timer <= u5_tms_x[7:0];
                    end
                    else
                    begin 
                        if ( u5_tmr_ld_twr ) 
                        begin
                            u5_timer <= { 4'h0, ( { 2'h0, u5_tms_x[16:15] } + u5_tms_x[23:20] ) };
                        end
                        else
                        begin 
                            if ( u5_tmr_ld_trp ) 
                            begin
                                u5_timer <= { 4'h0, u5_tms_x[23:20] };
                            end
                            else
                            begin 
                                if ( u5_tmr_ld_trcd ) 
                                begin
                                    u5_timer <= { 5'h0, u5_tms_x[19:17] };
                                end
                                else
                                begin 
                                    if ( u5_tmr_ld_tcl ) 
                                    begin
                                        u5_timer <= { 6'h0, u5_tms_x[5:4] };
                                    end
                                    else
                                    begin 
                                        if ( u5_tmr_ld_trfc ) 
                                        begin
                                            u5_timer <= { 4'h0, u5_tms_x[27:24] };
                                        end
                                        else
                                        begin 
                                            if ( u5_tmr_ld_tavav ) 
                                            begin
                                                u5_timer <= 8'h3;
                                            end
                                            else
                                            begin 
                                                if ( u5_tmr_ld_txsr ) 
                                                begin
                                                    u5_timer <= 8'h7;
                                                end
                                                else
                                                begin 
                                                    if (  !( ( u5_timer == 8'h0 )) &  !( u5_mc_le) ) 
                                                    begin
                                                        u5_timer <= ( u5_timer - 8'b1 );
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    always @ (  posedge clk_i or  posedge rst_i)
    begin
        if ( rst_i ) 
        begin
            u5_tmr_done <= 1'b0;
        end
        else
        begin 
            u5_tmr_done <= ( u5_timer == 8'h0 );
        end
    end
    always @ (  posedge clk_i)
    begin
        if ( u5_ir_cnt_ld ) 
        begin
            u5_ir_cnt <= 2;
        end
        else
        begin 
            if ( u5_ir_cnt_dec ) 
            begin
                u5_ir_cnt <= ( u5_ir_cnt - 4'b1 );
            end
        end
    end
    always @ (  posedge clk_i)
    begin
        u5_ir_cnt_done <= ( u5_ir_cnt == 4'h0 );
    end
    always @ (  ( ( ( ( ( u5_rfr_ack_d | u5_rfr_ack_r ) | u5_susp_sel_r ) |  !( u5_mc_c_oe) ) ) ? ( 32'hffff_ffff ) : ( ( ( ( u5_lmr_ack | u5_init_ack ) ) ? ( u0_sp_tms ) : ( u0_tms ) ) ) ) or  u1_page_size)
    begin
        case ( u5_tms_x[2:0] ) 
        3'h0:
        begin
            u5_burst_val = 11'h1;
        end
        3'h1:
        begin
            u5_burst_val = 11'h2;
        end
        3'h2:
        begin
            u5_burst_val = 11'h4;
        end
        3'h3:
        begin
            u5_burst_val = 11'h8;
        end
        3'h7:
        begin
            u5_burst_val = u1_page_size;
        end
        endcase
    end
    always @ (  posedge clk_i)
    begin
        if ( u5_burst_cnt_ld_4 ) 
        begin
            u5_burst_cnt <= 11'h4;
        end
        else
        begin 
            if ( u5_burst_cnt_ld ) 
            begin
                u5_burst_cnt <= u5_burst_val;
            end
            else
            begin 
                if ( ( ( u5_wr_cycle ) ? ( u5_mem_ack_d ) : ( u5_dv ) ) ) 
                begin
                    u5_burst_cnt <= ( u5_burst_cnt - 11'h1 );
                end
            end
        end
    end
    always @ (  posedge clk_i or  posedge rst_i)
    begin
        if ( rst_i ) 
        begin
            u5_burst_fp <= 1'b0;
        end
        else
        begin 
            if ( u5_burst_cnt_ld ) 
            begin
                u5_burst_fp <= ( u5_tms_x[2:0] == 3'h7 );
            end
        end
    end
    always @ (  posedge clk_i or  posedge rst_i)
    begin
        if ( rst_i ) 
        begin
            u5_ap_en <= 1'b0;
        end
        else
        begin 
            if ( u5_burst_cnt_ld ) 
            begin
                u5_ap_en <= ( ( u5_tms_x[2:0] == 3'h0 ) &  !( u5_csc[10]) );
            end
        end
    end
    always @ (  posedge clk_i)
    begin
        u5_burst_act_rd <=  |( u5_burst_cnt);
    end
    always @ (  posedge clk_i or  posedge rst_i)
    begin
        if ( rst_i ) 
        begin
            u5_dv_r <= 1'b0;
        end
        else
        begin 
            u5_dv_r <= u5_dv;
        end
    end
    always @ (  posedge clk_i)
    begin
        u5_cmd_a10_r <= u5_cmd_a10;
    end
    always @ (  posedge clk_i)
    begin
        u5_wb_write_go_r <= u6_wb_write_go;
    end
    always @ (  posedge clk_i or  posedge rst_i)
    begin
        if ( rst_i ) 
        begin
            u5_wb_stb_first <= 1'b0;
        end
        else
        begin 
            if ( ( u5_mem_ack_d | ( ( ( ( ( u5_ack_cnt != 4'h0 ) &  !( u5_wb_wait) ) &  !( u5_mem_ack_r) ) & u5_wb_read_go ) &  !( ( u5_wb_we_i & u5_wb_stb_i )) ) ) & ( u6_wb_read_go | u6_wb_write_go ) ) 
            begin
                u5_wb_stb_first <= 1'b0;
            end
            else
            begin 
                if ( u6_wb_first & wb_stb_i ) 
                begin
                    u5_wb_stb_first <= 1'b1;
                end
            end
        end
    end
    always @ (  posedge clk_i or  posedge rst_i)
    begin
        if ( rst_i ) 
        begin
            u5_state <= u5_POR;
        end
        else
        begin 
            u5_state <= u5_next_state;
        end
    end
    always @ (  u5_state or   |( ( ( ( u5_rfr_ack_r | u5_susp_sel_r ) ) ? ( { ( u0_csc7[0] & ( u0_csc7[3:1] == 3'h0 ) ), ( u0_csc6[0] & ( u0_csc6[3:1] == 3'h0 ) ), ( u0_csc5[0] & ( u0_csc5[3:1] == 3'h0 ) ), ( u0_csc4[0] & ( u0_csc4[3:1] == 3'h0 ) ), ( u0_csc3[0] & ( u0_csc3[3:1] == 3'h0 ) ), ( u0_csc2[0] & ( u0_csc2[3:1] == 3'h0 ) ), ( u0_u1_csc[0] & ( u0_u1_csc[3:1] == 3'h0 ) ), ( u0_u0_csc[0] & ( u0_u0_csc[3:1] == 3'h0 ) ) } ) : ( ( ( ( u5_lmr_ack | u5_init_ack ) ) ? ( u0_spec_req_cs ) : ( u0_cs ) ) ) )) or  u5_cs_le or  u5_cs_le_r or  ( u5_tms_x[19:16] == 4'h0 ) or  wb_stb_i or  u5_wb_write_go_r or  u6_wb_first or  u6_wb_read_go or  u6_wb_write_go or  u6_wb_wait or  u5_mem_ack_r or  wb_we_i or  ( u5_ack_cnt == 4'h0 ) or  u5_wb_wait_r or  u5_cnt or  u5_wb_cycle or  u5_wr_cycle or  u5_csc[3:1] or  u5_csc[10] or  u5_lookup_ready2 or  u2_row_same or  u5_cmd_a10_r or  u2_bank_open or  ( u5_tms[9] | ( u5_tms[2:0] == 3'h0 ) ) or  u5_cmd_asserted or  u5_tmr_done or  u5_tmr2_done or  u5_ir_cnt_done or  u5_cmd_asserted2 or  (  |( u5_burst_cnt) &  |( u5_tms_x[2:0]) ) or  u5_burst_act_rd or  u5_burst_fp or  u5_cke_ or  u5_cke_r or  u5_cke_o_del or  u4_rfr_req or  u0_lmr_req or  u0_init_req or  u5_rfr_ack_r or  u5_susp_req_r or  u5_resume_req_r or  u7_mc_br_r or  ( u5_csc[5:4] == 2'h0 ) or  ( u5_csc[5:4] == 2'h1 ) or  u5_dv_r or  u5_mc_adv_r or  u7_mc_ack_r or  u5_wb_stb_first or  u5_ap_en)
    begin
        u5_next_state = u5_state;
        u5_cnt_next = 1'b0;
        u5_cmd = 4'b0111;
        u5_cmd_a10 = u5_ap_en;
        u5_oe_d = 1'b0;
        u5_data_oe_d = 1'b0;
        u5_cke_d = 1'b1;
        u5_cke_rd = 1'b1;
        u5_mc_adsc = 1'b0;
        u5_mc_adv = 1'b0;
        u5_bank_set = 1'b0;
        u5_bank_clr = 1'b0;
        u5_bank_clr_all = 1'b0;
        u5_burst_cnt_ld = 1'b0;
        u5_burst_cnt_ld_4 = 1'b0;
        u5_tmr_ld_trp = 1'b0;
        u5_tmr_ld_trcd = 1'b0;
        u5_tmr_ld_tcl = 1'b0;
        u5_tmr_ld_trfc = 1'b0;
        u5_tmr_ld_twr = 1'b0;
        u5_tmr_ld_txsr = 1'b0;
        u5_tmr_ld_trdv = 1'b0;
        u5_tmr_ld_trdz = 1'b0;
        u5_tmr_ld_twr2 = 1'b0;
        u5_tmr_ld_tavav = 1'b0;
        u5_tmr2_ld_trdv = 1'b0;
        u5_tmr2_ld_trdz = 1'b0;
        u5_tmr2_ld_twpw = 1'b0;
        u5_tmr2_ld_twd = 1'b0;
        u5_tmr2_ld_twwd = 1'b0;
        u5_tmr2_ld_tsrdv = 1'b0;
        u5_tmr2_ld_tscsto = 1'b0;
        u5_mem_ack_d = 1'b0;
        u5_err_d = 1'b0;
        u5_rfr_ack_d = 1'b0;
        u5_lmr_ack_d = 1'b0;
        u5_init_ack = 1'b0;
        u5_ir_cnt_dec = 1'b0;
        u5_ir_cnt_ld = 1'b0;
        u5_row_sel = 1'b0;
        u5_cs_le_d = 1'b0;
        u5_wr_clr = 1'b0;
        u5_wr_set = 1'b0;
        u5_wb_cycle_set = 1'b0;
        u5_dv = 1'b0;
        u5_suspended_d = 1'b0;
        u5_susp_sel_set = 1'b0;
        u5_susp_sel_clr = 1'b0;
        u5_mc_bg = 1'b0;
        u5_next_adr = 1'b0;
        u5_pack_le0_d = 1'b0;
        u5_pack_le1_d = 1'b0;
        u5_pack_le2_d = 1'b0;
        u5_mc_c_oe_d = 1'b1;
        case ( u5_state ) 
        u5_POR:
        begin
            if ( u5_tmr_done ) 
            begin
                u5_next_state = u5_IDLE;
            end
        end
        u5_IDLE:
        begin
            u5_cs_le_d = u5_wb_stb_first;
            u5_burst_cnt_ld = 1'b1;
            u5_wr_clr = 1'b1;
            if ( u5_csc[3:1] == 3'h3 ) 
            begin
                u5_tmr2_ld_tscsto = 1'b1;
            end
            if ( u5_csc[3:1] == 3'h1 ) 
            begin
                u5_tmr2_ld_tsrdv = 1'b1;
            end
            if ( u4_rfr_req ) 
            begin
                u5_rfr_ack_d = 1'b1;
                u5_next_state = u5_PRECHARGE;
            end
            else
            begin 
                if ( u0_init_req ) 
                begin
                    u5_cs_le_d = 1'b1;
                    u5_next_state = u5_INIT0;
                end
                else
                begin 
                    if ( u0_lmr_req & u5_lookup_ready2 ) 
                    begin
                        u5_lmr_ack_d = 1'b1;
                        u5_cs_le_d = 1'b1;
                        u5_next_state = u5_LMR0;
                    end
                    else
                    begin 
                        if ( u5_susp_req_r &  !( u5_wb_cycle) ) 
                        begin
                            u5_cs_le_d = 1'b1;
                            u5_susp_sel_set = 1'b1;
                            u5_next_state = u5_SUSP1;
                        end
                        else
                        begin 
                            if ( (  |( ( ( ( u5_rfr_ack_r | u5_susp_sel_r ) ) ? ( { ( u0_csc7[0] & ( u0_csc7[3:1] == 3'h0 ) ), ( u0_csc6[0] & ( u0_csc6[3:1] == 3'h0 ) ), ( u0_csc5[0] & ( u0_csc5[3:1] == 3'h0 ) ), ( u0_csc4[0] & ( u0_csc4[3:1] == 3'h0 ) ), ( u0_csc3[0] & ( u0_csc3[3:1] == 3'h0 ) ), ( u0_csc2[0] & ( u0_csc2[3:1] == 3'h0 ) ), ( u0_u1_csc[0] & ( u0_u1_csc[3:1] == 3'h0 ) ), ( u0_u0_csc[0] & ( u0_u0_csc[3:1] == 3'h0 ) ) } ) : ( ( ( ( u5_lmr_ack | u5_init_ack ) ) ? ( u0_spec_req_cs ) : ( u0_cs ) ) ) )) & ( u6_wb_read_go | u6_wb_write_go ) ) & u5_lookup_ready2 ) 
                            begin
                                u5_wb_cycle_set = 1'b1;
                                case ( u5_csc[3:1] ) 
                                3'h0:
                                begin
                                    if ( u5_lookup_ready2 &  !( u6_wb_wait) ) 
                                    begin
                                        if ( u6_wb_write_go | ( wb_we_i & wb_stb_i ) ) 
                                        begin
                                            u5_wr_set = 1'b1;
                                        end
                                        if ( ( u5_csc[10] & u2_bank_open ) & u2_row_same ) 
                                        begin
                                            u5_next_state = u5_SD_RD_WR;
                                        end
                                        else
                                        begin 
                                            if ( u5_csc[10] & u2_bank_open ) 
                                            begin
                                                u5_next_state = u5_PRECHARGE;
                                            end
                                            else
                                            begin 
                                                u5_next_state = u5_ACTIVATE;
                                            end
                                        end
                                    end
                                end
                                3'h2:
                                begin
                                    if (  !( u6_wb_wait) ) 
                                    begin
                                        u5_cs_le_d = 1'b1;
                                        if ( u6_wb_write_go ) 
                                        begin
                                            u5_data_oe_d = 1'b1;
                                            u5_next_state = u5_ACS_WR;
                                        end
                                        else
                                        begin 
                                            u5_next_state = u5_ACS_RD;
                                        end
                                    end
                                end
                                3'h3:
                                begin
                                    if (  !( u6_wb_wait) ) 
                                    begin
                                        u5_cs_le_d = 1'b1;
                                        if ( u6_wb_write_go ) 
                                        begin
                                            u5_cmd = 4'b1110;
                                            u5_data_oe_d = 1'b1;
                                            u5_tmr_ld_twr2 = 1'b1;
                                            u5_next_state = u5_SCS_WR;
                                        end
                                        else
                                        begin 
                                            u5_cmd = 4'b1111;
                                            u5_oe_d = 1'b1;
                                            u5_tmr_ld_trdv = 1'b1;
                                            u5_next_state = u5_SCS_RD;
                                        end
                                    end
                                end
                                3'h1:
                                begin
                                    if (  !( u6_wb_wait) ) 
                                    begin
                                        u5_cs_le_d = 1'b1;
                                        if ( u6_wb_write_go ) 
                                        begin
                                            u5_data_oe_d = 1'b1;
                                            u5_mem_ack_d = 1'b1;
                                            u5_next_state = u5_SRAM_WR;
                                        end
                                        else
                                        begin 
                                            u5_cmd = 4'b1111;
                                            u5_oe_d = 1'b1;
                                            u5_mc_adsc = 1'b1;
                                            u5_next_state = u5_SRAM_RD;
                                        end
                                    end
                                end
                                endcase
                            end
                            else
                            begin 
                                if ( u7_mc_br_r ) 
                                begin
                                    if (  !( u5_cmd_asserted2) ) 
                                    begin
                                        u5_next_state = u5_BG0;
                                        u5_mc_c_oe_d = 1'b0;
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
        u5_IDLE_T:
        begin
            u5_cmd_a10 = u5_cmd_a10_r;
            if ( ( u5_tmr_done & u5_wb_cycle ) &  !( u6_wb_wait) ) 
            begin
                u5_cs_le_d = 1'b1;
            end
            if ( u5_tmr_done ) 
            begin
                u5_next_state = u5_IDLE;
            end
        end
        u5_IDLE_T2:
        begin
            if ( u5_tmr2_done & (  !( u6_wb_wait) |  !( u5_wb_cycle) ) ) 
            begin
                u5_cs_le_d = u5_wb_cycle;
                if ( u5_cs_le_r |  !( u5_wb_cycle) ) 
                begin
                    u5_next_state = u5_IDLE;
                end
            end
        end
        u5_SCS_RD:
        begin
            u5_cmd = 4'b1111;
            u5_oe_d = 1'b1;
            u5_tmr_ld_trdv = 1'b1;
            if ( u7_mc_ack_r ) 
            begin
                u5_next_state = u5_SCS_RD1;
            end
            else
            begin 
                if ( u5_tmr2_done ) 
                begin
                    u5_next_state = u5_SCS_ERR;
                end
            end
        end
        u5_SCS_RD1:
        begin
            u5_cmd = 4'b1111;
            u5_oe_d = 1'b1;
            if ( u5_tmr_done ) 
            begin
                u5_mem_ack_d = 1'b1;
                u5_tmr_ld_trdz = 1'b1;
                u5_next_state = u5_SCS_RD2;
            end
        end
        u5_SCS_RD2:
        begin
            u5_tmr_ld_trdz = 1'b1;
            u5_next_state = u5_IDLE_T;
        end
        u5_SCS_WR:
        begin
            u5_tmr_ld_twr2 = 1'b1;
            u5_cmd = 4'b1110;
            u5_data_oe_d = 1'b1;
            if ( u7_mc_ack_r ) 
            begin
                u5_next_state = u5_SCS_WR1;
            end
            else
            begin 
                if ( u5_tmr2_done ) 
                begin
                    u5_next_state = u5_SCS_ERR;
                end
            end
        end
        u5_SCS_WR1:
        begin
            u5_data_oe_d = 1'b1;
            if ( u5_tmr_done ) 
            begin
                u5_mem_ack_d = 1'b1;
                u5_next_state = u5_IDLE_T;
            end
            else
            begin 
                u5_cmd = 4'b1110;
            end
        end
        u5_SCS_ERR:
        begin
            u5_mem_ack_d = 1'b1;
            u5_err_d = 1'b1;
            u5_next_state = u5_IDLE_T2;
        end
        u5_SRAM_RD:
        begin
            u5_cmd = 4'b1111;
            u5_oe_d = 1'b1;
            u5_mc_adsc = 1'b1;
            u5_tmr2_ld_tsrdv = 1'b1;
            u5_burst_cnt_ld_4 = 1'b1;
            if ( u5_cmd_asserted ) 
            begin
                u5_next_state = u5_SRAM_RD0;
            end
        end
        u5_SRAM_RD0:
        begin
            u5_mc_adv = 1'b1;
            u5_oe_d = 1'b1;
            if ( u5_tmr2_done ) 
            begin
                u5_mc_adv =  !( u6_wb_wait);
                u5_next_state = u5_SRAM_RD1;
            end
        end
        u5_SRAM_RD1:
        begin
            if ( u5_mc_adv_r ) 
            begin
                u5_dv =  ~( u5_dv_r);
            end
            u5_mc_adv =  !( u6_wb_wait);
            if (  !( (  |( u5_burst_cnt) &  |( u5_tms_x[2:0]) )) |  !( u6_wb_read_go) ) 
            begin
                u5_next_state = u5_SRAM_RD2;
            end
            else
            begin 
                u5_oe_d = 1'b1;
            end
        end
        u5_SRAM_RD2:
        begin
            if ( ( u5_ack_cnt == 4'h0 ) & u6_wb_read_go ) 
            begin
                u5_next_state = u5_SRAM_RD3;
            end
            else
            begin 
                if (  !( u6_wb_read_go) ) 
                begin
                    u5_mc_adsc = 1'b1;
                    u5_next_state = u5_SRAM_RD4;
                end
            end
        end
        u5_SRAM_RD3:
        begin
            if (  !( u6_wb_read_go) ) 
            begin
                u5_mc_adsc = 1'b1;
                u5_next_state = u5_SRAM_RD4;
            end
            else
            begin 
                if (  !( u6_wb_wait) ) 
                begin
                    u5_cs_le_d = 1'b1;
                    u5_next_state = u5_SRAM_RD;
                end
            end
        end
        u5_SRAM_RD4:
        begin
            if ( u5_wb_cycle ) 
            begin
                u5_cs_le_d = 1'b1;
            end
            u5_mc_adsc = 1'b1;
            u5_next_state = u5_IDLE;
        end
        u5_SRAM_WR:
        begin
            u5_cmd = 4'b1110;
            u5_mc_adsc = 1'b1;
            u5_data_oe_d = 1'b1;
            if ( u5_cmd_asserted ) 
            begin
                if ( u6_wb_wait ) 
                begin
                    u5_next_state = u5_SRAM_WR0;
                end
                else
                begin 
                    if (  !( u6_wb_write_go) ) 
                    begin
                        u5_mc_adsc = 1'b1;
                        u5_next_state = u5_SRAM_RD4;
                    end
                    else
                    begin 
                        u5_data_oe_d = 1'b1;
                        u5_mem_ack_d =  ~( u5_mem_ack_r);
                    end
                end
            end
        end
        u5_SRAM_WR0:
        begin
            if ( u6_wb_wait ) 
            begin
                u5_next_state = u5_SRAM_WR0;
            end
            else
            begin 
                if (  !( u6_wb_write_go) ) 
                begin
                    u5_mc_adsc = 1'b1;
                    u5_next_state = u5_SRAM_RD4;
                end
                else
                begin 
                    u5_data_oe_d = 1'b1;
                    u5_next_state = u5_SRAM_WR;
                end
            end
        end
        u5_ACS_RD:
        begin
            u5_cmd = 4'b1111;
            u5_oe_d = 1'b1;
            u5_tmr2_ld_trdv = 1'b1;
            u5_next_state = u5_ACS_RD1;
        end
        u5_ACS_RD1:
        begin
            u5_cmd = 4'b1111;
            u5_oe_d = 1'b1;
            if ( u5_tmr2_done ) 
            begin
                if ( ( u5_csc[5:4] == 2'h0 ) | ( u5_csc[5:4] == 2'h1 ) ) 
                begin
                    u5_next_adr = 1'b1;
                end
                if ( u5_csc[5:4] == 2'h0 ) 
                begin
                    u5_next_state = u5_ACS_RD_8_1;
                end
                else
                begin 
                    if ( u5_csc[5:4] == 2'h1 ) 
                    begin
                        u5_next_state = u5_ACS_RD_8_5;
                    end
                    else
                    begin 
                        u5_next_state = u5_ACS_RD2A;
                    end
                end
            end
        end
        u5_ACS_RD_8_1:
        begin
            u5_pack_le0_d = 1'b1;
            u5_cmd = 4'b1111;
            u5_oe_d = 1'b1;
            u5_tmr2_ld_trdv = 1'b1;
            u5_next_state = u5_ACS_RD_8_2;
        end
        u5_ACS_RD_8_2:
        begin
            u5_cmd = 4'b1111;
            u5_oe_d = 1'b1;
            if ( u5_tmr2_done ) 
            begin
                u5_next_adr = 1'b1;
                u5_next_state = u5_ACS_RD_8_3;
            end
        end
        u5_ACS_RD_8_3:
        begin
            u5_pack_le1_d = 1'b1;
            u5_cmd = 4'b1111;
            u5_oe_d = 1'b1;
            u5_tmr2_ld_trdv = 1'b1;
            u5_next_state = u5_ACS_RD_8_4;
        end
        u5_ACS_RD_8_4:
        begin
            u5_cmd = 4'b1111;
            u5_oe_d = 1'b1;
            if ( u5_tmr2_done ) 
            begin
                u5_next_adr = 1'b1;
                u5_next_state = u5_ACS_RD_8_5;
            end
        end
        u5_ACS_RD_8_5:
        begin
            if ( u5_csc[5:4] == 2'h0 ) 
            begin
                u5_pack_le2_d = 1'b1;
            end
            if ( u5_csc[5:4] == 2'h1 ) 
            begin
                u5_pack_le0_d = 1'b1;
            end
            u5_cmd = 4'b1111;
            u5_oe_d = 1'b1;
            u5_tmr2_ld_trdv = 1'b1;
            u5_next_state = u5_ACS_RD_8_6;
        end
        u5_ACS_RD_8_6:
        begin
            u5_cmd = 4'b1111;
            u5_oe_d = 1'b1;
            if ( u5_tmr2_done ) 
            begin
                u5_next_state = u5_ACS_RD2;
            end
        end
        u5_ACS_RD2A:
        begin
            u5_oe_d = 1'b1;
            u5_cmd = 4'b1111;
            u5_next_state = u5_ACS_RD2;
        end
        u5_ACS_RD2:
        begin
            u5_cmd = 4'b1111;
            u5_next_state = u5_ACS_RD3;
        end
        u5_ACS_RD3:
        begin
            u5_mem_ack_d = 1'b1;
            u5_tmr2_ld_trdz = 1'b1;
            u5_next_state = u5_IDLE_T2;
        end
        u5_ACS_WR:
        begin
            u5_tmr2_ld_twpw = 1'b1;
            u5_cmd = 4'b1110;
            u5_data_oe_d = 1'b1;
            u5_next_state = u5_ACS_WR1;
        end
        u5_ACS_WR1:
        begin
            if (  !( u5_cmd_asserted) ) 
            begin
                u5_tmr2_ld_twpw = 1'b1;
            end
            u5_cmd = 4'b1110;
            u5_data_oe_d = 1'b1;
            if ( u5_tmr2_done ) 
            begin
                u5_tmr2_ld_twd = 1'b1;
                u5_next_state = u5_ACS_WR2;
            end
        end
        u5_ACS_WR2:
        begin
            if ( u5_tms_x[19:16] == 4'h0 ) 
            begin
                u5_next_state = u5_ACS_WR3;
            end
            else
            begin 
                u5_cmd = 4'b1111;
                u5_data_oe_d = 1'b1;
                u5_next_state = u5_ACS_WR3;
            end
        end
        u5_ACS_WR3:
        begin
            if ( u5_tmr2_done ) 
            begin
                u5_next_state = u5_ACS_WR4;
            end
            else
            begin 
                u5_cmd = 4'b1111;
            end
        end
        u5_ACS_WR4:
        begin
            u5_tmr2_ld_twwd = 1'b1;
            u5_mem_ack_d = 1'b1;
            u5_next_state = u5_IDLE_T2;
        end
        u5_PRECHARGE:
        begin
            u5_cmd = 4'b1010;
            if ( u5_rfr_ack_r ) 
            begin
                u5_rfr_ack_d = 1'b1;
                u5_cmd_a10 = 1'b1;
                u5_bank_clr_all = 1'b1;
            end
            else
            begin 
                u5_bank_clr = 1'b1;
                u5_cmd_a10 = 1'b0;
            end
            u5_tmr_ld_trp = 1'b1;
            if ( u5_cmd_asserted ) 
            begin
                u5_next_state = u5_PRECHARGE_W;
            end
        end
        u5_PRECHARGE_W:
        begin
            u5_rfr_ack_d = u5_rfr_ack_r;
            if ( u5_tmr_done ) 
            begin
                if ( u5_rfr_ack_r ) 
                begin
                    u5_next_state = u5_REFR;
                end
                else
                begin 
                    u5_next_state = u5_ACTIVATE;
                end
            end
        end
        u5_ACTIVATE:
        begin
            if (  !( u5_wb_wait_r) ) 
            begin
                u5_row_sel = 1'b1;
                u5_tmr_ld_trcd = 1'b1;
                u5_cmd = 4'b1011;
            end
            if ( u5_cmd_asserted ) 
            begin
                u5_next_state = u5_ACTIVATE_W;
            end
        end
        u5_ACTIVATE_W:
        begin
            u5_row_sel = 1'b1;
            if ( u6_wb_write_go | ( wb_we_i & wb_stb_i ) ) 
            begin
                u5_wr_set = 1'b1;
            end
            if ( u5_csc[10] ) 
            begin
                u5_bank_set = 1'b1;
            end
            if ( u5_tmr_done ) 
            begin
                if ( u6_wb_write_go ) 
                begin
                    u5_mem_ack_d =  ~( u5_mem_ack_r);
                    u5_cmd_a10 = ( u5_ap_en | ( ( u5_tms[9] | ( u5_tms[2:0] == 3'h0 ) ) &  !( u5_csc[10]) ) );
                    u5_next_state = u5_SD_WR;
                end
                else
                begin 
                    if (  !( u5_wb_wait_r) ) 
                    begin
                        u5_next_state = u5_SD_RD;
                    end
                end
            end
        end
        u5_SD_RD_WR:
        begin
            if ( u6_wb_write_go | ( wb_we_i & wb_stb_i ) ) 
            begin
                u5_wr_set = 1'b1;
            end
            if ( u6_wb_write_go &  !( u6_wb_wait) ) 
            begin
                u5_data_oe_d = 1'b1;
                u5_mem_ack_d =  ~( u5_mem_ack_r);
                u5_cmd_a10 = ( u5_ap_en | ( ( u5_tms[9] | ( u5_tms[2:0] == 3'h0 ) ) &  !( u5_csc[10]) ) );
                u5_next_state = u5_SD_WR;
            end
            else
            begin 
                if (  !( u6_wb_wait) ) 
                begin
                    if ( u5_csc[10] ) 
                    begin
                        if (  !( u5_wb_wait_r) ) 
                        begin
                            u5_next_state = u5_SD_RD;
                        end
                    end
                    else
                    begin 
                        u5_next_state = u5_SD_RD;
                    end
                end
            end
        end
        u5_SD_WR:
        begin
            u5_data_oe_d = 1'b1;
            u5_tmr_ld_twr = 1'b1;
            u5_cnt_next =  ~( u5_cnt);
            u5_cmd = 4'b1100;
            u5_cmd_a10 = ( u5_ap_en | ( ( u5_tms[9] | ( u5_tms[2:0] == 3'h0 ) ) &  !( u5_csc[10]) ) );
            if ( (  !( u5_cnt) & u5_wb_cycle ) & (  |( u5_burst_cnt) &  |( u5_tms_x[2:0]) ) ) 
            begin
                u5_cke_d =  ~( u6_wb_wait);
            end
            else
            begin 
                u5_cke_d = u5_cke_r;
            end
            if ( u5_cmd_asserted ) 
            begin
                u5_mem_ack_d = ( ( ( (  !( u5_mem_ack_r) & u6_wb_write_go ) &  !( u6_wb_wait) ) & u5_wb_cycle ) & (  |( u5_burst_cnt) &  |( u5_tms_x[2:0]) ) );
                if ( u5_wb_cycle &  !( (  |( u5_burst_cnt) &  |( u5_tms_x[2:0]) )) ) 
                begin
                    u5_next_state = u5_IDLE_T;
                end
                else
                begin 
                    if ( u6_wb_write_go ) 
                    begin
                        u5_next_state = u5_SD_WR_W;
                    end
                    else
                    begin 
                        if ( (  |( u5_burst_cnt) &  |( u5_tms_x[2:0]) ) &  !( ( u5_tms[9] | ( u5_tms[2:0] == 3'h0 ) )) ) 
                        begin
                            u5_next_state = u5_BT;
                        end
                        else
                        begin 
                            if (  !( u5_ap_en) ) 
                            begin
                                u5_next_state = u5_BT_W;
                            end
                            else
                            begin 
                                u5_next_state = u5_IDLE_T;
                            end
                        end
                    end
                end
            end
        end
        u5_SD_WR_W:
        begin
            u5_tmr_ld_twr = 1'b1;
            u5_cnt_next =  ~( u5_cnt);
            if ( ( u5_tms[9] | ( u5_tms[2:0] == 3'h0 ) ) & u5_wb_cycle ) 
            begin
                u5_cmd = 4'b1100;
            end
            u5_cmd_a10 = ( u5_ap_en | ( ( u5_tms[9] | ( u5_tms[2:0] == 3'h0 ) ) &  !( u5_csc[10]) ) );
            u5_data_oe_d = 1'b1;
            u5_mem_ack_d = ( ( ( (  !( u5_mem_ack_r) & u6_wb_write_go ) &  !( u6_wb_wait) ) & u5_wr_cycle ) & (  |( u5_burst_cnt) &  |( u5_tms_x[2:0]) ) );
            if (  !( u5_cnt) ) 
            begin
                u5_cke_d =  ~( u6_wb_wait);
            end
            else
            begin 
                u5_cke_d = u5_cke_r;
            end
            if ( ( ( ( u5_tms[9] | ( u5_tms[2:0] == 3'h0 ) ) & u5_cke_r ) | ( (  !( ( u5_tms[9] | ( u5_tms[2:0] == 3'h0 ) )) &  !( u5_cnt) ) &  !( u6_wb_wait) ) ) | ( (  !( ( u5_tms[9] | ( u5_tms[2:0] == 3'h0 ) )) & u5_cnt ) & u5_cke_r ) ) 
            begin
                if ( ( u5_tms[9] | ( u5_tms[2:0] == 3'h0 ) ) &  !( u5_wb_cycle) ) 
                begin
                    u5_next_state = u5_IDLE_T;
                end
                else
                begin 
                    if ( ( (  |( u5_burst_cnt) &  |( u5_tms_x[2:0]) ) &  !( ( u5_tms[9] | ( u5_tms[2:0] == 3'h0 ) )) ) &  !( u5_wb_write_go_r) ) 
                    begin
                        u5_cmd = 4'b1110;
                        u5_next_state = u5_BT;
                    end
                    else
                    begin 
                        if (  !( (  |( u5_burst_cnt) &  |( u5_tms_x[2:0]) )) &  !( u5_ap_en) ) 
                        begin
                            u5_next_state = u5_BT_W;
                        end
                        else
                        begin 
                            if (  !( (  |( u5_burst_cnt) &  |( u5_tms_x[2:0]) )) ) 
                            begin
                                u5_next_state = u5_IDLE_T;
                            end
                            else
                            begin 
                                if (  !( u5_wb_write_go_r) & u6_wb_read_go ) 
                                begin
                                    u5_next_state = u5_IDLE_T;
                                end
                            end
                        end
                    end
                end
            end
        end
        u5_SD_RD:
        begin
            u5_cmd = 4'b1101;
            u5_cmd_a10 = u5_ap_en;
            u5_tmr_ld_tcl = 1'b1;
            if ( u5_cmd_asserted ) 
            begin
                u5_next_state = u5_SD_RD_W;
            end
        end
        u5_SD_RD_W:
        begin
            if ( u5_tmr_done ) 
            begin
                u5_next_state = u5_SD_RD_LOOP;
            end
        end
        u5_SD_RD_LOOP:
        begin
            u5_cnt_next =  ~( u5_cnt);
            if ( ( u5_cnt &  !( ( (  |( u5_burst_cnt) &  |( u5_tms_x[2:0]) ) &  !( u5_wb_cycle) )) ) & (  |( u5_burst_cnt) &  |( u5_tms_x[2:0]) ) ) 
            begin
                u5_cke_rd =  !( u6_wb_wait);
            end
            else
            begin 
                u5_cke_rd = u5_cke_;
            end
            if ( ( ( u5_wb_cycle &  !( u5_cnt) ) & u5_burst_act_rd ) & u5_cke_o_del ) 
            begin
                u5_dv = 1'b1;
            end
            if ( u5_wb_cycle & u6_wb_write_go ) 
            begin
                u5_next_state = u5_BT;
            end
            else
            begin 
                if ( (  |( u5_burst_cnt) &  |( u5_tms_x[2:0]) ) &  !( u5_wb_cycle) ) 
                begin
                    u5_next_state = u5_BT;
                end
                else
                begin 
                    if (  !( (  |( u5_burst_cnt) &  |( u5_tms_x[2:0]) )) ) 
                    begin
                        u5_next_state = u5_SD_RD_W2;
                    end
                end
            end
        end
        u5_SD_RD_W2:
        begin
            if ( u6_wb_write_go | ( u5_ack_cnt == 4'h0 ) ) 
            begin
                if (  !( u5_ap_en) &  !( u5_csc[10]) ) 
                begin
                    u5_next_state = u5_BT_W;
                end
                else
                begin 
                    if (  !( u6_wb_wait) &  !( u5_mem_ack_r) ) 
                    begin
                        u5_next_state = u5_IDLE_T;
                    end
                end
            end
        end
        u5_BT:
        begin
            u5_cmd = 4'b1110;
            u5_tmr_ld_trp = 1'b1;
            if ( u5_cmd_asserted ) 
            begin
                u5_next_state = u5_BT_W;
            end
        end
        u5_BT_W:
        begin
            u5_cmd_a10 = u5_cmd_a10_r;
            if ( u5_csc[10] & u5_tmr_done ) 
            begin
                if ( ( u5_csc[10] &  !( u6_wb_wait) ) & ( u6_wb_read_go | u6_wb_write_go ) ) 
                begin
                    u5_cs_le_d = 1'b1;
                end
                u5_next_state = u5_IDLE;
            end
            else
            begin 
                if (  !( u5_csc[10]) & u5_tmr_done ) 
                begin
                    u5_bank_clr = 1'b1;
                    u5_cmd = 4'b1010;
                    u5_cmd_a10 = 1'b0;
                    u5_tmr_ld_trp = 1'b1;
                    if ( u5_cmd_asserted ) 
                    begin
                        u5_next_state = u5_IDLE_T;
                    end
                end
            end
        end
        u5_REFR:
        begin
            u5_cs_le_d = 1'b1;
            u5_cmd = 4'b1001;
            u5_tmr_ld_trfc = 1'b1;
            u5_rfr_ack_d = 1'b1;
            if ( u5_cmd_asserted ) 
            begin
                u5_susp_sel_clr = 1'b1;
                u5_next_state = u5_IDLE_T;
            end
        end
        u5_LMR0:
        begin
            u5_lmr_ack_d = 1'b1;
            u5_cmd = 4'b1010;
            u5_cmd_a10 = 1'b1;
            u5_bank_clr_all = 1'b1;
            u5_tmr_ld_trp = 1'b1;
            if ( u5_cmd_asserted ) 
            begin
                u5_next_state = u5_LMR1;
            end
        end
        u5_LMR1:
        begin
            u5_lmr_ack_d = 1'b1;
            if ( u5_tmr_done ) 
            begin
                u5_next_state = u5_LMR2;
            end
        end
        u5_LMR2:
        begin
            u5_bank_clr_all = 1'b1;
            u5_cmd = 4'b1000;
            u5_tmr_ld_trfc = 1'b1;
            u5_lmr_ack_d = 1'b1;
            if ( u5_cmd_asserted ) 
            begin
                u5_next_state = u5_IDLE_T;
            end
        end
        u5_INIT0:
        begin
            u5_cs_le_d = 1'b1;
            u5_next_state = u5_INIT;
        end
        u5_INIT:
        begin
            u5_init_ack = 1'b1;
            u5_cmd = 4'b1010;
            u5_cmd_a10 = 1'b1;
            u5_bank_clr_all = 1'b1;
            u5_tmr_ld_trp = 1'b1;
            u5_ir_cnt_ld = 1'b1;
            if ( u5_cmd_asserted ) 
            begin
                u5_next_state = u5_INIT_W;
            end
        end
        u5_INIT_W:
        begin
            u5_init_ack = 1'b1;
            if ( u5_tmr_done ) 
            begin
                u5_next_state = u5_INIT_REFR1;
            end
        end
        u5_INIT_REFR1:
        begin
            u5_init_ack = 1'b1;
            u5_cmd = 4'b1001;
            u5_tmr_ld_trfc = 1'b1;
            if ( u5_cmd_asserted ) 
            begin
                u5_ir_cnt_dec = 1'b1;
                u5_next_state = u5_INIT_REFR1_W;
            end
        end
        u5_INIT_REFR1_W:
        begin
            u5_init_ack = 1'b1;
            if ( u5_tmr_done ) 
            begin
                if ( u5_ir_cnt_done ) 
                begin
                    u5_next_state = u5_INIT_LMR;
                end
                else
                begin 
                    u5_next_state = u5_INIT_REFR1;
                end
            end
        end
        u5_INIT_LMR:
        begin
            u5_init_ack = 1'b1;
            u5_cmd = 4'b1000;
            u5_bank_clr_all = 1'b1;
            u5_tmr_ld_trfc = 1'b1;
            if ( u5_cmd_asserted ) 
            begin
                u5_next_state = u5_IDLE_T;
            end
        end
        u5_BG0:
        begin
            u5_mc_bg = 1'b1;
            u5_mc_c_oe_d = 1'b0;
            u5_next_state = u5_BG1;
        end
        u5_BG1:
        begin
            u5_mc_bg = 1'b1;
            u5_cs_le_d = 1'b1;
            u5_mc_c_oe_d = 1'b0;
            u5_next_state = u5_BG2;
        end
        u5_BG2:
        begin
            u5_cs_le_d = 1'b1;
            u5_mc_bg = ( ( ( ( (  !( u6_wb_read_go) &  !( u6_wb_write_go) ) &  !( u4_rfr_req) ) &  !( u0_init_req) ) &  !( u0_lmr_req) ) &  !( u5_susp_req_r) );
            u5_tmr_ld_tavav = 1'b1;
            u5_mc_c_oe_d = u7_mc_br_r;
            if (  !( u7_mc_br_r) ) 
            begin
                u5_next_state = u5_IDLE_T;
            end
        end
        u5_SUSP1:
        begin
            u5_cmd = 4'b1010;
            u5_cmd_a10 = 1'b1;
            u5_bank_clr_all = 1'b1;
            u5_tmr_ld_trp = 1'b1;
            if ( u5_cmd_asserted ) 
            begin
                u5_next_state = u5_SUSP2;
            end
        end
        u5_SUSP2:
        begin
            if ( u5_tmr_done ) 
            begin
                u5_next_state = u5_SUSP3;
            end
        end
        u5_SUSP3:
        begin
            u5_cke_d = 1'b0;
            u5_cmd = 4'b1001;
            u5_rfr_ack_d = 1'b1;
            if ( u5_cmd_asserted ) 
            begin
                u5_next_state = u5_SUSP4;
            end
        end
        u5_SUSP4:
        begin
            u5_cke_rd = 1'b0;
            u5_suspended_d = 1'b1;
            u5_tmr_ld_txsr = 1'b1;
            if ( u5_resume_req_r ) 
            begin
                u5_next_state = u5_RESUME1;
            end
        end
        u5_RESUME1:
        begin
            u5_suspended_d = 1'b1;
            u5_tmr_ld_txsr = 1'b1;
            u5_next_state = u5_RESUME2;
        end
        u5_RESUME2:
        begin
            u5_suspended_d = 1'b1;
            if ( u5_tmr_done ) 
            begin
                u5_next_state = u5_REFR;
            end
        end
        endcase
    end
    assign u6_wb_cyc_i = wb_cyc_i;
    assign u6_wb_stb_i = wb_stb_i;
    assign u6_wb_we_i = wb_we_i;
    assign wb_ack_o = u6_wb_ack_o;
    assign wb_err_o = u6_wb_err;
    assign wb_data_o = u6_wb_data_o;
    always @ (  posedge clk_i or  posedge rst_i)
    begin
        if ( rst_i ) 
        begin
            u6_rmw_en <= 1'b0;
        end
        else
        begin 
            if ( u6_wb_ack_o ) 
            begin
                u6_rmw_en <= 1'b1;
            end
            else
            begin 
                if (  !( wb_cyc_i) ) 
                begin
                    u6_rmw_en <= 1'b0;
                end
            end
        end
    end
    always @ (  posedge clk_i or  posedge rst_i)
    begin
        if ( rst_i ) 
        begin
            u6_rmw_r <= 1'b0;
        end
        else
        begin 
            u6_rmw_r <= ( ( ( (  !( u6_wr_hold) & wb_we_i ) & wb_cyc_i ) & wb_stb_i ) & u6_rmw_en );
        end
    end
    assign u6_rmw = ( u6_rmw_r | ( ( ( (  !( u6_wr_hold) & wb_we_i ) & wb_cyc_i ) & wb_stb_i ) & u6_rmw_en ) );
    always @ (  posedge clk_i or  posedge rst_i)
    begin
        if ( rst_i ) 
        begin
            u6_read_go_r1 <= 1'b0;
        end
        else
        begin 
            u6_read_go_r1 <= ( (  !( ( u6_rmw_r | ( ( ( (  !( u6_wr_hold) & wb_we_i ) & wb_cyc_i ) & wb_stb_i ) & u6_rmw_en ) )) & wb_cyc_i ) & ( ( ( wb_stb_i & ( wb_addr_i[31:29] == 3'h0 ) ) &  !( wb_we_i) ) | u6_read_go_r ) );
        end
    end
    always @ (  posedge clk_i or  posedge rst_i)
    begin
        if ( rst_i ) 
        begin
            u6_read_go_r <= 1'b0;
        end
        else
        begin 
            u6_read_go_r <= ( u6_read_go_r1 & wb_cyc_i );
        end
    end
    always @ (  posedge clk_i or  posedge rst_i)
    begin
        if ( rst_i ) 
        begin
            u6_write_go_r1 <= 1'b0;
        end
        else
        begin 
            u6_write_go_r1 <= ( wb_cyc_i & ( ( ( wb_stb_i & ( wb_addr_i[31:29] == 3'h0 ) ) & wb_we_i ) | u6_write_go_r ) );
        end
    end
    always @ (  posedge clk_i or  posedge rst_i)
    begin
        if ( rst_i ) 
        begin
            u6_write_go_r <= 1'b0;
        end
        else
        begin 
            u6_write_go_r <= ( ( u6_write_go_r1 & wb_cyc_i ) & ( ( wb_we_i & wb_stb_i ) |  !( wb_stb_i) ) );
        end
    end
    assign u6_wb_first_set = ( ( ( ( wb_addr_i[31:29] == 3'h0 ) & wb_cyc_i ) & wb_stb_i ) &  !( ( u6_read_go_r | u6_write_go_r )) );
    assign u6_wb_first = ( ( ( ( ( wb_addr_i[31:29] == 3'h0 ) & wb_cyc_i ) & wb_stb_i ) &  !( ( u6_read_go_r | u6_write_go_r )) ) | ( ( u6_wb_first_r &  !( u6_wb_ack_o) ) &  !( u6_wb_err) ) );
    always @ (  posedge clk_i or  posedge rst_i)
    begin
        if ( rst_i ) 
        begin
            u6_wb_first_r <= 1'b0;
        end
        else
        begin 
            if ( ( ( ( wb_addr_i[31:29] == 3'h0 ) & wb_cyc_i ) & wb_stb_i ) &  !( ( u6_read_go_r | u6_write_go_r )) ) 
            begin
                u6_wb_first_r <= 1'b1;
            end
            else
            begin 
                if ( u6_wb_ack_o | u6_wb_err ) 
                begin
                    u6_wb_first_r <= 1'b0;
                end
            end
        end
    end
    always @ (  posedge clk_i or  posedge rst_i)
    begin
        if ( rst_i ) 
        begin
            u6_wr_hold <= 1'b0;
        end
        else
        begin 
            if ( wb_cyc_i & wb_stb_i ) 
            begin
                u6_wr_hold <= wb_we_i;
            end
        end
    end
    always @ (  posedge clk_i or  posedge rst_i)
    begin
        if ( rst_i ) 
        begin
            u6_wb_ack_o <= 1'b0;
        end
        else
        begin 
            u6_wb_ack_o <= ( ( ( wb_addr_i[31:29] == 3'h0 ) ) ? ( ( ( ( u5_mem_ack_d | ( ( ( ( ( u5_ack_cnt != 4'h0 ) &  !( u6_wb_wait) ) &  !( u5_mem_ack_r) ) & u6_wb_read_go ) &  !( ( wb_we_i & wb_stb_i )) ) ) & ( u6_wb_read_go | u6_wb_write_go ) ) &  !( ( ( wb_cyc_i & wb_stb_i ) & ( ( ( (  !( u3_wb_we_i) & u3_mem_ack ) & u3_pen ) | u5_err_d ) | u0_wp_err ) )) ) ) : ( ( ( ( ( wb_addr_i[31:29] == 3'b011 ) & wb_cyc_i ) & wb_stb_i ) &  !( u6_wb_ack_o) ) ) );
        end
    end
    always @ (  posedge clk_i or  posedge rst_i)
    begin
        if ( rst_i ) 
        begin
            u6_wb_err <= 1'b0;
        end
        else
        begin 
            u6_wb_err <= ( ( ( wb_addr_i[31:29] == 3'h0 ) & ( ( wb_cyc_i & wb_stb_i ) & ( ( ( (  !( u3_wb_we_i) & u3_mem_ack ) & u3_pen ) | u5_err_d ) | u0_wp_err ) ) ) &  !( u6_wb_err) );
        end
    end
    always @ (  posedge clk_i)
    begin
        u6_wb_data_o <= ( ( ( wb_addr_i[31:29] == 3'h0 ) ) ? ( u3_wb_data_o ) : ( u0_rf_dout ) );
    end
    assign mc_rp_pad_o_ = u7_mc_rp;
    assign mc_bg_pad_o = u7_mc_bg;
    assign mc_addr_pad_o = u7_mc_addr;
    assign mc_data_pad_o = u7_mc_data_o;
    assign mc_dp_pad_o = u7_mc_dp_o;
    assign mc_doe_pad_doe_o = u7_mc_data_oe;
    assign mc_dqm_pad_o = u7_mc_dqm;
    assign mc_oe_pad_o_ = u7_mc_oe_;
    assign mc_we_pad_o_ = u7_mc_we_;
    assign mc_cas_pad_o_ = u7_mc_cas_;
    assign mc_ras_pad_o_ = u7_mc_ras_;
    assign mc_cke_pad_o_ = u5_cke_;
    assign mc_cs_pad_o_ = { u7_mc_cs_7, u7_mc_cs_6, u7_mc_cs_5, u7_mc_cs_4, u7_mc_cs_3, u7_mc_cs_2, u7_mc_cs_1, u7_mc_cs_0 };
    assign mc_adsc_pad_o_ = u7_mc_adsc_;
    assign mc_adv_pad_o_ = u7_mc_adv_;
    assign mc_zz_pad_o = u7_mc_zz_o;
    assign u7_cs_need_rfr = { ( u0_csc7[0] & ( u0_csc7[3:1] == 3'h0 ) ), ( u0_csc6[0] & ( u0_csc6[3:1] == 3'h0 ) ), ( u0_csc5[0] & ( u0_csc5[3:1] == 3'h0 ) ), ( u0_csc4[0] & ( u0_csc4[3:1] == 3'h0 ) ), ( u0_csc3[0] & ( u0_csc3[3:1] == 3'h0 ) ), ( u0_csc2[0] & ( u0_csc2[3:1] == 3'h0 ) ), ( u0_csc1[0] & ( u0_csc1[3:1] == 3'h0 ) ), ( u0_csc0[0] & ( u0_csc0[3:1] == 3'h0 ) ) };
    assign mc_coe_pad_coe_o = u7_mc_c_oe;
    always @ (  posedge mc_clk_i)
    begin
        u7_mc_zz_o <= suspended_o;
    end
    always @ (  posedge mc_clk_i)
    begin
        u7_mc_sts_ir <= mc_sts_pad_i;
    end
    always @ (  posedge mc_clk_i)
    begin
        u7_mc_data_ir <= { mc_dp_pad_i, mc_data_pad_i };
    end
    always @ (  posedge mc_clk_i)
    begin
        u7_mc_c_oe <= u5_mc_c_oe;
    end
    always @ (  posedge mc_clk_i)
    begin
        u7_mc_rp <= (  !( suspended_o) &  !( ( u0_csr_r[2] | u0_trig )) );
    end
    always @ (  posedge mc_clk_i)
    begin
        u7_mc_br_r <= mc_br_pad_i;
    end
    always @ (  posedge mc_clk_i)
    begin
        u7_mc_ack_r <= mc_ack_pad_i;
    end
    always @ (  posedge mc_clk_i)
    begin
        u7_mc_bg <= u5_mc_bg;
    end
    always @ (  posedge mc_clk_i or  posedge rst_i)
    begin
        if ( rst_i ) 
        begin
            u7_mc_data_oe <= 1'b0;
        end
        else
        begin 
            u7_mc_data_oe <= ( ( u5_data_oe &  !( u5_susp_sel_r) ) & u5_mc_c_oe );
        end
    end
    always @ (  posedge mc_clk_i)
    begin
        u7_mc_data_o <= u3_mc_data_o;
    end
    always @ (  posedge mc_clk_i)
    begin
        u7_mc_dp_o <= u3_mc_dp_o;
    end
    always @ (  posedge mc_clk_i)
    begin
        u7_mc_addr <= ( ( u5_rfr_ack_r ) ? ( { u1_mc_addr_d[23:11], 1'b1, u1_mc_addr_d[9:0] } ) : ( u1_mc_addr_d ) );
    end
    always @ (  posedge clk_i)
    begin
        if ( wb_cyc_i & wb_stb_i ) 
        begin
            u7_mc_dqm_r <= wb_sel_i;
        end
    end
    always @ (  posedge clk_i)
    begin
        u7_mc_dqm_r2 <= u7_mc_dqm_r;
    end
    always @ (  posedge mc_clk_i)
    begin
        u7_mc_dqm <= ( ( u5_susp_sel_r ) ? ( 4'hf ) : ( ( ( u5_data_oe ) ? (  ~( u7_mc_dqm_r2) ) : ( ( ( ( u5_wb_cycle &  !( u5_wr_cycle) ) ) ? ( 4'h0 ) : ( 4'hf ) ) ) ) ) );
    end
    always @ (  posedge mc_clk_i or  posedge rst_i)
    begin
        if ( rst_i ) 
        begin
            u7_mc_oe_ <= 1'b1;
        end
        else
        begin 
            u7_mc_oe_ <= ( u5_oe_ | u5_susp_sel_r );
        end
    end
    always @ (  posedge mc_clk_i)
    begin
        u7_mc_we_ <= u5_temp_cs[0];
    end
    always @ (  posedge mc_clk_i)
    begin
        u7_mc_cas_ <= u5_temp_cs[1];
    end
    always @ (  posedge mc_clk_i)
    begin
        u7_mc_ras_ <= u5_temp_cs[2];
    end
    always @ (  posedge mc_clk_i or  posedge rst_i)
    begin
        if ( rst_i ) 
        begin
        end
    end
    assign u7_mc_cs_ = { u7_mc_cs_7, u7_mc_cs_6, u7_mc_cs_5, u7_mc_cs_4, u7_mc_cs_3, u7_mc_cs_2, u7_mc_cs_1, u7_mc_cs_0 };
    always @ (  posedge mc_clk_i or  posedge rst_i)
    begin
        if ( rst_i ) 
        begin
            u7_mc_cs_0 <= 1'b1;
        end
        else
        begin 
            u7_mc_cs_0 <=  ~( ( u5_temp_cs[3] & ( ( ( u5_rfr_ack_r | u5_susp_sel_r ) ) ? ( u7_cs_need_rfr[0] ) : ( ( ( ( u5_lmr_ack | u5_init_ack ) ) ? ( u0_spec_req_cs[0] ) : ( u0_cs[0] ) ) ) ) ));
        end
    end
    always @ (  posedge mc_clk_i or  posedge rst_i)
    begin
        if ( rst_i ) 
        begin
            u7_mc_cs_1 <= 1'b1;
        end
        else
        begin 
            u7_mc_cs_1 <=  ~( ( u5_temp_cs[3] & ( ( ( u5_rfr_ack_r | u5_susp_sel_r ) ) ? ( u7_cs_need_rfr[1] ) : ( ( ( ( u5_lmr_ack | u5_init_ack ) ) ? ( u0_spec_req_cs[1] ) : ( u0_cs[1] ) ) ) ) ));
        end
    end
    always @ (  posedge mc_clk_i or  posedge rst_i)
    begin
        if ( rst_i ) 
        begin
            u7_mc_cs_2 <= 1'b1;
        end
        else
        begin 
            u7_mc_cs_2 <=  ~( ( u5_temp_cs[3] & ( ( ( u5_rfr_ack_r | u5_susp_sel_r ) ) ? ( u7_cs_need_rfr[2] ) : ( ( ( ( u5_lmr_ack | u5_init_ack ) ) ? ( u0_spec_req_cs[2] ) : ( u0_cs[2] ) ) ) ) ));
        end
    end
    always @ (  posedge mc_clk_i or  posedge rst_i)
    begin
        if ( rst_i ) 
        begin
            u7_mc_cs_3 <= 1'b1;
        end
        else
        begin 
            u7_mc_cs_3 <=  ~( ( u5_temp_cs[3] & ( ( ( u5_rfr_ack_r | u5_susp_sel_r ) ) ? ( u7_cs_need_rfr[3] ) : ( ( ( ( u5_lmr_ack | u5_init_ack ) ) ? ( u0_spec_req_cs[3] ) : ( u0_cs[3] ) ) ) ) ));
        end
    end
    always @ (  posedge mc_clk_i or  posedge rst_i)
    begin
        if ( rst_i ) 
        begin
            u7_mc_cs_4 <= 1'b1;
        end
        else
        begin 
            u7_mc_cs_4 <=  ~( ( u5_temp_cs[3] & ( ( ( u5_rfr_ack_r | u5_susp_sel_r ) ) ? ( u7_cs_need_rfr[4] ) : ( ( ( ( u5_lmr_ack | u5_init_ack ) ) ? ( u0_spec_req_cs[4] ) : ( u0_cs[4] ) ) ) ) ));
        end
    end
    always @ (  posedge mc_clk_i or  posedge rst_i)
    begin
        if ( rst_i ) 
        begin
            u7_mc_cs_5 <= 1'b1;
        end
        else
        begin 
            u7_mc_cs_5 <=  ~( ( u5_temp_cs[3] & ( ( ( u5_rfr_ack_r | u5_susp_sel_r ) ) ? ( u7_cs_need_rfr[5] ) : ( ( ( ( u5_lmr_ack | u5_init_ack ) ) ? ( u0_spec_req_cs[5] ) : ( u0_cs[5] ) ) ) ) ));
        end
    end
    always @ (  posedge mc_clk_i or  posedge rst_i)
    begin
        if ( rst_i ) 
        begin
            u7_mc_cs_6 <= 1'b1;
        end
        else
        begin 
            u7_mc_cs_6 <=  ~( ( u5_temp_cs[3] & ( ( ( u5_rfr_ack_r | u5_susp_sel_r ) ) ? ( u7_cs_need_rfr[6] ) : ( ( ( ( u5_lmr_ack | u5_init_ack ) ) ? ( u0_spec_req_cs[6] ) : ( u0_cs[6] ) ) ) ) ));
        end
    end
    always @ (  posedge mc_clk_i or  posedge rst_i)
    begin
        if ( rst_i ) 
        begin
            u7_mc_cs_7 <= 1'b1;
        end
        else
        begin 
            u7_mc_cs_7 <=  ~( ( u5_temp_cs[3] & ( ( ( u5_rfr_ack_r | u5_susp_sel_r ) ) ? ( u7_cs_need_rfr[7] ) : ( ( ( ( u5_lmr_ack | u5_init_ack ) ) ? ( u0_spec_req_cs[7] ) : ( u0_cs[7] ) ) ) ) ));
        end
    end
    always @ (  posedge mc_clk_i)
    begin
        u7_mc_adsc_ <=  ~( u5_mc_adsc);
    end
    always @ (  posedge mc_clk_i)
    begin
        u7_mc_adv_ <=  ~( u5_mc_adv);
    end
endmodule 


