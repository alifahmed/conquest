module usb_phy(
        clk,
        rst,
        phy_tx_mode,
        usb_rst,
        txdp,
        txdn,
        txoe,
        rxd,
        rxdp,
        rxdn,
        DataOut_i,
        TxValid_i,
        TxReady_o,
        RxValid_o,
        RxActive_o,
        RxError_o,
        DataIn_o,
        LineState_o
    );
    parameter i_tx_phy_IDLE  = 3'd0;
    parameter i_tx_phy_SOP  = 3'h1;
    parameter i_tx_phy_DATA  = 3'h2;
    parameter i_tx_phy_EOP1  = 3'h3;
    parameter i_tx_phy_EOP2  = 3'h4;
    parameter i_tx_phy_WAIT  = 3'h5;
    parameter i_rx_phy_FS_IDLE  = 3'h0;
    parameter i_rx_phy_K1  = 3'h1;
    parameter i_rx_phy_J1  = 3'h2;
    parameter i_rx_phy_K2  = 3'h3;
    parameter i_rx_phy_J2  = 3'h4;
    parameter i_rx_phy_K3  = 3'h5;
    parameter i_rx_phy_J3  = 3'h6;
    parameter i_rx_phy_K4  = 3'h7;
    input clk;
    input rst;
    input phy_tx_mode;
    output usb_rst;
    output txdp;
    output txdn;
    output txoe;
    input rxd;
    input rxdp;
    input rxdn;
    input [7:0]DataOut_i;
    input TxValid_i;
    output TxReady_o;
    output RxValid_o;
    output RxActive_o;
    output RxError_o;
    output [7:0]DataIn_o;
    output [1:0]LineState_o;
    reg [4:0]rst_cnt;
    reg usb_rst;
    reg i_tx_phy_TxReady_o;
    reg [2:0]i_tx_phy_state;
    reg [2:0]i_tx_phy_next_state;
    reg i_tx_phy_tx_ready_d;
    reg i_tx_phy_ld_sop_d;
    reg i_tx_phy_ld_data_d;
    reg i_tx_phy_ld_eop_d;
    reg i_tx_phy_tx_ip;
    reg i_tx_phy_tx_ip_sync;
    reg [2:0]i_tx_phy_bit_cnt;
    reg [7:0]i_tx_phy_hold_reg;
    reg [7:0]i_tx_phy_hold_reg_d;
    reg i_tx_phy_sd_raw_o;
    reg i_tx_phy_data_done;
    reg i_tx_phy_sft_done;
    reg i_tx_phy_sft_done_r;
    reg i_tx_phy_ld_data;
    reg [2:0]i_tx_phy_one_cnt;
    wire i_tx_phy_stuff;
    reg i_tx_phy_sd_bs_o;
    reg i_tx_phy_sd_nrzi_o;
    reg i_tx_phy_append_eop;
    reg i_tx_phy_append_eop_sync1;
    reg i_tx_phy_append_eop_sync2;
    reg i_tx_phy_append_eop_sync3;
    reg i_tx_phy_append_eop_sync4;
    reg i_tx_phy_txdp;
    reg i_tx_phy_txdn;
    reg i_tx_phy_txoe_r1;
    reg i_tx_phy_txoe_r2;
    reg i_tx_phy_txoe;
    reg i_rx_phy_rxd_s0;
    reg i_rx_phy_rxd_s1;
    reg i_rx_phy_rxd_s;
    reg i_rx_phy_rxdp_s0;
    reg i_rx_phy_rxdp_s1;
    reg i_rx_phy_rxdp_s;
    reg i_rx_phy_rxdp_s_r;
    reg i_rx_phy_rxdn_s0;
    reg i_rx_phy_rxdn_s1;
    reg i_rx_phy_rxdn_s;
    reg i_rx_phy_rxdn_s_r;
    reg i_rx_phy_synced_d;
    reg i_rx_phy_rxd_r;
    reg i_rx_phy_rx_en;
    reg i_rx_phy_rx_active;
    reg [2:0]i_rx_phy_bit_cnt;
    reg i_rx_phy_rx_valid1;
    reg i_rx_phy_rx_valid;
    reg i_rx_phy_shift_en;
    reg i_rx_phy_sd_r;
    reg i_rx_phy_sd_nrzi;
    reg [7:0]i_rx_phy_hold_reg;
    reg [2:0]i_rx_phy_one_cnt;
    reg [1:0]i_rx_phy_dpll_state;
    reg [1:0]i_rx_phy_dpll_next_state;
    reg i_rx_phy_fs_ce_d;
    reg i_rx_phy_fs_ce;
    reg [2:0]i_rx_phy_fs_state;
    reg [2:0]i_rx_phy_fs_next_state;
    reg i_rx_phy_rx_valid_r;
    reg i_rx_phy_sync_err_d;
    reg i_rx_phy_sync_err;
    reg i_rx_phy_bit_stuff_err;
    reg i_rx_phy_se0_r;
    reg i_rx_phy_byte_err;
    reg i_rx_phy_se0_s;
    reg i_rx_phy_fs_ce_r1;
    reg i_rx_phy_fs_ce_r2;
    always @ (  posedge clk or  negedge rst)
    begin
        if (  !( rst) ) 
        begin
            rst_cnt <= 5'h0;
        end
        else
        begin 
            if ( LineState_o != 2'h0 ) 
            begin
                rst_cnt <= 5'h0;
            end
            else
            begin 
                if (  !( usb_rst) && i_rx_phy_fs_ce ) 
                begin
                    rst_cnt <= ( rst_cnt + 5'h1 );
                end
            end
        end
    end
    always @ (  posedge clk or  negedge rst)
    begin
        if (  !( rst) ) 
        begin
            usb_rst <= 1'b0;
        end
        else
        begin 
            usb_rst <= ( rst_cnt == 5'h1f );
        end
    end
    assign txdp = i_tx_phy_txdp;
    assign txdn = i_tx_phy_txdn;
    assign txoe = i_tx_phy_txoe;
    assign TxReady_o = i_tx_phy_TxReady_o;
    always @ (  posedge clk or  negedge rst)
    begin
        if (  !( rst) ) 
        begin
            i_tx_phy_TxReady_o <= 1'b0;
        end
        else
        begin 
            i_tx_phy_TxReady_o <= ( i_tx_phy_tx_ready_d & TxValid_i );
        end
    end
    always @ (  posedge clk)
    begin
        i_tx_phy_ld_data <= i_tx_phy_ld_data_d;
    end
    always @ (  posedge clk or  negedge rst)
    begin
        if (  !( rst) ) 
        begin
            i_tx_phy_tx_ip <= 1'b0;
        end
        else
        begin 
            if ( i_tx_phy_ld_sop_d ) 
            begin
                i_tx_phy_tx_ip <= 1'b1;
            end
            else
            begin 
                if ( i_tx_phy_append_eop_sync3 ) 
                begin
                    i_tx_phy_tx_ip <= 1'b0;
                end
            end
        end
    end
    always @ (  posedge clk or  negedge rst)
    begin
        if (  !( rst) ) 
        begin
            i_tx_phy_tx_ip_sync <= 1'b0;
        end
        else
        begin 
            if ( i_rx_phy_fs_ce ) 
            begin
                i_tx_phy_tx_ip_sync <= i_tx_phy_tx_ip;
            end
        end
    end
    always @ (  posedge clk or  negedge rst)
    begin
        if (  !( rst) ) 
        begin
            i_tx_phy_data_done <= 1'b0;
        end
        else
        begin 
            if ( TxValid_i &&  !( i_tx_phy_tx_ip) ) 
            begin
                i_tx_phy_data_done <= 1'b1;
            end
            else
            begin 
                if (  !( TxValid_i) ) 
                begin
                    i_tx_phy_data_done <= 1'b0;
                end
            end
        end
    end
    always @ (  posedge clk or  negedge rst)
    begin
        if (  !( rst) ) 
        begin
            i_tx_phy_bit_cnt <= 3'h0;
        end
        else
        begin 
            if (  !( i_tx_phy_tx_ip_sync) ) 
            begin
                i_tx_phy_bit_cnt <= 3'h0;
            end
            else
            begin 
                if ( i_rx_phy_fs_ce &&  !( i_tx_phy_stuff) ) 
                begin
                    i_tx_phy_bit_cnt <= ( i_tx_phy_bit_cnt + 3'h1 );
                end
            end
        end
    end
    always @ (  posedge clk)
    begin
        if (  !( i_tx_phy_tx_ip_sync) ) 
        begin
            i_tx_phy_sd_raw_o <= 1'b0;
        end
        else
        begin 
            case ( i_tx_phy_bit_cnt ) 
            3'h0:
            begin
                i_tx_phy_sd_raw_o <= i_tx_phy_hold_reg_d[0];
            end
            3'h1:
            begin
                i_tx_phy_sd_raw_o <= i_tx_phy_hold_reg_d[1];
            end
            3'h2:
            begin
                i_tx_phy_sd_raw_o <= i_tx_phy_hold_reg_d[2];
            end
            3'h3:
            begin
                i_tx_phy_sd_raw_o <= i_tx_phy_hold_reg_d[3];
            end
            3'h4:
            begin
                i_tx_phy_sd_raw_o <= i_tx_phy_hold_reg_d[4];
            end
            3'h5:
            begin
                i_tx_phy_sd_raw_o <= i_tx_phy_hold_reg_d[5];
            end
            3'h6:
            begin
                i_tx_phy_sd_raw_o <= i_tx_phy_hold_reg_d[6];
            end
            3'h7:
            begin
                i_tx_phy_sd_raw_o <= i_tx_phy_hold_reg_d[7];
            end
            endcase
        end
    end
    always @ (  posedge clk)
    begin
        i_tx_phy_sft_done <= (  !( ( i_tx_phy_one_cnt == 3'h6 )) & ( i_tx_phy_bit_cnt == 3'h7 ) );
    end
    always @ (  posedge clk)
    begin
        i_tx_phy_sft_done_r <= i_tx_phy_sft_done;
    end
    always @ (  posedge clk)
    begin
        if ( i_tx_phy_ld_sop_d ) 
        begin
            i_tx_phy_hold_reg <= 8'h80;
        end
        else
        begin 
            if ( i_tx_phy_ld_data ) 
            begin
                i_tx_phy_hold_reg <= DataOut_i;
            end
        end
    end
    always @ (  posedge clk)
    begin
        i_tx_phy_hold_reg_d <= i_tx_phy_hold_reg;
    end
    always @ (  posedge clk or  negedge rst)
    begin
        if (  !( rst) ) 
        begin
            i_tx_phy_one_cnt <= 3'h0;
        end
        else
        begin 
            if (  !( i_tx_phy_tx_ip_sync) ) 
            begin
                i_tx_phy_one_cnt <= 3'h0;
            end
            else
            begin 
                if ( i_rx_phy_fs_ce ) 
                begin
                    if (  !( i_tx_phy_sd_raw_o) || ( i_tx_phy_one_cnt == 3'h6 ) ) 
                    begin
                        i_tx_phy_one_cnt <= 3'h0;
                    end
                    else
                    begin 
                        i_tx_phy_one_cnt <= ( i_tx_phy_one_cnt + 3'h1 );
                    end
                end
            end
        end
    end
    assign i_tx_phy_stuff = ( i_tx_phy_one_cnt == 3'h6 );
    always @ (  posedge clk or  negedge rst)
    begin
        if (  !( rst) ) 
        begin
            i_tx_phy_sd_bs_o <= 1'h0;
        end
        else
        begin 
            if ( i_rx_phy_fs_ce ) 
            begin
                i_tx_phy_sd_bs_o <= ( (  !( i_tx_phy_tx_ip_sync) ) ? ( 1'b0 ) : ( ( ( ( i_tx_phy_one_cnt == 3'h6 ) ) ? ( 1'b0 ) : ( i_tx_phy_sd_raw_o ) ) ) );
            end
        end
    end
    always @ (  posedge clk or  negedge rst)
    begin
        if (  !( rst) ) 
        begin
            i_tx_phy_sd_nrzi_o <= 1'b1;
        end
        else
        begin 
            if (  !( i_tx_phy_tx_ip_sync) ||  !( i_tx_phy_txoe_r1) ) 
            begin
                i_tx_phy_sd_nrzi_o <= 1'b1;
            end
            else
            begin 
                if ( i_rx_phy_fs_ce ) 
                begin
                    i_tx_phy_sd_nrzi_o <= ( ( i_tx_phy_sd_bs_o ) ? ( i_tx_phy_sd_nrzi_o ) : (  ~( i_tx_phy_sd_nrzi_o) ) );
                end
            end
        end
    end
    always @ (  posedge clk or  negedge rst)
    begin
        if (  !( rst) ) 
        begin
            i_tx_phy_append_eop <= 1'b0;
        end
        else
        begin 
            if ( i_tx_phy_ld_eop_d ) 
            begin
                i_tx_phy_append_eop <= 1'b1;
            end
            else
            begin 
                if ( i_tx_phy_append_eop_sync2 ) 
                begin
                    i_tx_phy_append_eop <= 1'b0;
                end
            end
        end
    end
    always @ (  posedge clk or  negedge rst)
    begin
        if (  !( rst) ) 
        begin
            i_tx_phy_append_eop_sync1 <= 1'b0;
        end
        else
        begin 
            if ( i_rx_phy_fs_ce ) 
            begin
                i_tx_phy_append_eop_sync1 <= i_tx_phy_append_eop;
            end
        end
    end
    always @ (  posedge clk or  negedge rst)
    begin
        if (  !( rst) ) 
        begin
            i_tx_phy_append_eop_sync2 <= 1'b0;
        end
        else
        begin 
            if ( i_rx_phy_fs_ce ) 
            begin
                i_tx_phy_append_eop_sync2 <= i_tx_phy_append_eop_sync1;
            end
        end
    end
    always @ (  posedge clk or  negedge rst)
    begin
        if (  !( rst) ) 
        begin
            i_tx_phy_append_eop_sync3 <= 1'b0;
        end
        else
        begin 
            if ( i_rx_phy_fs_ce ) 
            begin
                i_tx_phy_append_eop_sync3 <= ( i_tx_phy_append_eop_sync2 | ( i_tx_phy_append_eop_sync3 &  !( i_tx_phy_append_eop_sync4) ) );
            end
        end
    end
    always @ (  posedge clk or  negedge rst)
    begin
        if (  !( rst) ) 
        begin
            i_tx_phy_append_eop_sync4 <= 1'b0;
        end
        else
        begin 
            if ( i_rx_phy_fs_ce ) 
            begin
                i_tx_phy_append_eop_sync4 <= i_tx_phy_append_eop_sync3;
            end
        end
    end
    always @ (  posedge clk or  negedge rst)
    begin
        if (  !( rst) ) 
        begin
            i_tx_phy_txoe_r1 <= 1'b0;
        end
        else
        begin 
            if ( i_rx_phy_fs_ce ) 
            begin
                i_tx_phy_txoe_r1 <= i_tx_phy_tx_ip_sync;
            end
        end
    end
    always @ (  posedge clk or  negedge rst)
    begin
        if (  !( rst) ) 
        begin
            i_tx_phy_txoe_r2 <= 1'b0;
        end
        else
        begin 
            if ( i_rx_phy_fs_ce ) 
            begin
                i_tx_phy_txoe_r2 <= i_tx_phy_txoe_r1;
            end
        end
    end
    always @ (  posedge clk or  negedge rst)
    begin
        if (  !( rst) ) 
        begin
            i_tx_phy_txoe <= 1'b1;
        end
        else
        begin 
            if ( i_rx_phy_fs_ce ) 
            begin
                i_tx_phy_txoe <=  !( ( i_tx_phy_txoe_r1 | i_tx_phy_txoe_r2 ));
            end
        end
    end
    always @ (  posedge clk or  negedge rst)
    begin
        if (  !( rst) ) 
        begin
            i_tx_phy_txdp <= 1'b1;
        end
        else
        begin 
            if ( i_rx_phy_fs_ce ) 
            begin
                i_tx_phy_txdp <= ( ( phy_tx_mode ) ? ( (  !( i_tx_phy_append_eop_sync3) & i_tx_phy_sd_nrzi_o ) ) : ( i_tx_phy_sd_nrzi_o ) );
            end
        end
    end
    always @ (  posedge clk or  negedge rst)
    begin
        if (  !( rst) ) 
        begin
            i_tx_phy_txdn <= 1'b0;
        end
        else
        begin 
            if ( i_rx_phy_fs_ce ) 
            begin
                i_tx_phy_txdn <= ( ( phy_tx_mode ) ? ( (  !( i_tx_phy_append_eop_sync3) &  ~( i_tx_phy_sd_nrzi_o) ) ) : ( i_tx_phy_append_eop_sync3 ) );
            end
        end
    end
    always @ (  posedge clk or  negedge rst)
    begin
        if (  !( rst) ) 
        begin
            i_tx_phy_state <= i_tx_phy_IDLE;
        end
        else
        begin 
            i_tx_phy_state <= i_tx_phy_next_state;
        end
    end
    always @ (  i_tx_phy_state or  TxValid_i or  i_tx_phy_data_done or  ( i_tx_phy_sft_done &  !( i_tx_phy_sft_done_r) ) or  i_tx_phy_append_eop_sync3 or  i_rx_phy_fs_ce)
    begin
        i_tx_phy_next_state = i_tx_phy_state;
        i_tx_phy_tx_ready_d = 1'b0;
        i_tx_phy_ld_sop_d = 1'b0;
        i_tx_phy_ld_data_d = 1'b0;
        i_tx_phy_ld_eop_d = 1'b0;
        case ( i_tx_phy_state ) 
        i_tx_phy_IDLE:
        begin
            if ( TxValid_i ) 
            begin
                i_tx_phy_ld_sop_d = 1'b1;
                i_tx_phy_next_state = i_tx_phy_SOP;
            end
        end
        i_tx_phy_SOP:
        begin
            if ( i_tx_phy_sft_done &  !( i_tx_phy_sft_done_r) ) 
            begin
                i_tx_phy_tx_ready_d = 1'b1;
                i_tx_phy_ld_data_d = 1'b1;
                i_tx_phy_next_state = i_tx_phy_DATA;
            end
        end
        i_tx_phy_DATA:
        begin
            if (  !( i_tx_phy_data_done) && ( i_tx_phy_sft_done &  !( i_tx_phy_sft_done_r) ) ) 
            begin
                i_tx_phy_ld_eop_d = 1'b1;
                i_tx_phy_next_state = i_tx_phy_EOP1;
            end
            if ( i_tx_phy_data_done && ( i_tx_phy_sft_done &  !( i_tx_phy_sft_done_r) ) ) 
            begin
                i_tx_phy_tx_ready_d = 1'b1;
                i_tx_phy_ld_data_d = 1'b1;
            end
        end
        i_tx_phy_EOP1:
        begin
            if ( i_tx_phy_append_eop_sync3 ) 
            begin
                i_tx_phy_next_state = i_tx_phy_EOP2;
            end
        end
        i_tx_phy_EOP2:
        begin
            if (  !( i_tx_phy_append_eop_sync3) && i_rx_phy_fs_ce ) 
            begin
                i_tx_phy_next_state = i_tx_phy_WAIT;
            end
        end
        i_tx_phy_WAIT:
        begin
            if ( i_rx_phy_fs_ce ) 
            begin
                i_tx_phy_next_state = i_tx_phy_IDLE;
            end
        end
        endcase
    end
    assign DataIn_o = i_rx_phy_hold_reg;
    assign RxValid_o = i_rx_phy_rx_valid;
    assign RxActive_o = i_rx_phy_rx_active;
    assign RxError_o = ( ( i_rx_phy_sync_err | i_rx_phy_bit_stuff_err ) | i_rx_phy_byte_err );
    assign LineState_o = { i_rx_phy_rxdn_s1, i_rx_phy_rxdp_s1 };
    always @ (  posedge clk)
    begin
        i_rx_phy_rx_en <= txoe;
    end
    always @ (  posedge clk)
    begin
        i_rx_phy_sync_err <= (  !( i_rx_phy_rx_active) & i_rx_phy_sync_err_d );
    end
    always @ (  posedge clk)
    begin
        i_rx_phy_rxd_s0 <= rxd;
    end
    always @ (  posedge clk)
    begin
        i_rx_phy_rxd_s1 <= i_rx_phy_rxd_s0;
    end
    always @ (  posedge clk)
    begin
        if ( i_rx_phy_rxd_s0 && i_rx_phy_rxd_s1 ) 
        begin
            i_rx_phy_rxd_s <= 1'b1;
        end
        else
        begin 
            if (  !( i_rx_phy_rxd_s0) &&  !( i_rx_phy_rxd_s1) ) 
            begin
                i_rx_phy_rxd_s <= 1'b0;
            end
        end
    end
    always @ (  posedge clk)
    begin
        i_rx_phy_rxdp_s0 <= rxdp;
    end
    always @ (  posedge clk)
    begin
        i_rx_phy_rxdp_s1 <= i_rx_phy_rxdp_s0;
    end
    always @ (  posedge clk)
    begin
        i_rx_phy_rxdp_s_r <= ( i_rx_phy_rxdp_s0 & i_rx_phy_rxdp_s1 );
    end
    always @ (  posedge clk)
    begin
        i_rx_phy_rxdp_s <= ( ( i_rx_phy_rxdp_s0 & i_rx_phy_rxdp_s1 ) | i_rx_phy_rxdp_s_r );
    end
    always @ (  posedge clk)
    begin
        i_rx_phy_rxdn_s0 <= rxdn;
    end
    always @ (  posedge clk)
    begin
        i_rx_phy_rxdn_s1 <= i_rx_phy_rxdn_s0;
    end
    always @ (  posedge clk)
    begin
        i_rx_phy_rxdn_s_r <= ( i_rx_phy_rxdn_s0 & i_rx_phy_rxdn_s1 );
    end
    always @ (  posedge clk)
    begin
        i_rx_phy_rxdn_s <= ( ( i_rx_phy_rxdn_s0 & i_rx_phy_rxdn_s1 ) | i_rx_phy_rxdn_s_r );
    end
    always @ (  posedge clk)
    begin
        if ( i_rx_phy_fs_ce ) 
        begin
            i_rx_phy_se0_s <= (  !( i_rx_phy_rxdp_s) &  !( i_rx_phy_rxdn_s) );
        end
    end
    always @ (  posedge clk)
    begin
        i_rx_phy_rxd_r <= i_rx_phy_rxd_s;
    end
    always @ (  posedge clk or  negedge rst)
    begin
        if (  !( rst) ) 
        begin
            i_rx_phy_dpll_state <= 2'h1;
        end
        else
        begin 
            i_rx_phy_dpll_state <= i_rx_phy_dpll_next_state;
        end
    end
    always @ (  i_rx_phy_dpll_state or  i_rx_phy_rx_en or  ( i_rx_phy_rxd_r != i_rx_phy_rxd_s ))
    begin
        i_rx_phy_fs_ce_d = 1'b0;
        case ( i_rx_phy_dpll_state ) 
        2'h0:
        begin
            if ( i_rx_phy_rx_en && ( i_rx_phy_rxd_r != i_rx_phy_rxd_s ) ) 
            begin
                i_rx_phy_dpll_next_state = 2'h0;
            end
            else
            begin 
                i_rx_phy_dpll_next_state = 2'h1;
            end
        end
        2'h1:
        begin
            i_rx_phy_fs_ce_d = 1'b1;
            if ( i_rx_phy_rx_en && ( i_rx_phy_rxd_r != i_rx_phy_rxd_s ) ) 
            begin
                i_rx_phy_dpll_next_state = 2'h3;
            end
            else
            begin 
                i_rx_phy_dpll_next_state = 2'h2;
            end
        end
        2'h2:
        begin
            if ( i_rx_phy_rx_en && ( i_rx_phy_rxd_r != i_rx_phy_rxd_s ) ) 
            begin
                i_rx_phy_dpll_next_state = 2'h0;
            end
            else
            begin 
                i_rx_phy_dpll_next_state = 2'h3;
            end
        end
        2'h3:
        begin
            if ( i_rx_phy_rx_en && ( i_rx_phy_rxd_r != i_rx_phy_rxd_s ) ) 
            begin
                i_rx_phy_dpll_next_state = 2'h0;
            end
            else
            begin 
                i_rx_phy_dpll_next_state = 2'h0;
            end
        end
        endcase
    end
    always @ (  posedge clk)
    begin
        i_rx_phy_fs_ce_r1 <= i_rx_phy_fs_ce_d;
    end
    always @ (  posedge clk)
    begin
        i_rx_phy_fs_ce_r2 <= i_rx_phy_fs_ce_r1;
    end
    always @ (  posedge clk)
    begin
        i_rx_phy_fs_ce <= i_rx_phy_fs_ce_r2;
    end
    always @ (  posedge clk or  negedge rst)
    begin
        if (  !( rst) ) 
        begin
            i_rx_phy_fs_state <= i_rx_phy_FS_IDLE;
        end
        else
        begin 
            i_rx_phy_fs_state <= i_rx_phy_fs_next_state;
        end
    end
    always @ (  i_rx_phy_fs_state or  i_rx_phy_fs_ce or  (  !( i_rx_phy_rxdp_s) & i_rx_phy_rxdn_s ) or  ( i_rx_phy_rxdp_s &  !( i_rx_phy_rxdn_s) ) or  i_rx_phy_rx_en or  i_rx_phy_rx_active or  (  !( i_rx_phy_rxdp_s) &  !( i_rx_phy_rxdn_s) ) or  i_rx_phy_se0_s)
    begin
        i_rx_phy_synced_d = 1'b0;
        i_rx_phy_sync_err_d = 1'b0;
        i_rx_phy_fs_next_state = i_rx_phy_fs_state;
        if ( ( ( i_rx_phy_fs_ce &&  !( i_rx_phy_rx_active) ) &&  !( (  !( i_rx_phy_rxdp_s) &  !( i_rx_phy_rxdn_s) )) ) &&  !( i_rx_phy_se0_s) ) 
        begin
            case ( i_rx_phy_fs_state ) 
            i_rx_phy_FS_IDLE:
            begin
                if ( (  !( i_rx_phy_rxdp_s) & i_rx_phy_rxdn_s ) && i_rx_phy_rx_en ) 
                begin
                    i_rx_phy_fs_next_state = i_rx_phy_K1;
                end
            end
            i_rx_phy_K1:
            begin
                if ( ( i_rx_phy_rxdp_s &  !( i_rx_phy_rxdn_s) ) && i_rx_phy_rx_en ) 
                begin
                    i_rx_phy_fs_next_state = i_rx_phy_J1;
                end
                else
                begin 
                    i_rx_phy_sync_err_d = 1'b1;
                    i_rx_phy_fs_next_state = i_rx_phy_FS_IDLE;
                end
            end
            i_rx_phy_J1:
            begin
                if ( (  !( i_rx_phy_rxdp_s) & i_rx_phy_rxdn_s ) && i_rx_phy_rx_en ) 
                begin
                    i_rx_phy_fs_next_state = i_rx_phy_K2;
                end
                else
                begin 
                    i_rx_phy_sync_err_d = 1'b1;
                    i_rx_phy_fs_next_state = i_rx_phy_FS_IDLE;
                end
            end
            i_rx_phy_K2:
            begin
                if ( ( i_rx_phy_rxdp_s &  !( i_rx_phy_rxdn_s) ) && i_rx_phy_rx_en ) 
                begin
                    i_rx_phy_fs_next_state = i_rx_phy_J2;
                end
                else
                begin 
                    i_rx_phy_sync_err_d = 1'b1;
                    i_rx_phy_fs_next_state = i_rx_phy_FS_IDLE;
                end
            end
            i_rx_phy_J2:
            begin
                if ( (  !( i_rx_phy_rxdp_s) & i_rx_phy_rxdn_s ) && i_rx_phy_rx_en ) 
                begin
                    i_rx_phy_fs_next_state = i_rx_phy_K3;
                end
                else
                begin 
                    i_rx_phy_sync_err_d = 1'b1;
                    i_rx_phy_fs_next_state = i_rx_phy_FS_IDLE;
                end
            end
            i_rx_phy_K3:
            begin
                if ( ( i_rx_phy_rxdp_s &  !( i_rx_phy_rxdn_s) ) && i_rx_phy_rx_en ) 
                begin
                    i_rx_phy_fs_next_state = i_rx_phy_J3;
                end
                else
                begin 
                    if ( (  !( i_rx_phy_rxdp_s) & i_rx_phy_rxdn_s ) && i_rx_phy_rx_en ) 
                    begin
                        i_rx_phy_fs_next_state = i_rx_phy_FS_IDLE;
                        i_rx_phy_synced_d = 1'b1;
                    end
                    else
                    begin 
                        i_rx_phy_sync_err_d = 1'b1;
                        i_rx_phy_fs_next_state = i_rx_phy_FS_IDLE;
                    end
                end
            end
            i_rx_phy_J3:
            begin
                if ( (  !( i_rx_phy_rxdp_s) & i_rx_phy_rxdn_s ) && i_rx_phy_rx_en ) 
                begin
                    i_rx_phy_fs_next_state = i_rx_phy_K4;
                end
                else
                begin 
                    i_rx_phy_sync_err_d = 1'b1;
                    i_rx_phy_fs_next_state = i_rx_phy_FS_IDLE;
                end
            end
            i_rx_phy_K4:
            begin
                if (  !( i_rx_phy_rxdp_s) & i_rx_phy_rxdn_s ) 
                begin
                    i_rx_phy_synced_d = 1'b1;
                end
                i_rx_phy_fs_next_state = i_rx_phy_FS_IDLE;
            end
            endcase
        end
    end
    always @ (  posedge clk or  negedge rst)
    begin
        if (  !( rst) ) 
        begin
            i_rx_phy_rx_active <= 1'b0;
        end
        else
        begin 
            if ( i_rx_phy_synced_d && i_rx_phy_rx_en ) 
            begin
                i_rx_phy_rx_active <= 1'b1;
            end
            else
            begin 
                if ( (  !( i_rx_phy_rxdp_s) &  !( i_rx_phy_rxdn_s) ) && i_rx_phy_rx_valid_r ) 
                begin
                    i_rx_phy_rx_active <= 1'b0;
                end
            end
        end
    end
    always @ (  posedge clk)
    begin
        if ( i_rx_phy_rx_valid ) 
        begin
            i_rx_phy_rx_valid_r <= 1'b1;
        end
        else
        begin 
            if ( i_rx_phy_fs_ce ) 
            begin
                i_rx_phy_rx_valid_r <= 1'b0;
            end
        end
    end
    always @ (  posedge clk)
    begin
        if ( i_rx_phy_fs_ce ) 
        begin
            i_rx_phy_sd_r <= i_rx_phy_rxd_s;
        end
    end
    always @ (  posedge clk or  negedge rst)
    begin
        if (  !( rst) ) 
        begin
            i_rx_phy_sd_nrzi <= 1'b0;
        end
        else
        begin 
            if (  !( i_rx_phy_rx_active) ) 
            begin
                i_rx_phy_sd_nrzi <= 1'b1;
            end
            else
            begin 
                if ( i_rx_phy_rx_active && i_rx_phy_fs_ce ) 
                begin
                    i_rx_phy_sd_nrzi <=  !( ( i_rx_phy_rxd_s ^ i_rx_phy_sd_r ));
                end
            end
        end
    end
    always @ (  posedge clk or  negedge rst)
    begin
        if (  !( rst) ) 
        begin
            i_rx_phy_one_cnt <= 3'h0;
        end
        else
        begin 
            if (  !( i_rx_phy_shift_en) ) 
            begin
                i_rx_phy_one_cnt <= 3'h0;
            end
            else
            begin 
                if ( i_rx_phy_fs_ce ) 
                begin
                    if (  !( i_rx_phy_sd_nrzi) || ( i_rx_phy_one_cnt == 3'h6 ) ) 
                    begin
                        i_rx_phy_one_cnt <= 3'h0;
                    end
                    else
                    begin 
                        i_rx_phy_one_cnt <= ( i_rx_phy_one_cnt + 3'h1 );
                    end
                end
            end
        end
    end
    always @ (  posedge clk)
    begin
        i_rx_phy_bit_stuff_err <= ( ( ( ( ( i_rx_phy_one_cnt == 3'h6 ) & i_rx_phy_sd_nrzi ) & i_rx_phy_fs_ce ) &  !( (  !( i_rx_phy_rxdp_s) &  !( i_rx_phy_rxdn_s) )) ) & i_rx_phy_rx_active );
    end
    always @ (  posedge clk)
    begin
        if ( i_rx_phy_fs_ce ) 
        begin
            i_rx_phy_shift_en <= ( i_rx_phy_synced_d | i_rx_phy_rx_active );
        end
    end
    always @ (  posedge clk)
    begin
        if ( ( i_rx_phy_fs_ce && i_rx_phy_shift_en ) &&  !( ( i_rx_phy_one_cnt == 3'h6 )) ) 
        begin
            i_rx_phy_hold_reg <= { i_rx_phy_sd_nrzi, i_rx_phy_hold_reg[7:1] };
        end
    end
    always @ (  posedge clk or  negedge rst)
    begin
        if (  !( rst) ) 
        begin
            i_rx_phy_bit_cnt <= 3'b0;
        end
        else
        begin 
            if (  !( i_rx_phy_shift_en) ) 
            begin
                i_rx_phy_bit_cnt <= 3'h0;
            end
            else
            begin 
                if ( i_rx_phy_fs_ce &&  !( ( i_rx_phy_one_cnt == 3'h6 )) ) 
                begin
                    i_rx_phy_bit_cnt <= ( i_rx_phy_bit_cnt + 3'h1 );
                end
            end
        end
    end
    always @ (  posedge clk or  negedge rst)
    begin
        if (  !( rst) ) 
        begin
            i_rx_phy_rx_valid1 <= 1'b0;
        end
        else
        begin 
            if ( ( i_rx_phy_fs_ce &&  !( ( i_rx_phy_one_cnt == 3'h6 )) ) && ( i_rx_phy_bit_cnt == 3'h7 ) ) 
            begin
                i_rx_phy_rx_valid1 <= 1'b1;
            end
            else
            begin 
                if ( ( i_rx_phy_rx_valid1 && i_rx_phy_fs_ce ) &&  !( ( i_rx_phy_one_cnt == 3'h6 )) ) 
                begin
                    i_rx_phy_rx_valid1 <= 1'b0;
                end
            end
        end
    end
    always @ (  posedge clk)
    begin
        i_rx_phy_rx_valid <= ( (  !( ( i_rx_phy_one_cnt == 3'h6 )) & i_rx_phy_rx_valid1 ) & i_rx_phy_fs_ce );
    end
    always @ (  posedge clk)
    begin
        i_rx_phy_se0_r <= (  !( i_rx_phy_rxdp_s) &  !( i_rx_phy_rxdn_s) );
    end
    always @ (  posedge clk)
    begin
        i_rx_phy_byte_err <= ( ( ( (  !( i_rx_phy_rxdp_s) &  !( i_rx_phy_rxdn_s) ) &  !( i_rx_phy_se0_r) ) &  |( i_rx_phy_bit_cnt[2:1]) ) & i_rx_phy_rx_active );
    end
endmodule 


