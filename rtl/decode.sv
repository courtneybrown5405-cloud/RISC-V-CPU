
import cpu_types::*;
module decode (
    input logic [31:0] instr,

    output logic [6:0] instr_opcode,
    output logic [4:0] reg_dest, reg_source1, reg_source2,
    output logic [2:0] instr_funct3,
    output logic [6:0] instr_funct7
);

always_comb begin
    instr_opcode = instr[6:0];

    reg_dest = 0;
    reg_source1 = 0;
    reg_source2 = 0;
    instr_funct3 = 0;
    instr_funct7 = 0;

    case (instr_opcode)
        OPCODE_R_TYPE: begin
            reg_dest = instr[11:7];
            reg_source1 = instr[19:15];
            reg_source2 = instr[24:20];
            instr_funct3 = instr[14:12];
            instr_funct7 = instr[31:25];
        end 
    endcase
end
endmodule