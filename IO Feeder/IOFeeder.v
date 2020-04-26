module IOFeeder (input clk,
                 input reset,
                 output reg intrpt, // notifies the accelerator chip of a command
                 output reg cmd,    // load = 1, process = 0
                 input done,
                 inout[31:0] data);
    
    integer dataFile;
    integer resultFile;
    integer scanFile;
    integer N;
    integer T;
    integer elementsCount;
    integer receivedDataCount;
    integer outputtedXCount;
    reg [31:0] fileInputData;
    
    assign data = dataFile ? fileInputData : 32'bz;
    
    always @(posedge clk, posedge reset) begin
        if (reset) begin
            // Set received data count to -1
            outputtedXCount   = 0;
            receivedDataCount = -1;
            elementsCount = 0;
            // Open file for reading
            dataFile = $fopen("output.txt", "rb");
            // Missing file error catching
            if (dataFile == 0) begin
                $display("ERROR: dataFile handle is NULL");
                $finish;
            end
            // Prepare first data packet
            scanFile <= $fscanf(dataFile, "%b", fileInputData);
            // Set load command control signal + interrupt signal to notify the chip to receive a data packet
            intrpt <= 1;
            cmd    <= 1;
        end
        else begin
            if (dataFile) begin // Send data as long as the file is open
                if (done) begin // Prepare a new data packet, whenever the I/O module receives a data packet
                    scanFile <= $fscanf(dataFile, "%b", fileInputData);
                    if (!$feof(dataFile)) begin
                        intrpt <= 0; // If there are data to be sent, inform the I/O module to wait by suppressing the interrupt signal until the new data is prepared
                    end
                    else begin // Otherwise, send 'process' command and close the file
                        intrpt <= 1;
                        cmd    <= 0;
                        $fclose(dataFile);
                        dataFile <= 0;
                    end
                end
                else begin // Inform the I/O module of the new data packet on the falling edge of the 'done' signal
                    intrpt <= 1;
                end
            end
            else begin // Receive results whenever the accelerator chip finishes data processing
                if (done) begin // Receive data from I/O module
                    if (receivedDataCount == -1) begin
                        T                 <= data[3:0];
                        N                 <= data[9:4];
                        elementsCount     <= data[3:0] * data[9:4];
                        receivedDataCount <= receivedDataCount + 1;
                        resultFile <= $fopen("results.txt");
                    end
                    else begin
                        if (receivedDataCount < elementsCount) begin
                            if (outputtedXCount < N) begin
                                $fwrite(resultFile, "%b ", data);
                                outputtedXCount   <= outputtedXCount + 1;
                                receivedDataCount <= receivedDataCount + 1;
                            end
                            else begin
                                $fwrite(resultFile, "\n");
                                outputtedXCount <= 0;
                            end
                        end
                        else begin
                            $fclose(resultFile);
                        end
                    end
                end
            end
        end
    end
    
    
endmodule
