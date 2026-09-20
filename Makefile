TOPLEVEL_LANG = verilog
VERILOG_SOURCES = mux.sv
TOPLEVEL=mux
MODULE=test_bench

SIM=verilator
EXTRA_ARGS += --trace

include $(shell cocotb-config --makefiles)/Makefile.sim

VIVADO_CFG=/tools/Xilinx/2025.1/Vivado/settings64.sh
PART=xcau10p-ubva368-1-e
VIVADO=vivado -mode batch
diagram.pdf: synth_diagram.tcl mux.sv
	bash -c "source $(VIVADO_CFG) && $(VIVADO) -source $< -tclargs mux.v $(PART) $@"

#You have to open a gui instance of vivado for this to work
#Actually, I cant get this to work without doing the whole thing from inside vivado
list-parts:
	bash -c "source /tools/Xilinx/2025.1/Vivado/settings64.sh && \
	vivado -mode batch -source list-parts.tcl"
