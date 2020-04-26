module variable_step(
    output reg h_done_reg,mem_wr_enable_reg,error_ok_reg,
    input clk,reset,enable,start_cal_err,           //to be added --> format (fixed or float)
    output reg [9:0] address_bus_reg,                     //not sure about bus width
    inout [63:0] data_bus
);

//=============Internal Constants======================
parameter WORD_SIZE = 64;
parameter ADDRESS_SIZE = 10;
parameter H_ADDRESS  =10'b0000010001;        //17               //TO BE CHANGED--ADDRESS
parameter X0_ADDRESS =10'b0001110111;        //119             //TO BE CHANGED--ADDRESS
parameter X1_ADDRESS =10'b0010101001;        //169               //TO BE CHANGED--ADDRESS
parameter T_ADDRESS  =10'b0000000001;        //1               //TO BE CHANGED--ADDRESS
parameter N_ADDRESS  =10'b0000000000;        //0               //TO BE CHANGED--ADDRESS
parameter L_ADDRESS  =10'b0000010010;        //18               //TO BE CHANGED--ADDRESS

//STATES::
parameter IDLE                  = 4'b0000,
          START                 = 4'b0001,
          HDONE_WAIT            = 4'b0010,
          CALC_ERROR            = 4'b0011,
          CHECK_ERROR           = 4'b0100,
          CALC_HNWE             = 4'b0101,           //IF ERROE NOTE ACCEPTABLE ERR>L
          CHECK_NOT_EXCEED_TIME = 4'b0110,
          TIME_EXCEEDED         = 4'b0111,
          TIME_NOT_EXCEEDED     = 4'b1000,
          TIME_EQUALITY         = 4'b1001;

//=============Internal Variables======================
reg   [3:0]                 STATE        ;
reg   [3:0]                 NEXT_STATE   ;
reg   [WORD_SIZE-1:0]       N            ;
reg   [WORD_SIZE-1:0]       CURRENT_TIME ;
reg   [WORD_SIZE-1:0]       NEXT_TIME    ;
reg   [WORD_SIZE-1:0]       H            ;
reg   [WORD_SIZE-1:0]       ERR          ;
reg   [WORD_SIZE-1:0]       MAX          ;
reg   [WORD_SIZE-1:0]       DIFFERENCE   ;
reg   [WORD_SIZE-1:0]       X            ;
reg   [WORD_SIZE-1:0]       COUNTER      ;                          //SIZE TO BE CHANGED
reg   [WORD_SIZE-1:0]       ITERATOR     ;                          //i
reg   [WORD_SIZE-1:0]       data_bus_reg;
reg [WORD_SIZE-1:0]         NEXT_TIME_I;

