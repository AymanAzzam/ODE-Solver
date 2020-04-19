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


wire[DATA_WIDTH-1  : 0 ] S;
wire[DATA_WIDTH  : 0 ] C;

assign C[0] = 1'b0 ;

    genvar i;
    generate 
        for ( i = 0; i <= DATA_WIDTH; i = i + 1 )
        begin
           CLA_bit U1 (
                         .A( A[i] ),
                         .B( B[i] ),
                         .C( C[i] ),
                         .S( S[i]),
                         .Cout( C[i+1] )
                         
                         ); 
        end 
    endgenerate  
    
assign result = S;
assign overflow = (~result[DATA_WIDTH-1]&A[DATA_WIDTH-1]&B[DATA_WIDTH-1])|(result[DATA_WIDTH-1]&(~A[DATA_WIDTH-1])&(~B[DATA_WIDTH-1]));

endmodule


module CLA_bit 
(   
    input  A,
    input  B,
    input  C,
    output S,
    output Cout
); 
 wire P , G ;
 assign P = A ^ B;
 assign G = A & B;
 assign S = P ^ C;
 assign Cout = G | (P & C );

    
endmodule 