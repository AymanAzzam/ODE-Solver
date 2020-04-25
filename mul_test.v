

module mul_test;

    reg signed [15 : 0] multiplicand, multiplier;
    wire signed [15 : 0] o_result;
    wire overflow_flag;
    wire done;
    reg clk;
reg reset;
    localparam period = 400;  

    multiplier UUT (.multiplicand(multiplicand), .multiplier(multiplier), .o_result(o_result),. overflow_flag(overflow_flag),.clk(clk),.reset(reset));
    

always #10 clk = !clk;

always
begin
reset=1;
#70;
reset=0;
#330;
end

initial
begin
   clk=1;
 //reset=1;

multiplicand = 'b00000001_00000000;
    multiplier =   'b00000100_00000000;
    #period; // wait for period
   $display("A=%b",o_result);
   if(o_result != 'b00000100_00000000 || overflow_flag !=1'b0)
       $display("test failed 1");

   multiplicand = 'b00000010_00100111;
    multiplier = 'b0000010_00000000;
    #period; // wait for period 
    $display("A=%b",o_result);
    if(o_result != 'b00000100_01001110 || overflow_flag !=1'b0)
        $display("test failed 2");

    multiplicand = 'b0000001_00000000;//1.0
    multiplier = 'b0000010_00000000;//2.0
    #period; // wait for period 
    if(o_result != 'b00000010_00000000 || overflow_flag !=1'b0)
        $display("test failed 3");

    multiplicand = 'b00001111_00110000;//
    multiplier = 'b00000100_00000000;
    #period; // wait for period 
    if(o_result != 'b00111100_11000000 || overflow_flag !=1'b0)
        $display("test failed 4");

    multiplicand = 'b00001111_00110000;//
    multiplier = 'b00001111_00110000;//
    #period; // wait for period 
    if(o_result != 'b1110011010101001 )//|| overflow_flag !=1'b1)
        $display("test failed 5");

    multiplicand = 'b00001111_00110000;//
    multiplier = 'b00000100_01000000;//
    #period; // wait for period 
    if(o_result != 'b001000000_10001100  )//|| overflow_flag !=1'b1)
        $display("test failed 6");

    multiplicand = -'b00000101_10000000;//
    multiplier =   'b00000100_01000000;//
    #period; // wait for period 
    if(o_result != -5984 )//|| overflow_flag !=1'b0)
        begin
        $display("test failed 7");
        $display("%b",o_result);
end

    multiplicand = -'b00000101_10000000;//
    multiplier =   -'b00000101_10000000;//
    #period; // wait for period 
    if(o_result != 'b00011110_01000000 )//|| overflow_flag !=1'b0)
        $display("test failed 8");

    multiplicand = 'b00110011_00110000;//
    multiplier = 'b00001100_00100100;//
    #period; // wait for period
    if(o_result != 'b0110110101110011 )//|| overflow_flag !=1'b0)  
        $display("test failed 9");

    multiplicand = -'b00000101_10000000;//
    multiplier =  'b00000101_10000000;//
    #period; // wait for period
    if(o_result != -7744)// || overflow_flag !=1'b0)  
begin
        $display("test failed 10");
      $display("%b",o_result);
end

    multiplicand = 'b11110100_00000000;//
    multiplier =   'b10000101_10000000;//
    #period; // wait for period 
                   //00111110_00000000 the python output.
    if(o_result != 'b10111110_00000000 )//|| overflow_flag !=1'b1)  
        $display("test failed 11");        

    multiplicand =  'b11111111_11111111;
    multiplier =    'b00000001_00000000;
    #period; // wait for period
    if(o_result != 'b11111111_11111111 )//|| overflow_flag !=1'b0)  
begin
        $display("test failed 12");
      $display("%b",o_result);
end

    multiplicand =  'b11110000_00000000;//
    multiplier =  'b10000001_00000000;//
    #period; // wait for period
    if(o_result != 'b1111000000000000 )//|| overflow_flag !=1'b0)  
        $display("test failed 13");

    multiplicand =  'b11110000_01100000;//
    multiplier =  'b10000001_01100000;//
    #period; // wait for period
                   //01111010_10000100 the modelsim output.
    if(o_result != 'b10111010_10000100 )//|| overflow_flag !=1'b1)  //------------>this is python output, overflow test expected output varies in last two bits.0
        $display("test failed 14");

    multiplicand =  'b10000001_00000000;//
    multiplier =    'b00000001_00000000;//
    #period; // wait for period
    if(o_result != 'b1000000100000000)// || overflow_flag !=1'b0)  
begin
        $display("test failed 15");
      $display("%b",o_result);
end



$stop;
end
endmodule