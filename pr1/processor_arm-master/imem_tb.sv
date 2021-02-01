`timescale 1ns/10ps

// IMEM TEST BENCH

module imem_tb #(parameter N = 32)();
	int errors;
	logic [5:0] addr;
	logic [N-1:0] q;
	
	// expected output vector for q
	logic [N-1:0] expected_q [0:18] = 
	'{
		32'hf8000000, 32'hf8008001,
		32'hf8010002, 32'hf8018003,
		32'hf8020004, 32'hf8028005,
		32'hf8030006, 32'hf8400007,
		32'hf8408008, 32'hf8410009,
		32'hf841800a, 32'hf842000b,
		32'hf842800c, 32'hf843000d,
		32'hcb0e01ce, 32'hb400004e,
		32'hcb01000f, 32'h8b01000f,
		32'hf803800f
	};
		
	// instantiate device under testing
	imem dut(.addr(addr), .q(q));

	// initialize device
	initial begin
		errors = 0;
		for (int i = 0; i < 24; i++) begin
			addr = i;
			#10;
			if ((i <= 18 && q !== expected_q[i]) || (i > 18 && q !== 0)) begin
				errors++;
				$display("Error at iteration %d", i);
				$display("Expected result: %h\nFound: %h", i <= 18 ? expected_q[i] : 0, q);
			end
		end
		$display("Simulation finished with %d errors", errors);
	end
endmodule
