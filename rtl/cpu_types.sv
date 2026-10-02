package cpu_types;
    typedef enum logic [3:0] {
    //Arithmetic
    ALU_NOP = 4'b0000,
    ALU_ADD = 4'b0001,
    ALU_SUB = 4'b0010,

    //Logic
    ALU_AND = 4'b0011,
    ALU_OR  = 4'b0100,
    ALU_XOR = 4'b0101,

    //Shifts
    ALU_SLL = 4'b0110,
    ALU_SRL = 4'b0111,
    ALU_SRA = 4'b1000,

    //Comparisons
    ALU_SLT = 4'b1001,
    ALU_SLTU = 4'b1010

} alu_opcode_t;

typedef enum logic [6:0] {
    //TODO: Add R-type instruction encoding for opcode 
    OPCODE_R_TYPE = 7'b0110011
} instruction_opcode_t;
endpackage
