module divider(
	input signed [15:0]Dividend, 
	input signed [15:0]Divisor, 
	input clk,
	output signed [15:0]Quotient,
 	output signed [15:0]Remain, 
	output reg error);
        reg signed[31:0] Quot, Div, Rem;
	reg signed[15:0] tmp1,tmp2;
	reg signed[31:0] a,b;
	wire[31:0] res;
	wire err;

	Add_Sub  #(32)mod1(.A(a), 
	.B(~b), 
	.result(res), 
	.overflow(err),.cin(1'b1));

integer i;
always @(posedge clk ) begin
assign Quot = 16'b0000000000000000;
assign Rem = {16'b0,Dividend};
assign Div = {1'b0,Divisor,15'b0};
assign error = 0;

if ((Divisor == 16'b0) | (Divisor <'b00000001_00000000 ))begin
assign error = 1;
    tmp1 = {16'b0};
    tmp2 = {16'b0};
end
else if(Dividend == Divisor)begin
    tmp1 = {7'b0,1'b1,8'b0};
    tmp2 = {16'b0};
end

else if(Divisor == 'b00000001_00000000)begin

    tmp1 = {Dividend};
    tmp2 = {16'b0};
end

else begin
     for (i=0; i<16; i=i+1)begin

        if(Rem >= Div)begin
	
	   assign Quot = Quot <<< 1;
	   assign Quot = {Quot[15:1],1'b1};
	   a = Rem;
	   b = Div;
	   assign Rem = res;
	   assign error = err;
	   assign Div = Div >>> 1;
	end
          
	else begin
	   assign Quot = Quot <<< 1;
 	   assign Div = Div >>> 1;
	end
     end

assign tmp1 = {Quot[7:0], 8'b0};
assign tmp2 = Rem[15:0];

end

end
assign Quotient = tmp1;
assign Remain = tmp2;
assign a = 32'b0;
assign b = 32'b0;
assign Rem = 32'b0;
assign Quot = 32'b0;
assign Div = 32'b0;

endmodule
