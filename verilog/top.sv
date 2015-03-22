module top(input logic clk1, clk2, shiftClk, shiftIn, reset,
           input logic [7:0] a,
           output logic [15:0] y);
    logic dataClk1, dataClk2, clearAccum, clearData;
    logic[1:0] muxControl;
    logic[7:0] coef, muxOut;
    logic[15:0] multResult;

    dp datapath(.*);
    c controller(.*);
    m #(8) multiplier(coef, muxOut, multResult);
endmodule