module cpu_itype_tb;
initial begin 
    $dumpfile("cpu_itype.vcd");
    $dumpvars(0, cpu_itype_tb);
end

logic clk;
logic reset;
wire [31:0] instruction_tb;
logic [31:0] actual;
logic [31:0] expected;

cpu DUT (
    .clk (clk),
    .reset(reset),
    .instruction (instruction_tb)
);

always #5 clk = ~clk;

initial begin 
    clk = 0;
    reset = 1;
    //Put ADDI in Instr Mem
    DUT.Instr_Mem_Module.instr_memory[0] = 32'h00510093;
    DUT.Register_File_Module.reg_file[2] = 32'd5;

    //ANDI x2, x3, -5
    DUT.Instr_Mem_Module.instr_memory[1] = 32'hffb1f113;
    DUT.Register_File_Module.reg_file[3] = 32'd5;

    //ORI x5, x6, 3
    DUT.Instr_Mem_Module.instr_memory[2] = 32'h00336293;
    DUT.Register_File_Module.reg_file[6] = 32'd6;
    
    //XORI x7, x8, 11
    DUT.Instr_Mem_Module.instr_memory[3] = 32'h00b44393;
    DUT.Register_File_Module.reg_file[8] = 32'd7;

    //SLI
    //SRLI
    //SRAI
    //gave x2 some value 
    expected = 32'd10;

    @(posedge clk);
    #1
    reset = 0;

    @(posedge clk);
    #1 
    $display("-----Starting I-Type Test ------");
    actual = DUT.Register_File_Module.reg_file[1];
    if (actual == expected) begin 
        $display("PASS: ADDI - pc = %0d", DUT.PC_Module.pc);
    end else begin 
        $display("FAIL ADDI: expected - %0d | actual - %0d", expected, actual);
    end

    @(posedge clk);
    #1
    //ANDI x2, x3, -5
    expected = 32'd1;
    actual = DUT.Register_File_Module.reg_file[2];
    if (actual == expected) begin 
        $display("PASS: ANDI - pc = %0d", DUT.PC_Module.pc);
    end else begin 
        $display("FAIL ANDI: expected - %0d | actual - %0d", expected, actual);
    end

    //ORI x5, x6, 3
    @(posedge clk);
    #1
    expected = 32'd7;
    actual = DUT.Register_File_Module.reg_file[5];
     if (actual == expected) begin 
        $display("PASS: ORI - pc = %0d", DUT.PC_Module.pc);
    end else begin 
        $display("FAIL ORI: expected - %0d | actual - %0d", expected, actual);
    end

    //XORI x7, x8, 11
    @(posedge clk);
    #1
    expected = 32'd12;
    actual = DUT.Register_File_Module.reg_file[7];
    if (actual == expected) begin 
        $display("PASS: XORI - pc = %0d", DUT.PC_Module.pc);
    end else begin 
        $display("FAIL XORI: expected - %0d | actual - %0d", expected, actual);
    end

    $display("-----I-TYPE TEST COMPLETE------");
    $finish;


end

endmodule