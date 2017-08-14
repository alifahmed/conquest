// Following code segment is generated from ./src/b14.v:16
module b14(clock, reset, datai, addr, datao, rd, wr, __obs);
    input clock;
    input reset;
    input [30:0] datai;
    output [19:0] addr;
    output [30:0] datao;
    output rd;
    output wr;
    input __obs;

    reg B = 1'b0;
    reg [30:0] IR = 31'b0;
    reg [19:0] addr = 20'b0;
    reg cf = 1'b0;
    reg [1:0] d = 2'b0;
    reg [30:0] datao = 31'b0;
    reg [2:0] df = 3'b0;
    reg [3:0] ff = 4'b0;
    reg [30:0] m = 31'b0;
    reg [1:0] mf = 2'b0;
    reg rd = 1'b0;
    reg [30:0] reg0 = 31'b0;
    reg [30:0] reg1 = 31'b0;
    reg [30:0] reg2 = 31'b0;
    reg [30:0] reg3 = 31'b0;
    reg [30:0] rx = 31'b0;
    reg [1:0] s = 2'b0;
    reg state = 1'b0;
    reg [30:0] t = 31'b0;
    reg [19:0] tail = 20'b0;
    reg wr = 1'b0;

    always @(*) begin
        mf = IR[28:27]; $display(";A 0");		//(assert (= @mf    (bv-extract 28 27 #IR ))) ;0 BL
    end

    always @(*) begin
        df = IR[26:24]; $display(";A 1");		//(assert (= @df    (bv-extract 26 24 #IR ))) ;1 BL
    end

    always @(*) begin
        ff = IR[22:19]; $display(";A 2");		//(assert (= @ff    (bv-extract 22 19 #IR ))) ;2 BL
    end

    always @(*) begin
        cf = IR[23]; $display(";A 3");		//(assert (= @cf    (bv-extract 23 23 #IR ))) ;3 BL
    end

    always @(*) begin
        tail = IR[19:0]; $display(";A 4");		//(assert (= @tail    (bv-extract 19 0 #IR ))) ;4 BL
    end

    always @(*) begin
        s = IR[30:29]; $display(";A 5");		//(assert (= @s    (bv-extract 30 29 #IR ))) ;5 BL
    end

    // Following code segment is generated from ./src/b14.v:72
    always @(posedge clock) begin
        if ((reset == 1'b1)) begin
            IR <= #1 31'b0000000000000000000000000000000; $display(";A 8");		//(assert (= @IR    0b0000000000000000000000000000000)) ;8 NB
            d <= #1 2'b00; $display(";A 9");		//(assert (= @d    0b00)) ;9 NB
            rx <= #1 31'b0000000000000000000000000000000; $display(";A 10");		//(assert (= @rx    0b0000000000000000000000000000000)) ;10 NB
            m <= #1 31'b0000000000000000000000000000000; $display(";A 11");		//(assert (= @m    0b0000000000000000000000000000000)) ;11 NB
            B <= #1 1'b0; $display(";A 12");		//(assert (= @B    0b0)) ;12 NB
            reg0 <= #1 31'b0000000000000000000000000000000; $display(";A 13");		//(assert (= @reg0    0b0000000000000000000000000000000)) ;13 NB
            reg1 <= #1 31'b0000000000000000000000000000000; $display(";A 14");		//(assert (= @reg1    0b0000000000000000000000000000000)) ;14 NB
            reg2 <= #1 31'b0000000000000000000000000000000; $display(";A 15");		//(assert (= @reg2    0b0000000000000000000000000000000)) ;15 NB
            reg3 <= #1 31'b0000000000000000000000000000000; $display(";A 16");		//(assert (= @reg3    0b0000000000000000000000000000000)) ;16 NB
            addr <= #1 20'b00000000000000000000; $display(";A 17");		//(assert (= @addr    0b00000000000000000000)) ;17 NB
            rd <= #1 1'b0; $display(";A 18");		//(assert (= @rd    0b0)) ;18 NB
            wr <= #1 1'b0; $display(";A 19");		//(assert (= @wr    0b0)) ;19 NB
            datao <= #1 31'b0000000000000000000000000000000; $display(";A 20");		//(assert (= @datao    0b0000000000000000000000000000000)) ;20 NB
            state <= #1 1'b0; $display(";A 21");		//(assert (= @state    0b0)) ;21 NB
        end
        else begin
            case (state)
                1'b0 :
                    begin
                        $display(";A 22");		//(assert (= #state    0b0)) ;22 CS
                        addr <= #1 reg3[19:0]; $display(";A 23");		//(assert (= @addr    (bv-extract 19 0 #reg3 ))) ;23 NB
                        rd <= #1 1'b1; $display(";A 24");		//(assert (= @rd    0b1)) ;24 NB
                        IR <= #1 datai; $display(";A 25");		//(assert (= @IR    #datai )) ;25 NB
                        state <= #1 1'b1; $display(";A 26");		//(assert (= @state    0b1)) ;26 NB
                        case (datai[30:29])
                            2'b00 :
                                begin
                                    $display(";A 27");		//(assert (= (bv-extract 30 29 #datai )   0b00)) ;27 CS
                                    rx <= #1 reg0; $display(";A 28");		//(assert (= @rx    #reg0 )) ;28 NB
                                end
                            2'b01 :
                                begin
                                    $display(";A 29");		//(assert (= (bv-extract 30 29 #datai )   0b01)) ;29 CS
                                    rx <= #1 reg1; $display(";A 30");		//(assert (= @rx    #reg1 )) ;30 NB
                                end
                            2'b10 :
                                begin
                                    $display(";A 31");		//(assert (= (bv-extract 30 29 #datai )   0b10)) ;31 CS
                                    rx <= #1 reg2; $display(";A 32");		//(assert (= @rx    #reg2 )) ;32 NB
                                end
                            2'b11 :
                                begin
                                    $display(";A 33");		//(assert (= (bv-extract 30 29 #datai )   0b11)) ;33 CS
                                    rx <= #1 reg3; $display(";A 34");		//(assert (= @rx    #reg3 )) ;34 NB
                                end
                        endcase
                    end
                1'b1 :
                    begin
                        $display(";A 35");		//(assert (= #state    0b1)) ;35 CS
                        case (cf)
                            1'b1 :
                                begin
                                    $display(";A 36");		//(assert (= #cf    0b1)) ;36 CS
                                    case (mf)
                                        2'b00 :
                                            begin
                                                $display(";A 37");		//(assert (= #mf    0b00)) ;37 CS
                                                m = {11'b00000000000, tail}; $display(";A 38");		//(assert (= @m    (bv-concat 0b00000000000 #tail ))) ;38 BL
                                            end
                                        2'b01 :
                                            begin
                                                $display(";A 39");		//(assert (= #mf    0b01)) ;39 CS
                                                m = datai; $display(";A 40");		//(assert (= @m    #datai )) ;40 BL
                                                addr <= #1 tail; $display(";A 41");		//(assert (= @addr    #tail )) ;41 NB
                                                rd <= #1 1'b1; $display(";A 42");		//(assert (= @rd    0b1)) ;42 NB
                                            end
                                        2'b10 :
                                            begin
                                                $display(";A 43");		//(assert (= #mf    0b10)) ;43 CS
                                                addr <= #1 (tail + reg1[19:0]); $display(";A 44");		//(assert (= @addr    (bv-add #tail  (bv-extract 19 0 #reg1 )))) ;44 NB
                                                rd <= #1 1'b1; $display(";A 45");		//(assert (= @rd    0b1)) ;45 NB
                                                m = datai; $display(";A 46");		//(assert (= @m    #datai )) ;46 BL
                                            end
                                        2'b11 :
                                            begin
                                                $display(";A 47");		//(assert (= #mf    0b11)) ;47 CS
                                                addr <= #1 (tail + reg2[19:0]); $display(";A 48");		//(assert (= @addr    (bv-add #tail  (bv-extract 19 0 #reg2 )))) ;48 NB
                                                rd <= #1 1'b1; $display(";A 49");		//(assert (= @rd    0b1)) ;49 NB
                                                m = datai; $display(";A 50");		//(assert (= @m    #datai )) ;50 BL
                                            end
                                    endcase
                                    case (ff)
                                        4'b0000 :
                                            begin
                                                $display(";A 51");		//(assert (= #ff    0b0000)) ;51 CS
                                                if ((rx < m)) begin
                                                    $display(";A 52");		//(assert (= (bool-to-bv (bv-lt #rx  #m ))   0b1)) ;52 BR
                                                    B <= #1 1'b1; $display(";A 54");		//(assert (= @B    0b1)) ;54 NB
                                                end
                                                else begin
                                                    $display(";A 53");		//(assert (= (bool-to-bv (bv-lt #rx  #m ))   0b0)) ;53 BR
                                                    B <= #1 1'b0; $display(";A 55");		//(assert (= @B    0b0)) ;55 NB
                                                end
                                            end
                                        4'b0001 :
                                            begin
                                                $display(";A 56");		//(assert (= #ff    0b0001)) ;56 CS
                                                if ((rx >= m)) begin
                                                    $display(";A 57");		//(assert (= (bool-to-bv (bv-ge #rx  #m ))   0b1)) ;57 BR
                                                    B <= #1 1'b1; $display(";A 59");		//(assert (= @B    0b1)) ;59 NB
                                                end
                                                else begin
                                                    $display(";A 58");		//(assert (= (bool-to-bv (bv-ge #rx  #m ))   0b0)) ;58 BR
                                                    B <= #1 1'b0; $display(";A 60");		//(assert (= @B    0b0)) ;60 NB
                                                end
                                            end
                                        4'b0010 :
                                            begin
                                                $display(";A 61");		//(assert (= #ff    0b0010)) ;61 CS
                                                if ((rx == m)) begin
                                                    $display(";A 62");		//(assert (= (bv-comp #rx  #m )   0b1)) ;62 BR
                                                    B <= #1 1'b1; $display(";A 64");		//(assert (= @B    0b1)) ;64 NB
                                                end
                                                else begin
                                                    $display(";A 63");		//(assert (= (bv-comp #rx  #m )   0b0)) ;63 BR
                                                    B <= #1 1'b0; $display(";A 65");		//(assert (= @B    0b0)) ;65 NB
                                                end
                                            end
                                        4'b0011 :
                                            begin
                                                $display(";A 66");		//(assert (= #ff    0b0011)) ;66 CS
                                                if ((rx != m)) begin
                                                    $display(";A 67");		//(assert (= (bv-not (bv-comp #rx  #m ))   0b1)) ;67 BR
                                                    B <= #1 1'b1; $display(";A 69");		//(assert (= @B    0b1)) ;69 NB
                                                end
                                                else begin
                                                    $display(";A 68");		//(assert (= (bv-not (bv-comp #rx  #m ))   0b0)) ;68 BR
                                                    B <= #1 1'b0; $display(";A 70");		//(assert (= @B    0b0)) ;70 NB
                                                end
                                            end
                                        4'b0100 :
                                            begin
                                                $display(";A 71");		//(assert (= #ff    0b0100)) ;71 CS
                                                if ((rx <= m)) begin
                                                    $display(";A 72");		//(assert (= (bool-to-bv (bv-le #rx  #m ))   0b1)) ;72 BR
                                                    B <= #1 1'b1; $display(";A 74");		//(assert (= @B    0b1)) ;74 NB
                                                end
                                                else begin
                                                    $display(";A 73");		//(assert (= (bool-to-bv (bv-le #rx  #m ))   0b0)) ;73 BR
                                                    B <= #1 1'b0; $display(";A 75");		//(assert (= @B    0b0)) ;75 NB
                                                end
                                            end
                                        4'b0101 :
                                            begin
                                                $display(";A 76");		//(assert (= #ff    0b0101)) ;76 CS
                                                if ((rx > m)) begin
                                                    $display(";A 77");		//(assert (= (bool-to-bv (bv-gt #rx  #m ))   0b1)) ;77 BR
                                                    B <= #1 1'b1; $display(";A 79");		//(assert (= @B    0b1)) ;79 NB
                                                end
                                                else begin
                                                    $display(";A 78");		//(assert (= (bool-to-bv (bv-gt #rx  #m ))   0b0)) ;78 BR
                                                    B <= #1 1'b0; $display(";A 80");		//(assert (= @B    0b0)) ;80 NB
                                                end
                                            end
                                        4'b0110 :
                                            begin
                                                $display(";A 81");		//(assert (= #ff    0b0110)) ;81 CS
                                                if ((rx > 31'b0111111111111111111111111111111)) begin
                                                    $display(";A 82");		//(assert (= (bool-to-bv (bv-gt #rx  0b0111111111111111111111111111111))   0b1)) ;82 BR
                                                    rx = rx; $display(";A 84");		//(assert (= @rx    #rx )) ;84 BL
                                                end
                                                else begin
                                                    $display(";A 83");		//(assert (= (bool-to-bv (bv-gt #rx  0b0111111111111111111111111111111))   0b0)) ;83 BR
                                                end
                                                if ((rx < m)) begin
                                                    $display(";A 85");		//(assert (= (bool-to-bv (bv-lt #rx  #m ))   0b1)) ;85 BR
                                                    B <= #1 1'b1; $display(";A 87");		//(assert (= @B    0b1)) ;87 NB
                                                end
                                                else begin
                                                    $display(";A 86");		//(assert (= (bool-to-bv (bv-lt #rx  #m ))   0b0)) ;86 BR
                                                    B <= #1 1'b0; $display(";A 88");		//(assert (= @B    0b0)) ;88 NB
                                                end
                                            end
                                        4'b0111 :
                                            begin
                                                $display(";A 89");		//(assert (= #ff    0b0111)) ;89 CS
                                                if ((rx > 31'b0111111111111111111111111111111)) begin
                                                    $display(";A 90");		//(assert (= (bool-to-bv (bv-gt #rx  0b0111111111111111111111111111111))   0b1)) ;90 BR
                                                    rx = rx; $display(";A 92");		//(assert (= @rx    #rx )) ;92 BL
                                                end
                                                else begin
                                                    $display(";A 91");		//(assert (= (bool-to-bv (bv-gt #rx  0b0111111111111111111111111111111))   0b0)) ;91 BR
                                                end
                                                if ((rx >= m)) begin
                                                    $display(";A 93");		//(assert (= (bool-to-bv (bv-ge #rx  #m ))   0b1)) ;93 BR
                                                    B <= #1 1'b1; $display(";A 95");		//(assert (= @B    0b1)) ;95 NB
                                                end
                                                else begin
                                                    $display(";A 94");		//(assert (= (bool-to-bv (bv-ge #rx  #m ))   0b0)) ;94 BR
                                                    B <= #1 1'b0; $display(";A 96");		//(assert (= @B    0b0)) ;96 NB
                                                end
                                            end
                                        4'b1000 :
                                            begin
                                                $display(";A 97");		//(assert (= #ff    0b1000)) ;97 CS
                                                if (((rx < m) || (B == 1'b1))) begin
                                                    $display(";A 98");		//(assert (= (bv-or (bool-to-bv (bv-lt #rx  #m )) (bv-comp #B  0b1))   0b1)) ;98 BR
                                                    B <= #1 1'b1; $display(";A 100");		//(assert (= @B    0b1)) ;100 NB
                                                end
                                                else begin
                                                    $display(";A 99");		//(assert (= (bv-or (bool-to-bv (bv-lt #rx  #m )) (bv-comp #B  0b1))   0b0)) ;99 BR
                                                    B <= #1 1'b0; $display(";A 101");		//(assert (= @B    0b0)) ;101 NB
                                                end
                                            end
                                        4'b1001 :
                                            begin
                                                $display(";A 102");		//(assert (= #ff    0b1001)) ;102 CS
                                                if (((!(rx < m)) || (B == 1'b1))) begin
                                                    $display(";A 103");		//(assert (= (bv-or (bv-not (bv-redor (bool-to-bv (bv-lt #rx  #m )))) (bv-comp #B  0b1))   0b1)) ;103 BR
                                                    B <= #1 1'b1; $display(";A 105");		//(assert (= @B    0b1)) ;105 NB
                                                end
                                                else begin
                                                    $display(";A 104");		//(assert (= (bv-or (bv-not (bv-redor (bool-to-bv (bv-lt #rx  #m )))) (bv-comp #B  0b1))   0b0)) ;104 BR
                                                    B <= #1 1'b0; $display(";A 106");		//(assert (= @B    0b0)) ;106 NB
                                                end
                                            end
                                        4'b1010 :
                                            begin
                                                $display(";A 107");		//(assert (= #ff    0b1010)) ;107 CS
                                                if (((rx == m) || (B == 1'b1))) begin
                                                    $display(";A 108");		//(assert (= (bv-or (bv-comp #rx  #m ) (bv-comp #B  0b1))   0b1)) ;108 BR
                                                    B <= #1 1'b1; $display(";A 110");		//(assert (= @B    0b1)) ;110 NB
                                                end
                                                else begin
                                                    $display(";A 109");		//(assert (= (bv-or (bv-comp #rx  #m ) (bv-comp #B  0b1))   0b0)) ;109 BR
                                                    B <= #1 1'b0; $display(";A 111");		//(assert (= @B    0b0)) ;111 NB
                                                end
                                            end
                                        4'b1011 :
                                            begin
                                                $display(";A 112");		//(assert (= #ff    0b1011)) ;112 CS
                                                if (((!(rx == m)) || (B == 1'b1))) begin
                                                    $display(";A 113");		//(assert (= (bv-or (bv-not (bv-redor (bv-comp #rx  #m ))) (bv-comp #B  0b1))   0b1)) ;113 BR
                                                    B <= #1 1'b1; $display(";A 115");		//(assert (= @B    0b1)) ;115 NB
                                                end
                                                else begin
                                                    $display(";A 114");		//(assert (= (bv-or (bv-not (bv-redor (bv-comp #rx  #m ))) (bv-comp #B  0b1))   0b0)) ;114 BR
                                                    B <= #1 1'b0; $display(";A 116");		//(assert (= @B    0b0)) ;116 NB
                                                end
                                            end
                                        4'b1100 :
                                            begin
                                                $display(";A 117");		//(assert (= #ff    0b1100)) ;117 CS
                                                if (((!(rx > m)) || (B == 1'b1))) begin
                                                    $display(";A 118");		//(assert (= (bv-or (bv-not (bv-redor (bool-to-bv (bv-gt #rx  #m )))) (bv-comp #B  0b1))   0b1)) ;118 BR
                                                    B <= #1 1'b1; $display(";A 120");		//(assert (= @B    0b1)) ;120 NB
                                                end
                                                else begin
                                                    $display(";A 119");		//(assert (= (bv-or (bv-not (bv-redor (bool-to-bv (bv-gt #rx  #m )))) (bv-comp #B  0b1))   0b0)) ;119 BR
                                                    B <= #1 1'b0; $display(";A 121");		//(assert (= @B    0b0)) ;121 NB
                                                end
                                            end
                                        4'b1101 :
                                            begin
                                                $display(";A 122");		//(assert (= #ff    0b1101)) ;122 CS
                                                if (((rx > m) || (B == 1'b1))) begin
                                                    $display(";A 123");		//(assert (= (bv-or (bool-to-bv (bv-gt #rx  #m )) (bv-comp #B  0b1))   0b1)) ;123 BR
                                                    B <= #1 1'b1; $display(";A 125");		//(assert (= @B    0b1)) ;125 NB
                                                end
                                                else begin
                                                    $display(";A 124");		//(assert (= (bv-or (bool-to-bv (bv-gt #rx  #m )) (bv-comp #B  0b1))   0b0)) ;124 BR
                                                    B <= #1 1'b0; $display(";A 126");		//(assert (= @B    0b0)) ;126 NB
                                                end
                                            end
                                        4'b1110 :
                                            begin
                                                $display(";A 127");		//(assert (= #ff    0b1110)) ;127 CS
                                                if ((rx > 31'b0111111111111111111111111111111)) begin
                                                    $display(";A 128");		//(assert (= (bool-to-bv (bv-gt #rx  0b0111111111111111111111111111111))   0b1)) ;128 BR
                                                    rx = rx; $display(";A 130");		//(assert (= @rx    #rx )) ;130 BL
                                                end
                                                else begin
                                                    $display(";A 129");		//(assert (= (bool-to-bv (bv-gt #rx  0b0111111111111111111111111111111))   0b0)) ;129 BR
                                                end
                                                if (((rx < m) || (B == 1'b1))) begin
                                                    $display(";A 131");		//(assert (= (bv-or (bool-to-bv (bv-lt #rx  #m )) (bv-comp #B  0b1))   0b1)) ;131 BR
                                                    B <= #1 1'b1; $display(";A 133");		//(assert (= @B    0b1)) ;133 NB
                                                end
                                                else begin
                                                    $display(";A 132");		//(assert (= (bv-or (bool-to-bv (bv-lt #rx  #m )) (bv-comp #B  0b1))   0b0)) ;132 BR
                                                    B <= #1 1'b0; $display(";A 134");		//(assert (= @B    0b0)) ;134 NB
                                                end
                                            end
                                        4'b1111 :
                                            begin
                                                $display(";A 135");		//(assert (= #ff    0b1111)) ;135 CS
                                                if ((rx > 31'b0111111111111111111111111111111)) begin
                                                    $display(";A 136");		//(assert (= (bool-to-bv (bv-gt #rx  0b0111111111111111111111111111111))   0b1)) ;136 BR
                                                    rx = rx; $display(";A 138");		//(assert (= @rx    #rx )) ;138 BL
                                                end
                                                else begin
                                                    $display(";A 137");		//(assert (= (bool-to-bv (bv-gt #rx  0b0111111111111111111111111111111))   0b0)) ;137 BR
                                                end
                                                if (((!(rx < m)) || (B == 1'b1))) begin
                                                    $display(";A 139");		//(assert (= (bv-or (bv-not (bv-redor (bool-to-bv (bv-lt #rx  #m )))) (bv-comp #B  0b1))   0b1)) ;139 BR
                                                    B <= #1 1'b1; $display(";A 141");		//(assert (= @B    0b1)) ;141 NB
                                                end
                                                else begin
                                                    $display(";A 140");		//(assert (= (bv-or (bv-not (bv-redor (bool-to-bv (bv-lt #rx  #m )))) (bv-comp #B  0b1))   0b0)) ;140 BR
                                                    B <= #1 1'b0; $display(";A 142");		//(assert (= @B    0b0)) ;142 NB
                                                end
                                            end
                                    endcase
                                end
                            1'b0 :
                                begin
                                    $display(";A 143");		//(assert (= #cf    0b0)) ;143 CS
                                    if ((df != 3'b111)) begin
                                        $display(";A 144");		//(assert (= (bv-not (bv-comp #df  0b111))   0b1)) ;144 BR
                                        if ((((df == 3'b101) && (B == 1'b0)) || ((df == 3'b100) && (B == 1'b1)))) begin
                                            $display(";A 146");		//(assert (= (bv-or (bv-and (bv-comp #df  0b101) (bv-comp #B  0b0)) (bv-and (bv-comp #df  0b100) (bv-comp #B  0b1)))   0b1)) ;146 BR
                                            d = 2'b11; $display(";A 148");		//(assert (= @d    0b11)) ;148 BL
                                        end
                                        else begin
                                            $display(";A 147");		//(assert (= (bv-or (bv-and (bv-comp #df  0b101) (bv-comp #B  0b0)) (bv-and (bv-comp #df  0b100) (bv-comp #B  0b1)))   0b0)) ;147 BR
                                            d = df[1:0]; $display(";A 149");		//(assert (= @d    (bv-extract 1 0 #df ))) ;149 BL
                                        end
                                        case (ff)
                                            4'b0000 :
                                                begin
                                                    $display(";A 150");		//(assert (= #ff    0b0000)) ;150 CS
                                                    case (mf)
                                                        2'b00 :
                                                            begin
                                                                $display(";A 151");		//(assert (= #mf    0b00)) ;151 CS
                                                                m = {11'b00000000000, tail}; $display(";A 152");		//(assert (= @m    (bv-concat 0b00000000000 #tail ))) ;152 BL
                                                            end
                                                        2'b01 :
                                                            begin
                                                                $display(";A 153");		//(assert (= #mf    0b01)) ;153 CS
                                                                m = datai; $display(";A 154");		//(assert (= @m    #datai )) ;154 BL
                                                                addr <= #1 tail; $display(";A 155");		//(assert (= @addr    #tail )) ;155 NB
                                                                rd <= #1 1'b1; $display(";A 156");		//(assert (= @rd    0b1)) ;156 NB
                                                            end
                                                        2'b10 :
                                                            begin
                                                                $display(";A 157");		//(assert (= #mf    0b10)) ;157 CS
                                                                addr <= #1 (tail + reg1[19:0]); $display(";A 158");		//(assert (= @addr    (bv-add #tail  (bv-extract 19 0 #reg1 )))) ;158 NB
                                                                rd <= #1 1'b1; $display(";A 159");		//(assert (= @rd    0b1)) ;159 NB
                                                                m = datai; $display(";A 160");		//(assert (= @m    #datai )) ;160 BL
                                                            end
                                                        2'b11 :
                                                            begin
                                                                $display(";A 161");		//(assert (= #mf    0b11)) ;161 CS
                                                                addr <= #1 (tail + reg2[19:0]); $display(";A 162");		//(assert (= @addr    (bv-add #tail  (bv-extract 19 0 #reg2 )))) ;162 NB
                                                                rd <= #1 1'b1; $display(";A 163");		//(assert (= @rd    0b1)) ;163 NB
                                                                m = datai; $display(";A 164");		//(assert (= @m    #datai )) ;164 BL
                                                            end
                                                    endcase
                                                    t = 31'b0000000000000000000000000000000; $display(";A 165");		//(assert (= @t    0b0000000000000000000000000000000)) ;165 BL
                                                    case (d)
                                                        2'b00 :
                                                            begin
                                                                $display(";A 166");		//(assert (= #d    0b00)) ;166 CS
                                                                reg0 = (t - m); $display(";A 167");		//(assert (= @reg0    (bv-sub #t  #m ))) ;167 BL
                                                            end
                                                        2'b01 :
                                                            begin
                                                                $display(";A 168");		//(assert (= #d    0b01)) ;168 CS
                                                                reg1 = (t - m); $display(";A 169");		//(assert (= @reg1    (bv-sub #t  #m ))) ;169 BL
                                                            end
                                                        2'b10 :
                                                            begin
                                                                $display(";A 170");		//(assert (= #d    0b10)) ;170 CS
                                                                reg2 = (t - m); $display(";A 171");		//(assert (= @reg2    (bv-sub #t  #m ))) ;171 BL
                                                            end
                                                        2'b11 :
                                                            begin
                                                                $display(";A 172");		//(assert (= #d    0b11)) ;172 CS
                                                                reg3 = (t - m); $display(";A 173");		//(assert (= @reg3    (bv-sub #t  #m ))) ;173 BL
                                                            end
                                                    endcase
                                                end
                                            4'b0001 :
                                                begin
                                                    $display(";A 174");		//(assert (= #ff    0b0001)) ;174 CS
                                                    case (mf)
                                                        2'b00 :
                                                            begin
                                                                $display(";A 175");		//(assert (= #mf    0b00)) ;175 CS
                                                                m = {11'b00000000000, tail}; $display(";A 176");		//(assert (= @m    (bv-concat 0b00000000000 #tail ))) ;176 BL
                                                            end
                                                        2'b01 :
                                                            begin
                                                                $display(";A 177");		//(assert (= #mf    0b01)) ;177 CS
                                                                m = datai; $display(";A 178");		//(assert (= @m    #datai )) ;178 BL
                                                                addr <= #1 tail; $display(";A 179");		//(assert (= @addr    #tail )) ;179 NB
                                                                rd <= #1 1'b1; $display(";A 180");		//(assert (= @rd    0b1)) ;180 NB
                                                            end
                                                        2'b10 :
                                                            begin
                                                                $display(";A 181");		//(assert (= #mf    0b10)) ;181 CS
                                                                addr <= #1 (tail + reg1[19:0]); $display(";A 182");		//(assert (= @addr    (bv-add #tail  (bv-extract 19 0 #reg1 )))) ;182 NB
                                                                rd <= #1 1'b1; $display(";A 183");		//(assert (= @rd    0b1)) ;183 NB
                                                                m = datai; $display(";A 184");		//(assert (= @m    #datai )) ;184 BL
                                                            end
                                                        2'b11 :
                                                            begin
                                                                $display(";A 185");		//(assert (= #mf    0b11)) ;185 CS
                                                                addr <= #1 (tail + reg2[19:0]); $display(";A 186");		//(assert (= @addr    (bv-add #tail  (bv-extract 19 0 #reg2 )))) ;186 NB
                                                                rd <= #1 1'b1; $display(";A 187");		//(assert (= @rd    0b1)) ;187 NB
                                                                m = datai; $display(";A 188");		//(assert (= @m    #datai )) ;188 BL
                                                            end
                                                    endcase
                                                    reg2 = reg3; $display(";A 189");		//(assert (= @reg2    #reg3 )) ;189 BL
                                                    reg3 = m; $display(";A 190");		//(assert (= @reg3    #m )) ;190 BL
                                                end
                                            4'b0010 :
                                                begin
                                                    $display(";A 191");		//(assert (= #ff    0b0010)) ;191 CS
                                                    case (mf)
                                                        2'b00 :
                                                            begin
                                                                $display(";A 192");		//(assert (= #mf    0b00)) ;192 CS
                                                                m = {11'b00000000000, tail}; $display(";A 193");		//(assert (= @m    (bv-concat 0b00000000000 #tail ))) ;193 BL
                                                            end
                                                        2'b01 :
                                                            begin
                                                                $display(";A 194");		//(assert (= #mf    0b01)) ;194 CS
                                                                m = datai; $display(";A 195");		//(assert (= @m    #datai )) ;195 BL
                                                                addr <= #1 tail; $display(";A 196");		//(assert (= @addr    #tail )) ;196 NB
                                                                rd <= #1 1'b1; $display(";A 197");		//(assert (= @rd    0b1)) ;197 NB
                                                            end
                                                        2'b10 :
                                                            begin
                                                                $display(";A 198");		//(assert (= #mf    0b10)) ;198 CS
                                                                addr <= #1 (tail + reg1[19:0]); $display(";A 199");		//(assert (= @addr    (bv-add #tail  (bv-extract 19 0 #reg1 )))) ;199 NB
                                                                rd <= #1 1'b1; $display(";A 200");		//(assert (= @rd    0b1)) ;200 NB
                                                                m = datai; $display(";A 201");		//(assert (= @m    #datai )) ;201 BL
                                                            end
                                                        2'b11 :
                                                            begin
                                                                $display(";A 202");		//(assert (= #mf    0b11)) ;202 CS
                                                                addr <= #1 (tail + reg2[19:0]); $display(";A 203");		//(assert (= @addr    (bv-add #tail  (bv-extract 19 0 #reg2 )))) ;203 NB
                                                                rd <= #1 1'b1; $display(";A 204");		//(assert (= @rd    0b1)) ;204 NB
                                                                m = datai; $display(";A 205");		//(assert (= @m    #datai )) ;205 BL
                                                            end
                                                    endcase
                                                    case (d)
                                                        2'b00 :
                                                            begin
                                                                $display(";A 206");		//(assert (= #d    0b00)) ;206 CS
                                                                reg0 = m; $display(";A 207");		//(assert (= @reg0    #m )) ;207 BL
                                                            end
                                                        2'b01 :
                                                            begin
                                                                $display(";A 208");		//(assert (= #d    0b01)) ;208 CS
                                                                reg1 = m; $display(";A 209");		//(assert (= @reg1    #m )) ;209 BL
                                                            end
                                                        2'b10 :
                                                            begin
                                                                $display(";A 210");		//(assert (= #d    0b10)) ;210 CS
                                                                reg2 = m; $display(";A 211");		//(assert (= @reg2    #m )) ;211 BL
                                                            end
                                                        2'b11 :
                                                            begin
                                                                $display(";A 212");		//(assert (= #d    0b11)) ;212 CS
                                                                reg3 = m; $display(";A 213");		//(assert (= @reg3    #m )) ;213 BL
                                                            end
                                                    endcase
                                                end
                                            4'b0011 :
                                                begin
                                                    $display(";A 214");		//(assert (= #ff    0b0011)) ;214 CS
                                                    case (mf)
                                                        2'b00 :
                                                            begin
                                                                $display(";A 215");		//(assert (= #mf    0b00)) ;215 CS
                                                                m = {11'b00000000000, tail}; $display(";A 216");		//(assert (= @m    (bv-concat 0b00000000000 #tail ))) ;216 BL
                                                            end
                                                        2'b01 :
                                                            begin
                                                                $display(";A 217");		//(assert (= #mf    0b01)) ;217 CS
                                                                m = datai; $display(";A 218");		//(assert (= @m    #datai )) ;218 BL
                                                                addr <= #1 tail; $display(";A 219");		//(assert (= @addr    #tail )) ;219 NB
                                                                rd <= #1 1'b1; $display(";A 220");		//(assert (= @rd    0b1)) ;220 NB
                                                            end
                                                        2'b10 :
                                                            begin
                                                                $display(";A 221");		//(assert (= #mf    0b10)) ;221 CS
                                                                addr <= #1 (tail + reg1[19:0]); $display(";A 222");		//(assert (= @addr    (bv-add #tail  (bv-extract 19 0 #reg1 )))) ;222 NB
                                                                rd <= #1 1'b1; $display(";A 223");		//(assert (= @rd    0b1)) ;223 NB
                                                                m = datai; $display(";A 224");		//(assert (= @m    #datai )) ;224 BL
                                                            end
                                                        2'b11 :
                                                            begin
                                                                $display(";A 225");		//(assert (= #mf    0b11)) ;225 CS
                                                                addr <= #1 (tail + reg2[19:0]); $display(";A 226");		//(assert (= @addr    (bv-add #tail  (bv-extract 19 0 #reg2 )))) ;226 NB
                                                                rd <= #1 1'b1; $display(";A 227");		//(assert (= @rd    0b1)) ;227 NB
                                                                m = datai; $display(";A 228");		//(assert (= @m    #datai )) ;228 BL
                                                            end
                                                    endcase
                                                    case (d)
                                                        2'b00 :
                                                            begin
                                                                $display(";A 229");		//(assert (= #d    0b00)) ;229 CS
                                                                reg0 = m; $display(";A 230");		//(assert (= @reg0    #m )) ;230 BL
                                                            end
                                                        2'b01 :
                                                            begin
                                                                $display(";A 231");		//(assert (= #d    0b01)) ;231 CS
                                                                reg1 = m; $display(";A 232");		//(assert (= @reg1    #m )) ;232 BL
                                                            end
                                                        2'b10 :
                                                            begin
                                                                $display(";A 233");		//(assert (= #d    0b10)) ;233 CS
                                                                reg2 = m; $display(";A 234");		//(assert (= @reg2    #m )) ;234 BL
                                                            end
                                                        2'b11 :
                                                            begin
                                                                $display(";A 235");		//(assert (= #d    0b11)) ;235 CS
                                                                reg3 = m; $display(";A 236");		//(assert (= @reg3    #m )) ;236 BL
                                                            end
                                                    endcase
                                                end
                                            4'b0100 :
                                                begin
                                                    $display(";A 237");		//(assert (= #ff    0b0100)) ;237 CS
                                                    case (mf)
                                                        2'b00 :
                                                            begin
                                                                $display(";A 238");		//(assert (= #mf    0b00)) ;238 CS
                                                                m = {11'b00000000000, tail}; $display(";A 239");		//(assert (= @m    (bv-concat 0b00000000000 #tail ))) ;239 BL
                                                            end
                                                        2'b01 :
                                                            begin
                                                                $display(";A 240");		//(assert (= #mf    0b01)) ;240 CS
                                                                m = datai; $display(";A 241");		//(assert (= @m    #datai )) ;241 BL
                                                                addr <= #1 tail; $display(";A 242");		//(assert (= @addr    #tail )) ;242 NB
                                                                rd <= #1 1'b1; $display(";A 243");		//(assert (= @rd    0b1)) ;243 NB
                                                            end
                                                        2'b10 :
                                                            begin
                                                                $display(";A 244");		//(assert (= #mf    0b10)) ;244 CS
                                                                addr <= #1 (tail + reg1[19:0]); $display(";A 245");		//(assert (= @addr    (bv-add #tail  (bv-extract 19 0 #reg1 )))) ;245 NB
                                                                rd <= #1 1'b1; $display(";A 246");		//(assert (= @rd    0b1)) ;246 NB
                                                                m = datai; $display(";A 247");		//(assert (= @m    #datai )) ;247 BL
                                                            end
                                                        2'b11 :
                                                            begin
                                                                $display(";A 248");		//(assert (= #mf    0b11)) ;248 CS
                                                                addr <= #1 (tail + reg2[19:0]); $display(";A 249");		//(assert (= @addr    (bv-add #tail  (bv-extract 19 0 #reg2 )))) ;249 NB
                                                                rd <= #1 1'b1; $display(";A 250");		//(assert (= @rd    0b1)) ;250 NB
                                                                m = datai; $display(";A 251");		//(assert (= @m    #datai )) ;251 BL
                                                            end
                                                    endcase
                                                    case (d)
                                                        2'b00 :
                                                            begin
                                                                $display(";A 252");		//(assert (= #d    0b00)) ;252 CS
                                                                reg0 = (rx + m); $display(";A 253");		//(assert (= @reg0    (bv-add #rx  #m ))) ;253 BL
                                                            end
                                                        2'b01 :
                                                            begin
                                                                $display(";A 254");		//(assert (= #d    0b01)) ;254 CS
                                                                reg1 = (rx + m); $display(";A 255");		//(assert (= @reg1    (bv-add #rx  #m ))) ;255 BL
                                                            end
                                                        2'b10 :
                                                            begin
                                                                $display(";A 256");		//(assert (= #d    0b10)) ;256 CS
                                                                reg2 = (rx + m); $display(";A 257");		//(assert (= @reg2    (bv-add #rx  #m ))) ;257 BL
                                                            end
                                                        2'b11 :
                                                            begin
                                                                $display(";A 258");		//(assert (= #d    0b11)) ;258 CS
                                                                reg3 = (rx + m); $display(";A 259");		//(assert (= @reg3    (bv-add #rx  #m ))) ;259 BL
                                                            end
                                                    endcase
                                                end
                                            4'b0101 :
                                                begin
                                                    $display(";A 260");		//(assert (= #ff    0b0101)) ;260 CS
                                                    case (mf)
                                                        2'b00 :
                                                            begin
                                                                $display(";A 261");		//(assert (= #mf    0b00)) ;261 CS
                                                                m = {11'b00000000000, tail}; $display(";A 262");		//(assert (= @m    (bv-concat 0b00000000000 #tail ))) ;262 BL
                                                            end
                                                        2'b01 :
                                                            begin
                                                                $display(";A 263");		//(assert (= #mf    0b01)) ;263 CS
                                                                m = datai; $display(";A 264");		//(assert (= @m    #datai )) ;264 BL
                                                                addr <= #1 tail; $display(";A 265");		//(assert (= @addr    #tail )) ;265 NB
                                                                rd <= #1 1'b1; $display(";A 266");		//(assert (= @rd    0b1)) ;266 NB
                                                            end
                                                        2'b10 :
                                                            begin
                                                                $display(";A 267");		//(assert (= #mf    0b10)) ;267 CS
                                                                addr <= #1 (tail + reg1[19:0]); $display(";A 268");		//(assert (= @addr    (bv-add #tail  (bv-extract 19 0 #reg1 )))) ;268 NB
                                                                rd <= #1 1'b1; $display(";A 269");		//(assert (= @rd    0b1)) ;269 NB
                                                                m = datai; $display(";A 270");		//(assert (= @m    #datai )) ;270 BL
                                                            end
                                                        2'b11 :
                                                            begin
                                                                $display(";A 271");		//(assert (= #mf    0b11)) ;271 CS
                                                                addr <= #1 (tail + reg2[19:0]); $display(";A 272");		//(assert (= @addr    (bv-add #tail  (bv-extract 19 0 #reg2 )))) ;272 NB
                                                                rd <= #1 1'b1; $display(";A 273");		//(assert (= @rd    0b1)) ;273 NB
                                                                m = datai; $display(";A 274");		//(assert (= @m    #datai )) ;274 BL
                                                            end
                                                    endcase
                                                    case (d)
                                                        2'b00 :
                                                            begin
                                                                $display(";A 275");		//(assert (= #d    0b00)) ;275 CS
                                                                reg0 = (rx + m); $display(";A 276");		//(assert (= @reg0    (bv-add #rx  #m ))) ;276 BL
                                                            end
                                                        2'b01 :
                                                            begin
                                                                $display(";A 277");		//(assert (= #d    0b01)) ;277 CS
                                                                reg1 = (rx + m); $display(";A 278");		//(assert (= @reg1    (bv-add #rx  #m ))) ;278 BL
                                                            end
                                                        2'b10 :
                                                            begin
                                                                $display(";A 279");		//(assert (= #d    0b10)) ;279 CS
                                                                reg2 = (rx + m); $display(";A 280");		//(assert (= @reg2    (bv-add #rx  #m ))) ;280 BL
                                                            end
                                                        2'b11 :
                                                            begin
                                                                $display(";A 281");		//(assert (= #d    0b11)) ;281 CS
                                                                reg3 = (rx + m); $display(";A 282");		//(assert (= @reg3    (bv-add #rx  #m ))) ;282 BL
                                                            end
                                                    endcase
                                                end
                                            4'b0110 :
                                                begin
                                                    $display(";A 283");		//(assert (= #ff    0b0110)) ;283 CS
                                                    case (mf)
                                                        2'b00 :
                                                            begin
                                                                $display(";A 284");		//(assert (= #mf    0b00)) ;284 CS
                                                                m = {11'b00000000000, tail}; $display(";A 285");		//(assert (= @m    (bv-concat 0b00000000000 #tail ))) ;285 BL
                                                            end
                                                        2'b01 :
                                                            begin
                                                                $display(";A 286");		//(assert (= #mf    0b01)) ;286 CS
                                                                m = datai; $display(";A 287");		//(assert (= @m    #datai )) ;287 BL
                                                                addr <= #1 tail; $display(";A 288");		//(assert (= @addr    #tail )) ;288 NB
                                                                rd <= #1 1'b1; $display(";A 289");		//(assert (= @rd    0b1)) ;289 NB
                                                            end
                                                        2'b10 :
                                                            begin
                                                                $display(";A 290");		//(assert (= #mf    0b10)) ;290 CS
                                                                addr <= #1 (tail + reg1[19:0]); $display(";A 291");		//(assert (= @addr    (bv-add #tail  (bv-extract 19 0 #reg1 )))) ;291 NB
                                                                rd <= #1 1'b1; $display(";A 292");		//(assert (= @rd    0b1)) ;292 NB
                                                                m = datai; $display(";A 293");		//(assert (= @m    #datai )) ;293 BL
                                                            end
                                                        2'b11 :
                                                            begin
                                                                $display(";A 294");		//(assert (= #mf    0b11)) ;294 CS
                                                                addr <= #1 (tail + reg2[19:0]); $display(";A 295");		//(assert (= @addr    (bv-add #tail  (bv-extract 19 0 #reg2 )))) ;295 NB
                                                                rd <= #1 1'b1; $display(";A 296");		//(assert (= @rd    0b1)) ;296 NB
                                                                m = datai; $display(";A 297");		//(assert (= @m    #datai )) ;297 BL
                                                            end
                                                    endcase
                                                    case (d)
                                                        2'b00 :
                                                            begin
                                                                $display(";A 298");		//(assert (= #d    0b00)) ;298 CS
                                                                reg0 = (rx - m); $display(";A 299");		//(assert (= @reg0    (bv-sub #rx  #m ))) ;299 BL
                                                            end
                                                        2'b01 :
                                                            begin
                                                                $display(";A 300");		//(assert (= #d    0b01)) ;300 CS
                                                                reg1 = (rx - m); $display(";A 301");		//(assert (= @reg1    (bv-sub #rx  #m ))) ;301 BL
                                                            end
                                                        2'b10 :
                                                            begin
                                                                $display(";A 302");		//(assert (= #d    0b10)) ;302 CS
                                                                reg2 = (rx - m); $display(";A 303");		//(assert (= @reg2    (bv-sub #rx  #m ))) ;303 BL
                                                            end
                                                        2'b11 :
                                                            begin
                                                                $display(";A 304");		//(assert (= #d    0b11)) ;304 CS
                                                                reg3 = (rx - m); $display(";A 305");		//(assert (= @reg3    (bv-sub #rx  #m ))) ;305 BL
                                                            end
                                                    endcase
                                                end
                                            4'b0111 :
                                                begin
                                                    $display(";A 306");		//(assert (= #ff    0b0111)) ;306 CS
                                                    case (mf)
                                                        2'b00 :
                                                            begin
                                                                $display(";A 307");		//(assert (= #mf    0b00)) ;307 CS
                                                                m = {11'b00000000000, tail}; $display(";A 308");		//(assert (= @m    (bv-concat 0b00000000000 #tail ))) ;308 BL
                                                            end
                                                        2'b01 :
                                                            begin
                                                                $display(";A 309");		//(assert (= #mf    0b01)) ;309 CS
                                                                m = datai; $display(";A 310");		//(assert (= @m    #datai )) ;310 BL
                                                                addr <= #1 tail; $display(";A 311");		//(assert (= @addr    #tail )) ;311 NB
                                                                rd <= #1 1'b1; $display(";A 312");		//(assert (= @rd    0b1)) ;312 NB
                                                            end
                                                        2'b10 :
                                                            begin
                                                                $display(";A 313");		//(assert (= #mf    0b10)) ;313 CS
                                                                addr <= #1 (tail + reg1[19:0]); $display(";A 314");		//(assert (= @addr    (bv-add #tail  (bv-extract 19 0 #reg1 )))) ;314 NB
                                                                rd <= #1 1'b1; $display(";A 315");		//(assert (= @rd    0b1)) ;315 NB
                                                                m = datai; $display(";A 316");		//(assert (= @m    #datai )) ;316 BL
                                                            end
                                                        2'b11 :
                                                            begin
                                                                $display(";A 317");		//(assert (= #mf    0b11)) ;317 CS
                                                                addr <= #1 (tail + reg2[19:0]); $display(";A 318");		//(assert (= @addr    (bv-add #tail  (bv-extract 19 0 #reg2 )))) ;318 NB
                                                                rd <= #1 1'b1; $display(";A 319");		//(assert (= @rd    0b1)) ;319 NB
                                                                m = datai; $display(";A 320");		//(assert (= @m    #datai )) ;320 BL
                                                            end
                                                    endcase
                                                    case (d)
                                                        2'b00 :
                                                            begin
                                                                $display(";A 321");		//(assert (= #d    0b00)) ;321 CS
                                                                reg0 = (rx - m); $display(";A 322");		//(assert (= @reg0    (bv-sub #rx  #m ))) ;322 BL
                                                            end
                                                        2'b01 :
                                                            begin
                                                                $display(";A 323");		//(assert (= #d    0b01)) ;323 CS
                                                                reg1 = (rx - m); $display(";A 324");		//(assert (= @reg1    (bv-sub #rx  #m ))) ;324 BL
                                                            end
                                                        2'b10 :
                                                            begin
                                                                $display(";A 325");		//(assert (= #d    0b10)) ;325 CS
                                                                reg2 = (rx - m); $display(";A 326");		//(assert (= @reg2    (bv-sub #rx  #m ))) ;326 BL
                                                            end
                                                        2'b11 :
                                                            begin
                                                                $display(";A 327");		//(assert (= #d    0b11)) ;327 CS
                                                                reg3 = (rx - m); $display(";A 328");		//(assert (= @reg3    (bv-sub #rx  #m ))) ;328 BL
                                                            end
                                                    endcase
                                                end
                                            4'b1000 :
                                                begin
                                                    $display(";A 329");		//(assert (= #ff    0b1000)) ;329 CS
                                                    case (mf)
                                                        2'b00 :
                                                            begin
                                                                $display(";A 330");		//(assert (= #mf    0b00)) ;330 CS
                                                                m = {11'b00000000000, tail}; $display(";A 331");		//(assert (= @m    (bv-concat 0b00000000000 #tail ))) ;331 BL
                                                            end
                                                        2'b01 :
                                                            begin
                                                                $display(";A 332");		//(assert (= #mf    0b01)) ;332 CS
                                                                m = datai; $display(";A 333");		//(assert (= @m    #datai )) ;333 BL
                                                                addr <= #1 tail; $display(";A 334");		//(assert (= @addr    #tail )) ;334 NB
                                                                rd <= #1 1'b1; $display(";A 335");		//(assert (= @rd    0b1)) ;335 NB
                                                            end
                                                        2'b10 :
                                                            begin
                                                                $display(";A 336");		//(assert (= #mf    0b10)) ;336 CS
                                                                addr <= #1 (tail + reg1[19:0]); $display(";A 337");		//(assert (= @addr    (bv-add #tail  (bv-extract 19 0 #reg1 )))) ;337 NB
                                                                rd <= #1 1'b1; $display(";A 338");		//(assert (= @rd    0b1)) ;338 NB
                                                                m = datai; $display(";A 339");		//(assert (= @m    #datai )) ;339 BL
                                                            end
                                                        2'b11 :
                                                            begin
                                                                $display(";A 340");		//(assert (= #mf    0b11)) ;340 CS
                                                                addr <= #1 (tail + reg2[19:0]); $display(";A 341");		//(assert (= @addr    (bv-add #tail  (bv-extract 19 0 #reg2 )))) ;341 NB
                                                                rd <= #1 1'b1; $display(";A 342");		//(assert (= @rd    0b1)) ;342 NB
                                                                m = datai; $display(";A 343");		//(assert (= @m    #datai )) ;343 BL
                                                            end
                                                    endcase
                                                    case (d)
                                                        2'b00 :
                                                            begin
                                                                $display(";A 344");		//(assert (= #d    0b00)) ;344 CS
                                                                reg0 = (rx + m); $display(";A 345");		//(assert (= @reg0    (bv-add #rx  #m ))) ;345 BL
                                                            end
                                                        2'b01 :
                                                            begin
                                                                $display(";A 346");		//(assert (= #d    0b01)) ;346 CS
                                                                reg1 = (rx + m); $display(";A 347");		//(assert (= @reg1    (bv-add #rx  #m ))) ;347 BL
                                                            end
                                                        2'b10 :
                                                            begin
                                                                $display(";A 348");		//(assert (= #d    0b10)) ;348 CS
                                                                reg2 = (rx + m); $display(";A 349");		//(assert (= @reg2    (bv-add #rx  #m ))) ;349 BL
                                                            end
                                                        2'b11 :
                                                            begin
                                                                $display(";A 350");		//(assert (= #d    0b11)) ;350 CS
                                                                reg3 = (rx + m); $display(";A 351");		//(assert (= @reg3    (bv-add #rx  #m ))) ;351 BL
                                                            end
                                                    endcase
                                                end
                                            4'b1001 :
                                                begin
                                                    $display(";A 352");		//(assert (= #ff    0b1001)) ;352 CS
                                                    case (mf)
                                                        2'b00 :
                                                            begin
                                                                $display(";A 353");		//(assert (= #mf    0b00)) ;353 CS
                                                                m = {11'b00000000000, tail}; $display(";A 354");		//(assert (= @m    (bv-concat 0b00000000000 #tail ))) ;354 BL
                                                            end
                                                        2'b01 :
                                                            begin
                                                                $display(";A 355");		//(assert (= #mf    0b01)) ;355 CS
                                                                m = datai; $display(";A 356");		//(assert (= @m    #datai )) ;356 BL
                                                                addr <= #1 tail; $display(";A 357");		//(assert (= @addr    #tail )) ;357 NB
                                                                rd <= #1 1'b1; $display(";A 358");		//(assert (= @rd    0b1)) ;358 NB
                                                            end
                                                        2'b10 :
                                                            begin
                                                                $display(";A 359");		//(assert (= #mf    0b10)) ;359 CS
                                                                addr <= #1 (tail + reg1[19:0]); $display(";A 360");		//(assert (= @addr    (bv-add #tail  (bv-extract 19 0 #reg1 )))) ;360 NB
                                                                rd <= #1 1'b1; $display(";A 361");		//(assert (= @rd    0b1)) ;361 NB
                                                                m = datai; $display(";A 362");		//(assert (= @m    #datai )) ;362 BL
                                                            end
                                                        2'b11 :
                                                            begin
                                                                $display(";A 363");		//(assert (= #mf    0b11)) ;363 CS
                                                                addr <= #1 (tail + reg2[19:0]); $display(";A 364");		//(assert (= @addr    (bv-add #tail  (bv-extract 19 0 #reg2 )))) ;364 NB
                                                                rd <= #1 1'b1; $display(";A 365");		//(assert (= @rd    0b1)) ;365 NB
                                                                m = datai; $display(";A 366");		//(assert (= @m    #datai )) ;366 BL
                                                            end
                                                    endcase
                                                    case (d)
                                                        2'b00 :
                                                            begin
                                                                $display(";A 367");		//(assert (= #d    0b00)) ;367 CS
                                                                reg0 = (rx - m); $display(";A 368");		//(assert (= @reg0    (bv-sub #rx  #m ))) ;368 BL
                                                            end
                                                        2'b01 :
                                                            begin
                                                                $display(";A 369");		//(assert (= #d    0b01)) ;369 CS
                                                                reg1 = (rx - m); $display(";A 370");		//(assert (= @reg1    (bv-sub #rx  #m ))) ;370 BL
                                                            end
                                                        2'b10 :
                                                            begin
                                                                $display(";A 371");		//(assert (= #d    0b10)) ;371 CS
                                                                reg2 = (rx - m); $display(";A 372");		//(assert (= @reg2    (bv-sub #rx  #m ))) ;372 BL
                                                            end
                                                        2'b11 :
                                                            begin
                                                                $display(";A 373");		//(assert (= #d    0b11)) ;373 CS
                                                                reg3 = (rx - m); $display(";A 374");		//(assert (= @reg3    (bv-sub #rx  #m ))) ;374 BL
                                                            end
                                                    endcase
                                                end
                                            4'b1010 :
                                                begin
                                                    $display(";A 375");		//(assert (= #ff    0b1010)) ;375 CS
                                                    case (mf)
                                                        2'b00 :
                                                            begin
                                                                $display(";A 376");		//(assert (= #mf    0b00)) ;376 CS
                                                                m = {11'b00000000000, tail}; $display(";A 377");		//(assert (= @m    (bv-concat 0b00000000000 #tail ))) ;377 BL
                                                            end
                                                        2'b01 :
                                                            begin
                                                                $display(";A 378");		//(assert (= #mf    0b01)) ;378 CS
                                                                m = datai; $display(";A 379");		//(assert (= @m    #datai )) ;379 BL
                                                                addr <= #1 tail; $display(";A 380");		//(assert (= @addr    #tail )) ;380 NB
                                                                rd <= #1 1'b1; $display(";A 381");		//(assert (= @rd    0b1)) ;381 NB
                                                            end
                                                        2'b10 :
                                                            begin
                                                                $display(";A 382");		//(assert (= #mf    0b10)) ;382 CS
                                                                addr <= #1 (tail + reg1[19:0]); $display(";A 383");		//(assert (= @addr    (bv-add #tail  (bv-extract 19 0 #reg1 )))) ;383 NB
                                                                rd <= #1 1'b1; $display(";A 384");		//(assert (= @rd    0b1)) ;384 NB
                                                                m = datai; $display(";A 385");		//(assert (= @m    #datai )) ;385 BL
                                                            end
                                                        2'b11 :
                                                            begin
                                                                $display(";A 386");		//(assert (= #mf    0b11)) ;386 CS
                                                                addr <= #1 (tail + reg2[19:0]); $display(";A 387");		//(assert (= @addr    (bv-add #tail  (bv-extract 19 0 #reg2 )))) ;387 NB
                                                                rd <= #1 1'b1; $display(";A 388");		//(assert (= @rd    0b1)) ;388 NB
                                                                m = datai; $display(";A 389");		//(assert (= @m    #datai )) ;389 BL
                                                            end
                                                    endcase
                                                    case (d)
                                                        2'b00 :
                                                            begin
                                                                $display(";A 390");		//(assert (= #d    0b00)) ;390 CS
                                                                reg0 = (rx + m); $display(";A 391");		//(assert (= @reg0    (bv-add #rx  #m ))) ;391 BL
                                                            end
                                                        2'b01 :
                                                            begin
                                                                $display(";A 392");		//(assert (= #d    0b01)) ;392 CS
                                                                reg1 = (rx + m); $display(";A 393");		//(assert (= @reg1    (bv-add #rx  #m ))) ;393 BL
                                                            end
                                                        2'b10 :
                                                            begin
                                                                $display(";A 394");		//(assert (= #d    0b10)) ;394 CS
                                                                reg2 = (rx + m); $display(";A 395");		//(assert (= @reg2    (bv-add #rx  #m ))) ;395 BL
                                                            end
                                                        2'b11 :
                                                            begin
                                                                $display(";A 396");		//(assert (= #d    0b11)) ;396 CS
                                                                reg3 = (rx + m); $display(";A 397");		//(assert (= @reg3    (bv-add #rx  #m ))) ;397 BL
                                                            end
                                                    endcase
                                                end
                                            4'b1011 :
                                                begin
                                                    $display(";A 398");		//(assert (= #ff    0b1011)) ;398 CS
                                                    case (mf)
                                                        2'b00 :
                                                            begin
                                                                $display(";A 399");		//(assert (= #mf    0b00)) ;399 CS
                                                                m = {11'b00000000000, tail}; $display(";A 400");		//(assert (= @m    (bv-concat 0b00000000000 #tail ))) ;400 BL
                                                            end
                                                        2'b01 :
                                                            begin
                                                                $display(";A 401");		//(assert (= #mf    0b01)) ;401 CS
                                                                m = datai; $display(";A 402");		//(assert (= @m    #datai )) ;402 BL
                                                                addr <= #1 tail; $display(";A 403");		//(assert (= @addr    #tail )) ;403 NB
                                                                rd <= #1 1'b1; $display(";A 404");		//(assert (= @rd    0b1)) ;404 NB
                                                            end
                                                        2'b10 :
                                                            begin
                                                                $display(";A 405");		//(assert (= #mf    0b10)) ;405 CS
                                                                addr <= #1 (tail + reg1[19:0]); $display(";A 406");		//(assert (= @addr    (bv-add #tail  (bv-extract 19 0 #reg1 )))) ;406 NB
                                                                rd <= #1 1'b1; $display(";A 407");		//(assert (= @rd    0b1)) ;407 NB
                                                                m = datai; $display(";A 408");		//(assert (= @m    #datai )) ;408 BL
                                                            end
                                                        2'b11 :
                                                            begin
                                                                $display(";A 409");		//(assert (= #mf    0b11)) ;409 CS
                                                                addr <= #1 (tail + reg2[19:0]); $display(";A 410");		//(assert (= @addr    (bv-add #tail  (bv-extract 19 0 #reg2 )))) ;410 NB
                                                                rd <= #1 1'b1; $display(";A 411");		//(assert (= @rd    0b1)) ;411 NB
                                                                m = datai; $display(";A 412");		//(assert (= @m    #datai )) ;412 BL
                                                            end
                                                    endcase
                                                    case (d)
                                                        2'b00 :
                                                            begin
                                                                $display(";A 413");		//(assert (= #d    0b00)) ;413 CS
                                                                reg0 = (rx - m); $display(";A 414");		//(assert (= @reg0    (bv-sub #rx  #m ))) ;414 BL
                                                            end
                                                        2'b01 :
                                                            begin
                                                                $display(";A 415");		//(assert (= #d    0b01)) ;415 CS
                                                                reg1 = (rx - m); $display(";A 416");		//(assert (= @reg1    (bv-sub #rx  #m ))) ;416 BL
                                                            end
                                                        2'b10 :
                                                            begin
                                                                $display(";A 417");		//(assert (= #d    0b10)) ;417 CS
                                                                reg2 = (rx - m); $display(";A 418");		//(assert (= @reg2    (bv-sub #rx  #m ))) ;418 BL
                                                            end
                                                        2'b11 :
                                                            begin
                                                                $display(";A 419");		//(assert (= #d    0b11)) ;419 CS
                                                                reg3 = (rx - m); $display(";A 420");		//(assert (= @reg3    (bv-sub #rx  #m ))) ;420 BL
                                                            end
                                                    endcase
                                                end
                                            4'b1100 :
                                                begin
                                                    $display(";A 421");		//(assert (= #ff    0b1100)) ;421 CS
                                                    case (mf)
                                                        2'b00 :
                                                            begin
                                                                $display(";A 422");		//(assert (= #mf    0b00)) ;422 CS
                                                                t = {1'b0, rx[30:1]}; $display(";A 423");		//(assert (= @t    (bv-concat 0b0 (bv-extract 30 1 #rx )))) ;423 BL
                                                            end
                                                        2'b01 :
                                                            begin
                                                                $display(";A 424");		//(assert (= #mf    0b01)) ;424 CS
                                                                t = {1'b0, ((B == 1'b1) ? 1'b0 : rx[30]), rx[29:1]}; $display(";A 425");		//(assert (= @t    (bv-concat 0b0 (ite (= (bv-comp #B  0b1) 0b1) 0b0 (bv-extract 30 30 #rx )) (bv-extract 29 1 #rx )))) ;425 BL
                                                            end
                                                        2'b10 :
                                                            begin
                                                                $display(";A 426");		//(assert (= #mf    0b10)) ;426 CS
                                                                t = {rx[29:0], 1'b0}; $display(";A 427");		//(assert (= @t    (bv-concat (bv-extract 29 0 #rx ) 0b0))) ;427 BL
                                                            end
                                                        2'b11 :
                                                            begin
                                                                $display(";A 428");		//(assert (= #mf    0b11)) ;428 CS
                                                                t = {rx[29:0], 1'b0}; $display(";A 429");		//(assert (= @t    (bv-concat (bv-extract 29 0 #rx ) 0b0))) ;429 BL
                                                                if ((t > 31'b0111111111111111111111111111111)) begin
                                                                    $display(";A 430");		//(assert (= (bool-to-bv (bv-gt #t  0b0111111111111111111111111111111))   0b1)) ;430 BR
                                                                    B <= #1 1'b1; $display(";A 432");		//(assert (= @B    0b1)) ;432 NB
                                                                end
                                                                else begin
                                                                    $display(";A 431");		//(assert (= (bool-to-bv (bv-gt #t  0b0111111111111111111111111111111))   0b0)) ;431 BR
                                                                    B <= #1 1'b0; $display(";A 433");		//(assert (= @B    0b0)) ;433 NB
                                                                end
                                                            end
                                                    endcase
                                                    case (d)
                                                        2'b00 :
                                                            begin
                                                                $display(";A 434");		//(assert (= #d    0b00)) ;434 CS
                                                                reg0 <= #1 t; $display(";A 435");		//(assert (= @reg0    #t )) ;435 NB
                                                            end
                                                        2'b01 :
                                                            begin
                                                                $display(";A 436");		//(assert (= #d    0b01)) ;436 CS
                                                                reg1 <= #1 t; $display(";A 437");		//(assert (= @reg1    #t )) ;437 NB
                                                            end
                                                        2'b10 :
                                                            begin
                                                                $display(";A 438");		//(assert (= #d    0b10)) ;438 CS
                                                                reg2 <= #1 t; $display(";A 439");		//(assert (= @reg2    #t )) ;439 NB
                                                            end
                                                        2'b11 :
                                                            begin
                                                                $display(";A 440");		//(assert (= #d    0b11)) ;440 CS
                                                                reg3 <= #1 t; $display(";A 441");		//(assert (= @reg3    #t )) ;441 NB
                                                            end
                                                    endcase
                                                end
                                        endcase
                                    end
                                    else begin
                                        $display(";A 145");		//(assert (= (bv-not (bv-comp #df  0b111))   0b0)) ;145 BR
                                        if ((df == 3'b111)) begin
                                            $display(";A 442");		//(assert (= (bv-comp #df  0b111)   0b1)) ;442 BR
                                            case (mf)
                                                2'b00 :
                                                    begin
                                                        $display(";A 444");		//(assert (= #mf    0b00)) ;444 CS
                                                        m = {11'b00000000000, tail}; $display(";A 445");		//(assert (= @m    (bv-concat 0b00000000000 #tail ))) ;445 BL
                                                    end
                                                2'b01 :
                                                    begin
                                                        $display(";A 446");		//(assert (= #mf    0b01)) ;446 CS
                                                        m = {11'b00000000000, tail}; $display(";A 447");		//(assert (= @m    (bv-concat 0b00000000000 #tail ))) ;447 BL
                                                    end
                                                2'b10 :
                                                    begin
                                                        $display(";A 448");		//(assert (= #mf    0b10)) ;448 CS
                                                        m = (reg1 + {11'b00000000000, tail}); $display(";A 449");		//(assert (= @m    (bv-add #reg1  (bv-concat 0b00000000000 #tail )))) ;449 BL
                                                    end
                                                2'b11 :
                                                    begin
                                                        $display(";A 450");		//(assert (= #mf    0b11)) ;450 CS
                                                        m = (reg2 + {11'b00000000000, tail}); $display(";A 451");		//(assert (= @m    (bv-add #reg2  (bv-concat 0b00000000000 #tail )))) ;451 BL
                                                    end
                                            endcase
                                            addr <= #1 m[19:0]; $display(";A 452");		//(assert (= @addr    (bv-extract 19 0 #m ))) ;452 NB
                                            wr <= #1 1'b1; $display(";A 453");		//(assert (= @wr    0b1)) ;453 NB
                                            datao <= #1 rx; $display(";A 454");		//(assert (= @datao    #rx )) ;454 NB
                                        end
                                        else begin
                                            $display(";A 443");		//(assert (= (bv-comp #df  0b111)   0b0)) ;443 BR
                                        end
                                    end
                                end
                        endcase
                        state <= #1 1'b0; $display(";A 455");		//(assert (= @state    0b0)) ;455 NB
                    end
            endcase
        end
    end
/*
[1] weight: 0 distance: 268435455
(assert (= @mf    (bv-extract 28 27 #IR ))) ;0 BL

[2] weight: 0 distance: 268435455
(assert (= @df    (bv-extract 26 24 #IR ))) ;1 BL

[3] weight: 0 distance: 268435455
(assert (= @ff    (bv-extract 22 19 #IR ))) ;2 BL

[4] weight: 0 distance: 268435455
(assert (= @cf    (bv-extract 23 23 #IR ))) ;3 BL

[5] weight: 0 distance: 268435455
(assert (= @tail    (bv-extract 19 0 #IR ))) ;4 BL

[6] weight: 0 distance: 268435455
(assert (= @s    (bv-extract 30 29 #IR ))) ;5 BL

[7] weight: 1 distance: 268435455
[S] 8 9

[8] weight: 0 distance: 268435455
(assert (= (bv-comp #reset  0b1)   0b1)) ;6 BR
(assert (= @IR    0b0000000000000000000000000000000)) ;8 NB
(assert (= @d    0b00)) ;9 NB
(assert (= @rx    0b0000000000000000000000000000000)) ;10 NB
(assert (= @m    0b0000000000000000000000000000000)) ;11 NB
(assert (= @B    0b0)) ;12 NB
(assert (= @reg0    0b0000000000000000000000000000000)) ;13 NB
(assert (= @reg1    0b0000000000000000000000000000000)) ;14 NB
(assert (= @reg2    0b0000000000000000000000000000000)) ;15 NB
(assert (= @reg3    0b0000000000000000000000000000000)) ;16 NB
(assert (= @addr    0b00000000000000000000)) ;17 NB
(assert (= @rd    0b0)) ;18 NB
(assert (= @wr    0b0)) ;19 NB
(assert (= @datao    0b0000000000000000000000000000000)) ;20 NB
(assert (= @state    0b0)) ;21 NB
[S] 10
[P] 7

[9] weight: 1 distance: 268435455
(assert (= (bv-comp #reset  0b1)   0b0)) ;7 BR
[S] 12 18
[P] 7

[10] weight: 0 distance: 268435455
[P] 8 11

[11] weight: 0 distance: 268435455
[S] 10
[P] 13 19

[12] weight: 1 distance: 268435455
(assert (= #state    0b0)) ;22 CS
(assert (= @addr    (bv-extract 19 0 #reg3 ))) ;23 NB
(assert (= @rd    0b1)) ;24 NB
(assert (= @IR    #datai )) ;25 NB
(assert (= @state    0b1)) ;26 NB
[S] 14 15 16 17
[P] 9

[13] weight: 0 distance: 268435455
[S] 11
[P] 14 15 16 17

[14] weight: 0 distance: 268435455
(assert (= (bv-extract 30 29 #datai )   0b00)) ;27 CS
(assert (= @rx    #reg0 )) ;28 NB
[S] 13
[P] 12

[15] weight: 0 distance: 268435455
(assert (= (bv-extract 30 29 #datai )   0b01)) ;29 CS
(assert (= @rx    #reg1 )) ;30 NB
[S] 13
[P] 12

[16] weight: 0 distance: 268435455
(assert (= (bv-extract 30 29 #datai )   0b10)) ;31 CS
(assert (= @rx    #reg2 )) ;32 NB
[S] 13
[P] 12

[17] weight: 0 distance: 268435455
(assert (= (bv-extract 30 29 #datai )   0b11)) ;33 CS
(assert (= @rx    #reg3 )) ;34 NB
[S] 13
[P] 12

[18] weight: 1 distance: 268435455
(assert (= #state    0b1)) ;35 CS
[S] 20 103
[P] 9

[19] weight: 0 distance: 268435455
(assert (= @state    0b0)) ;455 NB
[S] 11
[P] 26 106

[20] weight: 1 distance: 268435455
(assert (= #cf    0b1)) ;36 CS
[S] 25 22 23 24
[P] 18

[21] weight: 1 distance: 268435455
[S] 31 27 35 39 43 47 51 96 58 65 69 73 77 81 85 89
[P] 25 22 23 24

[22] weight: 0 distance: 268435455
(assert (= #mf    0b00)) ;37 CS
(assert (= @m    (bv-concat 0b00000000000 #tail ))) ;38 BL
[S] 21
[P] 20

[23] weight: 0 distance: 268435455
(assert (= #mf    0b01)) ;39 CS
(assert (= @m    #datai )) ;40 BL
(assert (= @addr    #tail )) ;41 NB
(assert (= @rd    0b1)) ;42 NB
[S] 21
[P] 20

[24] weight: 0 distance: 268435455
(assert (= #mf    0b10)) ;43 CS
(assert (= @addr    (bv-add #tail  (bv-extract 19 0 #reg1 )))) ;44 NB
(assert (= @rd    0b1)) ;45 NB
(assert (= @m    #datai )) ;46 BL
[S] 21
[P] 20

[25] weight: 0 distance: 268435455
(assert (= #mf    0b11)) ;47 CS
(assert (= @addr    (bv-add #tail  (bv-extract 19 0 #reg2 )))) ;48 NB
(assert (= @rd    0b1)) ;49 NB
(assert (= @m    #datai )) ;50 BL
[S] 21
[P] 20

[26] weight: 0 distance: 268435455
[S] 19
[P] 30 34 38 42 46 50 57 64 68 72 76 80 84 88 95 102

[27] weight: 1 distance: 268435455
(assert (= #ff    0b0000)) ;51 CS
[S] 28 29
[P] 21

[28] weight: 0 distance: 268435455
(assert (= (bool-to-bv (bv-lt #rx  #m ))   0b1)) ;52 BR
(assert (= @B    0b1)) ;54 NB
[S] 30
[P] 27

[29] weight: 0 distance: 268435455
(assert (= (bool-to-bv (bv-lt #rx  #m ))   0b0)) ;53 BR
(assert (= @B    0b0)) ;55 NB
[S] 30
[P] 27

[30] weight: 0 distance: 268435455
[S] 26
[P] 28 29

[31] weight: 1 distance: 268435455
(assert (= #ff    0b0001)) ;56 CS
[S] 32 33
[P] 21

[32] weight: 0 distance: 268435455
(assert (= (bool-to-bv (bv-ge #rx  #m ))   0b1)) ;57 BR
(assert (= @B    0b1)) ;59 NB
[S] 34
[P] 31

[33] weight: 0 distance: 268435455
(assert (= (bool-to-bv (bv-ge #rx  #m ))   0b0)) ;58 BR
(assert (= @B    0b0)) ;60 NB
[S] 34
[P] 31

[34] weight: 0 distance: 268435455
[S] 26
[P] 32 33

[35] weight: 1 distance: 268435455
(assert (= #ff    0b0010)) ;61 CS
[S] 36 37
[P] 21

[36] weight: 0 distance: 268435455
(assert (= (bv-comp #rx  #m )   0b1)) ;62 BR
(assert (= @B    0b1)) ;64 NB
[S] 38
[P] 35

[37] weight: 0 distance: 268435455
(assert (= (bv-comp #rx  #m )   0b0)) ;63 BR
(assert (= @B    0b0)) ;65 NB
[S] 38
[P] 35

[38] weight: 0 distance: 268435455
[S] 26
[P] 36 37

[39] weight: 1 distance: 268435455
(assert (= #ff    0b0011)) ;66 CS
[S] 40 41
[P] 21

[40] weight: 0 distance: 268435455
(assert (= (bv-not (bv-comp #rx  #m ))   0b1)) ;67 BR
(assert (= @B    0b1)) ;69 NB
[S] 42
[P] 39

[41] weight: 0 distance: 268435455
(assert (= (bv-not (bv-comp #rx  #m ))   0b0)) ;68 BR
(assert (= @B    0b0)) ;70 NB
[S] 42
[P] 39

[42] weight: 0 distance: 268435455
[S] 26
[P] 40 41

[43] weight: 1 distance: 268435455
(assert (= #ff    0b0100)) ;71 CS
[S] 44 45
[P] 21

[44] weight: 0 distance: 268435455
(assert (= (bool-to-bv (bv-le #rx  #m ))   0b1)) ;72 BR
(assert (= @B    0b1)) ;74 NB
[S] 46
[P] 43

[45] weight: 0 distance: 268435455
(assert (= (bool-to-bv (bv-le #rx  #m ))   0b0)) ;73 BR
(assert (= @B    0b0)) ;75 NB
[S] 46
[P] 43

[46] weight: 0 distance: 268435455
[S] 26
[P] 44 45

[47] weight: 1 distance: 268435455
(assert (= #ff    0b0101)) ;76 CS
[S] 48 49
[P] 21

[48] weight: 0 distance: 268435455
(assert (= (bool-to-bv (bv-gt #rx  #m ))   0b1)) ;77 BR
(assert (= @B    0b1)) ;79 NB
[S] 50
[P] 47

[49] weight: 0 distance: 268435455
(assert (= (bool-to-bv (bv-gt #rx  #m ))   0b0)) ;78 BR
(assert (= @B    0b0)) ;80 NB
[S] 50
[P] 47

[50] weight: 0 distance: 268435455
[S] 26
[P] 48 49

[51] weight: 1 distance: 268435455
(assert (= #ff    0b0110)) ;81 CS
[S] 52 53
[P] 21

[52] weight: 0 distance: 268435455
(assert (= (bool-to-bv (bv-gt #rx  0b0111111111111111111111111111111))   0b1)) ;82 BR
(assert (= @rx    #rx )) ;84 BL
[S] 54
[P] 51

[53] weight: 0 distance: 268435455
(assert (= (bool-to-bv (bv-gt #rx  0b0111111111111111111111111111111))   0b0)) ;83 BR
[S] 54
[P] 51

[54] weight: 1 distance: 268435455
[S] 55 56
[P] 52 53

[55] weight: 0 distance: 268435455
(assert (= (bool-to-bv (bv-lt #rx  #m ))   0b1)) ;85 BR
(assert (= @B    0b1)) ;87 NB
[S] 57
[P] 54

[56] weight: 0 distance: 268435455
(assert (= (bool-to-bv (bv-lt #rx  #m ))   0b0)) ;86 BR
(assert (= @B    0b0)) ;88 NB
[S] 57
[P] 54

[57] weight: 0 distance: 268435455
[S] 26
[P] 55 56

[58] weight: 1 distance: 268435455
(assert (= #ff    0b0111)) ;89 CS
[S] 59 60
[P] 21

[59] weight: 0 distance: 268435455
(assert (= (bool-to-bv (bv-gt #rx  0b0111111111111111111111111111111))   0b1)) ;90 BR
(assert (= @rx    #rx )) ;92 BL
[S] 61
[P] 58

[60] weight: 0 distance: 268435455
(assert (= (bool-to-bv (bv-gt #rx  0b0111111111111111111111111111111))   0b0)) ;91 BR
[S] 61
[P] 58

[61] weight: 1 distance: 268435455
[S] 62 63
[P] 59 60

[62] weight: 0 distance: 268435455
(assert (= (bool-to-bv (bv-ge #rx  #m ))   0b1)) ;93 BR
(assert (= @B    0b1)) ;95 NB
[S] 64
[P] 61

[63] weight: 0 distance: 268435455
(assert (= (bool-to-bv (bv-ge #rx  #m ))   0b0)) ;94 BR
(assert (= @B    0b0)) ;96 NB
[S] 64
[P] 61

[64] weight: 0 distance: 268435455
[S] 26
[P] 62 63

[65] weight: 1 distance: 268435455
(assert (= #ff    0b1000)) ;97 CS
[S] 66 67
[P] 21

[66] weight: 0 distance: 268435455
(assert (= (bv-or (bool-to-bv (bv-lt #rx  #m )) (bv-comp #B  0b1))   0b1)) ;98 BR
(assert (= @B    0b1)) ;100 NB
[S] 68
[P] 65

[67] weight: 0 distance: 268435455
(assert (= (bv-or (bool-to-bv (bv-lt #rx  #m )) (bv-comp #B  0b1))   0b0)) ;99 BR
(assert (= @B    0b0)) ;101 NB
[S] 68
[P] 65

[68] weight: 0 distance: 268435455
[S] 26
[P] 66 67

[69] weight: 1 distance: 268435455
(assert (= #ff    0b1001)) ;102 CS
[S] 70 71
[P] 21

[70] weight: 0 distance: 268435455
(assert (= (bv-or (bv-not (bv-redor (bool-to-bv (bv-lt #rx  #m )))) (bv-comp #B  0b1))   0b1)) ;103 BR
(assert (= @B    0b1)) ;105 NB
[S] 72
[P] 69

[71] weight: 0 distance: 268435455
(assert (= (bv-or (bv-not (bv-redor (bool-to-bv (bv-lt #rx  #m )))) (bv-comp #B  0b1))   0b0)) ;104 BR
(assert (= @B    0b0)) ;106 NB
[S] 72
[P] 69

[72] weight: 0 distance: 268435455
[S] 26
[P] 70 71

[73] weight: 1 distance: 268435455
(assert (= #ff    0b1010)) ;107 CS
[S] 74 75
[P] 21

[74] weight: 0 distance: 268435455
(assert (= (bv-or (bv-comp #rx  #m ) (bv-comp #B  0b1))   0b1)) ;108 BR
(assert (= @B    0b1)) ;110 NB
[S] 76
[P] 73

[75] weight: 0 distance: 268435455
(assert (= (bv-or (bv-comp #rx  #m ) (bv-comp #B  0b1))   0b0)) ;109 BR
(assert (= @B    0b0)) ;111 NB
[S] 76
[P] 73

[76] weight: 0 distance: 268435455
[S] 26
[P] 74 75

[77] weight: 1 distance: 268435455
(assert (= #ff    0b1011)) ;112 CS
[S] 78 79
[P] 21

[78] weight: 0 distance: 268435455
(assert (= (bv-or (bv-not (bv-redor (bv-comp #rx  #m ))) (bv-comp #B  0b1))   0b1)) ;113 BR
(assert (= @B    0b1)) ;115 NB
[S] 80
[P] 77

[79] weight: 0 distance: 268435455
(assert (= (bv-or (bv-not (bv-redor (bv-comp #rx  #m ))) (bv-comp #B  0b1))   0b0)) ;114 BR
(assert (= @B    0b0)) ;116 NB
[S] 80
[P] 77

[80] weight: 0 distance: 268435455
[S] 26
[P] 78 79

[81] weight: 1 distance: 268435455
(assert (= #ff    0b1100)) ;117 CS
[S] 82 83
[P] 21

[82] weight: 0 distance: 268435455
(assert (= (bv-or (bv-not (bv-redor (bool-to-bv (bv-gt #rx  #m )))) (bv-comp #B  0b1))   0b1)) ;118 BR
(assert (= @B    0b1)) ;120 NB
[S] 84
[P] 81

[83] weight: 0 distance: 268435455
(assert (= (bv-or (bv-not (bv-redor (bool-to-bv (bv-gt #rx  #m )))) (bv-comp #B  0b1))   0b0)) ;119 BR
(assert (= @B    0b0)) ;121 NB
[S] 84
[P] 81

[84] weight: 0 distance: 268435455
[S] 26
[P] 82 83

[85] weight: 1 distance: 268435455
(assert (= #ff    0b1101)) ;122 CS
[S] 86 87
[P] 21

[86] weight: 0 distance: 268435455
(assert (= (bv-or (bool-to-bv (bv-gt #rx  #m )) (bv-comp #B  0b1))   0b1)) ;123 BR
(assert (= @B    0b1)) ;125 NB
[S] 88
[P] 85

[87] weight: 0 distance: 268435455
(assert (= (bv-or (bool-to-bv (bv-gt #rx  #m )) (bv-comp #B  0b1))   0b0)) ;124 BR
(assert (= @B    0b0)) ;126 NB
[S] 88
[P] 85

[88] weight: 0 distance: 268435455
[S] 26
[P] 86 87

[89] weight: 1 distance: 268435455
(assert (= #ff    0b1110)) ;127 CS
[S] 90 91
[P] 21

[90] weight: 0 distance: 268435455
(assert (= (bool-to-bv (bv-gt #rx  0b0111111111111111111111111111111))   0b1)) ;128 BR
(assert (= @rx    #rx )) ;130 BL
[S] 92
[P] 89

[91] weight: 0 distance: 268435455
(assert (= (bool-to-bv (bv-gt #rx  0b0111111111111111111111111111111))   0b0)) ;129 BR
[S] 92
[P] 89

[92] weight: 1 distance: 268435455
[S] 93 94
[P] 90 91

[93] weight: 0 distance: 268435455
(assert (= (bv-or (bool-to-bv (bv-lt #rx  #m )) (bv-comp #B  0b1))   0b1)) ;131 BR
(assert (= @B    0b1)) ;133 NB
[S] 95
[P] 92

[94] weight: 0 distance: 268435455
(assert (= (bv-or (bool-to-bv (bv-lt #rx  #m )) (bv-comp #B  0b1))   0b0)) ;132 BR
(assert (= @B    0b0)) ;134 NB
[S] 95
[P] 92

[95] weight: 0 distance: 268435455
[S] 26
[P] 93 94

[96] weight: 1 distance: 268435455
(assert (= #ff    0b1111)) ;135 CS
[S] 97 98
[P] 21

[97] weight: 0 distance: 268435455
(assert (= (bool-to-bv (bv-gt #rx  0b0111111111111111111111111111111))   0b1)) ;136 BR
(assert (= @rx    #rx )) ;138 BL
[S] 99
[P] 96

[98] weight: 0 distance: 268435455
(assert (= (bool-to-bv (bv-gt #rx  0b0111111111111111111111111111111))   0b0)) ;137 BR
[S] 99
[P] 96

[99] weight: 1 distance: 268435455
[S] 100 101
[P] 97 98

[100] weight: 0 distance: 268435455
(assert (= (bv-or (bv-not (bv-redor (bool-to-bv (bv-lt #rx  #m )))) (bv-comp #B  0b1))   0b1)) ;139 BR
(assert (= @B    0b1)) ;141 NB
[S] 102
[P] 99

[101] weight: 0 distance: 268435455
(assert (= (bv-or (bv-not (bv-redor (bool-to-bv (bv-lt #rx  #m )))) (bv-comp #B  0b1))   0b0)) ;140 BR
(assert (= @B    0b0)) ;142 NB
[S] 102
[P] 99

[102] weight: 0 distance: 268435455
[S] 26
[P] 100 101

[103] weight: 1 distance: 268435455
(assert (= #cf    0b0)) ;143 CS
[S] 104 105
[P] 18

[104] weight: 1 distance: 268435455
(assert (= (bv-not (bv-comp #df  0b111))   0b1)) ;144 BR
[S] 107 108
[P] 103

[105] weight: 1 distance: 268435455
(assert (= (bv-not (bv-comp #df  0b111))   0b0)) ;145 BR
[S] 252 253
[P] 103

[106] weight: 0 distance: 268435455
[S] 19
[P] 110 254

[107] weight: 0 distance: 268435455
(assert (= (bv-or (bv-and (bv-comp #df  0b101) (bv-comp #B  0b0)) (bv-and (bv-comp #df  0b100) (bv-comp #B  0b1)))   0b1)) ;146 BR
(assert (= @d    0b11)) ;148 BL
[S] 109
[P] 104

[108] weight: 0 distance: 268435455
(assert (= (bv-or (bv-and (bv-comp #df  0b101) (bv-comp #B  0b0)) (bv-and (bv-comp #df  0b100) (bv-comp #B  0b1)))   0b0)) ;147 BR
(assert (= @d    (bv-extract 1 0 #df ))) ;149 BL
[S] 109
[P] 104

[109] weight: 1 distance: 268435455
[S] 111 122 128 139 150 161 172 183 194 205 216 227 238
[P] 107 108

[110] weight: 0 distance: 268435455
[S] 106
[P] 145 117 123 178 134 156 167 189 200 211 222 233 247

[111] weight: 1 distance: 268435455
(assert (= #ff    0b0000)) ;150 CS
[S] 113 114 115 116
[P] 109

[112] weight: 1 distance: 268435455
(assert (= @t    0b0000000000000000000000000000000)) ;165 BL
[S] 118 119 120 121
[P] 113 114 115 116

[113] weight: 0 distance: 268435455
(assert (= #mf    0b00)) ;151 CS
(assert (= @m    (bv-concat 0b00000000000 #tail ))) ;152 BL
[S] 112
[P] 111

[114] weight: 0 distance: 268435455
(assert (= #mf    0b01)) ;153 CS
(assert (= @m    #datai )) ;154 BL
(assert (= @addr    #tail )) ;155 NB
(assert (= @rd    0b1)) ;156 NB
[S] 112
[P] 111

[115] weight: 0 distance: 268435455
(assert (= #mf    0b10)) ;157 CS
(assert (= @addr    (bv-add #tail  (bv-extract 19 0 #reg1 )))) ;158 NB
(assert (= @rd    0b1)) ;159 NB
(assert (= @m    #datai )) ;160 BL
[S] 112
[P] 111

[116] weight: 0 distance: 268435455
(assert (= #mf    0b11)) ;161 CS
(assert (= @addr    (bv-add #tail  (bv-extract 19 0 #reg2 )))) ;162 NB
(assert (= @rd    0b1)) ;163 NB
(assert (= @m    #datai )) ;164 BL
[S] 112
[P] 111

[117] weight: 0 distance: 268435455
[S] 110
[P] 118 119 120 121

[118] weight: 0 distance: 268435455
(assert (= #d    0b00)) ;166 CS
(assert (= @reg0    (bv-sub #t  #m ))) ;167 BL
[S] 117
[P] 112

[119] weight: 0 distance: 268435455
(assert (= #d    0b01)) ;168 CS
(assert (= @reg1    (bv-sub #t  #m ))) ;169 BL
[S] 117
[P] 112

[120] weight: 0 distance: 268435455
(assert (= #d    0b10)) ;170 CS
(assert (= @reg2    (bv-sub #t  #m ))) ;171 BL
[S] 117
[P] 112

[121] weight: 0 distance: 268435455
(assert (= #d    0b11)) ;172 CS
(assert (= @reg3    (bv-sub #t  #m ))) ;173 BL
[S] 117
[P] 112

[122] weight: 1 distance: 268435455
(assert (= #ff    0b0001)) ;174 CS
[S] 126 124 125 127
[P] 109

[123] weight: 0 distance: 268435455
(assert (= @reg2    #reg3 )) ;189 BL
(assert (= @reg3    #m )) ;190 BL
[S] 110
[P] 126 124 125 127

[124] weight: 0 distance: 268435455
(assert (= #mf    0b00)) ;175 CS
(assert (= @m    (bv-concat 0b00000000000 #tail ))) ;176 BL
[S] 123
[P] 122

[125] weight: 0 distance: 268435455
(assert (= #mf    0b01)) ;177 CS
(assert (= @m    #datai )) ;178 BL
(assert (= @addr    #tail )) ;179 NB
(assert (= @rd    0b1)) ;180 NB
[S] 123
[P] 122

[126] weight: 0 distance: 268435455
(assert (= #mf    0b10)) ;181 CS
(assert (= @addr    (bv-add #tail  (bv-extract 19 0 #reg1 )))) ;182 NB
(assert (= @rd    0b1)) ;183 NB
(assert (= @m    #datai )) ;184 BL
[S] 123
[P] 122

[127] weight: 0 distance: 268435455
(assert (= #mf    0b11)) ;185 CS
(assert (= @addr    (bv-add #tail  (bv-extract 19 0 #reg2 )))) ;186 NB
(assert (= @rd    0b1)) ;187 NB
(assert (= @m    #datai )) ;188 BL
[S] 123
[P] 122

[128] weight: 1 distance: 268435455
(assert (= #ff    0b0010)) ;191 CS
[S] 130 131 132 133
[P] 109

[129] weight: 1 distance: 268435455
[S] 135 136 137 138
[P] 130 131 132 133

[130] weight: 0 distance: 268435455
(assert (= #mf    0b00)) ;192 CS
(assert (= @m    (bv-concat 0b00000000000 #tail ))) ;193 BL
[S] 129
[P] 128

[131] weight: 0 distance: 268435455
(assert (= #mf    0b01)) ;194 CS
(assert (= @m    #datai )) ;195 BL
(assert (= @addr    #tail )) ;196 NB
(assert (= @rd    0b1)) ;197 NB
[S] 129
[P] 128

[132] weight: 0 distance: 268435455
(assert (= #mf    0b10)) ;198 CS
(assert (= @addr    (bv-add #tail  (bv-extract 19 0 #reg1 )))) ;199 NB
(assert (= @rd    0b1)) ;200 NB
(assert (= @m    #datai )) ;201 BL
[S] 129
[P] 128

[133] weight: 0 distance: 268435455
(assert (= #mf    0b11)) ;202 CS
(assert (= @addr    (bv-add #tail  (bv-extract 19 0 #reg2 )))) ;203 NB
(assert (= @rd    0b1)) ;204 NB
(assert (= @m    #datai )) ;205 BL
[S] 129
[P] 128

[134] weight: 0 distance: 268435455
[S] 110
[P] 135 136 137 138

[135] weight: 0 distance: 268435455
(assert (= #d    0b00)) ;206 CS
(assert (= @reg0    #m )) ;207 BL
[S] 134
[P] 129

[136] weight: 0 distance: 268435455
(assert (= #d    0b01)) ;208 CS
(assert (= @reg1    #m )) ;209 BL
[S] 134
[P] 129

[137] weight: 0 distance: 268435455
(assert (= #d    0b10)) ;210 CS
(assert (= @reg2    #m )) ;211 BL
[S] 134
[P] 129

[138] weight: 0 distance: 268435455
(assert (= #d    0b11)) ;212 CS
(assert (= @reg3    #m )) ;213 BL
[S] 134
[P] 129

[139] weight: 1 distance: 268435455
(assert (= #ff    0b0011)) ;214 CS
[S] 141 142 143 144
[P] 109

[140] weight: 1 distance: 268435455
[S] 146 147 148 149
[P] 141 142 143 144

[141] weight: 0 distance: 268435455
(assert (= #mf    0b00)) ;215 CS
(assert (= @m    (bv-concat 0b00000000000 #tail ))) ;216 BL
[S] 140
[P] 139

[142] weight: 0 distance: 268435455
(assert (= #mf    0b01)) ;217 CS
(assert (= @m    #datai )) ;218 BL
(assert (= @addr    #tail )) ;219 NB
(assert (= @rd    0b1)) ;220 NB
[S] 140
[P] 139

[143] weight: 0 distance: 268435455
(assert (= #mf    0b10)) ;221 CS
(assert (= @addr    (bv-add #tail  (bv-extract 19 0 #reg1 )))) ;222 NB
(assert (= @rd    0b1)) ;223 NB
(assert (= @m    #datai )) ;224 BL
[S] 140
[P] 139

[144] weight: 0 distance: 268435455
(assert (= #mf    0b11)) ;225 CS
(assert (= @addr    (bv-add #tail  (bv-extract 19 0 #reg2 )))) ;226 NB
(assert (= @rd    0b1)) ;227 NB
(assert (= @m    #datai )) ;228 BL
[S] 140
[P] 139

[145] weight: 0 distance: 268435455
[S] 110
[P] 146 147 148 149

[146] weight: 0 distance: 268435455
(assert (= #d    0b00)) ;229 CS
(assert (= @reg0    #m )) ;230 BL
[S] 145
[P] 140

[147] weight: 0 distance: 268435455
(assert (= #d    0b01)) ;231 CS
(assert (= @reg1    #m )) ;232 BL
[S] 145
[P] 140

[148] weight: 0 distance: 268435455
(assert (= #d    0b10)) ;233 CS
(assert (= @reg2    #m )) ;234 BL
[S] 145
[P] 140

[149] weight: 0 distance: 268435455
(assert (= #d    0b11)) ;235 CS
(assert (= @reg3    #m )) ;236 BL
[S] 145
[P] 140

[150] weight: 1 distance: 268435455
(assert (= #ff    0b0100)) ;237 CS
[S] 152 153 154 155
[P] 109

[151] weight: 1 distance: 268435455
[S] 159 157 158 160
[P] 152 153 154 155

[152] weight: 0 distance: 268435455
(assert (= #mf    0b00)) ;238 CS
(assert (= @m    (bv-concat 0b00000000000 #tail ))) ;239 BL
[S] 151
[P] 150

[153] weight: 0 distance: 268435455
(assert (= #mf    0b01)) ;240 CS
(assert (= @m    #datai )) ;241 BL
(assert (= @addr    #tail )) ;242 NB
(assert (= @rd    0b1)) ;243 NB
[S] 151
[P] 150

[154] weight: 0 distance: 268435455
(assert (= #mf    0b10)) ;244 CS
(assert (= @addr    (bv-add #tail  (bv-extract 19 0 #reg1 )))) ;245 NB
(assert (= @rd    0b1)) ;246 NB
(assert (= @m    #datai )) ;247 BL
[S] 151
[P] 150

[155] weight: 0 distance: 268435455
(assert (= #mf    0b11)) ;248 CS
(assert (= @addr    (bv-add #tail  (bv-extract 19 0 #reg2 )))) ;249 NB
(assert (= @rd    0b1)) ;250 NB
(assert (= @m    #datai )) ;251 BL
[S] 151
[P] 150

[156] weight: 0 distance: 268435455
[S] 110
[P] 159 157 158 160

[157] weight: 0 distance: 268435455
(assert (= #d    0b00)) ;252 CS
(assert (= @reg0    (bv-add #rx  #m ))) ;253 BL
[S] 156
[P] 151

[158] weight: 0 distance: 268435455
(assert (= #d    0b01)) ;254 CS
(assert (= @reg1    (bv-add #rx  #m ))) ;255 BL
[S] 156
[P] 151

[159] weight: 0 distance: 268435455
(assert (= #d    0b10)) ;256 CS
(assert (= @reg2    (bv-add #rx  #m ))) ;257 BL
[S] 156
[P] 151

[160] weight: 0 distance: 268435455
(assert (= #d    0b11)) ;258 CS
(assert (= @reg3    (bv-add #rx  #m ))) ;259 BL
[S] 156
[P] 151

[161] weight: 1 distance: 268435455
(assert (= #ff    0b0101)) ;260 CS
[S] 163 164 165 166
[P] 109

[162] weight: 1 distance: 268435455
[S] 168 169 170 171
[P] 163 164 165 166

[163] weight: 0 distance: 268435455
(assert (= #mf    0b00)) ;261 CS
(assert (= @m    (bv-concat 0b00000000000 #tail ))) ;262 BL
[S] 162
[P] 161

[164] weight: 0 distance: 268435455
(assert (= #mf    0b01)) ;263 CS
(assert (= @m    #datai )) ;264 BL
(assert (= @addr    #tail )) ;265 NB
(assert (= @rd    0b1)) ;266 NB
[S] 162
[P] 161

[165] weight: 0 distance: 268435455
(assert (= #mf    0b10)) ;267 CS
(assert (= @addr    (bv-add #tail  (bv-extract 19 0 #reg1 )))) ;268 NB
(assert (= @rd    0b1)) ;269 NB
(assert (= @m    #datai )) ;270 BL
[S] 162
[P] 161

[166] weight: 0 distance: 268435455
(assert (= #mf    0b11)) ;271 CS
(assert (= @addr    (bv-add #tail  (bv-extract 19 0 #reg2 )))) ;272 NB
(assert (= @rd    0b1)) ;273 NB
(assert (= @m    #datai )) ;274 BL
[S] 162
[P] 161

[167] weight: 0 distance: 268435455
[S] 110
[P] 168 169 170 171

[168] weight: 0 distance: 268435455
(assert (= #d    0b00)) ;275 CS
(assert (= @reg0    (bv-add #rx  #m ))) ;276 BL
[S] 167
[P] 162

[169] weight: 0 distance: 268435455
(assert (= #d    0b01)) ;277 CS
(assert (= @reg1    (bv-add #rx  #m ))) ;278 BL
[S] 167
[P] 162

[170] weight: 0 distance: 268435455
(assert (= #d    0b10)) ;279 CS
(assert (= @reg2    (bv-add #rx  #m ))) ;280 BL
[S] 167
[P] 162

[171] weight: 0 distance: 268435455
(assert (= #d    0b11)) ;281 CS
(assert (= @reg3    (bv-add #rx  #m ))) ;282 BL
[S] 167
[P] 162

[172] weight: 1 distance: 268435455
(assert (= #ff    0b0110)) ;283 CS
[S] 177 174 175 176
[P] 109

[173] weight: 1 distance: 268435455
[S] 179 180 181 182
[P] 177 174 175 176

[174] weight: 0 distance: 268435455
(assert (= #mf    0b00)) ;284 CS
(assert (= @m    (bv-concat 0b00000000000 #tail ))) ;285 BL
[S] 173
[P] 172

[175] weight: 0 distance: 268435455
(assert (= #mf    0b01)) ;286 CS
(assert (= @m    #datai )) ;287 BL
(assert (= @addr    #tail )) ;288 NB
(assert (= @rd    0b1)) ;289 NB
[S] 173
[P] 172

[176] weight: 0 distance: 268435455
(assert (= #mf    0b10)) ;290 CS
(assert (= @addr    (bv-add #tail  (bv-extract 19 0 #reg1 )))) ;291 NB
(assert (= @rd    0b1)) ;292 NB
(assert (= @m    #datai )) ;293 BL
[S] 173
[P] 172

[177] weight: 0 distance: 268435455
(assert (= #mf    0b11)) ;294 CS
(assert (= @addr    (bv-add #tail  (bv-extract 19 0 #reg2 )))) ;295 NB
(assert (= @rd    0b1)) ;296 NB
(assert (= @m    #datai )) ;297 BL
[S] 173
[P] 172

[178] weight: 0 distance: 268435455
[S] 110
[P] 179 180 181 182

[179] weight: 0 distance: 268435455
(assert (= #d    0b00)) ;298 CS
(assert (= @reg0    (bv-sub #rx  #m ))) ;299 BL
[S] 178
[P] 173

[180] weight: 0 distance: 268435455
(assert (= #d    0b01)) ;300 CS
(assert (= @reg1    (bv-sub #rx  #m ))) ;301 BL
[S] 178
[P] 173

[181] weight: 0 distance: 268435455
(assert (= #d    0b10)) ;302 CS
(assert (= @reg2    (bv-sub #rx  #m ))) ;303 BL
[S] 178
[P] 173

[182] weight: 0 distance: 268435455
(assert (= #d    0b11)) ;304 CS
(assert (= @reg3    (bv-sub #rx  #m ))) ;305 BL
[S] 178
[P] 173

[183] weight: 1 distance: 268435455
(assert (= #ff    0b0111)) ;306 CS
[S] 185 186 187 188
[P] 109

[184] weight: 1 distance: 268435455
[S] 190 191 192 193
[P] 185 186 187 188

[185] weight: 0 distance: 268435455
(assert (= #mf    0b00)) ;307 CS
(assert (= @m    (bv-concat 0b00000000000 #tail ))) ;308 BL
[S] 184
[P] 183

[186] weight: 0 distance: 268435455
(assert (= #mf    0b01)) ;309 CS
(assert (= @m    #datai )) ;310 BL
(assert (= @addr    #tail )) ;311 NB
(assert (= @rd    0b1)) ;312 NB
[S] 184
[P] 183

[187] weight: 0 distance: 268435455
(assert (= #mf    0b10)) ;313 CS
(assert (= @addr    (bv-add #tail  (bv-extract 19 0 #reg1 )))) ;314 NB
(assert (= @rd    0b1)) ;315 NB
(assert (= @m    #datai )) ;316 BL
[S] 184
[P] 183

[188] weight: 0 distance: 268435455
(assert (= #mf    0b11)) ;317 CS
(assert (= @addr    (bv-add #tail  (bv-extract 19 0 #reg2 )))) ;318 NB
(assert (= @rd    0b1)) ;319 NB
(assert (= @m    #datai )) ;320 BL
[S] 184
[P] 183

[189] weight: 0 distance: 268435455
[S] 110
[P] 190 191 192 193

[190] weight: 0 distance: 268435455
(assert (= #d    0b00)) ;321 CS
(assert (= @reg0    (bv-sub #rx  #m ))) ;322 BL
[S] 189
[P] 184

[191] weight: 0 distance: 268435455
(assert (= #d    0b01)) ;323 CS
(assert (= @reg1    (bv-sub #rx  #m ))) ;324 BL
[S] 189
[P] 184

[192] weight: 0 distance: 268435455
(assert (= #d    0b10)) ;325 CS
(assert (= @reg2    (bv-sub #rx  #m ))) ;326 BL
[S] 189
[P] 184

[193] weight: 0 distance: 268435455
(assert (= #d    0b11)) ;327 CS
(assert (= @reg3    (bv-sub #rx  #m ))) ;328 BL
[S] 189
[P] 184

[194] weight: 1 distance: 268435455
(assert (= #ff    0b1000)) ;329 CS
[S] 196 197 198 199
[P] 109

[195] weight: 1 distance: 268435455
[S] 201 202 203 204
[P] 196 197 198 199

[196] weight: 0 distance: 268435455
(assert (= #mf    0b00)) ;330 CS
(assert (= @m    (bv-concat 0b00000000000 #tail ))) ;331 BL
[S] 195
[P] 194

[197] weight: 0 distance: 268435455
(assert (= #mf    0b01)) ;332 CS
(assert (= @m    #datai )) ;333 BL
(assert (= @addr    #tail )) ;334 NB
(assert (= @rd    0b1)) ;335 NB
[S] 195
[P] 194

[198] weight: 0 distance: 268435455
(assert (= #mf    0b10)) ;336 CS
(assert (= @addr    (bv-add #tail  (bv-extract 19 0 #reg1 )))) ;337 NB
(assert (= @rd    0b1)) ;338 NB
(assert (= @m    #datai )) ;339 BL
[S] 195
[P] 194

[199] weight: 0 distance: 268435455
(assert (= #mf    0b11)) ;340 CS
(assert (= @addr    (bv-add #tail  (bv-extract 19 0 #reg2 )))) ;341 NB
(assert (= @rd    0b1)) ;342 NB
(assert (= @m    #datai )) ;343 BL
[S] 195
[P] 194

[200] weight: 0 distance: 268435455
[S] 110
[P] 201 202 203 204

[201] weight: 0 distance: 268435455
(assert (= #d    0b00)) ;344 CS
(assert (= @reg0    (bv-add #rx  #m ))) ;345 BL
[S] 200
[P] 195

[202] weight: 0 distance: 268435455
(assert (= #d    0b01)) ;346 CS
(assert (= @reg1    (bv-add #rx  #m ))) ;347 BL
[S] 200
[P] 195

[203] weight: 0 distance: 268435455
(assert (= #d    0b10)) ;348 CS
(assert (= @reg2    (bv-add #rx  #m ))) ;349 BL
[S] 200
[P] 195

[204] weight: 0 distance: 268435455
(assert (= #d    0b11)) ;350 CS
(assert (= @reg3    (bv-add #rx  #m ))) ;351 BL
[S] 200
[P] 195

[205] weight: 1 distance: 268435455
(assert (= #ff    0b1001)) ;352 CS
[S] 209 207 208 210
[P] 109

[206] weight: 1 distance: 268435455
[S] 212 213 214 215
[P] 209 207 208 210

[207] weight: 0 distance: 268435455
(assert (= #mf    0b00)) ;353 CS
(assert (= @m    (bv-concat 0b00000000000 #tail ))) ;354 BL
[S] 206
[P] 205

[208] weight: 0 distance: 268435455
(assert (= #mf    0b01)) ;355 CS
(assert (= @m    #datai )) ;356 BL
(assert (= @addr    #tail )) ;357 NB
(assert (= @rd    0b1)) ;358 NB
[S] 206
[P] 205

[209] weight: 0 distance: 268435455
(assert (= #mf    0b10)) ;359 CS
(assert (= @addr    (bv-add #tail  (bv-extract 19 0 #reg1 )))) ;360 NB
(assert (= @rd    0b1)) ;361 NB
(assert (= @m    #datai )) ;362 BL
[S] 206
[P] 205

[210] weight: 0 distance: 268435455
(assert (= #mf    0b11)) ;363 CS
(assert (= @addr    (bv-add #tail  (bv-extract 19 0 #reg2 )))) ;364 NB
(assert (= @rd    0b1)) ;365 NB
(assert (= @m    #datai )) ;366 BL
[S] 206
[P] 205

[211] weight: 0 distance: 268435455
[S] 110
[P] 212 213 214 215

[212] weight: 0 distance: 268435455
(assert (= #d    0b00)) ;367 CS
(assert (= @reg0    (bv-sub #rx  #m ))) ;368 BL
[S] 211
[P] 206

[213] weight: 0 distance: 268435455
(assert (= #d    0b01)) ;369 CS
(assert (= @reg1    (bv-sub #rx  #m ))) ;370 BL
[S] 211
[P] 206

[214] weight: 0 distance: 268435455
(assert (= #d    0b10)) ;371 CS
(assert (= @reg2    (bv-sub #rx  #m ))) ;372 BL
[S] 211
[P] 206

[215] weight: 0 distance: 268435455
(assert (= #d    0b11)) ;373 CS
(assert (= @reg3    (bv-sub #rx  #m ))) ;374 BL
[S] 211
[P] 206

[216] weight: 1 distance: 268435455
(assert (= #ff    0b1010)) ;375 CS
[S] 218 219 220 221
[P] 109

[217] weight: 1 distance: 268435455
[S] 223 224 225 226
[P] 218 219 220 221

[218] weight: 0 distance: 268435455
(assert (= #mf    0b00)) ;376 CS
(assert (= @m    (bv-concat 0b00000000000 #tail ))) ;377 BL
[S] 217
[P] 216

[219] weight: 0 distance: 268435455
(assert (= #mf    0b01)) ;378 CS
(assert (= @m    #datai )) ;379 BL
(assert (= @addr    #tail )) ;380 NB
(assert (= @rd    0b1)) ;381 NB
[S] 217
[P] 216

[220] weight: 0 distance: 268435455
(assert (= #mf    0b10)) ;382 CS
(assert (= @addr    (bv-add #tail  (bv-extract 19 0 #reg1 )))) ;383 NB
(assert (= @rd    0b1)) ;384 NB
(assert (= @m    #datai )) ;385 BL
[S] 217
[P] 216

[221] weight: 0 distance: 268435455
(assert (= #mf    0b11)) ;386 CS
(assert (= @addr    (bv-add #tail  (bv-extract 19 0 #reg2 )))) ;387 NB
(assert (= @rd    0b1)) ;388 NB
(assert (= @m    #datai )) ;389 BL
[S] 217
[P] 216

[222] weight: 0 distance: 268435455
[S] 110
[P] 223 224 225 226

[223] weight: 0 distance: 268435455
(assert (= #d    0b00)) ;390 CS
(assert (= @reg0    (bv-add #rx  #m ))) ;391 BL
[S] 222
[P] 217

[224] weight: 0 distance: 268435455
(assert (= #d    0b01)) ;392 CS
(assert (= @reg1    (bv-add #rx  #m ))) ;393 BL
[S] 222
[P] 217

[225] weight: 0 distance: 268435455
(assert (= #d    0b10)) ;394 CS
(assert (= @reg2    (bv-add #rx  #m ))) ;395 BL
[S] 222
[P] 217

[226] weight: 0 distance: 268435455
(assert (= #d    0b11)) ;396 CS
(assert (= @reg3    (bv-add #rx  #m ))) ;397 BL
[S] 222
[P] 217

[227] weight: 1 distance: 268435455
(assert (= #ff    0b1011)) ;398 CS
[S] 229 230 231 232
[P] 109

[228] weight: 1 distance: 268435455
[S] 234 235 236 237
[P] 229 230 231 232

[229] weight: 0 distance: 268435455
(assert (= #mf    0b00)) ;399 CS
(assert (= @m    (bv-concat 0b00000000000 #tail ))) ;400 BL
[S] 228
[P] 227

[230] weight: 0 distance: 268435455
(assert (= #mf    0b01)) ;401 CS
(assert (= @m    #datai )) ;402 BL
(assert (= @addr    #tail )) ;403 NB
(assert (= @rd    0b1)) ;404 NB
[S] 228
[P] 227

[231] weight: 0 distance: 268435455
(assert (= #mf    0b10)) ;405 CS
(assert (= @addr    (bv-add #tail  (bv-extract 19 0 #reg1 )))) ;406 NB
(assert (= @rd    0b1)) ;407 NB
(assert (= @m    #datai )) ;408 BL
[S] 228
[P] 227

[232] weight: 0 distance: 268435455
(assert (= #mf    0b11)) ;409 CS
(assert (= @addr    (bv-add #tail  (bv-extract 19 0 #reg2 )))) ;410 NB
(assert (= @rd    0b1)) ;411 NB
(assert (= @m    #datai )) ;412 BL
[S] 228
[P] 227

[233] weight: 0 distance: 268435455
[S] 110
[P] 234 235 236 237

[234] weight: 0 distance: 268435455
(assert (= #d    0b00)) ;413 CS
(assert (= @reg0    (bv-sub #rx  #m ))) ;414 BL
[S] 233
[P] 228

[235] weight: 0 distance: 268435455
(assert (= #d    0b01)) ;415 CS
(assert (= @reg1    (bv-sub #rx  #m ))) ;416 BL
[S] 233
[P] 228

[236] weight: 0 distance: 268435455
(assert (= #d    0b10)) ;417 CS
(assert (= @reg2    (bv-sub #rx  #m ))) ;418 BL
[S] 233
[P] 228

[237] weight: 0 distance: 268435455
(assert (= #d    0b11)) ;419 CS
(assert (= @reg3    (bv-sub #rx  #m ))) ;420 BL
[S] 233
[P] 228

[238] weight: 1 distance: 268435455
(assert (= #ff    0b1100)) ;421 CS
[S] 240 241 242 243
[P] 109

[239] weight: 1 distance: 268435455
[S] 248 249 250 251
[P] 240 241 242 246

[240] weight: 0 distance: 268435455
(assert (= #mf    0b00)) ;422 CS
(assert (= @t    (bv-concat 0b0 (bv-extract 30 1 #rx )))) ;423 BL
[S] 239
[P] 238

[241] weight: 0 distance: 268435455
(assert (= #mf    0b01)) ;424 CS
(assert (= @t    (bv-concat 0b0 (ite (= (bv-comp #B  0b1) 0b1) 0b0 (bv-extract 30 30 #rx )) (bv-extract 29 1 #rx )))) ;425 BL
[S] 239
[P] 238

[242] weight: 0 distance: 268435455
(assert (= #mf    0b10)) ;426 CS
(assert (= @t    (bv-concat (bv-extract 29 0 #rx ) 0b0))) ;427 BL
[S] 239
[P] 238

[243] weight: 1 distance: 268435455
(assert (= #mf    0b11)) ;428 CS
(assert (= @t    (bv-concat (bv-extract 29 0 #rx ) 0b0))) ;429 BL
[S] 244 245
[P] 238

[244] weight: 0 distance: 268435455
(assert (= (bool-to-bv (bv-gt #t  0b0111111111111111111111111111111))   0b1)) ;430 BR
(assert (= @B    0b1)) ;432 NB
[S] 246
[P] 243

[245] weight: 0 distance: 268435455
(assert (= (bool-to-bv (bv-gt #t  0b0111111111111111111111111111111))   0b0)) ;431 BR
(assert (= @B    0b0)) ;433 NB
[S] 246
[P] 243

[246] weight: 0 distance: 268435455
[S] 239
[P] 244 245

[247] weight: 0 distance: 268435455
[S] 110
[P] 248 249 250 251

[248] weight: 0 distance: 268435455
(assert (= #d    0b00)) ;434 CS
(assert (= @reg0    #t )) ;435 NB
[S] 247
[P] 239

[249] weight: 0 distance: 268435455
(assert (= #d    0b01)) ;436 CS
(assert (= @reg1    #t )) ;437 NB
[S] 247
[P] 239

[250] weight: 0 distance: 268435455
(assert (= #d    0b10)) ;438 CS
(assert (= @reg2    #t )) ;439 NB
[S] 247
[P] 239

[251] weight: 0 distance: 268435455
(assert (= #d    0b11)) ;440 CS
(assert (= @reg3    #t )) ;441 NB
[S] 247
[P] 239

[252] weight: 1 distance: 268435455
(assert (= (bv-comp #df  0b111)   0b1)) ;442 BR
[S] 256 257 258 259
[P] 105

[253] weight: 0 distance: 268435455
(assert (= (bv-comp #df  0b111)   0b0)) ;443 BR
[S] 254
[P] 105

[254] weight: 0 distance: 268435455
[S] 106
[P] 253 255

[255] weight: 0 distance: 268435455
(assert (= @addr    (bv-extract 19 0 #m ))) ;452 NB
(assert (= @wr    0b1)) ;453 NB
(assert (= @datao    #rx )) ;454 NB
[S] 254
[P] 256 257 258 259

[256] weight: 0 distance: 268435455
(assert (= #mf    0b00)) ;444 CS
(assert (= @m    (bv-concat 0b00000000000 #tail ))) ;445 BL
[S] 255
[P] 252

[257] weight: 0 distance: 268435455
(assert (= #mf    0b01)) ;446 CS
(assert (= @m    (bv-concat 0b00000000000 #tail ))) ;447 BL
[S] 255
[P] 252

[258] weight: 0 distance: 268435455
(assert (= #mf    0b10)) ;448 CS
(assert (= @m    (bv-add #reg1  (bv-concat 0b00000000000 #tail )))) ;449 BL
[S] 255
[P] 252

[259] weight: 0 distance: 268435455
(assert (= #mf    0b11)) ;450 CS
(assert (= @m    (bv-add #reg2  (bv-concat 0b00000000000 #tail )))) ;451 BL
[S] 255
[P] 252

*/

endmodule

//state variables: B rd state wr

