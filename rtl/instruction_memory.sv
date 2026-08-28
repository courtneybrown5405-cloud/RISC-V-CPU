module instruction_memory (
    input logic [31:0] pc,
    output logic [31:0] instruction
);

logic [31:0] instr_memory [0:31];

always_comb begin
    instruction = instr_memory[pc[31:2]];
end
endmodule