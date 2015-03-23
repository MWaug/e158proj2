module top(input logic ph1, ph2, shiftClk1, shiftClk2,
					   shiftIn, reset,
           input logic [7:0] a,
           output logic [15:0] y);
    logic dataClk1, dataClk2, clearAccum, clearData;
    logic[1:0] muxControl;
    logic[7:0] coef, dOut;
    logic[15:0] multResult;

    datapath dp(.*);
    controller c(.*);
    multiplier #(8) m(coef, dOut, multResult);
endmodule