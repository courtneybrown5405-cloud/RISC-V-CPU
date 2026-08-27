module cpu_tb;
    initial begin
        $dumpfile("cpu.vcd");
        $dumpvars(0, cpu_tb);
    end

    logic clk;
    logic [31:0] instruction;
    logic [31:0] actual;
    logic [31:0] expected;

    cpu DUT (
        .clk (clk),
        .instruction (instruction)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        instruction = 32'b0;
        $display("Starting CPU Test..");
        //Add x3, x1, x2
        DUT.Register_File_Module.reg_file[1] = 32'd10;
        DUT.Register_File_Module.reg_file[2] = 32'd20;
        instruction = 32'b00000000001000001000000110110011;
        #10
        expected = 32'd30;
        actual = DUT.Register_File_Module.reg_file[3];
        if (expected == actual) begin
            $display("PASS: ADD x1, x2, x3");
        end else begin
            $display("FAIL: expected %d, got %d", expected, actual);
        end

        //SUB x3, x1, x2
        DUT.Register_File_Module.reg_file[1] = 32'd20;
        DUT.Register_File_Module.reg_file[2] = 32'd10;
        instruction = 32'h402081b3;
        #10
        expected = 32'd10;
        actual = DUT.Register_File_Module.reg_file[3];
        if (expected == actual) begin
            $display("PASS: SUB x1, x2, x3");
        end else begin
            $display("FAIL: expected %d, got %d", expected, actual);
        end
        
        //AND x4, x1, x2
        DUT.Register_File_Module.reg_file[1] = 32'b1100;
        DUT.Register_File_Module.reg_file[2] = 32'b1010;
        instruction = 32'h0020f233;
        #10
        expected = 32'b1000;
        actual = DUT.Register_File_Module.reg_file[4];
        if (expected == actual) begin
            $display("PASS: AND x4, x2, x3");
        end else begin
            $display("FAIL: expected %d, got %d", expected, actual);
        end

        //OR x4, x1, x2
        DUT.Register_File_Module.reg_file[1] = 32'b1100;
        DUT.Register_File_Module.reg_file[2] = 32'b1010;
        instruction = 32'h0020e233;
        #10
        expected = 32'b1110;
        actual = DUT.Register_File_Module.reg_file[4];
        if (expected == actual) begin
            $display("PASS: OR x4, x2, x3");
        end else begin
            $display("FAIL: expected %d, got %d", expected, actual);
        end

        //XOR x4, x1, x2
        DUT.Register_File_Module.reg_file[1] = 32'b1100;
        DUT.Register_File_Module.reg_file[2] = 32'b1010;
        instruction = 32'h0020c233;
        #10
        expected = 32'b0110;
        actual = DUT.Register_File_Module.reg_file[4];
        if (expected == actual) begin
            $display("PASS: XOR x4, x2, x3");
        end else begin
            $display("FAIL: expected %d, got %d", expected, actual);
        end
        
        //SLL x6, x7, x8
        DUT.Register_File_Module.reg_file[7] = 32'b0010;
        DUT.Register_File_Module.reg_file[8] = 32'b0010;
        instruction = 32'h00839333;
        #10
        expected = 32'b1000;
        actual = DUT.Register_File_Module.reg_file[6];
        if (expected == actual) begin
            $display("PASS: SLL x6, x7, x8");
        end else begin
            $display("FAIL: expected %d, got %d", expected, actual);
        end

        //SRL x6, x7, x8
        DUT.Register_File_Module.reg_file[7] = 32'b1000;
        DUT.Register_File_Module.reg_file[8] = 32'b0011;
        instruction = 32'h0083d333;
        #10
        expected = 32'b0001;
        actual = DUT.Register_File_Module.reg_file[6];
        if (expected == actual) begin
            $display("PASS: SRL x6, x7, x8");
        end else begin
            $display("FAIL: expected %d, got %d", expected, actual);
        end

        //SRA x6, x7, x8
        DUT.Register_File_Module.reg_file[7] = 32'b1011;
        DUT.Register_File_Module.reg_file[8] = 32'b0100;
        instruction = 32'h4083d333;
        #10
        expected = 32'b0000;
        actual = DUT.Register_File_Module.reg_file[6];
        if (expected == actual) begin
            $display("PASS: SRA x6, x7, x8");
        end else begin
            $display("FAIL: expected %d, got %d", expected, actual);
        end

        //SLT x11, x12, x13
        DUT.Register_File_Module.reg_file[12] = -32'sd1;
        DUT.Register_File_Module.reg_file[13] = 32'd1;
        instruction = 32'h00d625b3;
        #10
        expected = 32'd1;
        actual = DUT.Register_File_Module.reg_file[11];
        if (expected == actual) begin
            $display("PASS: SLT x11, x12, x13");
        end else begin
            $display("FAIL: expected %d, got %d", expected, actual);
        end
        
        //SLTU x11, x12, x13
        DUT.Register_File_Module.reg_file[12] = 32'b1011;
        DUT.Register_File_Module.reg_file[13] = 32'b0100;
        instruction = 32'h00d635b3;
        #10
        expected = 32'd0;
        actual = DUT.Register_File_Module.reg_file[11];
        if (expected == actual) begin
            $display("PASS: SLTU x11, x12, x13");
        end else begin
            $display("FAIL: expected %d, got %d", expected, actual);
        end

        $finish;
    end
endmodule
// $display("rs1 = %0d", DUT.rs1);
// $display("rs2 = %0d", DUT.rs2);
// $display("rd = %0d", DUT.rd);
// $display("ALU A = %0d", DUT.alu_op_a);
// $display("ALU B = %0d", DUT.alu_op_b);
// $display("ALU result = %0d", DUT.alu_result);
// $display("reg_write = %b", DUT.write_en);
// $display("CPU rd = %0d", DUT.rd);
// $display("x3 before write = %0d", DUT.Register_File_Module.reg_file[3]);
// $display("x3 before after = %0d", DUT.Register_File_Module.reg_file[3]);
// $display("x3 before after = %0d", DUT.Register_File_Module.reg_file[3]);