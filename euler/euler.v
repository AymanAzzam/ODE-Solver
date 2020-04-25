module euler
(Rst,Clk, Fixed_Floating, Hnew_Done, Enable,Done_Interpolation, count, 
Data1, Data2, Data3, Data4,isH_Fixed,Done_error,error_low,
ADD1,ADD2,ADD3,ADD4,X,DoneResult, read_write_en1, read_write_en2, read_write_en3, read_write_en4);

input  Rst,Clk, Fixed_Floating, Hnew_Done, Enable,
Done_Interpolation,isH_Fixed,Done_error,error_low;
input [2:0] count;
inout [63:0] Data1, Data2, Data3, Data4;
output  [10:0] ADD1;
output  [10:0] ADD2;
output  [10:0] ADD3;
output  [10:0] ADD4;
output X,DoneResult, read_write_en1, read_write_en2, read_write_en3, read_write_en4 ;

// utility registers
reg [63:0] H;
reg [7:0] N,M;
reg en1 = 1'd0;
reg en11 = 1'd0;
reg en2 = 1'd0;
reg en3 = 1'd0;
reg en4 = 1'd0;
reg en5_2 = 1'd0;
reg en5_4 = 1'd0;
reg en6 = 1'd0;
reg en7 = 1'd0;
reg en8 = 1'd0;
reg en9 = 1'd0;
reg enable_interpolation = 1'd0;
reg en_write_data1 = 1'd0;
reg en_write_data2 = 1'd0;
reg en_write_data3 = 1'd0;
reg en_write_data4 = 1'd0;

 
reg [1:0] ClkCounter1 = 2'd0;
reg ClkCounter2 = 1'd0;
reg ClkCounter3 = 1'd0;
reg ClkCounter4 = 1'd0;

reg[2:0] count_written_Xs = 3'd0;
reg[1:0] count_h_iterations = 2'd0;
  //0 : use given H , 1: use h/2 for first time , 2: use h/2 for second time 
reg [63:0] regData1 = 64'd0;
reg [63:0] regData2 = 64'd0;
reg [63:0] regData3 = 64'd0;
reg [63:0] regData4 = 64'd0;

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
reg [63:0] mul2_in1 = 64'd0;
reg [63:0] mul2_in2 = 64'd0;
reg [63:0] mul2_out = 64'd0;

reg [63:0] div1_in1 = 64'd0;
reg [63:0] div1_in2 = 64'd0;
reg [63:0] div1_out = 64'd0;

reg isDone=1'd0;
reg Xready=1'd0;
reg [10:0] add1Reg,add2Reg,add3Reg,add4Reg;
reg [10:0] indexA= 10'd20; // first address of A
reg [10:0] indexX0= 10'd20; // first address of X
reg [10:0] indexB= 10'd20; // first address of B
reg [10:0] indexU= 10'd20; // first address of U
reg [10:0] indexT= 10'd20; // first address of T
reg [10:0] Tinterpolate= 10'd20; // address of Tcurrent in RAM
reg [10:0] indexXout= 10'd20; // address of Xout
reg [10:0] indexXh= 10'd20; // address of Xn+1 due to h
reg [10:0] indexXh_2= 10'd20; // address of Xn+1 due to h/2
reg [10:0] Ucurrent= 10'd20; // first Address of the current U in RAM1
reg [10:0] indexXstable=10'd20; //address of last stable X
reg [10:0] indexUstable=10'd20; //address of last stable U

reg[63:0] Tvalue = 3'd0; // T value read from memory
reg[63:0] Tcurrent = 3'd0; // T value read from memory + H
reg[63:0] Tstable = 3'd0;  // T used for restore

integer i, rows1 , cols1, rows2, cols2;
reg [63:0] AXn[0:50]; //contains temporary vector
reg [63:0] BUn[0:50]; //contains temporary vector
reg [63:0] Xprev[0:50]; //contains temporary vector
//assign outputs
assign   ADD1=add1Reg;
assign   ADD2=add2Reg;
assign   ADD3=add3Reg;
assign   ADD4=add4Reg;
assign   DoneResult=isDone;
assign   X=Xready;

assign Data1  = en_write_data1 ? regData1 :  64'dz;
assign Data2  = en_write_data2 ? regData2 :  64'dz;
assign Data3  = en_write_data3 ? regData3 :  64'dz;
assign Data4  = en_write_data4 ? regData4 :  64'dz;

