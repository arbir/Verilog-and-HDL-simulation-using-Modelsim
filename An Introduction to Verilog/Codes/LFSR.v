`timescale 1ns / 1ps
//Linear Feedback Shift Register

module LFSR #(parameter width = 4) (clock, reset, seed, out);
  
  input clock;
  input reset;
  input [width-1:0] seed;

  output [width-1:0] out;
  
  reg [width-1:0] out;
  reg feedback;

  always @(reset)
		out = seed;

	always @ (posedge clock)
	begin
		// 4 bit LFSR - X4 + X3 + 1 => 3 4
		feedback = out[3]^out[2];
		out = { out[2], out[1], out[0], feedback};
    end				  
  
endmodule



module LFSR_2 #(parameter width = 4) (clk, rst, seed, data);

	input clk;
	input rst; 
	input [width-1:0] seed;
	output reg [width-1:0] data;
 
	reg [width-1:0] data_next;

	generate
	
		// 4 bit
		if (width==4)  
			always @* begin
			data_next = { data[2], data[1], data[0], data[3]^data[2]};
			end
		
		
		// 8 bit  
		if (width==8) 
			always @* begin
			data_next = { data[6], data[5], data[4], data[3], 			  
							data[2], data[1], data[0], data[7]^data[5]^data[2]^data[1]};
		end	
	
	endgenerate
	
	always @(posedge clk or posedge rst)
	if(rst)
		data <= seed;
	else
		data <= data_next; 
				  
  
endmodule 