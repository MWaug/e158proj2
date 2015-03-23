// states and instructions
typedef enum logic [1:0] {STATE_1 = 2'b00,
							STATE_2 = 2'b01,
							STATE_3 = 2'b10,
							STATE_4 = 2'b11,
							} statetype;

module controller(input logic clk1, clk2, reset,
                  output logic dataClk1, dataClk2, clearAccum,
                  output logic[1:0] muxControl);

	// State registers
	statetype state;

	statelogic statelog(clk1, clk2, reset, state);
	outputlogic outputlog(state, dataClk1, dataClk2, clearAccum, muxControl);

endmodule

module statelogic(input  logic     clk1, clk2, reset,
                  output statetype state);

      statetype nextstate;
  	  logic [1:0] nextstate, state_logic;

  	  // 
	  regr #(2) statereg(clk1, clk2, nextstate, state_logic);

	  assign state = statetype'(state_logic);

	  // Next state logic
	  always_comb
	    begin
	      case (CurrentState)
	        STATE_1 : nextstate = STATE_2 ;
		    STATE_2 : nextstate = STATE_3 ;
		    STATE_3 : nextstate = STATE_4 ;
		    STATE_4 : nextstate = STATE_1 ;
	        default: nextstate = STATE_1; // should never happen
	      endcase
	    end
endmodule


module outputlogic(input statetype state,
                   output logic dataClk1, dataClk2, clearAccum,
                   output logic[1:0] muxControl);
    // Output logic
    always_comb
      begin
	    case (state)
	 	    STATE_1 : 
	 	    begin 
		    	muxControl = 2b'00;
		    	dataClk1 = 0;
		    end
		    STATE_2 : 
	 	    begin 
		    	muxControl = 2b'01;
		    	dataClk1 = 0;
		    end
		    STATE_3 : 
	 	    begin 
		    	muxControl = 2b'10;
		    	dataClk1 = 0;
		    end
		    STATE_4 : 
	 	    begin 
		    	muxControl = 2b'11;
		    	dataClk1 = 1;
		    	clearAccum = 1;
		    end
		default: muxControl = 2b'00;
	    endcase
      end
endmodule