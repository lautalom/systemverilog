// SIGNEXT

module signext
				(input logic [31:0] a,
				output logic [63:0] y);
	always_comb begin
		casez(a[31:21])
			// LDUR type D instr ==> 20 ~ 12 bits
			11'b111_1100_0010: y = {{55{a[20]}}, a[20:12]};
			// STUR type D instr ==> 20 ~ 12 bits
			11'b111_1100_0000: y = {{55{a[20]}}, a[20:12]};//hacer cosas stur;
			// CBZ type CB instr ==> 23 ~ 5 bits - according to legv8 isa this should lsl2
			// LEGv8 green card has a bug
			11'b101_1010_0???: y = {{45{a[23]}}, a[23:5]};
			default: y = 64'b0;
		endcase
	end
endmodule