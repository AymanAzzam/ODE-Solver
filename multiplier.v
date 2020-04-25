module multiplier (
multiplicand,
multiplier,
o_result,
overflow_flag,
clk,
reset
);


input signed[15:0] multiplicand;
input signed [15:0] multiplier;
output signed [15:0] o_result;
input clk;
input reset;
output overflow_flag;
wire signed[31:0]result;
reg signed [31:0] bin=32'b0000000000000000000000010000000 ;// smallest value used to round instead of truncate

//booth b(result,multiplicand,multiplier,clk,reset);
shiftadd s(result,multiplicand,multiplier,clk,reset);

assign overflow_flag = (result >32'b00000000011111111111111100000000) ?  1'b1 :
                        (result==32'b11111111111111111111111100000000)?1'b1:
                        1'b0;


assign o_result=(result+bin)>>>8; 

endmodule
