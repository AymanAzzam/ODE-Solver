`timescale 1 ps/1 ps  // time-unit = 1 ns, precision = 10 ps

module SV_TestBench();
    wire h_done,mem_wr_enable,error_ok;
    reg reset,enable,start_cal_err;
    wire [10:0] address_bus;
    wire [63:0] data_bus;
    reg clk;

    localparam period = 100;

    variable_step vs (.h_done(h_done),.mem_wr_enable(mem_wr_enable),.error_ok(error_ok),.clk(clk),.reset(reset),.enable(enable),.start_cal_err(start_cal_err),.address_bus(address_bus),.data_bus(data_bus));
    
    always
    begin 
    clk = 1'b0;
    #50;
    clk =1'b1;
    #50;
    end 

    initial 
    begin
        reset = 1;
        vs.RAM.Mem[0] = 3 ;               //n=3
        vs.RAM.Mem[17] = 0.1;             //h=0.1
        vs.RAM.Mem[1] = 1;                //t1=1
        vs.RAM.Mem[2] = 2;                //t2=2
        vs.RAM.Mem[18] = 0.02;            //err=0.02
        //X0
        vs.RAM.Mem[119] = 1;
        vs.RAM.Mem[120] = 2;
        vs.RAM.Mem[121] = 3;
        //X1
        vs.RAM.Mem[169] = 1;
        vs.RAM.Mem[170] = 2;
        vs.RAM.Mem[171] = 3;

        #period;

    end

    always 
    begin
        reset = 0;
        enable = 1;
        #700;
        start_cal_err = 1;
        #period;
        #1000;
        $stop;
    end
endmodule