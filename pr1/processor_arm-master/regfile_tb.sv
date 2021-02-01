`timescale 1ns/10ps

// REGFILE TEST BENCH

module regfile_tb #(parameter RD1_SIZE = 36, parameter RD2_SIZE = 36, parameter STEPS = 36)();
	int i, errors;
	logic clk, we3;
	logic [4:0] ra1, ra2, wa3;
	logic [63:0] wd3, rd1, rd2;
	// INPUT VECTORS
	logic we3_vector [0: STEPS-1] = '{
													// check initialization values
													1'b0,	1'b0,	1'b0,	1'b0,	1'b0,	1'b0,	1'b0,	1'b0,
													1'b0,	1'b0,	1'b0,	1'b0,	1'b0,	1'b0,	1'b0,	1'b0,
													1'b0,	1'b0,	1'b0,	1'b0,	1'b0,	1'b0,	1'b0,	1'b0,
													1'b0,	1'b0,	1'b0,	1'b0,	1'b0,	1'b0,	1'b0,	1'b0,
													// write reg 0
													1'b1, 1'b1,
													// write reg x31 aka xzr
													1'b1, 1'b1
												};
	logic [4:0] ra1_vector [0: STEPS-1] = '{
															// check initialization values
															5'd0,		5'd1,		5'd2,		5'd3,		5'd4,		5'd5,		5'd6,		5'd7,
															5'd8,		5'd9,		5'd10,	5'd11,	5'd12,	5'd13,	5'd14,	5'd15,
															5'd16,	5'd17,	5'd18,	5'd19,	5'd20,	5'd21,	5'd22,	5'd23,
															5'd24,	5'd25,	5'd26,	5'd27,	5'd28,	5'd29, 	5'd30,	5'd31,
															// read reg 0
															5'd0, 5'd0,
															// read reg xzr
															5'd31, 5'd31
														};
	logic [4:0] ra2_vector [0: STEPS-1] = '{
															// check initialization values
															5'd0,		5'd1,		5'd2,		5'd3,		5'd4,		5'd5,		5'd6,		5'd7,
															5'd8,		5'd9,		5'd10,	5'd11,	5'd12,	5'd13,	5'd14,	5'd15,
															5'd16,	5'd17,	5'd18,	5'd19,	5'd20,	5'd21,	5'd22,	5'd23,
															5'd24,	5'd25,	5'd26,	5'd27,	5'd28,	5'd29, 	5'd30,	5'd31,
															// check read diff registers while writing reg 0
															5'd25, 5'd25,
															// read reg xzr
															5'd31, 5'd31
														};
	logic [4:0] wa3_vector [0: STEPS-1] = '{
															// these values don't matter
															5'd0,		5'd1,		5'd2,		5'd3,		5'd4,		5'd5,		5'd6,		5'd7,
															5'd8,		5'd9,		5'd10,	5'd11,	5'd12,	5'd13,	5'd14,	5'd15,
															5'd16,	5'd17,	5'd18,	5'd19,	5'd20,	5'd21,	5'd22,	5'd23,
															5'd24,	5'd25,	5'd26,	5'd27,	5'd28,	5'd29, 	5'd30,	5'd31,
															// write reg 0
															5'd0, 5'd0,
															// write xzr
															5'd31, 5'd31
														};
	logic [63:0] wd3_vector [0:STEPS-1] = '{
															// these values don't matter at all
															64'd0,	64'd1,	64'd2,	64'd3,	64'd4,	64'd5,	64'd6,	64'd7,
															64'd8,	64'd9,	64'd10,	64'd11,	64'd12,	64'd13,	64'd14,	64'd15,
															64'd16,	64'd17,	64'd18,	64'd19,	64'd20,	64'd21,	64'd22,	64'd23,
															64'd24,	64'd25,	64'd26,	64'd27,	64'd28,	64'd29, 	64'd30,	64'd31,
															// write 255 to reg 0
															64'd255, 64'd255,
															// try to write anything to xzr
															64'hc0c0, 64'hc4c4
														};

	logic [63:0] expected_rd1 [0:RD1_SIZE-1] = '{
															// check initialization
															64'd0,	64'd1,	64'd2,	64'd3,	64'd4,	64'd5,	64'd6,	64'd7,
															64'd8,	64'd9,	64'd10,	64'd11,	64'd12,	64'd13,	64'd14,	64'd15,
															64'd16,	64'd17,	64'd18,	64'd19,	64'd20,	64'd21,	64'd22,	64'd23,
															64'd24,	64'd25,	64'd26,	64'd27,	64'd28,	64'd29, 	64'd30,	64'd00,
															// check write to reg 0;
															64'd255, 64'd255,
															// try to write xzr
															64'd0, 64'd0
															};
	logic [63:0] expected_rd2 [0:RD2_SIZE-1] = '{
															64'd0,	64'd1,	64'd2,	64'd3,	64'd4,	64'd5,	64'd6,	64'd7,
															64'd8,	64'd9,	64'd10,	64'd11,	64'd12,	64'd13,	64'd14,	64'd15,
															64'd16,	64'd17,	64'd18,	64'd19,	64'd20,	64'd21,	64'd22,	64'd23,
															64'd24,	64'd25,	64'd26,	64'd27,	64'd28,	64'd29, 	64'd30,	64'd00,
															// check multiple reads 
															64'd25, 64'd25,
															// try to write xzr
															64'd0, 64'd0
															};
	
	// instantiate device under testing
	regfile dut(.clk(clk), .we3(we3), .ra1(ra1), .ra2(ra2), .wa3(wa3), .wd3(wd3), .rd1(rd1), .rd2(rd2));
	
	// set device clock to f=100MHz (t=10ns)
	always begin
		clk = 1'b1; #5;
		clk = 1'b0; #5;
	end
	// initialize device
	initial begin
		i = 0; errors = 0; we3=1'b0; ra1 = 5'b0; ra2 = 5'b0; wa3 = 5'b0; wd3 = 64'b0;
	end
	
	
	// update input value
	always @(posedge clk) begin
		we3 = we3_vector[i]; ra1 = ra1_vector[i]; ra2 = ra2_vector[i]; wa3 = wa3_vector[i]; wd3 = wd3_vector[i];
	end
	
	// check output value
	always @(negedge clk) begin
		if (i >= STEPS) begin
			$display("Simulation finished with %d errors", errors);
			$stop;
		end
		if (rd1 !== expected_rd1[i] || rd2 !== expected_rd2[i]) begin
			errors++;
			$display("Error on test %d", i);
			$display("Expected rd1: %h\nFound: %h", expected_rd1[i], rd1);
			$display("Expected rd2: %h\nFound: %h", expected_rd2[i], rd2);
		end
		i++;
	end
endmodule