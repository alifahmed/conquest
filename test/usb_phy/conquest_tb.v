module conquest_tb();

    // Generated top module signals
    reg  clk;
    reg  rst;
    reg  phy_tx_mode = 1'b0;
    wire usb_rst;
    wire txdp;
    wire txdn;
    wire txoe;
    reg  rxd = 1'b0;
    reg  rxdp = 1'b0;
    reg  rxdn = 1'b0;
    reg  [7:0] DataOut_i = 8'b0;
    reg  TxValid_i = 1'b0;
    wire TxReady_o;
    wire RxValid_o;
    wire RxActive_o;
    wire RxError_o;
    wire [7:0] DataIn_o;
    wire [1:0] LineState_o;
    reg  __obs;

    // Generated top module instance
    usb_phy _conc_top_inst(
            .clk       ( clk ),
            .rst       ( rst ),
            .phy_tx_mode( phy_tx_mode ),
            .usb_rst   ( usb_rst ),
            .txdp      ( txdp ),
            .txdn      ( txdn ),
            .txoe      ( txoe ),
            .rxd       ( rxd ),
            .rxdp      ( rxdp ),
            .rxdn      ( rxdn ),
            .DataOut_i ( DataOut_i ),
            .TxValid_i ( TxValid_i ),
            .TxReady_o ( TxReady_o ),
            .RxValid_o ( RxValid_o ),
            .RxActive_o( RxActive_o ),
            .RxError_o ( RxError_o ),
            .DataIn_o  ( DataIn_o ),
            .LineState_o( LineState_o ),
            .__obs     ( __obs ));

    // Generated internal use signals
    reg  [31:0] _conc_pc;
    reg  [13:0] _conc_opcode;
    reg  [13:0] _conc_ram[0:20];


    // Generated clock pulse
    always begin
        #5 clk = ~clk;
    end

    // Generated program counter
    always @(posedge clk) begin
        _conc_pc = _conc_pc + 32'b1;
        _conc_opcode = _conc_ram[_conc_pc];
        DataOut_i <= #1 _conc_opcode[11:4];
        TxValid_i <= #1 _conc_opcode[12];
        __obs <= #1 _conc_opcode[13];
        phy_tx_mode <= #1 _conc_opcode[0];
        rxd <= #1 _conc_opcode[1];
        rxdn <= #1 _conc_opcode[3];
        rxdp <= #1 _conc_opcode[2];
        $strobe(";_C %d", _conc_pc);
    end

    // Generated initial block
    initial begin
        clk = 1'b0;
        rst = 1'b1;
        _conc_pc = 32'b0;
        $readmemb("data.mem", _conc_ram);
        #2 clk = 1'b1;
        rst = 1'b0;
        #5 rst = 1'b1;
        #200 $finish;
    end

endmodule
