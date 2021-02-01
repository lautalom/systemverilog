module exception #(parameter N=64) 
						(input logic [N-1:0] NextPC_F, imem_addr_F, PCBranch_EX,
						input logic [3:0] EStatus,
						input logic [1:0] IM_readData,
						input logic Exc, ERet, clk, reset,
						output logic EProc, ExcAck,
						output logic [N-1:0] readData3_E, ExcVector, PCBranch_EXP);
						
		logic esync_out;
		logic [N-1:0] elrout, errout;
		logic [3:0] esrout;
		
		comp_n COMP (.a(imem_addr_F),
						.b(64'hD8),
						.y(ExcAck));

		esync ESync (.reset(ExcAck),
						.set(Exc),
						.esync_out(esync_out));
		
		flopr_e ELR (.d(imem_addr_F),
						.clk(clk),
						.reset(reset),
						.enable(~(reset)&&esync_out),
						.q(elrout));
		
		flopr_e #(4) ESR (.d(EStatus),
						.clk(clk),
						.reset(reset),
						.enable(~(reset)&&esync_out),
						.q(esrout));
		
		flopr_e ERR (.d(NextPC_F),
						.clk(clk),
						.reset(reset),
						.enable(~(reset)&&esync_out),
						.q(errout));
		
		mux4 MUX (.s(IM_readData),
						.d3(64'b0),
						.d0(errout),
						.d1(elrout),
						.d2({60'b0,esrout}),
						.y(readData3_E));
		
		mux2 MUX2 (.s(ERet),
					.d1(errout),
					.d0(PCBranch_EX),
					.y(PCBranch_EXP));
					
		assign EProc = ~reset&&esync_out;
		assign ExcVector = 64'hD8;


endmodule