module slatch
	#(parameter width = 8)
	(input logic clk,
	input logic[width-1:0]  d,
	output logic[width-1:0] q);
	always_latch
		if (clk) q <= d;
endmodule