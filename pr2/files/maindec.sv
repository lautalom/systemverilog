module maindec
		(input logic [10:0] Op,
		output logic Reg2Loc, ALUSrc, MemtoReg,
						 RegWrite, MemRead, MemWrite,
						 Branch,
		output logic [1:0] ALUOp);
		

	always_comb begin
	casez(Op)
		11'b111_1100_0010:{Reg2Loc, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp} =  {1'b0, 1'b1, 1'b1, 1'b1, 1'b1, 1'b0, 1'b0, 2'b00};//LDUR
		11'b111_1100_0000:{Reg2Loc, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp} =  {1'b1, 1'b1, 1'b0, 1'b0, 1'b0, 1'b1, 1'b0, 2'b00};//STUR
		11'b101_1010_0???:{Reg2Loc, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp} =  {1'b1, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b1, 2'b01};//CBZ
		11'b100_0101_1000:{Reg2Loc, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp} =  {1'b0, 1'b0, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 2'b10};//ADD
		11'b110_0101_1000:{Reg2Loc, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp} =  {1'b0, 1'b0, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 2'b10};//SUB
		11'b100_0101_0000:{Reg2Loc, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp} =  {1'b0, 1'b0, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 2'b10};//AND
		11'b101_0101_0000:{Reg2Loc, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp} =  {1'b0, 1'b0, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 2'b10};//ORR
		default: {Reg2Loc, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp} = {'0};//(1) opcode invalid
		endcase			
	end
endmodule
