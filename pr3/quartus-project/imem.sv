// IMEM

module imem	#(parameter N = 32)
				(input logic [5:0] addr,
				output logic [N-1:0] q);
	// N bits per word, 64 words
	logic [N-1:0] rom [0:63];

	initial begin
		rom = '{default:32'h0};
		rom [0:18] ='{
		32'hf8000000, 32'hf8008001,
		32'hf8010002, 32'hf8018003,
		32'hf8020004, 32'hf8028005,
		32'hf8030006, 32'hf8400007,
		32'hf8408008, 32'hf8410009,
		32'hf841800a, 32'hf842000b,
		32'hf842800c, 32'hf843000d,
		32'hcb0e01ce, 32'hb400004e,
		32'hcb01000f, 32'h8b01000f,
		32'hf803800f};
	end
	assign q = rom[addr];
endmodule