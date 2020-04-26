module MemoryTestBench(); 

    localparam DATA_WIDTH       = 64;
    localparam ADDRESS_WIDTH_1  = 10;
    localparam ADDRESS_WIDTH_2  = 12;
    localparam ADDRESS_WIDTH_3  = 12;
    localparam ADDRESS_WIDTH_4  = 10;

    reg                             clk;
    reg  [ADDRESS_WIDTH_1-1:0] address_1;
    reg  [ADDRESS_WIDTH_2-1:0] address_2;
    reg  [ADDRESS_WIDTH_3-1:0] address_3;
    reg  [ADDRESS_WIDTH_4-1:0] address_4;
    reg  [DATA_WIDTH-1:0]   data_write_1;
    reg  [DATA_WIDTH-1:0]   data_write_2;
    reg  [DATA_WIDTH-1:0]   data_write_3;
    reg  [DATA_WIDTH-1:0]   data_write_4;
    wire [DATA_WIDTH-1:0]    data_read_1;
    wire [DATA_WIDTH-1:0]    data_read_2;
    wire [DATA_WIDTH-1:0]    data_read_3;
    wire [DATA_WIDTH-1:0]    data_read_4;
    reg                      WR_signal_1;
    reg                      WR_signal_2;
    reg                      WR_signal_3;
    reg                      WR_signal_4;

    RAM ram (.clk(clk),
            .address_1(address_1),
            .address_2(address_2),
            .address_3(address_3),
            .address_4(address_4),
            .data_write_1(data_write_1),
            .data_write_2(data_write_2),
            .data_write_3(data_write_3),
            .data_write_4(data_write_4),
            .WR_signal_1(WR_signal_1),
            .WR_signal_2(WR_signal_2),
            .WR_signal_3(WR_signal_3),
            .WR_signal_4(WR_signal_4),
            .data_read_1(data_read_1),
            .data_read_2(data_read_2),
            .data_read_3(data_read_3),
            .data_read_4(data_read_4));

    initial begin
        
        $display("Set initial signals and addresses");

        clk     = 0;
        WR_signal_1  = 0;
        WR_signal_2  = 0;
        WR_signal_3  = 0;
        WR_signal_4  = 0;
        
        address_1 = 10'b0000000001;
        address_2 = 12'b000000000010;
        address_3 = 12'b000000000011;
        address_4 = 10'b0000000100;
        
        toggle_clk;
        
        $display("Write data at different addresses in each RAM");

        WR_signal_1  = 1;
        WR_signal_2  = 1;
        WR_signal_3  = 1;
        WR_signal_4  = 1;
        data_write_1  = 64'h1110a716aa948111 ;
        data_write_2  = 64'h2220a716aa9485d9 ;
        data_write_3  = 64'h3330a716aa9485d9 ;
        data_write_4  = 64'h4440a716aa9485d9 ;

        toggle_clk;

        $display("Read the newly written data");

        WR_signal_1  = 0;
        WR_signal_2  = 0;
        WR_signal_3  = 0;
        WR_signal_4  = 0;

        toggle_clk;

        if (data_read_1 != data_write_1) begin
            $display("ERROR: Couldn't read from RAM_1[%0h]: %0h", address_1, data_read_1);
        end
        else begin
            $display("SUCCESS: Read from RAM_1[%0h]: %0h", address_1, data_read_1);
        end

        if (data_read_2 != data_write_2) begin
            $display("ERROR: Couldn't read from RAM_2[%0h]: %0h", address_2, data_read_2);
        end
        else begin
            $display("SUCCESS: Read from RAM_2[%0h]: %0h", address_2, data_read_2);
        end

        if (data_read_3 != data_write_3) begin
            $display("ERROR: Couldn't read from RAM_3[%0h]: %0h", address_3, data_read_3);
        end
        else begin
            $display("SUCCESS: Read from RAM_3[%0h]: %0h", address_3, data_read_3);
        end

        if (data_read_4 != data_write_4) begin
            $display("ERROR: Couldn't read from RAM_4[%0h]: %0h", address_4, data_read_4);
        end
        else begin
            $display("SUCCESS: Read from RAM_4[%0h]: %0h", address_4, data_read_4);
        end

        $display("Write new data in each RAM");

        WR_signal_1  = 1;
        WR_signal_2  = 1;
        WR_signal_3  = 1;
        WR_signal_4  = 1;
        data_write_1  = 64'h9990a716aa948111 ;
        data_write_2  = 64'h8880a716aa9485d9 ;
        data_write_3  = 64'h7770a716aa9485d9 ;
        data_write_4  = 64'h6660a716aa9485d9 ;

        toggle_clk;

        $display("Read and write simultaneously in multiple RAMs");

        WR_signal_1  = 1;
        WR_signal_2  = 0;
        WR_signal_3  = 1;
        WR_signal_4  = 0;
        data_write_1  = 64'h5550a716aa948111 ;
        data_write_3  = 64'h1230a716aa9485d9 ;

        toggle_clk;

        WR_signal_1  = 0;
        WR_signal_3  = 0;

        toggle_clk;

        if (data_read_1 != data_write_1) begin
            $display("ERROR: Couldn't write at RAM_1[%0h]: %0h in the same clock cycle", address_1, data_read_1);
        end
        else begin
            $display("SUCCESS: Wrote at RAM_1[%0h]: %0h in the same clock cycle", address_1, data_read_1);
        end

        if (data_read_2 != data_write_2) begin
            $display("ERROR: Couldn't read from RAM_2[%0h]: %0h in the same clock cycle", address_2, data_read_2);
        end
        else begin
            $display("SUCCESS: Read from RAM_2[%0h]: %0h in the same clock cycle", address_2, data_read_2);
        end

        if (data_read_3 != data_write_3) begin
            $display("ERROR: Couldn't write at RAM_3[%0h]: %0h in the same clock cycle", address_3, data_read_3);
        end
        else begin
            $display("SUCCESS: Wrote at RAM_3[%0h]: %0h in the same clock cycle", address_3, data_read_3);
        end

        if (data_read_4 != data_write_4) begin
            $display("ERROR: Couldn't read from RAM_4[%0h]: %0h in the same clock cycle", address_4, data_read_4);
        end
        else begin
            $display("SUCCESS: Read from RAM_4[%0h]: %0h in the same clock cycle", address_4, data_read_4);
        end

    end
    
    task toggle_clk;
        begin
            clk = ~clk; #50;
            clk = ~clk; #50;
        end
    endtask
    
endmodule
