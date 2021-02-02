module maindec
		(input logic [10:0] Op,
		input logic ExtIRQ, reset,
		//remember last output
		input logic [15:0] previous,
		output logic Reg2Loc, MemtoReg,
						 RegWrite, MemRead, MemWrite,
						 Branch, ERet,NotAnInstr,
		output logic [1:0] ALUOp, ALUSrc,
		output logic [3:0] EStatus);
		
		always_comb begin
		if (~ExtIRQ) {Reg2Loc, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp, EStatus, ERet, NotAnInstr} = previous;
		else begin 
			casez(Op)
			11'b111_1100_0010://LDUR
			{Reg2Loc, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp, EStatus, ERet, NotAnInstr} =  {1'bx, 2'b01, 1'b1, 1'b1, 1'b1, 1'b0, 1'b0, 2'b00, 4'b0000, 1'b0, 1'b0};
			11'b111_1100_0000://STUR
			{Reg2Loc, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp, EStatus, ERet, NotAnInstr} =  {1'b1, 2'b01, 1'bx, 1'b0, 1'b0, 1'b1, 1'b0, 2'b00, 4'b0000, 1'b0, 1'b0};
			11'b101_1010_0???://CBZ
			{Reg2Loc, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp, EStatus, ERet, NotAnInstr} =  {1'b1, 2'b00, 1'bx, 1'b0, 1'b0, 1'b0, 1'b1, 2'b01, 4'b0000, 1'b0, 1'b0};
			11'b100_0101_1000://ADD
			{Reg2Loc, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp, EStatus, ERet, NotAnInstr} =  {1'b0, 2'b00, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 2'b10, 4'b0000, 1'b0, 1'b0};
			11'b110_0101_1000://SUB
			{Reg2Loc, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp, EStatus, ERet, NotAnInstr} =  {1'b0, 2'b00, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 2'b10, 4'b0000, 1'b0, 1'b0};
			11'b100_0101_0000://AND
			{Reg2Loc, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp, EStatus, ERet, NotAnInstr} =  {1'b0, 2'b00, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 2'b10, 4'b0000, 1'b0, 1'b0};
			11'b101_0101_0000://ORR
			{Reg2Loc, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp, EStatus, ERet, NotAnInstr} =  {1'b0, 2'b00, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 2'b10, 4'b0000, 1'b0, 1'b0};
			11'b110_1011_0100://ERET
			{Reg2Loc, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp, EStatus, ERet, NotAnInstr} =  {1'b0, 2'b00, 1'bx, 1'b0, 1'b0, 1'b0, 1'b1, 2'b01, 4'b0000, 1'b1, 1'b0};
			11'b110_1010_1001://MRS
			{Reg2Loc, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp, EStatus, ERet, NotAnInstr} =  {1'b1, 2'b1x, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 2'b01, 4'b0000, 1'b0, 1'b0};
			default: //(1)  invalid opcode
			{Reg2Loc, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp, EStatus, ERet, NotAnInstr} = {1'bx,2'bxx,1'b0,1'b0,1'b0,1'b0,1'b0,2'bxx,4'b0010,1'b0, 1'b1};
			endcase
			end
		end	
endmodule
