# vim: set tabstop=2 shiftwidth=2 softtabstop=2 noexpandtab nu:
import random
import cocotb
from cocotb.triggers import RisingEdge, Timer
from cocotb.clock    import Clock

def rand(width):
	return int(random.random() * pow(2,width))-1

async def run(dut, period):
	width = dut.WIDTH.value
	data_in = [ rand(width), rand(width) ]
	dut.data_in = ( data_in[1] << width ) | data_in[0]
	await Timer(period/10, units="ns")
	selects = [0, 1, 0]
	for s in selects:
		dut.sel = s
		await Timer(period/10, units="ns")
		if( dut.REGISTERED.value == 0 ):
			check = [ int(dut.data_out.value), data_in[s] ]
			assert check[0] == check[1], f"{hex(check[0])} != {hex(check[1])}"
		for _ in range(2):
			await RisingEdge(dut.clk)

@cocotb.test()
async def test_bench(dut):
	dut._log.info("Starting test")
	period = 10
	cocotb.start_soon(Clock(dut.clk, period, units="ns").start())
	await run(dut, period) #Run asynch
