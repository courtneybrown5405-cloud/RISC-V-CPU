`timescale 1ns/1ns
module decode_tb;
    initial begin
        $dumpfile("decode.vcd");
        $dumpvars(0,decode_tb);
    end

    logic [31:0] instr_tb;
    logic [6:0] instr_opcode_tb;
    logic [4:0] reg_dest_tb, reg_source1_tb, reg_source2_tb;
    logic [2:0] instr_funct3_tb;
    logic [6:0] instr_funct7_tb;

    decode decode_instance (
        .instr (instr_tb),
        .instr_opcode (instr_opcode_tb),
        .reg_dest (reg_dest_tb),
        .reg_source1 (reg_source1_tb),
        .reg_source2 (reg_source2_tb),
        .instr_funct3 (instr_funct3_tb),
        .instr_funct7 (instr_funct7_tb)
    );

    initial begin
        instr_tb = 32'b01000000001100010000000010110011; //sub x1, x2, x3
        #2
        $display("----R-Type Decode Test ---- \n Instruction: %b \n Opcode: %b \n rd: %b \n rs1 %b \n rs2 %b \n funct3: %b \n funct7: %b \n",
        instr_tb, instr_opcode_tb, reg_dest_tb, reg_source1_tb, reg_source2_tb, 
        instr_funct3_tb, instr_funct7_tb);

        instr_tb = 32'b00000000001100010110000010110011; //or x1, x2, x3
        #2
        $display("----R-Type Decode Test ---- \n Instruction: %b \n Opcode: %b \n rd: %b \n rs1 %b \n rs2 %b \n funct3: %b \n funct7: %b \n",
        instr_tb, instr_opcode_tb, reg_dest_tb, reg_source1_tb, reg_source2_tb, 
        instr_funct3_tb, instr_funct7_tb);
        
        instr_tb = 32'b00000000001100010101000010110011; //srl x1, x2, x3
        #2
        $display("----R-Type Decode Test ---- \n Instruction: %b \n Opcode: %b \n rd: %b \n rs1 %b \n rs2 %b \n funct3: %b \n funct7: %b \n",
        instr_tb, instr_opcode_tb, reg_dest_tb, reg_source1_tb, reg_source2_tb, 
        instr_funct3_tb, instr_funct7_tb);
        
        instr_tb = 32'b00000000001100010010000010110011; //slt x1, x2, x3
        #2
        $display("----R-Type Decode Test ---- \n Instruction: %b \n Opcode: %b \n rd: %b \n rs1 %b \n rs2 %b \n funct3: %b \n funct7: %b \n",
        instr_tb, instr_opcode_tb, reg_dest_tb, reg_source1_tb, reg_source2_tb, 
        instr_funct3_tb, instr_funct7_tb);
        $finish;
    end

endmodule