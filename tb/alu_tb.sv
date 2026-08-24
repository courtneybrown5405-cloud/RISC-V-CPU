`timescale 1ns/1ns
module alu_tb;
    initial begin
        $dumpfile("alu.vcd");
        $dumpvars(0, alu_tb);
    end

    logic [31:0] operand_a_tb;
    logic [31:0] operand_b_tb;
    alu_opcode_t alu_operation_tb;
    logic [31:0] alu_result_tb;

    alu alu_instance (
        .operand_a (operand_a_tb),
        .operand_b (operand_b_tb),
        .alu_operation (alu_operation_tb),
        .alu_result (alu_result_tb)
    );

    initial begin
        operand_a_tb = 5;
        operand_b_tb = 3;
        alu_operation_tb = ALU_ADD; //8
        #10
        operand_a_tb = 5;
        operand_b_tb = 2;
        alu_operation_tb = ALU_SUB; //3
        #10
        operand_a_tb = 4'b1111;
        operand_b_tb = 4'b1000;
        alu_operation_tb = ALU_AND; //1000
        #10
        operand_a_tb = 4'b0010;
        operand_b_tb = 4'b0011;
        alu_operation_tb = ALU_OR; //0011
        #10
        operand_a_tb = 4'b1010;
        operand_b_tb = 4'b1111;
        alu_operation_tb = ALU_XOR; //0101
        #10
        operand_a_tb = 8'b10101100; //0A0C
        operand_b_tb = 8'b00000101; //5
        alu_operation_tb = ALU_SLL; //0800
        #10
        operand_a_tb = 8'b10111010; //BA
        operand_b_tb = 8'b00000111; //7
        alu_operation_tb = ALU_SRL; //1
        #10
        operand_a_tb = 8'b10110100; //B4
        operand_b_tb = 8'b00000010; //2
        alu_operation_tb = ALU_SRA; // 2D
        #10
        operand_a_tb = 4'b0000; //0
        operand_b_tb = 4'b0010; //2
        alu_operation_tb = ALU_SLT; //1
        #10
        operand_a_tb = 9'b111110000; //-16
        operand_b_tb = 9'b111101100; //-20
        alu_operation_tb = ALU_SLTU; //0
        #10
        $finish;
    end

endmodule