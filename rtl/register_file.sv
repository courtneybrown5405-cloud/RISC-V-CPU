module register_file (
    input logic clk,
    input logic [4:0] reg_source1, //rs1, from decode
    input logic [4:0] reg_source2, //rs2, from decode
    input logic [4:0] reg_dest, //rd, from decode

    input logic [31:0] write_data, //get from ALU
    input logic reg_write, //get from control
    
    output logic [31:0] read_data1,
    output logic [31:0] read_data2
);

//register file array 32 x 32
logic [31:0] reg_file [31:0];

always @(posedge clk ) begin
    //Write Logic
    if (reg_dest != 5'b0 && reg_write) begin
        reg_file[reg_dest] <= write_data;
    end
end

always_comb begin 
    //read logic 
    if (reg_source1 == 5'b0) begin 
        read_data1 = 32'b0;
    end else begin
        read_data1 = reg_file[reg_source1];
    end
    read_data2 = reg_file[reg_source2];
end 
endmodule 