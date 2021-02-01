// FLOPR_E

module flopr_e #(parameter N = 64)
				(input logic clk, reset, enable,
				input logic [N-1:0] d,					
				output logic [N-1:0] q);
	
	always_ff @(posedge clk, posedge reset) begin
		if (reset) q <= 0; // when reset
		else if (enable) q <= d; // when enable AND clk
	end
	
endmodule
