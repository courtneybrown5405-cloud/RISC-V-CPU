module program_counter (
    input wire clk,
    input wire reset,
    output reg [31:0] pc
);

always @(posedge clk) begin
    if (reset)
        pc <= 32'h00000000;
    else
        pc <= pc + 32'd4;
end

endmodule