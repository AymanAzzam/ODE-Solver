
module io
(
    input clk,rst,interrupt,load_process,
    inout [31 : 0] data,
    input reg [0 : 0] done_result,
    output reg [63 : 0] to_ram1,to_ram2,to_ram3,to_ram4,
    output reg [63 : 0] address1,address2,address3,address4,
    output reg [1 : 0] WR_RD1, WR_RD2, WR_RD3, WR_RD4,
    output reg [0 : 0] done,enable_step,enable_euler,
    output reg [1 : 0] fixed
);

reg [5 : 0] n,m;
reg [0 : 0] mode;
reg [1 : 0] fixed_point;
reg [3 : 0] count;
reg [70 : 0] decoded;
reg [3 : 0] enable;
integer index_start,index_end,index_end_temp;
integer number,temp1,temp2,cmp1,cmp2;
integer i,j;

initial begin
	index_start = 70;
	index_end = 70;
	index_end_temp = 70;
	enable[0] = 1'b1;
	enable[2] = 1'b1;
	temp1 = 0;
	temp2 = 0;
	number = 0;
	WR_RD1[1 : 0] = 2'b00;
	WR_RD2[1 : 0] = 2'b00;
	WR_RD3[1 : 0] = 2'b00;
	WR_RD4[1 : 0] = 2'b00;
	done[0] = 1'b0;
	enable_step[0] = 1'b0;
	enable_euler[0] = 1'b0;
end

//Reset Signals 
always @(posedge clk) begin
	if(rst) begin
		index_start = 70;
		index_end = 70;
		index_end_temp = 70;
		enable[0] = 1'b1;
		enable[2] = 1'b1;
		temp1 = 0;
		temp2 = 0;
		number = 0;
	end
end

//Decode Data and Shift Decoded
always @(negedge clk) begin
	if(load_process && interrupt && enable[0]) begin
		//************* Shift Old Decoded Data *************//
		index_end_temp = index_start - index_end;
 		if(index_end_temp > 0) begin
			for(i = 0; i< index_end_temp; i = i + 1)
				decoded[70 - i] = decoded[index_start - i];
			index_end = 70 - index_end_temp;
		end
		//************* Decode New Data *************//
		for(i = 31; i > 0; i = i - 4) begin
			for(j = 0; j < data[i-1 -: 3]; j = j + 1) begin
				decoded[index_end] = data[i];
				index_end = index_end - 1;
			end
		end
		index_start = 70;
		enable[1] = 1'b1;
		enable[0] = 1'b0;
	end
end

