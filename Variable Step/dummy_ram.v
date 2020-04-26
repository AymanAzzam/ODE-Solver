
module dummy_ram (reset,Address, Data, clk, wr_en);

parameter AddressSize = 10;
parameter WordSize = 64;

input [AddressSize-1:0] Address;
inout [WordSize-1:0] Data;
input wr_en, clk,reset;

reg [WordSize-1:0] Mem [0:(1<<AddressSize)-1];
reg [WordSize-1:0] Data_reg;

assign Data = (wr_en == 0) ? Data_reg : {64{1'bz}};


always @(posedge clk) begin
  if(reset) begin
    Data_reg = 64'bz;
  end else if (wr_en) begin
    Mem[Address] = Data;
  end else begin
    Data_reg = Mem[Address];
  end
end

endmodule