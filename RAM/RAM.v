module RAM (clk,
            address_1,
            address_2,
            address_3,
            address_4,
            data_1,
            data_2,
            data_3,
            data_4,
            WR_signal_1,
            WR_signal_2,
            WR_signal_3,
            WR_signal_4);
    
    parameter DATA_WIDTH       = 64;
    parameter ADDRESS_WIDTH_1  = 10;
    parameter ADDRESS_WIDTH_2  = 12;
    parameter ADDRESS_WIDTH_3  = 12;
    parameter ADDRESS_WIDTH_4  = 10;
    parameter ADDRESS_HEIGHT_1 = 918; // = N: 1 element + M: 1 element + T: max 16 elements + U0: max 50 elements + U's: max 50 elements * 16 (time steps count) + U_interpolation: max 50 elements
    parameter ADDRESS_HEIGHT_2 = 2500; // = A: max 50 elements * 50 elements = 50 * 50
    parameter ADDRESS_HEIGHT_3 = 2500; // = B: max 50 elements * 50 elements = 50 * 50
    parameter ADDRESS_HEIGHT_4 = 1018; //  N: 1 element + T: max 16 elements + H: 1 element + Error Precision: 1 element  + X0: max 50 elements
    // + X_stable: max 50 elements + X_n+1(h): max 50 elements + X_n+1(h/2): max 50 elements + X's: max 50 elements * 16
    
    input                              clk;
    input  [ADDRESS_WIDTH_1-1:0] address_1;
    input  [ADDRESS_WIDTH_2-1:0] address_2;
    input  [ADDRESS_WIDTH_3-1:0] address_3;
    input  [ADDRESS_WIDTH_4-1:0] address_4;
    inout  [DATA_WIDTH-1:0]   data_1;
    inout  [DATA_WIDTH-1:0]   data_2;
    inout  [DATA_WIDTH-1:0]   data_3;
    inout  [DATA_WIDTH-1:0]   data_4;
    reg [DATA_WIDTH-1:0]    data_read_1;
    reg [DATA_WIDTH-1:0]    data_read_2;
    reg [DATA_WIDTH-1:0]    data_read_3;
    reg [DATA_WIDTH-1:0]    data_read_4;
    input                      WR_signal_1;
    input                      WR_signal_2;
    input                      WR_signal_3;
    input                      WR_signal_4;
    
    // RAM as multi-dimensional arrays
    reg [DATA_WIDTH-1:0] RAM_1 [ADDRESS_HEIGHT_1-1:0];
    reg [DATA_WIDTH-1:0] RAM_2 [ADDRESS_HEIGHT_2-1:0];
    reg [DATA_WIDTH-1:0] RAM_3 [ADDRESS_HEIGHT_3-1:0];
    reg [DATA_WIDTH-1:0] RAM_4 [ADDRESS_HEIGHT_4-1:0];

    assign data_1 = WR_signal_1 ? 64'bz : data_read_1;
    assign data_2 = WR_signal_2 ? 64'bz : data_read_2;
    assign data_3 = WR_signal_3 ? 64'bz : data_read_3;
    assign data_4 = WR_signal_4 ? 64'bz : data_read_4;
    
    always @(posedge clk) begin
        
        if (WR_signal_1) begin
            RAM_1[address_1] <= data_1;
        end
        else begin
            data_read_1 <= RAM_1[address_1];
        end
        
        if (WR_signal_2) begin
            RAM_2[address_2] <= data_2;
        end
        else begin
            data_read_2 <= RAM_2[address_2];
        end
        
        if (WR_signal_3) begin
            RAM_3[address_3] <= data_3;
        end
        else begin
            data_read_3 <= RAM_3[address_3];
        end
        
        if (WR_signal_4) begin
            RAM_4[address_4] <= data_4;
        end
        else begin
            data_read_4 <= RAM_4[address_4];
        end
        
    end
    
endmodule
