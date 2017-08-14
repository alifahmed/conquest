// Following code segment is generated from ./src/b11.v:1
module b11(x_in, stbi, clock, reset, x_out, __obs);
    input [5:0] x_in;
    input stbi;
    input clock;
    input reset;
    output [5:0] x_out;
    input __obs;

    reg [5:0] cont = 6'b0;
    reg signed [8:0] cont1 = 9'b0;
    reg signed [8:0] cont1_inv = 9'b0;
    reg [5:0] r_in = 6'b0;
    reg [3:0] stato = 4'b0;
    reg [5:0] x_out = 6'b0;

    always @(*) begin
        cont1_inv = (9'sb000000000 - cont1); $display(";A 0");		//(assert (= @cont1_inv    (bv-sub 0b000000000 #cont1 ))) ;0 BL
    end

    // Following code segment is generated from ./src/b11.v:28
    always @(posedge clock) begin
        if ((reset == 1'b1)) begin
            stato = 4'b0000; $display(";A 3");		//(assert (= @stato    0b0000)) ;3 BL
            r_in = 6'b000000; $display(";A 4");		//(assert (= @r_in    0b000000)) ;4 BL
            cont = 6'b000000; $display(";A 5");		//(assert (= @cont    0b000000)) ;5 BL
            cont1 = 9'b000000000; $display(";A 6");		//(assert (= @cont1    0b000000000)) ;6 BL
            x_out = 6'b000000; $display(";A 7");		//(assert (= @x_out    0b000000)) ;7 BL
        end
        else begin
            case (stato)
                4'b0000 :
                    begin
                        $display(";A 8");		//(assert (= #stato    0b0000)) ;8 CS
                        cont = 6'b000000; $display(";A 9");		//(assert (= @cont    0b000000)) ;9 BL
                        r_in = x_in; $display(";A 10");		//(assert (= @r_in    #x_in )) ;10 BL
                        x_out <= #1 6'b000000; $display(";A 11");		//(assert (= @x_out    0b000000)) ;11 NB
                        stato = 4'b0001; $display(";A 12");		//(assert (= @stato    0b0001)) ;12 BL
                    end
                4'b0001 :
                    begin
                        $display(";A 13");		//(assert (= #stato    0b0001)) ;13 CS
                        r_in = x_in; $display(";A 14");		//(assert (= @r_in    #x_in )) ;14 BL
                        if ((stbi == 1'b1)) begin
                            $display(";A 15");		//(assert (= (bv-comp #stbi  0b1)   0b1)) ;15 BR
                            stato = 4'b0001; $display(";A 17");		//(assert (= @stato    0b0001)) ;17 BL
                        end
                        else begin
                            $display(";A 16");		//(assert (= (bv-comp #stbi  0b1)   0b0)) ;16 BR
                            stato = 4'b0010; $display(";A 18");		//(assert (= @stato    0b0010)) ;18 BL
                        end
                    end
                4'b0010 :
                    begin
                        $display(";A 19");		//(assert (= #stato    0b0010)) ;19 CS
                        if (((r_in == 6'b000000) || (r_in == 6'b111111))) begin
                            $display(";A 20");		//(assert (= (bv-or (bv-comp #r_in  0b000000) (bv-comp #r_in  0b111111))   0b1)) ;20 BR
                            if ((cont < 6'b011001)) begin
                                $display(";A 22");		//(assert (= (bool-to-bv (bv-lt #cont  0b011001))   0b1)) ;22 BR
                                cont = (cont + 6'b000001); $display(";A 24");		//(assert (= @cont    (bv-add #cont  0b000001))) ;24 BL
                            end
                            else begin
                                $display(";A 23");		//(assert (= (bool-to-bv (bv-lt #cont  0b011001))   0b0)) ;23 BR
                                cont = 6'b000000; $display(";A 25");		//(assert (= @cont    0b000000)) ;25 BL
                            end
                            cont1 = {3'b000, r_in}; $display(";A 26");		//(assert (= @cont1    (bv-concat 0b000 #r_in ))) ;26 BL
                            stato = 4'b1000; $display(";A 27");		//(assert (= @stato    0b1000)) ;27 BL
                        end
                        else begin
                            $display(";A 21");		//(assert (= (bv-or (bv-comp #r_in  0b000000) (bv-comp #r_in  0b111111))   0b0)) ;21 BR
                            if ((r_in <= 6'b011010)) begin
                                $display(";A 28");		//(assert (= (bool-to-bv (bv-le #r_in  0b011010))   0b1)) ;28 BR
                                stato = 4'b0011; $display(";A 30");		//(assert (= @stato    0b0011)) ;30 BL
                            end
                            else begin
                                $display(";A 29");		//(assert (= (bool-to-bv (bv-le #r_in  0b011010))   0b0)) ;29 BR
                                stato = 4'b0001; $display(";A 31");		//(assert (= @stato    0b0001)) ;31 BL
                            end
                        end
                    end
                4'b0011 :
                    begin
                        $display(";A 32");		//(assert (= #stato    0b0011)) ;32 CS
                        if ((r_in[0] == 1'b1)) begin
                            $display(";A 33");		//(assert (= (bv-comp (bv-extract 0 0 #r_in ) 0b1)   0b1)) ;33 BR
                            cont1 = {2'b00, cont, 1'b0}; $display(";A 35");		//(assert (= @cont1    (bv-concat 0b00 #cont  0b0))) ;35 BL
                        end
                        else begin
                            $display(";A 34");		//(assert (= (bv-comp (bv-extract 0 0 #r_in ) 0b1)   0b0)) ;34 BR
                            cont1 = {3'b000, cont}; $display(";A 36");		//(assert (= @cont1    (bv-concat 0b000 #cont ))) ;36 BL
                        end
                        stato = 4'b0100; $display(";A 37");		//(assert (= @stato    0b0100)) ;37 BL
                    end
                4'b0100 :
                    begin
                        $display(";A 38");		//(assert (= #stato    0b0100)) ;38 CS
                        if ((r_in[1] == 1'b1)) begin
                            $display(";A 39");		//(assert (= (bv-comp (bv-extract 1 1 #r_in ) 0b1)   0b1)) ;39 BR
                            cont1 = ({3'b000, r_in} + cont1); $display(";A 41");		//(assert (= @cont1    (bv-add (bv-concat 0b000 #r_in ) #cont1 ))) ;41 BL
                            stato = 4'b0101; $display(";A 42");		//(assert (= @stato    0b0101)) ;42 BL
                        end
                        else begin
                            $display(";A 40");		//(assert (= (bv-comp (bv-extract 1 1 #r_in ) 0b1)   0b0)) ;40 BR
                            cont1 = ({3'b000, r_in} - cont1); $display(";A 43");		//(assert (= @cont1    (bv-sub (bv-concat 0b000 #r_in ) #cont1 ))) ;43 BL
                            stato = 4'b0110; $display(";A 44");		//(assert (= @stato    0b0110)) ;44 BL
                        end
                    end
                4'b0101 :
                    begin
                        $display(";A 45");		//(assert (= #stato    0b0101)) ;45 CS
                        if ((cont1 > 9'sb000011010)) begin
                            $display(";A 46");		//(assert (= (bool-to-bv (bv-sgt #cont1  0b000011010))   0b1)) ;46 BR
                            cont1 = (cont1 - 9'b000011010); $display(";A 48");		//(assert (= @cont1    (bv-sub #cont1  0b000011010))) ;48 BL
                            stato = 4'b0101; $display(";A 49");		//(assert (= @stato    0b0101)) ;49 BL
                        end
                        else begin
                            $display(";A 47");		//(assert (= (bool-to-bv (bv-sgt #cont1  0b000011010))   0b0)) ;47 BR
                            stato = 4'b0111; $display(";A 50");		//(assert (= @stato    0b0111)) ;50 BL
                        end
                    end
                4'b0110 :
                    begin
                        $display(";A 51");		//(assert (= #stato    0b0110)) ;51 CS
                        if ((cont1 > 9'sb000111111)) begin
                            $display(";A 52");		//(assert (= (bool-to-bv (bv-sgt #cont1  0b000111111))   0b1)) ;52 BR
                            cont1 = (cont1 + 9'b000011010); $display(";A 54");		//(assert (= @cont1    (bv-add #cont1  0b000011010))) ;54 BL
                            stato = 4'b0110; $display(";A 55");		//(assert (= @stato    0b0110)) ;55 BL
                        end
                        else begin
                            $display(";A 53");		//(assert (= (bool-to-bv (bv-sgt #cont1  0b000111111))   0b0)) ;53 BR
                            stato = 4'b0111; $display(";A 56");		//(assert (= @stato    0b0111)) ;56 BL
                        end
                    end
                4'b0111 :
                    begin
                        $display(";A 57");		//(assert (= #stato    0b0111)) ;57 CS
                        if ((r_in[3:2] == 2'b00)) begin
                            $display(";A 58");		//(assert (= (bv-comp (bv-extract 3 2 #r_in ) 0b00)   0b1)) ;58 BR
                            cont1 = (cont1 - 9'b000010101); $display(";A 60");		//(assert (= @cont1    (bv-sub #cont1  0b000010101))) ;60 BL
                        end
                        else begin
                            $display(";A 59");		//(assert (= (bv-comp (bv-extract 3 2 #r_in ) 0b00)   0b0)) ;59 BR
                            if ((r_in[3:2] == 2'b01)) begin
                                $display(";A 61");		//(assert (= (bv-comp (bv-extract 3 2 #r_in ) 0b01)   0b1)) ;61 BR
                                cont1 = (cont1 - 9'b000101010); $display(";A 63");		//(assert (= @cont1    (bv-sub #cont1  0b000101010))) ;63 BL
                            end
                            else begin
                                $display(";A 62");		//(assert (= (bv-comp (bv-extract 3 2 #r_in ) 0b01)   0b0)) ;62 BR
                                if ((r_in[3:2] == 2'b10)) begin
                                    $display(";A 64");		//(assert (= (bv-comp (bv-extract 3 2 #r_in ) 0b10)   0b1)) ;64 BR
                                    cont1 = (cont1 + 9'b000000111); $display(";A 66");		//(assert (= @cont1    (bv-add #cont1  0b000000111))) ;66 BL
                                end
                                else begin
                                    $display(";A 65");		//(assert (= (bv-comp (bv-extract 3 2 #r_in ) 0b10)   0b0)) ;65 BR
                                    cont1 = (cont1 + 9'b000011100); $display(";A 67");		//(assert (= @cont1    (bv-add #cont1  0b000011100))) ;67 BL
                                end
                            end
                        end
                        stato = 4'b1000; $display(";A 68");		//(assert (= @stato    0b1000)) ;68 BL
                    end
                4'b1000 :
                    begin
                        $display(";A 69");		//(assert (= #stato    0b1000)) ;69 CS
                        if ((cont1 < 9'sb000000000)) begin
                            $display(";A 70");		//(assert (= (bool-to-bv (bv-slt #cont1  0b000000000))   0b1)) ;70 BR
                            x_out <= #1 cont1_inv[5:0]; $display(";A 72");		//(assert (= @x_out    (bv-extract 5 0 #cont1_inv ))) ;72 NB
                        end
                        else begin
                            $display(";A 71");		//(assert (= (bool-to-bv (bv-slt #cont1  0b000000000))   0b0)) ;71 BR
                            x_out <= #1 cont1[5:0]; $display(";A 73");		//(assert (= @x_out    (bv-extract 5 0 #cont1 ))) ;73 NB
                        end
                        stato = 4'b0001; $display(";A 74");		//(assert (= @stato    0b0001)) ;74 BL
                    end
            endcase
        end
    end
/*
[1] weight: 0 distance: 268435455
(assert (= @cont1_inv    (bv-sub 0b000000000 #cont1 ))) ;0 BL

[2] weight: 1 distance: 268435455
[S] 3 4

[3] weight: 0 distance: 268435455
(assert (= (bv-comp #reset  0b1)   0b1)) ;1 BR
(assert (= @stato    0b0000)) ;3 BL
(assert (= @r_in    0b000000)) ;4 BL
(assert (= @cont    0b000000)) ;5 BL
(assert (= @cont1    0b000000000)) ;6 BL
(assert (= @x_out    0b000000)) ;7 BL
[S] 5
[P] 2

[4] weight: 1 distance: 268435455
(assert (= (bv-comp #reset  0b1)   0b0)) ;2 BR
[S] 7 8 22 12 26 48 30 34 38
[P] 2

[5] weight: 0 distance: 268435455
[P] 3 6

[6] weight: 0 distance: 268435455
[S] 5
[P] 7 11 15 25 29 33 37 41 51

[7] weight: 0 distance: 268435455
(assert (= #stato    0b0000)) ;8 CS
(assert (= @cont    0b000000)) ;9 BL
(assert (= @r_in    #x_in )) ;10 BL
(assert (= @x_out    0b000000)) ;11 NB
(assert (= @stato    0b0001)) ;12 BL
[S] 6
[P] 4

[8] weight: 1 distance: 268435455
(assert (= #stato    0b0001)) ;13 CS
(assert (= @r_in    #x_in )) ;14 BL
[S] 9 10
[P] 4

[9] weight: 0 distance: 268435455
(assert (= (bv-comp #stbi  0b1)   0b1)) ;15 BR
(assert (= @stato    0b0001)) ;17 BL
[S] 11
[P] 8

[10] weight: 0 distance: 268435455
(assert (= (bv-comp #stbi  0b1)   0b0)) ;16 BR
(assert (= @stato    0b0010)) ;18 BL
[S] 11
[P] 8

[11] weight: 0 distance: 268435455
[S] 6
[P] 9 10

[12] weight: 1 distance: 268435455
(assert (= #stato    0b0010)) ;19 CS
[S] 13 14
[P] 4

[13] weight: 1 distance: 268435455
(assert (= (bv-or (bv-comp #r_in  0b000000) (bv-comp #r_in  0b111111))   0b1)) ;20 BR
[S] 16 17
[P] 12

[14] weight: 1 distance: 268435455
(assert (= (bv-or (bv-comp #r_in  0b000000) (bv-comp #r_in  0b111111))   0b0)) ;21 BR
[S] 19 20
[P] 12

[15] weight: 0 distance: 268435455
[S] 6
[P] 18 21

[16] weight: 0 distance: 268435455
(assert (= (bool-to-bv (bv-lt #cont  0b011001))   0b1)) ;22 BR
(assert (= @cont    (bv-add #cont  0b000001))) ;24 BL
[S] 18
[P] 13

[17] weight: 0 distance: 268435455
(assert (= (bool-to-bv (bv-lt #cont  0b011001))   0b0)) ;23 BR
(assert (= @cont    0b000000)) ;25 BL
[S] 18
[P] 13

[18] weight: 0 distance: 268435455
(assert (= @cont1    (bv-concat 0b000 #r_in ))) ;26 BL
(assert (= @stato    0b1000)) ;27 BL
[S] 15
[P] 16 17

[19] weight: 0 distance: 268435455
(assert (= (bool-to-bv (bv-le #r_in  0b011010))   0b1)) ;28 BR
(assert (= @stato    0b0011)) ;30 BL
[S] 21
[P] 14

[20] weight: 0 distance: 268435455
(assert (= (bool-to-bv (bv-le #r_in  0b011010))   0b0)) ;29 BR
(assert (= @stato    0b0001)) ;31 BL
[S] 21
[P] 14

[21] weight: 0 distance: 268435455
[S] 15
[P] 19 20

[22] weight: 1 distance: 268435455
(assert (= #stato    0b0011)) ;32 CS
[S] 23 24
[P] 4

[23] weight: 0 distance: 268435455
(assert (= (bv-comp (bv-extract 0 0 #r_in ) 0b1)   0b1)) ;33 BR
(assert (= @cont1    (bv-concat 0b00 #cont  0b0))) ;35 BL
[S] 25
[P] 22

[24] weight: 0 distance: 268435455
(assert (= (bv-comp (bv-extract 0 0 #r_in ) 0b1)   0b0)) ;34 BR
(assert (= @cont1    (bv-concat 0b000 #cont ))) ;36 BL
[S] 25
[P] 22

[25] weight: 0 distance: 268435455
(assert (= @stato    0b0100)) ;37 BL
[S] 6
[P] 23 24

[26] weight: 1 distance: 268435455
(assert (= #stato    0b0100)) ;38 CS
[S] 27 28
[P] 4

[27] weight: 0 distance: 268435455
(assert (= (bv-comp (bv-extract 1 1 #r_in ) 0b1)   0b1)) ;39 BR
(assert (= @cont1    (bv-add (bv-concat 0b000 #r_in ) #cont1 ))) ;41 BL
(assert (= @stato    0b0101)) ;42 BL
[S] 29
[P] 26

[28] weight: 0 distance: 268435455
(assert (= (bv-comp (bv-extract 1 1 #r_in ) 0b1)   0b0)) ;40 BR
(assert (= @cont1    (bv-sub (bv-concat 0b000 #r_in ) #cont1 ))) ;43 BL
(assert (= @stato    0b0110)) ;44 BL
[S] 29
[P] 26

[29] weight: 0 distance: 268435455
[S] 6
[P] 27 28

[30] weight: 1 distance: 268435455
(assert (= #stato    0b0101)) ;45 CS
[S] 31 32
[P] 4

[31] weight: 0 distance: 268435455
(assert (= (bool-to-bv (bv-sgt #cont1  0b000011010))   0b1)) ;46 BR
(assert (= @cont1    (bv-sub #cont1  0b000011010))) ;48 BL
(assert (= @stato    0b0101)) ;49 BL
[S] 33
[P] 30

[32] weight: 0 distance: 268435455
(assert (= (bool-to-bv (bv-sgt #cont1  0b000011010))   0b0)) ;47 BR
(assert (= @stato    0b0111)) ;50 BL
[S] 33
[P] 30

[33] weight: 0 distance: 268435455
[S] 6
[P] 31 32

[34] weight: 1 distance: 268435455
(assert (= #stato    0b0110)) ;51 CS
[S] 35 36
[P] 4

[35] weight: 0 distance: 268435455
(assert (= (bool-to-bv (bv-sgt #cont1  0b000111111))   0b1)) ;52 BR
(assert (= @cont1    (bv-add #cont1  0b000011010))) ;54 BL
(assert (= @stato    0b0110)) ;55 BL
[S] 37
[P] 34

[36] weight: 0 distance: 268435455
(assert (= (bool-to-bv (bv-sgt #cont1  0b000111111))   0b0)) ;53 BR
(assert (= @stato    0b0111)) ;56 BL
[S] 37
[P] 34

[37] weight: 0 distance: 268435455
[S] 6
[P] 35 36

[38] weight: 1 distance: 268435455
(assert (= #stato    0b0111)) ;57 CS
[S] 39 40
[P] 4

[39] weight: 0 distance: 268435455
(assert (= (bv-comp (bv-extract 3 2 #r_in ) 0b00)   0b1)) ;58 BR
(assert (= @cont1    (bv-sub #cont1  0b000010101))) ;60 BL
[S] 41
[P] 38

[40] weight: 1 distance: 268435455
(assert (= (bv-comp (bv-extract 3 2 #r_in ) 0b00)   0b0)) ;59 BR
[S] 42 43
[P] 38

[41] weight: 0 distance: 268435455
(assert (= @stato    0b1000)) ;68 BL
[S] 6
[P] 39 44

[42] weight: 0 distance: 268435455
(assert (= (bv-comp (bv-extract 3 2 #r_in ) 0b01)   0b1)) ;61 BR
(assert (= @cont1    (bv-sub #cont1  0b000101010))) ;63 BL
[S] 44
[P] 40

[43] weight: 1 distance: 268435455
(assert (= (bv-comp (bv-extract 3 2 #r_in ) 0b01)   0b0)) ;62 BR
[S] 45 46
[P] 40

[44] weight: 0 distance: 268435455
[S] 41
[P] 42 47

[45] weight: 0 distance: 268435455
(assert (= (bv-comp (bv-extract 3 2 #r_in ) 0b10)   0b1)) ;64 BR
(assert (= @cont1    (bv-add #cont1  0b000000111))) ;66 BL
[S] 47
[P] 43

[46] weight: 0 distance: 268435455
(assert (= (bv-comp (bv-extract 3 2 #r_in ) 0b10)   0b0)) ;65 BR
(assert (= @cont1    (bv-add #cont1  0b000011100))) ;67 BL
[S] 47
[P] 43

[47] weight: 0 distance: 268435455
[S] 44
[P] 45 46

[48] weight: 1 distance: 268435455
(assert (= #stato    0b1000)) ;69 CS
[S] 49 50
[P] 4

[49] weight: 0 distance: 268435455
(assert (= (bool-to-bv (bv-slt #cont1  0b000000000))   0b1)) ;70 BR
(assert (= @x_out    (bv-extract 5 0 #cont1_inv ))) ;72 NB
[S] 51
[P] 48

[50] weight: 0 distance: 268435455
(assert (= (bool-to-bv (bv-slt #cont1  0b000000000))   0b0)) ;71 BR
(assert (= @x_out    (bv-extract 5 0 #cont1 ))) ;73 NB
[S] 51
[P] 48

[51] weight: 0 distance: 268435455
(assert (= @stato    0b0001)) ;74 BL
[S] 6
[P] 49 50

*/

endmodule

//state variables: stato

