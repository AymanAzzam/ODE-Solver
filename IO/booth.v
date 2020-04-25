
module booth(prod, mc, mp);
output signed[31:0] prod;

input signed[15:0] mc, mp;
reg signed[15:0] A, Q, M;
reg Q_1;
integer i;

//alu adder (sum, A, M, 1'b1);
//alu subtracter (difference, A, ~M, 1'b1);
always @(mc,mp)
begin
 A = 15'b000000000000000;
 M = mc;
 Q = mp;
 Q_1 = 1'b0;
 for(i=0;i<16;i=i+1)
begin
 case ({Q[0], Q_1})
// 2'b0_1 :  {A, Q, Q_1}={sum,Q,Q_1};
// 2'b1_0 :{A, Q, Q_1}={difference,Q,Q_1};
// default: {A, Q, Q_1} = {A, Q, Q_1};
2'b0_1 :A=A+M;
2'b1_0 :A=A-M;
default: A=A;
 endcase


Q_1=Q[0];
Q=Q>>1;
Q[15]=A[0];

A= A>>>1;

//$display("%b",A);
//$display("%b",Q);
//$display("%b",Q_1);

end 
end

assign prod = {A, Q};
endmodule
/*
module alu(out, a, b, cin);
output [15:0] out;
input signed[15:0] a;
input signed[15:0] b;
input cin;
assign out = a + b + cin;
endmodule*/
