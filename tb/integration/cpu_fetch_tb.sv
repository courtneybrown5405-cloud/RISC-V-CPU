module cpu_fetch_tb;
    initial begin
        $dumpfile("cpu_fetch.vcd");
        $dumpvars(0, cpu_fetch_tb);
    end

    logic clk;
    logic reset;
    wire [31:0] instruction_tb;
    logic [31:0] expected_pc;
    logic [31:0] expected_instr;
    logic [31:0] actual_pc;
    logic [31:0] actual_instr;

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

        @(posedge clk);
        #1
        //check
        actual_pc = DUT.PC_Module.pc;
        actual_instr = instruction_tb;
        expected_pc = 32'd0;
        expected_instr = 32'h001101b3;
        if(actual_pc == expected_pc && actual_instr==expected_instr) begin
            $display("PASS: Reset Case");
        end else begin 
            $display("FAIL: PC - expected: %0d | actual: %0d \n Instr - expected: %0b | actual: %0b",
            expected_pc, actual_pc, expected_instr, actual_instr);
        end

        reset = 0;
        @(posedge clk);
        #1
        //check
        actual_pc = DUT.PC_Module.pc;
        actual_instr = instruction_tb;
        expected_pc = 32'd4;
        expected_instr = 32'h401101b3;
        if(actual_pc == expected_pc && actual_instr==expected_instr) begin
            $display("PASS: PC = 4");
        end else begin 
            $display("FAIL: PC - expected: %0d | actual: %0d \n Instr - expected: %0b | actual: %0b",
            expected_pc, actual_pc, expected_instr, actual_instr);
        end

        @(posedge clk);
        #1
        //check
        actual_pc = DUT.PC_Module.pc;
        actual_instr = instruction_tb;
        expected_pc = 32'd8;
        expected_instr = 32'h001171b3;
        if(actual_pc == expected_pc && actual_instr==expected_instr) begin
            $display("PASS: PC = 8");
        end else begin 
            $display("FAIL: PC - expected: %0d | actual: %0d \n Instr - expected: %0b | actual: %0b",
            expected_pc, actual_pc, expected_instr, actual_instr);
        end

        @(posedge clk);
        #1
        //check
        actual_pc = DUT.PC_Module.pc;
        actual_instr = instruction_tb;
        expected_pc = 32'd12;
        expected_instr = 32'h001161b3;
        if(actual_pc == expected_pc && actual_instr==expected_instr) begin
            $display("PASS: PC = 12");
        end else begin 
            $display("FAIL: PC - expected: %0d | actual: %0d \n Instr - expected: %0b | actual: %0b",
            expected_pc, actual_pc, expected_instr, actual_instr);
        end
        $finish;
    end
endmodule