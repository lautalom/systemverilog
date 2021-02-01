`timescale 1ns/10ps

// ALU TEST BENCH

module maindec_tb #(parameter TEST_SIZE = 15)();
	int errors;
	logic [10:0] Op;
	logic ExtIRQ, reset, Reg2Loc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ERet, Exc;
	logic [1:0] ALUSrc, ALUOp;
	logic [3:0] EStatus;
	
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
	logic [8:0] expected_output [0:TEST_SIZE] = '{
		// R-format (ADD)
		16'b0_00_0_1_0_0_0_10_0000_0_0,
		// R-format (SUB)
		16'b0_00_0_1_0_0_0_10_0000_0_0,
		// R-format (AND)
		16'b0_00_0_1_0_0_0_10_0000_0_0,
		// R-format (ORR)
		16'b0_00_0_1_0_0_0_10_0000_0_0,
		// LDUR
		{1'bx, 2'b01, 1'b1, 1'b1, 1'b1, 1'b0, 1'b0, 2'b00, 4'b0000, 1'b0, 1'b0},
		// STUR             
		 {1'b1, 2'b01, 1'bx, 1'b0, 1'b0, 1'b1, 1'b0, 2'b00, 4'b0000, 1'b0, 1'b0},
		// CBZ               
{1'b1, 2'b00, 1'bx, 1'b0, 1'b0, 1'b0, 1'b1, 2'b01, 4'b0000, 1'b0, 1'b0},
{1'b1, 2'b00, 1'bx, 1'b0, 1'b0, 1'b0, 1'b1, 2'b01, 4'b0000, 1'b0, 1'b0},
{1'b1, 2'b00, 1'bx, 1'b0, 1'b0, 1'b0, 1'b1, 2'b01, 4'b0000, 1'b0, 1'b0},
{1'b1, 2'b00, 1'bx, 1'b0, 1'b0, 1'b0, 1'b1, 2'b01, 4'b0000, 1'b0, 1'b0},
{1'b1, 2'b00, 1'bx, 1'b0, 1'b0, 1'b0, 1'b1, 2'b01, 4'b0000, 1'b0, 1'b0},
{1'b1, 2'b00, 1'bx, 1'b0, 1'b0, 1'b0, 1'b1, 2'b01, 4'b0000, 1'b0, 1'b0},
{1'b1, 2'b00, 1'bx, 1'b0, 1'b0, 1'b0, 1'b1, 2'b01, 4'b0000, 1'b0, 1'b0},
		// undefined
{1'b0,2'b00,1'b0,1'b0,1'b0,1'b0,1'b0,4'b0010,1'b0, 1'b1}	};
	
	
	// instantiate device under testing
	maindec dut(.Op(Op), .ExtIRQ(ExtIRQ), .reset(reset), .Reg2Loc(Reg2Loc), .EStatus(EStatus), .ALUSrc(ALUSrc), .MemtoReg(MemtoReg), .RegWrite(RegWrite), .MemRead(MemRead), .MemWrite(MemWrite), .Branch(Branch), .ERet(ERet), .Exc(Exc), .ALUOp(ALUOp));

	// initialize device
	initial begin
	ExtIRQ=0; reset=0;
		errors = 0;
		for (int i = 0; i < TEST_SIZE; i++) begin
			Op = input_vector[i];
			#10;
			if ({Reg2Loc, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp, EStatus, ERet, Exc} !== expected_output[i] ) begin
				errors++;
				$display("Error at iteration %d", i);
				$display("Expected result: %b\nFound: %b", expected_output[i], {Reg2Loc, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp});
			end
		end
		$display("Simulation finished with %d errors", errors);
	end
endmodule
