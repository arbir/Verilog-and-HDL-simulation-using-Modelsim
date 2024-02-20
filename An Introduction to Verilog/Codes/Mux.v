//Function: 4-to-1 Multiplexer using Case

module Multiplexer (In, Select, Out);
	
	input [3:0] In;
	input [1:0] Select;
	output reg Out;
	
	always @ (*) begin 
		case (Select)
			2'b00:	Out <= In[0];
			2'b01:	Out <= In[1];
			2'b10:	Out <= In[2];
			2'b11:	Out <= In[3];
		endcase
	end
	
endmodule


// Function    : 2:1 Mux using Assign

module  mux_using_assign(
	din_0      , // Mux first input
	din_1      , // Mux Second input
	sel        , // Select input
	mux_out      // Mux output
	);
	
	input din_0, din_1, sel ;
	output mux_out;
	wire  mux_out;
	
	assign mux_out = (sel) ? din_1 : din_0;

endmodule //End Of Module mux


// Function    : 2:1 Mux using If

module  mux_using_if(
din_0      , // Mux first input
din_1      , // Mux Second input
sel        , // Select input
mux_out      // Mux output
);

	input din_0, din_1, sel ;
	output mux_out;
	reg  mux_out; //because the value is set inside an always block we need to define a reg

	always @ (sel or din_0 or din_1)
	begin : MUX
	  if (sel == 1'b0) begin
		  mux_out = din_0;
	  end else begin
		  mux_out = din_1 ;
	  end
	end

endmodule //End Of Module mux


// Function    : 2:1 Mux using Case
module  mux_using_case(
din_0      , // Mux first input
din_1      , // Mux Second input
sel           , // Select input
mux_out   // Mux output
);

input din_0, din_1, sel ;
output mux_out;
reg  mux_out;

always @ (sel or din_0 or din_1)
	begin : MUX
	 case(sel ) 
		1'b0 : mux_out = din_0;
		1'b1 : mux_out = din_1;
	 endcase 
	end

endmodule //End Of Module mux