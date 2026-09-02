IVERILOG = iverilog

CPU_RTL = rtl/cpu_types.sv \
 rtl/alu.sv \
 rtl/register_file.sv \
 rtl/decode.sv \
 rtl/control_unit.sv \
 rtl/program_counter.sv \
 rtl/instruction_memory.sv \
 rtl/cpu.sv

CPU_RTYPE_TB = tb/integration/cpu_rtype_tb.sv
CPU_FETCH_TB = tb/integration/cpu_fetch_tb.sv
CPU_DECODE_TB = tb/integration/cpu_decode_tb.sv
SIM_DIR = sim

cpu_sim: $(CPU_RTL) $(CPU_TB)
	mkdir -p $(SIM_DIR)
	$(IVERILOG) -g2012 -o $@ $^

wave: cpu_rtype
	gtkwave cpu_rtype.vcd


cpu_fetch: $(CPU_RTL) $(CPU_FETCH_TB)
	mkdir -p $(SIM_DIR)
	$(IVERILOG) -g2012 -o $(SIM_DIR)/cpu_fetch_sim $^
	vvp $(SIM_DIR)/cpu_fetch_sim

cpu_decode: $(CPU_RTL) $(CPU_DECODE_TB)
	mkdir -p $(SIM_DIR)
	$(IVERILOG) -g2012 -o $(SIM_DIR)/cpu_decode_sim $^
	vvp $(SIM_DIR)/cpu_decode_sim

cpu_rtype: $(CPU_RTL) $(CPU_RTYPE_TB)
	mkdir -p $(SIM_DIR)
	$(IVERILOG) -g2012 -o $(SIM_DIR)/cpu_decode_sim $^
	vvp $(SIM_DIR)/cpu_rtype_sim