//Write in Ram
always @(posedge clk) begin
	if(enable[1]) begin		
		if(number == 0 && index_end - index_start >= 6) begin			//n
			n[5 : 0] = decoded[index_start -: 6];
			
			to_ram1[63 : 0] = { {58{1'b0}}, n[5 : 0] };
			address1 = 0;
			WR_RD1[1] = 1;
			
			to_ram2[63 : 0] = { {58{1'b0}}, n[5 : 0] };
			address2 = 0;
			WR_RD2[1] = 1;
			
			number = number + 1;
			index_start = index_start - 6;
		end else if(number == 1 && index_end - index_start >= 6) begin		//m
			m[5 : 0] = decoded[index_start -: 6];
			
			to_ram1[63 : 0] = { {58{1'b0}}, m[5 : 0] };
			address1 = 0;
			WR_RD1[1] = 1;
	
			number = number + 1;
			index_start = index_start - 6;
		end else if(number == 2 && index_end - index_start >= 1 ) begin		//mode
			mode[0] = decoded[index_start];
		
			number = number + 1;
			index_start = index_start - 1;
		end else if(number == 3 && index_end - index_start >= 16) begin		//H	
			to_ram4[63 : 0] = { {48{1'b0}}, decoded[index_start -: 16] };
			address4 = 0;
			WR_RD4[1] = 1;
	
			number = number + 1;
			index_start = index_start - 16;
		end else if(number == 4 && index_end - index_start >= 16) begin		//Tolerance
			to_ram4[63 : 0] = { {48{1'b0}}, decoded[index_start -: 16] };
			address4 = 0;
			WR_RD4[1] = 1;	

			number = number + 1;
			index_start = index_start - 16;
		end else if(number == 5 && index_end - index_start >= 2) begin		//Fixed_point
			fixed_point[1 : 0] = decoded[index_start -: 2];

			number = number + 1;
			index_start = index_start - 2;
		end else if(number ==6 && index_end - index_start >= 4) begin	//Count
			count[3 : 0] = decoded[index_start -: 4];

			number = number + 1;
			index_start = index_start - 4;
		end else if (number < 13 && index_end - index_start >= 16) begin
			if(number == 7) begin						//Matrix A
				to_ram2[63 : 0] = { {48{decoded[index_start]}}, decoded[index_start -: 16] };
				address2 = 0 + 4*(n*temp2 + temp1);
				WR_RD2[1] = 1;	
			end else if(number == 8) begin					//Matrix B
				to_ram3[63 : 0] = { {48{decoded[index_start]}}, decoded[index_start -: 16] };
				address3 = 0 + 4*(m*temp2 + temp1);
				WR_RD3[1] = 1;
			end else if(number == 9) begin					//Matrix X0
				to_ram4[63 : 0] = { {48{decoded[index_start]}}, decoded[index_start -: 16] };
				address4 = 0 + 4*temp1;
				WR_RD4[1] = 1;
			end else if(number == 10) begin					//Matrix T
				to_ram1[63 : 0] = { {48{1'b0}}, decoded[index_start -: 16] };
				address1 = 0 + 4*temp1;
				WR_RD1[1] = 1;
			end else if(number == 11) begin					//Matrix U0
				to_ram1[63 : 0] = { {48{decoded[index_start]}}, decoded[index_start -: 16] };
				address1 = 0 + 4*temp1;
				WR_RD1[1] = 1;
			end else if(number == 12) begin					//Matrix Us
				to_ram1[63 : 0] = { {48{decoded[index_start]}}, decoded[index_start -: 16] };
				address1 = 0 + 4*(m*temp2 + temp1);
				WR_RD1[1] = 1;
			end
			index_start = index_start - 16; 
			if(number >= 7 && number <=12) begin
				temp1 = temp1 + 1;
				if(number == 7) begin				//Matrix A
					cmp1[5 : 0] = n[5 : 0];
					cmp2[5 : 0] = n[5 : 0];
				end else if(number == 8) begin			//Matrix B
					cmp1[5 : 0] = m[5 : 0];
					cmp2[5 : 0] = n[5 : 0];
				end else if(number == 9) begin			//Matrix X0
					cmp1[5 : 0] = n[5 : 0];
					cmp2 = temp2;	
				end else if(number == 10) begin			// Matrix T
					cmp1[3 : 0] = count[3 : 0];
					cmp2 = temp2;
				end else if(number == 11) begin			//Matrix U0
					cmp1[5 : 0] = m[5 : 0];
					cmp2 = temp2;
				end else begin					//Matrix Us
					cmp1[5 : 0] = m[5 : 0];
					cmp2[3 : 0] = count[3 : 0];
				end
				if(temp1 == cmp1 && temp2 == cmp2) begin	//done this matrix
					temp1 = 0;
					temp2 = 0;
					number = number + 1;
				end else if(temp1 == cmp1) begin		//done row in matrix
					temp1 = 0;
					temp2 = temp2 + 1;
				end
			end
		end else
			done[0] = 1'b1;
		if(number == 13)
			enable[1] = 1'b0;	
	end
end

//Coordinator
always @(posedge clk) begin
	if(!load_process && interrupt && count > 0 && enable[2]) begin
		enable_euler[0] = 1'b1;
		if(mode[0])
			enable_step[0] = 1'b1;
		fixed[1 : 0] = fixed_point[1 : 0];
		enable[2] = 1'b0;
	end
	if(done_result[0] && count > 0)
		count = count - 1;
	if(count == 0)
		enable[3] = 1;
end

//Read Data from Ram and write in IO 

//Return Signals to zero
always @(negedge clk) begin
	WR_RD1[1 : 0] = 2'b00;
	WR_RD2[1 : 0] = 2'b00;
	WR_RD3[1 : 0] = 2'b00;
	WR_RD4[1 : 0] = 2'b00;
	done[0] = 1'b0;
end


endmodule
