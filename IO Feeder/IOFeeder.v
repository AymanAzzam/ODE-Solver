module IOFeeder (input clk,
                 input reset,
                 output reg intrpt, // notifies the accelerator chip of a command
                 output reg cmd,    // load = 1, process = 0
                 input done,
                 inout[31:0] data);
    
    integer encodedDataFile;
    integer resultFile;
    integer scanFile;
    integer N;
    integer totalElementsCount;
    integer totalReceivedElementsCount;
    integer currentVectorElementsCount;
    reg [31:0] fileInputData;
    
    assign data = encodedDataFile ? fileInputData : 32'bz;
    
    always @(posedge clk, posedge reset) begin
        if (reset) begin
            // Set received data count to -1
            currentVectorElementsCount   = 0;
            totalReceivedElementsCount = -1;
            totalElementsCount = 0;
            // Open file for reading
            encodedDataFile = $fopen("output.txt", "rb");
            // Missing file error catching
            if (encodedDataFile == 0) begin
                $display("ERROR: encodedDataFile handle is NULL");
                $finish;
            end
            // Prepare first data packet
            scanFile <= $fscanf(encodedDataFile, "%b", fileInputData);
            // Set load command control signal + interrupt signal to notify the chip to receive a data packet
            intrpt <= 1;
            cmd    <= 1;
        end
        else begin
            if (encodedDataFile) begin // Send data as long as the file is open
                if (done) begin // Prepare a new data packet, whenever the I/O module receives a data packet
                    scanFile <= $fscanf(encodedDataFile, "%b", fileInputData);
                    if (!$feof(encodedDataFile)) begin
                        intrpt <= 0; // If there are data to be sent, inform the I/O module to wait by suppressing the interrupt signal until the new data is prepared
                    end
                    else begin // Otherwise, send 'process' command and close the file
                        intrpt <= 1;
                        cmd    <= 0;
                        $fclose(encodedDataFile);
                        encodedDataFile <= 0;
                    end
                end
                else begin // Inform the I/O module of the new data packet on the falling edge of the 'done' signal
                    intrpt <= 1;
                end
            end
            else begin // Receive results whenever the accelerator chip finishes data processing
                if (done) begin
                    if (totalReceivedElementsCount == -1) begin // First time receiving data
                        N                 <= data[9:4]; // N => vector X length
                        totalElementsCount     <= data[3:0] * data[9:4]; // Total elements = N * Time steps at which X's are required
                        totalReceivedElementsCount <= totalReceivedElementsCount + 1; // totalReceivedElementsCount now equals 0
                        resultFile <= $fopen("results.txt"); // Open file for writing X's
                    end
                    else begin
                        if (totalReceivedElementsCount < totalElementsCount) begin
                            if (currentVectorElementsCount < N) begin // Write each X vector in a row with spaces between its elements
                                $fwrite(resultFile, "%b ", data);
                                currentVectorElementsCount   <= currentVectorElementsCount + 1;
                                totalReceivedElementsCount <= totalReceivedElementsCount + 1;
                            end
                            else begin
                                $fwrite(resultFile, "\n"); // Write a newline whenever an X gets all its elements written
                                currentVectorElementsCount <= 0;
                            end
                        end
                        else begin
                            $fclose(resultFile); // Close the file when finished
                        end
                    end
                end
            end
        end
    end
    
    
endmodule
