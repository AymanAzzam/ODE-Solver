module variable_step(
    output h_done,mem_wr_enable,error_ok,
    input clk,reset,enable,start_cal_err,           //to be added --> format (fixed or float)
    output [63:0] address_bus,                     //not sure about bus width
    inout [63:0] data_bus
);

//=============Internal Constants======================
parameter SIZE = 16;
parameter H_ADDRESS  =5'b00000;                      //TO BE CHANGED--ADDRESS
parameter X0_ADDRESS =5'b00000;                      //TO BE CHANGED--ADDRESS
parameter X1_ADDRESS =5'b00000;                      //TO BE CHANGED--ADDRESS
parameter T_ADDRESS  =5'b00000;                      //TO BE CHANGED--ADDRESS
parameter N_ADDRESS  =5'b00000;                      //TO BE CHANGED--ADDRESS
parameter L_ADDRESS  =5'b00000;                      //TO BE CHANGED--ADDRESS

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
reg   [3:0]          STATE        ;
reg   [3:0]          NEXT_STATE   ;
reg   [5:0]          N            ;
reg   [SIZE-1:0]     CURRENT_TIME ;
reg   [SIZE-1:0]     NEXT_TIME    ;
reg   [SIZE-1:0]     H            ;
reg   [SIZE-1:0]     ERR          ;
reg   [SIZE-1:0]     MAX          ;
reg   [SIZE-1:0]     DIFFERENCE   ;
reg   [SIZE-1:0]     X            ;
reg   [SIZE-1:0]     COUNTER      ;                          //SIZE TO BE CHANGED
reg   [5:0]          ITERATOR     ;                          //i
reg   [63:0]         address_bus_reg;
reg   [63:0]         data_bus_reg;
reg                  h_done_reg;
reg                  error_ok_reg;
reg                  mem_wr_enable_reg;
reg [63:0]           NEXT_TIME_I;

//==========intializations=============================
assign address_bus = address_bus_reg; 
assign data_bus = (mem_wr_enable == 1) ? data_bus_reg : 64'bz;
assign h_done = h_done_reg;
assign error_ok = error_ok_reg;

//==========Code startes Here==========================
always @(posedge clk) begin
    if (reset) STATE <= IDLE;
    else STATE <= NEXT_STATE;
end

//assume memory return data in rising edge...
always @(STATE,clk) begin 
    NEXT_STATE <= STATE;
    COUNTER <= COUNTER + 1;
    case (STATE)
        //IDLE STATE::
        IDLE : 
            if (enable) begin
                NEXT_STATE <= START;
                COUNTER <= 0;
            end

        //START STATE::
        START : 
            if(COUNTER == 0) begin
                address_bus_reg <= H_ADDRESS;
                CURRENT_TIME <= 0;
                mem_wr_enable_reg <= 0;
            end else if (COUNTER == 2) begin
                H <= data_bus[SIZE-1:0];
                address_bus_reg <= N_ADDRESS;
                mem_wr_enable_reg <= 0;
            end else if (COUNTER == 4) begin
                N <= data_bus [5:0];
                address_bus_reg <= L_ADDRESS;
                mem_wr_enable_reg <= 0;
            end else if (COUNTER == 6) begin
                ERR <= data_bus [SIZE-1:0];
                address_bus_reg <= T_ADDRESS;
                mem_wr_enable_reg <= 0;
            end else if (COUNTER == 8) begin
                NEXT_TIME <= data_bus[SIZE-1:0];
                NEXT_TIME_I <= 1;
                NEXT_STATE <= HDONE_WAIT;
                COUNTER <= 0;
            end    

        //HDONE_WAIT STATE::
        HDONE_WAIT : 
            if(COUNTER == 0) begin
                h_done_reg <= 1;
            end else if (start_cal_err == 1) begin
                NEXT_STATE <= CALC_ERROR;
                COUNTER <= 0;
                ITERATOR <= 0;
                address_bus_reg <= X1_ADDRESS;
                mem_wr_enable_reg <= 0;
            end
                 
        //CALC_ERROR STATE::
        CALC_ERROR : 
            if (COUNTER == 0) begin
                if (ITERATOR == N) begin
                    NEXT_STATE <= CHECK_ERROR;
                    COUNTER <= 0;
                end else begin
                    X <= data_bus[SIZE-1:0];
                    address_bus_reg <= X0_ADDRESS + ITERATOR; 
                    mem_wr_enable_reg <= 0;
                end
            end else if (COUNTER == 2) begin
                DIFFERENCE = (data_bus[SIZE-1:0] > X) ? (data_bus[SIZE-1:0] - X):(X - data_bus[SIZE-1:0]);
                MAX = (MAX < DIFFERENCE) ? DIFFERENCE : MAX;
                address_bus_reg <= X1_ADDRESS + ITERATOR +1;
                mem_wr_enable_reg <= 0;
                ITERATOR <= ITERATOR + 1;
                COUNTER <= 0; 
            end
        
        //CHECK_ERROR STATE::
        CHECK_ERROR : 
            if(COUNTER == 0) begin
                if(MAX > ERR) begin
                    NEXT_STATE <= CALC_HNWE;
                    COUNTER <= 0;
                end else begin
                    NEXT_STATE <= CHECK_NOT_EXCEED_TIME;
                    COUNTER <=0;
                end
            end

        //CALC_HNEW STATE::
        CALC_HNWE :
            if(COUNTER == 0) begin
                H = (0.9*H*H*ERR)/MAX;
                address_bus_reg = H_ADDRESS;
                data_bus_reg = H;
                mem_wr_enable_reg = 1;
            end else if (COUNTER == 2) begin
                mem_wr_enable_reg = 0;
                h_done_reg = 1;
                COUNTER <= 0;
                NEXT_STATE <= HDONE_WAIT;
            end
        
        //CHECK_NOT_EXCEEDED_TIME STATE::
        CHECK_NOT_EXCEED_TIME :
            if (COUNTER == 0) begin
                if(CURRENT_TIME + H > NEXT_TIME) begin
                    NEXT_STATE <= TIME_EXCEEDED;
                    COUNTER <= 0;
                end else begin
                    NEXT_STATE <= TIME_NOT_EXCEEDED;
                    COUNTER <= 0;
                end
            end

        //TIME_EXCEEDED::
        TIME_EXCEEDED:
            if(COUNTER == 0) begin
                H = NEXT_TIME - CURRENT_TIME;
                data_bus_reg = H;
                address_bus_reg = H_ADDRESS;
                mem_wr_enable_reg = 1;
            end else if (COUNTER == 2) begin
                mem_wr_enable_reg = 0;
                NEXT_TIME <= HDONE_WAIT;
            end

        //TIME_NOT_EXCEEDED STATE::
        TIME_NOT_EXCEEDED : 
            if(COUNTER == 0) begin
                error_ok_reg =1;
                if(CURRENT_TIME == NEXT_TIME) begin
                    NEXT_STATE <= TIME_EQUALITY;
                end else begin
                    NEXT_STATE <= HDONE_WAIT;
                end
                COUNTER <= 0;
            end

        //TIME_EQUALITY STATE::
        TIME_EQUALITY :
            if(COUNTER == 0) begin
                address_bus_reg = T_ADDRESS + NEXT_TIME_I;
                mem_wr_enable_reg =0;
            end else if (COUNTER == 2) begin
                NEXT_TIME <= data_bus;
                NEXT_TIME_I <= NEXT_TIME_I + 1;
                NEXT_STATE <= HDONE_WAIT;
            end
    endcase
end

endmodule