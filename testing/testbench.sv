// testbench.sv
module testbench();

  logic ph1, ph2, reset, shiftIn, shiftClk1, shiftClk2;
  logic [7:0] a, a0, a1, a2, a3, testa;
  logic [15:0] y;
  logic [17:0] accum;
  logic [15:0] result;

  // Example testvector
  // tv =      0   _   0    _00000000
  //     shiftph1, shiftIn,     a

  // Store the list of testvectors
  logic [9:0] testvector[2097151:0];
  logic [15:0] vecnum; // index of the current testvector
  logic [9:0] tv;      // current testvector
  assign result = accum[17:2];

  // instantiate device to be tested
  top dut(.*); 
  
  // initialize test
  initial
    begin
      // C:\Users\maxwaug\Google Drive\E 158\proj2\SourceTree\testing
      $readmemb("C:/Users/maxwaug/Google Drive/E 158/proj2/SourceTree/testing/t1.v", testvector);
      vecnum = 0;
      reset <= 1; # 20; reset <= 0;
    end

  // generate clock to sequence tests
  always
    begin
     ph1 = 0; ph2 = 0; #1;
     ph1 = 1; # 4;
     ph1 = 0; #1;
     ph2 = 1; # 4;
    end

  // Check results on each new data cycle
  always @(negedge dut.dataClk2)
  begin
    a3 = a2;
    a2 = a1;
    a1 = a0;
    a0 = a;
    accum = dut.dp.c0 * a0 + dut.dp.c1 * a1 + dut.dp.c2 * a2 + dut.dp.c3 * a3;
    if( result !== y ) begin
      $display("Expected %d, actual %d", result, y);
      $display("c0 %d, c1 %d, c2 %d, c3 %d", 
        dut.dp.c0, dut.dp.c1, dut.dp.c2, dut.dp.c3);
      $display("a0 %d, a1 %d, a2 %d, a3 %d", a0, a1, a2, a3);
      $display("@%0dns",$time);
    end
  end

  // Make the second shift clock follow the first
  always @(negedge shiftClk1)
  begin
    shiftClk2 <= 1; 
  end
  always @(posedge shiftClk1)
  begin
    shiftClk2 <= 0;
  end

  // Increment through the testvectors
  always @(negedge ph1)
  begin
    tv = testvector[vecnum];
    a = tv[7:0];
    shiftIn = tv[8];
    shiftClk1 = tv[9];
    vecnum = vecnum +1;
  end

endmodule