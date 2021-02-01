`timescale 1ns/10ps

// FETCH TEST BENCH

module execute_tb #(parameter TEST_SIZE = 12)();
	int errors;
	logic AluSrc, zero_E;
	logic [3:0] AluControl;
	logic [63:0] PC_E, signImm_E, readData1_E, readData2_E, PCBranch_E, aluResult_E, writeData_E;
	
	// hacer todas las ops de AluControl con las distintas fuentes y al mismo tiempo testear que el branch se ejecute correctamente rrey
	
	// regs AND, OR, add, sub, pass b, nor.
	// reg, immediate and, or, add, sub, pass b, nor.
	// pc in every test can be done simultaneously
	
	
	// INPUT VECTORS
	logic AluSrc_vector [0: TEST_SIZE-1] = '{
		// regs AND
		1'b0,
		// regs OR
		1'b0,
		// regs ADD
		1'b0,
		// regs SUB
		1'b0,
		// regs PASS b
		1'b0,
		// regs NOR
		1'b0,
		// immediate + reg AND
		1'b1,
		// immediate + reg OR
		1'b1,
		// immediate + reg ADD
		1'b1,
		// immediate + reg SUB
		1'b1,
		// immediate + reg PASS b
		1'b1,
		// immediate + reg NOR
		1'b1
	};
	
	logic [3:0] AluControl_vector [0:TEST_SIZE-1] = '{
		// regs AND
		4'b0,
		// regs OR
		4'b1,
		// regs ADD
		4'b10,
		// regs SUB
		4'b110,
		// regs PASS b
		4'b111,
		// regs NOR
		4'b1100,
		// immediate + reg AND
		4'b0,
		// immediate + reg OR
		4'b1,
		// immediate + reg ADD
		4'b10,
		// immediate + reg SUB
		4'b110,
		// immediate + reg PASS b
		4'b111,
		// immediate + reg NOR
		4'b1100
	};
	
	
	logic [63:0] PC_E_vector [0:TEST_SIZE-1] = '{
		// regs AND
		64'hffff,
		// regs OR
		64'hcacaca,
		// regs ADD
		64'hf0f0f0,
		// regs SUB
		64'hded0,
		// regs PASS b
		64'hdad0,
		// regs NOR
		64'he5e,
		// immediate + reg AND
		64'hf7a_e1_d1e50,
		// immediate + reg OR
		64'hc0c0c0,
		// immediate + reg ADD
		64'hcafe,
		// immediate + reg SUB
		64'hfef17a,
		// immediate + reg PASS b
		64'h1a,
		// immediate + reg NOR
		64'hcabe
	};
	
	logic [63:0] signImm_E_vector[0:TEST_SIZE-1] = '{
		// regs AND
		64'h1,
		// regs OR
		64'h2,
		// regs ADD
		64'h3,
		// regs SUB
		64'h4,
		// regs PASS b
		64'h5,
		// regs NOR
		64'h6,
		// immediate + reg AND
		64'h5,
		// immediate + reg OR
		64'hf,
		// immediate + reg ADD
		64'h0,
		// immediate + reg SUB
		64'ha,
		// immediate + reg PASS b
		64'hf,
		// immediate + reg NOR
		64'h24
	};
	logic [63:0] readData1_E_vector[0:TEST_SIZE-1] = '{
		// regs AND
		64'h0,
		// regs OR
		64'h1,
		// regs ADD
		64'h2,
		// regs SUB
		64'hf,
		// regs PASS b
		64'hc4c4,
		// regs NOR
		64'h7e1,
		// immediate + reg AND
		64'hff,
		// immediate + reg OR
		64'hffff,
		// immediate + reg ADD
		64'ha5d,
		// immediate + reg SUB
		64'd56,
		// immediate + reg PASS b
		64'hcacacacaca,
		// immediate + reg NOR
		64'hc0c0c0c0
	};
	logic [63:0] readData2_E_vector[0:TEST_SIZE-1] = '{
		// regs AND
		64'hc0c0c0c0,
		// regs OR
		64'hcacacacaca,
		// regs ADD
		64'd56,
		// regs SUB
		64'hffff,
		// regs PASS b
		64'hff,
		// regs NOR
		64'h7e1,
		// immediate + reg AND
		64'hc4c4,
		// immediate + reg OR
		64'hf,
		// immediate + reg ADD
		64'h2,
		// immediate + reg SUB
		64'h1,
		// immediate + reg PASS b
		64'h0,
		// immediate + reg NOR
		64'hc0c0c0c0
	};
	logic [63:0] expected_PCBranch_E [0:TEST_SIZE-1] = '{
		// regs AND
		64'h10003,
		// regs OR
		64'hcacad2,
		// regs ADD
		64'hf0f0fc,
		// regs SUB
		64'hdee0,
		// regs PASS b
		64'hdae4,
		// regs NOR
		64'he76,
		// immediate + reg AND
		64'hf7a_e1_d1e64,
		// immediate + reg OR
		64'hc0c0fc,
		// immediate + reg ADD
		64'hcafe,		
		// immediate + reg SUB
		64'hfef1a2,		
		// immediate + reg PASS b
		64'h56,
		// immediate + reg NOR
		64'hcb4e
	};

	logic [63:0] expected_aluResult_E [0:TEST_SIZE-1] = '{
		// regs AND
		64'h0,
		// regs OR
		64'hcacacacacb,
		// regs ADD
		64'd58,
		// regs SUB
		64'hffff_ffff_ffff_0010,
		// regs PASS b
		64'hff,
		// regs NOR
		64'hffff_ffff_ffff_f81e,
		// immediate + reg AND
		64'h5,
		// immediate + reg OR
		64'hffff,
		// immediate + reg ADD
		64'ha5d,
		// immediate + reg SUB
		64'h2e,
		// immediate + reg PASS b
		64'hf,
		// immediate + reg NOR
		64'hffff_ffff_3f3f_3f1b
	};
	
	logic [63:0] expected_writeData_E[0:TEST_SIZE-1] = '{
		// regs AND
		64'hc0c0c0c0,
		// regs OR
		64'hcacacacaca,
		// regs ADD
		64'd56,
		// regs SUB
		64'hffff,
		// regs PASS b
		64'hff,
		// regs NOR
		64'h7e1,
		// immediate + reg AND
		64'hc4c4,
		// immediate + reg OR
		64'hf,
		// immediate + reg ADD
		64'h2,
		// immediate + reg SUB
		64'h1,
		// immediate + reg PASS b
		64'h0,
		// immediate + reg NOR
		64'hc0c0c0c0
	};
	
	logic expected_zero_E[0:TEST_SIZE-1] = '{
		// regs AND
		1'b1,
		// regs OR
		1'b0,
		// regs ADD
		1'b0,
		// regs SUB
		1'b0,
		// regs PASS b
		1'b0,
		// regs NOR
		1'b0,
		// immediate + reg AND
		1'b0,
		// immediate + reg OR
		1'b0,
		// immediate + reg ADD
		1'b0,
		// immediate + reg SUB
		1'b0,
		// immediate + reg PASS b
		1'b0,
		// immediate + reg NOR
		1'b0
	};
	// instantiate device under testing
	execute dut(.AluSrc(AluSrc), 
		.AluControl(AluControl), 
		.PC_E(PC_E), 
		.signImm_E(signImm_E), 
		.readData1_E(readData1_E), 
		.readData2_E(readData2_E), 
		.PCBranch_E(PCBranch_E),
		.aluResult_E(aluResult_E),
		.writeData_E(writeData_E),
		.zero_E(zero_E));
	
	// initialize device
	initial begin
		errors = 0;
		for (int i = 0; i < TEST_SIZE; i++) begin
		AluSrc = AluSrc_vector[i];
		AluControl= AluControl_vector[i];
		PC_E = PC_E_vector[i];
		signImm_E = signImm_E_vector[i];
		readData1_E = readData1_E_vector[i];
		readData2_E = readData2_E_vector[i];
		#1;
			if (PCBranch_E !== expected_PCBranch_E[i]
				|| aluResult_E !== expected_aluResult_E[i]
				|| writeData_E !== expected_writeData_E[i]
				|| zero_E !== expected_zero_E[i]) begin
				errors++;
				$display("Error at iteration %d", i);
				$display("Expected PCBranch_E: %h\nFound: %h", expected_PCBranch_E[i], PCBranch_E);
				$display("Expected aluResult_E: %h\nFound: %h", expected_aluResult_E[i], aluResult_E);
				$display("Expected writeData_E: %h\nFound: %h", expected_writeData_E[i], writeData_E);
				$display("Expected zero_E: %h\nFound: %h", expected_zero_E[i], zero_E);
			end
		end
		$display("Simulation finished with %d errors", errors);
	end
endmodule