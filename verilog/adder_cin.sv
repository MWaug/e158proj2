module adder_cin
	#(parameter width = 18) 
	(input logic [width-1:0] a, b,
	input logic cin,
	output logic [width-1:0] y);
	assign y = a + b + cin;
endmodule