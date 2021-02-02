// CONTROLLER

module controller(input logic [10:0] instr,
						input logic ExcAck, ExtIRQ, reset,
						output logic [3:0] AluControl,
						output logic [3:0] EStatus,
						output logic [1:0] AluSrc,
						output logic reg2loc, regWrite, Branch,
											memtoReg, memRead, memWrite,
											ERet, Exc, ExtIAck);
											
	logic [1:0] AluOp_s;			
	logic [3:0] EStatusAux;
	logic [1:0] ALUSrcAux, ALUOpAux;
	logic NotAnInstr, Reg2LocAux, MemtoRegAux, RegWriteAux, MemReadAux, MemWriteAux, BranchAux, ERetAux;
											
	maindec 	decPpal 	(.Op(instr),
							.previous({reg2loc, AluSrc, memtoReg, regWrite, memRead, memWrite, Branch, AluOp_s, EStatus, ERet, Exc}),
							.Reg2Loc(Reg2LocAux), 
							.ALUSrc(ALUSrcAux), 
							.MemtoReg(MemtoRegAux), 
							.RegWrite(RegWriteAux), 
							.MemRead(MemReadAux),
							.EStatus(EStatusAux),
							.reset(reset),
							.MemWrite(MemWriteAux), 
							.Branch(BranchAux), 
							.ALUOp(ALUOpAux),
							.ERet(ERetAux),
							.ExtIRQ(ExtIRQ),
							.NotAnInstr(NotAnInstr));	
					
								
	aludec 	decAlu 	(.funct(instr), 
							.aluop(AluOp_s), 
							.alucontrol(AluControl));
							
	assign ExtIAck = ExcAck & ExtIRQ;
	
	assign {reg2loc, AluSrc, memtoReg, regWrite, memRead, memWrite, Branch, AluOp_s, EStatus, ERet, Exc} = reset ? ({'0}) : 
											(ExtIRQ ? {Reg2LocAux, ALUSrcAux, MemtoRegAux, RegWriteAux, MemReadAux, MemWriteAux, BranchAux, ALUOpAux, 4'b0001, ERetAux, ExtIRQ} :
											{Reg2LocAux, ALUSrcAux, MemtoRegAux, RegWriteAux, MemReadAux, MemWriteAux, BranchAux, ALUOpAux, EStatusAux, ERetAux, NotAnInstr});
			
endmodule
