//Transistor-level Inverter

module Inverter (a, out);

	input a;
	output out ;

	wire out;

	pmos p1(out, 1, a); //pmos	
	nmos n1(out, 0, a); //nmos


endmodule
