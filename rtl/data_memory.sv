module data_memory(
    input logic clk,
    input logic write_en,
    input logic [31:0] addr, 
    input logic [31:0] write_data,
    output logic [31:0] read_data
);

logic [31:0] data_mem [0:255];

always_ff @( posedge clk ) begin
    if (write_en) begin
        data_mem[addr[9:2]] <= write_data;
    end 
    read_data <= data_mem[addr[9:2]];
end
endmodule