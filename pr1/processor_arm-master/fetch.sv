
module fetch #(parameter N = 64)
				(input logic PCSrc_F,clk,reset,
				 input logic  [N-1:0] PCBranch_F,
				output logic [N-1:0] imem_addr_F);				 
	
	logic [N-1:0] adderout,muxout;
		
	mux2 a1(adderout,PCBranch_F,PCSrc_F,muxout);
	flopr a2(clk,reset,muxout,imem_addr_F);
	adder a3(64'd4,imem_addr_F,adderout);
				 
endmodule
