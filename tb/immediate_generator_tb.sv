`timescale 1ns/1ns
module immd_gen_tb;
    initial begin 
        $dumpfile("immd_gen.vcd");
        $dumpvars(0, immd_gen_tb);
    end

logic [31:0] instr_tb;
logic signed [31:0] immd_tb;
logic signed [31:0] expected;

immediate_generator IMMD_GEN (
    .immediate(immd_tb),
    .instruction(instr_tb)
);

initial begin 
    $display("-------Starting Test ------");

    //ADDI x1, x2, 5
    instr_tb = 32'h00510093;
    expected = 32'd5;
    #1
    if (expected == immd_tb) begin
        $display("PASS: ADDI x1, x2, 5");
    end else begin
        $display("FAIL ADDI x1, x2, 5: expected - %b | actual - %b\n", expected, immd_tb);
    end 

    //XORI x1, x2, -6
    instr_tb = 32'hffa14093;
    expected = -32'd6;
    #1
    if (expected == immd_tb) begin
        $display("PASS: XORI x1, x2, -6");
    end else begin
        $display("FAIL XORI x1, x2, -6: expected - %b | actual - %b\n", expected, immd_tb);
    end 

    //ORI x1, x2, 0
    instr_tb = 32'h00016093;
    expected = 32'd0;
    #1
    if (expected == immd_tb) begin
        $display("PASS: ORI x1, x2, 0");
    end else begin 
        $display("FAIL ORI x1, x2, 0: expected - %b | actual - %b\n", expected, immd_tb);
    end 

    //ANDI x1, x2, 2047
    instr_tb = 32'h7ff17093;
    expected = 32'd2047;
    #1
    if (expected == immd_tb) begin
        $display("PASS: ANDI x1, x2, 2047");
    end else begin 
        $display("FAIL ANDI x1, x2, 2047: expected - %b | actual - %b\n", expected, immd_tb);
    end 

    //ADDI x1, x2, -2047
    instr_tb = 32'h80110093;
    expected = -32'd2047;
    #1
    if (expected == immd_tb) begin
        $display("PASS: ADDI x1, x2, -2047");
    end else begin 
        $display("FAIL ADDI x1, x2, -2047: expected - %b | actual - %b\n", expected, immd_tb);
    end 

    //and x1, x2, x3 DEFAULT CASE
    instr_tb = 32'h003170b3;
    expected = 32'd0;
    #1
    if (expected == immd_tb) begin
        $display("PASS: AND x1, x2, x3");
    end else begin 
        $display("FAIL AND x1, x2, x3: expected - %b | actual - %b\n", expected, immd_tb);
    end 
    $display("-------Test Complete-------");
    $finish;
    
end

endmodule