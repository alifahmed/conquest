// Following code segment is generated from ./src/b06.v:17
module b06(eql, clock, reset, cont_eql, cc_mux, uscite, enable_count, ackout, __obs);
    input eql;
    input clock;
    input reset;
    input cont_eql;
    output [1:0] cc_mux;
    output [1:0] uscite;
    output enable_count;
    output ackout;
    input __obs;

    reg ackout = 1'b0;
    reg [1:0] cc_mux = 2'b0;
    reg enable_count = 1'b0;
    reg [2:0] state = 3'b0;
    reg [1:0] uscite = 2'b0;

    // Following code segment is generated from ./src/b06.v:51
    always @(posedge clock) begin
        if ((reset == 1'b1)) begin
            state <= #1 3'b000; $display(";A 2");		//(assert (= @state    0b000)) ;2 NB
            cc_mux <= #1 2'b00; $display(";A 3");		//(assert (= @cc_mux    0b00)) ;3 NB
            enable_count <= #1 1'b0; $display(";A 4");		//(assert (= @enable_count    0b0)) ;4 NB
            ackout <= #1 1'b0; $display(";A 5");		//(assert (= @ackout    0b0)) ;5 NB
            uscite <= #1 2'b00; $display(";A 6");		//(assert (= @uscite    0b00)) ;6 NB
        end
        else begin
            if ((cont_eql == 1'b1)) begin
                $display(";A 7");		//(assert (= (bv-comp #cont_eql  0b1)   0b1)) ;7 BR
                ackout <= #1 1'b0; $display(";A 9");		//(assert (= @ackout    0b0)) ;9 NB
                enable_count <= #1 1'b0; $display(";A 10");		//(assert (= @enable_count    0b0)) ;10 NB
            end
            else begin
                $display(";A 8");		//(assert (= (bv-comp #cont_eql  0b1)   0b0)) ;8 BR
                ackout <= #1 1'b1; $display(";A 11");		//(assert (= @ackout    0b1)) ;11 NB
                enable_count <= #1 1'b1; $display(";A 12");		//(assert (= @enable_count    0b1)) ;12 NB
            end
            case (state)
                3'b000 :
                    begin
                        $display(";A 13");		//(assert (= #state    0b000)) ;13 CS
                        cc_mux <= #1 2'b01; $display(";A 14");		//(assert (= @cc_mux    0b01)) ;14 NB
                        uscite <= #1 2'b01; $display(";A 15");		//(assert (= @uscite    0b01)) ;15 NB
                        state <= #1 3'b001; $display(";A 16");		//(assert (= @state    0b001)) ;16 NB
                    end
                3'b001 :
                    begin
                        $display(";A 17");		//(assert (= #state    0b001)) ;17 CS
                        if ((eql == 1'b1)) begin
                            $display(";A 18");		//(assert (= (bv-comp #eql  0b1)   0b1)) ;18 BR
                            uscite <= #1 2'b00; $display(";A 20");		//(assert (= @uscite    0b00)) ;20 NB
                            cc_mux <= #1 2'b11; $display(";A 21");		//(assert (= @cc_mux    0b11)) ;21 NB
                            state <= #1 3'b010; $display(";A 22");		//(assert (= @state    0b010)) ;22 NB
                        end
                        else begin
                            $display(";A 19");		//(assert (= (bv-comp #eql  0b1)   0b0)) ;19 BR
                            uscite <= #1 2'b01; $display(";A 23");		//(assert (= @uscite    0b01)) ;23 NB
                            cc_mux <= #1 2'b10; $display(";A 24");		//(assert (= @cc_mux    0b10)) ;24 NB
                            state <= #1 3'b101; $display(";A 25");		//(assert (= @state    0b101)) ;25 NB
                        end
                    end
                3'b101 :
                    begin
                        $display(";A 26");		//(assert (= #state    0b101)) ;26 CS
                        if ((eql == 1'b1)) begin
                            $display(";A 27");		//(assert (= (bv-comp #eql  0b1)   0b1)) ;27 BR
                            uscite <= #1 2'b00; $display(";A 29");		//(assert (= @uscite    0b00)) ;29 NB
                            cc_mux <= #1 2'b11; $display(";A 30");		//(assert (= @cc_mux    0b11)) ;30 NB
                            state <= #1 3'b100; $display(";A 31");		//(assert (= @state    0b100)) ;31 NB
                        end
                        else begin
                            $display(";A 28");		//(assert (= (bv-comp #eql  0b1)   0b0)) ;28 BR
                            uscite <= #1 2'b01; $display(";A 32");		//(assert (= @uscite    0b01)) ;32 NB
                            cc_mux <= #1 2'b01; $display(";A 33");		//(assert (= @cc_mux    0b01)) ;33 NB
                            state <= #1 3'b001; $display(";A 34");		//(assert (= @state    0b001)) ;34 NB
                        end
                    end
                3'b010 :
                    begin
                        $display(";A 35");		//(assert (= #state    0b010)) ;35 CS
                        if ((eql == 1'b1)) begin
                            $display(";A 36");		//(assert (= (bv-comp #eql  0b1)   0b1)) ;36 BR
                            uscite <= #1 2'b00; $display(";A 38");		//(assert (= @uscite    0b00)) ;38 NB
                            cc_mux <= #1 2'b11; $display(";A 39");		//(assert (= @cc_mux    0b11)) ;39 NB
                            state <= #1 3'b010; $display(";A 40");		//(assert (= @state    0b010)) ;40 NB
                        end
                        else begin
                            $display(";A 37");		//(assert (= (bv-comp #eql  0b1)   0b0)) ;37 BR
                            uscite <= #1 2'b01; $display(";A 41");		//(assert (= @uscite    0b01)) ;41 NB
                            ackout <= #1 1'b1; $display(";A 42");		//(assert (= @ackout    0b1)) ;42 NB
                            enable_count <= #1 1'b1; $display(";A 43");		//(assert (= @enable_count    0b1)) ;43 NB
                            cc_mux <= #1 2'b01; $display(";A 44");		//(assert (= @cc_mux    0b01)) ;44 NB
                            state <= #1 3'b011; $display(";A 45");		//(assert (= @state    0b011)) ;45 NB
                        end
                    end
                3'b011 :
                    begin
                        $display(";A 46");		//(assert (= #state    0b011)) ;46 CS
                        if ((eql == 1'b1)) begin
                            $display(";A 47");		//(assert (= (bv-comp #eql  0b1)   0b1)) ;47 BR
                            uscite <= #1 2'b01; $display(";A 49");		//(assert (= @uscite    0b01)) ;49 NB
                            cc_mux <= #1 2'b01; $display(";A 50");		//(assert (= @cc_mux    0b01)) ;50 NB
                            state <= #1 3'b011; $display(";A 51");		//(assert (= @state    0b011)) ;51 NB
                        end
                        else begin
                            $display(";A 48");		//(assert (= (bv-comp #eql  0b1)   0b0)) ;48 BR
                            uscite <= #1 2'b01; $display(";A 52");		//(assert (= @uscite    0b01)) ;52 NB
                            cc_mux <= #1 2'b01; $display(";A 53");		//(assert (= @cc_mux    0b01)) ;53 NB
                            state <= #1 3'b001; $display(";A 54");		//(assert (= @state    0b001)) ;54 NB
                        end
                    end
                3'b100 :
                    begin
                        $display(";A 55");		//(assert (= #state    0b100)) ;55 CS
                        if ((eql == 1'b1)) begin
                            $display(";A 56");		//(assert (= (bv-comp #eql  0b1)   0b1)) ;56 BR
                            uscite <= #1 2'b00; $display(";A 58");		//(assert (= @uscite    0b00)) ;58 NB
                            cc_mux <= #1 2'b11; $display(";A 59");		//(assert (= @cc_mux    0b11)) ;59 NB
                            state <= #1 3'b100; $display(";A 60");		//(assert (= @state    0b100)) ;60 NB
                        end
                        else begin
                            $display(";A 57");		//(assert (= (bv-comp #eql  0b1)   0b0)) ;57 BR
                            uscite <= #1 2'b11; $display(";A 61");		//(assert (= @uscite    0b11)) ;61 NB
                            cc_mux <= #1 2'b10; $display(";A 62");		//(assert (= @cc_mux    0b10)) ;62 NB
                            state <= #1 3'b110; $display(";A 63");		//(assert (= @state    0b110)) ;63 NB
                        end
                    end
                3'b110 :
                    begin
                        $display(";A 64");		//(assert (= #state    0b110)) ;64 CS
                        if ((eql == 1'b1)) begin
                            $display(";A 65");		//(assert (= (bv-comp #eql  0b1)   0b1)) ;65 BR
                            uscite <= #1 2'b11; $display(";A 67");		//(assert (= @uscite    0b11)) ;67 NB
                            cc_mux <= #1 2'b10; $display(";A 68");		//(assert (= @cc_mux    0b10)) ;68 NB
                            state <= #1 3'b110; $display(";A 69");		//(assert (= @state    0b110)) ;69 NB
                        end
                        else begin
                            $display(";A 66");		//(assert (= (bv-comp #eql  0b1)   0b0)) ;66 BR
                            uscite <= #1 2'b01; $display(";A 70");		//(assert (= @uscite    0b01)) ;70 NB
                            cc_mux <= #1 2'b01; $display(";A 71");		//(assert (= @cc_mux    0b01)) ;71 NB
                            state <= #1 3'b001; $display(";A 72");		//(assert (= @state    0b001)) ;72 NB
                        end
                    end
            endcase
        end
    end
/*
[1] weight: 1 distance: 268435455
[S] 2 3

[2] weight: 0 distance: 268435455
(assert (= (bv-comp #reset  0b1)   0b1)) ;0 BR
(assert (= @state    0b000)) ;2 NB
(assert (= @cc_mux    0b00)) ;3 NB
(assert (= @enable_count    0b0)) ;4 NB
(assert (= @ackout    0b0)) ;5 NB
(assert (= @uscite    0b00)) ;6 NB
[S] 4
[P] 1

[3] weight: 1 distance: 268435455
(assert (= (bv-comp #reset  0b1)   0b0)) ;1 BR
[S] 5 6
[P] 1

[4] weight: 0 distance: 268435455
[P] 2 8

[5] weight: 0 distance: 268435455
(assert (= (bv-comp #cont_eql  0b1)   0b1)) ;7 BR
(assert (= @ackout    0b0)) ;9 NB
(assert (= @enable_count    0b0)) ;10 NB
[S] 7
[P] 3

[6] weight: 0 distance: 268435455
(assert (= (bv-comp #cont_eql  0b1)   0b0)) ;8 BR
(assert (= @ackout    0b1)) ;11 NB
(assert (= @enable_count    0b1)) ;12 NB
[S] 7
[P] 3

[7] weight: 1 distance: 268435455
[S] 9 10 14 30 18 22 26
[P] 5 6

[8] weight: 0 distance: 268435455
[S] 4
[P] 9 13 17 21 25 29 33

[9] weight: 0 distance: 268435455
(assert (= #state    0b000)) ;13 CS
(assert (= @cc_mux    0b01)) ;14 NB
(assert (= @uscite    0b01)) ;15 NB
(assert (= @state    0b001)) ;16 NB
[S] 8
[P] 7

[10] weight: 1 distance: 268435455
(assert (= #state    0b001)) ;17 CS
[S] 11 12
[P] 7

[11] weight: 0 distance: 268435455
(assert (= (bv-comp #eql  0b1)   0b1)) ;18 BR
(assert (= @uscite    0b00)) ;20 NB
(assert (= @cc_mux    0b11)) ;21 NB
(assert (= @state    0b010)) ;22 NB
[S] 13
[P] 10

[12] weight: 0 distance: 268435455
(assert (= (bv-comp #eql  0b1)   0b0)) ;19 BR
(assert (= @uscite    0b01)) ;23 NB
(assert (= @cc_mux    0b10)) ;24 NB
(assert (= @state    0b101)) ;25 NB
[S] 13
[P] 10

[13] weight: 0 distance: 268435455
[S] 8
[P] 11 12

[14] weight: 1 distance: 268435455
(assert (= #state    0b101)) ;26 CS
[S] 15 16
[P] 7

[15] weight: 0 distance: 268435455
(assert (= (bv-comp #eql  0b1)   0b1)) ;27 BR
(assert (= @uscite    0b00)) ;29 NB
(assert (= @cc_mux    0b11)) ;30 NB
(assert (= @state    0b100)) ;31 NB
[S] 17
[P] 14

[16] weight: 0 distance: 268435455
(assert (= (bv-comp #eql  0b1)   0b0)) ;28 BR
(assert (= @uscite    0b01)) ;32 NB
(assert (= @cc_mux    0b01)) ;33 NB
(assert (= @state    0b001)) ;34 NB
[S] 17
[P] 14

[17] weight: 0 distance: 268435455
[S] 8
[P] 15 16

[18] weight: 1 distance: 268435455
(assert (= #state    0b010)) ;35 CS
[S] 19 20
[P] 7

[19] weight: 0 distance: 268435455
(assert (= (bv-comp #eql  0b1)   0b1)) ;36 BR
(assert (= @uscite    0b00)) ;38 NB
(assert (= @cc_mux    0b11)) ;39 NB
(assert (= @state    0b010)) ;40 NB
[S] 21
[P] 18

[20] weight: 0 distance: 268435455
(assert (= (bv-comp #eql  0b1)   0b0)) ;37 BR
(assert (= @uscite    0b01)) ;41 NB
(assert (= @ackout    0b1)) ;42 NB
(assert (= @enable_count    0b1)) ;43 NB
(assert (= @cc_mux    0b01)) ;44 NB
(assert (= @state    0b011)) ;45 NB
[S] 21
[P] 18

[21] weight: 0 distance: 268435455
[S] 8
[P] 19 20

[22] weight: 1 distance: 268435455
(assert (= #state    0b011)) ;46 CS
[S] 23 24
[P] 7

[23] weight: 0 distance: 268435455
(assert (= (bv-comp #eql  0b1)   0b1)) ;47 BR
(assert (= @uscite    0b01)) ;49 NB
(assert (= @cc_mux    0b01)) ;50 NB
(assert (= @state    0b011)) ;51 NB
[S] 25
[P] 22

[24] weight: 0 distance: 268435455
(assert (= (bv-comp #eql  0b1)   0b0)) ;48 BR
(assert (= @uscite    0b01)) ;52 NB
(assert (= @cc_mux    0b01)) ;53 NB
(assert (= @state    0b001)) ;54 NB
[S] 25
[P] 22

[25] weight: 0 distance: 268435455
[S] 8
[P] 23 24

[26] weight: 1 distance: 268435455
(assert (= #state    0b100)) ;55 CS
[S] 27 28
[P] 7

[27] weight: 0 distance: 268435455
(assert (= (bv-comp #eql  0b1)   0b1)) ;56 BR
(assert (= @uscite    0b00)) ;58 NB
(assert (= @cc_mux    0b11)) ;59 NB
(assert (= @state    0b100)) ;60 NB
[S] 29
[P] 26

[28] weight: 0 distance: 268435455
(assert (= (bv-comp #eql  0b1)   0b0)) ;57 BR
(assert (= @uscite    0b11)) ;61 NB
(assert (= @cc_mux    0b10)) ;62 NB
(assert (= @state    0b110)) ;63 NB
[S] 29
[P] 26

[29] weight: 0 distance: 268435455
[S] 8
[P] 27 28

[30] weight: 1 distance: 268435455
(assert (= #state    0b110)) ;64 CS
[S] 31 32
[P] 7

[31] weight: 0 distance: 268435455
(assert (= (bv-comp #eql  0b1)   0b1)) ;65 BR
(assert (= @uscite    0b11)) ;67 NB
(assert (= @cc_mux    0b10)) ;68 NB
(assert (= @state    0b110)) ;69 NB
[S] 33
[P] 30

[32] weight: 0 distance: 268435455
(assert (= (bv-comp #eql  0b1)   0b0)) ;66 BR
(assert (= @uscite    0b01)) ;70 NB
(assert (= @cc_mux    0b01)) ;71 NB
(assert (= @state    0b001)) ;72 NB
[S] 33
[P] 30

[33] weight: 0 distance: 268435455
[S] 8
[P] 31 32

*/

endmodule

//state variables: ackout cc_mux enable_count state uscite

