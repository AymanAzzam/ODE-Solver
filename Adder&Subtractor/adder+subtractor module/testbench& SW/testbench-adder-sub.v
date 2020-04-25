
module addition_tb;

    reg signed [15 : 0] A, B;
    wire signed[15 : 0] result;
	wire overflow;
	reg cin;
    localparam period = 20;  
	
	integer data_file ; // file handler
    integer scan_file ; // file handler
	reg  signed [15:0]captured_data;
	`define NULL 0


    Add_Sub UUT (.A(A), .B(B), .result(result), .overflow(overflow),.cin(cin));
	assign overflow = (~result[15]&A[15]&B[15])|(result[15]&(~A[15])&(~B[15]));
reg clk;

always 
begin
    clk = 1'b1; 
    #20;

    clk = 1'b0;
    #20;
end
//--------read from the file -----------//
initial begin
data_file = $fopen("test_out.txt", "r");
if (data_file == `NULL) begin
$display("data_file handle was NULL");
$finish;
end
end
//-------------------------------------//


always @(posedge clk)
begin
   
     scan_file = $fscanf(data_file, "%d\n", captured_data);
     
    A = 'b00110011_00110000;//51.1875
    B =   'b00000000_00000000;//0
	cin='b0;
    #period; // wait for period
	if(overflow)
		$display("Overflow Occured with inputs",A," ",B,"=",result);
   // if(result != 'b11001100110000)
      if(result != captured_data)
        $display("test failed #1 with inputs ",A," ",B,"!=",result," right answer = ",captured_data);
		
    scan_file = $fscanf(data_file, "%d\n", captured_data);
    A = 'b00000010_00100111;//2.15234375
    B = 'b0000010_00000000;
	cin='b0;
    #period; // wait for period 
	if(overflow)
		$display("Overflow Occured with inputs",A," ",B,"=",result);
    if(result != captured_data )
        $display("test failed #2 with inputs ",A," ",B,"!=",result," right answer = ",captured_data);

    scan_file = $fscanf(data_file, "%d\n", captured_data);
    A = 'b0000001_00000000;
    B = 'b0000010_00000000;
	cin='b0;
    #period; // wait for period 
	if(overflow)
		$display("Overflow Occured with inputs",A," ",B,"=",result);
    if(result != captured_data )
        $display("test failed #3 with inputs ",A," ",B,"!=",result," right answer = ",captured_data);

    scan_file = $fscanf(data_file, "%d\n", captured_data);
    A = 'b00001111_00110000;//15.1875
    B = 'b00000100_00000000;//4.0
	cin='b0;
    #period; // wait for period 
	if(overflow)
		$display("Overflow Occured with inputs",A," ",B,"=",result);
    if(result != captured_data )
        $display("test failed #4 with inputs ",A," ",B,"!=",result," right answer = ",captured_data);

    scan_file = $fscanf(data_file, "%d\n", captured_data);
    A = 'b00001111_00110000;//15.1875
    B = 'b00001111_00110000;//15.1875
	cin='b0;
    #period; // wait for period 
	if(overflow)
		$display("Overflow Occured with inputs",A," ",B,"=",result);
    if(result != captured_data )
        $display("test failed #5 with inputs ",A," ",B,"!=",result," right answer = ",captured_data);

    scan_file = $fscanf(data_file, "%d\n", captured_data);
    A = 'b00001111_00110000;//15.1875
    B = 'b00000100_01000000;//4.25
	cin='b0;
    #period; // wait for period 
	if(overflow)
		$display("Overflow Occured with inputs",A," ",B,"=",result);
    if(result != captured_data )
        $display("test failed #6 with inputs ",A," ",B,"!=",result," right answer = ",captured_data);
    scan_file = $fscanf(data_file, "%d\n", captured_data);
    A = -'b00000101_10000000;//-5.5
    B =   'b00000100_01000000;//4.25
	cin='b0;
    #period; // wait for period 
	if(overflow)
		$display("Overflow Occured with inputs",A," ",B,"=",result);
    if(result != captured_data )
        $display("test failed #7 with inputs ",A," ",B,"!=",result," right answer = ",captured_data);

    scan_file = $fscanf(data_file, "%d\n", captured_data);
    A = 'b00000101_10000000;//5.5
    B = -'b00000100_01000000;//-4.25
	cin='b0;
    #period; // wait for period 
	if(overflow)
		$display("Overflow Occured with inputs",A," ",B,"=",result);
    if(result != captured_data )
        $display("test failed #8 with inputs ",A," ",B,"!=",result," right answer = ",captured_data);

    scan_file = $fscanf(data_file, "%d\n", captured_data);
    A = -'b00000101_10000000;//-5.5
    B =   -'b00000101_10000000;//-5.5
	cin='b0;
    #period; // wait for period 
	if(overflow)
		$display("Overflow Occured with inputs",A," ",B,"=",result);
    if(result != captured_data )
        $display("test failed #9 with inputs ",A," ",B,"!=",result," right answer = ",captured_data);

    scan_file = $fscanf(data_file, "%d\n", captured_data);
    A = 'b11110100_00000000;//244.0
    B = 'b10000101_10000000;//133.5
	cin='b0;
    #period; // wait for period 
	if(overflow)
		$display("Overflow Occured with inputs",A," ",B,"=",result);
    if(result != captured_data )
        $display("test failed #10 with inputs ",A," ",B,"!=",result," right answer = ",captured_data);

    scan_file = $fscanf(data_file, "%d\n", captured_data);
    A = -'b00000101_10000000;//-5.5
    B =  'b00000101_10000000;//5.5
	cin='b0;
    #period; // wait for period
	if(overflow)
		$display("Overflow Occured with inputs",A," ",B,"=",result);
    if(result != captured_data )  
        $display("test failed #11 with inputs ",A," ",B,"!=",result," right answer = ",captured_data);

    scan_file = $fscanf(data_file, "%d\n", captured_data);
    A =  'b11111111_11111111;//255.99609375
    B =  'b00000001_00000000;//1
	cin='b0;
    #period; // wait for period
	if(overflow)
		$display("Overflow Occured with inputs",A," ",B,"=",result);
    if(result != captured_data )  
        $display("test failed #12 with inputs ",A," ",B,"!=",result," right answer = ",captured_data);

		
		
    scan_file = $fscanf(data_file, "%d\n", captured_data);
    A =  'b11110000_00000000;//240.375
    B =  'b10000001_00000000;//129.375
	cin='b0;
    #period; // wait for period
	if(overflow)
		$display("Overflow Occured with inputs",A," ",B,"=",result);
    if(result != captured_data )  
        $display("test failed #13 with inputs ",A," ",B,"!=",result," right answer = ",captured_data);

    scan_file = $fscanf(data_file, "%d\n", captured_data);
    A =  'b11110000_11100000;//240.875
    B =  'b10000001_11100000;//129.875
	cin='b0;
    #period; // wait for period
	if(overflow)
		$display("Overflow Occured with inputs",A," ",B,"=",result);
    if(result != captured_data )  
        $display("test failed #14 with inputs ",A," ",B,"!=",result," right answer = ",captured_data);

    scan_file = $fscanf(data_file, "%d\n", captured_data);
    A =  'b11111111_11111111;//255.99609375
    B =  'b10000001_00000000;//129
	cin='b0;
    #period; // wait for period
	if(overflow)
		$display("Overflow Occured with inputs",A," ",B,"=",result);
    if(result != captured_data )  
        $display("test failed #15 with inputs ",A," ",B,"!=",result," right answer = ",captured_data);
    $stop;   // end of simulation

  
end
endmodule
