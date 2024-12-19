##################################################
#  Modelsim do file to run simuilation
#  MS 7/2015
##################################################

vlib work 
vmap work work

# include netlist and testbench files
vlog +acc -incr ../../RTL/top.v
vlog +acc -incr ../../RTL/AHB_Interface.v
vlog +acc -incr ../../RTL/APB_FSM.v
 
vlog +acc -incr top_tb.v 

# run simulation 
vsim +acc -t ps -lib work top_tb
do waveformat.do   
run -all
