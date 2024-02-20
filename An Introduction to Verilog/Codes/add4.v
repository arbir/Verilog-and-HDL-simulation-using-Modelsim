//A Full Adder

module add1 (co, s, a, b, c);

	input a, b, c ;
	output co, s ;

	
	//xor (out, in1, in2)
	xor (n1, a, b) ;
	xor (s, n1, c) ;
	//nand (out, in1, in2)
	nand (n2, a, b) ;
	nand (n3,n1, c) ;
	nand (co, n3,n2) ;
	
endmodule



//4-bit Adder 
module add4 (a,b,ci,s,c3);

	input [3:0] a,b ;	// port declarations
	input ci ;
	output [3:0] s ;	// vector
	output c3 ;
	
	wire [2:0] co ;
	
	add1 a0 (co[0], s[0], a[0], b[0], ci) ;
	add1 a1 (co[1], s[1], a[1], b[1], co[0]) ;
	add1 a2 (co[2], s[2], a[2], b[2], co[1]) ;
	add1 a3 (c3, s[3], a[3], b[3], co[2]) ;
	
endmodule

