module datapath(input logic clk1, clk2, shiftIn, shiftClk1, shiftClk2,
				reset, dataClk1, dataClk2, clearAccum, 
				input logic[1:0]  muxControl,
				input logic[15:0] multResult,
				input logic[7:0]  a,
				output logic[7:0] coef, dOut,
				output logic[15:0] y);
	logic s1, s2, s3;
	logic [7:0] a1, a2, a3, c0, c1, c2, c3;
	logic [17:0] accum;
	mux4 #(8) m4d( a, a1, a2, a3, muxControl, dOut);	
	mux4 #(8) m4c(c0, c1, c2, c3, muxControl, coef);	
	adder #(18) add(multResult, accumQ, accumD);

	// Data delay registers
	regr #(8) d1(dataClk1, dataClk2, clearData, a, a1);
	regr #(8) d2(dataClk1, dataClk2, clearData, a1, a2);
	regr #(8) d3(dataClk1, dataClk2, clearData, a2, a3);

	// Coefficient shift registers
	sregr_8 c0reg(shiftClk1, shiftClk2, shiftIn, c0);
	sregr_8 c1reg(shiftClk1, shiftClk2, c0[7], c1);
	sregr_8 c2reg(shiftClk1, shiftClk2, c1[7], c2);
	sregr_8 c3reg(shiftClk1, shiftClk2, c2[7], c3);

	// Accumulate register
	regr #(18) acc(clk1, clk2, clearAccum, accumD, accumQ);

	// Output register
	regr #(16) r(dataClk1, dataClk2, clearData, accumQ, y);

endmodule