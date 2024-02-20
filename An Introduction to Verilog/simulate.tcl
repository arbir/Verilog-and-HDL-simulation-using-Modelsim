puts {
  Verilog Test Project
}

set library_file_list {
  design_library {Codes/Mux.v
				  Codes/LFSR.v	
				  Codes/add4.v	
				  Codes/Inverter.v	
		}
  test_library   {Codes/TestBench.v}
}



# compilation
vlib work
foreach {library file_list} $library_file_list {
  foreach file $file_list {
    vlog $file
  }
}

# simulation
eval vsim -voptargs=+acc work.top

# show the waveforms
add wave -r /*
#add wave -r Mux_inputs  Mux_select Mux_out
#add wave -r clock Seed out

# run the simulation
run -all

#quit