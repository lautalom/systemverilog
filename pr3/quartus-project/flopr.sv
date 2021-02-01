// FLOPR

module flopr #(parameter N = 64)
				(input logic clk, reset,
				input logic [N-1:0] d,					
				output logic [N-1:0] q);

	always_ff @(posedge clk, posedge reset)
		q <= reset ? 64'b0 : d;
endmodule
