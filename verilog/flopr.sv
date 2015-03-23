module flopr #(parameter WIDTH = 8)
                (input  logic             ph1, ph2, reset, 
                 input  logic [WIDTH-1:0] d,
                 output logic [WIDTH-1:0] q);

  logic [WIDTH-1:0] d2, resetval;

  assign resetval = 0;

  mux2 #(WIDTH) enrmux(d, resetval, reset, d2);
  flop #(WIDTH) f(ph1, ph2, d2, q);
endmodule

