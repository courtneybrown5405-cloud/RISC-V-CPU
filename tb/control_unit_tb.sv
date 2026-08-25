`timescale 1ns/1ns
module control_unit_tb;
    initial begin
        $dumpfile("control_unit_tb.vcd");
        $dumpvars(0, control_unit_tb);
    end

    logic [6:0] instr_opcode_tb;
    logic [2:0] instr_funct3_tb;
    logic [6:0] instr_funct7_tb;
    alu_opcode_t alu_operation_tb;
    logic reg_write_tb;

    control_unit control_unit_instance (
        .instr_opcode (instr_opcode_tb),
        .instr_funct3 (instr_funct3_tb),
        .instr_funct7 (instr_funct7_tb),

        .alu_operation (alu_operation_tb),
        .reg_write (reg_write_tb)
    );

    initial begin
        instr_opcode_tb = 7'b0110011;
        instr_funct7_tb = 7'b0000000;
        instr_funct3_tb = 3'b000;
        #2
        //0001 (ADD), 1
        $display("ALU_OP = %b | reg_write = %b", alu_operation_tb, reg_write_tb); 

        instr_opcode_tb = 7'b0110011;
        instr_funct7_tb = 7'b0100000;
        instr_funct3_tb = 3'b000;
        #2
        //0010 (SUB), 1
        $display("ALU_OP = %b | reg_write = %b", alu_operation_tb, reg_write_tb);

        instr_opcode_tb = 7'b0110011;
        instr_funct7_tb = 7'b0000000;
        instr_funct3_tb = 3'b100;
        #2
        //0101(XOR), 1
        $display("ALU_OP = %b | reg_write = %b", alu_operation_tb, reg_write_tb);

        instr_opcode_tb = 7'b0110011;
        instr_funct7_tb = 7'b0000000;
        instr_funct3_tb = 3'b110;
        #2
        //0100 (OR), 1
        $display("ALU_OP = %b | reg_write = %b", alu_operation_tb, reg_write_tb);

        instr_opcode_tb = 7'b0110011;
        instr_funct7_tb = 7'b0000000;
        instr_funct3_tb = 3'b111;
        #2
        //0011 (AND), 1
        $display("ALU_OP = %b | reg_write = %b", alu_operation_tb, reg_write_tb);
    end
endmodule
