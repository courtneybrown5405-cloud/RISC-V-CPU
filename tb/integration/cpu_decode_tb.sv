module cpu_decode_tb;
    initial begin
        $dumpfile("sim/cpu_decode.vcd");
        $dumpvars(0, cpu_decode_tb);
    end

    logic clk;
    logic reset;
    wire [31:0] instruction_tb;
    logic [4:0] expected_rd, expected_rs1, expected_rs2;
    logic [4:0] actual_rd, actual_rs1, actual_rs2;
    logic[2:0] expected_fucnt3, actual_funct3;
    
    
    cpu DUT (
        .clk (clk),
        .reset(reset),
        .instruction (instruction_tb)
    );

    always #5 clk = ~clk;
    initial begin
        clk = 0;

       //ADD x3, x2, x1
        DUT.Instr_Mem_Module.instr_memory[0] = 32'h001101b3;
        //SUB x3, x2, x1
        DUT.Instr_Mem_Module.instr_memory[1] = 32'h401101b3;
        //AND x3, x2, x1
        DUT.Instr_Mem_Module.instr_memory[2] = 32'h001171b3;
        //OR x3, x2, x1
        DUT.Instr_Mem_Module.instr_memory[3] = 32'h001161b3;

        reset = 1;

        @(posedge clk); //pc =0, check rd, rs1, rs2
        #1
        //check
        actual_rd = DUT.Decode_Module.reg_dest;
        actual_rs1 = DUT.Decode_Module.reg_source1;
        actual_rs2 = DUT.Decode_Module.reg_source2;
        actual_funct3 = DUT.Decode_Module.instr_funct3;
        expected_rd = 5'd3;
        expected_rs1 = 5'd2;
        expected_rs2 = 5'd1;
        expected_fucnt3 = 3'd0;
        if ((actual_rd == expected_rd) && (actual_rs1 == expected_rs1) && (actual_rs2 == expected_rs2)&& (expected_fucnt3 == actual_funct3)) begin 
            $display("PASS: ADD x3, x2, x1 when PC = 0");
        end else begin 
            $display("FAIL: RD - expected: %0b | actual: %0b \n RS1 - expected: %0b | actual: %0b \n RS2 - expected: %0b | actual: %0b \n FUNCT3 - expeced: %0b | actual: %0b",
            expected_rd, actual_rd, expected_rs1, actual_rs1, expected_rs2, actual_rs2, expected_fucnt3, actual_funct3);
        end

        reset = 0;
        @(posedge clk); //pc = 4
        #1 
        actual_rd = DUT.Decode_Module.reg_dest;
        actual_rs1 = DUT.Decode_Module.reg_source1;
        actual_rs2 = DUT.Decode_Module.reg_source2;
        actual_funct3 = DUT.Decode_Module.instr_funct3;
        expected_rd = 5'd3;
        expected_rs1 = 5'd2;
        expected_rs2 = 5'd1;
        expected_fucnt3 = 3'd0;
        if ((actual_rd == expected_rd) && (actual_rs1 == expected_rs1) && (actual_rs2 == expected_rs2)&& (expected_fucnt3 == actual_funct3)) begin 
            $display("PASS: ADD x3, x2, x1 when PC = 4");
        end else begin 
            $display("FAIL: RD - expected: %0b | actual: %0b \n RS1 - expected: %0b | actual: %0b \n RS2 - expected: %0b | actual: %0b \n FUNCT3 - expeced: %0b | actual: %0b",
            expected_rd, actual_rd, expected_rs1, actual_rs1, expected_rs2, actual_rs2, expected_fucnt3, actual_funct3);
        end

        @(posedge clk); //pc = 8
        #1 
        actual_rd = DUT.Decode_Module.reg_dest;
        actual_rs1 = DUT.Decode_Module.reg_source1;
        actual_rs2 = DUT.Decode_Module.reg_source2;
        actual_funct3 = DUT.Decode_Module.instr_funct3;
        expected_rd = 5'd3;
        expected_rs1 = 5'd2;
        expected_rs2 = 5'd1;
        expected_fucnt3 = 3'd7;
        if ((actual_rd == expected_rd) && (actual_rs1 == expected_rs1) && (actual_rs2 == expected_rs2)&& (expected_fucnt3 == actual_funct3)) begin 
            $display("PASS: ADD x3, x2, x1 when PC = 8");
        end else begin 
            $display("FAIL: RD - expected: %0b | actual: %0b \n RS1 - expected: %0b | actual: %0b \n RS2 - expected: %0b | actual: %0b \n FUNCT3 - expeced: %0b | actual: %0b",
            expected_rd, actual_rd, expected_rs1, actual_rs1, expected_rs2, actual_rs2, expected_fucnt3, actual_funct3);
        end

        @(posedge clk); //pc = 12
        #1
        actual_rd = DUT.Decode_Module.reg_dest;
        actual_rs1 = DUT.Decode_Module.reg_source1;
        actual_rs2 = DUT.Decode_Module.reg_source2;
        actual_funct3 = DUT.Decode_Module.instr_funct3;
        expected_rd = 5'd3;
        expected_rs1 = 5'd2;
        expected_rs2 = 5'd1;
        expected_fucnt3 = 3'd6;
        if ((actual_rd == expected_rd) && (actual_rs1 == expected_rs1) && (actual_rs2 == expected_rs2)&& (expected_fucnt3 == actual_funct3)) begin 
            $display("PASS: ADD x3, x2, x1 when PC = 12");
        end else begin 
            $display("FAIL: RD - expected: %0b | actual: %0b \n RS1 - expected: %0b | actual: %0b \n RS2 - expected: %0b | actual: %0b \n FUNCT3 - expeced: %0b | actual: %0b",
            expected_rd, actual_rd, expected_rs1, actual_rs1, expected_rs2, actual_rs2, expected_fucnt3, actual_funct3);
        end
        $finish;
    end

endmodule 