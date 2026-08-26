`timescale 1ns/1ns
module register_file_tb;
    initial begin 
        $dumpfile("register_file.vcd");
        $dumpvars(0, register_file_tb);
    end 

    //inputs
    logic clk;
    logic [4:0] rs1; //rs1
    logic [4:0] rs2; //rs2
    logic [4:0] rd; //rd
    logic [31:0] wd;
    logic rwrite; //enable signal 

    //outputs
    logic [31:0] read1;
    logic [31:0] read2;

    register_file reg_file_instance (
        .clk (clk),
        .reg_source1 (rs1),
        .reg_source2 (rs2),
        .reg_dest (rd),
        .write_data (wd),
        .reg_write (rwrite),
        .read_data1 (read1),
        .read_data2 (read2)
    );

    initial begin
        clk = 0;
    end

    always begin        
        #5 clk = ~clk;
    end

    initial begin
        rs1 = 0;
        rs2 = 0;
        rd = 0;
        wd = 0;
        rwrite = 0;

        //Testing read 1
        rd = 5'd5;
        wd = 32'd15;
        rwrite = 1;
        rs1 = 5'd5;
        @(posedge clk)
        #1
        rwrite = 0;
        $display("expect: 15 | read1: %d", read1);

        //testing read 2
        rd = 5'd6;
        wd = 32'd10;
        rwrite = 1;
        rs2 = 5'd6;
        @(posedge clk);
        #1
        rwrite = 0;
        $display ("expect: 10 | read2: %d", read2);

        //testing both read 1 and read 2
        rs1 = 5'd6;
        rs2 = 5'd5;
        @(posedge clk);
        #1
        $display("expect: read1 = 10, read2 = 15 | read1: %d, read2: %d", read1, read2);

        //testing when reg_write = 0
        rd = 5'd6;
        wd = 32'd10;
        rwrite = 0;
        rs1 = 5'd6;
        @(posedge clk);
        #1
        $display("expect: 10 | read1: %d", read1);

        //testing x0
        rd = 5'd0;
        wd = 32'd24;
        rwrite = 1;
        rs1 = 5'd0;
        @(posedge clk);
        #1
        $display("expect: 0 | read1: %d", read1);

        //testing overwriting registers
        rd = 5'd9;
        wd = 32'd3;
        rwrite = 1;
        rs1 = 5'd9;
        @(posedge clk);
        #1
        wd = 32'd8;
        rs1 = 5'd9;
        @(posedge clk);
        #1
        $display("expect: 8 | read1: %d", read1);
        $finish;
    end
endmodule