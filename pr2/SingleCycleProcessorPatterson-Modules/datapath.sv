// DATAPATH

module datapath #(parameter N = 64)
					(input logic reset, clk,
					input logic reg2loc,									
					input logic AluSrc,
					input logic [3:0] AluControl,
					input logic	Branch,
					input logic memRead,
					input logic memWrite,
					input logic regWrite,	
					input logic memtoReg,									
					input logic [31:0] IM_readData,
					input logic [N-1:0] DM_readData,
					output logic [N-1:0] IM_addr, DM_addr, DM_writeData,
					output logic DM_writeEnable, DM_readEnable );					
					
	logic zero_E, PCSrc;
	logic [N-1:0] signImm_D, readData1_D, readData2_D, PCBranch_E, aluResult_E, writeData3, writeData_E;
	logic [95:0] IF_IDq;
	logic [270:0] ID_EXq;
	logic [202:0] EX_MEMq;
	logic [134:0] MEM_WBq;
	
	fetch 	#(64) 	FETCH 	(.PCSrc_F(PCSrc),
										.clk(clk),
										.reset(reset),
										.PCBranch_F(EX_MEMq[197:134]),
										.imem_addr_F(IM_addr));								
					
	
	flopr 	#(96)		IF_ID 	(.clk(clk),
										.reset(reset), 
										.d({IM_addr, IM_readData}),
										.q(IF_IDq));
										
	
	decode 	#(64) 	DECODE 	(.regWrite_D(MEM_WBq[134]),
										.reg2loc_D(reg2loc), 
										.clk(clk),
										.writeData3_D(writeData3),
										.instr_D(IF_IDq[31:0]), 
										.signImm_D(signImm_D), 
										.readData1_D(readData1_D),
										.readData2_D(readData2_D),
										.wa3_D(MEM_WBq[4:0]));				
																									
									
	flopr 	#(271)	ID_EX 	(.clk(clk),
										.reset(reset), 
										.d({AluSrc, AluControl, Branch, memRead, memWrite, regWrite, memtoReg,	
											IF_IDq[95:32], signImm_D, readData1_D, readData2_D, IF_IDq[4:0]}),
										.q(ID_EXq));	
	
										
	execute 	#(64) 	EXECUTE 	(.AluSrc(ID_EXq[270]),
										.AluControl(ID_EXq[269:266]),
										.PC_E(ID_EXq[260:197]), 
										.signImm_E(ID_EXq[196:133]), 
										.readData1_E(ID_EXq[132:69]), 
										.readData2_E(ID_EXq[68:5]), 
										.PCBranch_E(PCBranch_E), 
										.aluResult_E(aluResult_E), 
										.writeData_E(writeData_E), 
										.zero_E(zero_E));											
											
									
	flopr 	#(203)	EX_MEM 	(.clk(clk),
										.reset(reset), 
										.d({ID_EXq[265:261], PCBranch_E, zero_E, aluResult_E, writeData_E, ID_EXq[4:0]}),
										.q(EX_MEMq));	
	
										
	memory				MEMORY	(.Branch_M(EX_MEMq[202]), 
										.zero_M(EX_MEMq[133]), 
										.PCSrc_M(PCSrc));
			
	
	assign DM_writeData = EX_MEMq[68:5];
	assign DM_addr = EX_MEMq[132:69];
	
	assign DM_writeEnable = EX_MEMq[200];
	assign DM_readEnable = EX_MEMq[201];
	
	flopr 	#(135)	MEM_WB 	(.clk(clk),
										.reset(reset), 
										.d({EX_MEMq[199:198], EX_MEMq[132:69],	DM_readData, EX_MEMq[4:0]}),
										.q(MEM_WBq));
		
	
	writeback #(64) 	WRITEBACK (.aluResult_W(MEM_WBq[132:69]), 
										.DM_readData_W(MEM_WBq[68:5]), 
										.memtoReg(MEM_WBq[133]), 
										.writeData3_W(writeData3));		
		
endmodule
