# Create work library
vlib work

# Compile Verilog
#     All Verilog files that are part of this design should have
#     their own "vlog" line below.

# Lab1 
vlog "./mux_2x1.sv"
vlog "./mux_4x1.sv"
vlog "./mux_8x1.sv"
vlog "./mux_16x1.sv"
vlog "./mux_32x1.sv"
vlog "./mux_64_32x1.sv"

vlog "./decoder_1x2.sv"
vlog "./decoder_2x4.sv"
vlog "./decoder_3x8.sv"
vlog "./decoder_5x32.sv"

vlog "./regfile.sv"
vlog "./regstim.sv"

vlog "./D_FF.sv"
vlog "./D_FF_new.sv"


# Lab 2
vlog "./alustim.sv"
vlog "./alu.sv"
vlog "./alu_1bit.sv"

vlog "./zerocheck_8bit.sv"
vlog "./zeroFlag.sv"

vlog "./fullAdder_1bit.sv"

# Lab 3
vlog "./datamem.sv"
vlog "./instructmem.sv"
vlog "./mult.sv"
vlog "./controlUnit.sv"
vlog "./CPU.sv"
vlog "./mux_5_2x1.sv"
vlog "./pc.sv"
vlog "./signExtender.sv"
vlog "./ZeroExtender.sv"
vlog "./mux_64_2x1.sv"
vlog "./CPUstim.sv"

# Lab 4
vlog "./D_FF_64.sv"
vlog "./D_FF_5.sv"
vlog "./D_FF_3.sv"
vlog "./D_FF_32.sv"
vlog "./mux_64_4x1.sv"
vlog "./ForwardingUnit.sv"
vlog "./D_FF_9.sv"
vlog "./D_FF_12.sv"
vlog "./D_FF_new_NEG.sv"
vlog "./Hazard_Detection_Unit.sv"





# Call vsim to invoke simulator
#     Make sure the last item on the line is the name of the
#     testbench module you want to execute.
vsim -voptargs="+acc" -t 1ps -lib work CPUstim

# Source the wave do file
#     This should be the file that sets up the signal window for
#     the module you are testing.
do CPU_wave.do

# Set the window types
view wave
view structure
view signals

# Run the simulation
run -all

# End
