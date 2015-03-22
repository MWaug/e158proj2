module mux4
	#(parameter width = 8)
	(input logic [width-1:0] d0, d1, d2, d3,
	input logic [1:0] s,
	output logic [width-1:0] y);
	logic [width-1:0] low, hi;
	mux2 #(width) lowmux(d0, d1, s[0], low);
	mux2 #(width) himux(d2, d3, s[0], hi);
	mux2 #(width) outmux(low, hi, s[1], y);
endmodule