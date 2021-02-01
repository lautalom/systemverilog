`timescale 1ns/10ps

// ALU TEST BENCH

module maindec_tb #(parameter TEST_SIZE = 15)();
	int errors;
	logic [10:0] Op;
	logic Reg2Loc, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch;
	logic [1:0]  ALUOp;
	
	logic [0:10] input_vector [0:TEST_SIZE-1] = '{
		// R-format (ADD)
		11'b100_0101_1000,
		// R-format (SUB)
		11'b110_0101_1000,
		// R-format (AND)
		11'b100_0101_0000,
		// R-format (ORR)
		11'b101_0101_0000,
		// LDUR
		11'b111_1100_0010,
		// STUR
		11'b111_1100_0000,
		// CBZ
		11'b101_1010_0000,
		11'b101_1010_0001,
		11'b101_1010_0010,
		11'b101_1010_0011,
		11'b101_1010_0100,
		11'b101_1010_0101,
		11'b101_1010_0110,
		11'b101_1010_0111,
		// undefined
		11'b111_1111_1111

	};
	// output expected vector for result
	logic [8:0] expected_output [0:TEST_SIZE-1] = '{
		// R-format (ADD)
		9'b0_0_0_1_0_0_0_10,
		// R-format (SUB)
		9'b0_0_0_1_0_0_0_10,
		// R-format (AND)
		9'b0_0_0_1_0_0_0_10,
		// R-format (ORR)
		9'b0_0_0_1_0_0_0_10,
		// LDUR
		9'b0_1_1_1_1_0_0_00,
		// STUR
		9'b1_1_0_0_0_1_0_00,
		// CBZ
		9'b1_0_0_0_0_0_1_01,
		9'b1_0_0_0_0_0_1_01,
		9'b1_0_0_0_0_0_1_01,
		9'b1_0_0_0_0_0_1_01,
		9'b1_0_0_0_0_0_1_01,
		9'b1_0_0_0_0_0_1_01,
		9'b1_0_0_0_0_0_1_01,
		9'b1_0_0_0_0_0_1_01,
		// undefined
		9'b0
	};
	
	
	// instantiate device under testing
	maindec dut(.Op(Op), .Reg2Loc(Reg2Loc), .ALUSrc(ALUSrc), .MemtoReg(MemtoReg), .RegWrite(RegWrite), .MemRead(MemRead), .MemWrite(MemWrite), .Branch(Branch), .ALUOp(ALUOp));
	

	// initialize device
	initial begin
		errors = 0;
		for (int i = 0; i < TEST_SIZE; i++) begin
			Op = input_vector[i];
			#10;
			if ({Reg2Loc, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp} !== expected_output[i] ) begin
				errors++;
				$display("Error at iteration %d", i);
				$display("Expected result: %b\nFound: %b", expected_output[i], {Reg2Loc, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp});
			end
		if (i+1 >= TEST_SIZE) begin
			$display("Simulation finished with %d errors", errors);
			$stop;
			end
		end

	end
endmodule

