module carry_select_adder(a,b,result,overflow);

output signed[15:0]result;
input signed[15:0]a;
input signed[15:0]b;
output overflow; 

wire [7:0] c0,c1;
wire [7:0]c;
wire [15:0]sum0;
wire [15:0]sum1;
assign overflow = (~a[15]&b[15]&b[15])|(result[15]&(~a[15])&(~b[15]));

//---------------with input carry = 0 
FA_Block add1_0(a[1:0],b[1:0],1'b0,sum0[1:0],c0[0]);
FA_Block add2_0(a[3:2],b[3:2],1'b0,sum0[3:2],c0[1]);
FA_Block add3_0(a[5:4],b[5:4],1'b0,sum0[5:4],c0[2]);
FA_Block add4_0(a[7:6],b[7:6],1'b0,sum0[7:6],c0[3]);

FA_Block add5_0(a[9:8],b[9:8],1'b0,sum0[9:8],c0[4]);
FA_Block add6_0(a[11:10],b[11:10],1'b0,sum0[11:10],c0[5]);
FA_Block add7_0(a[13:12],b[13:12],1'b0,sum0[13:12],c0[6]);
FA_Block add8_0(a[15:14],b[15:14],1'b0,sum0[15:14],c0[7]);
//----------------with input carry = 1
FA_Block add1_1(a[1:0],b[1:0],1'b1,sum1[1:0],c1[0]);
FA_Block add2_1(a[3:2],b[3:2],1'b1,sum1[3:2],c1[1]);
FA_Block add3_1(a[5:4],b[5:4],1'b1,sum1[5:4],c1[2]);
FA_Block add4_1(a[7:6],b[7:6],1'b1,sum1[7:6],c1[3]);

FA_Block add5_1(a[9:8],b[9:8],1'b1,sum1[9:8],c1[4]);
FA_Block add6_1(a[11:10],b[11:10],1'b1,sum1[11:10],c1[5]);
FA_Block add7_1(a[13:12],b[13:12],1'b1,sum1[13:12],c1[6]);
FA_Block add8_1(a[15:14],b[15:14],1'b1,sum1[15:14],c1[7]);
//---------mux-----------------------
mux2X1 #(2) ms0(
.in0(sum0[1:0]),
.in1(sum1[1:0]),
.c0(c0[0]),
.c1(c1[0]),
.sel(1'b0),
.out(result[1:0]),
.c(c[0]));



mux2X1 #(2) ms1(
.in0(sum0[3:2]),
.in1(sum1[3:2]),
.c0(c0[1]),
.c1(c1[1]),
.sel(c[0]),
.out(result[3:2]),
.c(c[1]));



mux2X1 #(2) ms2(
.in0(sum0[5:4]),
.in1(sum1[5:4]),
.c0(c0[2]),
.c1(c1[2]),
.sel(c[1]),
.out(result[5:4]),
.c(c[2]));



mux2X1 #(2) ms3(
.in0(sum0[7:6]),
.in1(sum1[7:6]),
.c0(c0[3]),
.c1(c1[3]),
.sel(c[2]),
.out(result[7:6]),
.c(c[3]));



mux2X1 #(2) ms4(
.in0(sum0[9:8]),
.in1(sum1[9:8]),
.c0(c0[4]),
.c1(c1[4]),
.sel(c[3]),
.out(result[9:8]),
.c(c[4]));




mux2X1 #(2) ms5(
.in0(sum0[11:10]),
.in1(sum1[11:10]),
.c0(c0[5]),
.c1(c1[5]),
.sel(c[4]),
.out(result[11:10]),
.c(c[5]));



mux2X1 #(2) ms6(
.in0(sum0[13:12]),
.in1(sum1[13:12]),
.c0(c0[6]),
.c1(c1[6]),
.sel(c[5]),
.out(result[13:12]),
.c(c[6]));



mux2X1 #(2) ms7(
.in0(sum0[15:14]),
.in1(sum1[15:14]),
.c0(c0[7]),
.c1(c1[7]),
.sel(c[6]),
.out(result[15:14]),
.c(c[7]));



endmodule

module FA_Block(a,b,cin,sum,cout);
input [1:0] a,b;
input cin;
output [1:0] sum;
output cout;
wire c1,c2;
full_adder fa0(
.a(a[0]),
.b(b[0]),
.cin(cin),
.sum(sum[0]),
.cout(c1));

full_adder fa1(
.a(a[1]),
.b(b[1]),
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
//1bit Full Adder
/////////////////////
 
module full_adder(a,b,cin,sum, cout);
input a,b,cin;
output sum, cout;
 
wire x,y,z;
 
half_adder h1(.a(a), .b(b), .sum(x), .cout(y));
half_adder h2(.a(x), .b(cin), .sum(sum), .cout(z));
or or_1(cout,z,y);
endmodule
 
//////////////////////
// 1 bit Half Adder
//////////////////////
 
module half_adder( a,b, sum, cout );
input a,b;
output sum, cout;
xor xor_1 (sum,a,b);
and and_1 (cout,a,b);
endmodule
