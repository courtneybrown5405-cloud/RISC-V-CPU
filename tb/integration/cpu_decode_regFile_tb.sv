module cpu_decode_regFile_tb;
    initial begin 
        $dumpfile("sim/cpu_decode_regFile.vcd");
        $dumpvars(0, cpu_decode_regFile_tb);
    end

    logic clk;
    logic reset;
    logic [31:0] instruction_tb;
    logic [4:0] expected_rs1, expected_rs2, actual_rs1, actual_rs2;
    logic [4:0] expected_rd, actual_rd;
    logic [31:0] actual_read1, expected_read1, actual_read2, expected_read2;

    cpu DUT (
        .clk (clk),
        .reset(reset),
        .instruction (instruction_tb)
    );

    always #5 clk = ~clk;

    initial begin 
        clk = 0;
        reset = 1;


        $display("----Starting Decode/Regfile Integration Test----\n");
        $display("----Starting: ADD x3, x2, x1 Test");
        //values into the Register File
        expected_read1 = 31'd10;
        expected_read2 = 31'd20;

        DUT.Register_File_Module.reg_file[2] = expected_read1;
        DUT.Register_File_Module.reg_file[1] = expected_read2;

        //Put Instruction into memory
        //ADD x3, x2, x1
        DUT.Instr_Mem_Module.instr_memory[0] = 32'h001101b3;

        @(posedge clk);
        #1
        reset = 0;

        //Check decode rs1, rs2, rd
        expected_rs1 = 5'd2;
        expected_rs2 = 5'd1;
        expected_rd = 5'd3;
        actual_rs1 = DUT.Decode_Module.reg_source1;
        actual_rs2 = DUT.Decode_Module.reg_source2;
        actual_rd = DUT.Decode_Module.reg_dest;

        if ((expected_rs1 == actual_rs1) && (expected_rs2 == actual_rs2) && (expected_rd == actual_rd)) begin 
            $display("Pass: ADD x3, x2, x1 - Decode Test");
        end else begin 
            $display("---FAIL--- \n RS1 - expected: %0d | actual: %0d \n RS2 - expected: %0d | actual: %0d \n RSd - expected: %0d | actual: %0d",
            expected_rs1, actual_rs1, expected_rs2, actual_rs2, expected_rd, actual_rd);
        end

        //check read of register file
        actual_read1 = DUT.Register_File_Module.read_data1;
        actual_read2 = DUT.Register_File_Module.read_data2;

        if((expected_read1 == actual_read1) && (expected_read2 == actual_read2)) begin 
            $display("PASS: ADD x3, x2, x1 - Register Read Test\n");
        end else begin 
            $display("---FAIL--- \n READ1 - expected: %0d | actual: %0d \n READ2 - expected: %0d | actual: %0d\n", expected_read1, actual_read1, expected_read2, actual_read2);
        end

        $display("----Starting: AND x6, x7, x8 Test");
        //values into the Register File
        expected_read1 = 31'd30;
        expected_read2 = 31'd90;

        DUT.Register_File_Module.reg_file[7] = expected_read1;
        DUT.Register_File_Module.reg_file[8] = expected_read2;

        //Put Instruction into memory
        //ADD x3, x2, x1
        DUT.Instr_Mem_Module.instr_memory[1] = 32'h0083f333;

        @(posedge clk);
        #1
        

        //Check decode rs1, rs2, rd
        expected_rs1 = 5'd7;
        expected_rs2 = 5'd8;
        expected_rd = 5'd6;
        actual_rs1 = DUT.Decode_Module.reg_source1;
        actual_rs2 = DUT.Decode_Module.reg_source2;
        actual_rd = DUT.Decode_Module.reg_dest;

        if ((expected_rs1 == actual_rs1) && (expected_rs2 == actual_rs2) && (expected_rd == actual_rd)) begin 
            $display("Pass: AND x6, x7, x8 - Decode Test");
        end else begin 
            $display("---FAIL--- \n RS1 - expected: %0d | actual: %0d \n RS2 - expected: %0d | actual: %0d \n RSd - expected: %0d | actual: %0d",
            expected_rs1, actual_rs1, expected_rs2, actual_rs2, expected_rd, actual_rd);
        end

        //check read of register file
        actual_read1 = DUT.Register_File_Module.read_data1;
        actual_read2 = DUT.Register_File_Module.read_data2;

        if((expected_read1 == actual_read1) && (expected_read2 == actual_read2)) begin 
            $display("PASS: AND x6, x7, x8 - Register Read Test\n");
        end else begin 
            $display("---FAIL--- \n READ1 - expected: %0d | actual: %0d \n READ2 - expected: %0d | actual: %0d\n", expected_read1, actual_read1, expected_read2, actual_read2);
        end

        $display("----Starting: OR x17, x30, x5 Test");
        //values into the Register File
        expected_read1 = 31'd30;
        expected_read2 = 31'd10;

        DUT.Register_File_Module.reg_file[30] = expected_read1;
        DUT.Register_File_Module.reg_file[5] = expected_read2;

        //Put Instruction into memory
        //ADD x3, x2, x1
        DUT.Instr_Mem_Module.instr_memory[2] = 32'h005f68b3;

        @(posedge clk);
        #1
        
        //Check decode rs1, rs2, rd
        expected_rs1 = 5'd30;
        expected_rs2 = 5'd5;
        expected_rd = 5'd17;
        actual_rs1 = DUT.Decode_Module.reg_source1;
        actual_rs2 = DUT.Decode_Module.reg_source2;
        actual_rd = DUT.Decode_Module.reg_dest;

        if ((expected_rs1 == actual_rs1) && (expected_rs2 == actual_rs2) && (expected_rd == actual_rd)) begin 
            $display("Pass: OR x17, x30, x5 - Decode Test");
        end else begin 
            $display("---FAIL--- \n RS1 - expected: %0d | actual: %0d \n RS2 - expected: %0d | actual: %0d \n RSd - expected: %0d | actual: %0d",
            expected_rs1, actual_rs1, expected_rs2, actual_rs2, expected_rd, actual_rd);
        end

        //check read of register file
        actual_read1 = DUT.Register_File_Module.read_data1;
        actual_read2 = DUT.Register_File_Module.read_data2;

        if((expected_read1 == actual_read1) && (expected_read2 == actual_read2)) begin 
            $display("PASS: OR x17, x30, x5 - Register Read Test\n");
        end else begin 
            $display("---FAIL--- \n READ1 - expected: %0d | actual: %0d \n READ2 - expected: %0d | actual: %0d\n", expected_read1, actual_read1, expected_read2, actual_read2);
        end
        $finish;
    end

endmodule;