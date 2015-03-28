module datapath(input logic ph1, ph2, shiftIn, shiftClk1, shiftClk2,
				reset, enData, clearAccum, 
				input logic[1:0]  muxControl,
				input logic[15:0] multResult,
				input logic[7:0]  a,
				output logic[7:0] coef, dOut,
				output logic[17:0] y);
	logic s1, s2, s3;
	logic [7:0] a0, a1, a2, a3, c0, c1, c2, c3;
	logic [17:0] accumQ, accumD;

	// Mux's to select the coefficient and data
	mux4 #(8) m4d( a0, a1, a2, a3, muxControl, dOut);	
	mux4 #(8) m4c(c0, c1, c2, c3, muxControl, coef);	

	// 18 bit adder
		// Separate these into 8 and 10 bit flop
	adder #(18) add({2'b00, multResult}, accumQ, accumD);

	// Data delay registers
	// Fix this - clock enable
	flopenr #(8) d0(ph1, ph2, reset, enData, a, a0);
	flopenr #(8) d1(ph1, ph2, reset, enData, a0, a1);
	flopenr #(8) d2(ph1, ph2, reset, enData, a1, a2);
	flopenr #(8) d3(ph1, ph2, reset, enData, a2, a3);

	// Coefficient shift registers
	sflop_8 c0reg(shiftClk1, shiftClk2, shiftIn, c0);
	sflop_8 c1reg(shiftClk1, shiftClk2, c0[7], c1);
	sflop_8 c2reg(shiftClk1, shiftClk2, c1[7], c2);
	sflop_8 c3reg(shiftClk1, shiftClk2, c2[7], c3);

	// Accumulate register
	// Separate these into 8 and 10 bit flop
	flopr #(18) acc(ph1, ph2, clearAccum, accumD, accumQ);

	// Output register
	// Fix this with enabled flops
	flopenr #(18) r(ph1, ph2, reset, enData, accumD, y);

endmodule