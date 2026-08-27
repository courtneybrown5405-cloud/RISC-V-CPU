IVERILOG = iverilog

CPU_RTL = rtl/cpu_types.sv \
 rtl/alu.sv \
 rtl/register_file.sv \
 rtl/decode.sv \
 rtl/control_unit.sv \
 rtl/cpu.sv

CPU_TB = tb/cpu_tb.sv

cpu_sim: $(CPU_RTL) $(CPU_TB)
	$(IVERILOG) -g2012 -o cpu_sim $@ $^

run: cpu_sim
	vvp $<