assign read_write_en1  =en_write_data1;
assign read_write_en2  =en_write_data2;
assign read_write_en3  =en_write_data3;
assign read_write_en4  =en_write_data4;
// instantiating modules
Add_Sub #(64) sum1 (sum1_in1, sum1_in2, sum1_out,OVFlag,addORsub1);
Add_Sub #(64) sum2 (sum2_in1, sum2_in2, sum2_out,OVFlag,addORsub2);

mul #(64) mul1 (mul1_in1, mul1_in2, mul1_out,OVFlag);
mul #(64) mul2 (mul2_in1, mul2_in2, mul2_out,OVFlag);

div #(64) div1 (div1_in1, div1_in2, div1_out);
// reset block
  always @(posedge Rst) begin
      isDone <= 0;
      Xready <= 0;
      en1 <= 0;
    en11 <=0;
      en2 <= 0;
      en3 <= 0; 
en5_2 <=0;
en5_4 <=0; 
en6 <= 0;
      en7 <= 0; 
    en8 <= 0;
      en9 <= 0; 
count_written_Xs = 3'd0;
count_h_iterations <= 0;

    for (i= 0;i < 50; i=i+1) begin
          AXn[i] <= 64'd0;
        BUn[i] <= 64'd0;
        Xprev[i] <= 64'd0;
       end

indexA <= 10'd20; // first address of A
indexX0 <= 10'd20; // first address of X
indexB <= 10'd20; // first address of B
indexU <= 10'd20; // first address of U
indexT <= 10'd20; // first address of T
indexXout <= 10'd20; // address of Xout
indexXh <= 10'd20; // address of Xn+1 due to h
indexXh_2 <= 10'd20; // address of Xn+1 due to h/2
Ucurrent <= 10'd20; // first Address of the current U in RAM1
indexXstable <=10'd20; //address of last stable X
indexUstable <=10'd20; //address of last stable U

     en_write_data1 <= 0;
    en_write_data2 <= 0;
    en_write_data3 <= 0;
    en_write_data4 <= 0;
ClkCounter1 = 2'd0;
ClkCounter2 = 1'd0;
ClkCounter3 = 1'd0;
ClkCounter4 = 1'd0;

Tvalue <= 3'd0; // T value read from memory
Tcurrent <= 3'd0; // T value read from memory + H
Tstable <= 3'd0;  // T used for restore
    rows1 <=0;
cols1<=0;
rows2<=0;
cols2<=0;

  end
// enable block
always @(posedge Enable) begin
     en1 <= 1;
 end

//first block initiate euler (no loop)
  always @(posedge Clk) begin
    wait(en1) begin
      if (ClkCounter1 == 0) begin
add1Reg<=10'd20; //address of M (10'd20 is assumption)
add4Reg<=10'd20; //address of N (10'd20 is assumption)
ClkCounter1 = ClkCounter1 + 1;        
      end
        else if(ClkCounter1 == 1) begin
    N <= Data4 [7:0];
    M <= Data1 [7:0];
    add4Reg<=10'd20; //address of H (10'd20 is assumption)
    ClkCounter1 = ClkCounter1 + 1;  
            end
else if(ClkCounter1 == 2) begin
H <= Data4;
en1 =0;
en2 =1;
en3 =1;
ClkCounter1 =0;
        end
     end
end

// First dash (get H )
 always @(posedge Clk) begin
    wait(en11  && Hnew_Done) begin
        if (ClkCounter1 == 0 && count_h_iterations == 0 ) begin
add4Reg<=10'd20; //address of H (10'd20 is assumption)
ClkCounter1 = ClkCounter1 +1;
        end
        else if(ClkCounter1 == 1 && count_h_iterations == 0) begin
            H = Data4;
ClkCounter1 = 0;
en2 =1;
en3 =1;
en11 =0;
        end
        else if(count_h_iterations == 1) begin
            div1_in1 = H;
            div1_in2 = 2;
            H = div1_out;
en2 =1;
en3 =1;
en11 =0;
        end
        else if(count_h_iterations == 2) begin
en2 =1;
en3 =1;
en11 =0;
        end
end
end

// second block A * Xn
  always @(posedge Clk) begin
    wait(en2) begin
 if (rows1 <N && cols1==N) begin
cols1 = 0;
rows1 =rows1 +1;
indexX0 = 10'd20; // address of X0 (10'd20 is assumption)
indexXstable = 10'd20; // address of Xstable (10'd20 is assumption)
end
if (ClkCounter2 == 0) begin
          add2Reg =indexA ; //address of element in A
