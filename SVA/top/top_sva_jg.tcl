clear -all

analyze -sv09 top_sva.sv
analyze -sv09 ../../RTL/top.v
analyze -sv09 ../../RTL/AHB_Interface.v
analyze -sv09 ../../RTL/APB_FSM.v
elaborate -top Bridge_Top

clock clk
reset ~rst
