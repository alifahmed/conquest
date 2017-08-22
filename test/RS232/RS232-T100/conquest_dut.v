// Following code segment is generated from flattened.v:1
module uart(sys_clk, sys_rst_l, uart_XMIT_dataH, xmitH, xmit_dataH, xmit_doneH, uart_REC_dataH, rec_dataH, rec_readyH, __obs);
    input sys_clk;
    input sys_rst_l;
    output uart_XMIT_dataH;
    input xmitH;
    input [7:0] xmit_dataH;
    output xmit_doneH;
    input uart_REC_dataH;
    output [7:0] rec_dataH;
    output rec_readyH;
    input __obs;

    reg [3:0] iRECEIVER_bitCell_cntrH = 4'b0;
    reg iRECEIVER_cntr_resetH = 1'b0;
    reg iRECEIVER_countH = 1'b0;
    reg [2:0] iRECEIVER_next_state = 3'b0;
    reg [7:0] iRECEIVER_par_dataH = 8'b0;
    reg iRECEIVER_rec_datH = 1'b0;
    reg iRECEIVER_rec_datSyncH = 1'b0;
    reg [7:0] iRECEIVER_rec_dataH = 8'b0;
    reg iRECEIVER_rec_readyH = 1'b0;
    reg iRECEIVER_rec_readyH_temp = 1'b0;
    reg iRECEIVER_rec_readyInH = 1'b0;
    reg [3:0] iRECEIVER_recd_bitCntrH = 4'b0;
    reg iRECEIVER_rstCountH = 1'b0;
    reg iRECEIVER_shiftH = 1'b0;
    reg [2:0] iRECEIVER_state = 3'b0;
    reg [3:0] iXMIT_bitCell_cntrH = 4'b0;
    reg [3:0] iXMIT_bitCountH = 4'b0;
    reg iXMIT_countEnaH = 1'b0;
    reg iXMIT_ena_bitCountH = 1'b0;
    reg iXMIT_load_shiftRegH = 1'b0;
    reg [2:0] iXMIT_next_state = 3'b0;
    reg iXMIT_rst_bitCountH = 1'b0;
    reg iXMIT_shiftEnaH = 1'b0;
    reg [2:0] iXMIT_state = 3'b0;
    reg iXMIT_uart_xmitH = 1'b0;
    reg [1:0] iXMIT_xmitDataSelH = 2'b0;
    reg [7:0] iXMIT_xmit_ShiftRegH = 8'b0;
    reg iXMIT_xmit_doneH = 1'b0;
    reg iXMIT_xmit_doneInH = 1'b0;
    reg [7:0] rec_dataH = 8'b0;
    reg [7:0] rec_dataH_temp = 8'b0;
    reg rec_readyH = 1'b0;
    reg uart_XMIT_dataH = 1'b0;
    reg xmit_doneH = 1'b0;

    always @(*) begin
        uart_XMIT_dataH = iXMIT_uart_xmitH; $display(";A 0");		//(assert (= uart_XMIT_dataH    iXMIT_uart_xmitH )) ;0
    end

    always @(*) begin
        xmit_doneH = iXMIT_xmit_doneH; $display(";A 1");		//(assert (= xmit_doneH    iXMIT_xmit_doneH )) ;1
    end

    always @(*) begin
        rec_readyH = iRECEIVER_rec_readyH; $display(";A 2");		//(assert (= rec_readyH    iRECEIVER_rec_readyH )) ;2
    end

    always @(*) begin
        iRECEIVER_rec_dataH = iRECEIVER_par_dataH; $display(";A 3");		//(assert (= iRECEIVER_rec_dataH    iRECEIVER_par_dataH )) ;3
    end

    // Following code segment is generated from flattened.v:133
    always @(posedge sys_clk or negedge sys_rst_l) begin
        if ((~sys_rst_l)) begin
            rec_dataH <= #1 8'b00000000; $display(";A 6");		//(assert (= rec_dataH    0b00000000)) ;6
        end
        else begin
            rec_dataH <= #1 rec_dataH_temp; $display(";A 7");		//(assert (= rec_dataH    rec_dataH_temp )) ;7
        end
    end

    // Following code segment is generated from flattened.v:144
    always @(posedge sys_clk or negedge sys_rst_l) begin
        if ((~sys_rst_l)) begin
            rec_dataH_temp <= #1 8'b00000000; $display(";A 10");		//(assert (= rec_dataH_temp    0b00000000)) ;10
        end
        else begin
            if (rec_readyH) begin
                $display(";A 11");		//(assert (= rec_readyH    0b1)) ;11
                rec_dataH_temp <= #1 iRECEIVER_rec_dataH; $display(";A 13");		//(assert (= rec_dataH_temp    iRECEIVER_rec_dataH )) ;13
            end
            else begin
                $display(";A 12");		//(assert (= rec_readyH    0b0)) ;12
            end
        end
    end

    // Following code segment is generated from flattened.v:160
    always @(iXMIT_xmitDataSelH or iXMIT_xmit_ShiftRegH or __obs) begin
        case (iXMIT_xmitDataSelH)
            2'b00 :
                begin
                    $display(";A 14");		//(assert (= iXMIT_xmitDataSelH    0b00)) ;14
                    iXMIT_uart_xmitH = 1'b0; $display(";A 15");		//(assert (= iXMIT_uart_xmitH    0b0)) ;15
                end
            2'b01 :
                begin
                    $display(";A 16");		//(assert (= iXMIT_xmitDataSelH    0b01)) ;16
                    iXMIT_uart_xmitH = 1'b1; $display(";A 17");		//(assert (= iXMIT_uart_xmitH    0b1)) ;17
                end
            2'b10 :
                begin
                    $display(";A 18");		//(assert (= iXMIT_xmitDataSelH    0b10)) ;18
                    iXMIT_uart_xmitH = iXMIT_xmit_ShiftRegH[0]; $display(";A 19");		//(assert (= iXMIT_uart_xmitH    (bv-extract 0 0 iXMIT_xmit_ShiftRegH ))) ;19
                end
        endcase
    end

    // Following code segment is generated from flattened.v:177
    always @(posedge sys_clk or negedge sys_rst_l) begin
        if ((~sys_rst_l)) begin
            iXMIT_bitCell_cntrH <= #1 4'b0000; $display(";A 22");		//(assert (= iXMIT_bitCell_cntrH    0b0000)) ;22
        end
        else begin
            if (iXMIT_countEnaH) begin
                $display(";A 23");		//(assert (= iXMIT_countEnaH    0b1)) ;23
                iXMIT_bitCell_cntrH <= #1 (iXMIT_bitCell_cntrH + 4'b0001); $display(";A 25");		//(assert (= iXMIT_bitCell_cntrH    (bv-add iXMIT_bitCell_cntrH  0b0001))) ;25
            end
            else begin
                $display(";A 24");		//(assert (= iXMIT_countEnaH    0b0)) ;24
                iXMIT_bitCell_cntrH <= #1 4'b0000; $display(";A 26");		//(assert (= iXMIT_bitCell_cntrH    0b0000)) ;26
            end
        end
    end

    // Following code segment is generated from flattened.v:195
    always @(posedge sys_clk or negedge sys_rst_l) begin
        if ((~sys_rst_l)) begin
            iXMIT_xmit_ShiftRegH <= #1 8'b00000000; $display(";A 29");		//(assert (= iXMIT_xmit_ShiftRegH    0b00000000)) ;29
        end
        else begin
            if (iXMIT_load_shiftRegH) begin
                $display(";A 30");		//(assert (= iXMIT_load_shiftRegH    0b1)) ;30
                iXMIT_xmit_ShiftRegH <= #1 xmit_dataH; $display(";A 32");		//(assert (= iXMIT_xmit_ShiftRegH    xmit_dataH )) ;32
            end
            else begin
                $display(";A 31");		//(assert (= iXMIT_load_shiftRegH    0b0)) ;31
                if (iXMIT_shiftEnaH) begin
                    $display(";A 33");		//(assert (= iXMIT_shiftEnaH    0b1)) ;33
                    iXMIT_xmit_ShiftRegH <= #1 {1'b1, iXMIT_xmit_ShiftRegH[7:1]}; $display(";A 35");		//(assert (= iXMIT_xmit_ShiftRegH    (bv-concat 0b1 (bv-extract 7 1 iXMIT_xmit_ShiftRegH )))) ;35
                end
                else begin
                    $display(";A 34");		//(assert (= iXMIT_shiftEnaH    0b0)) ;34
                    iXMIT_xmit_ShiftRegH <= #1 iXMIT_xmit_ShiftRegH; $display(";A 36");		//(assert (= iXMIT_xmit_ShiftRegH    iXMIT_xmit_ShiftRegH )) ;36
                end
            end
        end
    end

    // Following code segment is generated from flattened.v:220
    always @(posedge sys_clk or negedge sys_rst_l) begin
        if ((~sys_rst_l)) begin
            iXMIT_bitCountH <= #1 4'b0000; $display(";A 39");		//(assert (= iXMIT_bitCountH    0b0000)) ;39
        end
        else begin
            if (iXMIT_rst_bitCountH) begin
                $display(";A 40");		//(assert (= iXMIT_rst_bitCountH    0b1)) ;40
                iXMIT_bitCountH <= #1 4'b0000; $display(";A 42");		//(assert (= iXMIT_bitCountH    0b0000)) ;42
            end
            else begin
                $display(";A 41");		//(assert (= iXMIT_rst_bitCountH    0b0)) ;41
                if (iXMIT_ena_bitCountH) begin
                    $display(";A 43");		//(assert (= iXMIT_ena_bitCountH    0b1)) ;43
                    iXMIT_bitCountH <= #1 (iXMIT_bitCountH + 4'b0001); $display(";A 45");		//(assert (= iXMIT_bitCountH    (bv-add iXMIT_bitCountH  0b0001))) ;45
                end
                else begin
                    $display(";A 44");		//(assert (= iXMIT_ena_bitCountH    0b0)) ;44
                end
            end
        end
    end

    // Following code segment is generated from flattened.v:241
    always @(posedge sys_clk or negedge sys_rst_l) begin
        if ((~sys_rst_l)) begin
            iXMIT_state <= #1 3'b000; $display(";A 48");		//(assert (= iXMIT_state    0b000)) ;48
        end
        else begin
            iXMIT_state <= #1 iXMIT_next_state; $display(";A 49");		//(assert (= iXMIT_state    iXMIT_next_state )) ;49
        end
    end

    // Following code segment is generated from flattened.v:252
    always @(iXMIT_bitCountH or iXMIT_bitCell_cntrH or xmitH or iXMIT_state or __obs) begin
        iXMIT_next_state = iXMIT_state; $display(";A 50");		//(assert (= iXMIT_next_state    iXMIT_state )) ;50
        iXMIT_load_shiftRegH = 1'b0; $display(";A 51");		//(assert (= iXMIT_load_shiftRegH    0b0)) ;51
        iXMIT_countEnaH = 1'b0; $display(";A 52");		//(assert (= iXMIT_countEnaH    0b0)) ;52
        iXMIT_shiftEnaH = 1'b0; $display(";A 53");		//(assert (= iXMIT_shiftEnaH    0b0)) ;53
        iXMIT_rst_bitCountH = 1'b0; $display(";A 54");		//(assert (= iXMIT_rst_bitCountH    0b0)) ;54
        iXMIT_ena_bitCountH = 1'b0; $display(";A 55");		//(assert (= iXMIT_ena_bitCountH    0b0)) ;55
        iXMIT_xmitDataSelH = 2'b01; $display(";A 56");		//(assert (= iXMIT_xmitDataSelH    0b01)) ;56
        iXMIT_xmit_doneInH = 1'b0; $display(";A 57");		//(assert (= iXMIT_xmit_doneInH    0b0)) ;57
        case (iXMIT_state)
            3'b000 :
                begin
                    $display(";A 58");		//(assert (= iXMIT_state    0b000)) ;58
                    if (xmitH) begin
                        $display(";A 59");		//(assert (= xmitH    0b1)) ;59
                        iXMIT_next_state = 3'b010; $display(";A 61");		//(assert (= iXMIT_next_state    0b010)) ;61
                        iXMIT_load_shiftRegH = 1'b1; $display(";A 62");		//(assert (= iXMIT_load_shiftRegH    0b1)) ;62
                    end
                    else begin
                        $display(";A 60");		//(assert (= xmitH    0b0)) ;60
                        iXMIT_next_state = 3'b000; $display(";A 63");		//(assert (= iXMIT_next_state    0b000)) ;63
                        iXMIT_rst_bitCountH = 1'b1; $display(";A 64");		//(assert (= iXMIT_rst_bitCountH    0b1)) ;64
                        iXMIT_xmit_doneInH = 1'b1; $display(";A 65");		//(assert (= iXMIT_xmit_doneInH    0b1)) ;65
                    end
                end
            3'b010 :
                begin
                    $display(";A 66");		//(assert (= iXMIT_state    0b010)) ;66
                    iXMIT_xmitDataSelH = 2'b00; $display(";A 67");		//(assert (= iXMIT_xmitDataSelH    0b00)) ;67
                    if ((iXMIT_bitCell_cntrH == 4'b1111)) begin
                        $display(";A 68");		//(assert (= (bv-comp iXMIT_bitCell_cntrH  0b1111)   0b1)) ;68
                        iXMIT_next_state = 3'b011; $display(";A 70");		//(assert (= iXMIT_next_state    0b011)) ;70
                    end
                    else begin
                        $display(";A 69");		//(assert (= (bv-comp iXMIT_bitCell_cntrH  0b1111)   0b0)) ;69
                        iXMIT_next_state = 3'b010; $display(";A 71");		//(assert (= iXMIT_next_state    0b010)) ;71
                        iXMIT_countEnaH = 1'b1; $display(";A 72");		//(assert (= iXMIT_countEnaH    0b1)) ;72
                    end
                end
            3'b011 :
                begin
                    $display(";A 73");		//(assert (= iXMIT_state    0b011)) ;73
                    iXMIT_xmitDataSelH = 2'b10; $display(";A 74");		//(assert (= iXMIT_xmitDataSelH    0b10)) ;74
                    if ((iXMIT_bitCell_cntrH == 4'b1110)) begin
                        $display(";A 75");		//(assert (= (bv-comp iXMIT_bitCell_cntrH  0b1110)   0b1)) ;75
                        if ((iXMIT_bitCountH == 4'b1000)) begin
                            $display(";A 77");		//(assert (= (bv-comp iXMIT_bitCountH  0b1000)   0b1)) ;77
                            iXMIT_next_state = 3'b101; $display(";A 79");		//(assert (= iXMIT_next_state    0b101)) ;79
                        end
                        else begin
                            $display(";A 78");		//(assert (= (bv-comp iXMIT_bitCountH  0b1000)   0b0)) ;78
                            iXMIT_next_state = 3'b100; $display(";A 80");		//(assert (= iXMIT_next_state    0b100)) ;80
                            iXMIT_ena_bitCountH = 1'b1; $display(";A 81");		//(assert (= iXMIT_ena_bitCountH    0b1)) ;81
                        end
                    end
                    else begin
                        $display(";A 76");		//(assert (= (bv-comp iXMIT_bitCell_cntrH  0b1110)   0b0)) ;76
                        iXMIT_next_state = 3'b011; $display(";A 82");		//(assert (= iXMIT_next_state    0b011)) ;82
                        iXMIT_countEnaH = 1'b1; $display(";A 83");		//(assert (= iXMIT_countEnaH    0b1)) ;83
                    end
                end
            3'b100 :
                begin
                    $display(";A 84");		//(assert (= iXMIT_state    0b100)) ;84
                    iXMIT_xmitDataSelH = 2'b10; $display(";A 85");		//(assert (= iXMIT_xmitDataSelH    0b10)) ;85
                    iXMIT_next_state = 3'b011; $display(";A 86");		//(assert (= iXMIT_next_state    0b011)) ;86
                    iXMIT_shiftEnaH = 1'b1; $display(";A 87");		//(assert (= iXMIT_shiftEnaH    0b1)) ;87
                end
            3'b101 :
                begin
                    $display(";A 88");		//(assert (= iXMIT_state    0b101)) ;88
                    iXMIT_xmitDataSelH = 2'b01; $display(";A 89");		//(assert (= iXMIT_xmitDataSelH    0b01)) ;89
                    if ((iXMIT_bitCell_cntrH == 4'b1111)) begin
                        $display(";A 90");		//(assert (= (bv-comp iXMIT_bitCell_cntrH  0b1111)   0b1)) ;90
                        iXMIT_next_state = 3'b000; $display(";A 92");		//(assert (= iXMIT_next_state    0b000)) ;92
                        iXMIT_xmit_doneInH = 1'b1; $display(";A 93");		//(assert (= iXMIT_xmit_doneInH    0b1)) ;93
                    end
                    else begin
                        $display(";A 91");		//(assert (= (bv-comp iXMIT_bitCell_cntrH  0b1111)   0b0)) ;91
                        iXMIT_next_state = 3'b101; $display(";A 94");		//(assert (= iXMIT_next_state    0b101)) ;94
                        iXMIT_countEnaH = 1'b1; $display(";A 95");		//(assert (= iXMIT_countEnaH    0b1)) ;95
                    end
                end
        endcase
    end

    // Following code segment is generated from flattened.v:333
    always @(posedge sys_clk or negedge sys_rst_l) begin
        if ((~sys_rst_l)) begin
            iXMIT_xmit_doneH <= #1 1'b0; $display(";A 98");		//(assert (= iXMIT_xmit_doneH    0b0)) ;98
        end
        else begin
            iXMIT_xmit_doneH <= #1 iXMIT_xmit_doneInH; $display(";A 99");		//(assert (= iXMIT_xmit_doneH    iXMIT_xmit_doneInH )) ;99
        end
    end

    // Following code segment is generated from flattened.v:346
    always @(iRECEIVER_rec_dataH or iRECEIVER_bitCell_cntrH or iRECEIVER_recd_bitCntrH or iRECEIVER_state or iRECEIVER_rec_readyH_temp or __obs) begin
        if ((((((((((iRECEIVER_rec_dataH[0] & iRECEIVER_rec_dataH[1]) & iRECEIVER_rec_dataH[2]) & iRECEIVER_rec_dataH[3]) & iRECEIVER_rec_dataH[4]) & iRECEIVER_rec_dataH[5]) & iRECEIVER_rec_dataH[6]) & iRECEIVER_rec_dataH[7]) & ((((((((~iRECEIVER_bitCell_cntrH[0]) & iRECEIVER_bitCell_cntrH[1]) & iRECEIVER_bitCell_cntrH[2]) & iRECEIVER_bitCell_cntrH[3]) & iRECEIVER_recd_bitCntrH[0]) & iRECEIVER_recd_bitCntrH[1]) & (~iRECEIVER_recd_bitCntrH[2])) & (~iRECEIVER_recd_bitCntrH[3]))) & ((iRECEIVER_state[0] & iRECEIVER_state[1]) & (~iRECEIVER_state[2])))) begin
            $display(";A 100");		//(assert (= (bv-and (bv-and (bv-and (bv-and (bv-and (bv-and (bv-and (bv-and (bv-and (bv-extract 0 0 iRECEIVER_rec_dataH ) (bv-extract 1 1 iRECEIVER_rec_dataH )) (bv-extract 2 2 iRECEIVER_rec_dataH )) (bv-extract 3 3 iRECEIVER_rec_dataH )) (bv-extract 4 4 iRECEIVER_rec_dataH )) (bv-extract 5 5 iRECEIVER_rec_dataH )) (bv-extract 6 6 iRECEIVER_rec_dataH )) (bv-extract 7 7 iRECEIVER_rec_dataH )) (bv-and (bv-and (bv-and (bv-and (bv-and (bv-and (bv-and (bv-not (bv-extract 0 0 iRECEIVER_bitCell_cntrH )) (bv-extract 1 1 iRECEIVER_bitCell_cntrH )) (bv-extract 2 2 iRECEIVER_bitCell_cntrH )) (bv-extract 3 3 iRECEIVER_bitCell_cntrH )) (bv-extract 0 0 iRECEIVER_recd_bitCntrH )) (bv-extract 1 1 iRECEIVER_recd_bitCntrH )) (bv-not (bv-extract 2 2 iRECEIVER_recd_bitCntrH ))) (bv-not (bv-extract 3 3 iRECEIVER_recd_bitCntrH )))) (bv-and (bv-and (bv-extract 0 0 iRECEIVER_state ) (bv-extract 1 1 iRECEIVER_state )) (bv-not (bv-extract 2 2 iRECEIVER_state ))))   0b1)) ;100
            iRECEIVER_rec_readyH = 1'b0; $display(";A 102");		//(assert (= iRECEIVER_rec_readyH    0b0)) ;102
        end
        else begin
            $display(";A 101");		//(assert (= (bv-and (bv-and (bv-and (bv-and (bv-and (bv-and (bv-and (bv-and (bv-and (bv-extract 0 0 iRECEIVER_rec_dataH ) (bv-extract 1 1 iRECEIVER_rec_dataH )) (bv-extract 2 2 iRECEIVER_rec_dataH )) (bv-extract 3 3 iRECEIVER_rec_dataH )) (bv-extract 4 4 iRECEIVER_rec_dataH )) (bv-extract 5 5 iRECEIVER_rec_dataH )) (bv-extract 6 6 iRECEIVER_rec_dataH )) (bv-extract 7 7 iRECEIVER_rec_dataH )) (bv-and (bv-and (bv-and (bv-and (bv-and (bv-and (bv-and (bv-not (bv-extract 0 0 iRECEIVER_bitCell_cntrH )) (bv-extract 1 1 iRECEIVER_bitCell_cntrH )) (bv-extract 2 2 iRECEIVER_bitCell_cntrH )) (bv-extract 3 3 iRECEIVER_bitCell_cntrH )) (bv-extract 0 0 iRECEIVER_recd_bitCntrH )) (bv-extract 1 1 iRECEIVER_recd_bitCntrH )) (bv-not (bv-extract 2 2 iRECEIVER_recd_bitCntrH ))) (bv-not (bv-extract 3 3 iRECEIVER_recd_bitCntrH )))) (bv-and (bv-and (bv-extract 0 0 iRECEIVER_state ) (bv-extract 1 1 iRECEIVER_state )) (bv-not (bv-extract 2 2 iRECEIVER_state ))))   0b0)) ;101
            iRECEIVER_rec_readyH = iRECEIVER_rec_readyH_temp; $display(";A 103");		//(assert (= iRECEIVER_rec_readyH    iRECEIVER_rec_readyH_temp )) ;103
        end
    end

    // Following code segment is generated from flattened.v:357
    always @(posedge sys_clk or negedge sys_rst_l) begin
        if ((~sys_rst_l)) begin
            iRECEIVER_rec_datSyncH <= #1 1'b1; $display(";A 106");		//(assert (= iRECEIVER_rec_datSyncH    0b1)) ;106
            iRECEIVER_rec_datH <= #1 1'b1; $display(";A 107");		//(assert (= iRECEIVER_rec_datH    0b1)) ;107
        end
        else begin
            iRECEIVER_rec_datSyncH <= #1 uart_REC_dataH; $display(";A 108");		//(assert (= iRECEIVER_rec_datSyncH    uart_REC_dataH )) ;108
            iRECEIVER_rec_datH <= #1 iRECEIVER_rec_datSyncH; $display(";A 109");		//(assert (= iRECEIVER_rec_datH    iRECEIVER_rec_datSyncH )) ;109
        end
    end

    // Following code segment is generated from flattened.v:370
    always @(posedge sys_clk or negedge sys_rst_l) begin
        if ((~sys_rst_l)) begin
            iRECEIVER_bitCell_cntrH <= #1 4'b0000; $display(";A 112");		//(assert (= iRECEIVER_bitCell_cntrH    0b0000)) ;112
        end
        else begin
            if (iRECEIVER_cntr_resetH) begin
                $display(";A 113");		//(assert (= iRECEIVER_cntr_resetH    0b1)) ;113
                iRECEIVER_bitCell_cntrH <= #1 4'b0000; $display(";A 115");		//(assert (= iRECEIVER_bitCell_cntrH    0b0000)) ;115
            end
            else begin
                $display(";A 114");		//(assert (= iRECEIVER_cntr_resetH    0b0)) ;114
                iRECEIVER_bitCell_cntrH <= #1 (iRECEIVER_bitCell_cntrH + 4'b0001); $display(";A 116");		//(assert (= iRECEIVER_bitCell_cntrH    (bv-add iRECEIVER_bitCell_cntrH  0b0001))) ;116
            end
        end
    end

    // Following code segment is generated from flattened.v:388
    always @(posedge sys_clk or negedge sys_rst_l) begin
        if ((~sys_rst_l)) begin
            iRECEIVER_par_dataH <= #1 8'b00000000; $display(";A 119");		//(assert (= iRECEIVER_par_dataH    0b00000000)) ;119
        end
        else begin
            if (iRECEIVER_shiftH) begin
                $display(";A 120");		//(assert (= iRECEIVER_shiftH    0b1)) ;120
                iRECEIVER_par_dataH <= #1 {iRECEIVER_rec_datH, iRECEIVER_par_dataH[7:1]}; $display(";A 122");		//(assert (= iRECEIVER_par_dataH    (bv-concat iRECEIVER_rec_datH  (bv-extract 7 1 iRECEIVER_par_dataH )))) ;122
            end
            else begin
                $display(";A 121");		//(assert (= iRECEIVER_shiftH    0b0)) ;121
            end
        end
    end

    // Following code segment is generated from flattened.v:402
    always @(posedge sys_clk or negedge sys_rst_l) begin
        if ((~sys_rst_l)) begin
            iRECEIVER_recd_bitCntrH <= #1 4'b0000; $display(";A 125");		//(assert (= iRECEIVER_recd_bitCntrH    0b0000)) ;125
        end
        else begin
            if (iRECEIVER_countH) begin
                $display(";A 126");		//(assert (= iRECEIVER_countH    0b1)) ;126
                iRECEIVER_recd_bitCntrH <= #1 (iRECEIVER_recd_bitCntrH + 4'b0001); $display(";A 128");		//(assert (= iRECEIVER_recd_bitCntrH    (bv-add iRECEIVER_recd_bitCntrH  0b0001))) ;128
            end
            else begin
                $display(";A 127");		//(assert (= iRECEIVER_countH    0b0)) ;127
                if (iRECEIVER_rstCountH) begin
                    $display(";A 129");		//(assert (= iRECEIVER_rstCountH    0b1)) ;129
                    iRECEIVER_recd_bitCntrH <= #1 4'b0000; $display(";A 131");		//(assert (= iRECEIVER_recd_bitCntrH    0b0000)) ;131
                end
                else begin
                    $display(";A 130");		//(assert (= iRECEIVER_rstCountH    0b0)) ;130
                end
            end
        end
    end

    // Following code segment is generated from flattened.v:423
    always @(posedge sys_clk or negedge sys_rst_l) begin
        if ((~sys_rst_l)) begin
            iRECEIVER_state <= #1 3'b001; $display(";A 134");		//(assert (= iRECEIVER_state    0b001)) ;134
        end
        else begin
            iRECEIVER_state <= #1 iRECEIVER_next_state; $display(";A 135");		//(assert (= iRECEIVER_state    iRECEIVER_next_state )) ;135
        end
    end

    // Following code segment is generated from flattened.v:434
    always @(iRECEIVER_recd_bitCntrH or iRECEIVER_bitCell_cntrH or iRECEIVER_rec_datH or iRECEIVER_state or __obs) begin
        iRECEIVER_next_state = iRECEIVER_state; $display(";A 136");		//(assert (= iRECEIVER_next_state    iRECEIVER_state )) ;136
        iRECEIVER_cntr_resetH = 1'b1; $display(";A 137");		//(assert (= iRECEIVER_cntr_resetH    0b1)) ;137
        iRECEIVER_shiftH = 1'b0; $display(";A 138");		//(assert (= iRECEIVER_shiftH    0b0)) ;138
        iRECEIVER_countH = 1'b0; $display(";A 139");		//(assert (= iRECEIVER_countH    0b0)) ;139
        iRECEIVER_rstCountH = 1'b0; $display(";A 140");		//(assert (= iRECEIVER_rstCountH    0b0)) ;140
        iRECEIVER_rec_readyInH = 1'b0; $display(";A 141");		//(assert (= iRECEIVER_rec_readyInH    0b0)) ;141
        case (iRECEIVER_state)
            3'b001 :
                begin
                    $display(";A 142");		//(assert (= iRECEIVER_state    0b001)) ;142
                    if ((~iRECEIVER_rec_datH)) begin
                        $display(";A 143");		//(assert (= (bv-not iRECEIVER_rec_datH )   0b1)) ;143
                        iRECEIVER_next_state = 3'b010; $display(";A 145");		//(assert (= iRECEIVER_next_state    0b010)) ;145
                    end
                    else begin
                        $display(";A 144");		//(assert (= (bv-not iRECEIVER_rec_datH )   0b0)) ;144
                        iRECEIVER_next_state = 3'b001; $display(";A 146");		//(assert (= iRECEIVER_next_state    0b001)) ;146
                        iRECEIVER_rstCountH = 1'b1; $display(";A 147");		//(assert (= iRECEIVER_rstCountH    0b1)) ;147
                        iRECEIVER_rec_readyInH = 1'b1; $display(";A 148");		//(assert (= iRECEIVER_rec_readyInH    0b1)) ;148
                    end
                end
            3'b010 :
                begin
                    $display(";A 149");		//(assert (= iRECEIVER_state    0b010)) ;149
                    if ((iRECEIVER_bitCell_cntrH == 4'b0100)) begin
                        $display(";A 150");		//(assert (= (bv-comp iRECEIVER_bitCell_cntrH  0b0100)   0b1)) ;150
                        if ((~iRECEIVER_rec_datH)) begin
                            $display(";A 152");		//(assert (= (bv-not iRECEIVER_rec_datH )   0b1)) ;152
                            iRECEIVER_next_state = 3'b011; $display(";A 154");		//(assert (= iRECEIVER_next_state    0b011)) ;154
                        end
                        else begin
                            $display(";A 153");		//(assert (= (bv-not iRECEIVER_rec_datH )   0b0)) ;153
                            iRECEIVER_next_state = 3'b001; $display(";A 155");		//(assert (= iRECEIVER_next_state    0b001)) ;155
                        end
                    end
                    else begin
                        $display(";A 151");		//(assert (= (bv-comp iRECEIVER_bitCell_cntrH  0b0100)   0b0)) ;151
                        iRECEIVER_next_state = 3'b010; $display(";A 156");		//(assert (= iRECEIVER_next_state    0b010)) ;156
                        iRECEIVER_cntr_resetH = 1'b0; $display(";A 157");		//(assert (= iRECEIVER_cntr_resetH    0b0)) ;157
                    end
                end
            3'b011 :
                begin
                    $display(";A 158");		//(assert (= iRECEIVER_state    0b011)) ;158
                    if ((iRECEIVER_bitCell_cntrH == 4'b1110)) begin
                        $display(";A 159");		//(assert (= (bv-comp iRECEIVER_bitCell_cntrH  0b1110)   0b1)) ;159
                        if ((iRECEIVER_recd_bitCntrH == 4'b1000)) begin
                            $display(";A 161");		//(assert (= (bv-comp iRECEIVER_recd_bitCntrH  0b1000)   0b1)) ;161
                            iRECEIVER_next_state = 3'b101; $display(";A 163");		//(assert (= iRECEIVER_next_state    0b101)) ;163
                        end
                        else begin
                            $display(";A 162");		//(assert (= (bv-comp iRECEIVER_recd_bitCntrH  0b1000)   0b0)) ;162
                            iRECEIVER_next_state = 3'b100; $display(";A 164");		//(assert (= iRECEIVER_next_state    0b100)) ;164
                        end
                    end
                    else begin
                        $display(";A 160");		//(assert (= (bv-comp iRECEIVER_bitCell_cntrH  0b1110)   0b0)) ;160
                        iRECEIVER_next_state = 3'b011; $display(";A 165");		//(assert (= iRECEIVER_next_state    0b011)) ;165
                        iRECEIVER_cntr_resetH = 1'b0; $display(";A 166");		//(assert (= iRECEIVER_cntr_resetH    0b0)) ;166
                    end
                end
            3'b100 :
                begin
                    $display(";A 167");		//(assert (= iRECEIVER_state    0b100)) ;167
                    iRECEIVER_shiftH = 1'b1; $display(";A 168");		//(assert (= iRECEIVER_shiftH    0b1)) ;168
                    iRECEIVER_countH = 1'b1; $display(";A 169");		//(assert (= iRECEIVER_countH    0b1)) ;169
                    iRECEIVER_next_state = 3'b011; $display(";A 170");		//(assert (= iRECEIVER_next_state    0b011)) ;170
                end
            3'b101 :
                begin
                    $display(";A 171");		//(assert (= iRECEIVER_state    0b101)) ;171
                    iRECEIVER_next_state = 3'b001; $display(";A 172");		//(assert (= iRECEIVER_next_state    0b001)) ;172
                    iRECEIVER_rec_readyInH = 1'b1; $display(";A 173");		//(assert (= iRECEIVER_rec_readyInH    0b1)) ;173
                end
        endcase
    end

    // Following code segment is generated from flattened.v:507
    always @(posedge sys_clk or negedge sys_rst_l) begin
        if ((~sys_rst_l)) begin
            iRECEIVER_rec_readyH_temp <= #1 1'b0; $display(";A 176");		//(assert (= iRECEIVER_rec_readyH_temp    0b0)) ;176
        end
        else begin
            iRECEIVER_rec_readyH_temp <= #1 iRECEIVER_rec_readyInH; $display(";A 177");		//(assert (= iRECEIVER_rec_readyH_temp    iRECEIVER_rec_readyInH )) ;177
        end
    end

endmodule

