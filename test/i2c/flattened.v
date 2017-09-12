module i2c_master_top(
        wb_clk_i,
        rst_i,
        wb_adr_i,
        wb_dat_i,
        wb_dat_o,
        wb_we_i,
        wb_stb_i,
        wb_cyc_i,
        wb_ack_o,
        wb_inta_o,
        scl_pad_i,
        scl_pad_o,
        scl_padoen_o,
        sda_pad_i,
        sda_pad_o,
        sda_padoen_o
    );
    parameter [4:0]byte_controller_ST_IDLE  = 5'b0_0000;
    parameter [4:0]byte_controller_ST_START  = 5'b0_0001;
    parameter [4:0]byte_controller_ST_READ  = 5'b0_0010;
    parameter [4:0]byte_controller_ST_WRITE  = 5'b0_0100;
    parameter [4:0]byte_controller_ST_ACK  = 5'b0_1000;
    parameter [4:0]byte_controller_ST_STOP  = 5'b1_0000;
    parameter [16:0]byte_controller_bit_controller_idle  = 17'b0_0000_0000_0000_0000;
    parameter [16:0]byte_controller_bit_controller_start_a  = 17'b0_0000_0000_0000_0001;
    parameter [16:0]byte_controller_bit_controller_start_b  = 17'b0_0000_0000_0000_0010;
    parameter [16:0]byte_controller_bit_controller_start_c  = 17'b0_0000_0000_0000_0100;
    parameter [16:0]byte_controller_bit_controller_start_d  = 17'b0_0000_0000_0000_1000;
    parameter [16:0]byte_controller_bit_controller_start_e  = 17'b0_0000_0000_0001_0000;
    parameter [16:0]byte_controller_bit_controller_stop_a  = 17'b0_0000_0000_0010_0000;
    parameter [16:0]byte_controller_bit_controller_stop_b  = 17'b0_0000_0000_0100_0000;
    parameter [16:0]byte_controller_bit_controller_stop_c  = 17'b0_0000_0000_1000_0000;
    parameter [16:0]byte_controller_bit_controller_stop_d  = 17'b0_0000_0001_0000_0000;
    parameter [16:0]byte_controller_bit_controller_rd_a  = 17'b0_0000_0010_0000_0000;
    parameter [16:0]byte_controller_bit_controller_rd_b  = 17'b0_0000_0100_0000_0000;
    parameter [16:0]byte_controller_bit_controller_rd_c  = 17'b0_0000_1000_0000_0000;
    parameter [16:0]byte_controller_bit_controller_rd_d  = 17'b0_0001_0000_0000_0000;
    parameter [16:0]byte_controller_bit_controller_wr_a  = 17'b0_0010_0000_0000_0000;
    parameter [16:0]byte_controller_bit_controller_wr_b  = 17'b0_0100_0000_0000_0000;
    parameter [16:0]byte_controller_bit_controller_wr_c  = 17'b0_1000_0000_0000_0000;
    parameter [16:0]byte_controller_bit_controller_wr_d  = 17'b1_0000_0000_0000_0000;
    input wb_clk_i;
    input rst_i;
    input [2:0]wb_adr_i;
    input [7:0]wb_dat_i;
    output [7:0]wb_dat_o;
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
    reg [7:0]wb_dat_o;
    reg wb_ack_o;
    reg wb_inta_o;
    reg [15:0]prer;
    reg [7:0]ctr;
    reg [7:0]txr;
    reg [7:0]cr;
    reg rxack;
    reg tip;
    reg irq_flag;
    wire i2c_busy;
    reg al;
    wire wb_wacc = ( ( wb_cyc_i & wb_stb_i ) & wb_we_i );
    wire sta = cr[7];
    wire sto = cr[6];
    wire rd = cr[5];
    wire wr = cr[4];
    wire ack = cr[3];
    wire iack = cr[0];
    wire [7:0]byte_controller_dout;
    wire byte_controller_i2c_busy;
    wire byte_controller_i2c_al;
    reg byte_controller_cmd_ack;
    reg byte_controller_ack_out;
    reg [3:0]byte_controller_core_cmd;
    reg byte_controller_core_txd;
    reg [7:0]byte_controller_sr;
    reg byte_controller_shift;
    reg byte_controller_ld;
    reg [2:0]byte_controller_dcnt;
    reg [4:0]byte_controller_c_state;
    reg byte_controller_target;
    wire byte_controller_bit_controller_scl_o;
    wire byte_controller_bit_controller_sda_o;
    reg byte_controller_bit_controller_cmd_ack;
    reg byte_controller_bit_controller_busy;
    reg byte_controller_bit_controller_al;
    reg byte_controller_bit_controller_dout;
    reg byte_controller_bit_controller_scl_oen;
    reg byte_controller_bit_controller_sda_oen;
    reg byte_controller_bit_controller_sSCL;
    reg byte_controller_bit_controller_sSDB;
    reg byte_controller_bit_controller_dscl_oen;
    reg byte_controller_bit_controller_sda_chk;
    reg byte_controller_bit_controller_clk_en;
    reg [15:0]byte_controller_bit_controller_cnt;
    reg [16:0]byte_controller_bit_controller_c_state;
    reg byte_controller_bit_controller_dSCL;
    reg byte_controller_bit_controller_dSDA;
    reg byte_controller_bit_controller_sta_condition;
    reg byte_controller_bit_controller_sto_condition;
    reg byte_controller_bit_controller_cmd_stop;
    always @ (  posedge wb_clk_i)
    begin
        wb_ack_o <= #1 ( ( wb_cyc_i & wb_stb_i ) &  ~( wb_ack_o) );
    end
    always @ (  posedge wb_clk_i)
    begin
        case ( wb_adr_i ) 
        3'b000:
        begin
            wb_dat_o <= #1 prer[7:0];
        end
        3'b001:
        begin
            wb_dat_o <= #1 prer[15:8];
        end
        3'b010:
        begin
            wb_dat_o <= #1 ctr;
        end
        3'b011:
        begin
            wb_dat_o <= #1 byte_controller_dout;
        end
        3'b100:
        begin
            wb_dat_o <= #1 { rxack, i2c_busy, al, 3'h0, tip, irq_flag };
        end
        3'b101:
        begin
            wb_dat_o <= #1 txr;
        end
        3'b110:
        begin
            wb_dat_o <= #1 cr;
        end
        3'b111:
        begin
            wb_dat_o <= #1 0;
        end
        endcase
    end
    always @ (  posedge wb_clk_i or  negedge rst_i)
    begin
        if (  !( rst_i) ) 
        begin
            prer <= #1 16'hffff;
            ctr <= #1 8'h0;
            txr <= #1 8'h0;
        end
        else
        begin 
            if ( wb_wacc ) 
            begin
                case ( wb_adr_i ) 
                3'b000:
                begin
                    prer <= #1 { prer[15:8], wb_dat_i };
                end
                3'b001:
                begin
                    prer <= #1 { wb_dat_i, prer[7:0] };
                end
                3'b010:
                begin
                    ctr <= #1 wb_dat_i;
                end
                3'b011:
                begin
                    txr <= #1 wb_dat_i;
                end
                endcase
            end
        end
    end
    always @ (  posedge wb_clk_i or  negedge rst_i)
    begin
        if (  ~( rst_i) ) 
        begin
            cr <= #1 8'h0;
        end
        else
        begin 
            if ( wb_wacc ) 
            begin
                if ( ctr[7] & ( wb_adr_i == 3'b100 ) ) 
                begin
                    cr <= #1 wb_dat_i;
                end
            end
            else
            begin 
                if ( byte_controller_cmd_ack | byte_controller_i2c_al ) 
                begin
                    cr <= #1 { 4'h0, cr[3:0] };
                end
                cr <= #1 { cr[7:3], 3'b0 };
            end
        end
    end
    always @ (  posedge wb_clk_i or  negedge rst_i)
    begin
        if (  !( rst_i) ) 
        begin
            al <= #1 1'b0;
            rxack <= #1 1'b0;
            tip <= #1 1'b0;
            irq_flag <= #1 1'b0;
        end
        else
        begin 
            al <= #1 ( byte_controller_i2c_al | ( al &  ~( sta) ) );
            rxack <= #1 byte_controller_ack_out;
            tip <= #1 ( rd | wr );
            irq_flag <= #1 ( ( ( byte_controller_cmd_ack | byte_controller_i2c_al ) | irq_flag ) &  ~( iack) );
        end
    end
    always @ (  posedge wb_clk_i or  negedge rst_i)
    begin
        if (  !( rst_i) ) 
        begin
            wb_inta_o <= #1 1'b0;
        end
        else
        begin 
            wb_inta_o <= #1 ( irq_flag && ctr[6] );
        end
    end
    assign i2c_busy = byte_controller_bit_controller_busy;
    assign scl_pad_o = 1'b0;
    assign scl_padoen_o = byte_controller_bit_controller_scl_oen;
    assign sda_pad_o = 1'b0;
    assign sda_padoen_o = byte_controller_bit_controller_sda_oen;
    assign byte_controller_i2c_busy = byte_controller_bit_controller_busy;
    assign byte_controller_i2c_al = byte_controller_bit_controller_al;
    always @ (  posedge wb_clk_i or  negedge rst_i)
    begin
        if (  ~( rst_i) ) 
        begin
            byte_controller_bit_controller_dscl_oen <= 1'b0;
        end
        else
        begin 
            byte_controller_bit_controller_dscl_oen <= byte_controller_bit_controller_scl_oen;
        end
    end
    always @ (  posedge wb_clk_i or  negedge rst_i)
    begin
        if (  ~( rst_i) ) 
        begin
            byte_controller_bit_controller_cnt <= 16'h0;
            byte_controller_bit_controller_clk_en <= 1'b1;
        end
        else
        begin 
            if (  ~|( byte_controller_bit_controller_cnt) ||  ~( ctr[7]) ) 
            begin
                if (  ~( ( byte_controller_bit_controller_dscl_oen &&  !( byte_controller_bit_controller_sSCL) )) ) 
                begin
                    byte_controller_bit_controller_cnt <= prer;
                    byte_controller_bit_controller_clk_en <= 1'b1;
                end
                else
                begin 
                    byte_controller_bit_controller_cnt <= byte_controller_bit_controller_cnt;
                    byte_controller_bit_controller_clk_en <= 1'b0;
                end
            end
            else
            begin 
                byte_controller_bit_controller_cnt <= ( byte_controller_bit_controller_cnt - 16'h1 );
                byte_controller_bit_controller_clk_en <= 1'b0;
            end
        end
    end
    always @ (  posedge wb_clk_i or  negedge rst_i)
    begin
        if (  ~( rst_i) ) 
        begin
            byte_controller_bit_controller_sSCL <= 1'b1;
            byte_controller_bit_controller_sSDB <= 1'b1;
            byte_controller_bit_controller_dSCL <= 1'b1;
            byte_controller_bit_controller_dSDA <= 1'b1;
        end
        else
        begin 
            byte_controller_bit_controller_sSCL <= scl_pad_i;
            byte_controller_bit_controller_sSDB <= sda_pad_i;
            byte_controller_bit_controller_dSCL <= byte_controller_bit_controller_sSCL;
            byte_controller_bit_controller_dSDA <= byte_controller_bit_controller_sSDB;
        end
    end
    always @ (  posedge wb_clk_i or  negedge rst_i)
    begin
        if (  ~( rst_i) ) 
        begin
            byte_controller_bit_controller_sta_condition <= 1'b0;
            byte_controller_bit_controller_sto_condition <= 1'b0;
        end
        else
        begin 
            byte_controller_bit_controller_sta_condition <= ( (  ~( byte_controller_bit_controller_sSDB) & byte_controller_bit_controller_dSDA ) & byte_controller_bit_controller_sSCL );
            byte_controller_bit_controller_sto_condition <= ( ( byte_controller_bit_controller_sSDB &  ~( byte_controller_bit_controller_dSDA) ) & byte_controller_bit_controller_sSCL );
        end
    end
    always @ (  posedge wb_clk_i or  negedge rst_i)
    begin
        if (  !( rst_i) ) 
        begin
            byte_controller_bit_controller_busy <= 1'b0;
        end
        else
        begin 
            byte_controller_bit_controller_busy <= ( ( byte_controller_bit_controller_sta_condition | byte_controller_bit_controller_busy ) &  ~( byte_controller_bit_controller_sto_condition) );
        end
    end
    always @ (  posedge wb_clk_i or  negedge rst_i)
    begin
        if (  ~( rst_i) ) 
        begin
            byte_controller_bit_controller_cmd_stop <= 1'b0;
        end
        else
        begin 
            if ( byte_controller_bit_controller_clk_en ) 
            begin
                byte_controller_bit_controller_cmd_stop <= ( byte_controller_core_cmd == 4'b0010 );
            end
        end
    end
    always @ (  posedge wb_clk_i or  negedge rst_i)
    begin
        if (  ~( rst_i) ) 
        begin
            byte_controller_bit_controller_al <= 1'b0;
        end
        else
        begin 
            byte_controller_bit_controller_al <= ( ( ( byte_controller_bit_controller_sda_chk &  ~( byte_controller_bit_controller_sSDB) ) & byte_controller_bit_controller_sda_oen ) | ( (  |( byte_controller_bit_controller_c_state) & byte_controller_bit_controller_sto_condition ) &  ~( byte_controller_bit_controller_cmd_stop) ) );
        end
    end
    always @ (  posedge wb_clk_i or  negedge rst_i)
    begin
        if (  ~( rst_i) ) 
        begin
            byte_controller_bit_controller_dout <= 1'b0;
        end
        else
        begin 
            if ( byte_controller_bit_controller_sSCL &  ~( byte_controller_bit_controller_dSCL) ) 
            begin
                byte_controller_bit_controller_dout <= byte_controller_bit_controller_sSDB;
            end
        end
    end
    always @ (  posedge wb_clk_i or  negedge rst_i)
    begin
        if (  !( rst_i) ) 
        begin
            byte_controller_bit_controller_c_state <= byte_controller_bit_controller_idle;
            byte_controller_bit_controller_cmd_ack <= 1'b0;
            byte_controller_bit_controller_scl_oen <= 1'b1;
            byte_controller_bit_controller_sda_oen <= 1'b1;
            byte_controller_bit_controller_sda_chk <= 1'b0;
        end
        else
        begin 
            if ( byte_controller_bit_controller_al ) 
            begin
                byte_controller_bit_controller_c_state <= byte_controller_bit_controller_idle;
                byte_controller_bit_controller_cmd_ack <= 1'b0;
                byte_controller_bit_controller_scl_oen <= 1'b1;
                byte_controller_bit_controller_sda_oen <= 1'b1;
                byte_controller_bit_controller_sda_chk <= 1'b0;
            end
            else
            begin 
                byte_controller_bit_controller_cmd_ack <= 1'b0;
                if ( byte_controller_bit_controller_clk_en ) 
                begin
                    case ( byte_controller_bit_controller_c_state ) 
                    byte_controller_bit_controller_idle:
                    begin
                        case ( byte_controller_core_cmd ) 
                        4'b0001:
                        begin
                            byte_controller_bit_controller_c_state <= byte_controller_bit_controller_start_a;
                        end
                        4'b0010:
                        begin
                            byte_controller_bit_controller_c_state <= byte_controller_bit_controller_stop_a;
                        end
                        4'b0100:
                        begin
                            byte_controller_bit_controller_c_state <= byte_controller_bit_controller_wr_a;
                        end
                        4'b1000:
                        begin
                            byte_controller_bit_controller_c_state <= byte_controller_bit_controller_rd_a;
                        end
                        default :
                        begin
                            byte_controller_bit_controller_c_state <= byte_controller_bit_controller_idle;
                        end
                        endcase
                        byte_controller_bit_controller_scl_oen <= byte_controller_bit_controller_scl_oen;
                        byte_controller_bit_controller_sda_oen <= byte_controller_bit_controller_sda_oen;
                        byte_controller_bit_controller_sda_chk <= 1'b0;
                    end
                    byte_controller_bit_controller_start_a:
                    begin
                        byte_controller_bit_controller_c_state <= byte_controller_bit_controller_start_b;
                        byte_controller_bit_controller_scl_oen <= byte_controller_bit_controller_scl_oen;
                        byte_controller_bit_controller_sda_oen <= 1'b1;
                        byte_controller_bit_controller_sda_chk <= 1'b0;
                    end
                    byte_controller_bit_controller_start_b:
                    begin
                        byte_controller_bit_controller_c_state <= byte_controller_bit_controller_start_c;
                        byte_controller_bit_controller_scl_oen <= 1'b1;
                        byte_controller_bit_controller_sda_oen <= 1'b1;
                        byte_controller_bit_controller_sda_chk <= 1'b0;
                    end
                    byte_controller_bit_controller_start_c:
                    begin
                        byte_controller_bit_controller_c_state <= byte_controller_bit_controller_start_d;
                        byte_controller_bit_controller_scl_oen <= 1'b1;
                        byte_controller_bit_controller_sda_oen <= 1'b0;
                        byte_controller_bit_controller_sda_chk <= 1'b0;
                    end
                    byte_controller_bit_controller_start_d:
                    begin
                        byte_controller_bit_controller_c_state <= byte_controller_bit_controller_start_e;
                        byte_controller_bit_controller_scl_oen <= 1'b1;
                        byte_controller_bit_controller_sda_oen <= 1'b0;
                        byte_controller_bit_controller_sda_chk <= 1'b0;
                    end
                    byte_controller_bit_controller_start_e:
                    begin
                        byte_controller_bit_controller_c_state <= byte_controller_bit_controller_idle;
                        byte_controller_bit_controller_cmd_ack <= 1'b1;
                        byte_controller_bit_controller_scl_oen <= 1'b0;
                        byte_controller_bit_controller_sda_oen <= 1'b0;
                        byte_controller_bit_controller_sda_chk <= 1'b0;
                    end
                    byte_controller_bit_controller_stop_a:
                    begin
                        byte_controller_bit_controller_c_state <= byte_controller_bit_controller_stop_b;
                        byte_controller_bit_controller_scl_oen <= 1'b0;
                        byte_controller_bit_controller_sda_oen <= 1'b0;
                        byte_controller_bit_controller_sda_chk <= 1'b0;
                    end
                    byte_controller_bit_controller_stop_b:
                    begin
                        byte_controller_bit_controller_c_state <= byte_controller_bit_controller_stop_c;
                        byte_controller_bit_controller_scl_oen <= 1'b1;
                        byte_controller_bit_controller_sda_oen <= 1'b0;
                        byte_controller_bit_controller_sda_chk <= 1'b0;
                    end
                    byte_controller_bit_controller_stop_c:
                    begin
                        byte_controller_bit_controller_c_state <= byte_controller_bit_controller_stop_d;
                        byte_controller_bit_controller_scl_oen <= 1'b1;
                        byte_controller_bit_controller_sda_oen <= 1'b0;
                        byte_controller_bit_controller_sda_chk <= 1'b0;
                    end
                    byte_controller_bit_controller_stop_d:
                    begin
                        byte_controller_bit_controller_c_state <= byte_controller_bit_controller_idle;
                        byte_controller_bit_controller_cmd_ack <= 1'b1;
                        byte_controller_bit_controller_scl_oen <= 1'b1;
                        byte_controller_bit_controller_sda_oen <= 1'b1;
                        byte_controller_bit_controller_sda_chk <= 1'b0;
                    end
                    byte_controller_bit_controller_rd_a:
                    begin
                        byte_controller_bit_controller_c_state <= byte_controller_bit_controller_rd_b;
                        byte_controller_bit_controller_scl_oen <= 1'b0;
                        byte_controller_bit_controller_sda_oen <= 1'b1;
                        byte_controller_bit_controller_sda_chk <= 1'b0;
                    end
                    byte_controller_bit_controller_rd_b:
                    begin
                        byte_controller_bit_controller_c_state <= byte_controller_bit_controller_rd_c;
                        byte_controller_bit_controller_scl_oen <= 1'b1;
                        byte_controller_bit_controller_sda_oen <= 1'b1;
                        byte_controller_bit_controller_sda_chk <= 1'b0;
                    end
                    byte_controller_bit_controller_rd_c:
                    begin
                        byte_controller_bit_controller_c_state <= byte_controller_bit_controller_rd_d;
                        byte_controller_bit_controller_scl_oen <= 1'b1;
                        byte_controller_bit_controller_sda_oen <= 1'b1;
                        byte_controller_bit_controller_sda_chk <= 1'b0;
                    end
                    byte_controller_bit_controller_rd_d:
                    begin
                        byte_controller_bit_controller_c_state <= byte_controller_bit_controller_idle;
                        byte_controller_bit_controller_cmd_ack <= 1'b1;
                        byte_controller_bit_controller_scl_oen <= 1'b0;
                        byte_controller_bit_controller_sda_oen <= 1'b1;
                        byte_controller_bit_controller_sda_chk <= 1'b0;
                    end
                    byte_controller_bit_controller_wr_a:
                    begin
                        byte_controller_bit_controller_c_state <= byte_controller_bit_controller_wr_b;
                        byte_controller_bit_controller_scl_oen <= 1'b0;
                        byte_controller_bit_controller_sda_oen <= byte_controller_core_txd;
                        byte_controller_bit_controller_sda_chk <= 1'b0;
                    end
                    byte_controller_bit_controller_wr_b:
                    begin
                        byte_controller_bit_controller_c_state <= byte_controller_bit_controller_wr_c;
                        byte_controller_bit_controller_scl_oen <= 1'b1;
                        byte_controller_bit_controller_sda_oen <= byte_controller_core_txd;
                        byte_controller_bit_controller_sda_chk <= 1'b1;
                    end
                    byte_controller_bit_controller_wr_c:
                    begin
                        byte_controller_bit_controller_c_state <= byte_controller_bit_controller_wr_d;
                        byte_controller_bit_controller_scl_oen <= 1'b1;
                        byte_controller_bit_controller_sda_oen <= byte_controller_core_txd;
                        byte_controller_bit_controller_sda_chk <= 1'b1;
                    end
                    byte_controller_bit_controller_wr_d:
                    begin
                        byte_controller_bit_controller_c_state <= byte_controller_bit_controller_idle;
                        byte_controller_bit_controller_cmd_ack <= 1'b1;
                        byte_controller_bit_controller_scl_oen <= 1'b0;
                        byte_controller_bit_controller_sda_oen <= byte_controller_core_txd;
                        byte_controller_bit_controller_sda_chk <= 1'b0;
                    end
                    endcase
                end
            end
        end
    end
    assign byte_controller_dout = byte_controller_sr;
    always @ (  posedge wb_clk_i or  negedge rst_i)
    begin
        if (  !( rst_i) ) 
        begin
            byte_controller_sr <= 8'h0;
        end
        else
        begin 
            if ( byte_controller_ld ) 
            begin
                byte_controller_sr <= txr;
            end
            else
            begin 
                if ( byte_controller_shift ) 
                begin
                    byte_controller_sr <= { byte_controller_sr[6:0], byte_controller_bit_controller_dout };
                end
            end
        end
    end
    always @ (  posedge wb_clk_i or  negedge rst_i)
    begin
        if (  !( rst_i) ) 
        begin
            byte_controller_dcnt <= 3'h0;
        end
        else
        begin 
            if ( byte_controller_ld ) 
            begin
                byte_controller_dcnt <= 3'h7;
            end
            else
            begin 
                if ( byte_controller_shift ) 
                begin
                    byte_controller_dcnt <= ( byte_controller_dcnt - 3'h1 );
                end
            end
        end
    end
    always @ (  posedge wb_clk_i or  negedge rst_i)
    begin
        if (  !( rst_i) ) 
        begin
            byte_controller_core_cmd <= 4'b0000;
            byte_controller_core_txd <= 1'b0;
            byte_controller_shift <= 1'b0;
            byte_controller_ld <= 1'b0;
            byte_controller_cmd_ack <= 1'b0;
            byte_controller_c_state <= byte_controller_ST_IDLE;
            byte_controller_ack_out <= 1'b0;
        end
        else
        begin 
            if ( byte_controller_bit_controller_al ) 
            begin
                byte_controller_core_cmd <= 4'b0000;
                byte_controller_core_txd <= 1'b0;
                byte_controller_shift <= 1'b0;
                byte_controller_ld <= 1'b0;
                byte_controller_cmd_ack <= 1'b0;
                byte_controller_c_state <= byte_controller_ST_IDLE;
                byte_controller_ack_out <= 1'b0;
            end
            else
            begin 
                byte_controller_core_txd <= byte_controller_sr[7];
                byte_controller_shift <= 1'b0;
                byte_controller_ld <= 1'b0;
                byte_controller_cmd_ack <= 1'b0;
                case ( byte_controller_c_state ) 
                byte_controller_ST_IDLE:
                begin
                    if ( ( ( rd | wr ) | sto ) &  ~( byte_controller_cmd_ack) ) 
                    begin
                        if ( sta ) 
                        begin
                            byte_controller_target <= 1;
                            byte_controller_c_state <= byte_controller_ST_START;
                            byte_controller_core_cmd <= 4'b0001;
                        end
                        else
                        begin 
                            if ( rd ) 
                            begin
                                byte_controller_c_state <= byte_controller_ST_READ;
                                byte_controller_core_cmd <= 4'b1000;
                            end
                            else
                            begin 
                                if ( wr ) 
                                begin
                                    byte_controller_c_state <= byte_controller_ST_WRITE;
                                    byte_controller_core_cmd <= 4'b0100;
                                end
                                else
                                begin 
                                    byte_controller_c_state <= byte_controller_ST_STOP;
                                    byte_controller_core_cmd <= 4'b0010;
                                end
                            end
                        end
                        byte_controller_ld <= 1'b1;
                    end
                end
                byte_controller_ST_START:
                begin
                    if ( byte_controller_bit_controller_cmd_ack ) 
                    begin
                        if ( rd ) 
                        begin
                            byte_controller_c_state <= byte_controller_ST_READ;
                            byte_controller_core_cmd <= 4'b1000;
                        end
                        else
                        begin 
                            byte_controller_c_state <= byte_controller_ST_WRITE;
                            byte_controller_core_cmd <= 4'b0100;
                        end
                        byte_controller_ld <= 1'b1;
                    end
                end
                byte_controller_ST_WRITE:
                begin
                    if ( byte_controller_bit_controller_cmd_ack ) 
                    begin
                        if (  ~(  |( byte_controller_dcnt)) ) 
                        begin
                            byte_controller_c_state <= byte_controller_ST_ACK;
                            byte_controller_core_cmd <= 4'b1000;
                        end
                        else
                        begin 
                            byte_controller_c_state <= byte_controller_ST_WRITE;
                            byte_controller_core_cmd <= 4'b0100;
                            byte_controller_shift <= 1'b1;
                        end
                    end
                end
                byte_controller_ST_READ:
                begin
                    if ( byte_controller_bit_controller_cmd_ack ) 
                    begin
                        if (  ~(  |( byte_controller_dcnt)) ) 
                        begin
                            byte_controller_c_state <= byte_controller_ST_ACK;
                            byte_controller_core_cmd <= 4'b0100;
                        end
                        else
                        begin 
                            byte_controller_c_state <= byte_controller_ST_READ;
                            byte_controller_core_cmd <= 4'b1000;
                        end
                        byte_controller_shift <= 1'b1;
                        byte_controller_core_txd <= ack;
                    end
                end
                byte_controller_ST_ACK:
                begin
                    if ( byte_controller_bit_controller_cmd_ack ) 
                    begin
                        if ( sto ) 
                        begin
                            byte_controller_c_state <= byte_controller_ST_STOP;
                            byte_controller_core_cmd <= 4'b0010;
                        end
                        else
                        begin 
                            byte_controller_c_state <= byte_controller_ST_IDLE;
                            byte_controller_core_cmd <= 4'b0000;
                            byte_controller_cmd_ack <= 1'b1;
                        end
                        byte_controller_ack_out <= byte_controller_bit_controller_dout;
                        byte_controller_core_txd <= 1'b1;
                    end
                    else
                    begin 
                        byte_controller_core_txd <= ack;
                    end
                end
                byte_controller_ST_STOP:
                begin
                    if ( byte_controller_bit_controller_cmd_ack ) 
                    begin
                        byte_controller_c_state <= byte_controller_ST_IDLE;
                        byte_controller_core_cmd <= 4'b0000;
                        byte_controller_cmd_ack <= 1'b1;
                    end
                end
                endcase
            end
        end
    end
endmodule 


