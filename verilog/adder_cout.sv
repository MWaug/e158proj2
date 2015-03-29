module adder_cout
	#(parameter width = 18) 
	(input logic [width-1:0] a, b,
	output logic [width-1:0] y,
	output logic cout);
	assign {cout, y} = a + b;
endmodule