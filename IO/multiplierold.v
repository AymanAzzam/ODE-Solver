module multiplier (
multiplicand,
multiplier,
o_result
);


input signed[15:0] multiplicand;
input signed [15:0] multiplier;
output signed [15:0] o_result;
wire signed[31:0]result;
reg signed [31:0] bin=31'b0000000000000000000000010000000 ;// smallest value used to round instead of truncate

booth b(result,multiplicand,multiplier);
                      
assign o_result=(result +bin)>>>8; 

endmodule
