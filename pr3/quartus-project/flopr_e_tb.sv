`timescale 1ns/10ps

// FLOPR_E TEST BENCH -- Missing test with N=32

module flopr_e_tb #(parameter N = 64)();
	int i, errors;
	logic clk, reset, enable;
	logic [N-1:0] d, q, test_vector;
	// input data vector
	logic [N-1:0] data_vector [0:11] = '{64'hc4c4,
													64'hc0c0,
													64'hc3c1,
													64'hc4c0,
													64'hcac0,
													64'hcec1,
													64'hcac1,
													64'hc0c0,
													64'hcafe,
													64'hdad0,
													64'hcafe,
													64'hc0c0
													};
	// input enable vector
	logic enable_vector[0:11] = '{1'b1,
										  1'b1,
										  1'b1,
										  1'b1,
										  1'b1,
										  1'b1,
										  1'b1,
										  1'b1,
										  1'b1,
										  1'b1,
										  1'b0,
										  1'b1
										  };
	// input reset vector
	logic reset_vector [0:11] = '{1'b1,
										  1'b1,
										  1'b1,
										  1'b1,
										  1'b1,
										  1'b0,
										  1'b0,
										  1'b0,
										  1'b0,
										  1'b0,
										  1'b0,
										  1'b0
										  };
	// expected output vector
	logic [N-1:0] expected_vector [0:12] = '{64'h0,
														 64'h0,
														 64'h0,
														 64'h0,
														 64'h0,
														 64'h0,
														 64'hcec1,
														 64'hcac1,
														 64'hc0c0,
														 64'hcafe,
														 64'hdad0,
 														 64'hdad0,
														 64'hc0c0
														 };
														 
	// instantiate device under testing
	flopr_e dut(.clk(clk), .reset(reset), .enable(enable), .d(d), .q(q));
	// set device clock to f=100MHz (t=10ns)
	always begin
		clk = 1'b1; #5;
		clk = 1'b0; #5;
	end
	// initialize device
	initial begin
		i = 0; errors = 0;reset = 1'b0; d = 64'b0; enable = 1'b1;
	end
	
	// update input value
	always @(posedge clk) begin
		d = data_vector[i];
		reset = reset_vector[i];
		enable = enable_vector[i];
	end
	// check  output value
	always @(negedge clk) begin
		if (expected_vector[i] !== q) begin
			errors++;
			$display("Error on %d iteration", i);
			$display("Result: %h \nExpected: %h", q, expected_vector[i]);
		end
		i++;
		if(i === 32'd10) begin
			$display("Simulation finished with %d errors", errors);
//			$finish;
			$stop;
		end
	end
	
endmodule