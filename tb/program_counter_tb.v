module program_counter_tb;
    reg tb_clk,
    reg tb_reset,
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
        #10
        $finish;
    end
endmodule