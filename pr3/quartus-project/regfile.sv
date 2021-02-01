// REGFILE

module regfile
				(input logic clk, we3,
				input logic [4:0] ra1, ra2, wa3,
				input logic [63:0] wd3,
				output logic [63:0] rd1, rd2);
	logic [63:0] regs[0:31];
	
	
	initial begin
		for(int i = 0; i<31; i++)
			regs[i] = i;
		regs [31] =  64'b0;
	end
	
	always_comb begin
		rd1 = regs [ra1];
		rd2 = regs [ra2];
	end
	
	always @(posedge clk) begin
		if (we3 === 1'b1 && wa3 !== 5'd31) begin
			regs[wa3] <= wd3;
		end
	end
	
	
	
endmodule