import cpu_types::*;
module immediate_generator (
    input logic [31:0] instruction, //from CPU

    output logic signed [31:0] immediate
);

logic [6:0] opcode;
always_comb begin
    opcode = instruction[6:0];
    case(opcode)
        OPCODE_I_TYPE: begin
            immediate = {{20{instruction[31]}}, instruction[31:20]};
        end
        default: begin 
            immediate = 32'b0;
        end
    endcase

end


endmodule