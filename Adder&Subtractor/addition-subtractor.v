module addition #(parameter N=16 )
  (input signed [N-1 : 0] A,
   input signed  [N-1 : 0] B,
   output signed [N-1 : 0] result,
   output overflow
   );

assign result = A + B; 
assign overflow= (~result[15]&A[15]&B[15])|(result[15]&(~A[15])&(~B[15]));

 
   
   
endmodule;
