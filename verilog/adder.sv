module adder
	#(parameter width = 18) 
	(input logic [width-1:0] a, b,
	output logic [width-1:0] y);
	assign y = a + b;
endmodule