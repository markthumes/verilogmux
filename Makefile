TOPLEVEL_LANG = verilog
VERILOG_SOURCES = mux.v
TOPLEVEL=mux
MODULE=test_bench

SIM=verilator
EXTRA_ARGS += --trace

include $(shell cocotb-config --makefiles)/Makefile.sim

diagram: mux.v
	yosys -p "read_verilog -sv $<; prep -top mux; write_json mux_rtl.json"
	netlistsvg mux_rtl.json -o mux_rtl.svg
	rsvg-convert -d 300 -p 300 mux_rtl.svg -o $@.png
