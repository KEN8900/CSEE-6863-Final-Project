clear -all

analyze -sv09 APB_FSM_sva.sv
analyze -sv09 ../RTL/APB_FSM.v
elaborate -top APB_FSM

clock clk
reset ~rst
