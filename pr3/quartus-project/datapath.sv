// DATAPATH

module datapath #(parameter N = 64)
					(input logic reset, clk,
					input logic reg2loc,									
					input logic [1:0] AluSrc,
					input logic [3:0] AluControl,
					input logic	Branch,
					input logic memRead,
					input logic memWrite,
					input logic [3:0] EStatus,
					input logic Exc, ERet,
					input logic regWrite,	
					input logic memtoReg,									
					input logic [31:0] IM_readData,
					input logic [N-1:0] DM_readData,
					output logic [N-1:0] IM_addr, DM_addr, DM_writeData,
					output logic DM_writeEnable, DM_readEnable, ExcAck);					
					
	logic PCSrc, EProc;
	logic [N-1:0] PCBranch, writeData_E, writeData3,PCBranch_EXP,ExcVector; 
	logic [N-1:0] signImm, readData1, readData2, NextPC_F, readData3_E;
	logic zero;
	
	fetch 	#(64) 	FETCH 	(.PCSrc_F(PCSrc),
										.clk(clk),
										.reset(reset),
										.PCBranch_F(PCBranch_EXP),
										.EVAddr_F(ExcVector),
										.EProc_F(EProc),
										.NextPC_F(NextPC_F),
										.imem_addr_F(IM_addr));
									
	exception #(64)	EXCEPTION (.NextPC_F(NextPC_F),
											.imem_addr_F(IM_addr),
											.PCBranch_EX(PCBranch),
											.EStatus(EStatus),
											.IM_readData(IM_readData[13:12]),
											.Exc(Exc),
											.ERet(ERet), 
											.clk(clk),
											.reset(reset),
											.ExcAck(ExcAck),
											.ExcVector(ExcVector),
											.EProc(EProc),
											.readData3_E(readData3_E),
											.PCBranch_EXP(PCBranch_EXP));	
			
					
	decode 	#(64) 	DECODE 	(.regWrite_D(regWrite),
										.reg2loc_D(reg2loc), 
										.clk(clk),
										.writeData3_D(writeData3),
										.instr_D(IM_readData), 
										.signImm_D(signImm), 
										.readData1_D(readData1),
										.readData2_D(readData2));				
																									

											
	execute 	#(64) 	EXECUTE 	(.AluSrc(AluSrc),
										.AluControl(AluControl),
										.PC_E(IM_addr), 
										.signImm_E(signImm), 
										.readData1_E(readData1), 
										.readData2_E(readData2), 
										.readData3_E(readData3_E),
										.PCBranch_E(PCBranch), 
										.aluResult_E(DM_addr), 
										.writeData_E(DM_writeData), 
										.zero_E(zero));											
											
										
										
	memory				MEMORY	(.Branch_M(Branch), 
										.zero_M(zero), 
										.PCSrc_M(PCSrc));
										
										
										
	writeback #(64) 	WRITEBACK (.aluResult_W(DM_addr), 
										.DM_readData_W(DM_readData), 
										.memtoReg(memtoReg), 
										.writeData3_W(writeData3));		
			
		
		
	// Salida de señales de control:
	assign DM_writeEnable = memWrite;
	assign DM_readEnable = memRead;
	
endmodule
