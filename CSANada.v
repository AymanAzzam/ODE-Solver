module Add_Sub
#(      
    parameter DATA_WIDTH = 16
 )

(
    input signed[DATA_WIDTH-1 : 0] A,
    input signed [DATA_WIDTH-1 : 0] B,
    output [DATA_WIDTH-1 : 0 ] result,
	output overflow
    
);

wire [DATA_WIDTH/2-1:0] c0,c1;
wire [DATA_WIDTH/2-1:0]c;
wire [DATA_WIDTH-1:0]result0;
wire [DATA_WIDTH-1:0]result1;
assign overflow = (~result[DATA_WIDTH-1]&A[DATA_WIDTH-1]&B[DATA_WIDTH-1])|(result[DATA_WIDTH-1]&(~A[DATA_WIDTH-1])&(~B[DATA_WIDTH-1]));

//---------------with input carry = 0 
  genvar i;

    generate 
	 FA_Block Add1_0(A[1:0],B[1:0],1'b0,result0[1:0],c0[0]);
	 FA_Block Add1_1(A[1:0],B[1:0],1'b1,result1[1:0],c1[0]);
	 mux2X1 #(2) ms0(
				.in0(result0[1:0]),
				.in1(result1[1:0]),
				.c0(c0[0]),
				.c1(c1[0]),
				.sel(1'b0),
				.out(result[1:0]),
				.c(c[0]));
								
        for ( i = 2; i <= DATA_WIDTH-1; i = i + 2 )
        begin
         
						 FA_Block Add1_0(A[i+1:i],B[i+1:i],1'b0,result0[i+1:i],c0[i-i/2]);
						 FA_Block Add1_1(A[i+1:i],B[i+1:i],1'b1,result1[i+1:i],c1[i-i/2]);
						 mux2X1 #(2) ms0(
								.in0(result0[i+1:i]),
								.in1(result1[i+1:i]),
								.c0(c0[i-i/2]),
								.c1(c1[i-i/2]),
								.sel(c[i-i/2-1]),
								.out(result[i+1:i]),
								.c(c[i-i/2]));
							

        end 
    endgenerate  
	


endmodule

module FA_Block(A,B,cin,sum,cout);
input [1:0] A,B;
input cin;
output [1:0] sum;
output cout;
wire c1,c2;
full_Adder fA0(
.A(A[0]),
.B(B[0]),
.cin(cin),
.sum(sum[0]),
.cout(c1));

full_Adder fA1(
.A(A[1]),
.B(B[1]),
.cin(c1),
.sum(sum[1]),
.cout(cout));
endmodule


//------------------------------
//-----------MUX 2x1------------
//------------------------------
module mux2X1( in0,in1,c0,c1,sel,out,c);
parameter width=16; 
input [width-1:0] in0,in1;
input c0,c1;
output c;
input sel;
output [width-1:0] out;
assign out=(sel)?in1:in0;
assign c=(sel)?c1:c0;
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
