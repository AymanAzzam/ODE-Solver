module interpolator
(Rst,Clk, Fixed_Floating, Enable,Done_interpolation, 
Data1,ADD1, read_write_en1);

input  Rst,Clk, Fixed_Floating, Enable;
inout [63:0] Data1;
output  [10:0] ADD1;
output Done_interpolation, read_write_en1 ;

// utility registers
reg [63:0] regData1;
reg [10:0] add1Reg;
reg [10:0] indexT= 10'd20; // first address of T
reg [10:0] Tinterpolate= 10'd20; // address of Tcurrent in RAM
reg [10:0] start_indexT= 10'd20;  // constant reg
reg [10:0] start_indexU= 10'd20;  // constant reg
reg [10:0] Usmaller= 10'd20;  // U equivalent for Tsmaller
reg [10:0] index_interpolation= 10'd20;
reg [10:0] smallerTindex= 10'd20;

reg[63:0] Uelement; // to be saved in ram in interpolation area
reg[63:0] tempUsmaller;
reg[63:0] tempUbigger;

reg [1:0] ClkCounter1 = 2'd0;
reg[63:0] Tcurrent, Tbigger , Tsmaller;

reg done = 1'd0;
reg en1 = 1'd0;
reg en2 = 1'd0;
reg en3 = 1'd0;
reg en_write_data1 = 1'd0;
reg pos_or_neg = 1'd0;

reg [63:0] sum1_in1 = 64'd0;
reg [63:0] sum1_in2 = 64'd0;
reg [63:0] sum1_out = 64'd0;
reg [63:0] sum2_in1 = 64'd0;
reg [63:0] sum2_in2 = 64'd0;
reg [63:0] sum2_out = 64'd0;
reg addORsub1,addORsub2; //0:add , 1:sub
reg OVFlag; //not used

reg [63:0] mul1_in1 = 64'd0;
reg [63:0] mul1_in2 = 64'd0;
reg [63:0] mul1_out = 64'd0;

reg [63:0] div1_in1 = 64'd0;
reg [63:0] div1_in2 = 64'd0;
reg [63:0] div1_out = 64'd0;

reg [7:0] M;
reg [7:0] i = 8'd0;
//assign outputs
assign ADD1=add1Reg;
assign Data1  = en_write_data1 ? regData1 :  64'dz;
assign Done_interpolation = done;
// instantiating modules
Add_Sub #(64) sum1 (sum1_in1, sum1_in2, sum1_out,OVFlag,addORsub1);
Add_Sub #(64) sum2 (sum2_in1, sum2_in2, sum2_out,OVFlag,addORsub2);
mul #(64) mul1 (mul2_in1, mul2_in2, mul2_out,OVFlag);
div #(64) div1 (div1_in1, div1_in2, div1_out);



// reset block
always @(posedge Rst) begin
    en1 <= 1'd0;
en2 = 1'd0;
en3 = 1'd0;
en_write_data1 = 1'd0;
indexT= 10'd20; // first address of T
Tinterpolate= 10'd20; // address of Tcurrent in RAM
start_indexT= 10'd20;  // constant reg
start_indexU= 10'd20;  // constant reg
Usmaller= 10'd20;  // U equivalent for Tsmaller
index_interpolation= 10'd20;
    i <= 8'd0;
    ClkCounter1 = 2'd0;
done <= 0;
end
// enable block
always @(posedge Enable) begin
     en1 <= 1;
 end

//first block get Tcurrent,M
  always @(posedge Clk) begin
    wait(en1) begin
        if (ClkCounter1 ==0) begin
add1Reg<=Tinterpolate; // address of Tcurrent in RAM
ClkCounter1 = ClkCounter1 +1;
end
else if (ClkCounter1 ==1) begin
Tcurrent <= Data1; 
ClkCounter1 = ClkCounter1 +1;
end
else if (ClkCounter1 ==2) begin
add1Reg <= 10'd20; //address of M
ClkCounter1 = ClkCounter1 +1;
end
else if (ClkCounter1 ==3) begin
Tcurrent <= Data1; 
en2 =1;
en1 =0;
ClkCounter1 = 0;
end
end
end

//second block Tsmaller, Tbigger , Usmaller,Ubigger
  always @(posedge Clk) begin
    wait(en2) begin
        if (ClkCounter1 ==0) begin
add1Reg =indexT; // loop on T’s
indexT= indexT+1;
ClkCounter1 = ClkCounter1 +1;
end
else if (ClkCounter1 ==1) begin
sum1_in1 = Tcurrent; 
sum1_in2 = ~Data1;
addORsub1 = 1; //sub
pos_or_neg = sum1_out[63];
if (pos_or_neg == 1)begin //neg
Tbigger <= Data1;
indexT = start_indexT;
Usmaller = (smallerTindex - start_indexT) * M + start_indexU;
    en2=0;
    en3=1;
end
else begin
Tsmaller <= Data1;
smallerTindex<=indexT - 1;
end
ClkCounter1 = 0;

end

end
end

//third block calculate U and save it in RAM
  always @(posedge Clk) begin
    wait(en3) begin
        if (ClkCounter1 ==0) begin
add1Reg =Usmaller; 
en_write_data1=0;
ClkCounter1 = ClkCounter1 +1;
i = i+1;
end
else if (ClkCounter1 ==1) begin
tempUsmaller =Data1; 
add1Reg =Usmaller+ M; 
ClkCounter1 = ClkCounter1 +1;
end
else if (ClkCounter1 ==2) begin
tempUbigger =Data1; 
sum1_in1 = tempUsmaller;
sum1_in2 = tempUbigger;
addORsub1 = 1; //sub
tempUbigger=sum1_out; //subtract Ubigger - Usmaller
sum1_in1 = Tbigger;
sum1_in2 = ~Tsmaller;
div1_in1=tempUbigger;
div1_in2=sum1_out; //subtract Tbigger - Tsmaller
tempUbigger = div1_out; //divide
sum1_in1 = Tcurrent;
sum1_in2 = ~Tsmaller;
addORsub1 = 1; //sub
mul1_in1=sum1_out;
mul1_in2=tempUbigger;
tempUbigger=mul1_out; //multiply
addORsub1 = 0; //add
sum1_in1=tempUbigger;
sum1_in2=tempUsmaller;
tempUsmaller=sum1_out; //sum again
add1Reg = index_interpolation;
en_write_data1=1;
index_interpolation = index_interpolation+1;
Usmaller = Usmaller +1;
ClkCounter1 = 0;
end
if( i == M)begin
    done = 1;
    en3 = 0;
end

end
end 

endmodule

