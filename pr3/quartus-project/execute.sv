// EXECUTE

module execute
				#(parameter N=64)
				(input logic [1:0] AluSrc,
				input logic [3:0] AluControl,
				input logic [N-1:0] PC_E, signImm_E, readData1_E, readData2_E,readData3_E,
				output logic [N-1:0] PCBranch_E, aluResult_E, writeData_E,
				output logic zero_E);
	
	logic [N-1:0] sl2_out, mux_out;
	
	adder Add(.a(PC_E), .b(sl2_out), .y(PCBranch_E));
	
	sl2 shift_left_2(.a(signImm_E), .y(sl2_out));
	
	alu ALU(.a(readData1_E), .b(mux_out), .ALUControl(AluControl), .result(aluResult_E), .zero(zero_E));
	
	mux4 MUX0(.d2(readData3_E), .d1(signImm_E), .d3(readData3_E),.d0(readData2_E),.s(AluSrc), .y(mux_out));
	
	assign writeData_E = readData2_E;
endmodule