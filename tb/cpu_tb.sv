module cpu_tb;
    logic clk;
    logic [31:0] instruction;

    cpu DUT (
        .clk (clk),
        .instruction (instruction)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        instruction = 32'b0;

        DUT.Register_File_Module.reg_file[1] = 32'd10;
        DUT.Register_File_Module.reg_file[2] = 32'd20;
        instruction = 32'b00000000001000001000000110110011;
        $display("Starting CPU test...");
        #5

        // $display("rs1 = %0d", DUT.rs1);
        // $display("rs2 = %0d", DUT.rs2);
        // $display("rd = %0d", DUT.rd);
        // $display("ALU A = %0d", DUT.alu_op_a);
        // $display("ALU B = %0d", DUT.alu_op_b);
        // $display("ALU result = %0d", DUT.alu_result);
        // $display("reg_write = %b", DUT.write_en);
        // $display("CPU rd = %0d", DUT.rd);
        // $display("x3 before write = %0d", DUT.Register_File_Module.reg_file[3]);
        #5
        // $display("x3 before after = %0d", DUT.Register_File_Module.reg_file[3]);
        if (DUT.alu_result == 32'd30 && DUT.Register_File_Module.reg_file[3] == 32'd30) begin
            $display("PASS: ADD x1, x2, x3");
        end else begin
            $display("FAIL: expected 30, got %d", DUT.alu_result);
        end
        $finish;
    end
endmodule