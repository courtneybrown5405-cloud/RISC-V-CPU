module cpu (
    input logic clk,
    input logic [31:0] instruction
    
);

logic [31:0] alu_result;
logic [31:0] alu_op_a;
logic [31:0] alu_op_b;
logic write_en;
logic [4:0] rd, rs1, rs2;
logic [6:0] instr_opcode, instr_fct7;
logic [2:0] instr_fct3;
logic alu_opcode_t alu_operation;

register_file Register_File_Module (
    .clk (clk),
    .reg_source1 (rs1),
    .reg_source2 (rs2),
    .reg_dest (rd),
    .reg_write (write_en),
    .write_data (alu_result),
    .read_data1 (alu_op_a),
    .read_data2 (alu_op_b)
);

alu ALU_Module (
    .alu_result (alu_result),
    .alu_operation (alu_operation),
    .operand_a (alu_op_a),
    .operand_b (alu_op_b)
);

decode Decode_Module (
    .instr (instruction),
    .instr_opcode (instr_opcode),
    .reg_dest (rd),
    .reg_source1 (rs1), 
    .reg_source2 (rs2),
    .instr_funct3 (instr_fct3),
    .instr_funct7 (instr_fct7)
);

control_unit Control_Unit_Module (
    .instr_opcode (instr_opcode),
    .instr_funct3 (instr_fct3),
    .instr_funct7 (instr_fct7),
    .alu_operation (alu_operation),
    .reg_write (write_en)
);

endmodule