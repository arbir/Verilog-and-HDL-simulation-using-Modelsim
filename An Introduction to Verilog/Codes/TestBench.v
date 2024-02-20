`timescale 1ns / 1ps


module top ();
	
	//Comments with two slashes //
	//Recommended editor: Notepad++
	
	//------------------ Verilog Language Syntax --------------
	// Verilog 1995
	// Verilog 2001 (fixed many shortcomings Verilog 95 had)
	// SystemVerilog (is a super-set of Verilog 2001, born from the need to unify design and verification)
	
	//------------------ Verilog Compiler and Simulators ------
	//	Questa (Siemens)
	//		Free starter version from Intel website
	//	VCS (Synopsys)
	//  Incisive Enterprise Simulator (Cadence)
	//	ISE Simulator, Vivado Simulator (Xilinx)
	
	//-----------------  Value Set ----------------------------
	//  Verilog consists of four basic values 
	//  0 (false)
	//  1 (true)
	//  x (unknown)
	//  z (high impedance, unconnected, tri-state) 
	//---------------------------------------------------------

	//Number Syntax : n’Fddd..., 
	// where n - integer representing number of bits 
	// F - Four possible base formats. Default is d. 
	//		b (binary), 01xXzZ
	//		o (octal), 0-7xXzZ
	//		d (decimal), 0-9
	//		h (hexadecimal), 0-9a-fA-FxXzZ	
	// A = 5’b01011 // 5-bit binary number
	// A = 20’hB36F // 20-bit hexadecimal number
	// A = 267; // 32-bit decimal number
	
	
	//------------------ Operators ----------------------------
	//  + (addition) - (subtraction) * (multiplication)  / (division)  % (modulus)
	//  Relational Operators: < (less than) <= (less than or equal to)  == (equal to)  != (not equal to)
	//  Bit-wise Operators:  ~ (bitwise NOT) & (bitwise AND) | (bitwiseOR) ^ (bitwise XOR)
	//  Shift:  << (shift left)  >> (shift right)
	//  Conditional Operator : (cond) ? (result if cond true):(result if cond false) a = (g) ? x : y;
	//---------------------------------------------------------
	
	//Two main types of Verilog Variables:
	// Wire: all output of "assign" statements must be wires
	// Reg: all outputs of the "always" and "initial" blocks must be reg
	//Both can be used as inputs anywhere
	
	
	//Wire
	//A wire represents a physical wire in a circuit and is used to connect gates or modules. 
	//The value of a wire or reg can be read, but cannot "assign" to a reg
	wire C_net;
	wire [9:0] C_array;  //a 10-bit Bus  
	
	//Bit Select and Part select
	// A = C_array[2];
	// A[3:0] = C_array [9:6];
	
	//Reg
	reg A, B, C ;
	reg [9:0] Array ;
	
	//Register types: reg, integer, time, real
	//Should be careful about synthesizing
	integer A_int, B_int, C_int, Cycle_counter;
	real A_real, B_real;
	
	//2 Kinds of Behavioral Keywords : initial, always
	//Assigned Values Only within always or initial statement
	//Keywords Followed by a Statement of Block
	//initial:  Scheduled to Simulate at time=0 Only
	//	Is used to Initiate a Simulation
	//	Mainly used in TestBench and testing
	//	No practical for implementations

		
	// Block is a group of statements enclosed by "begin" and "end" Keywords
	// We can have more than one initial or always in a module
	// Statements within a block execute sequentially : unless you control them with delays
    initial begin
		B_int = 10;
		C_int = 40;
	end
	
	// Blocking assignments : Sequentially
	// A blocking statement must be executed before the execution of the statements that follow it in a sequential block.
	// Not synthesizable! (cannot synthesize delay!)
    initial begin
      A = #10 1'b1;// The simulator assigns 1 to A at time 10
      B = #20 1'b0;// The simulator assigns 0 to B at time 30
      C = #40 1'b1;// The simulator assigns 1 to C at time 70
    end
	
	// Non-Blocking assignments : More similar to actual hardware
	// make several register assignments within the same time step without regard to order
	//initial begin
	//	d <=   1'b1;// The simulator assigns 1 to d at time 0
	//	e <=   1'b0;// The simulator assigns 0 to e at time 0
	//	f <=   1'b1;// The simulator assigns 1 to f at time 0
	//end

	//Parameters allows constants like word length to be defined symbolically in one place.
	//This makes it easy to change the word length later, by change only the parameter.
	parameter Sample_parameters = 4;


	reg clock;	
	reg reset;
	
	//If the statement is only one line, no need to use "begin","end"
	always @(clock) #2 clock <= ~clock;

	initial begin	
			
		   clock = 1;
		   reset <= 1;
		#2 reset <= 0;
		
		A_real = 1.23;
		Cycle_counter = 0;
	end	
	
	
	initial $display ("Hello World ...... ");
	
	
	//----------------Testing 4-bit adder module ---------------------
	
	reg [3:0] add4_a, add4_b;
	reg add4_cin;
	wire [3:0] add4_sum;
	wire add4_cout;
	
	//We must instantiate a module to use it
	add4 add4_ins1 (add4_a,add4_b,add4_cin,add4_sum,add4_cout);
		
	initial begin
		add4_a = 4'b0110; //6
		add4_b = 4'b0101; //5
		add4_cin = 1'b0;
	#1	$display ("The Inputs of add4 is: a:%d, b:%d, cin:%d ",add4_a,add4_b,add4_cin );
		$display ("The Output of add4 is: %b or %d,%b ",add4_sum,add4_sum,add4_cout );
	end
	//----------------End of Testing 4-bit adder module --------------
	
	
	// ################# MUX 4-1 ########################################
	
	reg [3:0] Mux_inputs;
	reg [1:0] Mux_select;
	wire Mux_out;
	
	Multiplexer   Mul_ins   (Mux_inputs, Mux_select, Mux_out);
	
	initial begin
		Mux_inputs = 4'b1000;          
		Mux_select = 2'b11;//test with 2'b11 or 2'b00
		
	#1	$display ("The Output of MUX is: %b ",Mux_out );
	end
	
	
	
	
	
	// ################# LFSR ########################################
	parameter WIDTH = 4;
	reg  [WIDTH-1:0] Seed;
	wire [WIDTH-1:0] LFSR_out;
	
	initial Seed = $urandom();
	
	//Modules are instantiated inside other modules, and each instantiation creates
	//a unique object from the template. The exception is the top-level
	//module which is its own instantiation.
	//This example : Parametrized Modules : specify the value of the parameter at each instantiation of the module
	
	LFSR #(WIDTH) LFSR_instantiate_1  (clock, reset, Seed, LFSR_out);
	


	always @(posedge clock)
	begin
	
		$display ("LFSR output at cycle %d: %b ",Cycle_counter, LFSR_out );
	
		if (Cycle_counter==10) 
		begin
				$finish;
				$stop;		
		end
		
		Cycle_counter = Cycle_counter + 1;
	end

	 

  	

endmodule // top