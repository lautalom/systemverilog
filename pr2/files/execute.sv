module execute
	#(parameter N = 64)
	(input logic AluSrc,
	 input logic [3:0] AluControl,
	 input logic [N-1:0] PC_E, signImm_E, readData1_E, readData2_E,
	 output logic zero_E,
	 output logic [N-1:0] PCBranch_E, aluResult_E, writeData_E);
		
	logic [N-1:0] muxOut, slOut;
	
	mux2 #(N) MUX(.d0(readData2_E), .d1(signImm_E), .s(AluSrc), .y(muxOut));
	
	sl2 SL(.a(signImm_E), .y(slOut));
			 
	adder #(N) ADD (.a(PC_E), .b(slOut), .y(PCBranch_E));

	alu ALU (.a(readData1_E), .b(muxOut), .ALUControl(AluControl),	.result(aluResult_E),
				.zero(zero_E));
	

	
	assign writeData_E = readData2_E;
			
endmodule
