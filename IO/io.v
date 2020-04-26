
module io
(	
    input clk,rst,interrupt,load_process,
    inout [31 : 0] data,
    output done_cpu,
    inout [63 : 0] ram1_data,ram2_data,ram3_data,ram4_data,
    output [11 : 0] ram1_address,ram2_address,ram3_address,ram4_address,
    output ram1_WR_RD, ram2_WR_RD, ram3_WR_RD, ram4_WR_RD,
    output en_step,en_euler,
    output [1 : 0] fixed_point_out,
    input done_result,
    output [31 : 0]number_test,temp1_test,temp2_test,
    output [31 : 0]n_test,m_test,mode_test,fixed_point_test,count_test,index_start_test,index_end_test,enable_test
);

reg[15 : 0] index_start,index_end,index_end_temp;
reg [70 : 0] decoded;

reg[15 : 0] number,cmp1,cmp2;
reg[15 : 0] temp1,temp2;

reg [5 : 0] n,m;
reg [3 : 0] count,count_temp;
reg [0 : 0] mode;
reg [1 : 0] fixed_point;

reg [63 : 0] to_ram1,to_ram2,to_ram3,to_ram4;
reg [11 : 0] address1,address2,address3,address4;
reg [0 : 0] WR_RD1, WR_RD2, WR_RD3, WR_RD4;

reg [0 : 0] enable_step,enable_euler;

reg [31 : 0] data_out;
reg [0 : 0] done;

reg [4 : 0] enable;
integer i,j;

wire overflow;
wire [15 : 0]dec_start,new_start,mul_result,mul_temp2,plus_address,start_address,new_address,new_number;
reg [15 : 0] dec_index_start, start_address_reg,mul_temp2_reg;

assign dec_start = dec_index_start;
assign start_address = start_address_reg;
assign mul_temp2 = mul_temp2_reg;

assign number_test = number;
assign temp1_test = temp1;
assign temp2_test = temp2;

assign n_test = n;
assign m_test = m;
assign mode_test = mode;
assign fixed_point_test = fixed_point;
assign count_test = count;
assign index_start_test = index_start;
assign index_end_test = index_end;
assign enable_test = enable;

assign data = (enable[3]) ? data_out: 32'hzzzzzzzz;

assign ram1_data = (enable[1]) ? to_ram1: 64'hzzzzzzzzzzzzzzzz;
assign ram2_data = (enable[1]) ? to_ram2: 64'hzzzzzzzzzzzzzzzz;
assign ram3_data = (enable[1]) ? to_ram3: 64'hzzzzzzzzzzzzzzzz;
assign ram4_data = (enable[1]) ? to_ram4: 64'hzzzzzzzzzzzzzzzz;

assign ram1_WR_RD = WR_RD1;
assign ram2_WR_RD = WR_RD2;
assign ram3_WR_RD = WR_RD3;
assign ram4_WR_RD = WR_RD4;

assign ram1_address = address1;
assign ram2_address = address2;
assign ram3_address = address3;
assign ram4_address = address4;

assign done_cpu = done;
assign en_euler = enable_euler;
assign en_step = enable_step;
assign fixed_point_out = fixed_point;

Add_Sub #(16) a(index_start[15 : 0],~dec_start[15 : 0],new_start[15 : 0],overflow,1'b1);

multiplier b(mul_temp2[15 : 0],temp2[15 : 0],mul_result[15 : 0]);
Add_Sub #(16) c(mul_result[15 : 0],temp1[15 : 0],plus_address[15 : 0],overflow,1'b0);
Add_Sub #(16) d(plus_address[15 : 0],start_address[15 : 0],new_address[15 : 0],overflow,1'b0);

Add_Sub #(16) e(number[15 : 0],16'b0000000000000001,new_number[15 : 0],overflow,1'b0);

