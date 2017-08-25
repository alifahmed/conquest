module uart(
        sys_clk,
        sys_rst_l,
        uart_XMIT_dataH,
        xmitH,
        xmit_dataH,
        xmit_doneH,
        uart_REC_dataH,
        rec_dataH,
        rec_readyH
    );
    parameter r_START  = 3'b001;
    parameter r_CENTER  = 3'b010;
    parameter r_WAIT  = 3'b011;
    parameter r_SAMPLE  = 3'b100;
    parameter r_STOP  = 3'b101;
    parameter x_IDLE  = 3'b000;
    parameter x_START  = 3'b010;
    parameter x_WAIT  = 3'b011;
    parameter x_SHIFT  = 3'b100;
    parameter x_STOP  = 3'b101;
    parameter x_DataSend  = 3'b111;
    parameter s_idle  = 3'b000;
    parameter s_count1  = 3'b001;
    parameter s_count2  = 3'b010;
    parameter s_count3  = 3'b011;
    parameter s_stop  = 3'b111;
    parameter x_STARTbit  = 2'b00;
    parameter x_STOPbit  = 2'b01;
    parameter x_ShiftReg  = 2'b10;
    parameter x_miDataSend  = 2'b11;
    parameter LO  = 1'b0;
    parameter HI  = 1'b1;
    parameter X  = 1'bx;
    parameter DataSend  = 1'b0;
    parameter DataSend_bit  = 1'b1;
    parameter DataCon_bit  = 1'b1;
    parameter WORD_LEN  = 4'h8;
    parameter iXMIT_r_START  = 3'b001;
    parameter iXMIT_r_CENTER  = 3'b010;
    parameter iXMIT_r_WAIT  = 3'b011;
    parameter iXMIT_r_SAMPLE  = 3'b100;
    parameter iXMIT_r_STOP  = 3'b101;
    parameter iXMIT_x_IDLE  = 3'b000;
    parameter iXMIT_x_START  = 3'b010;
    parameter iXMIT_x_WAIT  = 3'b011;
    parameter iXMIT_x_SHIFT  = 3'b100;
    parameter iXMIT_x_STOP  = 3'b101;
    parameter iXMIT_x_DataSend  = 3'b111;
    parameter iXMIT_s_idle  = 3'b000;
    parameter iXMIT_s_count1  = 3'b001;
    parameter iXMIT_s_count2  = 3'b010;
    parameter iXMIT_s_count3  = 3'b011;
    parameter iXMIT_s_stop  = 3'b111;
    parameter iXMIT_x_STARTbit  = 2'b00;
    parameter iXMIT_x_STOPbit  = 2'b01;
    parameter iXMIT_x_ShiftReg  = 2'b10;
    parameter iXMIT_x_miDataSend  = 2'b11;
    parameter iXMIT_LO  = 1'b0;
    parameter iXMIT_HI  = 1'b1;
    parameter iXMIT_X  = 1'bx;
    parameter iXMIT_DataSend  = 1'b0;
    parameter iXMIT_DataSend_bit  = 1'b1;
    parameter iXMIT_DataCon_bit  = 1'b1;
    parameter iXMIT_WORD_LEN  = 4'h8;
    parameter iRECEIVER_r_START  = 3'b001;
    parameter iRECEIVER_r_CENTER  = 3'b010;
    parameter iRECEIVER_r_WAIT  = 3'b011;
    parameter iRECEIVER_r_SAMPLE  = 3'b100;
    parameter iRECEIVER_r_STOP  = 3'b101;
    parameter iRECEIVER_x_IDLE  = 3'b000;
    parameter iRECEIVER_x_START  = 3'b010;
    parameter iRECEIVER_x_WAIT  = 3'b011;
    parameter iRECEIVER_x_SHIFT  = 3'b100;
    parameter iRECEIVER_x_STOP  = 3'b101;
    parameter iRECEIVER_x_DataSend  = 3'b111;
    parameter iRECEIVER_s_idle  = 3'b000;
    parameter iRECEIVER_s_count1  = 3'b001;
    parameter iRECEIVER_s_count2  = 3'b010;
    parameter iRECEIVER_s_count3  = 3'b011;
    parameter iRECEIVER_s_stop  = 3'b111;
    parameter iRECEIVER_x_STARTbit  = 2'b00;
    parameter iRECEIVER_x_STOPbit  = 2'b01;
    parameter iRECEIVER_x_ShiftReg  = 2'b10;
    parameter iRECEIVER_x_miDataSend  = 2'b11;
    parameter iRECEIVER_LO  = 1'b0;
    parameter iRECEIVER_HI  = 1'b1;
    parameter iRECEIVER_X  = 1'bx;
    parameter iRECEIVER_DataSend  = 1'b0;
    parameter iRECEIVER_DataSend_bit  = 1'b1;
    parameter iRECEIVER_DataCon_bit  = 1'b1;
    parameter iRECEIVER_WORD_LEN  = 4'h8;
    input sys_clk;
    input sys_rst_l;
    output uart_XMIT_dataH;
    input xmitH;
    input [7:0]xmit_dataH;
    output xmit_doneH;
    input uart_REC_dataH;
    output [7:0]rec_dataH;
    output rec_readyH;
    reg [7:0]rec_dataH;
    reg [7:0]rec_dataH_temp;
    reg [2:0]iXMIT_next_state;
    reg [2:0]iXMIT_state;
    reg iXMIT_load_shiftRegH;
    reg iXMIT_shiftEnaH;
    reg [3:0]iXMIT_bitCell_cntrH;
    reg iXMIT_countEnaH;
    reg [7:0]iXMIT_xmit_ShiftRegH;
    reg [3:0]iXMIT_bitCountH;
    reg iXMIT_rst_bitCountH;
    reg iXMIT_ena_bitCountH;
    reg [1:0]iXMIT_xmitDataSelH;
    reg iXMIT_uart_xmitH;
    reg iXMIT_xmit_doneInH;
    reg iXMIT_xmit_doneH;
    reg [7:0]iRECEIVER_rec_dataH;
    reg iRECEIVER_rec_readyH;
    reg [2:0]iRECEIVER_next_state;
    reg [2:0]iRECEIVER_state;
    reg iRECEIVER_rec_datH;
    reg iRECEIVER_rec_datSyncH;
    reg [3:0]iRECEIVER_bitCell_cntrH;
    reg iRECEIVER_cntr_resetH;
    reg iRECEIVER_shiftH;
    reg [3:0]iRECEIVER_recd_bitCntrH;
    reg iRECEIVER_countH;
    reg iRECEIVER_rstCountH;
    reg iRECEIVER_rec_readyH_temp;
    reg iRECEIVER_rec_readyInH;
    always @ (  posedge sys_clk or  negedge sys_rst_l)
    begin
        if (  ~( sys_rst_l) ) 
        begin
            rec_dataH <= 8'b0;
        end
        else
        begin 
            rec_dataH <= rec_dataH_temp;
        end
    end
    always @ (  posedge sys_clk or  negedge sys_rst_l)
    begin
        if (  ~( sys_rst_l) ) 
        begin
            rec_dataH_temp <= 8'b0;
        end
        else
        begin 
            if ( rec_readyH ) 
            begin
                rec_dataH_temp <= iRECEIVER_rec_dataH;
            end
        end
    end
    assign uart_XMIT_dataH = iXMIT_uart_xmitH;
    assign xmit_doneH = iXMIT_xmit_doneH;
    always @ (  iXMIT_xmit_ShiftRegH or  iXMIT_xmitDataSelH)
    begin
        case ( iXMIT_xmitDataSelH ) 
        iXMIT_x_STARTbit:
        begin
            iXMIT_uart_xmitH = iXMIT_LO;
        end
        iXMIT_x_STOPbit:
        begin
            iXMIT_uart_xmitH = iXMIT_HI;
        end
        iXMIT_x_ShiftReg:
        begin
            iXMIT_uart_xmitH = iXMIT_xmit_ShiftRegH[0];
        end
        endcase
    end
    always @ (  posedge sys_clk or  negedge sys_rst_l)
    begin
        if (  ~( sys_rst_l) ) 
        begin
            iXMIT_bitCell_cntrH <= 4'b0;
        end
        else
        begin 
            if ( iXMIT_countEnaH ) 
            begin
                iXMIT_bitCell_cntrH <= ( iXMIT_bitCell_cntrH + 4'b1 );
            end
            else
            begin 
                iXMIT_bitCell_cntrH <= 4'b0;
            end
        end
    end
    always @ (  posedge sys_clk or  negedge sys_rst_l)
    begin
        if (  ~( sys_rst_l) ) 
        begin
            iXMIT_xmit_ShiftRegH <= 8'b0;
        end
        else
        begin 
            if ( iXMIT_load_shiftRegH ) 
            begin
                iXMIT_xmit_ShiftRegH <= xmit_dataH;
            end
            else
            begin 
                if ( iXMIT_shiftEnaH ) 
                begin
                    iXMIT_xmit_ShiftRegH <= { iXMIT_HI, iXMIT_xmit_ShiftRegH[7:1] };
                end
                else
                begin 
                    iXMIT_xmit_ShiftRegH <= iXMIT_xmit_ShiftRegH;
                end
            end
        end
    end
    always @ (  posedge sys_clk or  negedge sys_rst_l)
    begin
        if (  ~( sys_rst_l) ) 
        begin
            iXMIT_bitCountH <= 4'b0;
        end
        else
        begin 
            if ( iXMIT_rst_bitCountH ) 
            begin
                iXMIT_bitCountH <= 4'b0;
            end
            else
            begin 
                if ( iXMIT_ena_bitCountH ) 
                begin
                    iXMIT_bitCountH <= ( iXMIT_bitCountH + 4'b1 );
                end
            end
        end
    end
    always @ (  posedge sys_clk or  negedge sys_rst_l)
    begin
        if (  ~( sys_rst_l) ) 
        begin
            iXMIT_state <= iXMIT_x_IDLE;
        end
        else
        begin 
            iXMIT_state <= iXMIT_next_state;
        end
    end
    always @ (  iXMIT_state or  xmitH or  iXMIT_bitCell_cntrH or  iXMIT_bitCountH)
    begin
        iXMIT_next_state = iXMIT_state;
        iXMIT_load_shiftRegH = iXMIT_LO;
        iXMIT_countEnaH = iXMIT_LO;
        iXMIT_shiftEnaH = iXMIT_LO;
        iXMIT_rst_bitCountH = iXMIT_LO;
        iXMIT_ena_bitCountH = iXMIT_LO;
        iXMIT_xmitDataSelH = iXMIT_x_STOPbit;
        iXMIT_xmit_doneInH = iXMIT_LO;
        case ( iXMIT_state ) 
        iXMIT_x_IDLE:
        begin
            if ( xmitH ) 
            begin
                iXMIT_next_state = iXMIT_x_START;
                iXMIT_load_shiftRegH = iXMIT_HI;
            end
            else
            begin 
                iXMIT_next_state = iXMIT_x_IDLE;
                iXMIT_rst_bitCountH = iXMIT_HI;
                iXMIT_xmit_doneInH = iXMIT_HI;
            end
        end
        iXMIT_x_START:
        begin
            iXMIT_xmitDataSelH = iXMIT_x_STARTbit;
            if ( iXMIT_bitCell_cntrH == 4'hF ) 
            begin
                iXMIT_next_state = iXMIT_x_WAIT;
            end
            else
            begin 
                iXMIT_next_state = iXMIT_x_START;
                iXMIT_countEnaH = iXMIT_HI;
            end
        end
        iXMIT_x_WAIT:
        begin
            iXMIT_xmitDataSelH = iXMIT_x_ShiftReg;
            if ( iXMIT_bitCell_cntrH == 4'hE ) 
            begin
                if ( iXMIT_bitCountH == iXMIT_WORD_LEN ) 
                begin
                    iXMIT_next_state = iXMIT_x_STOP;
                end
                else
                begin 
                    iXMIT_next_state = iXMIT_x_SHIFT;
                    iXMIT_ena_bitCountH = iXMIT_HI;
                end
            end
            else
            begin 
                iXMIT_next_state = iXMIT_x_WAIT;
                iXMIT_countEnaH = iXMIT_HI;
            end
        end
        iXMIT_x_SHIFT:
        begin
            iXMIT_xmitDataSelH = iXMIT_x_ShiftReg;
            iXMIT_next_state = iXMIT_x_WAIT;
            iXMIT_shiftEnaH = iXMIT_HI;
        end
        iXMIT_x_STOP:
        begin
            iXMIT_xmitDataSelH = iXMIT_x_STOPbit;
            if ( iXMIT_bitCell_cntrH == 4'hF ) 
            begin
                iXMIT_next_state = iXMIT_x_IDLE;
                iXMIT_xmit_doneInH = iXMIT_HI;
            end
            else
            begin 
                iXMIT_next_state = iXMIT_x_STOP;
                iXMIT_countEnaH = iXMIT_HI;
            end
        end
        endcase
    end
    always @ (  posedge sys_clk or  negedge sys_rst_l)
    begin
        if (  ~( sys_rst_l) ) 
        begin
            iXMIT_xmit_doneH <= 1'b0;
        end
        else
        begin 
            iXMIT_xmit_doneH <= iXMIT_xmit_doneInH;
        end
    end
    assign rec_readyH = iRECEIVER_rec_readyH;
    always @ (  * )
    begin
        if ( ( ( iRECEIVER_rec_dataH == 8'b11111111 ) & ( ( iRECEIVER_bitCell_cntrH == 4'b1110 ) && ( iRECEIVER_recd_bitCntrH == 4'b0011 ) ) ) & ( iRECEIVER_state == 3'b011 ) ) 
        begin
            iRECEIVER_rec_readyH = 1'b0;
        end
        else
        begin 
            iRECEIVER_rec_readyH = iRECEIVER_rec_readyH_temp;
        end
    end
    always @ (  posedge sys_clk or  negedge sys_rst_l)
    begin
        if (  ~( sys_rst_l) ) 
        begin
            iRECEIVER_rec_datSyncH <= 1'b1;
            iRECEIVER_rec_datH <= 1'b1;
        end
        else
        begin 
            iRECEIVER_rec_datSyncH <= uart_REC_dataH;
            iRECEIVER_rec_datH <= iRECEIVER_rec_datSyncH;
        end
    end
    always @ (  posedge sys_clk or  negedge sys_rst_l)
    begin
        if (  ~( sys_rst_l) ) 
        begin
            iRECEIVER_bitCell_cntrH <= 4'b0;
        end
        else
        begin 
            if ( iRECEIVER_cntr_resetH ) 
            begin
                iRECEIVER_bitCell_cntrH <= 4'b0;
            end
            else
            begin 
                iRECEIVER_bitCell_cntrH <= ( iRECEIVER_bitCell_cntrH + 4'b1 );
            end
        end
    end
    always @ (  posedge sys_clk or  negedge sys_rst_l)
    begin
        if (  ~( sys_rst_l) ) 
        begin
            iRECEIVER_rec_dataH <= 8'b0;
        end
        else
        begin 
            if ( iRECEIVER_shiftH ) 
            begin
                iRECEIVER_rec_dataH <= { iRECEIVER_rec_datH, iRECEIVER_rec_dataH[7:1] };
            end
        end
    end
    always @ (  posedge sys_clk or  negedge sys_rst_l)
    begin
        if (  ~( sys_rst_l) ) 
        begin
            iRECEIVER_recd_bitCntrH <= 4'b0;
        end
        else
        begin 
            if ( iRECEIVER_countH ) 
            begin
                iRECEIVER_recd_bitCntrH <= ( iRECEIVER_recd_bitCntrH + 4'b1 );
            end
            else
            begin 
                if ( iRECEIVER_rstCountH ) 
                begin
                    iRECEIVER_recd_bitCntrH <= 4'b0;
                end
            end
        end
    end
    always @ (  posedge sys_clk or  negedge sys_rst_l)
    begin
        if (  ~( sys_rst_l) ) 
        begin
            iRECEIVER_state <= iRECEIVER_r_START;
        end
        else
        begin 
            iRECEIVER_state <= iRECEIVER_next_state;
        end
    end
    always @ (  iRECEIVER_state or  iRECEIVER_rec_datH or  iRECEIVER_bitCell_cntrH or  iRECEIVER_recd_bitCntrH)
    begin
        iRECEIVER_next_state = iRECEIVER_state;
        iRECEIVER_cntr_resetH = iRECEIVER_HI;
        iRECEIVER_shiftH = iRECEIVER_LO;
        iRECEIVER_countH = iRECEIVER_LO;
        iRECEIVER_rstCountH = iRECEIVER_LO;
        iRECEIVER_rec_readyInH = iRECEIVER_LO;
        case ( iRECEIVER_state ) 
        iRECEIVER_r_START:
        begin
            if (  ~( iRECEIVER_rec_datH) ) 
            begin
                iRECEIVER_next_state = iRECEIVER_r_CENTER;
            end
            else
            begin 
                iRECEIVER_next_state = iRECEIVER_r_START;
                iRECEIVER_rstCountH = iRECEIVER_HI;
                iRECEIVER_rec_readyInH = iRECEIVER_HI;
            end
        end
        iRECEIVER_r_CENTER:
        begin
            if ( iRECEIVER_bitCell_cntrH == 4'h4 ) 
            begin
                if (  ~( iRECEIVER_rec_datH) ) 
                begin
                    iRECEIVER_next_state = iRECEIVER_r_WAIT;
                end
                else
                begin 
                    iRECEIVER_next_state = iRECEIVER_r_START;
                end
            end
            else
            begin 
                iRECEIVER_next_state = iRECEIVER_r_CENTER;
                iRECEIVER_cntr_resetH = iRECEIVER_LO;
            end
        end
        iRECEIVER_r_WAIT:
        begin
            if ( iRECEIVER_bitCell_cntrH == 4'hE ) 
            begin
                if ( iRECEIVER_recd_bitCntrH == iRECEIVER_WORD_LEN ) 
                begin
                    iRECEIVER_next_state = iRECEIVER_r_STOP;
                end
                else
                begin 
                    iRECEIVER_next_state = iRECEIVER_r_SAMPLE;
                end
            end
            else
            begin 
                iRECEIVER_next_state = iRECEIVER_r_WAIT;
                iRECEIVER_cntr_resetH = iRECEIVER_LO;
            end
        end
        iRECEIVER_r_SAMPLE:
        begin
            iRECEIVER_shiftH = iRECEIVER_HI;
            iRECEIVER_countH = iRECEIVER_HI;
            iRECEIVER_next_state = iRECEIVER_r_WAIT;
        end
        iRECEIVER_r_STOP:
        begin
            iRECEIVER_next_state = iRECEIVER_r_START;
            iRECEIVER_rec_readyInH = iRECEIVER_HI;
        end
        endcase
    end
    always @ (  posedge sys_clk or  negedge sys_rst_l)
    begin
        if (  ~( sys_rst_l) ) 
        begin
            iRECEIVER_rec_readyH_temp <= 1'b0;
        end
        else
        begin 
            iRECEIVER_rec_readyH_temp <= iRECEIVER_rec_readyInH;
        end
    end
endmodule 


