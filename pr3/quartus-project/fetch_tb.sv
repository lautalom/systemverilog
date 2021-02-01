`timescale 1ns/10ps

// FETCH TEST BENCH

module fetch_tb #(parameter STEPS = 24)();
	int i, errors;
	logic PCSrc_F, clk, reset;
	logic [63:0] PCBranch_F, imem_addr_F;
	// INPUT VECTORS
	logic reset_vector [0: STEPS-1] = '{
		// reset 5 clocks
		1'b1, 1'b1, 
		1'b1, 1'b1, 
		1'b1, 1'b1,
		1'b1, 1'b1,
		1'b1, 1'b0,
		// PC = PC + 4 clocks
		1'b0, 1'b0,
		1'b0, 1'b0,
		1'b0, 1'b0,
		1'b0, 1'b0,
		1'b0, 1'b0,
		1'b0, 1'b0,
		// Branch
		1'b0, 1'b0
	};
	logic PCSrc_F_vector [0: STEPS-1] = '{
		// reset 5 clocks
		1'b1, 1'b1, 
		1'b1, 1'b1, 
		1'b1, 1'b1,
		1'b1, 1'b1,
		1'b1, 1'b0,
		// PC = PC + 4 clocks
		1'b0, 1'b0,
		1'b0, 1'b0,
		1'b0, 1'b0,
		1'b0, 1'b0,
		1'b0, 1'b0,
		1'b0, 1'b1,
		// Branch
		1'b0, 1'b0
	};
	
	logic [63:0] PCBranch_F_vector [0: STEPS-1] = '{
		// reset 5 clocks
		64'hff, 64'hff,
		64'hff, 64'hff,
		64'hff, 64'hff,
		64'hff, 64'hff,
		64'hff, 64'hff,
		// PC = PC + 4 clocks
		64'hc0ca, 64'hcaca,
		64'hc0ca, 64'hcaca,
		64'hc0ca, 64'hcaca,
		64'hc0ca, 64'hcaca,
		64'hc0ca, 64'hcaca,
		64'hc0ca, 64'hfafafa,
		// Branch
		64'h0, 64'h0
	};
	
	// EXPECTED RESULTS
	logic [63:0] expected_imem_addr_F [0:STEPS-1] = '{
	// reset 5 clocks
		64'h00, 64'h00,
		64'h00, 64'h00,
		64'h00, 64'h00,
		64'h00, 64'h00,
		64'h00, 64'h00,
		// PC = PC + 4 clocks
		64'h4, 64'h4,
		64'h8, 64'h8,
		64'hc, 64'hc,
		64'h10, 64'h10,
		64'h14, 64'h14,
		64'h18, 64'h18,
		// Branch
		64'hfafafa, 64'hfafafa
	};
	// instantiate device under testing
	fetch dut(.PCBranch_F(PCBranch_F), .PCSrc_F(PCSrc_F), .clk(clk), .reset(reset), .imem_addr_F(imem_addr_F));
	
	// set device clock to f=100MHz (t=10ns)
	always begin
		clk = 1'b1; #5;
		clk = 1'b0; #5;
	end
	// initialize device
	initial begin
		i = 0; errors = 0;
	end
	
	always @(clk) begin
		PCSrc_F = PCSrc_F_vector[i];
		PCBranch_F = PCBranch_F_vector[i];
		reset = reset_vector [i];
		#1;
		if (imem_addr_F !== expected_imem_addr_F[i] && i !== 0) begin
			errors++;
			$display("Error on test %d", i);
			$display("Expected imem_addr_F: %h\nFound: %h", expected_imem_addr_F[i], imem_addr_F);
		end
		i++;
		if (i >= STEPS) begin
			$display("Simulation finished with %d errors", errors);
			$stop;
		end
	end

endmodule