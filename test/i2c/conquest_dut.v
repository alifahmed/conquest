// Following code segment is generated from flattened.v:1
module i2c_master_top(wb_clk_i, rst_i, wb_adr_i, wb_dat_i, wb_dat_o, wb_we_i, wb_stb_i, wb_cyc_i, wb_ack_o, wb_inta_o, scl_pad_i, scl_pad_o, scl_padoen_o, sda_pad_i, sda_pad_o, sda_padoen_o, __obs);
    input wb_clk_i;
    input rst_i;
    input [2:0] wb_adr_i;
    input [7:0] wb_dat_i;
    output [7:0] wb_dat_o;
    input wb_we_i;
    input wb_stb_i;
    input wb_cyc_i;
    output wb_ack_o;
    output wb_inta_o;
    input scl_pad_i;
    output scl_pad_o;
    output scl_padoen_o;
    input sda_pad_i;
    output sda_pad_o;
    output sda_padoen_o;
    input __obs;

    reg ack = 1'b0;
    reg al = 1'b0;
    reg byte_controller_ack_out = 1'b0;
    reg byte_controller_bit_controller_al = 1'b0;
    reg byte_controller_bit_controller_busy = 1'b0;
    reg [16:0] byte_controller_bit_controller_c_state = 17'b0;
    reg byte_controller_bit_controller_clk_en = 1'b0;
    reg byte_controller_bit_controller_cmd_ack = 1'b0;
    reg byte_controller_bit_controller_cmd_stop = 1'b0;
    reg [15:0] byte_controller_bit_controller_cnt = 16'b0;
    reg byte_controller_bit_controller_dSCL = 1'b0;
    reg byte_controller_bit_controller_dSDA = 1'b0;
    reg byte_controller_bit_controller_dout = 1'b0;
    reg byte_controller_bit_controller_dscl_oen = 1'b0;
    reg byte_controller_bit_controller_sSCL = 1'b0;
    reg byte_controller_bit_controller_sSDB = 1'b0;
    reg byte_controller_bit_controller_scl_o = 1'b0;
    reg byte_controller_bit_controller_scl_oen = 1'b0;
    reg byte_controller_bit_controller_sda_chk = 1'b0;
    reg byte_controller_bit_controller_sda_o = 1'b0;
    reg byte_controller_bit_controller_sda_oen = 1'b0;
    reg byte_controller_bit_controller_sta_condition = 1'b0;
    reg byte_controller_bit_controller_sto_condition = 1'b0;
    reg [4:0] byte_controller_c_state = 5'b0;
    reg byte_controller_cmd_ack = 1'b0;
    reg [3:0] byte_controller_core_cmd = 4'b0;
    reg byte_controller_core_txd = 1'b0;
    reg [2:0] byte_controller_dcnt = 3'b0;
    reg [7:0] byte_controller_dout = 8'b0;
    reg byte_controller_i2c_al = 1'b0;
    reg byte_controller_i2c_busy = 1'b0;
    reg byte_controller_ld = 1'b0;
    reg byte_controller_shift = 1'b0;
    reg [7:0] byte_controller_sr = 8'b0;
    reg [7:0] cr = 8'b0;
    reg [7:0] ctr = 8'b0;
    reg i2c_busy = 1'b0;
    reg iack = 1'b0;
    reg irq_flag = 1'b0;
    reg [15:0] prer = 16'b0;
    reg rd = 1'b0;
    reg rxack = 1'b0;
    reg scl_pad_o = 1'b0;
    reg scl_padoen_o = 1'b0;
    reg sda_pad_o = 1'b0;
    reg sda_padoen_o = 1'b0;
    reg sta = 1'b0;
    reg sto = 1'b0;
    reg tip = 1'b0;
    reg [7:0] txr = 8'b0;
    reg wb_ack_o = 1'b0;
    reg [7:0] wb_dat_o = 8'b0;
    reg wb_inta_o = 1'b0;
    reg wb_wacc = 1'b0;
    reg wr = 1'b0;

    always @(*) begin
        scl_pad_o = 1'b0; $display(";A 0");		//(assert (= scl_pad_o    0b0)) ;0
    end

    always @(*) begin
        sda_pad_o = 1'b0; $display(";A 1");		//(assert (= sda_pad_o    0b0)) ;1
    end


    always @(*) begin
        sta = cr[7]; $display(";A 2");		//(assert (= sta    (bv-extract 7 7 cr ))) ;2
    end

    always @(*) begin
        sto = cr[6]; $display(";A 3");		//(assert (= sto    (bv-extract 6 6 cr ))) ;3
    end

    always @(*) begin
        rd = cr[5]; $display(";A 4");		//(assert (= rd    (bv-extract 5 5 cr ))) ;4
    end

    always @(*) begin
        wr = cr[4]; $display(";A 5");		//(assert (= wr    (bv-extract 4 4 cr ))) ;5
    end

    always @(*) begin
        ack = cr[3]; $display(";A 6");		//(assert (= ack    (bv-extract 3 3 cr ))) ;6
    end

    always @(*) begin
        iack = cr[0]; $display(";A 7");		//(assert (= iack    (bv-extract 0 0 cr ))) ;7
    end

    always @(*) begin
        wb_wacc = ((wb_cyc_i & wb_stb_i) & wb_we_i); $display(";A 8");		//(assert (= wb_wacc    (bv-and (bv-and wb_cyc_i  wb_stb_i ) wb_we_i ))) ;8
    end

    always @(*) begin
        i2c_busy = byte_controller_bit_controller_busy; $display(";A 9");		//(assert (= i2c_busy    byte_controller_bit_controller_busy )) ;9
    end

    always @(*) begin
        scl_padoen_o = byte_controller_bit_controller_scl_oen; $display(";A 10");		//(assert (= scl_padoen_o    byte_controller_bit_controller_scl_oen )) ;10
    end

    always @(*) begin
        sda_padoen_o = byte_controller_bit_controller_sda_oen; $display(";A 11");		//(assert (= sda_padoen_o    byte_controller_bit_controller_sda_oen )) ;11
    end

    always @(*) begin
        byte_controller_i2c_busy = byte_controller_bit_controller_busy; $display(";A 12");		//(assert (= byte_controller_i2c_busy    byte_controller_bit_controller_busy )) ;12
    end

    always @(*) begin
        byte_controller_i2c_al = byte_controller_bit_controller_al; $display(";A 13");		//(assert (= byte_controller_i2c_al    byte_controller_bit_controller_al )) ;13
    end

    always @(*) begin
        byte_controller_dout = byte_controller_sr; $display(";A 14");		//(assert (= byte_controller_dout    byte_controller_sr )) ;14
    end

    // Following code segment is generated from flattened.v:110
    always @(posedge wb_clk_i) begin
        wb_ack_o <= #1 ((wb_cyc_i & wb_stb_i) & (~wb_ack_o)); $display(";A 15");		//(assert (= wb_ack_o    (bv-and (bv-and wb_cyc_i  wb_stb_i ) (bv-not wb_ack_o )))) ;15
    end

    // Following code segment is generated from flattened.v:114
    always @(posedge wb_clk_i) begin
        case (wb_adr_i)
            3'b000 :
                begin
                    $display(";A 16");		//(assert (= wb_adr_i    0b000)) ;16
                    wb_dat_o <= #1 prer[7:0]; $display(";A 17");		//(assert (= wb_dat_o    (bv-extract 7 0 prer ))) ;17
                end
            3'b001 :
                begin
                    $display(";A 18");		//(assert (= wb_adr_i    0b001)) ;18
                    wb_dat_o <= #1 prer[15:8]; $display(";A 19");		//(assert (= wb_dat_o    (bv-extract 15 8 prer ))) ;19
                end
            3'b010 :
                begin
                    $display(";A 20");		//(assert (= wb_adr_i    0b010)) ;20
                    wb_dat_o <= #1 ctr; $display(";A 21");		//(assert (= wb_dat_o    ctr )) ;21
                end
            3'b011 :
                begin
                    $display(";A 22");		//(assert (= wb_adr_i    0b011)) ;22
                    wb_dat_o <= #1 byte_controller_dout; $display(";A 23");		//(assert (= wb_dat_o    byte_controller_dout )) ;23
                end
            3'b100 :
                begin
                    $display(";A 24");		//(assert (= wb_adr_i    0b100)) ;24
                    wb_dat_o <= #1 {rxack, i2c_busy, al, 3'b000, tip, irq_flag}; $display(";A 25");		//(assert (= wb_dat_o    (bv-concat rxack  i2c_busy  al  0b000 tip  irq_flag ))) ;25
                end
            3'b101 :
                begin
                    $display(";A 26");		//(assert (= wb_adr_i    0b101)) ;26
                    wb_dat_o <= #1 txr; $display(";A 27");		//(assert (= wb_dat_o    txr )) ;27
                end
            3'b110 :
                begin
                    $display(";A 28");		//(assert (= wb_adr_i    0b110)) ;28
                    wb_dat_o <= #1 cr; $display(";A 29");		//(assert (= wb_dat_o    cr )) ;29
                end
            3'b111 :
                begin
                    $display(";A 30");		//(assert (= wb_adr_i    0b111)) ;30
                    wb_dat_o <= #1 8'sb00000000; $display(";A 31");		//(assert (= wb_dat_o    0b00000000)) ;31
                end
        endcase
    end

    // Following code segment is generated from flattened.v:151
    always @(posedge wb_clk_i or negedge rst_i) begin
        if ((!rst_i)) begin
            prer <= #1 16'b1111111111111111; $display(";A 34");		//(assert (= prer    0b1111111111111111)) ;34
            ctr <= #1 8'b00000000; $display(";A 35");		//(assert (= ctr    0b00000000)) ;35
            txr <= #1 8'b00000000; $display(";A 36");		//(assert (= txr    0b00000000)) ;36
        end
        else begin
            if (wb_wacc) begin
                $display(";A 37");		//(assert (= wb_wacc    0b1)) ;37
                case (wb_adr_i)
                    3'b000 :
                        begin
                            $display(";A 39");		//(assert (= wb_adr_i    0b000)) ;39
                            prer <= #1 {prer[15:8], wb_dat_i}; $display(";A 40");		//(assert (= prer    (bv-concat (bv-extract 15 8 prer ) wb_dat_i ))) ;40
                        end
                    3'b001 :
                        begin
                            $display(";A 41");		//(assert (= wb_adr_i    0b001)) ;41
                            prer <= #1 {wb_dat_i, prer[7:0]}; $display(";A 42");		//(assert (= prer    (bv-concat wb_dat_i  (bv-extract 7 0 prer )))) ;42
                        end
                    3'b010 :
                        begin
                            $display(";A 43");		//(assert (= wb_adr_i    0b010)) ;43
                            ctr <= #1 wb_dat_i; $display(";A 44");		//(assert (= ctr    wb_dat_i )) ;44
                        end
                    3'b011 :
                        begin
                            $display(";A 45");		//(assert (= wb_adr_i    0b011)) ;45
                            txr <= #1 wb_dat_i; $display(";A 46");		//(assert (= txr    wb_dat_i )) ;46
                        end
                endcase
            end
            else begin
                $display(";A 38");		//(assert (= wb_wacc    0b0)) ;38
            end
        end
    end

    // Following code segment is generated from flattened.v:184
    always @(posedge wb_clk_i or negedge rst_i) begin
        if ((~rst_i)) begin
            cr <= #1 8'b00000000; $display(";A 49");		//(assert (= cr    0b00000000)) ;49
        end
        else begin
            if (wb_wacc) begin
                $display(";A 50");		//(assert (= wb_wacc    0b1)) ;50
                if ((ctr[7] & (wb_adr_i == 3'b100))) begin
                    $display(";A 52");		//(assert (= (bv-and (bv-extract 7 7 ctr ) (bv-comp wb_adr_i  0b100))   0b1)) ;52
                    cr <= #1 wb_dat_i; $display(";A 54");		//(assert (= cr    wb_dat_i )) ;54
                end
                else begin
                    $display(";A 53");		//(assert (= (bv-and (bv-extract 7 7 ctr ) (bv-comp wb_adr_i  0b100))   0b0)) ;53
                end
            end
            else begin
                $display(";A 51");		//(assert (= wb_wacc    0b0)) ;51
                if ((byte_controller_cmd_ack | byte_controller_i2c_al)) begin
                    $display(";A 55");		//(assert (= (bv-or byte_controller_cmd_ack  byte_controller_i2c_al )   0b1)) ;55
                    cr <= #1 {4'b0000, cr[3:0]}; $display(";A 57");		//(assert (= cr    (bv-concat 0b0000 (bv-extract 3 0 cr )))) ;57
                end
                else begin
                    $display(";A 56");		//(assert (= (bv-or byte_controller_cmd_ack  byte_controller_i2c_al )   0b0)) ;56
                end
                cr <= #1 {cr[7:3], 3'b000}; $display(";A 58");		//(assert (= cr    (bv-concat (bv-extract 7 3 cr ) 0b000))) ;58
            end
        end
    end

    // Following code segment is generated from flattened.v:209
    always @(posedge wb_clk_i or negedge rst_i) begin
        if ((!rst_i)) begin
            al <= #1 1'b0; $display(";A 61");		//(assert (= al    0b0)) ;61
            rxack <= #1 1'b0; $display(";A 62");		//(assert (= rxack    0b0)) ;62
            tip <= #1 1'b0; $display(";A 63");		//(assert (= tip    0b0)) ;63
            irq_flag <= #1 1'b0; $display(";A 64");		//(assert (= irq_flag    0b0)) ;64
        end
        else begin
            al <= #1 (byte_controller_i2c_al | (al & (~sta))); $display(";A 65");		//(assert (= al    (bv-or byte_controller_i2c_al  (bv-and al  (bv-not sta ))))) ;65
            rxack <= #1 byte_controller_ack_out; $display(";A 66");		//(assert (= rxack    byte_controller_ack_out )) ;66
            tip <= #1 (rd | wr); $display(";A 67");		//(assert (= tip    (bv-or rd  wr ))) ;67
            irq_flag <= #1 (((byte_controller_cmd_ack | byte_controller_i2c_al) | irq_flag) & (~iack)); $display(";A 68");		//(assert (= irq_flag    (bv-and (bv-or (bv-or byte_controller_cmd_ack  byte_controller_i2c_al ) irq_flag ) (bv-not iack )))) ;68
        end
    end

    // Following code segment is generated from flattened.v:226
    always @(posedge wb_clk_i or negedge rst_i) begin
        if ((!rst_i)) begin
            wb_inta_o <= #1 1'b0; $display(";A 71");		//(assert (= wb_inta_o    0b0)) ;71
        end
        else begin
            wb_inta_o <= #1 (irq_flag && ctr[6]); $display(";A 72");		//(assert (= wb_inta_o    (bv-and irq_flag  (bv-extract 6 6 ctr )))) ;72
        end
    end

    // Following code segment is generated from flattened.v:244
    always @(posedge wb_clk_i or negedge rst_i) begin
        if ((~rst_i)) begin
            byte_controller_bit_controller_dscl_oen <= #1 1'b0; $display(";A 75");		//(assert (= byte_controller_bit_controller_dscl_oen    0b0)) ;75
        end
        else begin
            byte_controller_bit_controller_dscl_oen <= #1 byte_controller_bit_controller_scl_oen; $display(";A 76");		//(assert (= byte_controller_bit_controller_dscl_oen    byte_controller_bit_controller_scl_oen )) ;76
        end
    end

    // Following code segment is generated from flattened.v:255
    always @(posedge wb_clk_i or negedge rst_i) begin
        if ((~rst_i)) begin
            byte_controller_bit_controller_cnt <= #1 16'b0000000000000000; $display(";A 79");		//(assert (= byte_controller_bit_controller_cnt    0b0000000000000000)) ;79
            byte_controller_bit_controller_clk_en <= #1 1'b1; $display(";A 80");		//(assert (= byte_controller_bit_controller_clk_en    0b1)) ;80
        end
        else begin
            if (((~|byte_controller_bit_controller_cnt) || (~ctr[7]))) begin
                $display(";A 81");		//(assert (= (bv-or (bv-not (bv-redor byte_controller_bit_controller_cnt )) (bv-not (bv-extract 7 7 ctr )))   0b1)) ;81
                if ((~(byte_controller_bit_controller_dscl_oen && (!byte_controller_bit_controller_sSCL)))) begin
                    $display(";A 83");		//(assert (= (bv-not (bv-and byte_controller_bit_controller_dscl_oen  (bv-not (bv-redor byte_controller_bit_controller_sSCL ))))   0b1)) ;83
                    byte_controller_bit_controller_cnt <= #1 prer; $display(";A 85");		//(assert (= byte_controller_bit_controller_cnt    prer )) ;85
                    byte_controller_bit_controller_clk_en <= #1 1'b1; $display(";A 86");		//(assert (= byte_controller_bit_controller_clk_en    0b1)) ;86
                end
                else begin
                    $display(";A 84");		//(assert (= (bv-not (bv-and byte_controller_bit_controller_dscl_oen  (bv-not (bv-redor byte_controller_bit_controller_sSCL ))))   0b0)) ;84
                    byte_controller_bit_controller_cnt <= #1 byte_controller_bit_controller_cnt; $display(";A 87");		//(assert (= byte_controller_bit_controller_cnt    byte_controller_bit_controller_cnt )) ;87
                    byte_controller_bit_controller_clk_en <= #1 1'b0; $display(";A 88");		//(assert (= byte_controller_bit_controller_clk_en    0b0)) ;88
                end
            end
            else begin
                $display(";A 82");		//(assert (= (bv-or (bv-not (bv-redor byte_controller_bit_controller_cnt )) (bv-not (bv-extract 7 7 ctr )))   0b0)) ;82
                byte_controller_bit_controller_cnt <= #1 (byte_controller_bit_controller_cnt - 16'b0000000000000001); $display(";A 89");		//(assert (= byte_controller_bit_controller_cnt    (bv-sub byte_controller_bit_controller_cnt  0b0000000000000001))) ;89
                byte_controller_bit_controller_clk_en <= #1 1'b0; $display(";A 90");		//(assert (= byte_controller_bit_controller_clk_en    0b0)) ;90
            end
        end
    end

    // Following code segment is generated from flattened.v:284
    always @(posedge wb_clk_i or negedge rst_i) begin
        if ((~rst_i)) begin
            byte_controller_bit_controller_sSCL <= #1 1'b1; $display(";A 93");		//(assert (= byte_controller_bit_controller_sSCL    0b1)) ;93
            byte_controller_bit_controller_sSDB <= #1 1'b1; $display(";A 94");		//(assert (= byte_controller_bit_controller_sSDB    0b1)) ;94
            byte_controller_bit_controller_dSCL <= #1 1'b1; $display(";A 95");		//(assert (= byte_controller_bit_controller_dSCL    0b1)) ;95
            byte_controller_bit_controller_dSDA <= #1 1'b1; $display(";A 96");		//(assert (= byte_controller_bit_controller_dSDA    0b1)) ;96
        end
        else begin
            byte_controller_bit_controller_sSCL <= #1 scl_pad_i; $display(";A 97");		//(assert (= byte_controller_bit_controller_sSCL    scl_pad_i )) ;97
            byte_controller_bit_controller_sSDB <= #1 sda_pad_i; $display(";A 98");		//(assert (= byte_controller_bit_controller_sSDB    sda_pad_i )) ;98
            byte_controller_bit_controller_dSCL <= #1 byte_controller_bit_controller_sSCL; $display(";A 99");		//(assert (= byte_controller_bit_controller_dSCL    byte_controller_bit_controller_sSCL )) ;99
            byte_controller_bit_controller_dSDA <= #1 byte_controller_bit_controller_sSDB; $display(";A 100");		//(assert (= byte_controller_bit_controller_dSDA    byte_controller_bit_controller_sSDB )) ;100
        end
    end

    // Following code segment is generated from flattened.v:301
    always @(posedge wb_clk_i or negedge rst_i) begin
        if ((~rst_i)) begin
            byte_controller_bit_controller_sta_condition <= #1 1'b0; $display(";A 103");		//(assert (= byte_controller_bit_controller_sta_condition    0b0)) ;103
            byte_controller_bit_controller_sto_condition <= #1 1'b0; $display(";A 104");		//(assert (= byte_controller_bit_controller_sto_condition    0b0)) ;104
        end
        else begin
            byte_controller_bit_controller_sta_condition <= #1 (((~byte_controller_bit_controller_sSDB) & byte_controller_bit_controller_dSDA) & byte_controller_bit_controller_sSCL); $display(";A 105");		//(assert (= byte_controller_bit_controller_sta_condition    (bv-and (bv-and (bv-not byte_controller_bit_controller_sSDB ) byte_controller_bit_controller_dSDA ) byte_controller_bit_controller_sSCL ))) ;105
            byte_controller_bit_controller_sto_condition <= #1 ((byte_controller_bit_controller_sSDB & (~byte_controller_bit_controller_dSDA)) & byte_controller_bit_controller_sSCL); $display(";A 106");		//(assert (= byte_controller_bit_controller_sto_condition    (bv-and (bv-and byte_controller_bit_controller_sSDB  (bv-not byte_controller_bit_controller_dSDA )) byte_controller_bit_controller_sSCL ))) ;106
        end
    end

    // Following code segment is generated from flattened.v:314
    always @(posedge wb_clk_i or negedge rst_i) begin
        if ((!rst_i)) begin
            byte_controller_bit_controller_busy <= #1 1'b0; $display(";A 109");		//(assert (= byte_controller_bit_controller_busy    0b0)) ;109
        end
        else begin
            byte_controller_bit_controller_busy <= #1 ((byte_controller_bit_controller_sta_condition | byte_controller_bit_controller_busy) & (~byte_controller_bit_controller_sto_condition)); $display(";A 110");		//(assert (= byte_controller_bit_controller_busy    (bv-and (bv-or byte_controller_bit_controller_sta_condition  byte_controller_bit_controller_busy ) (bv-not byte_controller_bit_controller_sto_condition )))) ;110
        end
    end

    // Following code segment is generated from flattened.v:325
    always @(posedge wb_clk_i or negedge rst_i) begin
        if ((~rst_i)) begin
            byte_controller_bit_controller_cmd_stop <= #1 1'b0; $display(";A 113");		//(assert (= byte_controller_bit_controller_cmd_stop    0b0)) ;113
        end
        else begin
            if (byte_controller_bit_controller_clk_en) begin
                $display(";A 114");		//(assert (= byte_controller_bit_controller_clk_en    0b1)) ;114
                byte_controller_bit_controller_cmd_stop <= #1 (byte_controller_core_cmd == 4'b0010); $display(";A 116");		//(assert (= byte_controller_bit_controller_cmd_stop    (bv-comp byte_controller_core_cmd  0b0010))) ;116
            end
            else begin
                $display(";A 115");		//(assert (= byte_controller_bit_controller_clk_en    0b0)) ;115
            end
        end
    end

    // Following code segment is generated from flattened.v:339
    always @(posedge wb_clk_i or negedge rst_i) begin
        if ((~rst_i)) begin
            byte_controller_bit_controller_al <= #1 1'b0; $display(";A 119");		//(assert (= byte_controller_bit_controller_al    0b0)) ;119
        end
        else begin
            byte_controller_bit_controller_al <= #1 (((byte_controller_bit_controller_sda_chk & (~byte_controller_bit_controller_sSDB)) & byte_controller_bit_controller_sda_oen) | (((|byte_controller_bit_controller_c_state) & byte_controller_bit_controller_sto_condition) & (~byte_controller_bit_controller_cmd_stop))); $display(";A 120");		//(assert (= byte_controller_bit_controller_al    (bv-or (bv-and (bv-and byte_controller_bit_controller_sda_chk  (bv-not byte_controller_bit_controller_sSDB )) byte_controller_bit_controller_sda_oen ) (bv-and (bv-and (bv-redor byte_controller_bit_controller_c_state ) byte_controller_bit_controller_sto_condition ) (bv-not byte_controller_bit_controller_cmd_stop ))))) ;120
        end
    end

    // Following code segment is generated from flattened.v:350
    always @(posedge wb_clk_i or negedge rst_i) begin
        if ((~rst_i)) begin
            byte_controller_bit_controller_dout <= #1 1'b0; $display(";A 123");		//(assert (= byte_controller_bit_controller_dout    0b0)) ;123
        end
        else begin
            if ((byte_controller_bit_controller_sSCL & (~byte_controller_bit_controller_dSCL))) begin
                $display(";A 124");		//(assert (= (bv-and byte_controller_bit_controller_sSCL  (bv-not byte_controller_bit_controller_dSCL ))   0b1)) ;124
                byte_controller_bit_controller_dout <= #1 byte_controller_bit_controller_sSDB; $display(";A 126");		//(assert (= byte_controller_bit_controller_dout    byte_controller_bit_controller_sSDB )) ;126
            end
            else begin
                $display(";A 125");		//(assert (= (bv-and byte_controller_bit_controller_sSCL  (bv-not byte_controller_bit_controller_dSCL ))   0b0)) ;125
            end
        end
    end

    // Following code segment is generated from flattened.v:364
    always @(posedge wb_clk_i or negedge rst_i) begin
        if ((!rst_i)) begin
            byte_controller_bit_controller_c_state <= #1 17'b00000000000000000; $display(";A 129");		//(assert (= byte_controller_bit_controller_c_state    0b00000000000000000)) ;129
            byte_controller_bit_controller_cmd_ack <= #1 1'b0; $display(";A 130");		//(assert (= byte_controller_bit_controller_cmd_ack    0b0)) ;130
            byte_controller_bit_controller_scl_oen <= #1 1'b1; $display(";A 131");		//(assert (= byte_controller_bit_controller_scl_oen    0b1)) ;131
            byte_controller_bit_controller_sda_oen <= #1 1'b1; $display(";A 132");		//(assert (= byte_controller_bit_controller_sda_oen    0b1)) ;132
            byte_controller_bit_controller_sda_chk <= #1 1'b0; $display(";A 133");		//(assert (= byte_controller_bit_controller_sda_chk    0b0)) ;133
        end
        else begin
            if (byte_controller_bit_controller_al) begin
                $display(";A 134");		//(assert (= byte_controller_bit_controller_al    0b1)) ;134
                byte_controller_bit_controller_c_state <= #1 17'b00000000000000000; $display(";A 136");		//(assert (= byte_controller_bit_controller_c_state    0b00000000000000000)) ;136
                byte_controller_bit_controller_cmd_ack <= #1 1'b0; $display(";A 137");		//(assert (= byte_controller_bit_controller_cmd_ack    0b0)) ;137
                byte_controller_bit_controller_scl_oen <= #1 1'b1; $display(";A 138");		//(assert (= byte_controller_bit_controller_scl_oen    0b1)) ;138
                byte_controller_bit_controller_sda_oen <= #1 1'b1; $display(";A 139");		//(assert (= byte_controller_bit_controller_sda_oen    0b1)) ;139
                byte_controller_bit_controller_sda_chk <= #1 1'b0; $display(";A 140");		//(assert (= byte_controller_bit_controller_sda_chk    0b0)) ;140
            end
            else begin
                $display(";A 135");		//(assert (= byte_controller_bit_controller_al    0b0)) ;135
                byte_controller_bit_controller_cmd_ack <= #1 1'b0; $display(";A 141");		//(assert (= byte_controller_bit_controller_cmd_ack    0b0)) ;141
                if (byte_controller_bit_controller_clk_en) begin
                    $display(";A 142");		//(assert (= byte_controller_bit_controller_clk_en    0b1)) ;142
                    case (byte_controller_bit_controller_c_state)
                        17'b00000000000000000 :
                            begin
                                $display(";A 144");		//(assert (= byte_controller_bit_controller_c_state    0b00000000000000000)) ;144
                                case (byte_controller_core_cmd)
                                    4'b0001 :
                                        begin
                                            $display(";A 145");		//(assert (= byte_controller_core_cmd    0b0001)) ;145
                                            byte_controller_bit_controller_c_state <= #1 17'b00000000000000001; $display(";A 146");		//(assert (= byte_controller_bit_controller_c_state    0b00000000000000001)) ;146
                                        end
                                    4'b0010 :
                                        begin
                                            $display(";A 147");		//(assert (= byte_controller_core_cmd    0b0010)) ;147
                                            byte_controller_bit_controller_c_state <= #1 17'b00000000000100000; $display(";A 148");		//(assert (= byte_controller_bit_controller_c_state    0b00000000000100000)) ;148
                                        end
                                    4'b0100 :
                                        begin
                                            $display(";A 149");		//(assert (= byte_controller_core_cmd    0b0100)) ;149
                                            byte_controller_bit_controller_c_state <= #1 17'b00010000000000000; $display(";A 150");		//(assert (= byte_controller_bit_controller_c_state    0b00010000000000000)) ;150
                                        end
                                    4'b1000 :
                                        begin
                                            $display(";A 151");		//(assert (= byte_controller_core_cmd    0b1000)) ;151
                                            byte_controller_bit_controller_c_state <= #1 17'b00000001000000000; $display(";A 152");		//(assert (= byte_controller_bit_controller_c_state    0b00000001000000000)) ;152
                                        end
                                    default:
                                        begin
                                            $display(";A 153");		//(assert (= (and (/= byte_controller_core_cmd  0b0001) (/= byte_controller_core_cmd  0b0010) (/= byte_controller_core_cmd  0b0100) (/= byte_controller_core_cmd  0b1000))   true)) ;153
                                            byte_controller_bit_controller_c_state <= #1 17'b00000000000000000; $display(";A 154");		//(assert (= byte_controller_bit_controller_c_state    0b00000000000000000)) ;154
                                        end
                                endcase
                                byte_controller_bit_controller_scl_oen <= #1 byte_controller_bit_controller_scl_oen; $display(";A 155");		//(assert (= byte_controller_bit_controller_scl_oen    byte_controller_bit_controller_scl_oen )) ;155
                                byte_controller_bit_controller_sda_oen <= #1 byte_controller_bit_controller_sda_oen; $display(";A 156");		//(assert (= byte_controller_bit_controller_sda_oen    byte_controller_bit_controller_sda_oen )) ;156
                                byte_controller_bit_controller_sda_chk <= #1 1'b0; $display(";A 157");		//(assert (= byte_controller_bit_controller_sda_chk    0b0)) ;157
                            end
                        17'b00000000000000001 :
                            begin
                                $display(";A 158");		//(assert (= byte_controller_bit_controller_c_state    0b00000000000000001)) ;158
                                byte_controller_bit_controller_c_state <= #1 17'b00000000000000010; $display(";A 159");		//(assert (= byte_controller_bit_controller_c_state    0b00000000000000010)) ;159
                                byte_controller_bit_controller_scl_oen <= #1 byte_controller_bit_controller_scl_oen; $display(";A 160");		//(assert (= byte_controller_bit_controller_scl_oen    byte_controller_bit_controller_scl_oen )) ;160
                                byte_controller_bit_controller_sda_oen <= #1 1'b1; $display(";A 161");		//(assert (= byte_controller_bit_controller_sda_oen    0b1)) ;161
                                byte_controller_bit_controller_sda_chk <= #1 1'b0; $display(";A 162");		//(assert (= byte_controller_bit_controller_sda_chk    0b0)) ;162
                            end
                        17'b00000000000000010 :
                            begin
                                $display(";A 163");		//(assert (= byte_controller_bit_controller_c_state    0b00000000000000010)) ;163
                                byte_controller_bit_controller_c_state <= #1 17'b00000000000000100; $display(";A 164");		//(assert (= byte_controller_bit_controller_c_state    0b00000000000000100)) ;164
                                byte_controller_bit_controller_scl_oen <= #1 1'b1; $display(";A 165");		//(assert (= byte_controller_bit_controller_scl_oen    0b1)) ;165
                                byte_controller_bit_controller_sda_oen <= #1 1'b1; $display(";A 166");		//(assert (= byte_controller_bit_controller_sda_oen    0b1)) ;166
                                byte_controller_bit_controller_sda_chk <= #1 1'b0; $display(";A 167");		//(assert (= byte_controller_bit_controller_sda_chk    0b0)) ;167
                            end
                        17'b00000000000000100 :
                            begin
                                $display(";A 168");		//(assert (= byte_controller_bit_controller_c_state    0b00000000000000100)) ;168
                                byte_controller_bit_controller_c_state <= #1 17'b00000000000001000; $display(";A 169");		//(assert (= byte_controller_bit_controller_c_state    0b00000000000001000)) ;169
                                byte_controller_bit_controller_scl_oen <= #1 1'b1; $display(";A 170");		//(assert (= byte_controller_bit_controller_scl_oen    0b1)) ;170
                                byte_controller_bit_controller_sda_oen <= #1 1'b0; $display(";A 171");		//(assert (= byte_controller_bit_controller_sda_oen    0b0)) ;171
                                byte_controller_bit_controller_sda_chk <= #1 1'b0; $display(";A 172");		//(assert (= byte_controller_bit_controller_sda_chk    0b0)) ;172
                            end
                        17'b00000000000001000 :
                            begin
                                $display(";A 173");		//(assert (= byte_controller_bit_controller_c_state    0b00000000000001000)) ;173
                                byte_controller_bit_controller_c_state <= #1 17'b00000000000010000; $display(";A 174");		//(assert (= byte_controller_bit_controller_c_state    0b00000000000010000)) ;174
                                byte_controller_bit_controller_scl_oen <= #1 1'b1; $display(";A 175");		//(assert (= byte_controller_bit_controller_scl_oen    0b1)) ;175
                                byte_controller_bit_controller_sda_oen <= #1 1'b0; $display(";A 176");		//(assert (= byte_controller_bit_controller_sda_oen    0b0)) ;176
                                byte_controller_bit_controller_sda_chk <= #1 1'b0; $display(";A 177");		//(assert (= byte_controller_bit_controller_sda_chk    0b0)) ;177
                            end
                        17'b00000000000010000 :
                            begin
                                $display(";A 178");		//(assert (= byte_controller_bit_controller_c_state    0b00000000000010000)) ;178
                                byte_controller_bit_controller_c_state <= #1 17'b00000000000000000; $display(";A 179");		//(assert (= byte_controller_bit_controller_c_state    0b00000000000000000)) ;179
                                byte_controller_bit_controller_cmd_ack <= #1 1'b1; $display(";A 180");		//(assert (= byte_controller_bit_controller_cmd_ack    0b1)) ;180
                                byte_controller_bit_controller_scl_oen <= #1 1'b0; $display(";A 181");		//(assert (= byte_controller_bit_controller_scl_oen    0b0)) ;181
                                byte_controller_bit_controller_sda_oen <= #1 1'b0; $display(";A 182");		//(assert (= byte_controller_bit_controller_sda_oen    0b0)) ;182
                                byte_controller_bit_controller_sda_chk <= #1 1'b0; $display(";A 183");		//(assert (= byte_controller_bit_controller_sda_chk    0b0)) ;183
                            end
                        17'b00000000000100000 :
                            begin
                                $display(";A 184");		//(assert (= byte_controller_bit_controller_c_state    0b00000000000100000)) ;184
                                byte_controller_bit_controller_c_state <= #1 17'b00000000001000000; $display(";A 185");		//(assert (= byte_controller_bit_controller_c_state    0b00000000001000000)) ;185
                                byte_controller_bit_controller_scl_oen <= #1 1'b0; $display(";A 186");		//(assert (= byte_controller_bit_controller_scl_oen    0b0)) ;186
                                byte_controller_bit_controller_sda_oen <= #1 1'b0; $display(";A 187");		//(assert (= byte_controller_bit_controller_sda_oen    0b0)) ;187
                                byte_controller_bit_controller_sda_chk <= #1 1'b0; $display(";A 188");		//(assert (= byte_controller_bit_controller_sda_chk    0b0)) ;188
                            end
                        17'b00000000001000000 :
                            begin
                                $display(";A 189");		//(assert (= byte_controller_bit_controller_c_state    0b00000000001000000)) ;189
                                byte_controller_bit_controller_c_state <= #1 17'b00000000010000000; $display(";A 190");		//(assert (= byte_controller_bit_controller_c_state    0b00000000010000000)) ;190
                                byte_controller_bit_controller_scl_oen <= #1 1'b1; $display(";A 191");		//(assert (= byte_controller_bit_controller_scl_oen    0b1)) ;191
                                byte_controller_bit_controller_sda_oen <= #1 1'b0; $display(";A 192");		//(assert (= byte_controller_bit_controller_sda_oen    0b0)) ;192
                                byte_controller_bit_controller_sda_chk <= #1 1'b0; $display(";A 193");		//(assert (= byte_controller_bit_controller_sda_chk    0b0)) ;193
                            end
                        17'b00000000010000000 :
                            begin
                                $display(";A 194");		//(assert (= byte_controller_bit_controller_c_state    0b00000000010000000)) ;194
                                byte_controller_bit_controller_c_state <= #1 17'b00000000100000000; $display(";A 195");		//(assert (= byte_controller_bit_controller_c_state    0b00000000100000000)) ;195
                                byte_controller_bit_controller_scl_oen <= #1 1'b1; $display(";A 196");		//(assert (= byte_controller_bit_controller_scl_oen    0b1)) ;196
                                byte_controller_bit_controller_sda_oen <= #1 1'b0; $display(";A 197");		//(assert (= byte_controller_bit_controller_sda_oen    0b0)) ;197
                                byte_controller_bit_controller_sda_chk <= #1 1'b0; $display(";A 198");		//(assert (= byte_controller_bit_controller_sda_chk    0b0)) ;198
                            end
                        17'b00000000100000000 :
                            begin
                                $display(";A 199");		//(assert (= byte_controller_bit_controller_c_state    0b00000000100000000)) ;199
                                byte_controller_bit_controller_c_state <= #1 17'b00000000000000000; $display(";A 200");		//(assert (= byte_controller_bit_controller_c_state    0b00000000000000000)) ;200
                                byte_controller_bit_controller_cmd_ack <= #1 1'b1; $display(";A 201");		//(assert (= byte_controller_bit_controller_cmd_ack    0b1)) ;201
                                byte_controller_bit_controller_scl_oen <= #1 1'b1; $display(";A 202");		//(assert (= byte_controller_bit_controller_scl_oen    0b1)) ;202
                                byte_controller_bit_controller_sda_oen <= #1 1'b1; $display(";A 203");		//(assert (= byte_controller_bit_controller_sda_oen    0b1)) ;203
                                byte_controller_bit_controller_sda_chk <= #1 1'b0; $display(";A 204");		//(assert (= byte_controller_bit_controller_sda_chk    0b0)) ;204
                            end
                        17'b00000001000000000 :
                            begin
                                $display(";A 205");		//(assert (= byte_controller_bit_controller_c_state    0b00000001000000000)) ;205
                                byte_controller_bit_controller_c_state <= #1 17'b00000010000000000; $display(";A 206");		//(assert (= byte_controller_bit_controller_c_state    0b00000010000000000)) ;206
                                byte_controller_bit_controller_scl_oen <= #1 1'b0; $display(";A 207");		//(assert (= byte_controller_bit_controller_scl_oen    0b0)) ;207
                                byte_controller_bit_controller_sda_oen <= #1 1'b1; $display(";A 208");		//(assert (= byte_controller_bit_controller_sda_oen    0b1)) ;208
                                byte_controller_bit_controller_sda_chk <= #1 1'b0; $display(";A 209");		//(assert (= byte_controller_bit_controller_sda_chk    0b0)) ;209
                            end
                        17'b00000010000000000 :
                            begin
                                $display(";A 210");		//(assert (= byte_controller_bit_controller_c_state    0b00000010000000000)) ;210
                                byte_controller_bit_controller_c_state <= #1 17'b00000100000000000; $display(";A 211");		//(assert (= byte_controller_bit_controller_c_state    0b00000100000000000)) ;211
                                byte_controller_bit_controller_scl_oen <= #1 1'b1; $display(";A 212");		//(assert (= byte_controller_bit_controller_scl_oen    0b1)) ;212
                                byte_controller_bit_controller_sda_oen <= #1 1'b1; $display(";A 213");		//(assert (= byte_controller_bit_controller_sda_oen    0b1)) ;213
                                byte_controller_bit_controller_sda_chk <= #1 1'b0; $display(";A 214");		//(assert (= byte_controller_bit_controller_sda_chk    0b0)) ;214
                            end
                        17'b00000100000000000 :
                            begin
                                $display(";A 215");		//(assert (= byte_controller_bit_controller_c_state    0b00000100000000000)) ;215
                                byte_controller_bit_controller_c_state <= #1 17'b00001000000000000; $display(";A 216");		//(assert (= byte_controller_bit_controller_c_state    0b00001000000000000)) ;216
                                byte_controller_bit_controller_scl_oen <= #1 1'b1; $display(";A 217");		//(assert (= byte_controller_bit_controller_scl_oen    0b1)) ;217
                                byte_controller_bit_controller_sda_oen <= #1 1'b1; $display(";A 218");		//(assert (= byte_controller_bit_controller_sda_oen    0b1)) ;218
                                byte_controller_bit_controller_sda_chk <= #1 1'b0; $display(";A 219");		//(assert (= byte_controller_bit_controller_sda_chk    0b0)) ;219
                            end
                        17'b00001000000000000 :
                            begin
                                $display(";A 220");		//(assert (= byte_controller_bit_controller_c_state    0b00001000000000000)) ;220
                                byte_controller_bit_controller_c_state <= #1 17'b00000000000000000; $display(";A 221");		//(assert (= byte_controller_bit_controller_c_state    0b00000000000000000)) ;221
                                byte_controller_bit_controller_cmd_ack <= #1 1'b1; $display(";A 222");		//(assert (= byte_controller_bit_controller_cmd_ack    0b1)) ;222
                                byte_controller_bit_controller_scl_oen <= #1 1'b0; $display(";A 223");		//(assert (= byte_controller_bit_controller_scl_oen    0b0)) ;223
                                byte_controller_bit_controller_sda_oen <= #1 1'b1; $display(";A 224");		//(assert (= byte_controller_bit_controller_sda_oen    0b1)) ;224
                                byte_controller_bit_controller_sda_chk <= #1 1'b0; $display(";A 225");		//(assert (= byte_controller_bit_controller_sda_chk    0b0)) ;225
                            end
                        17'b00010000000000000 :
                            begin
                                $display(";A 226");		//(assert (= byte_controller_bit_controller_c_state    0b00010000000000000)) ;226
                                byte_controller_bit_controller_c_state <= #1 17'b00100000000000000; $display(";A 227");		//(assert (= byte_controller_bit_controller_c_state    0b00100000000000000)) ;227
                                byte_controller_bit_controller_scl_oen <= #1 1'b0; $display(";A 228");		//(assert (= byte_controller_bit_controller_scl_oen    0b0)) ;228
                                byte_controller_bit_controller_sda_oen <= #1 byte_controller_core_txd; $display(";A 229");		//(assert (= byte_controller_bit_controller_sda_oen    byte_controller_core_txd )) ;229
                                byte_controller_bit_controller_sda_chk <= #1 1'b0; $display(";A 230");		//(assert (= byte_controller_bit_controller_sda_chk    0b0)) ;230
                            end
                        17'b00100000000000000 :
                            begin
                                $display(";A 231");		//(assert (= byte_controller_bit_controller_c_state    0b00100000000000000)) ;231
                                byte_controller_bit_controller_c_state <= #1 17'b01000000000000000; $display(";A 232");		//(assert (= byte_controller_bit_controller_c_state    0b01000000000000000)) ;232
                                byte_controller_bit_controller_scl_oen <= #1 1'b1; $display(";A 233");		//(assert (= byte_controller_bit_controller_scl_oen    0b1)) ;233
                                byte_controller_bit_controller_sda_oen <= #1 byte_controller_core_txd; $display(";A 234");		//(assert (= byte_controller_bit_controller_sda_oen    byte_controller_core_txd )) ;234
                                byte_controller_bit_controller_sda_chk <= #1 1'b1; $display(";A 235");		//(assert (= byte_controller_bit_controller_sda_chk    0b1)) ;235
                            end
                        17'b01000000000000000 :
                            begin
                                $display(";A 236");		//(assert (= byte_controller_bit_controller_c_state    0b01000000000000000)) ;236
                                byte_controller_bit_controller_c_state <= #1 17'b10000000000000000; $display(";A 237");		//(assert (= byte_controller_bit_controller_c_state    0b10000000000000000)) ;237
                                byte_controller_bit_controller_scl_oen <= #1 1'b1; $display(";A 238");		//(assert (= byte_controller_bit_controller_scl_oen    0b1)) ;238
                                byte_controller_bit_controller_sda_oen <= #1 byte_controller_core_txd; $display(";A 239");		//(assert (= byte_controller_bit_controller_sda_oen    byte_controller_core_txd )) ;239
                                byte_controller_bit_controller_sda_chk <= #1 1'b1; $display(";A 240");		//(assert (= byte_controller_bit_controller_sda_chk    0b1)) ;240
                            end
                        17'b10000000000000000 :
                            begin
                                $display(";A 241");		//(assert (= byte_controller_bit_controller_c_state    0b10000000000000000)) ;241
                                byte_controller_bit_controller_c_state <= #1 17'b00000000000000000; $display(";A 242");		//(assert (= byte_controller_bit_controller_c_state    0b00000000000000000)) ;242
                                byte_controller_bit_controller_cmd_ack <= #1 1'b1; $display(";A 243");		//(assert (= byte_controller_bit_controller_cmd_ack    0b1)) ;243
                                byte_controller_bit_controller_scl_oen <= #1 1'b0; $display(";A 244");		//(assert (= byte_controller_bit_controller_scl_oen    0b0)) ;244
                                byte_controller_bit_controller_sda_oen <= #1 byte_controller_core_txd; $display(";A 245");		//(assert (= byte_controller_bit_controller_sda_oen    byte_controller_core_txd )) ;245
                                byte_controller_bit_controller_sda_chk <= #1 1'b0; $display(";A 246");		//(assert (= byte_controller_bit_controller_sda_chk    0b0)) ;246
                            end
                    endcase
                end
                else begin
                    $display(";A 143");		//(assert (= byte_controller_bit_controller_clk_en    0b0)) ;143
                end
            end
        end
    end

    // Following code segment is generated from flattened.v:547
    always @(posedge wb_clk_i or negedge rst_i) begin
        if ((!rst_i)) begin
            byte_controller_sr <= #1 8'b00000000; $display(";A 249");		//(assert (= byte_controller_sr    0b00000000)) ;249
        end
        else begin
            if (byte_controller_ld) begin
                $display(";A 250");		//(assert (= byte_controller_ld    0b1)) ;250
                byte_controller_sr <= #1 txr; $display(";A 252");		//(assert (= byte_controller_sr    txr )) ;252
            end
            else begin
                $display(";A 251");		//(assert (= byte_controller_ld    0b0)) ;251
                if (byte_controller_shift) begin
                    $display(";A 253");		//(assert (= byte_controller_shift    0b1)) ;253
                    byte_controller_sr <= #1 {byte_controller_sr[6:0], byte_controller_bit_controller_dout}; $display(";A 255");		//(assert (= byte_controller_sr    (bv-concat (bv-extract 6 0 byte_controller_sr ) byte_controller_bit_controller_dout ))) ;255
                end
                else begin
                    $display(";A 254");		//(assert (= byte_controller_shift    0b0)) ;254
                end
            end
        end
    end

    // Following code segment is generated from flattened.v:568
    always @(posedge wb_clk_i or negedge rst_i) begin
        if ((!rst_i)) begin
            byte_controller_dcnt <= #1 3'b000; $display(";A 258");		//(assert (= byte_controller_dcnt    0b000)) ;258
        end
        else begin
            if (byte_controller_ld) begin
                $display(";A 259");		//(assert (= byte_controller_ld    0b1)) ;259
                byte_controller_dcnt <= #1 3'b111; $display(";A 261");		//(assert (= byte_controller_dcnt    0b111)) ;261
            end
            else begin
                $display(";A 260");		//(assert (= byte_controller_ld    0b0)) ;260
                if (byte_controller_shift) begin
                    $display(";A 262");		//(assert (= byte_controller_shift    0b1)) ;262
                    byte_controller_dcnt <= #1 (byte_controller_dcnt - 3'b001); $display(";A 264");		//(assert (= byte_controller_dcnt    (bv-sub byte_controller_dcnt  0b001))) ;264
                end
                else begin
                    $display(";A 263");		//(assert (= byte_controller_shift    0b0)) ;263
                end
            end
        end
    end

    // Following code segment is generated from flattened.v:589
    always @(posedge wb_clk_i or negedge rst_i) begin
        if ((!rst_i)) begin
            byte_controller_core_cmd <= #1 4'b0000; $display(";A 267");		//(assert (= byte_controller_core_cmd    0b0000)) ;267
            byte_controller_core_txd <= #1 1'b0; $display(";A 268");		//(assert (= byte_controller_core_txd    0b0)) ;268
            byte_controller_shift <= #1 1'b0; $display(";A 269");		//(assert (= byte_controller_shift    0b0)) ;269
            byte_controller_ld <= #1 1'b0; $display(";A 270");		//(assert (= byte_controller_ld    0b0)) ;270
            byte_controller_cmd_ack <= #1 1'b0; $display(";A 271");		//(assert (= byte_controller_cmd_ack    0b0)) ;271
            byte_controller_c_state <= #1 5'b00000; $display(";A 272");		//(assert (= byte_controller_c_state    0b00000)) ;272
            byte_controller_ack_out <= #1 1'b0; $display(";A 273");		//(assert (= byte_controller_ack_out    0b0)) ;273
        end
        else begin
            if (byte_controller_bit_controller_al) begin
                $display(";A 274");		//(assert (= byte_controller_bit_controller_al    0b1)) ;274
                byte_controller_core_cmd <= #1 4'b0000; $display(";A 276");		//(assert (= byte_controller_core_cmd    0b0000)) ;276
                byte_controller_core_txd <= #1 1'b0; $display(";A 277");		//(assert (= byte_controller_core_txd    0b0)) ;277
                byte_controller_shift <= #1 1'b0; $display(";A 278");		//(assert (= byte_controller_shift    0b0)) ;278
                byte_controller_ld <= #1 1'b0; $display(";A 279");		//(assert (= byte_controller_ld    0b0)) ;279
                byte_controller_cmd_ack <= #1 1'b0; $display(";A 280");		//(assert (= byte_controller_cmd_ack    0b0)) ;280
                byte_controller_c_state <= #1 5'b00000; $display(";A 281");		//(assert (= byte_controller_c_state    0b00000)) ;281
                byte_controller_ack_out <= #1 1'b0; $display(";A 282");		//(assert (= byte_controller_ack_out    0b0)) ;282
            end
            else begin
                $display(";A 275");		//(assert (= byte_controller_bit_controller_al    0b0)) ;275
                byte_controller_core_txd <= #1 byte_controller_sr[7]; $display(";A 283");		//(assert (= byte_controller_core_txd    (bv-extract 7 7 byte_controller_sr ))) ;283
                byte_controller_shift <= #1 1'b0; $display(";A 284");		//(assert (= byte_controller_shift    0b0)) ;284
                byte_controller_ld <= #1 1'b0; $display(";A 285");		//(assert (= byte_controller_ld    0b0)) ;285
                byte_controller_cmd_ack <= #1 1'b0; $display(";A 286");		//(assert (= byte_controller_cmd_ack    0b0)) ;286
                case (byte_controller_c_state)
                    5'b00000 :
                        begin
                            $display(";A 287");		//(assert (= byte_controller_c_state    0b00000)) ;287
                            if ((((rd | wr) | sto) & (~byte_controller_cmd_ack))) begin
                                $display(";A 288");		//(assert (= (bv-and (bv-or (bv-or rd  wr ) sto ) (bv-not byte_controller_cmd_ack ))   0b1)) ;288
                                if (sta) begin
                                    $display(";A 290");		//(assert (= sta    0b1)) ;290
                                    byte_controller_c_state <= #1 5'b00001; $display(";A 292");		//(assert (= byte_controller_c_state    0b00001)) ;292
                                    byte_controller_core_cmd <= #1 4'b0001; $display(";A 293");		//(assert (= byte_controller_core_cmd    0b0001)) ;293
                                end
                                else begin
                                    $display(";A 291");		//(assert (= sta    0b0)) ;291
                                    if (rd) begin
                                        $display(";A 294");		//(assert (= rd    0b1)) ;294
                                        byte_controller_c_state <= #1 5'b00010; $display(";A 296");		//(assert (= byte_controller_c_state    0b00010)) ;296
                                        byte_controller_core_cmd <= #1 4'b1000; $display(";A 297");		//(assert (= byte_controller_core_cmd    0b1000)) ;297
                                    end
                                    else begin
                                        $display(";A 295");		//(assert (= rd    0b0)) ;295
                                        if (wr) begin
                                            $display(";A 298");		//(assert (= wr    0b1)) ;298
                                            byte_controller_c_state <= #1 5'b00100; $display(";A 300");		//(assert (= byte_controller_c_state    0b00100)) ;300
                                            byte_controller_core_cmd <= #1 4'b0100; $display(";A 301");		//(assert (= byte_controller_core_cmd    0b0100)) ;301
                                        end
                                        else begin
                                            $display(";A 299");		//(assert (= wr    0b0)) ;299
                                            byte_controller_c_state <= #1 5'b10000; $display(";A 302");		//(assert (= byte_controller_c_state    0b10000)) ;302
                                            byte_controller_core_cmd <= #1 4'b0010; $display(";A 303");		//(assert (= byte_controller_core_cmd    0b0010)) ;303
                                        end
                                    end
                                end
                                byte_controller_ld <= #1 1'b1; $display(";A 304");		//(assert (= byte_controller_ld    0b1)) ;304
                            end
                            else begin
                                $display(";A 289");		//(assert (= (bv-and (bv-or (bv-or rd  wr ) sto ) (bv-not byte_controller_cmd_ack ))   0b0)) ;289
                            end
                        end
                    5'b00001 :
                        begin
                            $display(";A 305");		//(assert (= byte_controller_c_state    0b00001)) ;305
                            if (byte_controller_bit_controller_cmd_ack) begin
                                $display(";A 306");		//(assert (= byte_controller_bit_controller_cmd_ack    0b1)) ;306
                                if (rd) begin
                                    $display(";A 308");		//(assert (= rd    0b1)) ;308
                                    byte_controller_c_state <= #1 5'b00010; $display(";A 310");		//(assert (= byte_controller_c_state    0b00010)) ;310
                                    byte_controller_core_cmd <= #1 4'b1000; $display(";A 311");		//(assert (= byte_controller_core_cmd    0b1000)) ;311
                                end
                                else begin
                                    $display(";A 309");		//(assert (= rd    0b0)) ;309
                                    byte_controller_c_state <= #1 5'b00100; $display(";A 312");		//(assert (= byte_controller_c_state    0b00100)) ;312
                                    byte_controller_core_cmd <= #1 4'b0100; $display(";A 313");		//(assert (= byte_controller_core_cmd    0b0100)) ;313
                                end
                                byte_controller_ld <= #1 1'b1; $display(";A 314");		//(assert (= byte_controller_ld    0b1)) ;314
                            end
                            else begin
                                $display(";A 307");		//(assert (= byte_controller_bit_controller_cmd_ack    0b0)) ;307
                            end
                        end
                    5'b00100 :
                        begin
                            $display(";A 315");		//(assert (= byte_controller_c_state    0b00100)) ;315
                            if (byte_controller_bit_controller_cmd_ack) begin
                                $display(";A 316");		//(assert (= byte_controller_bit_controller_cmd_ack    0b1)) ;316
                                if ((~(|byte_controller_dcnt))) begin
                                    $display(";A 318");		//(assert (= (bv-not (bv-redor byte_controller_dcnt ))   0b1)) ;318
                                    byte_controller_c_state <= #1 5'b01000; $display(";A 320");		//(assert (= byte_controller_c_state    0b01000)) ;320
                                    byte_controller_core_cmd <= #1 4'b1000; $display(";A 321");		//(assert (= byte_controller_core_cmd    0b1000)) ;321
                                end
                                else begin
                                    $display(";A 319");		//(assert (= (bv-not (bv-redor byte_controller_dcnt ))   0b0)) ;319
                                    byte_controller_c_state <= #1 5'b00100; $display(";A 322");		//(assert (= byte_controller_c_state    0b00100)) ;322
                                    byte_controller_core_cmd <= #1 4'b0100; $display(";A 323");		//(assert (= byte_controller_core_cmd    0b0100)) ;323
                                    byte_controller_shift <= #1 1'b1; $display(";A 324");		//(assert (= byte_controller_shift    0b1)) ;324
                                end
                            end
                            else begin
                                $display(";A 317");		//(assert (= byte_controller_bit_controller_cmd_ack    0b0)) ;317
                            end
                        end
                    5'b00010 :
                        begin
                            $display(";A 325");		//(assert (= byte_controller_c_state    0b00010)) ;325
                            if (byte_controller_bit_controller_cmd_ack) begin
                                $display(";A 326");		//(assert (= byte_controller_bit_controller_cmd_ack    0b1)) ;326
                                if ((~(|byte_controller_dcnt))) begin
                                    $display(";A 328");		//(assert (= (bv-not (bv-redor byte_controller_dcnt ))   0b1)) ;328
                                    byte_controller_c_state <= #1 5'b01000; $display(";A 330");		//(assert (= byte_controller_c_state    0b01000)) ;330
                                    byte_controller_core_cmd <= #1 4'b0100; $display(";A 331");		//(assert (= byte_controller_core_cmd    0b0100)) ;331
                                end
                                else begin
                                    $display(";A 329");		//(assert (= (bv-not (bv-redor byte_controller_dcnt ))   0b0)) ;329
                                    byte_controller_c_state <= #1 5'b00010; $display(";A 332");		//(assert (= byte_controller_c_state    0b00010)) ;332
                                    byte_controller_core_cmd <= #1 4'b1000; $display(";A 333");		//(assert (= byte_controller_core_cmd    0b1000)) ;333
                                end
                                byte_controller_shift <= #1 1'b1; $display(";A 334");		//(assert (= byte_controller_shift    0b1)) ;334
                                byte_controller_core_txd <= #1 ack; $display(";A 335");		//(assert (= byte_controller_core_txd    ack )) ;335
                            end
                            else begin
                                $display(";A 327");		//(assert (= byte_controller_bit_controller_cmd_ack    0b0)) ;327
                            end
                        end
                    5'b01000 :
                        begin
                            $display(";A 336");		//(assert (= byte_controller_c_state    0b01000)) ;336
                            if (byte_controller_bit_controller_cmd_ack) begin
                                $display(";A 337");		//(assert (= byte_controller_bit_controller_cmd_ack    0b1)) ;337
                                if (sto) begin
                                    $display(";A 339");		//(assert (= sto    0b1)) ;339
                                    byte_controller_c_state <= #1 5'b10000; $display(";A 341");		//(assert (= byte_controller_c_state    0b10000)) ;341
                                    byte_controller_core_cmd <= #1 4'b0010; $display(";A 342");		//(assert (= byte_controller_core_cmd    0b0010)) ;342
                                end
                                else begin
                                    $display(";A 340");		//(assert (= sto    0b0)) ;340
                                    byte_controller_c_state <= #1 5'b00000; $display(";A 343");		//(assert (= byte_controller_c_state    0b00000)) ;343
                                    byte_controller_core_cmd <= #1 4'b0000; $display(";A 344");		//(assert (= byte_controller_core_cmd    0b0000)) ;344
                                    byte_controller_cmd_ack <= #1 1'b1; $display(";A 345");		//(assert (= byte_controller_cmd_ack    0b1)) ;345
                                end
                                byte_controller_ack_out <= #1 byte_controller_bit_controller_dout; $display(";A 346");		//(assert (= byte_controller_ack_out    byte_controller_bit_controller_dout )) ;346
                                byte_controller_core_txd <= #1 1'b1; $display(";A 347");		//(assert (= byte_controller_core_txd    0b1)) ;347
                            end
                            else begin
                                $display(";A 338");		//(assert (= byte_controller_bit_controller_cmd_ack    0b0)) ;338
                                byte_controller_core_txd <= #1 ack; $display(";A 348");		//(assert (= byte_controller_core_txd    ack )) ;348
                            end
                        end
                    5'b10000 :
                        begin
                            $display(";A 349");		//(assert (= byte_controller_c_state    0b10000)) ;349
                            if (byte_controller_bit_controller_cmd_ack) begin
                                $display(";A 350");		//(assert (= byte_controller_bit_controller_cmd_ack    0b1)) ;350
                                byte_controller_c_state <= #1 5'b00000; $display(";A 352");		//(assert (= byte_controller_c_state    0b00000)) ;352
                                byte_controller_core_cmd <= #1 4'b0000; $display(";A 353");		//(assert (= byte_controller_core_cmd    0b0000)) ;353
                                byte_controller_cmd_ack <= #1 1'b1; $display(";A 354");		//(assert (= byte_controller_cmd_ack    0b1)) ;354
                            end
                            else begin
                                $display(";A 351");		//(assert (= byte_controller_bit_controller_cmd_ack    0b0)) ;351
                            end
                        end
                endcase
            end
        end
    end

endmodule

