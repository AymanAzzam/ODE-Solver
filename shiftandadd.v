
module shiftadd(p,a,b,clk,reset);

output signed [31:0]p; //Output variable p

input signed [15:0]a,b; //Input variable a,b

reg signed [15:0]x; //Register to store input a
reg signed [32:0]y; //Register to store input b
reg [4:0] i ;
wire [15:0] sum;
wire ov;
input clk,reset;

Add_Sub adder (.A(y[31:16]),.B(x),.result(sum),.overflow(ov));

always @(posedge clk)

begin
if(reset )
begin
if(a[15] ==1 )
x=-a;
else
x=a;

if(b[15]==1)
 y[15:0]=-b;
else 
y[15:0]=b;

y[32:16]=17'b00000000000000000; //Make upper nibble of register 'y' as '0000
i=5'b00000;
end

else if(i<16)
begin
case({y[1],y[0]}) //load and select

2'b00:begin
if(i < 15)
begin
y=y>>>2;
i=i+2;
end
else 
begin

y=y>>>1;
i=i+1;
end
end 
2'b01:begin
if(i <15)
begin
y[31:16]=sum;
y[32]=ov;
y=y>>>2;
i=i+2;
end
else 
begin
y[31:16]=sum;
y[32]=ov;
y=y>>>1;
i=i+1;
end
end

2'b10:begin

y=y>>>1;
i=i+1;
end
2'b11:begin
y[31:16]=sum;
y[32]=ov;
y=y>>>1;
i=i+1;
end
endcase

if((a[15]^b[15] ==1) && (i ==16))
y=-y;
else 
y=y;

end

end

assign p=y; //Assign product


endmodule