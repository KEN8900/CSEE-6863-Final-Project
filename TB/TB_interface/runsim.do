##################################################
#  Modelsim do file to run simuilation
#  MS 7/2015
##################################################

vlib work 
vmap work work

# include netlist and testbench files
vlog +acc -incr ../../RTL/AHB_Interface.v
 
vlog +acc -incr AHB_Slave_Interface_tb.v 

# run simulation 
vsim +acc -t ps -lib work AHB_slave_interface_tb
do waveformat.do   
run -all
