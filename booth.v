
module booth(prod, mc, mp,clk,reset);
output signed[31:0] prod;
input clk;
input signed[15:0] mc, mp;
reg signed[15:0] A, Q, M;
reg Q_1;
reg [4:0] i;
input reset;
wire [15:0] sum,diff;
wire o;

Add_Sub adder(.A(A),.B(M),.result(sum),.overflow(o),.cin('b0));
Add_Sub sub(.A(A),.B(~M),.result(diff),.overflow(o),.cin('b1));
always @(posedge clk)
begin

if(reset)
begin
 A = 16'b0000000000000000;
 M = mc;
 Q = mp;
 Q_1 = 1'b0;
 i=5'b10000;
end
else if(i>0)
begin
 case ({Q[0], Q_1})
2'b0_1 :A=sum;
2'b1_0 :A=diff;
default: A=A;
 endcase


Q_1=Q[0];
Q=Q>>1;
Q[15]=A[0];

A= A>>>1;

i=i- 1'b1;


end 

end

assign prod = {A, Q};
endmodule

