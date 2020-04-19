module Add_Sub
#(      
    parameter DATA_WIDTH = 16
 )

(
    input signed[DATA_WIDTH-1 : 0] A,
    input signed[DATA_WIDTH-1 : 0] B,
    output[DATA_WIDTH-1 : 0 ] result,
	output overflow
    
);

assign result = A + B; 
assign overflow = (~result[DATA_WIDTH-1]&A[DATA_WIDTH-1]&B[DATA_WIDTH-1])|(result[DATA_WIDTH-1]&(~A[DATA_WIDTH-1])&(~B[DATA_WIDTH-1]));

 
   
   
endmodule;
