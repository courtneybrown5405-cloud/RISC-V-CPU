module cpu_rtype_tb;
    initial begin
        $dumpfile("sim/cpu.vcd");
        $dumpvars(0, cpu_rtype_tb);
    end

    logic clk;
    logic reset;
    wire [31:0] instruction_tb;
    logic [31:0] actual;
    logic [31:0] expected;
    integer instr_index = 0;

    cpu DUT (
        .clk (clk),
        .instruction (instruction_tb),
        .reset(reset)
    );

    always #5 clk = ~clk;

    task test_r_type(
        input [4:0]  rs1,
        input [4:0]  rs2,
        input [4:0]  rd,
        input [31:0] value1,
        input [31:0] value2,
        input [31:0] instr,
        input [31:0] expected_value,
        input string name
    );

    begin
        DUT.Register_File_Module.reg_file[rs1] = value1;
        DUT.Register_File_Module.reg_file[rs2] = value2;
        DUT.Instr_Mem_Module.instr_memory[instr_index] = instr;
        expected = expected_value;
        @(posedge clk);
        #1
        actual =  DUT.Register_File_Module.reg_file[rd];
        if (expected == actual) begin
            $display("PASS: %s x%0d, x%0d, x%0d", name, rd, rs1, rs2);
        end else begin
            $display("FAIL: alu_op: %b  | %s | expected: %0d | got: %0d", DUT.Control_Unit_Module.alu_operation, name, expected, actual);
        end
        instr_index++;
    end    
    endtask

    initial begin
        clk = 0;
        instr_index = 0;
        reset = 1;

        @(posedge clk);
        #1
        reset = 0;

        $display("Starting CPU Test..");

        //ADD x3, x1, x2
        test_r_type(
            5'd1,
            5'd2,
            5'd3,
            32'd10,
            32'd20,
            32'h001101b3,
            32'd30,
            "ADD"
        );


        //SUB x3, x1, x2
        test_r_type(
            5'd1,
            5'd2,
            5'd3,
            32'd20,
            32'd10,
            32'h402081b3,
            32'd10,
            "SUB"
        );
        
        //AND x4, x1, x2
        test_r_type(
            5'd1,
            5'd2,
            5'd4,
            32'b1100,
            32'b1010,
            32'h0020f233,
            32'b1000,
            "AND"
        );
        
        //OR x4, x1, x2
        test_r_type(
            5'd1,
            5'd2,
            5'd4,
            32'b1100,
            32'b1010,
            32'h0020e233,
            32'b1110,
            "OR"
        );


        //XOR x4, x1, x2
        test_r_type(
            5'd1,
            5'd2,
            5'd4,
            32'b1100,
            32'b1010,
            32'h0020c233,
            32'b0110,
            "XOR"
        );
        
        //SLL x6, x7, x8
        test_r_type(
            5'd7,
            5'd8,
            5'd6,
            32'b0010,
            32'b0010,
            32'h00839333,
            32'b1000,
            "SLL"
        );
        
        //SRL x6, x7, x8
        test_r_type(
            5'd7,
            5'd8,
            5'd6,
            32'b1000,
            32'b0011,
            32'h0083d333,
            32'b0001,
            "SRL"
        );

        //SRA x6, x7, x8
        test_r_type(
            5'd7,
            5'd8,
            5'd6,
            32'b1011,
            32'b0100,
            32'h4083d333,
            32'b0000,
            "SRA"
        );

        //SLT x11, x12, x13
        test_r_type(
            5'd12,
            5'd13,
            5'd11,
            -32'sd1,
            32'd1,
            32'h00d625b3,
            32'd1,
            "SLT"
        );
    
        //SLTU x11, x12, x13
        test_r_type(
            5'd12,
            5'd13,
            5'd11,
            32'b1011,
            32'b0100,
            32'h00d635b3,
            32'd0,
            "SLTU"
        );
        $display("CPU Test Complete");
        $finish;
    end
endmodule
