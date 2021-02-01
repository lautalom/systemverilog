
module fetch #(parameter N = 64)
				(input logic PCSrc_F,clk,reset,
				 input logic  [N-1:0] PCBranch_F,
				output logic [N-1:0] imem_addr_F);				 
	
	logic [N-1:0] adderout,muxout;
	
	mux2 #(N) a1(.d0(adderout),.d1(PCBranch_F),.s(PCSrc_F),.y(muxout));
	flopr #(N) a2(.clk(clk),.reset(reset),.d(muxout),.q(imem_addr_F));
	adder #(N) a3(.a(64'd4),.b(imem_addr_F),.y(adderout));
					 
endmodule
