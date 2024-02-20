//There are two basic forms of the assignment:
//the continuous assignment, which assigns values to nets
//the procedural assignment, which assigns values to registers

//There are two types of code in most HDLs:
//Structural, which is a verbal wiring diagram without storage.
//assign a=b & c | d;

//Procedural which is used for circuits with storage, or as a convenient way to write conditional logic.
//Procedural code is written like c code and assumes every assignment is stored in memory until over written.
//people prefer procedural code because it is usually much easier to write,
// for example, if and case statements are only allowed in procedural code.

//always @(posedge clk) // Execute the next statement on every rising clock edge.
// count <= count+1; 

module half_adder1(x, y, sum, carry);

	input x;
	input y;
	output sum;
	output carry;

	assign sum = x ^ y;
	assign carry = x & y;

endmodule

module half_adder2(A, B, Sum, C_out);

	input A;
	input B;
	output Sum;
	output C_out;
	
	//Basic Logic gates in Verilog:
	//and, or, not, but, xor, nand, nor, xnor
	
	xor(Sum, A, B);
	and(C_out, A, B);

endmodule


module smpl_circuit (A,B,C,x,y);

		input A,B,C;
		output x,y;
		wire e;
		
		and g1(e,A,B);
		not g2(y,C);
		or g3(x,e,y);
		
endmodule

module circuit_bln (x, y, A, B, C, D);

	input A,B,C,D;
	output x,y;
	
	assign x = A | (B & C) | (~B & D);
	assign y = (~B & C) | (B & ~C & ~D);
	
endmodule


