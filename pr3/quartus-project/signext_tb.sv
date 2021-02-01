`timescale 1ns/10ps

// SIGNEXT TEST BENCH

module signext_tb #(parameter TEST_SIZE = 7)();
	int errors;
	logic [31:0] a;
	logic [63:0] y;
	
	// input data vector
	logic [31:0] input_vector [0:TEST_SIZE-1] = '{
		// LDUR
		32'b111_1100_0010_1000_0000_1111_1111_1111_1,
		32'b111_1100_0010_0000_0000_1000_0000_0000_0,
		// STUR
		32'b111_1100_0000_1000_0000_1111_1111_1111_1,
		32'b111_1100_0000_0000_0000_1000_0000_0000_0,
		// CBZ
		32'b101_1010_0100_0000_0000_0000_0000_1111_1,
		32'b101_1010_0000_0000_0000_0000_0001_1111_1,
		//unkown instruction
		32'b111_1111_1111_1111_1111_1111_1111_1111_1
		};
	
	// input reset vector
	logic [63:0] expected_output [0:TEST_SIZE-1] = '{
		{{55{1'b1}},9'b1000_0000_1},
		64'd1,
		{{55{1'b1}},9'b1000_0000_1},
		64'd1,
		{{43{1'b1}},19'b100_0000_0000_0000_0000,2'b0},
		{43'b0,19'b000_0000_0000_0000_0001,2'b0},
		64'b0
		};													 
	
	// instantiate device under testing
	signext dut(.a(a), .y(y));

	// initialize device
	initial begin
		errors = 0;
		for (int i = 0; i < TEST_SIZE; i++) begin
			a = input_vector[i]; #10;
			if (y !== expected_output[i]) begin
				errors++;
				$display("Error at iteration %d", i);
				$display("Expected output: %b\nFound: %b", expected_output[i], y);
			end
		end
		$display("Simulation finished with %d errors", errors);
	end
endmodule