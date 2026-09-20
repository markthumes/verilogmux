// vim: set tabstop=2 shiftwidth=2 softtabstop=2 noexpandtab nu:
module mux #(
	parameter WIDTH      = 16,
	parameter INPUTS     =  2,
	parameter REGISTERED =  0
)(
	input  logic 				clk,
	input  logic 				rstn,
	input  logic [$clog2(INPUTS)-1:0] 	sel,
	input  logic [         WIDTH-1:0] 	data_in  [0:INPUTS-1],
	output logic [         WIDTH-1:0] 	data_out
);
	generate
		if( !REGISTERED ) begin
			assign data_out = data_in[sel];
		end else begin
			logic [WIDTH-1:0] r_data_out;
			assign data_out = r_data_out;
			always_ff @(posedge clk) begin
				if( !rstn ) r_data_out <= {WIDTH{1'b0}};
				else        r_data_out <= data_in[sel];
			end
		end
	endgenerate
endmodule
