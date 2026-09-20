TOPLEVEL_LANG = verilog
VERILOG_SOURCES = mux.v
TOPLEVEL=mux
MODULE=test_bench

SIM=verilator
EXTRA_ARGS += --trace

include $(shell cocotb-config --makefiles)/Makefile.sim

diagram: mux.v
	yosys -p "read_verilog -sv $<; synth -top mux; show -format png -prefix $@"
