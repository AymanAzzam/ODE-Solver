module carry_look_ahead_adder_subtractor(a,b, result,overflow);
input signed[15:0] a;
input signed[15:0] b;
output signed[15:0] result;
output overflow;
wire c1,c2,c3;
 
assign overflow = (~a[15]&b[15]&b[15])|(result[15]&(~a[15])&(~b[15]));
 
carry_look_ahead_4bit cla1 (.a(a[3:0]), .b(b[3:0]), .cin(1'b0), .result(result[3:0]), .cout(c1));
carry_look_ahead_4bit cla2 (.a(a[7:4]), .b(b[7:4]), .cin(c1), .result(result[7:4]), .cout(c2));
carry_look_ahead_4bit cla3(.a(a[11:8]), .b(b[11:8]), .cin(c2), .result(result[11:8]), .cout(c3));
carry_look_ahead_4bit cla4(.a(a[15:12]), .b(b[15:12]), .cin(c3), .result(result[15:12]), .cout(cout));
 
endmodule
 
////////////////////////////////////////////////////////
//4-bit Carry Look Ahead Adder 
// //////////////////////////////////////////////////////
 
module carry_look_ahead_4bit(a,b, cin, result,cout);
input [3:0] a,b;
input cin;
output [3:0] result;
output cout;
 
wire [3:0] p,g,c;
 
assign p=a^b;//propagate
assign g=a&b; //generate
 
assign c[0]=cin;
assign c[1]= g[0]|(p[0]&c[0]);
assign c[2]= g[1] | (p[1]&g[0]) | p[1]&p[0]&c[0];
assign c[3]= g[2] | (p[2]&g[1]) | p[2]&p[1]&g[0] | p[2]&p[1]&p[0]&c[0];
assign cout= g[3] | (p[3]&g[2]) | p[3]&p[2]&g[1] | p[3]&p[2]&p[1]&p[0]&c[0];
assign result=p^c;
 
endmodule
