module CPU (input clk,
            input rst,
            input intrpt,
            input ld,
            output[31:0] dataBus);
    
    integer dataFile;
    integer scanFile;
    reg [31:0] inputData;
    
    initial begin
        dataFile = $fopen("output.txt", "rb");
        if (dataFile == 0) begin
            $display("ERROR: dataFile handle is NULL");
            $finish;
        end
    end
    
    always @(posedge clk) begin
        scanFile = $fscanf(dataFile, "%b", inputData);
        if (!$feof(dataFile)) begin
            $display("%b",inputData);
        end
        else begin
            $fclose(dataFile);
            $finish;
        end
    end
    
endmodule
