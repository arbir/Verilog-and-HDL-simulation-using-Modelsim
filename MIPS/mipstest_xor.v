// Test MIPS together with memory
// Erik Brunvand
// ----------------------------------------------------------------

module top #(parameter WIDTH=8, REGBITS=3)();
   reg clk = 0;
   reg reset = 1;

   // dut
   mips_mem #(WIDTH,REGBITS) dut(clk, reset);

   initial
     begin
	reset <= 1;
	#22 reset <= 0;
	#4000 $stop;
     end

   always
     #5 clk <= ~clk;

   // Check data
   always @(negedge clk)
     begin
	if (dut.memwrite)
	  if (dut.adr == 8'hee & dut.writedata == 8'hF2)
	    $display("**** Fibonacci with XOR Simulation was successful!!!****");
	  else begin
	     $display("Fibonacci Simulation has failed");
	     $display("Data at address EE should be F2");
	  end
     end
endmodule // top
