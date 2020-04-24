
module io
(
    input clk,rst,interrupt,load_process,
    inout [31 : 0] data,
    output reg [63 : 0] to_ram1,to_ram2,to_ram3,to_ram4,
    output reg [63 : 0] address1,address2,address3,address4,
    output reg [1 : 0] WR_RD1, WR_RD2, WR_RD3, WR_RD4,

    output reg [70 : 0] decoded
);

reg [5 : 0] n,m;
reg mode;
reg [1 : 0] fixed_point;
reg [3 : 0] count;
//reg [70 : 0] decoded;
reg[2 : 0] enable;
integer index_start,index_end,index_end_temp;
integer number,temp1,temp2;
integer i,j;

initial begin
	index_end = 70;
	index_end_temp = 70;
	enable[0] = 1;
	number = 0;
end

// Decode Data
always @(negedge clk) begin
	if(load_process && interrupt && enable[0]) begin
		for(i = 31; i > 0; i = i - 4) begin
			for(j = 0; j < data[i-1 -: 3]; j = j + 1) begin
				decoded[index_end] = data[i];
				index_end = index_end - 1;
			end
		end
		index_start = 70;
		enable[1] = 1;
		enable[0] = 0;
	end
end

//Write in Ram
always @(posedge clk) begin
	if(enable[1]) begin		
		for(i = 0;index_start > index_end; i = i + 1) begin	// no need for i here
			if(number == 0) begin
				n[5 : 0] = decoded[index_start -: 6];
				
				to_ram1[63 : 0] = { {58{n[5]}}, n[5 : 0] };
				address1 = 0;
				WR_RD1[1] = 1;
				
				to_ram2[63 : 0] = { {58{n[5]}}, n[5 : 0] };
				address2 = 0;
				WR_RD2[1] = 1;
				
				number = number + 1;
				index_start = index_start - 6;
			end else if(number ==1) begin
				m[5 : 0] = decoded[index_start -: 6];
				
				to_ram1[63 : 0] = { {58{m[5]}}, m[5 : 0] };
				address1 = 0;
				WR_RD1[1] = 1;	

				number = number + 1;
				index_start = index_start - 6;
			end else if(number ==2) begin
				mode = decoded[index_start];
			
				number = number + 1;
				index_start = index_start - 1;
			end else if(number ==3) begin	
				to_ram4[63 : 0] = { {48{decoded[index_start]}}, decoded[index_start -: 16] };
				address4 = 0;
				WR_RD4[1] = 1;	

				number = number + 1;
				index_start = index_start - 16;
			end else if(number ==4) begin
				to_ram4[63 : 0] = { {48{decoded[index_start]}}, decoded[index_start -: 16] };
				address4 = 0;
				WR_RD4[1] = 1;	

				number = number + 1;
				index_start = index_start - 16;
			end else if(number ==5) begin
				fixed_point[1 : 0] = decoded[index_start -: 2];

				number = number + 1;
				index_start = index_start - 2;
			end else if(number ==6) begin
				count[3 : 0] = decoded[index_start -: 4];

				number = number + 1;
				index_start = index_start - 4;
			end
		end
	end
end

endmodule