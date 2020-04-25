module Add_Sub
#(      
    parameter DATA_WIDTH = 16
 )

(
    input signed[DATA_WIDTH-1 : 0] A,
    input signed[DATA_WIDTH-1 : 0] B,
    output[DATA_WIDTH-1 : 0 ] result,
	output overflow,
	input cin
    
);
wire[DATA_WIDTH /4: 0 ] c;
assign c[0] = cin;

genvar      i;


  generate
    for (i = 0; i < DATA_WIDTH; i = i + 4) 
      begin
	    
        carry_look_ahead_4bit cla1 (.a(A[i+3:i]), .b(B[i+3:i]), .cin(c[((i)/4)]), .result(result[i+3:i]), .cout(c[((i)/4)+1]));
		

      end
  endgenerate
  
assign overflow = (~result[DATA_WIDTH-1]&A[DATA_WIDTH-1]&B[DATA_WIDTH-1])|(result[DATA_WIDTH-1]&(~A[DATA_WIDTH-1])&(~B[DATA_WIDTH-1]));

endmodule
/////////////////////////////////
//4-bit Carry Look Ahead Adder 
// ///////////////////////////////
 
module carry_look_ahead_4bit(a,b, cin, result,cout);

input [3:0] a;
input [3:0] b;
input cin;
output [3:0] result;
output cout;
 
wire [3:0] p,g,c;
 
assign p=a^b;//propagate
assign g=a&b; //generate
 
assign c[0]=cin;
assign c[1]= g[0]|(p[0]&cin);
assign c[2]= g[1] | (p[1]&g[0]) | p[1]&p[0]&cin;
assign c[3]= g[2] | (p[2]&g[1]) | p[2]&p[1]&g[0] | p[2]&p[1]&p[0]&cin;
assign cout= g[3] | (p[3]&g[2]) | p[3]&p[2]&g[1]| p[3]&p[2]&p[1]&g[0] | p[3]&p[2]&p[1]&p[0]&cin;
assign result=p^c;
 
endmodule
