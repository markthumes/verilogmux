// vim: set tabstop=2 shiftwidth=2 softtabstop=2 noexpandtab nu:
module mux #(
	parameter WIDTH      = 16,
	parameter INPUTS     =  2,
	parameter REGISTERED =  0
)(
	input  wire 				clk,
	input  wire 				rstn,
	input  wire [$clog2(INPUTS)-1:0] 	sel,
	input  wire [(INPUTS*WIDTH)-1:0] 	data_in,
	output wire [         WIDTH-1:0] 	data_out
);
	generate
		if( !REGISTERED ) begin
			assign data_out = data_in[WIDTH*(32'(sel)+1)-1 -: WIDTH];
		end else begin
			reg [WIDTH-1:0] r_data_out;
			assign data_out = r_data_out;
			always @(posedge clk) begin
				if( !rstn ) r_data_out <= {WIDTH{1'b0}};
				else        r_data_out <= data_in[sel];
			end
		end
	endgenerate
endmodule
