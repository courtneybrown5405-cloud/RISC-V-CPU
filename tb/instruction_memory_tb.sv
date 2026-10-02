`timescale 1ns/1ns
module instruction_memory_tb;
    initial begin
        $dumpfile("instruction_memory.vcd");
        $dumpvars(0, instruction_memory_tb);
    end

    logic [31:0] pc_tb;
    logic [31:0] instr_tb;

    instruction_memory DUT (
        .pc(pc_tb),
        .inst(instr_tb)
    );

    initial begin
        pc_tb = 0;

        //load instr
        //ADD x3, x2, x1
        DUT.instr_memory[0] = 32'h001101b3;
        //SUB x3, x2, x1
        DUT.instr_memory[1] = 32'h401101b3;
        //AND x3, x2, x1
        DUT.instr_memory[2] = 32'h001171b3;
        //OR x3, x2, x1
        DUT.instr_memory[3] = 32'h001161b3;
        #5

        pc_tb = 32'd0;
        #5
        if (instr_tb == 32'h001101b3) begin
            $display("PASS: ADD x1, x3, x2");
        end else begin
            $display("FAIL: expected: %0h | actual: %0h",32'h001101b3, instr);
        end
        #5

        pc_tb+= 32'd4;
        #5
        if (instr_tb == 32'h401101b3) begin
            $display("PASS: SUB x1, x3, x2");
        end else begin
            $display("FAIL: expected: %0h | actual: %0h", 32'h401101b3, instr);
        end
        #5

        pc_tb +=32'd4;
        #5
        if (instr_tb == 32'h001171b3) begin
            $display("PASS: AND x1, x3, x2");
        end else begin
            $display("FAIL: expected: %0h | actual: %0h", 32'h001171b3, instr);
        end
        #5

        pc_tb+= 32'd4;
        #5
        if (instr_tb == 32'h001161b3) begin
            $display("PASS: OR x1, x3, x2");
        end else begin
            $display("FAIL: expected: %0h | actual: %0h", 32'h001161b3, instr);
        end
        $finish;
    end

endmodule