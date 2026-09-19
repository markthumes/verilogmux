// vim: set tabstop=2 shiftwidth=2 softtabstop=2 noexpandtab nu:
module mux #(
	parameter WIDTH      = 16,
	parameter INPUTS     =  2,
	parameter REGISTERED =  0
)(
	input  wire 				clk,
	input  wire 				rstn,
	input  wire [$clog2(INPUTS)-1:0] 	sel,
	input  wire [         WIDTH-1:0] 	data_in  [0:INPUTS-1],
	output wire [         WIDTH-1:0] 	data_out
);
	generate
		if( !REGISTERED ) begin
			assign data_out = data_in[sel];
		end else begin
			reg [WIDTH-1:0] r_data_out;
			assign data_out = r_data_out;
			always @(posedge clk) r_data_out <= data_in[sel];
		end
	endgenerate
endmodule
