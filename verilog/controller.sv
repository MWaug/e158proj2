// states and instructions
typedef enum logic [1:0] {STATE_1 = 2'b00,
							STATE_2 = 2'b01,
							STATE_3 = 2'b10,
							STATE_4 = 2'b11
							} statetype;

module controller(input logic ph1, ph2, reset,
                  output logic dataClk1, clearAccum,
                  output logic[1:0] muxControl);

	// State registers
	statetype state;

	statelogic statelog(ph1, ph2, reset, state);
	outputlogic outputlog(state, ph2, dataClk1, clearAccum, muxControl);

endmodule

module statelogic(input  logic     ph1, ph2, reset,
                  output statetype state);

      statetype nextstate;
      logic [1:0] state_logic;
  	  // 
	  flopr #(2) statereg(ph1, ph2, reset, nextstate, state_logic);
	  assign state = statetype'(state_logic);

	  // Next state logic
	  always_comb
	    begin
	      case (state)
	        STATE_1 : nextstate = STATE_2 ;
		    STATE_2 : nextstate = STATE_3 ;
		    STATE_3 : nextstate = STATE_4 ;
		    STATE_4 : nextstate = STATE_1 ;
	        default: nextstate = STATE_1; // should never happen
	      endcase
	    end
endmodule


module outputlogic(input statetype state,
				   input logic ph2,
                   output logic dataClk1, clearAccum,
                   output logic[1:0] muxControl);
    // Output logic
    always_comb
      begin
	    case (state)
	 	    STATE_1 : 
	 	    begin 
		    	muxControl = 2'b00;
		    	dataClk1 = 0;
		    	clearAccum = 0;
		    end
		    STATE_2 : 
	 	    begin 
		    	muxControl = 2'b01;
		    	dataClk1 = 0;
		    	clearAccum = 0;
		    end
		    STATE_3 : 
	 	    begin 
		    	muxControl = 2'b10;
		    	dataClk1 = 0;
		    	clearAccum = 0;
		    end
		    STATE_4 : 
	 	    begin 
		    	muxControl = 2'b11;
		    	dataClk1 = ph2;
		    	clearAccum = 1;
		    end
		default: muxControl = 2'b00;
	    endcase
      end
endmodule