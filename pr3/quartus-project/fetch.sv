// FETCH

module fetch
				#(parameter N=64)
				(input logic PCSrc_F, clk, reset, EProc_F,
				input logic [N-1:0] PCBranch_F, EVAddr_F,
				output logic [N-1:0] imem_addr_F, NextPC_F);
	
	logic [N-1:0] in_mux, in_adder, out_mux;
	
	mux2 mux0(.d0(in_mux), .d1(PCBranch_F), .s(PCSrc_F), .y(NextPC_F));
	
	mux2 mux1(.d0(NextPC_F),.d1(EVAddr_F), .s(EProc_F), .y(out_mux));
	
	adder add(.a(in_adder),.b(64'd4),.y(in_mux));
	
	flopr PC(.d(out_mux), .clk(clk), .reset(reset), .q(in_adder));
	
	assign imem_addr_F = in_adder;

endmodule