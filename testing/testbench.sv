// testbench.sv
module testbench();

  logic ph1, ph2, reset, shiftIn, shiftClk1, shiftClk2;
  logic [7:0] a, a0, a1, a2, a3, testa;
  logic [17:0] y;
  logic [17:0] result;

  // Example testvector
  // tv =      0   _   0    _00000000
  //     shiftClkEn, shiftIn,     a

  // Store the list of testvectors
  logic [9:0] testvector[2097151:0];
  logic [15:0] vecnum; // index of the current testvector
  logic [9:0] tv;      // current testvector
  logic[7:0] t0, t1, t2, t3;
  logic [31:0] errors;
  logic [31:0] correct;

  // Calculate the correct value given the test vectors
  always_comb 
  begin
    t0 = testvector[vecnum -4];
    t1 = testvector[vecnum -8];
    t2 = testvector[vecnum -12];
    t3 = testvector[vecnum -16];
    a0 = t0[7:0];
    a1 = t1[7:0];
    a2 = t2[7:0];
    a3 = t3[7:0];
    result = dut.dp.c0 * a0 + dut.dp.c1 * a1 + dut.dp.c2 * a2 + dut.dp.c3 * a3;
  end

  // instantiate device to be tested
  top dut(.*); 
  
  // initialize test
  initial
    begin
      // C:\Users\maxwaug\Google Drive\E 158\proj2\SourceTree\testing
      // $readmemb("C:/Users/maxwaug/Google Drive/E 158/proj2/SourceTree/testing/t1.v", testvector);
      $readmemb("D:/Max/Google Drive/E 158/proj2/SourceTree/testing/t1.v", testvector);
      vecnum = 0;
      errors = 0;
      correct = 0;
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
  always @(negedge dut.dataClk1)
  begin
    if(vecnum > 16) begin
      if( result !== y ) begin
        $display("Expected %d, actual %d", result, y);
        $display("c0 %d, c1 %d, c2 %d, c3 %d", 
          dut.dp.c0, dut.dp.c1, dut.dp.c2, dut.dp.c3);
        $display("a0 %d, a1 %d, a2 %d, a3 %d", a0, a1, a2, a3);
        $display("@%0dns",$time);
        errors = errors +1;
      end else begin
        correct = correct + 1:
      end
  end
  end
  
  logic shiftClkEn;
  // Make the second shift clock follow the first
  always_comb
  begin
    shiftClk1 = shiftClkEn & ph1;
    shiftClk2 = shiftClkEn & ph2;
  end

  // Increment through the testvectors
  always @(negedge ph1)
  begin
    tv = testvector[vecnum];
    a = tv[7:0];
    shiftIn = tv[8];
    shiftClkEn = tv[9];
    vecnum = vecnum +1;
  end

endmodule