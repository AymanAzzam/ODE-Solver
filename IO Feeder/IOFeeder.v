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
            // Open file for reading
            dataFile = $fopen("output.txt", "rb");
            // Missing file error catching
            if (dataFile == 0) begin
                $display("ERROR: dataFile handle is NULL");
                $finish;
            end
            // Prepare first data packet
            scanFile <= $fscanf(dataFile, "%b", inputData);
            // Set load command control signal + interrupt signal to notify the chip to receive a data packet
            intrptSignal <= 1;
            cmdSignal    <= 1;
        end
        else begin
            if (dataFile) begin // Send data as long as the file is open
                if (done) begin // Prepare a new data packet, whenever the I/O module receives a data packet
                    scanFile <= $fscanf(dataFile, "%b", inputData);
                    if (!$feof(dataFile)) begin
                        intrptSignal <= 0; // If there are data to be sent, inform the I/O module to wait by suppressing the interrupt signal until the new data is prepared
                    end
                    else begin // Otherwise, send 'process' command and close the file
                        intrptSignal <= 1;
                        cmdSignal    <= 0;
                        $fclose(dataFile);
                        dataFile <= 0;
                    end
                end
                else begin // Inform the I/O module of the new data packet on the falling edge of the 'done' signal
                    intrptSignal <= 1;
                end
            end
            else begin // Receive results whenever the accelerator chip finishes data processing
                if (done) begin
                    // Receive data from I/O module
                end
            end
        end
    end
    
    assign dataBus = inputData;
    assign intrpt  = intrptSignal;
    assign cmd     = cmdSignal;
    
endmodule