// to calculate Ram addresses and indices for Data sent
always @(negedge clk) begin
	if(number == 0) begin			//n
		dec_index_start = 6;
		start_address_reg = 0;
	end else if(number == 1) begin		//m
		dec_index_start = 6;
		start_address_reg = 16'd901;
	end else if(number == 2)		//mode
		dec_index_start = 1;
	else if(number == 3) begin		//h
		dec_index_start = 16;
		start_address_reg = 0;
	end else if(number == 4) begin		//tolerance
		dec_index_start = 16;
		start_address_reg = 0;
	end else if(number == 5)		//fixed_point
		dec_index_start = 2;
	else if(number == 6)			//count
		dec_index_start = 4;
	else if(number == 7) begin		//matrix A
		dec_index_start = 16;
		mul_temp2_reg = {{26{1'b0}},n[5 : 0]};
		start_address_reg = 0;
	end else if(number == 8) begin		//matrix B
		dec_index_start = 16;
		mul_temp2_reg = {{26{1'b0}},m[5 : 0]};
		start_address_reg = 0;
	end else if(number == 9) begin		//matrix X0
		dec_index_start = 16;
		mul_temp2_reg = 0;
		start_address_reg = 0;
	end else if(number == 10) begin		//matrix T
		dec_index_start = 16;
		mul_temp2_reg = 0;
		start_address_reg = 0;
	end else if(number == 11) begin		//matrix U0
		dec_index_start = 16;
		mul_temp2_reg = 0;
		start_address_reg = 0;
	end else if(number == 12) begin		//matrix Us
		dec_index_start = 16;
		mul_temp2_reg = {{26{1'b0}},m[5 : 0]};
		start_address_reg = 16'd50;
	end else if(number == 13) begin		//matrix Results
		dec_index_start = 16;
		mul_temp2_reg = {{26{1'b0}},n[5 : 0]};
		start_address_reg = 16'd50;
	end
end


//Reset Signals 
always @(posedge rst) begin
	index_start = 70;
	index_end = 70;
	index_end_temp = 70;
	enable[4 : 0] = 5'b00101;
	number = 0;
	cmp1 = 0;
	cmp2 = 0;
	temp1 = 0;
	temp2 = 0;
	WR_RD1[0] = 1'b0;
	WR_RD2[0] = 1'b0;
	WR_RD3[0] = 1'b0;
	WR_RD4[0] = 1'b0;
	done[0] = 1'b0;
	enable_step[0] = 1'b0;
	enable_euler[0] = 1'b0;

	dec_index_start = 0;
	start_address_reg = 0;
	mul_temp2_reg = 0;
end

//Decode Data and Shift Decoded
always @(negedge clk) begin
	if(load_process && interrupt && enable[0]) begin	
		//************* Shift Old Decoded Data *************//
		index_end_temp = index_start - index_end;
 		if(index_end_temp > 0) begin
			for(i = 0; i< index_end_temp; i = i + 1)
				decoded[70 - i] = decoded[index_start - i];
		end
		index_end = 70 - index_end_temp;
		//************* Decode New Data *************//
		for(i = 31; i > 0; i = i - 4) begin
			if(data[i-1 -: 3] == 3'd1)begin
				decoded[index_end] = data[i];
				index_end = index_end - 1;
			end else if(data[i-1 -: 3] == 3'd2) begin
				decoded[index_end -: 2] = {2{data[i]}};
				index_end = index_end - 2;
			end else if(data[i-1 -: 3] == 3'd3) begin
				decoded[index_end -: 3] = {3{data[i]}};
				index_end = index_end - 3;
			end else if(data[i-1 -: 3] == 3'd4) begin
				decoded[index_end -: 4] = {4{data[i]}};
				index_end = index_end - 4;
			end else if(data[i-1 -: 3] == 3'd5) begin
				decoded[index_end -: 5] = {5{data[i]}};
				index_end = index_end - 5;
			end else if(data[i-1 -: 3] == 3'd6) begin
				decoded[index_end -: 6] = {6{data[i]}};
				index_end = index_end - 6;
			end else if(data[i-1 -: 3] == 3'd7) begin
				decoded[index_end -: 7] = {7{data[i]}};
				index_end = index_end - 7;
			end
		end
		index_start = 70;
		enable[1] = 1'b1;
		enable[0] = 1'b0;
	end
end

//To Send Done for only one Clock not Twice
always @(posedge clk) begin
	if(enable[1] == 1'b0 && number<13) begin
		done[0] = 1'b0;	
		WR_RD1[0] = 1'b0;
		WR_RD2[0] = 1'b0;
		WR_RD3[0] = 1'b0;
		WR_RD4[0] = 1'b0;	
	end
end

//Write in Ram
always @(posedge clk) begin
	if(enable[1] && number<13) begin
		done[0] = 1'b0;	
		WR_RD1[0] = 1'b0;
		WR_RD2[0] = 1'b0;
		WR_RD3[0] = 1'b0;
		WR_RD4[0] = 1'b0;	
		if(number == 0 && index_start - index_end >= 6) begin			//n
			n[5 : 0] = decoded[index_start -: 6];
			
			to_ram1[63 : 0] = { {58{1'b0}}, n[5 : 0] };
			address1[11 : 0] = new_address[11 : 0];
			WR_RD1[0] = 1'b1;
			
			to_ram2[63 : 0] = { {58{1'b0}}, n[5 : 0] };
			address2[11 : 0] = new_address[11 : 0];
			WR_RD2[0] = 1'b1;
			
			number[15 : 0] = new_number[15 : 0];
			index_start[15 : 0] = new_start[15 : 0];
		end else if(number == 1 && index_start - index_end >= 6) begin		//m
			m[5 : 0] = decoded[index_start -: 6];
			
			to_ram1[63 : 0] = { {58{1'b0}}, m[5 : 0] };
			address1[11 : 0] = new_address[11 : 0];
			WR_RD1[0] = 1'b1;
	
			number[15 : 0] = new_number[15 : 0];
			index_start[15 : 0] = new_start[15 : 0];
		end else if(number == 2 && index_start - index_end >= 1 ) begin		//mode
			mode[0] = decoded[index_start];
		
			number[15 : 0] = new_number[15 : 0];
			index_start[15 : 0] = new_start[15 : 0];
		end else if((number == 3 || number ==4) && index_start - index_end >= 16) begin	 //H and Tolerance
			to_ram4[63 : 0] = { {48{1'b0}}, decoded[index_start -: 16] };
			address4[11 : 0] = new_address[11 : 0];
			WR_RD4[0] = 1'b1;	

			number[15 : 0] = new_number[15 : 0];
			index_start[15 : 0] = new_start[15 : 0];
		end else if(number == 5 && index_start - index_end >= 2) begin		//Fixed_point
			fixed_point[1 : 0] = decoded[index_start -: 2];

			number[15 : 0] = new_number[15 : 0];
			index_start[15 : 0] = new_start[15 : 0];
		end else if(number ==6 && index_start - index_end >= 4) begin	//Count
			count[3 : 0] = decoded[index_start -: 4];
			count_temp[3 : 0] = count[3 : 0]; 

			number[15 : 0] = new_number[15 : 0];
			index_start[15 : 0] = new_start[15 : 0];
		end else if (number>=7 && index_start - index_end >= 16) begin
			if(number == 7) begin						//Matrix A
				to_ram2[63 : 0] = { {48{decoded[index_start]}}, decoded[index_start -: 16] };
				address2[11 : 0] = new_address[11 : 0];
				WR_RD2[0] = 1'b1;	
			end else if(number == 8) begin					//Matrix B
				to_ram3[63 : 0] = { {48{decoded[index_start]}}, decoded[index_start -: 16] };
				address3[11 : 0] = new_address[11 : 0];
				WR_RD3[0] = 1'b1;
			end else if(number == 9) begin					//Matrix X0
				to_ram4[63 : 0] = { {48{decoded[index_start]}}, decoded[index_start -: 16] };
				address4[11 : 0] = new_address[11 : 0];
				WR_RD4[0] = 1'b1;
			end else if(number == 10) begin					//Matrix T
				to_ram1[63 : 0] = { {48{1'b0}}, decoded[index_start -: 16] };
				address1[11 : 0] = new_address[11 : 0];
				WR_RD1[0] = 1'b1;

				to_ram4[63 : 0] = { {48{1'b0}}, decoded[index_start -: 16] };
				address4[11 : 0] = new_address[11 : 0];
				WR_RD4[0] = 1'b1;
			end else begin							//Matrix U0 and Matrix Us
				to_ram1[63 : 0] = { {48{decoded[index_start]}}, decoded[index_start -: 16] };
				address1[11 : 0] = new_address[11 : 0];
				WR_RD1[0] = 1'b1;
			end
			index_start = new_start; 
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
			if(temp1 == cmp1) begin				//done row in matrix
				temp1 = 0;
				temp2 = temp2 + 1;
				if(temp2 >= cmp2) begin				//done this matrix
					temp2 = 0;
					number[15 : 0] = new_number[15 : 0];
				end
			end
		end else begin
			done[0] = 1'b1;
			enable[0] = 1'b1;
			enable[1] = 1'b0;
		end
		if(number == 13)
			enable[1] = 1'b0;	
	end
end

//Coordinator
always @(posedge clk) begin
	if(!load_process && interrupt && count_temp > 0 && enable[2]) begin
		enable_euler[0] = 1'b1;
		if(mode[0])
			enable_step[0] = 1'b1;
		enable[2] = 1'b0;
	end
	if(done_result && count_temp > 0)
		count_temp = count_temp - 1;
	if(count_temp == 0) begin
		enable_step[0] = 1'b0;
		enable_euler[0] = 1'b0;
		enable[3] = 1'b1;
		temp1 = 0;
		temp2 = 0;
		mode[0] = 0;
	end
end

//Send Results to IO
always @(posedge clk) begin
	if(enable[3] && count > 0)	begin
		if(mode[0] == 1'b0) begin
			data_out[31 : 0] = {{22{1'b0}},n[5 : 0],count[3 : 0]};
			done[0] = 1'b1;
			mode[0] = 1'b1;	
		end else begin
			data_out[31 : 0] = ram4_data[31 : 0];
			done[0] = 1'b1;
		end
		enable[4] = 1'b1;
		enable[3] = 1'b0;
	end
end


//Read Data from Ram 
always @(posedge clk) begin
	if(enable[4])
		done[0] = 1'b0;
	if(enable[4] && count > 0)	begin
		address4[11 : 0] = new_address[11 : 0];
		WR_RD4[0] = 1'b0;

		temp1 = temp1 + 1;
		if(temp2[3 : 0] == count[3 : 0] && temp1[5 : 0] == n[5 : 0])
			enable[3] = 1'b0;
		else if(temp1[5 : 0] == n[5 : 0]) begin
			temp1 = 0;
			temp2 = temp2 + 1;
		end
		enable[3] = 1'b1;
		enable[4] = 1'b0;
	end
end


endmodule
