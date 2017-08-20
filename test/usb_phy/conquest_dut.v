// Following code segment is generated from flattened.v:1
module usb_phy(clk, rst, phy_tx_mode, usb_rst, txdp, txdn, txoe, rxd, rxdp, rxdn, DataOut_i, TxValid_i, TxReady_o, RxValid_o, RxActive_o, RxError_o, DataIn_o, LineState_o, __obs);
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
    input [7:0] DataOut_i;
    input TxValid_i;
    output TxReady_o;
    output RxValid_o;
    output RxActive_o;
    output RxError_o;
    output [7:0] DataIn_o;
    output [1:0] LineState_o;
    input __obs;

    reg [7:0] DataIn_o = 8'b0;
    reg [1:0] LineState_o = 2'b0;
    reg RxActive_o = 1'b0;
    reg RxError_o = 1'b0;
    reg RxValid_o = 1'b0;
    reg TxReady_o = 1'b0;
    reg [2:0] i_rx_phy_bit_cnt = 3'b0;
    reg i_rx_phy_bit_stuff_err = 1'b0;
    reg i_rx_phy_byte_err = 1'b0;
    reg [1:0] i_rx_phy_dpll_next_state = 2'b0;
    reg [1:0] i_rx_phy_dpll_state = 2'b0;
    reg i_rx_phy_fs_ce = 1'b0;
    reg i_rx_phy_fs_ce_d = 1'b0;
    reg i_rx_phy_fs_ce_r1 = 1'b0;
    reg i_rx_phy_fs_ce_r2 = 1'b0;
    reg [2:0] i_rx_phy_fs_next_state = 3'b0;
    reg [2:0] i_rx_phy_fs_state = 3'b0;
    reg [7:0] i_rx_phy_hold_reg = 8'b0;
    reg [2:0] i_rx_phy_one_cnt = 3'b0;
    reg i_rx_phy_rx_active = 1'b0;
    reg i_rx_phy_rx_en = 1'b0;
    reg i_rx_phy_rx_valid = 1'b0;
    reg i_rx_phy_rx_valid1 = 1'b0;
    reg i_rx_phy_rx_valid_r = 1'b0;
    reg i_rx_phy_rxd_r = 1'b0;
    reg i_rx_phy_rxd_s = 1'b0;
    reg i_rx_phy_rxd_s0 = 1'b0;
    reg i_rx_phy_rxd_s1 = 1'b0;
    reg i_rx_phy_rxdn_s = 1'b0;
    reg i_rx_phy_rxdn_s0 = 1'b0;
    reg i_rx_phy_rxdn_s1 = 1'b0;
    reg i_rx_phy_rxdn_s_r = 1'b0;
    reg i_rx_phy_rxdp_s = 1'b0;
    reg i_rx_phy_rxdp_s0 = 1'b0;
    reg i_rx_phy_rxdp_s1 = 1'b0;
    reg i_rx_phy_rxdp_s_r = 1'b0;
    reg i_rx_phy_sd_nrzi = 1'b0;
    reg i_rx_phy_sd_r = 1'b0;
    reg i_rx_phy_se0_r = 1'b0;
    reg i_rx_phy_se0_s = 1'b0;
    reg i_rx_phy_shift_en = 1'b0;
    reg i_rx_phy_sync_err = 1'b0;
    reg i_rx_phy_sync_err_d = 1'b0;
    reg i_rx_phy_synced_d = 1'b0;
    reg i_tx_phy_TxReady_o = 1'b0;
    reg i_tx_phy_append_eop = 1'b0;
    reg i_tx_phy_append_eop_sync1 = 1'b0;
    reg i_tx_phy_append_eop_sync2 = 1'b0;
    reg i_tx_phy_append_eop_sync3 = 1'b0;
    reg i_tx_phy_append_eop_sync4 = 1'b0;
    reg [2:0] i_tx_phy_bit_cnt = 3'b0;
    reg i_tx_phy_data_done = 1'b0;
    reg [7:0] i_tx_phy_hold_reg = 8'b0;
    reg [7:0] i_tx_phy_hold_reg_d = 8'b0;
    reg i_tx_phy_ld_data = 1'b0;
    reg i_tx_phy_ld_data_d = 1'b0;
    reg i_tx_phy_ld_eop_d = 1'b0;
    reg i_tx_phy_ld_sop_d = 1'b0;
    reg [2:0] i_tx_phy_next_state = 3'b0;
    reg [2:0] i_tx_phy_one_cnt = 3'b0;
    reg i_tx_phy_sd_bs_o = 1'b0;
    reg i_tx_phy_sd_nrzi_o = 1'b0;
    reg i_tx_phy_sd_raw_o = 1'b0;
    reg i_tx_phy_sft_done = 1'b0;
    reg i_tx_phy_sft_done_r = 1'b0;
    reg [2:0] i_tx_phy_state = 3'b0;
    reg i_tx_phy_stuff = 1'b0;
    reg i_tx_phy_tx_ip = 1'b0;
    reg i_tx_phy_tx_ip_sync = 1'b0;
    reg i_tx_phy_tx_ready_d = 1'b0;
    reg i_tx_phy_txdn = 1'b0;
    reg i_tx_phy_txdp = 1'b0;
    reg i_tx_phy_txoe = 1'b0;
    reg i_tx_phy_txoe_r1 = 1'b0;
    reg i_tx_phy_txoe_r2 = 1'b0;
    reg [4:0] rst_cnt = 5'b0;
    reg txdn = 1'b0;
    reg txdp = 1'b0;
    reg txoe = 1'b0;
    reg usb_rst = 1'b0;

    always @(*) begin
        i_tx_phy_stuff = (i_tx_phy_one_cnt == 3'b110); $display(";A 0");		//(assert (= @i_tx_phy_stuff    (bv-comp #i_tx_phy_one_cnt  0b110))) ;0 BL
    end

    always @(*) begin
        LineState_o = {i_rx_phy_rxdn_s1, i_rx_phy_rxdp_s1}; $display(";A 1");		//(assert (= @LineState_o    (bv-concat #i_rx_phy_rxdn_s1  #i_rx_phy_rxdp_s1 ))) ;1 BL
    end

    always @(*) begin
txdp = i_tx_phy_txdp; $display(";A 2");		//(assert (= @txdp    #i_tx_phy_txdp )) ;2 BL
    end
    always @(*) begin
txdn = i_tx_phy_txdn; $display(";A 3");		//(assert (= @txdn    #i_tx_phy_txdn )) ;3 BL
    end
    always @(*) begin
txoe = i_tx_phy_txoe; $display(";A 4");		//(assert (= @txoe    #i_tx_phy_txoe )) ;4 BL
    end
    always @(*) begin
TxReady_o = i_tx_phy_TxReady_o; $display(";A 5");		//(assert (= @TxReady_o    #i_tx_phy_TxReady_o )) ;5 BL
    end
    always @(*) begin
DataIn_o = i_rx_phy_hold_reg; $display(";A 6");		//(assert (= @DataIn_o    #i_rx_phy_hold_reg )) ;6 BL
    end
    always @(*) begin
RxValid_o = i_rx_phy_rx_valid; $display(";A 7");		//(assert (= @RxValid_o    #i_rx_phy_rx_valid )) ;7 BL
    end
    always @(*) begin
RxActive_o = i_rx_phy_rx_active; $display(";A 8");		//(assert (= @RxActive_o    #i_rx_phy_rx_active )) ;8 BL
    end
    always @(*) begin
        RxError_o = ((i_rx_phy_sync_err | i_rx_phy_bit_stuff_err) | i_rx_phy_byte_err); $display(";A 9");		//(assert (= @RxError_o    (bv-or (bv-or #i_rx_phy_sync_err  #i_rx_phy_bit_stuff_err ) #i_rx_phy_byte_err ))) ;9 BL
    end
    // Following code segment is generated from flattened.v:124
    always @(posedge clk or negedge rst) begin
        if ((!rst)) begin
            rst_cnt <= #1 5'b00000;        end
        else begin
            if ((LineState_o != 2'b00)) begin
                $display(";A 13");		//(assert (= (bv-not (bv-comp #LineState_o  0b00))   0b1)) ;13 BR
                rst_cnt <= #1 5'b00000;            end
            else begin
                $display(";A 14");		//(assert (= (bv-not (bv-comp #LineState_o  0b00))   0b0)) ;14 BR
                if (((!usb_rst) && i_rx_phy_fs_ce)) begin
                    rst_cnt <= #1 (rst_cnt + 5'b00001);                end
                else begin
                end
            end
        end
    end

    // Following code segment is generated from flattened.v:145
    always @(posedge clk or negedge rst) begin
        if ((!rst)) begin
            usb_rst <= #1 1'b0;        end
        else begin
            usb_rst <= #1 (rst_cnt == 5'b11111);        end
    end

    // Following code segment is generated from flattened.v:160
    always @(posedge clk or negedge rst) begin
        if ((!rst)) begin
            i_tx_phy_TxReady_o <= #1 1'b0; $display(";A 25");		//(assert (= @i_tx_phy_TxReady_o    0b0)) ;25 NB
        end
        else begin
            i_tx_phy_TxReady_o <= #1 (i_tx_phy_tx_ready_d & TxValid_i); $display(";A 26");		//(assert (= @i_tx_phy_TxReady_o    (bv-and #i_tx_phy_tx_ready_d  #TxValid_i ))) ;26 NB
        end
    end

    // Following code segment is generated from flattened.v:171
    always @(posedge clk) begin
        i_tx_phy_ld_data <= #1 i_tx_phy_ld_data_d; $display(";A 27");		//(assert (= @i_tx_phy_ld_data    #i_tx_phy_ld_data_d )) ;27 NB
    end

    // Following code segment is generated from flattened.v:175
    always @(posedge clk or negedge rst) begin
        if ((!rst)) begin
            i_tx_phy_tx_ip <= #1 1'b0; $display(";A 30");		//(assert (= @i_tx_phy_tx_ip    0b0)) ;30 NB
        end
        else begin
            if (i_tx_phy_ld_sop_d) begin
                $display(";A 31");		//(assert (= #i_tx_phy_ld_sop_d    0b1)) ;31 BR
                i_tx_phy_tx_ip <= #1 1'b1; $display(";A 33");		//(assert (= @i_tx_phy_tx_ip    0b1)) ;33 NB
            end
            else begin
                $display(";A 32");		//(assert (= #i_tx_phy_ld_sop_d    0b0)) ;32 BR
                if (i_tx_phy_append_eop_sync3) begin
                    $display(";A 34");		//(assert (= #i_tx_phy_append_eop_sync3    0b1)) ;34 BR
                    i_tx_phy_tx_ip <= #1 1'b0; $display(";A 36");		//(assert (= @i_tx_phy_tx_ip    0b0)) ;36 NB
                end
                else begin
                    $display(";A 35");		//(assert (= #i_tx_phy_append_eop_sync3    0b0)) ;35 BR
                end
            end
        end
    end

    // Following code segment is generated from flattened.v:196
    always @(posedge clk or negedge rst) begin
        if ((!rst)) begin
            i_tx_phy_tx_ip_sync <= #1 1'b0; $display(";A 39");		//(assert (= @i_tx_phy_tx_ip_sync    0b0)) ;39 NB
        end
        else begin
            if (i_rx_phy_fs_ce) begin
                $display(";A 40");		//(assert (= #i_rx_phy_fs_ce    0b1)) ;40 BR
                i_tx_phy_tx_ip_sync <= #1 i_tx_phy_tx_ip; $display(";A 42");		//(assert (= @i_tx_phy_tx_ip_sync    #i_tx_phy_tx_ip )) ;42 NB
            end
            else begin
                $display(";A 41");		//(assert (= #i_rx_phy_fs_ce    0b0)) ;41 BR
            end
        end
    end

    // Following code segment is generated from flattened.v:210
    always @(posedge clk or negedge rst) begin
        if ((!rst)) begin
            i_tx_phy_data_done <= #1 1'b0; $display(";A 45");		//(assert (= @i_tx_phy_data_done    0b0)) ;45 NB
        end
        else begin
            if ((TxValid_i && (!i_tx_phy_tx_ip))) begin
                $display(";A 46");		//(assert (= (bv-and #TxValid_i  (bv-not (bv-redor #i_tx_phy_tx_ip )))   0b1)) ;46 BR
                i_tx_phy_data_done <= #1 1'b1; $display(";A 48");		//(assert (= @i_tx_phy_data_done    0b1)) ;48 NB
            end
            else begin
                $display(";A 47");		//(assert (= (bv-and #TxValid_i  (bv-not (bv-redor #i_tx_phy_tx_ip )))   0b0)) ;47 BR
                if ((!TxValid_i)) begin
                    $display(";A 49");		//(assert (= (bv-not (bv-redor #TxValid_i ))   0b1)) ;49 BR
                    i_tx_phy_data_done <= #1 1'b0; $display(";A 51");		//(assert (= @i_tx_phy_data_done    0b0)) ;51 NB
                end
                else begin
                    $display(";A 50");		//(assert (= (bv-not (bv-redor #TxValid_i ))   0b0)) ;50 BR
                end
            end
        end
    end

    // Following code segment is generated from flattened.v:231
    always @(posedge clk or negedge rst) begin
        if ((!rst)) begin
            i_tx_phy_bit_cnt <= #1 3'b000; $display(";A 54");		//(assert (= @i_tx_phy_bit_cnt    0b000)) ;54 NB
        end
        else begin
            if ((!i_tx_phy_tx_ip_sync)) begin
                $display(";A 55");		//(assert (= (bv-not (bv-redor #i_tx_phy_tx_ip_sync ))   0b1)) ;55 BR
                i_tx_phy_bit_cnt <= #1 3'b000; $display(";A 57");		//(assert (= @i_tx_phy_bit_cnt    0b000)) ;57 NB
            end
            else begin
                $display(";A 56");		//(assert (= (bv-not (bv-redor #i_tx_phy_tx_ip_sync ))   0b0)) ;56 BR
                if ((i_rx_phy_fs_ce && (!i_tx_phy_stuff))) begin
                    $display(";A 58");		//(assert (= (bv-and #i_rx_phy_fs_ce  (bv-not (bv-redor #i_tx_phy_stuff )))   0b1)) ;58 BR
                    i_tx_phy_bit_cnt <= #1 (i_tx_phy_bit_cnt + 3'b001); $display(";A 60");		//(assert (= @i_tx_phy_bit_cnt    (bv-add #i_tx_phy_bit_cnt  0b001))) ;60 NB
                end
                else begin
                    $display(";A 59");		//(assert (= (bv-and #i_rx_phy_fs_ce  (bv-not (bv-redor #i_tx_phy_stuff )))   0b0)) ;59 BR
                end
            end
        end
    end

    // Following code segment is generated from flattened.v:252
    always @(posedge clk) begin
        if ((!i_tx_phy_tx_ip_sync)) begin
            $display(";A 61");		//(assert (= (bv-not (bv-redor #i_tx_phy_tx_ip_sync ))   0b1)) ;61 BR
            i_tx_phy_sd_raw_o <= #1 1'b0; $display(";A 63");		//(assert (= @i_tx_phy_sd_raw_o    0b0)) ;63 NB
        end
        else begin
            $display(";A 62");		//(assert (= (bv-not (bv-redor #i_tx_phy_tx_ip_sync ))   0b0)) ;62 BR
            case (i_tx_phy_bit_cnt)
                3'b000 :
                    begin
                        $display(";A 64");		//(assert (= #i_tx_phy_bit_cnt    0b000)) ;64 CS
                        i_tx_phy_sd_raw_o <= #1 i_tx_phy_hold_reg_d[0]; $display(";A 65");		//(assert (= @i_tx_phy_sd_raw_o    (bv-extract 0 0 #i_tx_phy_hold_reg_d ))) ;65 NB
                    end
                3'b001 :
                    begin
                        $display(";A 66");		//(assert (= #i_tx_phy_bit_cnt    0b001)) ;66 CS
                        i_tx_phy_sd_raw_o <= #1 i_tx_phy_hold_reg_d[1]; $display(";A 67");		//(assert (= @i_tx_phy_sd_raw_o    (bv-extract 1 1 #i_tx_phy_hold_reg_d ))) ;67 NB
                    end
                3'b010 :
                    begin
                        $display(";A 68");		//(assert (= #i_tx_phy_bit_cnt    0b010)) ;68 CS
                        i_tx_phy_sd_raw_o <= #1 i_tx_phy_hold_reg_d[2]; $display(";A 69");		//(assert (= @i_tx_phy_sd_raw_o    (bv-extract 2 2 #i_tx_phy_hold_reg_d ))) ;69 NB
                    end
                3'b011 :
                    begin
                        $display(";A 70");		//(assert (= #i_tx_phy_bit_cnt    0b011)) ;70 CS
                        i_tx_phy_sd_raw_o <= #1 i_tx_phy_hold_reg_d[3]; $display(";A 71");		//(assert (= @i_tx_phy_sd_raw_o    (bv-extract 3 3 #i_tx_phy_hold_reg_d ))) ;71 NB
                    end
                3'b100 :
                    begin
                        $display(";A 72");		//(assert (= #i_tx_phy_bit_cnt    0b100)) ;72 CS
                        i_tx_phy_sd_raw_o <= #1 i_tx_phy_hold_reg_d[4]; $display(";A 73");		//(assert (= @i_tx_phy_sd_raw_o    (bv-extract 4 4 #i_tx_phy_hold_reg_d ))) ;73 NB
                    end
                3'b101 :
                    begin
                        $display(";A 74");		//(assert (= #i_tx_phy_bit_cnt    0b101)) ;74 CS
                        i_tx_phy_sd_raw_o <= #1 i_tx_phy_hold_reg_d[5]; $display(";A 75");		//(assert (= @i_tx_phy_sd_raw_o    (bv-extract 5 5 #i_tx_phy_hold_reg_d ))) ;75 NB
                    end
                3'b110 :
                    begin
                        $display(";A 76");		//(assert (= #i_tx_phy_bit_cnt    0b110)) ;76 CS
                        i_tx_phy_sd_raw_o <= #1 i_tx_phy_hold_reg_d[6]; $display(";A 77");		//(assert (= @i_tx_phy_sd_raw_o    (bv-extract 6 6 #i_tx_phy_hold_reg_d ))) ;77 NB
                    end
                3'b111 :
                    begin
                        $display(";A 78");		//(assert (= #i_tx_phy_bit_cnt    0b111)) ;78 CS
                        i_tx_phy_sd_raw_o <= #1 i_tx_phy_hold_reg_d[7]; $display(";A 79");		//(assert (= @i_tx_phy_sd_raw_o    (bv-extract 7 7 #i_tx_phy_hold_reg_d ))) ;79 NB
                    end
            endcase
        end
    end

    // Following code segment is generated from flattened.v:296
    always @(posedge clk) begin
        i_tx_phy_sft_done <= #1 ((!(i_tx_phy_one_cnt == 3'b110)) & (i_tx_phy_bit_cnt == 3'b111)); $display(";A 80");		//(assert (= @i_tx_phy_sft_done    (bv-and (bv-not (bv-redor (bv-comp #i_tx_phy_one_cnt  0b110))) (bv-comp #i_tx_phy_bit_cnt  0b111)))) ;80 NB
    end

    // Following code segment is generated from flattened.v:300
    always @(posedge clk) begin
        i_tx_phy_sft_done_r <= #1 i_tx_phy_sft_done; $display(";A 81");		//(assert (= @i_tx_phy_sft_done_r    #i_tx_phy_sft_done )) ;81 NB
    end

    // Following code segment is generated from flattened.v:304
    always @(posedge clk) begin
        if (i_tx_phy_ld_sop_d) begin
            $display(";A 82");		//(assert (= #i_tx_phy_ld_sop_d    0b1)) ;82 BR
            i_tx_phy_hold_reg <= #1 8'b10000000; $display(";A 84");		//(assert (= @i_tx_phy_hold_reg    0b10000000)) ;84 NB
        end
        else begin
            $display(";A 83");		//(assert (= #i_tx_phy_ld_sop_d    0b0)) ;83 BR
            if (i_tx_phy_ld_data) begin
                $display(";A 85");		//(assert (= #i_tx_phy_ld_data    0b1)) ;85 BR
                i_tx_phy_hold_reg <= #1 DataOut_i; $display(";A 87");		//(assert (= @i_tx_phy_hold_reg    #DataOut_i )) ;87 NB
            end
            else begin
                $display(";A 86");		//(assert (= #i_tx_phy_ld_data    0b0)) ;86 BR
            end
        end
    end

    // Following code segment is generated from flattened.v:318
    always @(posedge clk) begin
        i_tx_phy_hold_reg_d <= #1 i_tx_phy_hold_reg; $display(";A 88");		//(assert (= @i_tx_phy_hold_reg_d    #i_tx_phy_hold_reg )) ;88 NB
    end

    // Following code segment is generated from flattened.v:322
    always @(posedge clk or negedge rst) begin
        if ((!rst)) begin
            i_tx_phy_one_cnt <= #1 3'b000; $display(";A 91");		//(assert (= @i_tx_phy_one_cnt    0b000)) ;91 NB
        end
        else begin
            if ((!i_tx_phy_tx_ip_sync)) begin
                $display(";A 92");		//(assert (= (bv-not (bv-redor #i_tx_phy_tx_ip_sync ))   0b1)) ;92 BR
                i_tx_phy_one_cnt <= #1 3'b000; $display(";A 94");		//(assert (= @i_tx_phy_one_cnt    0b000)) ;94 NB
            end
            else begin
                $display(";A 93");		//(assert (= (bv-not (bv-redor #i_tx_phy_tx_ip_sync ))   0b0)) ;93 BR
                if (i_rx_phy_fs_ce) begin
                    $display(";A 95");		//(assert (= #i_rx_phy_fs_ce    0b1)) ;95 BR
                    if (((!i_tx_phy_sd_raw_o) || (i_tx_phy_one_cnt == 3'b110))) begin
                        $display(";A 97");		//(assert (= (bv-or (bv-not (bv-redor #i_tx_phy_sd_raw_o )) (bv-comp #i_tx_phy_one_cnt  0b110))   0b1)) ;97 BR
                        i_tx_phy_one_cnt <= #1 3'b000; $display(";A 99");		//(assert (= @i_tx_phy_one_cnt    0b000)) ;99 NB
                    end
                    else begin
                        $display(";A 98");		//(assert (= (bv-or (bv-not (bv-redor #i_tx_phy_sd_raw_o )) (bv-comp #i_tx_phy_one_cnt  0b110))   0b0)) ;98 BR
                        i_tx_phy_one_cnt <= #1 (i_tx_phy_one_cnt + 3'b001); $display(";A 100");		//(assert (= @i_tx_phy_one_cnt    (bv-add #i_tx_phy_one_cnt  0b001))) ;100 NB
                    end
                end
                else begin
                    $display(";A 96");		//(assert (= #i_rx_phy_fs_ce    0b0)) ;96 BR
                end
            end
        end
    end

    // Following code segment is generated from flattened.v:351
    always @(posedge clk or negedge rst) begin
        if ((!rst)) begin
            i_tx_phy_sd_bs_o <= #1 1'b0; $display(";A 103");		//(assert (= @i_tx_phy_sd_bs_o    0b0)) ;103 NB
        end
        else begin
            if (i_rx_phy_fs_ce) begin
                $display(";A 104");		//(assert (= #i_rx_phy_fs_ce    0b1)) ;104 BR
                i_tx_phy_sd_bs_o <= #1 ((!i_tx_phy_tx_ip_sync) ? 1'b0 : ((i_tx_phy_one_cnt == 3'b110) ? 1'b0 : i_tx_phy_sd_raw_o)); $display(";A 106");		//(assert (= @i_tx_phy_sd_bs_o    (ite (= (bv-not (bv-redor #i_tx_phy_tx_ip_sync )) 0b1) 0b0 (ite (= (bv-comp #i_tx_phy_one_cnt  0b110) 0b1) 0b0 #i_tx_phy_sd_raw_o )))) ;106 NB
            end
            else begin
                $display(";A 105");		//(assert (= #i_rx_phy_fs_ce    0b0)) ;105 BR
            end
        end
    end

    // Following code segment is generated from flattened.v:365
    always @(posedge clk or negedge rst) begin
        if ((!rst)) begin
            i_tx_phy_sd_nrzi_o <= #1 1'b1; $display(";A 109");		//(assert (= @i_tx_phy_sd_nrzi_o    0b1)) ;109 NB
        end
        else begin
            if (((!i_tx_phy_tx_ip_sync) || (!i_tx_phy_txoe_r1))) begin
                $display(";A 110");		//(assert (= (bv-or (bv-not (bv-redor #i_tx_phy_tx_ip_sync )) (bv-not (bv-redor #i_tx_phy_txoe_r1 )))   0b1)) ;110 BR
                i_tx_phy_sd_nrzi_o <= #1 1'b1; $display(";A 112");		//(assert (= @i_tx_phy_sd_nrzi_o    0b1)) ;112 NB
            end
            else begin
                $display(";A 111");		//(assert (= (bv-or (bv-not (bv-redor #i_tx_phy_tx_ip_sync )) (bv-not (bv-redor #i_tx_phy_txoe_r1 )))   0b0)) ;111 BR
                if (i_rx_phy_fs_ce) begin
                    $display(";A 113");		//(assert (= #i_rx_phy_fs_ce    0b1)) ;113 BR
                    i_tx_phy_sd_nrzi_o <= #1 (i_tx_phy_sd_bs_o ? i_tx_phy_sd_nrzi_o : (~i_tx_phy_sd_nrzi_o)); $display(";A 115");		//(assert (= @i_tx_phy_sd_nrzi_o    (ite (= #i_tx_phy_sd_bs_o  0b1) #i_tx_phy_sd_nrzi_o  (bv-not #i_tx_phy_sd_nrzi_o )))) ;115 NB
                end
                else begin
                    $display(";A 114");		//(assert (= #i_rx_phy_fs_ce    0b0)) ;114 BR
                end
            end
        end
    end

    // Following code segment is generated from flattened.v:386
    always @(posedge clk or negedge rst) begin
        if ((!rst)) begin
            i_tx_phy_append_eop <= #1 1'b0; $display(";A 118");		//(assert (= @i_tx_phy_append_eop    0b0)) ;118 NB
        end
        else begin
            if (i_tx_phy_ld_eop_d) begin
                $display(";A 119");		//(assert (= #i_tx_phy_ld_eop_d    0b1)) ;119 BR
                i_tx_phy_append_eop <= #1 1'b1; $display(";A 121");		//(assert (= @i_tx_phy_append_eop    0b1)) ;121 NB
            end
            else begin
                $display(";A 120");		//(assert (= #i_tx_phy_ld_eop_d    0b0)) ;120 BR
                if (i_tx_phy_append_eop_sync2) begin
                    $display(";A 122");		//(assert (= #i_tx_phy_append_eop_sync2    0b1)) ;122 BR
                    i_tx_phy_append_eop <= #1 1'b0; $display(";A 124");		//(assert (= @i_tx_phy_append_eop    0b0)) ;124 NB
                end
                else begin
                    $display(";A 123");		//(assert (= #i_tx_phy_append_eop_sync2    0b0)) ;123 BR
                end
            end
        end
    end

    // Following code segment is generated from flattened.v:407
    always @(posedge clk or negedge rst) begin
        if ((!rst)) begin
            i_tx_phy_append_eop_sync1 <= #1 1'b0; $display(";A 127");		//(assert (= @i_tx_phy_append_eop_sync1    0b0)) ;127 NB
        end
        else begin
            if (i_rx_phy_fs_ce) begin
                $display(";A 128");		//(assert (= #i_rx_phy_fs_ce    0b1)) ;128 BR
                i_tx_phy_append_eop_sync1 <= #1 i_tx_phy_append_eop; $display(";A 130");		//(assert (= @i_tx_phy_append_eop_sync1    #i_tx_phy_append_eop )) ;130 NB
            end
            else begin
                $display(";A 129");		//(assert (= #i_rx_phy_fs_ce    0b0)) ;129 BR
            end
        end
    end

    // Following code segment is generated from flattened.v:421
    always @(posedge clk or negedge rst) begin
        if ((!rst)) begin
            i_tx_phy_append_eop_sync2 <= #1 1'b0; $display(";A 133");		//(assert (= @i_tx_phy_append_eop_sync2    0b0)) ;133 NB
        end
        else begin
            if (i_rx_phy_fs_ce) begin
                $display(";A 134");		//(assert (= #i_rx_phy_fs_ce    0b1)) ;134 BR
                i_tx_phy_append_eop_sync2 <= #1 i_tx_phy_append_eop_sync1; $display(";A 136");		//(assert (= @i_tx_phy_append_eop_sync2    #i_tx_phy_append_eop_sync1 )) ;136 NB
            end
            else begin
                $display(";A 135");		//(assert (= #i_rx_phy_fs_ce    0b0)) ;135 BR
            end
        end
    end

    // Following code segment is generated from flattened.v:435
    always @(posedge clk or negedge rst) begin
        if ((!rst)) begin
            i_tx_phy_append_eop_sync3 <= #1 1'b0; $display(";A 139");		//(assert (= @i_tx_phy_append_eop_sync3    0b0)) ;139 NB
        end
        else begin
            if (i_rx_phy_fs_ce) begin
                $display(";A 140");		//(assert (= #i_rx_phy_fs_ce    0b1)) ;140 BR
                i_tx_phy_append_eop_sync3 <= #1 (i_tx_phy_append_eop_sync2 | (i_tx_phy_append_eop_sync3 & (!i_tx_phy_append_eop_sync4))); $display(";A 142");		//(assert (= @i_tx_phy_append_eop_sync3    (bv-or #i_tx_phy_append_eop_sync2  (bv-and #i_tx_phy_append_eop_sync3  (bv-not (bv-redor #i_tx_phy_append_eop_sync4 )))))) ;142 NB
            end
            else begin
                $display(";A 141");		//(assert (= #i_rx_phy_fs_ce    0b0)) ;141 BR
            end
        end
    end

    // Following code segment is generated from flattened.v:449
    always @(posedge clk or negedge rst) begin
        if ((!rst)) begin
            i_tx_phy_append_eop_sync4 <= #1 1'b0; $display(";A 145");		//(assert (= @i_tx_phy_append_eop_sync4    0b0)) ;145 NB
        end
        else begin
            if (i_rx_phy_fs_ce) begin
                $display(";A 146");		//(assert (= #i_rx_phy_fs_ce    0b1)) ;146 BR
                i_tx_phy_append_eop_sync4 <= #1 i_tx_phy_append_eop_sync3; $display(";A 148");		//(assert (= @i_tx_phy_append_eop_sync4    #i_tx_phy_append_eop_sync3 )) ;148 NB
            end
            else begin
                $display(";A 147");		//(assert (= #i_rx_phy_fs_ce    0b0)) ;147 BR
            end
        end
    end

    // Following code segment is generated from flattened.v:463
    always @(posedge clk or negedge rst) begin
        if ((!rst)) begin
            i_tx_phy_txoe_r1 <= #1 1'b0; $display(";A 151");		//(assert (= @i_tx_phy_txoe_r1    0b0)) ;151 NB
        end
        else begin
            if (i_rx_phy_fs_ce) begin
                $display(";A 152");		//(assert (= #i_rx_phy_fs_ce    0b1)) ;152 BR
                i_tx_phy_txoe_r1 <= #1 i_tx_phy_tx_ip_sync; $display(";A 154");		//(assert (= @i_tx_phy_txoe_r1    #i_tx_phy_tx_ip_sync )) ;154 NB
            end
            else begin
                $display(";A 153");		//(assert (= #i_rx_phy_fs_ce    0b0)) ;153 BR
            end
        end
    end

    // Following code segment is generated from flattened.v:477
    always @(posedge clk or negedge rst) begin
        if ((!rst)) begin
            i_tx_phy_txoe_r2 <= #1 1'b0; $display(";A 157");		//(assert (= @i_tx_phy_txoe_r2    0b0)) ;157 NB
        end
        else begin
            if (i_rx_phy_fs_ce) begin
                $display(";A 158");		//(assert (= #i_rx_phy_fs_ce    0b1)) ;158 BR
                i_tx_phy_txoe_r2 <= #1 i_tx_phy_txoe_r1; $display(";A 160");		//(assert (= @i_tx_phy_txoe_r2    #i_tx_phy_txoe_r1 )) ;160 NB
            end
            else begin
                $display(";A 159");		//(assert (= #i_rx_phy_fs_ce    0b0)) ;159 BR
            end
        end
    end

    // Following code segment is generated from flattened.v:491
    always @(posedge clk or negedge rst) begin
        if ((!rst)) begin
            i_tx_phy_txoe <= #1 1'b1; $display(";A 163");		//(assert (= @i_tx_phy_txoe    0b1)) ;163 NB
        end
        else begin
            if (i_rx_phy_fs_ce) begin
                $display(";A 164");		//(assert (= #i_rx_phy_fs_ce    0b1)) ;164 BR
                i_tx_phy_txoe <= #1 (!(i_tx_phy_txoe_r1 | i_tx_phy_txoe_r2)); $display(";A 166");		//(assert (= @i_tx_phy_txoe    (bv-not (bv-redor (bv-or #i_tx_phy_txoe_r1  #i_tx_phy_txoe_r2 ))))) ;166 NB
            end
            else begin
                $display(";A 165");		//(assert (= #i_rx_phy_fs_ce    0b0)) ;165 BR
            end
        end
    end

    // Following code segment is generated from flattened.v:505
    always @(posedge clk or negedge rst) begin
        if ((!rst)) begin
            i_tx_phy_txdp <= #1 1'b1; $display(";A 169");		//(assert (= @i_tx_phy_txdp    0b1)) ;169 NB
        end
        else begin
            if (i_rx_phy_fs_ce) begin
                $display(";A 170");		//(assert (= #i_rx_phy_fs_ce    0b1)) ;170 BR
                i_tx_phy_txdp <= #1 (phy_tx_mode ? ((!i_tx_phy_append_eop_sync3) & i_tx_phy_sd_nrzi_o) : i_tx_phy_sd_nrzi_o); $display(";A 172");		//(assert (= @i_tx_phy_txdp    (ite (= #phy_tx_mode  0b1) (bv-and (bv-not (bv-redor #i_tx_phy_append_eop_sync3 )) #i_tx_phy_sd_nrzi_o ) #i_tx_phy_sd_nrzi_o ))) ;172 NB
            end
            else begin
                $display(";A 171");		//(assert (= #i_rx_phy_fs_ce    0b0)) ;171 BR
            end
        end
    end

    // Following code segment is generated from flattened.v:519
    always @(posedge clk or negedge rst) begin
        if ((!rst)) begin
            i_tx_phy_txdn <= #1 1'b0; $display(";A 175");		//(assert (= @i_tx_phy_txdn    0b0)) ;175 NB
        end
        else begin
            if (i_rx_phy_fs_ce) begin
                $display(";A 176");		//(assert (= #i_rx_phy_fs_ce    0b1)) ;176 BR
                i_tx_phy_txdn <= #1 (phy_tx_mode ? ((!i_tx_phy_append_eop_sync3) & (~i_tx_phy_sd_nrzi_o)) : i_tx_phy_append_eop_sync3); $display(";A 178");		//(assert (= @i_tx_phy_txdn    (ite (= #phy_tx_mode  0b1) (bv-and (bv-not (bv-redor #i_tx_phy_append_eop_sync3 )) (bv-not #i_tx_phy_sd_nrzi_o )) #i_tx_phy_append_eop_sync3 ))) ;178 NB
            end
            else begin
                $display(";A 177");		//(assert (= #i_rx_phy_fs_ce    0b0)) ;177 BR
            end
        end
    end

    // Following code segment is generated from flattened.v:533
    always @(posedge clk or negedge rst) begin
        if ((!rst)) begin
            i_tx_phy_state <= #1 3'b000; $display(";A 181");		//(assert (= @i_tx_phy_state    0b000)) ;181 NB
        end
        else begin
            i_tx_phy_state <= #1 i_tx_phy_next_state; $display(";A 182");		//(assert (= @i_tx_phy_state    #i_tx_phy_next_state )) ;182 NB
        end
    end

    // Following code segment is generated from flattened.v:544
    always @(i_rx_phy_fs_ce or i_tx_phy_append_eop_sync3 or (i_tx_phy_sft_done & (~|i_tx_phy_sft_done_r)) or i_tx_phy_data_done or TxValid_i or i_tx_phy_state or __obs) begin
        i_tx_phy_next_state = i_tx_phy_state; $display(";A 183");		//(assert (= @i_tx_phy_next_state    #i_tx_phy_state )) ;183 BL
        i_tx_phy_tx_ready_d = 1'b0; $display(";A 184");		//(assert (= @i_tx_phy_tx_ready_d    0b0)) ;184 BL
        i_tx_phy_ld_sop_d = 1'b0; $display(";A 185");		//(assert (= @i_tx_phy_ld_sop_d    0b0)) ;185 BL
        i_tx_phy_ld_data_d = 1'b0; $display(";A 186");		//(assert (= @i_tx_phy_ld_data_d    0b0)) ;186 BL
        i_tx_phy_ld_eop_d = 1'b0; $display(";A 187");		//(assert (= @i_tx_phy_ld_eop_d    0b0)) ;187 BL
        case (i_tx_phy_state)
            3'b000 :
                begin
                    $display(";A 188");		//(assert (= #i_tx_phy_state    0b000)) ;188 CS
                    if (TxValid_i) begin
                        $display(";A 189");		//(assert (= #TxValid_i    0b1)) ;189 BR
                        i_tx_phy_ld_sop_d = 1'b1; $display(";A 191");		//(assert (= @i_tx_phy_ld_sop_d    0b1)) ;191 BL
                        i_tx_phy_next_state = 3'b001; $display(";A 192");		//(assert (= @i_tx_phy_next_state    0b001)) ;192 BL
                    end
                    else begin
                        $display(";A 190");		//(assert (= #TxValid_i    0b0)) ;190 BR
                    end
                end
            3'b001 :
                begin
                    $display(";A 193");		//(assert (= #i_tx_phy_state    0b001)) ;193 CS
                    if ((i_tx_phy_sft_done & (!i_tx_phy_sft_done_r))) begin
                        $display(";A 194");		//(assert (= (bv-and #i_tx_phy_sft_done  (bv-not (bv-redor #i_tx_phy_sft_done_r )))   0b1)) ;194 BR
                        i_tx_phy_tx_ready_d = 1'b1; $display(";A 196");		//(assert (= @i_tx_phy_tx_ready_d    0b1)) ;196 BL
                        i_tx_phy_ld_data_d = 1'b1; $display(";A 197");		//(assert (= @i_tx_phy_ld_data_d    0b1)) ;197 BL
                        i_tx_phy_next_state = 3'b010; $display(";A 198");		//(assert (= @i_tx_phy_next_state    0b010)) ;198 BL
                    end
                    else begin
                        $display(";A 195");		//(assert (= (bv-and #i_tx_phy_sft_done  (bv-not (bv-redor #i_tx_phy_sft_done_r )))   0b0)) ;195 BR
                    end
                end
            3'b010 :
                begin
                    $display(";A 199");		//(assert (= #i_tx_phy_state    0b010)) ;199 CS
                    if (((!i_tx_phy_data_done) && (i_tx_phy_sft_done & (!i_tx_phy_sft_done_r)))) begin
                        $display(";A 200");		//(assert (= (bv-and (bv-not (bv-redor #i_tx_phy_data_done )) (bv-and #i_tx_phy_sft_done  (bv-not (bv-redor #i_tx_phy_sft_done_r ))))   0b1)) ;200 BR
                        i_tx_phy_ld_eop_d = 1'b1; $display(";A 202");		//(assert (= @i_tx_phy_ld_eop_d    0b1)) ;202 BL
                        i_tx_phy_next_state = 3'b011; $display(";A 203");		//(assert (= @i_tx_phy_next_state    0b011)) ;203 BL
                    end
                    else begin
                        $display(";A 201");		//(assert (= (bv-and (bv-not (bv-redor #i_tx_phy_data_done )) (bv-and #i_tx_phy_sft_done  (bv-not (bv-redor #i_tx_phy_sft_done_r ))))   0b0)) ;201 BR
                    end
                    if ((i_tx_phy_data_done && (i_tx_phy_sft_done & (!i_tx_phy_sft_done_r)))) begin
                        $display(";A 204");		//(assert (= (bv-and #i_tx_phy_data_done  (bv-and #i_tx_phy_sft_done  (bv-not (bv-redor #i_tx_phy_sft_done_r ))))   0b1)) ;204 BR
                        i_tx_phy_tx_ready_d = 1'b1; $display(";A 206");		//(assert (= @i_tx_phy_tx_ready_d    0b1)) ;206 BL
                        i_tx_phy_ld_data_d = 1'b1; $display(";A 207");		//(assert (= @i_tx_phy_ld_data_d    0b1)) ;207 BL
                    end
                    else begin
                        $display(";A 205");		//(assert (= (bv-and #i_tx_phy_data_done  (bv-and #i_tx_phy_sft_done  (bv-not (bv-redor #i_tx_phy_sft_done_r ))))   0b0)) ;205 BR
                    end
                end
            3'b011 :
                begin
                    $display(";A 208");		//(assert (= #i_tx_phy_state    0b011)) ;208 CS
                    if (i_tx_phy_append_eop_sync3) begin
                        $display(";A 209");		//(assert (= #i_tx_phy_append_eop_sync3    0b1)) ;209 BR
                        i_tx_phy_next_state = 3'b100; $display(";A 211");		//(assert (= @i_tx_phy_next_state    0b100)) ;211 BL
                    end
                    else begin
                        $display(";A 210");		//(assert (= #i_tx_phy_append_eop_sync3    0b0)) ;210 BR
                    end
                end
            3'b100 :
                begin
                    $display(";A 212");		//(assert (= #i_tx_phy_state    0b100)) ;212 CS
                    if (((!i_tx_phy_append_eop_sync3) && i_rx_phy_fs_ce)) begin
                        $display(";A 213");		//(assert (= (bv-and (bv-not (bv-redor #i_tx_phy_append_eop_sync3 )) #i_rx_phy_fs_ce )   0b1)) ;213 BR
                        i_tx_phy_next_state = 3'b101; $display(";A 215");		//(assert (= @i_tx_phy_next_state    0b101)) ;215 BL
                    end
                    else begin
                        $display(";A 214");		//(assert (= (bv-and (bv-not (bv-redor #i_tx_phy_append_eop_sync3 )) #i_rx_phy_fs_ce )   0b0)) ;214 BR
                    end
                end
            3'b101 :
                begin
                    $display(";A 216");		//(assert (= #i_tx_phy_state    0b101)) ;216 CS
                    if (i_rx_phy_fs_ce) begin
                        $display(";A 217");		//(assert (= #i_rx_phy_fs_ce    0b1)) ;217 BR
                        i_tx_phy_next_state = 3'b000; $display(";A 219");		//(assert (= @i_tx_phy_next_state    0b000)) ;219 BL
                    end
                    else begin
                        $display(";A 218");		//(assert (= #i_rx_phy_fs_ce    0b0)) ;218 BR
                    end
                end
        endcase
    end

    // Following code segment is generated from flattened.v:610
    always @(posedge clk) begin
        i_rx_phy_rx_en <= #1 txoe; $display(";A 220");		//(assert (= @i_rx_phy_rx_en    #txoe )) ;220 NB
    end

    // Following code segment is generated from flattened.v:614
    always @(posedge clk) begin
        i_rx_phy_sync_err <= #1 ((!i_rx_phy_rx_active) & i_rx_phy_sync_err_d); $display(";A 221");		//(assert (= @i_rx_phy_sync_err    (bv-and (bv-not (bv-redor #i_rx_phy_rx_active )) #i_rx_phy_sync_err_d ))) ;221 NB
    end

    // Following code segment is generated from flattened.v:618
    always @(posedge clk) begin
        i_rx_phy_rxd_s0 <= #1 rxd; $display(";A 222");		//(assert (= @i_rx_phy_rxd_s0    #rxd )) ;222 NB
    end

    // Following code segment is generated from flattened.v:622
    always @(posedge clk) begin
        i_rx_phy_rxd_s1 <= #1 i_rx_phy_rxd_s0; $display(";A 223");		//(assert (= @i_rx_phy_rxd_s1    #i_rx_phy_rxd_s0 )) ;223 NB
    end

    // Following code segment is generated from flattened.v:626
    always @(posedge clk) begin
        if ((i_rx_phy_rxd_s0 && i_rx_phy_rxd_s1)) begin
            $display(";A 224");		//(assert (= (bv-and #i_rx_phy_rxd_s0  #i_rx_phy_rxd_s1 )   0b1)) ;224 BR
            i_rx_phy_rxd_s <= #1 1'b1; $display(";A 226");		//(assert (= @i_rx_phy_rxd_s    0b1)) ;226 NB
        end
        else begin
            $display(";A 225");		//(assert (= (bv-and #i_rx_phy_rxd_s0  #i_rx_phy_rxd_s1 )   0b0)) ;225 BR
            if (((!i_rx_phy_rxd_s0) && (!i_rx_phy_rxd_s1))) begin
                $display(";A 227");		//(assert (= (bv-and (bv-not (bv-redor #i_rx_phy_rxd_s0 )) (bv-not (bv-redor #i_rx_phy_rxd_s1 )))   0b1)) ;227 BR
                i_rx_phy_rxd_s <= #1 1'b0; $display(";A 229");		//(assert (= @i_rx_phy_rxd_s    0b0)) ;229 NB
            end
            else begin
                $display(";A 228");		//(assert (= (bv-and (bv-not (bv-redor #i_rx_phy_rxd_s0 )) (bv-not (bv-redor #i_rx_phy_rxd_s1 )))   0b0)) ;228 BR
            end
        end
    end

    // Following code segment is generated from flattened.v:640
    always @(posedge clk) begin
        i_rx_phy_rxdp_s0 <= #1 rxdp; $display(";A 230");		//(assert (= @i_rx_phy_rxdp_s0    #rxdp )) ;230 NB
    end

    // Following code segment is generated from flattened.v:644
    always @(posedge clk) begin
        i_rx_phy_rxdp_s1 <= #1 i_rx_phy_rxdp_s0; $display(";A 231");		//(assert (= @i_rx_phy_rxdp_s1    #i_rx_phy_rxdp_s0 )) ;231 NB
    end

    // Following code segment is generated from flattened.v:648
    always @(posedge clk) begin
        i_rx_phy_rxdp_s_r <= #1 (i_rx_phy_rxdp_s0 & i_rx_phy_rxdp_s1); $display(";A 232");		//(assert (= @i_rx_phy_rxdp_s_r    (bv-and #i_rx_phy_rxdp_s0  #i_rx_phy_rxdp_s1 ))) ;232 NB
    end

    // Following code segment is generated from flattened.v:652
    always @(posedge clk) begin
        i_rx_phy_rxdp_s <= #1 ((i_rx_phy_rxdp_s0 & i_rx_phy_rxdp_s1) | i_rx_phy_rxdp_s_r); $display(";A 233");		//(assert (= @i_rx_phy_rxdp_s    (bv-or (bv-and #i_rx_phy_rxdp_s0  #i_rx_phy_rxdp_s1 ) #i_rx_phy_rxdp_s_r ))) ;233 NB
    end

    // Following code segment is generated from flattened.v:656
    always @(posedge clk) begin
        i_rx_phy_rxdn_s0 <= #1 rxdn; $display(";A 234");		//(assert (= @i_rx_phy_rxdn_s0    #rxdn )) ;234 NB
    end

    // Following code segment is generated from flattened.v:660
    always @(posedge clk) begin
        i_rx_phy_rxdn_s1 <= #1 i_rx_phy_rxdn_s0; $display(";A 235");		//(assert (= @i_rx_phy_rxdn_s1    #i_rx_phy_rxdn_s0 )) ;235 NB
    end

    // Following code segment is generated from flattened.v:664
    always @(posedge clk) begin
        i_rx_phy_rxdn_s_r <= #1 (i_rx_phy_rxdn_s0 & i_rx_phy_rxdn_s1); $display(";A 236");		//(assert (= @i_rx_phy_rxdn_s_r    (bv-and #i_rx_phy_rxdn_s0  #i_rx_phy_rxdn_s1 ))) ;236 NB
    end

    // Following code segment is generated from flattened.v:668
    always @(posedge clk) begin
        i_rx_phy_rxdn_s <= #1 ((i_rx_phy_rxdn_s0 & i_rx_phy_rxdn_s1) | i_rx_phy_rxdn_s_r); $display(";A 237");		//(assert (= @i_rx_phy_rxdn_s    (bv-or (bv-and #i_rx_phy_rxdn_s0  #i_rx_phy_rxdn_s1 ) #i_rx_phy_rxdn_s_r ))) ;237 NB
    end

    // Following code segment is generated from flattened.v:672
    always @(posedge clk) begin
        if (i_rx_phy_fs_ce) begin
            $display(";A 238");		//(assert (= #i_rx_phy_fs_ce    0b1)) ;238 BR
            i_rx_phy_se0_s <= #1 ((!i_rx_phy_rxdp_s) & (!i_rx_phy_rxdn_s)); $display(";A 240");		//(assert (= @i_rx_phy_se0_s    (bv-and (bv-not (bv-redor #i_rx_phy_rxdp_s )) (bv-not (bv-redor #i_rx_phy_rxdn_s ))))) ;240 NB
        end
        else begin
            $display(";A 239");		//(assert (= #i_rx_phy_fs_ce    0b0)) ;239 BR
        end
    end

    // Following code segment is generated from flattened.v:679
    always @(posedge clk) begin
        i_rx_phy_rxd_r <= #1 i_rx_phy_rxd_s; $display(";A 241");		//(assert (= @i_rx_phy_rxd_r    #i_rx_phy_rxd_s )) ;241 NB
    end

    // Following code segment is generated from flattened.v:683
    always @(posedge clk or negedge rst) begin
        if ((!rst)) begin
            i_rx_phy_dpll_state <= #1 2'b01; $display(";A 244");		//(assert (= @i_rx_phy_dpll_state    0b01)) ;244 NB
        end
        else begin
            i_rx_phy_dpll_state <= #1 i_rx_phy_dpll_next_state; $display(";A 245");		//(assert (= @i_rx_phy_dpll_state    #i_rx_phy_dpll_next_state )) ;245 NB
        end
    end

    // Following code segment is generated from flattened.v:694
    always @((i_rx_phy_rxd_r ^ i_rx_phy_rxd_s) or i_rx_phy_rx_en or i_rx_phy_dpll_state or __obs) begin
        i_rx_phy_fs_ce_d = 1'b0; $display(";A 246");		//(assert (= @i_rx_phy_fs_ce_d    0b0)) ;246 BL
        case (i_rx_phy_dpll_state)
            2'b00 :
                begin
                    $display(";A 247");		//(assert (= #i_rx_phy_dpll_state    0b00)) ;247 CS
                    if ((i_rx_phy_rx_en && (i_rx_phy_rxd_r != i_rx_phy_rxd_s))) begin
                        $display(";A 248");		//(assert (= (bv-and #i_rx_phy_rx_en  (bv-not (bv-comp #i_rx_phy_rxd_r  #i_rx_phy_rxd_s )))   0b1)) ;248 BR
                        i_rx_phy_dpll_next_state = 2'b00; $display(";A 250");		//(assert (= @i_rx_phy_dpll_next_state    0b00)) ;250 BL
                    end
                    else begin
                        $display(";A 249");		//(assert (= (bv-and #i_rx_phy_rx_en  (bv-not (bv-comp #i_rx_phy_rxd_r  #i_rx_phy_rxd_s )))   0b0)) ;249 BR
                        i_rx_phy_dpll_next_state = 2'b01; $display(";A 251");		//(assert (= @i_rx_phy_dpll_next_state    0b01)) ;251 BL
                    end
                end
            2'b01 :
                begin
                    $display(";A 252");		//(assert (= #i_rx_phy_dpll_state    0b01)) ;252 CS
                    i_rx_phy_fs_ce_d = 1'b1; $display(";A 253");		//(assert (= @i_rx_phy_fs_ce_d    0b1)) ;253 BL
                    if ((i_rx_phy_rx_en && (i_rx_phy_rxd_r != i_rx_phy_rxd_s))) begin
                        $display(";A 254");		//(assert (= (bv-and #i_rx_phy_rx_en  (bv-not (bv-comp #i_rx_phy_rxd_r  #i_rx_phy_rxd_s )))   0b1)) ;254 BR
                        i_rx_phy_dpll_next_state = 2'b11; $display(";A 256");		//(assert (= @i_rx_phy_dpll_next_state    0b11)) ;256 BL
                    end
                    else begin
                        $display(";A 255");		//(assert (= (bv-and #i_rx_phy_rx_en  (bv-not (bv-comp #i_rx_phy_rxd_r  #i_rx_phy_rxd_s )))   0b0)) ;255 BR
                        i_rx_phy_dpll_next_state = 2'b10; $display(";A 257");		//(assert (= @i_rx_phy_dpll_next_state    0b10)) ;257 BL
                    end
                end
            2'b10 :
                begin
                    $display(";A 258");		//(assert (= #i_rx_phy_dpll_state    0b10)) ;258 CS
                    if ((i_rx_phy_rx_en && (i_rx_phy_rxd_r != i_rx_phy_rxd_s))) begin
                        $display(";A 259");		//(assert (= (bv-and #i_rx_phy_rx_en  (bv-not (bv-comp #i_rx_phy_rxd_r  #i_rx_phy_rxd_s )))   0b1)) ;259 BR
                        i_rx_phy_dpll_next_state = 2'b00; $display(";A 261");		//(assert (= @i_rx_phy_dpll_next_state    0b00)) ;261 BL
                    end
                    else begin
                        $display(";A 260");		//(assert (= (bv-and #i_rx_phy_rx_en  (bv-not (bv-comp #i_rx_phy_rxd_r  #i_rx_phy_rxd_s )))   0b0)) ;260 BR
                        i_rx_phy_dpll_next_state = 2'b11; $display(";A 262");		//(assert (= @i_rx_phy_dpll_next_state    0b11)) ;262 BL
                    end
                end
            2'b11 :
                begin
                    $display(";A 263");		//(assert (= #i_rx_phy_dpll_state    0b11)) ;263 CS
                    if ((i_rx_phy_rx_en && (i_rx_phy_rxd_r != i_rx_phy_rxd_s))) begin
                        $display(";A 264");		//(assert (= (bv-and #i_rx_phy_rx_en  (bv-not (bv-comp #i_rx_phy_rxd_r  #i_rx_phy_rxd_s )))   0b1)) ;264 BR
                        i_rx_phy_dpll_next_state = 2'b00; $display(";A 266");		//(assert (= @i_rx_phy_dpll_next_state    0b00)) ;266 BL
                    end
                    else begin
                        $display(";A 265");		//(assert (= (bv-and #i_rx_phy_rx_en  (bv-not (bv-comp #i_rx_phy_rxd_r  #i_rx_phy_rxd_s )))   0b0)) ;265 BR
                        i_rx_phy_dpll_next_state = 2'b00; $display(";A 267");		//(assert (= @i_rx_phy_dpll_next_state    0b00)) ;267 BL
                    end
                end
        endcase
    end

    // Following code segment is generated from flattened.v:745
    always @(posedge clk) begin
        i_rx_phy_fs_ce_r1 <= #1 i_rx_phy_fs_ce_d; $display(";A 268");		//(assert (= @i_rx_phy_fs_ce_r1    #i_rx_phy_fs_ce_d )) ;268 NB
    end

    // Following code segment is generated from flattened.v:749
    always @(posedge clk) begin
        i_rx_phy_fs_ce_r2 <= #1 i_rx_phy_fs_ce_r1; $display(";A 269");		//(assert (= @i_rx_phy_fs_ce_r2    #i_rx_phy_fs_ce_r1 )) ;269 NB
    end

    // Following code segment is generated from flattened.v:753
    always @(posedge clk) begin
        i_rx_phy_fs_ce <= #1 i_rx_phy_fs_ce_r2; $display(";A 270");		//(assert (= @i_rx_phy_fs_ce    #i_rx_phy_fs_ce_r2 )) ;270 NB
    end

    // Following code segment is generated from flattened.v:757
    always @(posedge clk or negedge rst) begin
        if ((!rst)) begin
            i_rx_phy_fs_state <= #1 3'b000; $display(";A 273");		//(assert (= @i_rx_phy_fs_state    0b000)) ;273 NB
        end
        else begin
            i_rx_phy_fs_state <= #1 i_rx_phy_fs_next_state; $display(";A 274");		//(assert (= @i_rx_phy_fs_state    #i_rx_phy_fs_next_state )) ;274 NB
        end
    end

    // Following code segment is generated from flattened.v:768
    always @(i_rx_phy_se0_s or ((~|i_rx_phy_rxdp_s) & (~|i_rx_phy_rxdn_s)) or i_rx_phy_rx_active or i_rx_phy_rx_en or (i_rx_phy_rxdp_s & (~|i_rx_phy_rxdn_s)) or ((~|i_rx_phy_rxdp_s) & i_rx_phy_rxdn_s) or i_rx_phy_fs_ce or i_rx_phy_fs_state or __obs) begin
        i_rx_phy_synced_d = 1'b0; $display(";A 275");		//(assert (= @i_rx_phy_synced_d    0b0)) ;275 BL
        i_rx_phy_sync_err_d = 1'b0; $display(";A 276");		//(assert (= @i_rx_phy_sync_err_d    0b0)) ;276 BL
        i_rx_phy_fs_next_state = i_rx_phy_fs_state; $display(";A 277");		//(assert (= @i_rx_phy_fs_next_state    #i_rx_phy_fs_state )) ;277 BL
        if ((((i_rx_phy_fs_ce && (!i_rx_phy_rx_active)) && (!((!i_rx_phy_rxdp_s) & (!i_rx_phy_rxdn_s)))) && (!i_rx_phy_se0_s))) begin
            $display(";A 278");		//(assert (= (bv-and (bv-and (bv-and #i_rx_phy_fs_ce  (bv-not (bv-redor #i_rx_phy_rx_active ))) (bv-not (bv-redor (bv-and (bv-not (bv-redor #i_rx_phy_rxdp_s )) (bv-not (bv-redor #i_rx_phy_rxdn_s )))))) (bv-not (bv-redor #i_rx_phy_se0_s )))   0b1)) ;278 BR
            case (i_rx_phy_fs_state)
                3'b000 :
                    begin
                        $display(";A 280");		//(assert (= #i_rx_phy_fs_state    0b000)) ;280 CS
                        if ((((!i_rx_phy_rxdp_s) & i_rx_phy_rxdn_s) && i_rx_phy_rx_en)) begin
                            $display(";A 281");		//(assert (= (bv-and (bv-and (bv-not (bv-redor #i_rx_phy_rxdp_s )) #i_rx_phy_rxdn_s ) #i_rx_phy_rx_en )   0b1)) ;281 BR
                            i_rx_phy_fs_next_state = 3'b001; $display(";A 283");		//(assert (= @i_rx_phy_fs_next_state    0b001)) ;283 BL
                        end
                        else begin
                            $display(";A 282");		//(assert (= (bv-and (bv-and (bv-not (bv-redor #i_rx_phy_rxdp_s )) #i_rx_phy_rxdn_s ) #i_rx_phy_rx_en )   0b0)) ;282 BR
                        end
                    end
                3'b001 :
                    begin
                        $display(";A 284");		//(assert (= #i_rx_phy_fs_state    0b001)) ;284 CS
                        if (((i_rx_phy_rxdp_s & (!i_rx_phy_rxdn_s)) && i_rx_phy_rx_en)) begin
                            $display(";A 285");		//(assert (= (bv-and (bv-and #i_rx_phy_rxdp_s  (bv-not (bv-redor #i_rx_phy_rxdn_s ))) #i_rx_phy_rx_en )   0b1)) ;285 BR
                            i_rx_phy_fs_next_state = 3'b010; $display(";A 287");		//(assert (= @i_rx_phy_fs_next_state    0b010)) ;287 BL
                        end
                        else begin
                            $display(";A 286");		//(assert (= (bv-and (bv-and #i_rx_phy_rxdp_s  (bv-not (bv-redor #i_rx_phy_rxdn_s ))) #i_rx_phy_rx_en )   0b0)) ;286 BR
                            i_rx_phy_sync_err_d = 1'b1; $display(";A 288");		//(assert (= @i_rx_phy_sync_err_d    0b1)) ;288 BL
                            i_rx_phy_fs_next_state = 3'b000; $display(";A 289");		//(assert (= @i_rx_phy_fs_next_state    0b000)) ;289 BL
                        end
                    end
                3'b010 :
                    begin
                        $display(";A 290");		//(assert (= #i_rx_phy_fs_state    0b010)) ;290 CS
                        if ((((!i_rx_phy_rxdp_s) & i_rx_phy_rxdn_s) && i_rx_phy_rx_en)) begin
                            $display(";A 291");		//(assert (= (bv-and (bv-and (bv-not (bv-redor #i_rx_phy_rxdp_s )) #i_rx_phy_rxdn_s ) #i_rx_phy_rx_en )   0b1)) ;291 BR
                            i_rx_phy_fs_next_state = 3'b011; $display(";A 293");		//(assert (= @i_rx_phy_fs_next_state    0b011)) ;293 BL
                        end
                        else begin
                            $display(";A 292");		//(assert (= (bv-and (bv-and (bv-not (bv-redor #i_rx_phy_rxdp_s )) #i_rx_phy_rxdn_s ) #i_rx_phy_rx_en )   0b0)) ;292 BR
                            i_rx_phy_sync_err_d = 1'b1; $display(";A 294");		//(assert (= @i_rx_phy_sync_err_d    0b1)) ;294 BL
                            i_rx_phy_fs_next_state = 3'b000; $display(";A 295");		//(assert (= @i_rx_phy_fs_next_state    0b000)) ;295 BL
                        end
                    end
                3'b011 :
                    begin
                        $display(";A 296");		//(assert (= #i_rx_phy_fs_state    0b011)) ;296 CS
                        if (((i_rx_phy_rxdp_s & (!i_rx_phy_rxdn_s)) && i_rx_phy_rx_en)) begin
                            $display(";A 297");		//(assert (= (bv-and (bv-and #i_rx_phy_rxdp_s  (bv-not (bv-redor #i_rx_phy_rxdn_s ))) #i_rx_phy_rx_en )   0b1)) ;297 BR
                            i_rx_phy_fs_next_state = 3'b100; $display(";A 299");		//(assert (= @i_rx_phy_fs_next_state    0b100)) ;299 BL
                        end
                        else begin
                            $display(";A 298");		//(assert (= (bv-and (bv-and #i_rx_phy_rxdp_s  (bv-not (bv-redor #i_rx_phy_rxdn_s ))) #i_rx_phy_rx_en )   0b0)) ;298 BR
                            i_rx_phy_sync_err_d = 1'b1; $display(";A 300");		//(assert (= @i_rx_phy_sync_err_d    0b1)) ;300 BL
                            i_rx_phy_fs_next_state = 3'b000; $display(";A 301");		//(assert (= @i_rx_phy_fs_next_state    0b000)) ;301 BL
                        end
                    end
                3'b100 :
                    begin
                        $display(";A 302");		//(assert (= #i_rx_phy_fs_state    0b100)) ;302 CS
                        if ((((!i_rx_phy_rxdp_s) & i_rx_phy_rxdn_s) && i_rx_phy_rx_en)) begin
                            $display(";A 303");		//(assert (= (bv-and (bv-and (bv-not (bv-redor #i_rx_phy_rxdp_s )) #i_rx_phy_rxdn_s ) #i_rx_phy_rx_en )   0b1)) ;303 BR
                            i_rx_phy_fs_next_state = 3'b101; $display(";A 305");		//(assert (= @i_rx_phy_fs_next_state    0b101)) ;305 BL
                        end
                        else begin
                            $display(";A 304");		//(assert (= (bv-and (bv-and (bv-not (bv-redor #i_rx_phy_rxdp_s )) #i_rx_phy_rxdn_s ) #i_rx_phy_rx_en )   0b0)) ;304 BR
                            i_rx_phy_sync_err_d = 1'b1; $display(";A 306");		//(assert (= @i_rx_phy_sync_err_d    0b1)) ;306 BL
                            i_rx_phy_fs_next_state = 3'b000; $display(";A 307");		//(assert (= @i_rx_phy_fs_next_state    0b000)) ;307 BL
                        end
                    end
                3'b101 :
                    begin
                        $display(";A 308");		//(assert (= #i_rx_phy_fs_state    0b101)) ;308 CS
                        if (((i_rx_phy_rxdp_s & (!i_rx_phy_rxdn_s)) && i_rx_phy_rx_en)) begin
                            $display(";A 309");		//(assert (= (bv-and (bv-and #i_rx_phy_rxdp_s  (bv-not (bv-redor #i_rx_phy_rxdn_s ))) #i_rx_phy_rx_en )   0b1)) ;309 BR
                            i_rx_phy_fs_next_state = 3'b110; $display(";A 311");		//(assert (= @i_rx_phy_fs_next_state    0b110)) ;311 BL
                        end
                        else begin
                            $display(";A 310");		//(assert (= (bv-and (bv-and #i_rx_phy_rxdp_s  (bv-not (bv-redor #i_rx_phy_rxdn_s ))) #i_rx_phy_rx_en )   0b0)) ;310 BR
                            if ((((!i_rx_phy_rxdp_s) & i_rx_phy_rxdn_s) && i_rx_phy_rx_en)) begin
                                $display(";A 312");		//(assert (= (bv-and (bv-and (bv-not (bv-redor #i_rx_phy_rxdp_s )) #i_rx_phy_rxdn_s ) #i_rx_phy_rx_en )   0b1)) ;312 BR
                                i_rx_phy_fs_next_state = 3'b000; $display(";A 314");		//(assert (= @i_rx_phy_fs_next_state    0b000)) ;314 BL
                                i_rx_phy_synced_d = 1'b1; $display(";A 315");		//(assert (= @i_rx_phy_synced_d    0b1)) ;315 BL
                            end
                            else begin
                                $display(";A 313");		//(assert (= (bv-and (bv-and (bv-not (bv-redor #i_rx_phy_rxdp_s )) #i_rx_phy_rxdn_s ) #i_rx_phy_rx_en )   0b0)) ;313 BR
                                i_rx_phy_sync_err_d = 1'b1; $display(";A 316");		//(assert (= @i_rx_phy_sync_err_d    0b1)) ;316 BL
                                i_rx_phy_fs_next_state = 3'b000; $display(";A 317");		//(assert (= @i_rx_phy_fs_next_state    0b000)) ;317 BL
                            end
                        end
                    end
                3'b110 :
                    begin
                        $display(";A 318");		//(assert (= #i_rx_phy_fs_state    0b110)) ;318 CS
                        if ((((!i_rx_phy_rxdp_s) & i_rx_phy_rxdn_s) && i_rx_phy_rx_en)) begin
                            $display(";A 319");		//(assert (= (bv-and (bv-and (bv-not (bv-redor #i_rx_phy_rxdp_s )) #i_rx_phy_rxdn_s ) #i_rx_phy_rx_en )   0b1)) ;319 BR
                            i_rx_phy_fs_next_state = 3'b111; $display(";A 321");		//(assert (= @i_rx_phy_fs_next_state    0b111)) ;321 BL
                        end
                        else begin
                            $display(";A 320");		//(assert (= (bv-and (bv-and (bv-not (bv-redor #i_rx_phy_rxdp_s )) #i_rx_phy_rxdn_s ) #i_rx_phy_rx_en )   0b0)) ;320 BR
                            i_rx_phy_sync_err_d = 1'b1; $display(";A 322");		//(assert (= @i_rx_phy_sync_err_d    0b1)) ;322 BL
                            i_rx_phy_fs_next_state = 3'b000; $display(";A 323");		//(assert (= @i_rx_phy_fs_next_state    0b000)) ;323 BL
                        end
                    end
                3'b111 :
                    begin
                        $display(";A 324");		//(assert (= #i_rx_phy_fs_state    0b111)) ;324 CS
                        if (((!i_rx_phy_rxdp_s) & i_rx_phy_rxdn_s)) begin
                            $display(";A 325");		//(assert (= (bv-and (bv-not (bv-redor #i_rx_phy_rxdp_s )) #i_rx_phy_rxdn_s )   0b1)) ;325 BR
                            i_rx_phy_synced_d = 1'b1; $display(";A 327");		//(assert (= @i_rx_phy_synced_d    0b1)) ;327 BL
                        end
                        else begin
                            $display(";A 326");		//(assert (= (bv-and (bv-not (bv-redor #i_rx_phy_rxdp_s )) #i_rx_phy_rxdn_s )   0b0)) ;326 BR
                        end
                        i_rx_phy_fs_next_state = 3'b000; $display(";A 328");		//(assert (= @i_rx_phy_fs_next_state    0b000)) ;328 BL
                    end
            endcase
        end
        else begin
            $display(";A 279");		//(assert (= (bv-and (bv-and (bv-and #i_rx_phy_fs_ce  (bv-not (bv-redor #i_rx_phy_rx_active ))) (bv-not (bv-redor (bv-and (bv-not (bv-redor #i_rx_phy_rxdp_s )) (bv-not (bv-redor #i_rx_phy_rxdn_s )))))) (bv-not (bv-redor #i_rx_phy_se0_s )))   0b0)) ;279 BR
        end
    end

    // Following code segment is generated from flattened.v:874
    always @(posedge clk or negedge rst) begin
        if ((!rst)) begin
            i_rx_phy_rx_active <= #1 1'b0; $display(";A 331");		//(assert (= @i_rx_phy_rx_active    0b0)) ;331 NB
        end
        else begin
            if ((i_rx_phy_synced_d && i_rx_phy_rx_en)) begin
                $display(";A 332");		//(assert (= (bv-and #i_rx_phy_synced_d  #i_rx_phy_rx_en )   0b1)) ;332 BR
                i_rx_phy_rx_active <= #1 1'b1; $display(";A 334");		//(assert (= @i_rx_phy_rx_active    0b1)) ;334 NB
            end
            else begin
                $display(";A 333");		//(assert (= (bv-and #i_rx_phy_synced_d  #i_rx_phy_rx_en )   0b0)) ;333 BR
                if ((((!i_rx_phy_rxdp_s) & (!i_rx_phy_rxdn_s)) && i_rx_phy_rx_valid_r)) begin
                    $display(";A 335");		//(assert (= (bv-and (bv-and (bv-not (bv-redor #i_rx_phy_rxdp_s )) (bv-not (bv-redor #i_rx_phy_rxdn_s ))) #i_rx_phy_rx_valid_r )   0b1)) ;335 BR
                    i_rx_phy_rx_active <= #1 1'b0; $display(";A 337");		//(assert (= @i_rx_phy_rx_active    0b0)) ;337 NB
                end
                else begin
                    $display(";A 336");		//(assert (= (bv-and (bv-and (bv-not (bv-redor #i_rx_phy_rxdp_s )) (bv-not (bv-redor #i_rx_phy_rxdn_s ))) #i_rx_phy_rx_valid_r )   0b0)) ;336 BR
                end
            end
        end
    end

    // Following code segment is generated from flattened.v:895
    always @(posedge clk) begin
        if (i_rx_phy_rx_valid) begin
            $display(";A 338");		//(assert (= #i_rx_phy_rx_valid    0b1)) ;338 BR
            i_rx_phy_rx_valid_r <= #1 1'b1; $display(";A 340");		//(assert (= @i_rx_phy_rx_valid_r    0b1)) ;340 NB
        end
        else begin
            $display(";A 339");		//(assert (= #i_rx_phy_rx_valid    0b0)) ;339 BR
            if (i_rx_phy_fs_ce) begin
                $display(";A 341");		//(assert (= #i_rx_phy_fs_ce    0b1)) ;341 BR
                i_rx_phy_rx_valid_r <= #1 1'b0; $display(";A 343");		//(assert (= @i_rx_phy_rx_valid_r    0b0)) ;343 NB
            end
            else begin
                $display(";A 342");		//(assert (= #i_rx_phy_fs_ce    0b0)) ;342 BR
            end
        end
    end

    // Following code segment is generated from flattened.v:909
    always @(posedge clk) begin
        if (i_rx_phy_fs_ce) begin
            $display(";A 344");		//(assert (= #i_rx_phy_fs_ce    0b1)) ;344 BR
            i_rx_phy_sd_r <= #1 i_rx_phy_rxd_s; $display(";A 346");		//(assert (= @i_rx_phy_sd_r    #i_rx_phy_rxd_s )) ;346 NB
        end
        else begin
            $display(";A 345");		//(assert (= #i_rx_phy_fs_ce    0b0)) ;345 BR
        end
    end

    // Following code segment is generated from flattened.v:916
    always @(posedge clk or negedge rst) begin
        if ((!rst)) begin
            i_rx_phy_sd_nrzi <= #1 1'b0; $display(";A 349");		//(assert (= @i_rx_phy_sd_nrzi    0b0)) ;349 NB
        end
        else begin
            if ((!i_rx_phy_rx_active)) begin
                $display(";A 350");		//(assert (= (bv-not (bv-redor #i_rx_phy_rx_active ))   0b1)) ;350 BR
                i_rx_phy_sd_nrzi <= #1 1'b1; $display(";A 352");		//(assert (= @i_rx_phy_sd_nrzi    0b1)) ;352 NB
            end
            else begin
                $display(";A 351");		//(assert (= (bv-not (bv-redor #i_rx_phy_rx_active ))   0b0)) ;351 BR
                if ((i_rx_phy_rx_active && i_rx_phy_fs_ce)) begin
                    $display(";A 353");		//(assert (= (bv-and #i_rx_phy_rx_active  #i_rx_phy_fs_ce )   0b1)) ;353 BR
                    i_rx_phy_sd_nrzi <= #1 (!(i_rx_phy_rxd_s ^ i_rx_phy_sd_r)); $display(";A 355");		//(assert (= @i_rx_phy_sd_nrzi    (bv-not (bv-redor (bv-xor #i_rx_phy_rxd_s  #i_rx_phy_sd_r ))))) ;355 NB
                end
                else begin
                    $display(";A 354");		//(assert (= (bv-and #i_rx_phy_rx_active  #i_rx_phy_fs_ce )   0b0)) ;354 BR
                end
            end
        end
    end

    // Following code segment is generated from flattened.v:937
    always @(posedge clk or negedge rst) begin
        if ((!rst)) begin
            i_rx_phy_one_cnt <= #1 3'b000; $display(";A 358");		//(assert (= @i_rx_phy_one_cnt    0b000)) ;358 NB
        end
        else begin
            if ((!i_rx_phy_shift_en)) begin
                $display(";A 359");		//(assert (= (bv-not (bv-redor #i_rx_phy_shift_en ))   0b1)) ;359 BR
                i_rx_phy_one_cnt <= #1 3'b000; $display(";A 361");		//(assert (= @i_rx_phy_one_cnt    0b000)) ;361 NB
            end
            else begin
                $display(";A 360");		//(assert (= (bv-not (bv-redor #i_rx_phy_shift_en ))   0b0)) ;360 BR
                if (i_rx_phy_fs_ce) begin
                    $display(";A 362");		//(assert (= #i_rx_phy_fs_ce    0b1)) ;362 BR
                    if (((!i_rx_phy_sd_nrzi) || (i_rx_phy_one_cnt == 3'b110))) begin
                        $display(";A 364");		//(assert (= (bv-or (bv-not (bv-redor #i_rx_phy_sd_nrzi )) (bv-comp #i_rx_phy_one_cnt  0b110))   0b1)) ;364 BR
                        i_rx_phy_one_cnt <= #1 3'b000; $display(";A 366");		//(assert (= @i_rx_phy_one_cnt    0b000)) ;366 NB
                    end
                    else begin
                        $display(";A 365");		//(assert (= (bv-or (bv-not (bv-redor #i_rx_phy_sd_nrzi )) (bv-comp #i_rx_phy_one_cnt  0b110))   0b0)) ;365 BR
                        i_rx_phy_one_cnt <= #1 (i_rx_phy_one_cnt + 3'b001); $display(";A 367");		//(assert (= @i_rx_phy_one_cnt    (bv-add #i_rx_phy_one_cnt  0b001))) ;367 NB
                    end
                end
                else begin
                    $display(";A 363");		//(assert (= #i_rx_phy_fs_ce    0b0)) ;363 BR
                end
            end
        end
    end

    // Following code segment is generated from flattened.v:965
    always @(posedge clk) begin
        i_rx_phy_bit_stuff_err <= #1 (((((i_rx_phy_one_cnt == 3'b110) & i_rx_phy_sd_nrzi) & i_rx_phy_fs_ce) & (!((!i_rx_phy_rxdp_s) & (!i_rx_phy_rxdn_s)))) & i_rx_phy_rx_active); $display(";A 368");		//(assert (= @i_rx_phy_bit_stuff_err    (bv-and (bv-and (bv-and (bv-and (bv-comp #i_rx_phy_one_cnt  0b110) #i_rx_phy_sd_nrzi ) #i_rx_phy_fs_ce ) (bv-not (bv-redor (bv-and (bv-not (bv-redor #i_rx_phy_rxdp_s )) (bv-not (bv-redor #i_rx_phy_rxdn_s )))))) #i_rx_phy_rx_active ))) ;368 NB
    end

    // Following code segment is generated from flattened.v:969
    always @(posedge clk) begin
        if (i_rx_phy_fs_ce) begin
            $display(";A 369");		//(assert (= #i_rx_phy_fs_ce    0b1)) ;369 BR
            i_rx_phy_shift_en <= #1 (i_rx_phy_synced_d | i_rx_phy_rx_active); $display(";A 371");		//(assert (= @i_rx_phy_shift_en    (bv-or #i_rx_phy_synced_d  #i_rx_phy_rx_active ))) ;371 NB
        end
        else begin
            $display(";A 370");		//(assert (= #i_rx_phy_fs_ce    0b0)) ;370 BR
        end
    end

    // Following code segment is generated from flattened.v:976
    always @(posedge clk) begin
        if (((i_rx_phy_fs_ce && i_rx_phy_shift_en) && (!(i_rx_phy_one_cnt == 3'b110)))) begin
            $display(";A 372");		//(assert (= (bv-and (bv-and #i_rx_phy_fs_ce  #i_rx_phy_shift_en ) (bv-not (bv-redor (bv-comp #i_rx_phy_one_cnt  0b110))))   0b1)) ;372 BR
            i_rx_phy_hold_reg <= #1 {i_rx_phy_sd_nrzi, i_rx_phy_hold_reg[7:1]}; $display(";A 374");		//(assert (= @i_rx_phy_hold_reg    (bv-concat #i_rx_phy_sd_nrzi  (bv-extract 7 1 #i_rx_phy_hold_reg )))) ;374 NB
        end
        else begin
            $display(";A 373");		//(assert (= (bv-and (bv-and #i_rx_phy_fs_ce  #i_rx_phy_shift_en ) (bv-not (bv-redor (bv-comp #i_rx_phy_one_cnt  0b110))))   0b0)) ;373 BR
        end
    end

    // Following code segment is generated from flattened.v:983
    always @(posedge clk or negedge rst) begin
        if ((!rst)) begin
            i_rx_phy_bit_cnt <= #1 3'b000; $display(";A 377");		//(assert (= @i_rx_phy_bit_cnt    0b000)) ;377 NB
        end
        else begin
            if ((!i_rx_phy_shift_en)) begin
                $display(";A 378");		//(assert (= (bv-not (bv-redor #i_rx_phy_shift_en ))   0b1)) ;378 BR
                i_rx_phy_bit_cnt <= #1 3'b000; $display(";A 380");		//(assert (= @i_rx_phy_bit_cnt    0b000)) ;380 NB
            end
            else begin
                $display(";A 379");		//(assert (= (bv-not (bv-redor #i_rx_phy_shift_en ))   0b0)) ;379 BR
                if ((i_rx_phy_fs_ce && (!(i_rx_phy_one_cnt == 3'b110)))) begin
                    $display(";A 381");		//(assert (= (bv-and #i_rx_phy_fs_ce  (bv-not (bv-redor (bv-comp #i_rx_phy_one_cnt  0b110))))   0b1)) ;381 BR
                    i_rx_phy_bit_cnt <= #1 (i_rx_phy_bit_cnt + 3'b001); $display(";A 383");		//(assert (= @i_rx_phy_bit_cnt    (bv-add #i_rx_phy_bit_cnt  0b001))) ;383 NB
                end
                else begin
                    $display(";A 382");		//(assert (= (bv-and #i_rx_phy_fs_ce  (bv-not (bv-redor (bv-comp #i_rx_phy_one_cnt  0b110))))   0b0)) ;382 BR
                end
            end
        end
    end

    // Following code segment is generated from flattened.v:1004
    always @(posedge clk or negedge rst) begin
        if ((!rst)) begin
            i_rx_phy_rx_valid1 <= #1 1'b0; $display(";A 386");		//(assert (= @i_rx_phy_rx_valid1    0b0)) ;386 NB
        end
        else begin
            if (((i_rx_phy_fs_ce && (!(i_rx_phy_one_cnt == 3'b110))) && (i_rx_phy_bit_cnt == 3'b111))) begin
                $display(";A 387");		//(assert (= (bv-and (bv-and #i_rx_phy_fs_ce  (bv-not (bv-redor (bv-comp #i_rx_phy_one_cnt  0b110)))) (bv-comp #i_rx_phy_bit_cnt  0b111))   0b1)) ;387 BR
                i_rx_phy_rx_valid1 <= #1 1'b1; $display(";A 389");		//(assert (= @i_rx_phy_rx_valid1    0b1)) ;389 NB
            end
            else begin
                $display(";A 388");		//(assert (= (bv-and (bv-and #i_rx_phy_fs_ce  (bv-not (bv-redor (bv-comp #i_rx_phy_one_cnt  0b110)))) (bv-comp #i_rx_phy_bit_cnt  0b111))   0b0)) ;388 BR
                if (((i_rx_phy_rx_valid1 && i_rx_phy_fs_ce) && (!(i_rx_phy_one_cnt == 3'b110)))) begin
                    $display(";A 390");		//(assert (= (bv-and (bv-and #i_rx_phy_rx_valid1  #i_rx_phy_fs_ce ) (bv-not (bv-redor (bv-comp #i_rx_phy_one_cnt  0b110))))   0b1)) ;390 BR
                    i_rx_phy_rx_valid1 <= #1 1'b0; $display(";A 392");		//(assert (= @i_rx_phy_rx_valid1    0b0)) ;392 NB
                end
                else begin
                    $display(";A 391");		//(assert (= (bv-and (bv-and #i_rx_phy_rx_valid1  #i_rx_phy_fs_ce ) (bv-not (bv-redor (bv-comp #i_rx_phy_one_cnt  0b110))))   0b0)) ;391 BR
                end
            end
        end
    end

    // Following code segment is generated from flattened.v:1025
    always @(posedge clk) begin
        i_rx_phy_rx_valid <= #1 (((!(i_rx_phy_one_cnt == 3'b110)) & i_rx_phy_rx_valid1) & i_rx_phy_fs_ce); $display(";A 393");		//(assert (= @i_rx_phy_rx_valid    (bv-and (bv-and (bv-not (bv-redor (bv-comp #i_rx_phy_one_cnt  0b110))) #i_rx_phy_rx_valid1 ) #i_rx_phy_fs_ce ))) ;393 NB
    end

    // Following code segment is generated from flattened.v:1029
    always @(posedge clk) begin
        i_rx_phy_se0_r <= #1 ((!i_rx_phy_rxdp_s) & (!i_rx_phy_rxdn_s)); $display(";A 394");		//(assert (= @i_rx_phy_se0_r    (bv-and (bv-not (bv-redor #i_rx_phy_rxdp_s )) (bv-not (bv-redor #i_rx_phy_rxdn_s ))))) ;394 NB
    end

    // Following code segment is generated from flattened.v:1033
    always @(posedge clk) begin
        i_rx_phy_byte_err <= #1 (((((!i_rx_phy_rxdp_s) & (!i_rx_phy_rxdn_s)) & (!i_rx_phy_se0_r)) & (|i_rx_phy_bit_cnt[2:1])) & i_rx_phy_rx_active); $display(";A 395");		//(assert (= @i_rx_phy_byte_err    (bv-and (bv-and (bv-and (bv-and (bv-not (bv-redor #i_rx_phy_rxdp_s )) (bv-not (bv-redor #i_rx_phy_rxdn_s ))) (bv-not (bv-redor #i_rx_phy_se0_r ))) (bv-redor (bv-extract 2 1 #i_rx_phy_bit_cnt ))) #i_rx_phy_rx_active ))) ;395 NB
    end

endmodule

