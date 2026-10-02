IVERILOG = iverilog

CPU_RTL = rtl/cpu_types.sv \
 rtl/alu.sv \
 rtl/register_file.sv \
 rtl/decode.sv \
 rtl/control_unit.sv \
 rtl/program_counter.sv \
 rtl/instruction_memory.sv \
 rtl/cpu.sv

CPU_TB = tb/cpu_tb.sv
CPU_FETCH_TB = tb/integration/cpu_fetch_tb.sv

cpu_sim: $(CPU_RTL) $(CPU_TB)
	$(IVERILOG) -g2012 -o $@ $^

run: cpu_sim
	vvp $<

wave: run
	gtkwave cpu.vcd

cpu_fetch: $(CPU_RTL) $(CPU_FETCH_TB)
	$(IVERILOG) -g2012 -o cpu_fetch_sim $^
	vvp cpu_fetch_sim