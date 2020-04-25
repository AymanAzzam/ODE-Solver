module Add_Sub
#(      
    parameter DATA_DATA_WIDTH = 16
 )

(
    input signed[DATA_DATA_WIDTH-1 : 0] A,
    input signed[DATA_DATA_WIDTH-1 : 0] B,
    output[DATA_DATA_WIDTH-1 : 0 ] result,
	output overflow,
	input cin
    
);
     
  wire [DATA_DATA_WIDTH:0]     C;
  wire [DATA_DATA_WIDTH-1:0]   G, P, S;
  assign C[0] = cin;
  // full adder works with out needing to wait the carry
  genvar       i;
  generate
    for (ii=0; ii<DATA_WIDTH; ii=ii+1) 
      begin
        full_Adder f
            ( 
              .A(A[i]),
              .B(B[i]),
              .cin(C[i]),
              .sum(result[i]),
              .cout()
              );
      end
  endgenerate
 

  genvar         j;
  generate
    for (j=0; j<DATA_WIDTH; j=j+1) 
      begin
        assign G[j]   = A[j] & B[j];
        assign P[j]   = A[j] | B[j];
        assign C[j+1] = G[j] | (P[j] & C[j]);
      end
  endgenerate
   
  assign C[0] = 1'b0; // no carry input on first adder
 
  assign o_result = {C[DATA_WIDTH], S};   // Verilog Concatenation
 
endmodule 



/////////////////////
//1Bit Full Adder
/////////////////////
 
module full_Adder(A,B,cin,sum, cout);
input A,B,cin;
output sum, cout;
 
wire x,y,z;
 
half_Adder h1(.A(A), .B(B), .sum(x), .cout(y));
half_Adder h2(.A(x), .B(cin), .sum(sum), .cout(z));
or or_1(cout,z,y);
endmodule

//////////////////////
// 1 Bit HAlf Adder
//////////////////////
 
module half_Adder( A,B, sum, cout );
input A,B;
output sum, cout;
xor xor_1 (sum,A,B);
and And_1 (cout,A,B);
endmodule