ClkCounter2 = ClkCounter2 + 1; 
indexA = indexA+1;
add4Reg = (Tcurrent == 0) ? indexX0 : indexXstable;  //addr of Xn
indexX0  = indexX0+1;       
indexXstable = indexXstable+1;      
end
else if(ClkCounter2 == 1) begin
mul1_in1 = Data2;
     mul1_in2 = (Tcurrent == 0 || count_h_iterations==1) ? Data4 : Xprev[cols1] ;
     sum1_in1 = AXn[rows1];
     sum1_in2 = mul1_out;
addORsub1 =0; //add
     AXn[rows1] <= sum1_out;
     cols1 = cols1 +1;
     ClkCounter2 =0;
     end
     if (rows1==N && cols1==N) begin
    en5_2 = 1;
    en2 = 0;
    rows1 =0;
    cols1 =0;
    indexA <= 10'd20;
indexX0 <= 10'd20; // address of X0 (10'd20 is assumption)
indexXstable <= 10'd20; // address of Xstable (10'd20 is assumption)
      end
end
end
// third Block Umemory or UInterpolation
always @(posedge Clk) begin
    wait(en3) begin
        if (Tcurrent == 0) begin
            en4 = 1;
            en3 = 0;
            enable_interpolation = 0;
        end
else if (ClkCounter3 == 0) begin
    add1Reg<=indexT ; //address of element in T 
    ClkCounter3 = ClkCounter3 + 1; 
end
else if(ClkCounter3 == 1) begin
Tvalue = Data1;
    sum2_in1 = Tcurrent;
    sum2_in2 = H;
    addORsub1 =0; //add
ClkCounter3 = 0;
Tcurrent =sum2_out;
    if (Tvalue == Tcurrent) begin
        // take the current U
        indexU = Ucurrent;
        enable_interpolation = 0;
end
else begin
add1Reg =Tinterpolate;
regData1 = Tcurrent;
en_write_data1 =1;
    // take the U from where the interpolation leaves it
    indexU <= 10'd40; // Fixed address for Interpolation 
    enable_interpolation = 1;
end
en4 = 1;
en3 = 0;
en_write_data1 =0;
        end

end
end
// fourth block B* Un
  always @(posedge Clk) begin
    wait(en4 && (Done_Interpolation || enable_interpolation==0 )) begin
 if (rows2 <N && cols2==M) begin
cols2 = 0;
rows2 = rows2 +1;
if(enable_interpolation) indexU = 10'd40; // Fixed address for Interp.
else indexU = Ucurrent;
end
if (ClkCounter4 == 0) begin
    add3Reg =indexB ; //address of element in B
add1Reg =indexU ; //address of element in Un
ClkCounter4 = ClkCounter4 + 1; 
indexB <= indexB+1;
indexU <= indexU+1;       
end
        else if(ClkCounter4 == 1) begin
mul2_in1 = Data3;
mul2_in2 = Data1;
sum2_in1 = BUn[rows2];
sum2_in2 = mul2_out;
addORsub2 =0; //add
BUn[rows2] = sum2_out;
cols2 = cols2 +1;
    ClkCounter4 =0;
        end
if (rows2==N && cols2==M) begin
    en5_4 = 1;
    en4 = 0;
    rows2 = 0;
    cols2 = 0;
    indexB <= 10'd20; // first address of B
    if ( enable_interpolation==0)  Ucurrent <= indexU;
end
   end
end
// fifth block AXn = AXn + BUn
  always @(posedge Clk) begin
    wait(en5_4 && en5_2 ) begin
for (i= 0;i < N; i=i+1) begin
          sum2_in1 = AXn[i] ;
        sum2_in2 =BUn[i] ;
        addORsub2 =1; //add
        AXn[i] = sum2_out;
end
en5_2 =0;
en5_4 =0;
en6 =1;
end
end

// sixth block  AXn = H*Xn’ 
  always @(posedge Clk) begin
    wait(en6 ) begin
for (i= 0;i < N; i=i+1) begin
          mul1_in1 = H;
        mul1_in1 = AXn[i];
        AXn[i] = mul1_out;
     end
en7 =1;
en6 =0;
end
end

// seventh block Xn+1 = Xn + HXn’
  always @(posedge Clk) begin
    wait(en7 ) begin
if (ClkCounter1 == 0) begin                                        // put address of X0 or Xstable on add bus
    add4Reg <= (Tcurrent == 0) ? indexX0 : indexXstable; //addr of Xn
