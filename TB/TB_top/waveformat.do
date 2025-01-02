onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /top_tb/clk
add wave -noupdate /top_tb/rst
add wave -noupdate /top_tb/Hwrite
add wave -noupdate /top_tb/Hreadyin
add wave -noupdate /top_tb/Htrans

add wave -noupdate -radix hexadecimal /top_tb/Hwdata
add wave -noupdate -radix hexadecimal /top_tb/Haddr
add wave -noupdate -radix hexadecimal /top_tb/Prdata

add wave -noupdate /top_tb/Pwrite
add wave -noupdate /top_tb/Penable
add wave -noupdate /top_tb/Hreadyout

add wave -noupdate -radix binary /top_tb/Pselx
add wave -noupdate -radix hexadecimal /top_tb/Paddr
add wave -noupdate -radix hexadecimal /top_tb/Pwdata
add wave -noupdate -radix hexadecimal /top_tb/Hrdata

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


