onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /APB_FSM_Controller_tb/Hclk
add wave -noupdate /APB_FSM_Controller_tb/Hresetn
add wave -noupdate /APB_FSM_Controller_tb/Hwrite
add wave -noupdate /APB_FSM_Controller_tb/valid
add wave -noupdate /APB_FSM_Controller_tb/Hwritereg

add wave -noupdate -radix hexadecimal /APB_FSM_Controller_tb/DUT.PRESENT_STATE
add wave -noupdate -radix hexadecimal /APB_FSM_Controller_tb/DUT.NEXT_STATE

add wave -noupdate -radix hexadecimal /APB_FSM_Controller_tb/Hwdata
add wave -noupdate -radix hexadecimal /APB_FSM_Controller_tb/Haddr
add wave -noupdate -radix hexadecimal /APB_FSM_Controller_tb/Haddr1
add wave -noupdate -radix hexadecimal /APB_FSM_Controller_tb/Haddr2
add wave -noupdate -radix hexadecimal /APB_FSM_Controller_tb/Hwdata1
add wave -noupdate -radix hexadecimal /APB_FSM_Controller_tb/Hwdata2
add wave -noupdate -radix hexadecimal /APB_FSM_Controller_tb/Prdata
add wave -noupdate -radix binary /APB_FSM_Controller_tb/tempselx

add wave -noupdate /APB_FSM_Controller_tb/Pwrite
add wave -noupdate /APB_FSM_Controller_tb/Penable
add wave -noupdate /APB_FSM_Controller_tb/Hreadyout

add wave -noupdate -radix binary /APB_FSM_Controller_tb/Pselx
add wave -noupdate -radix hexadecimal /APB_FSM_Controller_tb/Paddr
add wave -noupdate -radix hexadecimal /APB_FSM_Controller_tb/Pwdata

TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {3 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 223
configure wave -valuecolwidth 89
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ns} {12 ns}