//==========intializations=============================
assign data_bus = (mem_wr_enable_reg == 1) ? data_bus_reg : {64{1'bz}};

dummy_ram RAM (reset,address_bus_reg,data_bus, clk,mem_wr_enable_reg);

//==========Code startes Here==========================
always @(posedge clk) begin
    if (reset) STATE <= IDLE;
    else STATE <= NEXT_STATE;
end

//assume memory return data in rising edge...
always @(clk) begin
    if(reset) begin
        h_done_reg=0;
        mem_wr_enable_reg=0;
        error_ok_reg=0;
        address_bus_reg=0;
        N=0;
        CURRENT_TIME=0;
        NEXT_TIME=0;
        H=0;
        ERR=0;
        MAX=0;
        DIFFERENCE=0;
        X=0;
        COUNTER=0;
        ITERATOR=0;
        data_bus_reg=0;
        NEXT_TIME_I=0;
        NEXT_STATE=0;
    end
    else begin
        
        NEXT_STATE <= STATE;
        case (STATE)
            //IDLE STATE::    1 cycle
            IDLE : 
                if (enable) begin
                    NEXT_STATE <= START;
                    COUNTER <= -2;
                end

            //START STATE::  5 cycles
            START : 
                if(COUNTER == 0) begin
                    address_bus_reg <= H_ADDRESS;
                    CURRENT_TIME <= 0;
                    mem_wr_enable_reg <= 0;
                end else if (COUNTER == 2) begin
                    H <= data_bus;
                    address_bus_reg <= N_ADDRESS;
                    mem_wr_enable_reg <= 0;
                end else if (COUNTER == 4) begin
                    N <= data_bus;
                    address_bus_reg <= L_ADDRESS;
                    mem_wr_enable_reg <= 0;
                end else if (COUNTER == 6) begin
                    ERR <= data_bus;
                    address_bus_reg <= T_ADDRESS;
                    mem_wr_enable_reg <= 0;
                end else if (COUNTER == 8) begin
                    NEXT_TIME <= data_bus;
                    NEXT_TIME_I <= 1;
                    NEXT_STATE <= HDONE_WAIT;
                    COUNTER <= -1;
                end    

            //HDONE_WAIT STATE::    1 cycle + wait for start calc
            HDONE_WAIT : 
                if(COUNTER == 0) begin
                    h_done_reg <= 1;
                end else if (start_cal_err == 1) begin
                    h_done_reg <= 0;
                    NEXT_STATE <= CALC_ERROR;
                    COUNTER <= -2;
                    ITERATOR <= 0;
                    address_bus_reg <= X1_ADDRESS;
                    mem_wr_enable_reg <= 0;
                    MAX=0;
                end
                    
            //CALC_ERROR STATE::   2N cycles
            CALC_ERROR : 
                if (COUNTER == 0) begin
                    if (ITERATOR == N) begin
                        NEXT_STATE <= CHECK_ERROR;
                        COUNTER <= -1;
                    end else begin
                        X <= data_bus;
                        address_bus_reg <= X0_ADDRESS + ITERATOR; 
                        mem_wr_enable_reg <= 0;
                    end
                end else if (COUNTER == 2) begin
                    DIFFERENCE = (data_bus > X) ? (data_bus - X):(X - data_bus);
                    MAX = (MAX < DIFFERENCE) ? DIFFERENCE : MAX;
                    address_bus_reg <= X1_ADDRESS + ITERATOR +1;
                    mem_wr_enable_reg <= 0;
                    ITERATOR <= ITERATOR + 1;
                    COUNTER <= -1; 
                end
            
            //CHECK_ERROR STATE::  1 cycle
            CHECK_ERROR : 
                if(COUNTER == 0) begin
                    if(MAX > ERR) begin
                        NEXT_STATE <= CALC_HNWE;
                        COUNTER <= -1;
                    end else begin
                        NEXT_STATE <= CHECK_NOT_EXCEED_TIME;
                        COUNTER <= -1;
                    end
                end

            //CALC_HNEW STATE::  2 cycles
            CALC_HNWE :
                if(COUNTER == 0) begin
                    H = (0.9*H*H*ERR)/MAX;
                    address_bus_reg = H_ADDRESS;
                    data_bus_reg = H;
                    mem_wr_enable_reg = 1;
                end else if (COUNTER == 2) begin
                    mem_wr_enable_reg = 0;
                    h_done_reg = 1;
                    COUNTER <= -2;
                    NEXT_STATE <= HDONE_WAIT;
                end
            
            //CHECK_NOT_EXCEEDED_TIME STATE::    1 cycle
            CHECK_NOT_EXCEED_TIME :
                if (COUNTER == 0) begin
                    if(CURRENT_TIME + H > NEXT_TIME) begin
                        NEXT_STATE <= TIME_EXCEEDED;
                    end else begin
                        NEXT_STATE <= TIME_NOT_EXCEEDED;
                    end
                    COUNTER <= -1;
                end

            //TIME_EXCEEDED::    2 cycles
            TIME_EXCEEDED:
                if(COUNTER == 0) begin
                    H = NEXT_TIME - CURRENT_TIME;
                    data_bus_reg = H;
                    address_bus_reg = H_ADDRESS;
                    mem_wr_enable_reg = 1;
                end else if (COUNTER == 2) begin
                    mem_wr_enable_reg = 0;
                    NEXT_STATE <= HDONE_WAIT;
                    COUNTER=-2;
                end

            //TIME_NOT_EXCEEDED STATE::       1 cycle
            TIME_NOT_EXCEEDED : 
                if(COUNTER == 0) begin
                    error_ok_reg =1;
                    CURRENT_TIME = CURRENT_TIME + H;
                    if(CURRENT_TIME == NEXT_TIME) begin
                        NEXT_STATE <= TIME_EQUALITY;
                    end else begin
                        NEXT_STATE <= HDONE_WAIT;
                    end
                    COUNTER <= -1;
                end

            //TIME_EQUALITY STATE::             2 cycles
            TIME_EQUALITY :
                if(COUNTER == 0) begin
                    address_bus_reg = T_ADDRESS + NEXT_TIME_I;
                    mem_wr_enable_reg =0;
                end else if (COUNTER == 2) begin
                    NEXT_TIME <= data_bus;
                    NEXT_TIME_I <= NEXT_TIME_I + 1;
                    NEXT_STATE <= HDONE_WAIT;
                    COUNTER <= -1;
                end
        endcase
        COUNTER = COUNTER + 1;
    end
end

endmodule