ClkCounter1 = ClkCounter1 + 1;       
 end
 else if(ClkCounter1 == 1) begin
    sum1_in1 <= (Tcurrent == 0 || count_h_iterations==1) ? Data4 : Xprev[rows1];
    sum1_in2 <= AXn[rows1];
addORsub1 =0; //add
    if (enable_interpolation ==0 && isH_Fixed == 1 ) begin
    add4Reg = indexXout; 
    regData4 = sum1_out;
    en_write_data4 = 1;
    indexXout = indexXout + 1; 
end
Xprev[rows1] = sum1_out;
rows1 <= rows1 +1; 
if(enable_interpolation ==0 && isH_Fixed == 1) ClkCounter1 <= 0; //write cond.
else ClkCounter1 = 1;
indexX0 <= indexX0 + 1; 
indexXstable <= indexXstable + 1; 
end

     if (rows1 == N) begin
    if (enable_interpolation ==0 && isH_Fixed == 1  ) begin
count_written_Xs <= count_written_Xs +1;
end
    if (isH_Fixed == 0) count_h_iterations <= count_h_iterations +1;
          rows1 = 0;
    en_write_data4 = 0;
en7 = 0;
indexXstable <= 10'd20;
indexX0<= 10'd20;
if (count_written_Xs == count ) begin
isDone = 1;
en7 = 0;
end
    else if (isH_Fixed ==1) en2 = 1;
else en8 = 1;
end
end
end

// eighth block (save for variable step)
  always @(posedge Clk) begin
    wait(en8) begin
        if (ClkCounter1 == 0) begin
            add4Reg <= (count_h_iterations ==0) ?indexXh :indexXh_2;
            ClkCounter1 = ClkCounter1 + 1;  
        end
        if (ClkCounter1 == 1) begin
            regData4 = Xprev[rows1];
            en_write_data4 = 1;
            rows1 = rows1 +1;
indexXh = indexXh+1;
indexXh_2 = indexXh_2+1;
            ClkCounter1 = 0;   
        end
        if (rows1 ==N) begin
            en8 = 0;
            indexXh <= 10'd20; 
            indexXh_2 <= 10'd20; 
         end
if (count_h_iterations == 2)begin
Xready =1;
en9 =1;
end
else begin
en2 =1; 
en3 =1; 
end
end
end


// ninth block (wait for error)
  always @(posedge Clk) begin
    wait(en9 && Done_error) begin
if (error_low ==1 ) begin
    if (ClkCounter1 == 0) begin
        add4Reg = indexXh_2;
        indexXh_2 = indexXh_2 + 1;  
            ClkCounter1 = ClkCounter1 + 1;  
    end
    else if (ClkCounter1 == 1) begin
        Xprev[rows1] = Data4;
        add4Reg = indexXstable;
        regData4 = Xprev[rows1] ;
        en_write_data4 = 1;
        indexXstable = indexXstable + 1;  
            ClkCounter1 =(enable_interpolation)? 3 : ClkCounter1 + 1;  
    end
    else if (ClkCounter1 == 2) begin
        add4Reg = indexXout;
        indexXout = indexXout + 1;  
        indexT = indexT +1;
        count_written_Xs = count_written_Xs +1;
            ClkCounter1 = ClkCounter1 + 1;  
    end
    else if (ClkCounter1 == 3) begin
en_write_data4 = 0;
            ClkCounter1 = 0;  
            rows1 = rows1 + 1;  
    end
    if ( rows1 == N) begin
        rows1 =0;
        indexXh_2 <= 10'd20; 
        indexXstable <= 10'd20; 
        if (count_written_Xs == count ) begin
en11 =0;
isDone = 1;
        end
        else en11 =1;
        en9 =0; //close block any way
    end // end if rows == n
end // end if error_low ==1

         else begin //if error_low==0
        if (ClkCounter1 == 0) begin
            add4Reg <= indexXstable;
            ClkCounter1  = ClkCounter1 + 1;  
end
        else if (ClkCounter1 == 1) begin
            Xprev[rows1] = Data4;
            rows1 = rows1 + 1;  
            ClkCounter1 =0;
        end    

        if ( rows1 == N) begin
        rows1<=0;    
        Ucurrent <= Ucurrent - M;
        addORsub2 =1; //subtract
        sum1_in1 = Tcurrent;
        sum1_in2 = ~H;
        Tcurrent =sum1_out;
        en9 =0; //close block any way
        en11 =1;
    end
         end // end else
    end
end


endmodule

