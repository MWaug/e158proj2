module controller(input logic clk1, clk2, reset,
                  output logic dataClk1, dataClk2, clearAccum,
                  output logic[1:0] muxControl);

	//List of states
	parameter STATE_1 = 2'b00;
	parameter STATE_2 = 2'b01;
	parameter STATE_3 = 2'b10;
	parameter STATE_4 = 2'b11;

	// State registers
	reg [1:0] CurrentState ;
	reg [1:0] NextState ;

	// Register logic
	always@ ( clk1 ) begin
		if ( Reset ) CurrentState <= STATE_1;
		else CurrentState <= NextState;
	end

	// Next state logic
	always@ ( clk1 ) 
	begin
  		NextState = CurrentState ;
	    case ( CurrentState )
	 	    STATE_1 : NextState = STATE_2 ;
		    STATE_2 : NextState = STATE_3 ;
		    STATE_3 : NextState = STATE_4 ;
		    STATE_4 : NextState = STATE_1 ;
		default: next_state = START;
	    endcase
    end

    // Output logic
    always@ ( clk1 ) 
    begin
	    case ( CurrentState )
	 	    STATE_1 : 
	 	    begin 
		    	muxControl <= STATE_1;
		    	dataClk1 <= 0;
		    end
		    STATE_2 : 
	 	    begin 
		    	muxControl <= STATE_2;
		    	dataClk1 <= 0;
		    end
		    STATE_3 : 
	 	    begin 
		    	muxControl <= STATE_3;
		    	dataClk1 <= 0;
		    end
		    STATE_4 : 
	 	    begin 
		    	muxControl <= STATE_4;
		    	dataClk1 <= 1;
		    	clearAccum <= 1;
		    end
		default: muxControl <= STATE_1;
	    endcase
    end

endmodule