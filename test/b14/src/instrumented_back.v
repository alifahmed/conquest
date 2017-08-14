// Following code segment is generated from ./src/b14.v:16
module b14(clock, reset, datai, addr, datao, rd, wr);
    input clock;
    input reset;
    input [30:0] datai;
    output [19:0] addr;
    output [30:0] datao;
    output rd;
    output wr;

    reg B;
    reg [30:0] IR;
    reg [19:0] addr;
    wire cf;
    wire clock;
    reg [1:0] d;
    wire [30:0] datai;
    reg [30:0] datao;
    wire [2:0] df;
    wire [3:0] ff;
    reg [30:0] m;
    wire [1:0] mf;
    reg rd;
    reg [30:0] reg0;
    reg [30:0] reg1;
    reg [30:0] reg2;
    reg [30:0] reg3;
    wire reset;
    reg [30:0] rx;
    wire [1:0] s;
    reg state;
    reg [30:0] t;
    wire [19:0] tail;
    reg wr;

    assign mf = IR[28:27];		//(assert (= mf_#   (bv-extract 28 27 IR_#))) ;0 AS
    assign df = IR[26:24];		//(assert (= df_#   (bv-extract 26 24 IR_#))) ;1 AS
    assign ff = IR[22:19];		//(assert (= ff_#   (bv-extract 22 19 IR_#))) ;2 AS
    assign cf = IR[23];		//(assert (= cf_#   (bv-extract 23 23 IR_#))) ;3 AS
    assign tail = IR[19:0];		//(assert (= tail_#   (bv-extract 19 0 IR_#))) ;4 AS
    assign s = IR[30:29];		//(assert (= s_#   (bv-extract 30 29 IR_#))) ;5 AS
    // Following code segment is generated from ./src/b14.v:72
    always @(posedge clock) begin
        if ((reset == 1'b1)) begin
            IR <= 31'b0000000000000000000000000000000; $display(";A 2");		//(assert (= IR_@   0b0000000000000000000000000000000)) ;2 NB
            d <= 2'b00; $display(";A 3");		//(assert (= d_@   0b00)) ;3 NB
            rx <= 31'b0000000000000000000000000000000; $display(";A 4");		//(assert (= rx_@   0b0000000000000000000000000000000)) ;4 NB
            m <= 31'b0000000000000000000000000000000; $display(";A 5");		//(assert (= m_@   0b0000000000000000000000000000000)) ;5 NB
            B <= 1'b0; $display(";A 6");		//(assert (= B_@   0b0)) ;6 NB
            reg0 <= 31'b0000000000000000000000000000000; $display(";A 7");		//(assert (= reg0_@   0b0000000000000000000000000000000)) ;7 NB
            reg1 <= 31'b0000000000000000000000000000000; $display(";A 8");		//(assert (= reg1_@   0b0000000000000000000000000000000)) ;8 NB
            reg2 <= 31'b0000000000000000000000000000000; $display(";A 9");		//(assert (= reg2_@   0b0000000000000000000000000000000)) ;9 NB
            reg3 <= 31'b0000000000000000000000000000000; $display(";A 10");		//(assert (= reg3_@   0b0000000000000000000000000000000)) ;10 NB
            addr <= 20'b00000000000000000000; $display(";A 11");		//(assert (= addr_@   0b00000000000000000000)) ;11 NB
            rd <= 1'b0; $display(";A 12");		//(assert (= rd_@   0b0)) ;12 NB
            wr <= 1'b0; $display(";A 13");		//(assert (= wr_@   0b0)) ;13 NB
            datao <= 31'b0000000000000000000000000000000; $display(";A 14");		//(assert (= datao_@   0b0000000000000000000000000000000)) ;14 NB
            state <= 1'b0; $display(";A 15");		//(assert (= state_@   0b0)) ;15 NB
        end
        else begin
            case (state)
                1'b0 :
                    begin
                        $display(";A 16");		//(assert (= state_#   0b0)) ;16 CS
                        addr <= reg3[19:0]; $display(";A 17");		//(assert (= addr_@   (bv-extract 19 0 reg3_#))) ;17 NB
                        rd <= 1'b1; $display(";A 18");		//(assert (= rd_@   0b1)) ;18 NB
                        IR <= datai; $display(";A 19");		//(assert (= IR_@   datai_#)) ;19 NB
                        state <= 1'b1; $display(";A 20");		//(assert (= state_@   0b1)) ;20 NB
                    end
                1'b1 :
                    begin
                        $display(";A 21");		//(assert (= state_#   0b1)) ;21 CS
                        case (s)
                            2'b00 :
                                begin
                                    $display(";A 22");		//(assert (= s_#   0b00)) ;22 CS
                                    rx = reg0; $display(";A 23");		//(assert (= rx_#   reg0_#)) ;23 BL
                                end
                            2'b01 :
                                begin
                                    $display(";A 24");		//(assert (= s_#   0b01)) ;24 CS
                                    rx = reg1; $display(";A 25");		//(assert (= rx_#   reg1_#)) ;25 BL
                                end
                            2'b10 :
                                begin
                                    $display(";A 26");		//(assert (= s_#   0b10)) ;26 CS
                                    rx = reg2; $display(";A 27");		//(assert (= rx_#   reg2_#)) ;27 BL
                                end
                            2'b11 :
                                begin
                                    $display(";A 28");		//(assert (= s_#   0b11)) ;28 CS
                                    rx = reg3; $display(";A 29");		//(assert (= rx_#   reg3_#)) ;29 BL
                                end
                        endcase
                        case (cf)
                            1'b1 :
                                begin
                                    $display(";A 30");		//(assert (= cf_#   0b1)) ;30 CS
                                    case (mf)
                                        2'b00 :
                                            begin
                                                $display(";A 31");		//(assert (= mf_#   0b00)) ;31 CS
                                                m = {11'b00000000000, tail}; $display(";A 32");		//(assert (= m_#   (bv-concat 0b00000000000 tail_#))) ;32 BL
                                            end
                                        2'b01 :
                                            begin
                                                $display(";A 33");		//(assert (= mf_#   0b01)) ;33 CS
                                                m = datai; $display(";A 34");		//(assert (= m_#   datai_#)) ;34 BL
                                                addr <= tail; $display(";A 35");		//(assert (= addr_@   tail_#)) ;35 NB
                                                rd <= 1'b1; $display(";A 36");		//(assert (= rd_@   0b1)) ;36 NB
                                            end
                                        2'b10 :
                                            begin
                                                $display(";A 37");		//(assert (= mf_#   0b10)) ;37 CS
                                                addr <= (tail + reg1[19:0]); $display(";A 38");		//(assert (= addr_@   (bv-add tail_# (bv-extract 19 0 reg1_#)))) ;38 NB
                                                rd <= 1'b1; $display(";A 39");		//(assert (= rd_@   0b1)) ;39 NB
                                                m = datai; $display(";A 40");		//(assert (= m_#   datai_#)) ;40 BL
                                            end
                                        2'b11 :
                                            begin
                                                $display(";A 41");		//(assert (= mf_#   0b11)) ;41 CS
                                                addr <= (tail + reg2[19:0]); $display(";A 42");		//(assert (= addr_@   (bv-add tail_# (bv-extract 19 0 reg2_#)))) ;42 NB
                                                rd <= 1'b1; $display(";A 43");		//(assert (= rd_@   0b1)) ;43 NB
                                                m = datai; $display(";A 44");		//(assert (= m_#   datai_#)) ;44 BL
                                            end
                                    endcase
                                    case (ff)
                                        4'b0000 :
                                            begin
                                                $display(";A 45");		//(assert (= ff_#   0b0000)) ;45 CS
                                                if ((rx < m)) begin
                                                    $display(";A 46");		//(assert (= (bool-to-bv (bv-lt rx_# m_#)) 0b1)) ;46 BR
                                                    B <= 1'b1; $display(";A 48");		//(assert (= B_@   0b1)) ;48 NB
                                                end
                                                else begin
                                                    $display(";A 47");		//(assert (= (bool-to-bv (bv-lt rx_# m_#)) 0b0)) ;47 BR
                                                    B <= 1'b0; $display(";A 49");		//(assert (= B_@   0b0)) ;49 NB
                                                end
                                            end
                                        4'b0001 :
                                            begin
                                                $display(";A 50");		//(assert (= ff_#   0b0001)) ;50 CS
                                                if ((rx >= m)) begin
                                                    $display(";A 51");		//(assert (= (bool-to-bv (bv-ge rx_# m_#)) 0b1)) ;51 BR
                                                    B <= 1'b1; $display(";A 53");		//(assert (= B_@   0b1)) ;53 NB
                                                end
                                                else begin
                                                    $display(";A 52");		//(assert (= (bool-to-bv (bv-ge rx_# m_#)) 0b0)) ;52 BR
                                                    B <= 1'b0; $display(";A 54");		//(assert (= B_@   0b0)) ;54 NB
                                                end
                                            end
                                        4'b0010 :
                                            begin
                                                $display(";A 55");		//(assert (= ff_#   0b0010)) ;55 CS
                                                if ((rx == m)) begin
                                                    $display(";A 56");		//(assert (= (bv-comp rx_# m_#) 0b1)) ;56 BR
                                                    B <= 1'b1; $display(";A 58");		//(assert (= B_@   0b1)) ;58 NB
                                                end
                                                else begin
                                                    $display(";A 57");		//(assert (= (bv-comp rx_# m_#) 0b0)) ;57 BR
                                                    B <= 1'b0; $display(";A 59");		//(assert (= B_@   0b0)) ;59 NB
                                                end
                                            end
                                        4'b0011 :
                                            begin
                                                $display(";A 60");		//(assert (= ff_#   0b0011)) ;60 CS
                                                if ((rx != m)) begin
                                                    $display(";A 61");		//(assert (= (bv-not (bv-comp rx_# m_#)) 0b1)) ;61 BR
                                                    B <= 1'b1; $display(";A 63");		//(assert (= B_@   0b1)) ;63 NB
                                                end
                                                else begin
                                                    $display(";A 62");		//(assert (= (bv-not (bv-comp rx_# m_#)) 0b0)) ;62 BR
                                                    B <= 1'b0; $display(";A 64");		//(assert (= B_@   0b0)) ;64 NB
                                                end
                                            end
                                        4'b0100 :
                                            begin
                                                $display(";A 65");		//(assert (= ff_#   0b0100)) ;65 CS
                                                if ((rx <= m)) begin
                                                    $display(";A 66");		//(assert (= (bool-to-bv (bv-le rx_# m_#)) 0b1)) ;66 BR
                                                    B <= 1'b1; $display(";A 68");		//(assert (= B_@   0b1)) ;68 NB
                                                end
                                                else begin
                                                    $display(";A 67");		//(assert (= (bool-to-bv (bv-le rx_# m_#)) 0b0)) ;67 BR
                                                    B <= 1'b0; $display(";A 69");		//(assert (= B_@   0b0)) ;69 NB
                                                end
                                            end
                                        4'b0101 :
                                            begin
                                                $display(";A 70");		//(assert (= ff_#   0b0101)) ;70 CS
                                                if ((rx > m)) begin
                                                    $display(";A 71");		//(assert (= (bool-to-bv (bv-gt rx_# m_#)) 0b1)) ;71 BR
                                                    B <= 1'b1; $display(";A 73");		//(assert (= B_@   0b1)) ;73 NB
                                                end
                                                else begin
                                                    $display(";A 72");		//(assert (= (bool-to-bv (bv-gt rx_# m_#)) 0b0)) ;72 BR
                                                    B <= 1'b0; $display(";A 74");		//(assert (= B_@   0b0)) ;74 NB
                                                end
                                            end
                                        4'b0110 :
                                            begin
                                                $display(";A 75");		//(assert (= ff_#   0b0110)) ;75 CS
                                                if ((rx > 31'b0111111111111111111111111111111)) begin
                                                    $display(";A 76");		//(assert (= (bool-to-bv (bv-gt rx_# 0b0111111111111111111111111111111)) 0b1)) ;76 BR
                                                    rx = rx; $display(";A 78");		//(assert (= rx_#   rx_#)) ;78 BL
                                                end
                                                else begin
                                                    $display(";A 77");		//(assert (= (bool-to-bv (bv-gt rx_# 0b0111111111111111111111111111111)) 0b0)) ;77 BR
                                                end
                                                if ((rx < m)) begin
                                                    $display(";A 79");		//(assert (= (bool-to-bv (bv-lt rx_# m_#)) 0b1)) ;79 BR
                                                    B <= 1'b1; $display(";A 81");		//(assert (= B_@   0b1)) ;81 NB
                                                end
                                                else begin
                                                    $display(";A 80");		//(assert (= (bool-to-bv (bv-lt rx_# m_#)) 0b0)) ;80 BR
                                                    B <= 1'b0; $display(";A 82");		//(assert (= B_@   0b0)) ;82 NB
                                                end
                                            end
                                        4'b0111 :
                                            begin
                                                $display(";A 83");		//(assert (= ff_#   0b0111)) ;83 CS
                                                if ((rx > 31'b0111111111111111111111111111111)) begin
                                                    $display(";A 84");		//(assert (= (bool-to-bv (bv-gt rx_# 0b0111111111111111111111111111111)) 0b1)) ;84 BR
                                                    rx = rx; $display(";A 86");		//(assert (= rx_#   rx_#)) ;86 BL
                                                end
                                                else begin
                                                    $display(";A 85");		//(assert (= (bool-to-bv (bv-gt rx_# 0b0111111111111111111111111111111)) 0b0)) ;85 BR
                                                end
                                                if ((rx >= m)) begin
                                                    $display(";A 87");		//(assert (= (bool-to-bv (bv-ge rx_# m_#)) 0b1)) ;87 BR
                                                    B <= 1'b1; $display(";A 89");		//(assert (= B_@   0b1)) ;89 NB
                                                end
                                                else begin
                                                    $display(";A 88");		//(assert (= (bool-to-bv (bv-ge rx_# m_#)) 0b0)) ;88 BR
                                                    B <= 1'b0; $display(";A 90");		//(assert (= B_@   0b0)) ;90 NB
                                                end
                                            end
                                        4'b1000 :
                                            begin
                                                $display(";A 91");		//(assert (= ff_#   0b1000)) ;91 CS
                                                if (((rx < m) || (B == 1'b1))) begin
                                                    $display(";A 92");		//(assert (= (bv-or (bool-to-bv (bv-lt rx_# m_#)) (bv-comp B_# 0b1)) 0b1)) ;92 BR
                                                    B <= 1'b1; $display(";A 94");		//(assert (= B_@   0b1)) ;94 NB
                                                end
                                                else begin
                                                    $display(";A 93");		//(assert (= (bv-or (bool-to-bv (bv-lt rx_# m_#)) (bv-comp B_# 0b1)) 0b0)) ;93 BR
                                                    B <= 1'b0; $display(";A 95");		//(assert (= B_@   0b0)) ;95 NB
                                                end
                                            end
                                        4'b1001 :
                                            begin
                                                $display(";A 96");		//(assert (= ff_#   0b1001)) ;96 CS
                                                if (((!(rx < m)) || (B == 1'b1))) begin
                                                    $display(";A 97");		//(assert (= (bv-or (bv-not (bv-redor (bool-to-bv (bv-lt rx_# m_#)))) (bv-comp B_# 0b1)) 0b1)) ;97 BR
                                                    B <= 1'b1; $display(";A 99");		//(assert (= B_@   0b1)) ;99 NB
                                                end
                                                else begin
                                                    $display(";A 98");		//(assert (= (bv-or (bv-not (bv-redor (bool-to-bv (bv-lt rx_# m_#)))) (bv-comp B_# 0b1)) 0b0)) ;98 BR
                                                    B <= 1'b0; $display(";A 100");		//(assert (= B_@   0b0)) ;100 NB
                                                end
                                            end
                                        4'b1010 :
                                            begin
                                                $display(";A 101");		//(assert (= ff_#   0b1010)) ;101 CS
                                                if (((rx == m) || (B == 1'b1))) begin
                                                    $display(";A 102");		//(assert (= (bv-or (bv-comp rx_# m_#) (bv-comp B_# 0b1)) 0b1)) ;102 BR
                                                    B <= 1'b1; $display(";A 104");		//(assert (= B_@   0b1)) ;104 NB
                                                end
                                                else begin
                                                    $display(";A 103");		//(assert (= (bv-or (bv-comp rx_# m_#) (bv-comp B_# 0b1)) 0b0)) ;103 BR
                                                    B <= 1'b0; $display(";A 105");		//(assert (= B_@   0b0)) ;105 NB
                                                end
                                            end
                                        4'b1011 :
                                            begin
                                                $display(";A 106");		//(assert (= ff_#   0b1011)) ;106 CS
                                                if (((!(rx == m)) || (B == 1'b1))) begin
                                                    $display(";A 107");		//(assert (= (bv-or (bv-not (bv-redor (bv-comp rx_# m_#))) (bv-comp B_# 0b1)) 0b1)) ;107 BR
                                                    B <= 1'b1; $display(";A 109");		//(assert (= B_@   0b1)) ;109 NB
                                                end
                                                else begin
                                                    $display(";A 108");		//(assert (= (bv-or (bv-not (bv-redor (bv-comp rx_# m_#))) (bv-comp B_# 0b1)) 0b0)) ;108 BR
                                                    B <= 1'b0; $display(";A 110");		//(assert (= B_@   0b0)) ;110 NB
                                                end
                                            end
                                        4'b1100 :
                                            begin
                                                $display(";A 111");		//(assert (= ff_#   0b1100)) ;111 CS
                                                if (((!(rx > m)) || (B == 1'b1))) begin
                                                    $display(";A 112");		//(assert (= (bv-or (bv-not (bv-redor (bool-to-bv (bv-gt rx_# m_#)))) (bv-comp B_# 0b1)) 0b1)) ;112 BR
                                                    B <= 1'b1; $display(";A 114");		//(assert (= B_@   0b1)) ;114 NB
                                                end
                                                else begin
                                                    $display(";A 113");		//(assert (= (bv-or (bv-not (bv-redor (bool-to-bv (bv-gt rx_# m_#)))) (bv-comp B_# 0b1)) 0b0)) ;113 BR
                                                    B <= 1'b0; $display(";A 115");		//(assert (= B_@   0b0)) ;115 NB
                                                end
                                            end
                                        4'b1101 :
                                            begin
                                                $display(";A 116");		//(assert (= ff_#   0b1101)) ;116 CS
                                                if (((rx > m) || (B == 1'b1))) begin
                                                    $display(";A 117");		//(assert (= (bv-or (bool-to-bv (bv-gt rx_# m_#)) (bv-comp B_# 0b1)) 0b1)) ;117 BR
                                                    B <= 1'b1; $display(";A 119");		//(assert (= B_@   0b1)) ;119 NB
                                                end
                                                else begin
                                                    $display(";A 118");		//(assert (= (bv-or (bool-to-bv (bv-gt rx_# m_#)) (bv-comp B_# 0b1)) 0b0)) ;118 BR
                                                    B <= 1'b0; $display(";A 120");		//(assert (= B_@   0b0)) ;120 NB
                                                end
                                            end
                                        4'b1110 :
                                            begin
                                                $display(";A 121");		//(assert (= ff_#   0b1110)) ;121 CS
                                                if ((rx > 31'b0111111111111111111111111111111)) begin
                                                    $display(";A 122");		//(assert (= (bool-to-bv (bv-gt rx_# 0b0111111111111111111111111111111)) 0b1)) ;122 BR
                                                    rx = rx; $display(";A 124");		//(assert (= rx_#   rx_#)) ;124 BL
                                                end
                                                else begin
                                                    $display(";A 123");		//(assert (= (bool-to-bv (bv-gt rx_# 0b0111111111111111111111111111111)) 0b0)) ;123 BR
                                                end
                                                if (((rx < m) || (B == 1'b1))) begin
                                                    $display(";A 125");		//(assert (= (bv-or (bool-to-bv (bv-lt rx_# m_#)) (bv-comp B_# 0b1)) 0b1)) ;125 BR
                                                    B <= 1'b1; $display(";A 127");		//(assert (= B_@   0b1)) ;127 NB
                                                end
                                                else begin
                                                    $display(";A 126");		//(assert (= (bv-or (bool-to-bv (bv-lt rx_# m_#)) (bv-comp B_# 0b1)) 0b0)) ;126 BR
                                                    B <= 1'b0; $display(";A 128");		//(assert (= B_@   0b0)) ;128 NB
                                                end
                                            end
                                        4'b1111 :
                                            begin
                                                $display(";A 129");		//(assert (= ff_#   0b1111)) ;129 CS
                                                if ((rx > 31'b0111111111111111111111111111111)) begin
                                                    $display(";A 130");		//(assert (= (bool-to-bv (bv-gt rx_# 0b0111111111111111111111111111111)) 0b1)) ;130 BR
                                                    rx = rx; $display(";A 132");		//(assert (= rx_#   rx_#)) ;132 BL
                                                end
                                                else begin
                                                    $display(";A 131");		//(assert (= (bool-to-bv (bv-gt rx_# 0b0111111111111111111111111111111)) 0b0)) ;131 BR
                                                end
                                                if (((!(rx < m)) || (B == 1'b1))) begin
                                                    $display(";A 133");		//(assert (= (bv-or (bv-not (bv-redor (bool-to-bv (bv-lt rx_# m_#)))) (bv-comp B_# 0b1)) 0b1)) ;133 BR
                                                    B <= 1'b1; $display(";A 135");		//(assert (= B_@   0b1)) ;135 NB
                                                end
                                                else begin
                                                    $display(";A 134");		//(assert (= (bv-or (bv-not (bv-redor (bool-to-bv (bv-lt rx_# m_#)))) (bv-comp B_# 0b1)) 0b0)) ;134 BR
                                                    B <= 1'b0; $display(";A 136");		//(assert (= B_@   0b0)) ;136 NB
                                                end
                                            end
                                    endcase
                                end
                            1'b0 :
                                begin
                                    $display(";A 137");		//(assert (= cf_#   0b0)) ;137 CS
                                    if ((df != 3'b111)) begin
                                        $display(";A 138");		//(assert (= (bv-not (bv-comp df_# 0b111)) 0b1)) ;138 BR
                                        if ((((df == 3'b101) && (B == 1'b0)) || ((df == 3'b100) && (B == 1'b1)))) begin
                                            $display(";A 140");		//(assert (= (bv-or (bv-and (bv-comp df_# 0b101) (bv-comp B_# 0b0)) (bv-and (bv-comp df_# 0b100) (bv-comp B_# 0b1))) 0b1)) ;140 BR
                                            d = 2'b11; $display(";A 142");		//(assert (= d_#   0b11)) ;142 BL
                                        end
                                        else begin
                                            $display(";A 141");		//(assert (= (bv-or (bv-and (bv-comp df_# 0b101) (bv-comp B_# 0b0)) (bv-and (bv-comp df_# 0b100) (bv-comp B_# 0b1))) 0b0)) ;141 BR
                                            d = df[1:0]; $display(";A 143");		//(assert (= d_#   (bv-extract 1 0 df_#))) ;143 BL
                                        end
                                        case (ff)
                                            4'b0000 :
                                                begin
                                                    $display(";A 144");		//(assert (= ff_#   0b0000)) ;144 CS
                                                    case (mf)
                                                        2'b00 :
                                                            begin
                                                                $display(";A 145");		//(assert (= mf_#   0b00)) ;145 CS
                                                                m = {11'b00000000000, tail}; $display(";A 146");		//(assert (= m_#   (bv-concat 0b00000000000 tail_#))) ;146 BL
                                                            end
                                                        2'b01 :
                                                            begin
                                                                $display(";A 147");		//(assert (= mf_#   0b01)) ;147 CS
                                                                m = datai; $display(";A 148");		//(assert (= m_#   datai_#)) ;148 BL
                                                                addr <= tail; $display(";A 149");		//(assert (= addr_@   tail_#)) ;149 NB
                                                                rd <= 1'b1; $display(";A 150");		//(assert (= rd_@   0b1)) ;150 NB
                                                            end
                                                        2'b10 :
                                                            begin
                                                                $display(";A 151");		//(assert (= mf_#   0b10)) ;151 CS
                                                                addr <= (tail + reg1[19:0]); $display(";A 152");		//(assert (= addr_@   (bv-add tail_# (bv-extract 19 0 reg1_#)))) ;152 NB
                                                                rd <= 1'b1; $display(";A 153");		//(assert (= rd_@   0b1)) ;153 NB
                                                                m = datai; $display(";A 154");		//(assert (= m_#   datai_#)) ;154 BL
                                                            end
                                                        2'b11 :
                                                            begin
                                                                $display(";A 155");		//(assert (= mf_#   0b11)) ;155 CS
                                                                addr <= (tail + reg2[19:0]); $display(";A 156");		//(assert (= addr_@   (bv-add tail_# (bv-extract 19 0 reg2_#)))) ;156 NB
                                                                rd <= 1'b1; $display(";A 157");		//(assert (= rd_@   0b1)) ;157 NB
                                                                m = datai; $display(";A 158");		//(assert (= m_#   datai_#)) ;158 BL
                                                            end
                                                    endcase
                                                    t = 31'b0000000000000000000000000000000; $display(";A 159");		//(assert (= t_#   0b0000000000000000000000000000000)) ;159 BL
                                                    case (d)
                                                        2'b00 :
                                                            begin
                                                                $display(";A 160");		//(assert (= d_#   0b00)) ;160 CS
                                                                reg0 = (t - m); $display(";A 161");		//(assert (= reg0_#   (bv-sub t_# m_#))) ;161 BL
                                                            end
                                                        2'b01 :
                                                            begin
                                                                $display(";A 162");		//(assert (= d_#   0b01)) ;162 CS
                                                                reg1 = (t - m); $display(";A 163");		//(assert (= reg1_#   (bv-sub t_# m_#))) ;163 BL
                                                            end
                                                        2'b10 :
                                                            begin
                                                                $display(";A 164");		//(assert (= d_#   0b10)) ;164 CS
                                                                reg2 = (t - m); $display(";A 165");		//(assert (= reg2_#   (bv-sub t_# m_#))) ;165 BL
                                                            end
                                                        2'b11 :
                                                            begin
                                                                $display(";A 166");		//(assert (= d_#   0b11)) ;166 CS
                                                                reg3 = (t - m); $display(";A 167");		//(assert (= reg3_#   (bv-sub t_# m_#))) ;167 BL
                                                            end
                                                    endcase
                                                end
                                            4'b0001 :
                                                begin
                                                    $display(";A 168");		//(assert (= ff_#   0b0001)) ;168 CS
                                                    case (mf)
                                                        2'b00 :
                                                            begin
                                                                $display(";A 169");		//(assert (= mf_#   0b00)) ;169 CS
                                                                m = {11'b00000000000, tail}; $display(";A 170");		//(assert (= m_#   (bv-concat 0b00000000000 tail_#))) ;170 BL
                                                            end
                                                        2'b01 :
                                                            begin
                                                                $display(";A 171");		//(assert (= mf_#   0b01)) ;171 CS
                                                                m = datai; $display(";A 172");		//(assert (= m_#   datai_#)) ;172 BL
                                                                addr <= tail; $display(";A 173");		//(assert (= addr_@   tail_#)) ;173 NB
                                                                rd <= 1'b1; $display(";A 174");		//(assert (= rd_@   0b1)) ;174 NB
                                                            end
                                                        2'b10 :
                                                            begin
                                                                $display(";A 175");		//(assert (= mf_#   0b10)) ;175 CS
                                                                addr <= (tail + reg1[19:0]); $display(";A 176");		//(assert (= addr_@   (bv-add tail_# (bv-extract 19 0 reg1_#)))) ;176 NB
                                                                rd <= 1'b1; $display(";A 177");		//(assert (= rd_@   0b1)) ;177 NB
                                                                m = datai; $display(";A 178");		//(assert (= m_#   datai_#)) ;178 BL
                                                            end
                                                        2'b11 :
                                                            begin
                                                                $display(";A 179");		//(assert (= mf_#   0b11)) ;179 CS
                                                                addr <= (tail + reg2[19:0]); $display(";A 180");		//(assert (= addr_@   (bv-add tail_# (bv-extract 19 0 reg2_#)))) ;180 NB
                                                                rd <= 1'b1; $display(";A 181");		//(assert (= rd_@   0b1)) ;181 NB
                                                                m = datai; $display(";A 182");		//(assert (= m_#   datai_#)) ;182 BL
                                                            end
                                                    endcase
                                                    reg2 = reg3; $display(";A 183");		//(assert (= reg2_#   reg3_#)) ;183 BL
                                                    reg3 = m; $display(";A 184");		//(assert (= reg3_#   m_#)) ;184 BL
                                                end
                                            4'b0010 :
                                                begin
                                                    $display(";A 185");		//(assert (= ff_#   0b0010)) ;185 CS
                                                    case (mf)
                                                        2'b00 :
                                                            begin
                                                                $display(";A 186");		//(assert (= mf_#   0b00)) ;186 CS
                                                                m = {11'b00000000000, tail}; $display(";A 187");		//(assert (= m_#   (bv-concat 0b00000000000 tail_#))) ;187 BL
                                                            end
                                                        2'b01 :
                                                            begin
                                                                $display(";A 188");		//(assert (= mf_#   0b01)) ;188 CS
                                                                m = datai; $display(";A 189");		//(assert (= m_#   datai_#)) ;189 BL
                                                                addr <= tail; $display(";A 190");		//(assert (= addr_@   tail_#)) ;190 NB
                                                                rd <= 1'b1; $display(";A 191");		//(assert (= rd_@   0b1)) ;191 NB
                                                            end
                                                        2'b10 :
                                                            begin
                                                                $display(";A 192");		//(assert (= mf_#   0b10)) ;192 CS
                                                                addr <= (tail + reg1[19:0]); $display(";A 193");		//(assert (= addr_@   (bv-add tail_# (bv-extract 19 0 reg1_#)))) ;193 NB
                                                                rd <= 1'b1; $display(";A 194");		//(assert (= rd_@   0b1)) ;194 NB
                                                                m = datai; $display(";A 195");		//(assert (= m_#   datai_#)) ;195 BL
                                                            end
                                                        2'b11 :
                                                            begin
                                                                $display(";A 196");		//(assert (= mf_#   0b11)) ;196 CS
                                                                addr <= (tail + reg2[19:0]); $display(";A 197");		//(assert (= addr_@   (bv-add tail_# (bv-extract 19 0 reg2_#)))) ;197 NB
                                                                rd <= 1'b1; $display(";A 198");		//(assert (= rd_@   0b1)) ;198 NB
                                                                m = datai; $display(";A 199");		//(assert (= m_#   datai_#)) ;199 BL
                                                            end
                                                    endcase
                                                    case (d)
                                                        2'b00 :
                                                            begin
                                                                $display(";A 200");		//(assert (= d_#   0b00)) ;200 CS
                                                                reg0 = m; $display(";A 201");		//(assert (= reg0_#   m_#)) ;201 BL
                                                            end
                                                        2'b01 :
                                                            begin
                                                                $display(";A 202");		//(assert (= d_#   0b01)) ;202 CS
                                                                reg1 = m; $display(";A 203");		//(assert (= reg1_#   m_#)) ;203 BL
                                                            end
                                                        2'b10 :
                                                            begin
                                                                $display(";A 204");		//(assert (= d_#   0b10)) ;204 CS
                                                                reg2 = m; $display(";A 205");		//(assert (= reg2_#   m_#)) ;205 BL
                                                            end
                                                        2'b11 :
                                                            begin
                                                                $display(";A 206");		//(assert (= d_#   0b11)) ;206 CS
                                                                reg3 = m; $display(";A 207");		//(assert (= reg3_#   m_#)) ;207 BL
                                                            end
                                                    endcase
                                                end
                                            4'b0011 :
                                                begin
                                                    $display(";A 208");		//(assert (= ff_#   0b0011)) ;208 CS
                                                    case (mf)
                                                        2'b00 :
                                                            begin
                                                                $display(";A 209");		//(assert (= mf_#   0b00)) ;209 CS
                                                                m = {11'b00000000000, tail}; $display(";A 210");		//(assert (= m_#   (bv-concat 0b00000000000 tail_#))) ;210 BL
                                                            end
                                                        2'b01 :
                                                            begin
                                                                $display(";A 211");		//(assert (= mf_#   0b01)) ;211 CS
                                                                m = datai; $display(";A 212");		//(assert (= m_#   datai_#)) ;212 BL
                                                                addr <= tail; $display(";A 213");		//(assert (= addr_@   tail_#)) ;213 NB
                                                                rd <= 1'b1; $display(";A 214");		//(assert (= rd_@   0b1)) ;214 NB
                                                            end
                                                        2'b10 :
                                                            begin
                                                                $display(";A 215");		//(assert (= mf_#   0b10)) ;215 CS
                                                                addr <= (tail + reg1[19:0]); $display(";A 216");		//(assert (= addr_@   (bv-add tail_# (bv-extract 19 0 reg1_#)))) ;216 NB
                                                                rd <= 1'b1; $display(";A 217");		//(assert (= rd_@   0b1)) ;217 NB
                                                                m = datai; $display(";A 218");		//(assert (= m_#   datai_#)) ;218 BL
                                                            end
                                                        2'b11 :
                                                            begin
                                                                $display(";A 219");		//(assert (= mf_#   0b11)) ;219 CS
                                                                addr <= (tail + reg2[19:0]); $display(";A 220");		//(assert (= addr_@   (bv-add tail_# (bv-extract 19 0 reg2_#)))) ;220 NB
                                                                rd <= 1'b1; $display(";A 221");		//(assert (= rd_@   0b1)) ;221 NB
                                                                m = datai; $display(";A 222");		//(assert (= m_#   datai_#)) ;222 BL
                                                            end
                                                    endcase
                                                    case (d)
                                                        2'b00 :
                                                            begin
                                                                $display(";A 223");		//(assert (= d_#   0b00)) ;223 CS
                                                                reg0 = m; $display(";A 224");		//(assert (= reg0_#   m_#)) ;224 BL
                                                            end
                                                        2'b01 :
                                                            begin
                                                                $display(";A 225");		//(assert (= d_#   0b01)) ;225 CS
                                                                reg1 = m; $display(";A 226");		//(assert (= reg1_#   m_#)) ;226 BL
                                                            end
                                                        2'b10 :
                                                            begin
                                                                $display(";A 227");		//(assert (= d_#   0b10)) ;227 CS
                                                                reg2 = m; $display(";A 228");		//(assert (= reg2_#   m_#)) ;228 BL
                                                            end
                                                        2'b11 :
                                                            begin
                                                                $display(";A 229");		//(assert (= d_#   0b11)) ;229 CS
                                                                reg3 = m; $display(";A 230");		//(assert (= reg3_#   m_#)) ;230 BL
                                                            end
                                                    endcase
                                                end
                                            4'b0100 :
                                                begin
                                                    $display(";A 231");		//(assert (= ff_#   0b0100)) ;231 CS
                                                    case (mf)
                                                        2'b00 :
                                                            begin
                                                                $display(";A 232");		//(assert (= mf_#   0b00)) ;232 CS
                                                                m = {11'b00000000000, tail}; $display(";A 233");		//(assert (= m_#   (bv-concat 0b00000000000 tail_#))) ;233 BL
                                                            end
                                                        2'b01 :
                                                            begin
                                                                $display(";A 234");		//(assert (= mf_#   0b01)) ;234 CS
                                                                m = datai; $display(";A 235");		//(assert (= m_#   datai_#)) ;235 BL
                                                                addr <= tail; $display(";A 236");		//(assert (= addr_@   tail_#)) ;236 NB
                                                                rd <= 1'b1; $display(";A 237");		//(assert (= rd_@   0b1)) ;237 NB
                                                            end
                                                        2'b10 :
                                                            begin
                                                                $display(";A 238");		//(assert (= mf_#   0b10)) ;238 CS
                                                                addr <= (tail + reg1[19:0]); $display(";A 239");		//(assert (= addr_@   (bv-add tail_# (bv-extract 19 0 reg1_#)))) ;239 NB
                                                                rd <= 1'b1; $display(";A 240");		//(assert (= rd_@   0b1)) ;240 NB
                                                                m = datai; $display(";A 241");		//(assert (= m_#   datai_#)) ;241 BL
                                                            end
                                                        2'b11 :
                                                            begin
                                                                $display(";A 242");		//(assert (= mf_#   0b11)) ;242 CS
                                                                addr <= (tail + reg2[19:0]); $display(";A 243");		//(assert (= addr_@   (bv-add tail_# (bv-extract 19 0 reg2_#)))) ;243 NB
                                                                rd <= 1'b1; $display(";A 244");		//(assert (= rd_@   0b1)) ;244 NB
                                                                m = datai; $display(";A 245");		//(assert (= m_#   datai_#)) ;245 BL
                                                            end
                                                    endcase
                                                    case (d)
                                                        2'b00 :
                                                            begin
                                                                $display(";A 246");		//(assert (= d_#   0b00)) ;246 CS
                                                                reg0 = (rx + m); $display(";A 247");		//(assert (= reg0_#   (bv-add rx_# m_#))) ;247 BL
                                                            end
                                                        2'b01 :
                                                            begin
                                                                $display(";A 248");		//(assert (= d_#   0b01)) ;248 CS
                                                                reg1 = (rx + m); $display(";A 249");		//(assert (= reg1_#   (bv-add rx_# m_#))) ;249 BL
                                                            end
                                                        2'b10 :
                                                            begin
                                                                $display(";A 250");		//(assert (= d_#   0b10)) ;250 CS
                                                                reg2 = (rx + m); $display(";A 251");		//(assert (= reg2_#   (bv-add rx_# m_#))) ;251 BL
                                                            end
                                                        2'b11 :
                                                            begin
                                                                $display(";A 252");		//(assert (= d_#   0b11)) ;252 CS
                                                                reg3 = (rx + m); $display(";A 253");		//(assert (= reg3_#   (bv-add rx_# m_#))) ;253 BL
                                                            end
                                                    endcase
                                                end
                                            4'b0101 :
                                                begin
                                                    $display(";A 254");		//(assert (= ff_#   0b0101)) ;254 CS
                                                    case (mf)
                                                        2'b00 :
                                                            begin
                                                                $display(";A 255");		//(assert (= mf_#   0b00)) ;255 CS
                                                                m = {11'b00000000000, tail}; $display(";A 256");		//(assert (= m_#   (bv-concat 0b00000000000 tail_#))) ;256 BL
                                                            end
                                                        2'b01 :
                                                            begin
                                                                $display(";A 257");		//(assert (= mf_#   0b01)) ;257 CS
                                                                m = datai; $display(";A 258");		//(assert (= m_#   datai_#)) ;258 BL
                                                                addr <= tail; $display(";A 259");		//(assert (= addr_@   tail_#)) ;259 NB
                                                                rd <= 1'b1; $display(";A 260");		//(assert (= rd_@   0b1)) ;260 NB
                                                            end
                                                        2'b10 :
                                                            begin
                                                                $display(";A 261");		//(assert (= mf_#   0b10)) ;261 CS
                                                                addr <= (tail + reg1[19:0]); $display(";A 262");		//(assert (= addr_@   (bv-add tail_# (bv-extract 19 0 reg1_#)))) ;262 NB
                                                                rd <= 1'b1; $display(";A 263");		//(assert (= rd_@   0b1)) ;263 NB
                                                                m = datai; $display(";A 264");		//(assert (= m_#   datai_#)) ;264 BL
                                                            end
                                                        2'b11 :
                                                            begin
                                                                $display(";A 265");		//(assert (= mf_#   0b11)) ;265 CS
                                                                addr <= (tail + reg2[19:0]); $display(";A 266");		//(assert (= addr_@   (bv-add tail_# (bv-extract 19 0 reg2_#)))) ;266 NB
                                                                rd <= 1'b1; $display(";A 267");		//(assert (= rd_@   0b1)) ;267 NB
                                                                m = datai; $display(";A 268");		//(assert (= m_#   datai_#)) ;268 BL
                                                            end
                                                    endcase
                                                    case (d)
                                                        2'b00 :
                                                            begin
                                                                $display(";A 269");		//(assert (= d_#   0b00)) ;269 CS
                                                                reg0 = (rx + m); $display(";A 270");		//(assert (= reg0_#   (bv-add rx_# m_#))) ;270 BL
                                                            end
                                                        2'b01 :
                                                            begin
                                                                $display(";A 271");		//(assert (= d_#   0b01)) ;271 CS
                                                                reg1 = (rx + m); $display(";A 272");		//(assert (= reg1_#   (bv-add rx_# m_#))) ;272 BL
                                                            end
                                                        2'b10 :
                                                            begin
                                                                $display(";A 273");		//(assert (= d_#   0b10)) ;273 CS
                                                                reg2 = (rx + m); $display(";A 274");		//(assert (= reg2_#   (bv-add rx_# m_#))) ;274 BL
                                                            end
                                                        2'b11 :
                                                            begin
                                                                $display(";A 275");		//(assert (= d_#   0b11)) ;275 CS
                                                                reg3 = (rx + m); $display(";A 276");		//(assert (= reg3_#   (bv-add rx_# m_#))) ;276 BL
                                                            end
                                                    endcase
                                                end
                                            4'b0110 :
                                                begin
                                                    $display(";A 277");		//(assert (= ff_#   0b0110)) ;277 CS
                                                    case (mf)
                                                        2'b00 :
                                                            begin
                                                                $display(";A 278");		//(assert (= mf_#   0b00)) ;278 CS
                                                                m = {11'b00000000000, tail}; $display(";A 279");		//(assert (= m_#   (bv-concat 0b00000000000 tail_#))) ;279 BL
                                                            end
                                                        2'b01 :
                                                            begin
                                                                $display(";A 280");		//(assert (= mf_#   0b01)) ;280 CS
                                                                m = datai; $display(";A 281");		//(assert (= m_#   datai_#)) ;281 BL
                                                                addr <= tail; $display(";A 282");		//(assert (= addr_@   tail_#)) ;282 NB
                                                                rd <= 1'b1; $display(";A 283");		//(assert (= rd_@   0b1)) ;283 NB
                                                            end
                                                        2'b10 :
                                                            begin
                                                                $display(";A 284");		//(assert (= mf_#   0b10)) ;284 CS
                                                                addr <= (tail + reg1[19:0]); $display(";A 285");		//(assert (= addr_@   (bv-add tail_# (bv-extract 19 0 reg1_#)))) ;285 NB
                                                                rd <= 1'b1; $display(";A 286");		//(assert (= rd_@   0b1)) ;286 NB
                                                                m = datai; $display(";A 287");		//(assert (= m_#   datai_#)) ;287 BL
                                                            end
                                                        2'b11 :
                                                            begin
                                                                $display(";A 288");		//(assert (= mf_#   0b11)) ;288 CS
                                                                addr <= (tail + reg2[19:0]); $display(";A 289");		//(assert (= addr_@   (bv-add tail_# (bv-extract 19 0 reg2_#)))) ;289 NB
                                                                rd <= 1'b1; $display(";A 290");		//(assert (= rd_@   0b1)) ;290 NB
                                                                m = datai; $display(";A 291");		//(assert (= m_#   datai_#)) ;291 BL
                                                            end
                                                    endcase
                                                    case (d)
                                                        2'b00 :
                                                            begin
                                                                $display(";A 292");		//(assert (= d_#   0b00)) ;292 CS
                                                                reg0 = (rx - m); $display(";A 293");		//(assert (= reg0_#   (bv-sub rx_# m_#))) ;293 BL
                                                            end
                                                        2'b01 :
                                                            begin
                                                                $display(";A 294");		//(assert (= d_#   0b01)) ;294 CS
                                                                reg1 = (rx - m); $display(";A 295");		//(assert (= reg1_#   (bv-sub rx_# m_#))) ;295 BL
                                                            end
                                                        2'b10 :
                                                            begin
                                                                $display(";A 296");		//(assert (= d_#   0b10)) ;296 CS
                                                                reg2 = (rx - m); $display(";A 297");		//(assert (= reg2_#   (bv-sub rx_# m_#))) ;297 BL
                                                            end
                                                        2'b11 :
                                                            begin
                                                                $display(";A 298");		//(assert (= d_#   0b11)) ;298 CS
                                                                reg3 = (rx - m); $display(";A 299");		//(assert (= reg3_#   (bv-sub rx_# m_#))) ;299 BL
                                                            end
                                                    endcase
                                                end
                                            4'b0111 :
                                                begin
                                                    $display(";A 300");		//(assert (= ff_#   0b0111)) ;300 CS
                                                    case (mf)
                                                        2'b00 :
                                                            begin
                                                                $display(";A 301");		//(assert (= mf_#   0b00)) ;301 CS
                                                                m = {11'b00000000000, tail}; $display(";A 302");		//(assert (= m_#   (bv-concat 0b00000000000 tail_#))) ;302 BL
                                                            end
                                                        2'b01 :
                                                            begin
                                                                $display(";A 303");		//(assert (= mf_#   0b01)) ;303 CS
                                                                m = datai; $display(";A 304");		//(assert (= m_#   datai_#)) ;304 BL
                                                                addr <= tail; $display(";A 305");		//(assert (= addr_@   tail_#)) ;305 NB
                                                                rd <= 1'b1; $display(";A 306");		//(assert (= rd_@   0b1)) ;306 NB
                                                            end
                                                        2'b10 :
                                                            begin
                                                                $display(";A 307");		//(assert (= mf_#   0b10)) ;307 CS
                                                                addr <= (tail + reg1[19:0]); $display(";A 308");		//(assert (= addr_@   (bv-add tail_# (bv-extract 19 0 reg1_#)))) ;308 NB
                                                                rd <= 1'b1; $display(";A 309");		//(assert (= rd_@   0b1)) ;309 NB
                                                                m = datai; $display(";A 310");		//(assert (= m_#   datai_#)) ;310 BL
                                                            end
                                                        2'b11 :
                                                            begin
                                                                $display(";A 311");		//(assert (= mf_#   0b11)) ;311 CS
                                                                addr <= (tail + reg2[19:0]); $display(";A 312");		//(assert (= addr_@   (bv-add tail_# (bv-extract 19 0 reg2_#)))) ;312 NB
                                                                rd <= 1'b1; $display(";A 313");		//(assert (= rd_@   0b1)) ;313 NB
                                                                m = datai; $display(";A 314");		//(assert (= m_#   datai_#)) ;314 BL
                                                            end
                                                    endcase
                                                    case (d)
                                                        2'b00 :
                                                            begin
                                                                $display(";A 315");		//(assert (= d_#   0b00)) ;315 CS
                                                                reg0 = (rx - m); $display(";A 316");		//(assert (= reg0_#   (bv-sub rx_# m_#))) ;316 BL
                                                            end
                                                        2'b01 :
                                                            begin
                                                                $display(";A 317");		//(assert (= d_#   0b01)) ;317 CS
                                                                reg1 = (rx - m); $display(";A 318");		//(assert (= reg1_#   (bv-sub rx_# m_#))) ;318 BL
                                                            end
                                                        2'b10 :
                                                            begin
                                                                $display(";A 319");		//(assert (= d_#   0b10)) ;319 CS
                                                                reg2 = (rx - m); $display(";A 320");		//(assert (= reg2_#   (bv-sub rx_# m_#))) ;320 BL
                                                            end
                                                        2'b11 :
                                                            begin
                                                                $display(";A 321");		//(assert (= d_#   0b11)) ;321 CS
                                                                reg3 = (rx - m); $display(";A 322");		//(assert (= reg3_#   (bv-sub rx_# m_#))) ;322 BL
                                                            end
                                                    endcase
                                                end
                                            4'b1000 :
                                                begin
                                                    $display(";A 323");		//(assert (= ff_#   0b1000)) ;323 CS
                                                    case (mf)
                                                        2'b00 :
                                                            begin
                                                                $display(";A 324");		//(assert (= mf_#   0b00)) ;324 CS
                                                                m = {11'b00000000000, tail}; $display(";A 325");		//(assert (= m_#   (bv-concat 0b00000000000 tail_#))) ;325 BL
                                                            end
                                                        2'b01 :
                                                            begin
                                                                $display(";A 326");		//(assert (= mf_#   0b01)) ;326 CS
                                                                m = datai; $display(";A 327");		//(assert (= m_#   datai_#)) ;327 BL
                                                                addr <= tail; $display(";A 328");		//(assert (= addr_@   tail_#)) ;328 NB
                                                                rd <= 1'b1; $display(";A 329");		//(assert (= rd_@   0b1)) ;329 NB
                                                            end
                                                        2'b10 :
                                                            begin
                                                                $display(";A 330");		//(assert (= mf_#   0b10)) ;330 CS
                                                                addr <= (tail + reg1[19:0]); $display(";A 331");		//(assert (= addr_@   (bv-add tail_# (bv-extract 19 0 reg1_#)))) ;331 NB
                                                                rd <= 1'b1; $display(";A 332");		//(assert (= rd_@   0b1)) ;332 NB
                                                                m = datai; $display(";A 333");		//(assert (= m_#   datai_#)) ;333 BL
                                                            end
                                                        2'b11 :
                                                            begin
                                                                $display(";A 334");		//(assert (= mf_#   0b11)) ;334 CS
                                                                addr <= (tail + reg2[19:0]); $display(";A 335");		//(assert (= addr_@   (bv-add tail_# (bv-extract 19 0 reg2_#)))) ;335 NB
                                                                rd <= 1'b1; $display(";A 336");		//(assert (= rd_@   0b1)) ;336 NB
                                                                m = datai; $display(";A 337");		//(assert (= m_#   datai_#)) ;337 BL
                                                            end
                                                    endcase
                                                    case (d)
                                                        2'b00 :
                                                            begin
                                                                $display(";A 338");		//(assert (= d_#   0b00)) ;338 CS
                                                                reg0 = (rx + m); $display(";A 339");		//(assert (= reg0_#   (bv-add rx_# m_#))) ;339 BL
                                                            end
                                                        2'b01 :
                                                            begin
                                                                $display(";A 340");		//(assert (= d_#   0b01)) ;340 CS
                                                                reg1 = (rx + m); $display(";A 341");		//(assert (= reg1_#   (bv-add rx_# m_#))) ;341 BL
                                                            end
                                                        2'b10 :
                                                            begin
                                                                $display(";A 342");		//(assert (= d_#   0b10)) ;342 CS
                                                                reg2 = (rx + m); $display(";A 343");		//(assert (= reg2_#   (bv-add rx_# m_#))) ;343 BL
                                                            end
                                                        2'b11 :
                                                            begin
                                                                $display(";A 344");		//(assert (= d_#   0b11)) ;344 CS
                                                                reg3 = (rx + m); $display(";A 345");		//(assert (= reg3_#   (bv-add rx_# m_#))) ;345 BL
                                                            end
                                                    endcase
                                                end
                                            4'b1001 :
                                                begin
                                                    $display(";A 346");		//(assert (= ff_#   0b1001)) ;346 CS
                                                    case (mf)
                                                        2'b00 :
                                                            begin
                                                                $display(";A 347");		//(assert (= mf_#   0b00)) ;347 CS
                                                                m = {11'b00000000000, tail}; $display(";A 348");		//(assert (= m_#   (bv-concat 0b00000000000 tail_#))) ;348 BL
                                                            end
                                                        2'b01 :
                                                            begin
                                                                $display(";A 349");		//(assert (= mf_#   0b01)) ;349 CS
                                                                m = datai; $display(";A 350");		//(assert (= m_#   datai_#)) ;350 BL
                                                                addr <= tail; $display(";A 351");		//(assert (= addr_@   tail_#)) ;351 NB
                                                                rd <= 1'b1; $display(";A 352");		//(assert (= rd_@   0b1)) ;352 NB
                                                            end
                                                        2'b10 :
                                                            begin
                                                                $display(";A 353");		//(assert (= mf_#   0b10)) ;353 CS
                                                                addr <= (tail + reg1[19:0]); $display(";A 354");		//(assert (= addr_@   (bv-add tail_# (bv-extract 19 0 reg1_#)))) ;354 NB
                                                                rd <= 1'b1; $display(";A 355");		//(assert (= rd_@   0b1)) ;355 NB
                                                                m = datai; $display(";A 356");		//(assert (= m_#   datai_#)) ;356 BL
                                                            end
                                                        2'b11 :
                                                            begin
                                                                $display(";A 357");		//(assert (= mf_#   0b11)) ;357 CS
                                                                addr <= (tail + reg2[19:0]); $display(";A 358");		//(assert (= addr_@   (bv-add tail_# (bv-extract 19 0 reg2_#)))) ;358 NB
                                                                rd <= 1'b1; $display(";A 359");		//(assert (= rd_@   0b1)) ;359 NB
                                                                m = datai; $display(";A 360");		//(assert (= m_#   datai_#)) ;360 BL
                                                            end
                                                    endcase
                                                    case (d)
                                                        2'b00 :
                                                            begin
                                                                $display(";A 361");		//(assert (= d_#   0b00)) ;361 CS
                                                                reg0 = (rx - m); $display(";A 362");		//(assert (= reg0_#   (bv-sub rx_# m_#))) ;362 BL
                                                            end
                                                        2'b01 :
                                                            begin
                                                                $display(";A 363");		//(assert (= d_#   0b01)) ;363 CS
                                                                reg1 = (rx - m); $display(";A 364");		//(assert (= reg1_#   (bv-sub rx_# m_#))) ;364 BL
                                                            end
                                                        2'b10 :
                                                            begin
                                                                $display(";A 365");		//(assert (= d_#   0b10)) ;365 CS
                                                                reg2 = (rx - m); $display(";A 366");		//(assert (= reg2_#   (bv-sub rx_# m_#))) ;366 BL
                                                            end
                                                        2'b11 :
                                                            begin
                                                                $display(";A 367");		//(assert (= d_#   0b11)) ;367 CS
                                                                reg3 = (rx - m); $display(";A 368");		//(assert (= reg3_#   (bv-sub rx_# m_#))) ;368 BL
                                                            end
                                                    endcase
                                                end
                                            4'b1010 :
                                                begin
                                                    $display(";A 369");		//(assert (= ff_#   0b1010)) ;369 CS
                                                    case (mf)
                                                        2'b00 :
                                                            begin
                                                                $display(";A 370");		//(assert (= mf_#   0b00)) ;370 CS
                                                                m = {11'b00000000000, tail}; $display(";A 371");		//(assert (= m_#   (bv-concat 0b00000000000 tail_#))) ;371 BL
                                                            end
                                                        2'b01 :
                                                            begin
                                                                $display(";A 372");		//(assert (= mf_#   0b01)) ;372 CS
                                                                m = datai; $display(";A 373");		//(assert (= m_#   datai_#)) ;373 BL
                                                                addr <= tail; $display(";A 374");		//(assert (= addr_@   tail_#)) ;374 NB
                                                                rd <= 1'b1; $display(";A 375");		//(assert (= rd_@   0b1)) ;375 NB
                                                            end
                                                        2'b10 :
                                                            begin
                                                                $display(";A 376");		//(assert (= mf_#   0b10)) ;376 CS
                                                                addr <= (tail + reg1[19:0]); $display(";A 377");		//(assert (= addr_@   (bv-add tail_# (bv-extract 19 0 reg1_#)))) ;377 NB
                                                                rd <= 1'b1; $display(";A 378");		//(assert (= rd_@   0b1)) ;378 NB
                                                                m = datai; $display(";A 379");		//(assert (= m_#   datai_#)) ;379 BL
                                                            end
                                                        2'b11 :
                                                            begin
                                                                $display(";A 380");		//(assert (= mf_#   0b11)) ;380 CS
                                                                addr <= (tail + reg2[19:0]); $display(";A 381");		//(assert (= addr_@   (bv-add tail_# (bv-extract 19 0 reg2_#)))) ;381 NB
                                                                rd <= 1'b1; $display(";A 382");		//(assert (= rd_@   0b1)) ;382 NB
                                                                m = datai; $display(";A 383");		//(assert (= m_#   datai_#)) ;383 BL
                                                            end
                                                    endcase
                                                    case (d)
                                                        2'b00 :
                                                            begin
                                                                $display(";A 384");		//(assert (= d_#   0b00)) ;384 CS
                                                                reg0 = (rx + m); $display(";A 385");		//(assert (= reg0_#   (bv-add rx_# m_#))) ;385 BL
                                                            end
                                                        2'b01 :
                                                            begin
                                                                $display(";A 386");		//(assert (= d_#   0b01)) ;386 CS
                                                                reg1 = (rx + m); $display(";A 387");		//(assert (= reg1_#   (bv-add rx_# m_#))) ;387 BL
                                                            end
                                                        2'b10 :
                                                            begin
                                                                $display(";A 388");		//(assert (= d_#   0b10)) ;388 CS
                                                                reg2 = (rx + m); $display(";A 389");		//(assert (= reg2_#   (bv-add rx_# m_#))) ;389 BL
                                                            end
                                                        2'b11 :
                                                            begin
                                                                $display(";A 390");		//(assert (= d_#   0b11)) ;390 CS
                                                                reg3 = (rx + m); $display(";A 391");		//(assert (= reg3_#   (bv-add rx_# m_#))) ;391 BL
                                                            end
                                                    endcase
                                                end
                                            4'b1011 :
                                                begin
                                                    $display(";A 392");		//(assert (= ff_#   0b1011)) ;392 CS
                                                    case (mf)
                                                        2'b00 :
                                                            begin
                                                                $display(";A 393");		//(assert (= mf_#   0b00)) ;393 CS
                                                                m = {11'b00000000000, tail}; $display(";A 394");		//(assert (= m_#   (bv-concat 0b00000000000 tail_#))) ;394 BL
                                                            end
                                                        2'b01 :
                                                            begin
                                                                $display(";A 395");		//(assert (= mf_#   0b01)) ;395 CS
                                                                m = datai; $display(";A 396");		//(assert (= m_#   datai_#)) ;396 BL
                                                                addr <= tail; $display(";A 397");		//(assert (= addr_@   tail_#)) ;397 NB
                                                                rd <= 1'b1; $display(";A 398");		//(assert (= rd_@   0b1)) ;398 NB
                                                            end
                                                        2'b10 :
                                                            begin
                                                                $display(";A 399");		//(assert (= mf_#   0b10)) ;399 CS
                                                                addr <= (tail + reg1[19:0]); $display(";A 400");		//(assert (= addr_@   (bv-add tail_# (bv-extract 19 0 reg1_#)))) ;400 NB
                                                                rd <= 1'b1; $display(";A 401");		//(assert (= rd_@   0b1)) ;401 NB
                                                                m = datai; $display(";A 402");		//(assert (= m_#   datai_#)) ;402 BL
                                                            end
                                                        2'b11 :
                                                            begin
                                                                $display(";A 403");		//(assert (= mf_#   0b11)) ;403 CS
                                                                addr <= (tail + reg2[19:0]); $display(";A 404");		//(assert (= addr_@   (bv-add tail_# (bv-extract 19 0 reg2_#)))) ;404 NB
                                                                rd <= 1'b1; $display(";A 405");		//(assert (= rd_@   0b1)) ;405 NB
                                                                m = datai; $display(";A 406");		//(assert (= m_#   datai_#)) ;406 BL
                                                            end
                                                    endcase
                                                    case (d)
                                                        2'b00 :
                                                            begin
                                                                $display(";A 407");		//(assert (= d_#   0b00)) ;407 CS
                                                                reg0 = (rx - m); $display(";A 408");		//(assert (= reg0_#   (bv-sub rx_# m_#))) ;408 BL
                                                            end
                                                        2'b01 :
                                                            begin
                                                                $display(";A 409");		//(assert (= d_#   0b01)) ;409 CS
                                                                reg1 = (rx - m); $display(";A 410");		//(assert (= reg1_#   (bv-sub rx_# m_#))) ;410 BL
                                                            end
                                                        2'b10 :
                                                            begin
                                                                $display(";A 411");		//(assert (= d_#   0b10)) ;411 CS
                                                                reg2 = (rx - m); $display(";A 412");		//(assert (= reg2_#   (bv-sub rx_# m_#))) ;412 BL
                                                            end
                                                        2'b11 :
                                                            begin
                                                                $display(";A 413");		//(assert (= d_#   0b11)) ;413 CS
                                                                reg3 = (rx - m); $display(";A 414");		//(assert (= reg3_#   (bv-sub rx_# m_#))) ;414 BL
                                                            end
                                                    endcase
                                                end
                                            4'b1100 :
                                                begin
                                                    $display(";A 415");		//(assert (= ff_#   0b1100)) ;415 CS
                                                    case (mf)
                                                        2'b00 :
                                                            begin
                                                                $display(";A 416");		//(assert (= mf_#   0b00)) ;416 CS
                                                                t = {1'b0, rx[30:1]}; $display(";A 417");		//(assert (= t_#   (bv-concat 0b0 (bv-extract 30 1 rx_#)))) ;417 BL
                                                            end
                                                        2'b01 :
                                                            begin
                                                                $display(";A 418");		//(assert (= mf_#   0b01)) ;418 CS
                                                                t = {1'b0, rx[30:1]}; $display(";A 419");		//(assert (= t_#   (bv-concat 0b0 (bv-extract 30 1 rx_#)))) ;419 BL
                                                                if ((B == 1'b1)) begin
                                                                    $display(";A 420");		//(assert (= (bv-comp B_# 0b1) 0b1)) ;420 BR
                                                                    t[29] = 1'b0; $display(";A 422");		//(assert (= (bv-extract 29 29 t_#)   0b0)) ;422 BL
                                                                end
                                                                else begin
                                                                    $display(";A 421");		//(assert (= (bv-comp B_# 0b1) 0b0)) ;421 BR
                                                                end
                                                            end
                                                        2'b10 :
                                                            begin
                                                                $display(";A 423");		//(assert (= mf_#   0b10)) ;423 CS
                                                                t = {rx[29:0], 1'b0}; $display(";A 424");		//(assert (= t_#   (bv-concat (bv-extract 29 0 rx_#) 0b0))) ;424 BL
                                                            end
                                                        2'b11 :
                                                            begin
                                                                $display(";A 425");		//(assert (= mf_#   0b11)) ;425 CS
                                                                t = {rx[29:0], 1'b0}; $display(";A 426");		//(assert (= t_#   (bv-concat (bv-extract 29 0 rx_#) 0b0))) ;426 BL
                                                                if ((t > 31'b0111111111111111111111111111111)) begin
                                                                    $display(";A 427");		//(assert (= (bool-to-bv (bv-gt t_# 0b0111111111111111111111111111111)) 0b1)) ;427 BR
                                                                    B <= 1'b1; $display(";A 429");		//(assert (= B_@   0b1)) ;429 NB
                                                                end
                                                                else begin
                                                                    $display(";A 428");		//(assert (= (bool-to-bv (bv-gt t_# 0b0111111111111111111111111111111)) 0b0)) ;428 BR
                                                                    B <= 1'b0; $display(";A 430");		//(assert (= B_@   0b0)) ;430 NB
                                                                end
                                                            end
                                                    endcase
                                                    case (d)
                                                        2'b00 :
                                                            begin
                                                                $display(";A 431");		//(assert (= d_#   0b00)) ;431 CS
                                                                reg0 <= t; $display(";A 432");		//(assert (= reg0_@   t_#)) ;432 NB
                                                            end
                                                        2'b01 :
                                                            begin
                                                                $display(";A 433");		//(assert (= d_#   0b01)) ;433 CS
                                                                reg1 <= t; $display(";A 434");		//(assert (= reg1_@   t_#)) ;434 NB
                                                            end
                                                        2'b10 :
                                                            begin
                                                                $display(";A 435");		//(assert (= d_#   0b10)) ;435 CS
                                                                reg2 <= t; $display(";A 436");		//(assert (= reg2_@   t_#)) ;436 NB
                                                            end
                                                        2'b11 :
                                                            begin
                                                                $display(";A 437");		//(assert (= d_#   0b11)) ;437 CS
                                                                reg3 <= t; $display(";A 438");		//(assert (= reg3_@   t_#)) ;438 NB
                                                            end
                                                    endcase
                                                end
                                            default:
                                                begin
                                                    $display(";A 138");		//(assert (= (bv-not (bv-comp df_# 0b111)) 0b1)) ;138 BR
                                                    reg0 = reg0; $display(";A 439");		//(assert (= reg0_#   reg0_#)) ;439 BL
                                                end
                                        endcase
                                    end
                                    else begin
                                        $display(";A 139");		//(assert (= (bv-not (bv-comp df_# 0b111)) 0b0)) ;139 BR
                                        if ((df == 3'b111)) begin
                                            $display(";A 440");		//(assert (= (bv-comp df_# 0b111) 0b1)) ;440 BR
                                            case (mf)
                                                2'b00 :
                                                    begin
                                                        $display(";A 442");		//(assert (= mf_#   0b00)) ;442 CS
                                                        m = {11'b00000000000, tail}; $display(";A 443");		//(assert (= m_#   (bv-concat 0b00000000000 tail_#))) ;443 BL
                                                    end
                                                2'b01 :
                                                    begin
                                                        $display(";A 444");		//(assert (= mf_#   0b01)) ;444 CS
                                                        m = {11'b00000000000, tail}; $display(";A 445");		//(assert (= m_#   (bv-concat 0b00000000000 tail_#))) ;445 BL
                                                    end
                                                2'b10 :
                                                    begin
                                                        $display(";A 446");		//(assert (= mf_#   0b10)) ;446 CS
                                                        m = (reg1 + {11'b00000000000, tail}); $display(";A 447");		//(assert (= m_#   (bv-add reg1_# (bv-concat 0b00000000000 tail_#)))) ;447 BL
                                                    end
                                                2'b11 :
                                                    begin
                                                        $display(";A 448");		//(assert (= mf_#   0b11)) ;448 CS
                                                        m = (reg2 + {11'b00000000000, tail}); $display(";A 449");		//(assert (= m_#   (bv-add reg2_# (bv-concat 0b00000000000 tail_#)))) ;449 BL
                                                    end
                                            endcase
                                            addr <= m[19:0]; $display(";A 450");		//(assert (= addr_@   (bv-extract 19 0 m_#))) ;450 NB
                                            wr <= 1'b1; $display(";A 451");		//(assert (= wr_@   0b1)) ;451 NB
                                            datao <= rx; $display(";A 452");		//(assert (= datao_@   rx_#)) ;452 NB
                                        end
                                        else begin
                                            $display(";A 441");		//(assert (= (bv-comp df_# 0b111) 0b0)) ;441 BR
                                        end
                                    end
                                end
                        endcase
                        state <= 1'b0; $display(";A 453");		//(assert (= state_@   0b0)) ;453 NB
                    end
            endcase
        end
    end

endmodule

