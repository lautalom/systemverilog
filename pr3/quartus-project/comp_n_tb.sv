module comp_n_tb ();
	int errors;
	logic [0:10] a, b;
	logic y,expected;
	
	logic [0:10] input_vector [0:14] = '{
		// R-format (ADD)
		11'b100_0101_1000,
		// R-format (SUB)
		11'b110_0101_1000,
		// R-format (AND)
		11'b100_0101_0000,
		// R-format (ORR)
		11'b101_0101_0000,
		// LDUR
		11'b111_1100_0010,
		// STUR
		11'b111_1100_0000,
		// CBZ
		11'b101_1010_0000,
		11'b101_1010_0001,
		11'b101_1010_0010,
		11'b101_1010_0011,
		11'b101_1010_0100,
		11'b101_1010_0101,
		11'b101_1010_0110,
		11'b101_1010_0111,
		// undefined
		11'b111_1111_1111

	};
	
	comp_n dut (.a(a),.b(b),.y(y));
	
	initial begin
	for (int i=0; i<$size(input_vector); i++) begin
		for (int j=0;j<$size(input_vector);j++) begin
			expected = 0;
			if (i==j) begin 
				expected = 1;
			end
			a = input_vector[i];
			b = input_vector[j];
			#10;
			if (y!==expected) begin 
				errors++;
				$display("i:%d,j:%d,y:%d,expected:%d",i,j,y,expected);
			end

		end
		if (i+1>=$size(input_vector)) begin
			$display("Simulation finished with %d errors", errors);
			$stop;
		end
	end
	end
endmodule
	