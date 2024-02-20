
module exmem #(parameter WIDTH = 8, RAM_ADDR_BITS = 8)
   (input clk, en,
    input memwrite,
    input [RAM_ADDR_BITS-1:0] adr,
    input [WIDTH-1:0] writedata,
    output reg [WIDTH-1:0] memdata
    );

   reg [WIDTH-1:0] mips_ram [(2**RAM_ADDR_BITS)-1:0];

 initial

 // The following $readmemh statement is only necessary if you wish
 // to initialize the RAM contents via an external file (use
 // $readmemb for binary data). The fib.dat file is a list of bytes,
 // one per line, starting at address 0.  
   
 $readmemh("fib.dat", mips_ram);
 
 // Note that the RAM is clocked. Reading
 // and writing happen on the rising clock edge. This is very important
 // to keep in mind when you're using the RAM in your system! 
   always @(negedge clk)
      if (en) begin
         if (memwrite)
            mips_ram[adr] <= writedata;
         memdata <= mips_ram[adr];
      end
						
endmodule
