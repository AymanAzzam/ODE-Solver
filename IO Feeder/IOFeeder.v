module IOFeeder (input clk,
                 input reset,
                 output intrpt,         // notifies the accelerator chip of a command
                 output cmd,            // load = 1, process = 0
                 input done,
                 output[31:0] dataBus);
    
    integer dataFile;
    integer scanFile;
    reg [31:0] inputData;
    reg intrptSignal, cmdSignal;
    
    always @(posedge clk, posedge reset) begin
        if (reset) begin
            dataFile = $fopen("output.txt", "rb");
            if (dataFile == 0) begin
                $display("ERROR: dataFile handle is NULL");
                $finish;
            end
            scanFile <= $fscanf(dataFile, "%b", inputData);
            // Send load command + interrupt signal to notify the chip to receive a data packet
            intrptSignal  <= 1;
            cmdSignal     <= 1;
        end
        else begin
            if (dataFile) begin
                if (!$feof(dataFile)) begin
                    if (done && intrptSignal) begin
                        scanFile <= $fscanf(dataFile, "%b", inputData);
                        // Send load command + interrupt signal to notify the chip to receive a data packet
                        $display("scanFile = %d", scanFile);
                        intrptSignal  <= 0;
                    end
                    else begin
                        intrptSignal <= 1;
                    end
                end
                else begin
                    intrptSignal  <= 1;
                    cmdSignal     <= 0;
                end
            end
        end
    end

    assign dataBus = inputData;
    assign intrpt = intrptSignal;
    assign cmd = cmdSignal;

endmodule
