module sflop_8
	(input logic clk1, clk2, 
	 input logic sin, 
	 output logic[7:0] q);
	logic[7:0] mid;
	flop #(1) sreg0(clk1, clk2, sin,  q[0]);
	flop #(1) sreg1(clk1, clk2, q[0], q[1]);
	flop #(1) sreg2(clk1, clk2, q[1], q[2]);
	flop #(1) sreg3(clk1, clk2, q[2], q[3]);
	flop #(1) sreg4(clk1, clk2, q[3], q[4]);
	flop #(1) sreg5(clk1, clk2, q[4], q[5]);
	flop #(1) sreg6(clk1, clk2, q[5], q[6]);
	flop #(1) sreg7(clk1, clk2, q[6], q[7]);
endmodule