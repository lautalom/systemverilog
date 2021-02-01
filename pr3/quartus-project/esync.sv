module esync (input logic set, reset,
					output logic esync_out);

	always @(set, reset)
			if(set) esync_out <= 1'b1;//TODO cambiar a 1
			else if(reset) esync_out <= 1'b0;
			else  esync_out <= 1'b0;
			
endmodule
