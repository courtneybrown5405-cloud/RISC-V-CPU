`timescale 1ns/1ns
module program_counter_tb;
    initial begin
        $dumpfile("program_counter.vcd");
        $dumpvars(0, program_counter_tb);
    end
    reg tb_clk;
    reg tb_reset;
    wire [31:0] tb_pc;

    program_counter pc_instance (
        .clk (tb_clk),
        .reset (tb_reset),
        .pc (tb_pc)
    );

    initial begin
        tb_clk = 0;
    end

    always begin
        #5 tb_clk = ~tb_clk;
    end

    initial begin
        tb_reset = 1;
        #10
        tb_reset = 0;
        #40
        tb_reset = 1;
        #20
        tb_reset = 0;
        #30
        $finish;
    end
endmodule