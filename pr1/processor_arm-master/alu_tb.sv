`timescale 1ns/10ps

// ALU TEST BENCH

module alu_tb #(parameter TEST_SIZE = 10)();
	int errors;
	logic [63:0] a,b,result;
	logic [3:0]ALUControl;
	logic zero;
	
	// output expected vector for result
	logic [63:0] expected_result_vector [0:TEST_SIZE-1] = '{
		// AND
		64'hc0c0,
		// OR
		64'hc0ca,
		// +
		64'd31,
		64'b0,
		64'b0,
		// -
		64'd20,
		64'hffff_ffff_ffff_ffff,
		// pass input b
		64'hc0cac01a,
		// NOR
		{{60{1'b1}},4'b0},
		// undefined
		64'b0
	};
	
	// output expected vector for zero
	logic expected_zero_vector [0: TEST_SIZE-1] = '{
		// AND
		1'b0,
		// OR
		1'b0,
		// +
		1'b0,
		1'b1,
		1'b1,
		// -
		1'b0,
		1'b0,
		// pass input b
		1'b0,
		// NOR
		1'b0,
		// undefined
		1'b1
	};
	
	// input `a` data vector
	logic [63:0] input_vector_a [0:TEST_SIZE-1] = '{
		// AND
		64'hf0f0,
		// OR
		64'hc0c0,
		// +
		64'd23,
		64'hffff_ffff_ffff_ffff,
		64'b1,
		// -
		64'd23,
		64'h0,
		// pass input b
		64'h0,
		// NOR
		64'b1010,
		// undefined input
		64'hcaca
		};
	
	// input `b` data vector
	logic [63:0] input_vector_b [0:TEST_SIZE-1] = '{
		// AND
		64'hcec1,
		// OR
		64'hc0ca,
		// +
		64'd8,
		64'b1,
		64'hffff_ffff_ffff_ffff,
		// -,
		64'd3,
		64'b1,
		// pass input b
		64'hc0cac01a,
		// NOR
		64'b1111,
		// undefined
		64'hc0c4c01a
	};
	
	// input `ALUControl` data vector
	logic [3:0] input_vector_ALUControl [0:TEST_SIZE-1] = '{
		// AND
		4'b0000,
		// OR
		4'b0001,
		// +
		4'b0010,
		4'b0010,
		4'b0010,
		// -
		4'b0110,
		4'b0110,
		// pass input b
		4'b0111,
		// NOR
		4'b1100,
		// undefined
		4'b1111	
	};
	
	
	// instantiate device under testing
	alu dut(.a(a), .b(b), .ALUControl(ALUControl), .result(result), .zero(zero));

	// initialize device
	initial begin
		errors = 0;
		for (int i = 0; i < TEST_SIZE; i++) begin
			a = input_vector_a[i]; 
			b = input_vector_b[i];
			ALUControl = input_vector_ALUControl[i];
			#10;
			if (result !== expected_result_vector[i] || zero !== expected_zero_vector[i]) begin
				errors++;
				$display("Error at iteration %d", i);
				$display("Expected result: %h\nFound: %h", expected_result_vector[i], result);
				$display("Expected zero: %b\nFount: %b", expected_zero_vector[i], zero);
			end
		end
		$display("Simulation finished with %d errors", errors);
	end
endmodule
