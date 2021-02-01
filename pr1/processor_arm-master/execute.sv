module execute
	#(parameter N = 64)
	(input logic AluSrc,
	 input logic [3:0] AluControl,
	 input logic [N-1:0] PC_E, signImm_E, readData1_E, readData2_E,
	 output logic zero_E,
	 output logic [N-1:0] PCBranch_E, aluResult_E, writeData_E);
		
	logic [N-1:0] muxOutput1,muxOutput2;
	logic [N-1:0] slOutput;
	
	adder ADD (.a(PC_E[N-1:0]),
					.b(slOutput[N-1:0]),
					.y(PCBranch_E[N-1:0]));
	
	sl2 SL(.a(signImm_E[N-1:0]),
			 .y(slOutput[N-1:0]));


	alu ALU (.a(readData1_E[N-1:0]),
				.b(muxOutput2[N-1:0]),
				.ALUControl(AluControl[3:0]),
				.result(aluResult_E[N-1:0]),
				.zero(zero_E));
	
	mux2 MUX0(.d0(readData2_E), .d1(signImm_E), .s(AluSrc), .y(muxOutput2));
	
	assign writeData_E = readData2_E;
			
endmodule
