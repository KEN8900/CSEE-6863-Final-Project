##################################################
#  Modelsim do file to run simuilation
#  MS 7/2015
##################################################

vlib work 
vmap work work

# include netlist and testbench files
vlog +acc -incr ../../RTL/APB_Controller.v
 
vlog +acc -incr APB_Controller_tb.v 

# run simulation 
vsim +acc -t ps -lib work APB_FSM_Controller_tb
do waveformat.do   
run -all
