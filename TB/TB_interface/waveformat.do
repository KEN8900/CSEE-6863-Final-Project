onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /AHB_slave_interface_tb/clk
add wave -noupdate /AHB_slave_interface_tb/rst
add wave -noupdate /AHB_slave_interface_tb/Hwrite
add wave -noupdate /AHB_slave_interface_tb/Hreadyin
add wave -noupdate /AHB_slave_interface_tb/valid
add wave -noupdate /AHB_slave_interface_tb/Hwritereg
add wave -noupdate -radix unsigned /AHB_slave_interface_tb/Htrans
add wave -noupdate -radix unsigned /AHB_slave_interface_tb/Haddr
add wave -noupdate -radix unsigned /AHB_slave_interface_tb/Hwdata
add wave -noupdate -radix unsigned /AHB_slave_interface_tb/Prdata
add wave -noupdate -radix unsigned /AHB_slave_interface_tb/Haddr1
add wave -noupdate -radix unsigned /AHB_slave_interface_tb/Haddr2
add wave -noupdate -radix unsigned /AHB_slave_interface_tb/Hwdata1
add wave -noupdate -radix unsigned /AHB_slave_interface_tb/Hwdata2
add wave -noupdate -radix unsigned /AHB_slave_interface_tb/Hrdata
add wave -noupdate -radix unsigned /AHB_slave_interface_tb/tempselx
add wave -noupdate -radix unsigned /AHB_slave_interface_tb/Hresp
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


