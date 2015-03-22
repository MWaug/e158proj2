module regr #(parameter width = 8)
	(input logic clk1, clk2, 
	 input logic[width-1:0] d, 
	 output logic[width-1:0] q);
	logic[width-1:0] mid;
	latch l1(clk1, d, mid);
	latch l2(clk2, mid, q);
endmodule