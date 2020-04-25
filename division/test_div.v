
//`timescale 1 ns/10 ps  // time-unit = 1 ns, precision = 10 ps

module read_file_ex;
    
    reg signed [15:0] a, b;
    reg signed [15:0] div, dis;
    wire signed [15:0]res,remain;
    reg signed[15:0] quo,rem; 
    wire error;
    reg clk;
    reg[63:0] read_data [0:9];
    divider UUT (.Dividend(div), 
.Divisor(dis), 
.clk(clk), 
.Quotient(res), 
.Remain(remain),
.error(error));
    

    always 
       begin
         clk = 1'b1; 
    	 #20;

    	 clk = 1'b0;
    	 #20;
	end
    
   integer i;
     
   always @(negedge clk)
   begin 
        $readmemb("F:/3rd Year/2nd semester/VLSI/fucking pro/data.txt", read_data);
        for (i=0; i<10; i=i+1)
        begin
            
            {a, b, quo, rem} = read_data[i]; 
	    	div <= a;
		dis <= b;
		#30;
		if (!(rem == remain)&& (quo == res))
		begin 
			$display("error in #",i);
		end
            //#120;
        end
    end


endmodule