puts {
  A Simple Compile and Simulation Script
  Provided by HASSAN NAJAFI
}

set library_file_list {
  design_library {mips.v
		exmem.v
		mipsmem.v		}
  test_library   {mipstest.v}
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

# run the simulation
run -all

