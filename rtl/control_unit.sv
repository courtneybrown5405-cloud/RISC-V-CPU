import cpu_types::*;
module control_unit (
    //Get From Decode
    input logic [6:0] instr_opcode,
    input logic [2:0] instr_funct3,
    input logic [6:0] instr_funct7,

    output alu_opcode_t alu_operation,
    output logic reg_write,
    output logic alu_src,
);

always @(*) begin
    case(instr_opcode)
        OPCODE_R_TYPE: begin
            reg_write = 1'b1;
            alu_src = 1'b0;
            case({instr_funct7, instr_funct3})
                10'b0000000_000: alu_operation = ALU_ADD;
                10'b0100000_000: alu_operation = ALU_SUB;
                10'b0000000_100: alu_operation = ALU_XOR;
                10'b0000000_110: alu_operation = ALU_OR;
                10'b0000000_111: alu_operation = ALU_AND;
                10'b0000000_001: alu_operation = ALU_SLL;
                10'b0000000_101: alu_operation = ALU_SRL;
                10'b0100000_101: alu_operation = ALU_SRA;
                10'b0000000_010: alu_operation = ALU_SLT;
                10'b0000000_011: alu_operation = ALU_SLTU;
            endcase
        end
        OPCODE_I_TYPE: begin
            reg_write = 1'b1;
            alu_src = 1'b1;
            case(instr_funct3)
                3'b000: alu_operation = ALU_ADD;
                3'b100: alu_operation = ALU_XOR;
                3'b110: alu_operation = ALU_OR;
                3'b111: alu_operation = ALU_AND;
                3'b001: begin
                    if (instr_funct7 == 7'b0000000) begin
                        alu_operation = ALU_SLL;
                    end
                end
                3'b101: begin
                    if (instr_funct7 == 7'b0000000) begin
                        alu_operation = ALU_SRL;
                    end else if (instr_funct7 == 7'b0100000)begin
                        alu_operation = ALU_SRA;

                    end
                end
                3'b010: alu_operation = ALU_SLT;
                3'b011: alu_operation = ALU_SLTU;
            endcase
        end
    endcase 
end
endmodule 