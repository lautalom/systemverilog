module alu	(input logic 	[63:0]a, b,
				 input logic 	[3:0]ALUControl,
				 output logic  zero,
				 output logic 	[63:0]result);					
	
	always_comb begin
		case(ALUControl)
			4'b0000: result = a & b; 
			4'b0001:	result = a | b;
			4'b0010: result = a + b;
			4'b0110:	result = a - b;
			4'b0111: result = b;
			4'b1100: result = ~(a | b);
			default: result = '0;
		endcase
		zero = result==='0 ? 1'b1:1'b0;
	end
endmodule	