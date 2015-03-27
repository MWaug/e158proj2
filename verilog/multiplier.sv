module multiplier
	#(parameter width = 8)
	(input logic [width-1:0] a, b,
	output logic [2*width-1:0] y);
	assign y = a*b;
	// Write out the custom logic

endmodule