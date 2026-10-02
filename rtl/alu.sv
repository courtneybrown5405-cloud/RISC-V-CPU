import cpu_types::*;
module alu (
    input logic [31:0] operand_a, //from regfile
    input logic [31:0] operand_b, //from regfile
    input alu_opcode_t alu_operation, // from control unit

    output logic [31:0] alu_result
);

always_comb begin
    case(alu_operation)
        //Arithmetic 
        ALU_ADD: begin
            alu_result = operand_a + operand_b;
        end
        ALU_SUB: begin
            alu_result = operand_a - operand_b;
        end

        //Logic
        ALU_AND: begin
            alu_result = operand_a & operand_b;
        end
        ALU_OR: begin
            alu_result = operand_a | operand_b;
        end
        ALU_XOR: begin
            alu_result = operand_a ^ operand_b;
        end

        //Shifts
        ALU_SLL: begin
            alu_result = operand_a << (operand_b[4:0]);
        end
        ALU_SRL: begin
            alu_result = operand_a >> (operand_b[4:0]);
        end
        ALU_SRA: begin
            alu_result = ($signed(operand_a)) >>> (operand_b[4:0]);
        end

        //Comparisons
        ALU_SLT: begin
            alu_result = ($signed(operand_a) < $signed(operand_b)) ? 1 : 0;
        end
        ALU_SLTU: begin
            alu_result = (operand_a < operand_b) ? 1 : 0;
        end

        default: begin
            alu_result = 0;
        end

    endcase
end

endmodule 