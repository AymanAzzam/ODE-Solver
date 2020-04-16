module borrow_look_ahead_16bit_subtractor(a,b,result,overflow);
input [15:0] a,b;
output [15:0] result;
output overflow;
wire c1,c2,c3,c4;
assign overflow = (~a[15]&b[15]&b[15])|(result[15]&(~a[15])&(~b[15]));

carry_look_ahead_4bit cla1 (.a(a[3:0]), .b(b[3:0]), .Bin(1'b0), .result(result[3:0]), .Bout(c1));
carry_look_ahead_4bit cla2 (.a(a[7:4]), .b(b[7:4]), .Bin(c1), .result(result[7:4]), .Bout(c2));
carry_look_ahead_4bit cla3(.a(a[11:8]), .b(b[11:8]), .Bin(c2), .result(result[11:8]), .Bout(c3));
carry_look_ahead_4bit cla4(.a(a[15:12]), .b(b[15:12]), .Bin(c3), .result(result[15:12]), .Bout(c4));
 
endmodule
 
////////////////////////////////////////////////////////
//4-bit Carry Look Ahead Adder 
////////////////////////////////////////////////////////
 
module carry_look_ahead_4bit(a,b, Bin, result,Bout);
input [3:0] a,b;
input Bin;
output [3:0] result;
output Bout;
 
wire [3:0] p,g,c;
 
assign p=~a^b;//propagate
assign g=~a&b; //generate
 
assign c[0]=Bin;
assign c[1]= g[0]|(p[0]&c[0]);
assign c[2]= g[1] | (p[1]&g[0]) | p[1]&p[0]&c[0];
assign c[3]= g[2] | (p[2]&g[1]) | p[2]&p[1]&g[0] | p[2]&p[1]&p[0]&c[0];
assign Bout= g[3] | (p[3]&g[2]) | p[3]&p[2]&g[1] | p[3]&p[2]&p[1]&p[0]&c[0];
assign result=(a^b^c);
 
endmodule
