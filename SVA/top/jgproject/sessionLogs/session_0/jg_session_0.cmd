# ----------------------------------------
# Jasper Version Info
# tool      : Jasper 2024.06
# platform  : Linux 4.18.0-553.30.1.el8_10.x86_64
# version   : 2024.06p002 64 bits
# build date: 2024.09.02 16:28:38 UTC
# ----------------------------------------
# started   : 2024-12-17 14:33:39 EST
# hostname  : micro03.(none)
# pid       : 3921360
# arguments : '-label' 'session_0' '-console' '//127.0.0.1:42777' '-style' 'windows' '-data' 'AAAAfnicY2RgYLCp////PwMYMD6A0Aw2jAyoAMRnQhUJbEChGRhYYZqRNYkxlDDkMxQwxDMUM5QxJDLoAfnJDDlgeQDxagtE' '-proj' '/homes/user/stud/fall23/ym3000/6863/CSEE-6863-Final-Project/SVA/top/jgproject/sessionLogs/session_0' '-init' '-hidden' '/homes/user/stud/fall23/ym3000/6863/CSEE-6863-Final-Project/SVA/top/jgproject/.tmp/.initCmds.tcl' 'top_sva.tcl'
clear -all

analyze -sv09 top_sva.sv
analyze -sv09 ../../RTL/top.v
analyze -sv09 ../../RTL/AHB_Interface.v
analyze -sv09 ../../RTL/APB_FSM.v
elaborate -top Bridge_Top

clock clk
reset ~rst
prove -bg -all
visualize -violation -property <embedded>::Bridge_Top.chk_top.Read_addr0 -new_window
include /homes/user/stud/fall23/ym3000/6863/CSEE-6863-Final-Project/SVA/top/top_sva.tcl
prove -bg -all
visualize -violation -property <embedded>::Bridge_Top.chk_top.Read_addr0 -new_window
include /homes/user/stud/fall23/ym3000/6863/CSEE-6863-Final-Project/SVA/top/top_sva.tcl
prove -bg -all
include /homes/user/stud/fall23/ym3000/6863/CSEE-6863-Final-Project/SVA/top/top_sva.tcl
prove -bg -all
include /homes/user/stud/fall23/ym3000/6863/CSEE-6863-Final-Project/SVA/top/top_sva.tcl
prove -bg -all
visualize -violation -property <embedded>::Bridge_Top.chk_top.Read_after_write -new_window
include /homes/user/stud/fall23/ym3000/6863/CSEE-6863-Final-Project/SVA/top/top_sva.tcl
include /homes/user/stud/fall23/ym3000/6863/CSEE-6863-Final-Project/SVA/top/top_sva.tcl
include /homes/user/stud/fall23/ym3000/6863/CSEE-6863-Final-Project/SVA/top/top_sva.tcl
prove -bg -all
include /homes/user/stud/fall23/ym3000/6863/CSEE-6863-Final-Project/SVA/top/top_sva.tcl
include /homes/user/stud/fall23/ym3000/6863/CSEE-6863-Final-Project/SVA/top/top_sva.tcl
prove -bg -all
include /homes/user/stud/fall23/ym3000/6863/CSEE-6863-Final-Project/SVA/top/top_sva.tcl
prove -bg -all
visualize -violation -property <embedded>::Bridge_Top.chk_top.Write_Penable2 -new_window
include /homes/user/stud/fall23/ym3000/6863/CSEE-6863-Final-Project/SVA/top/top_sva.tcl
prove -bg -all
visualize -violation -property <embedded>::Bridge_Top.chk_top.Burst_write_addr0 -new_window
include /homes/user/stud/fall23/ym3000/6863/CSEE-6863-Final-Project/SVA/top/top_sva.tcl
prove -bg -all
visualize -violation -property <embedded>::Bridge_Top.chk_top.Burst_write_addr0 -new_window
include /homes/user/stud/fall23/ym3000/6863/CSEE-6863-Final-Project/SVA/top/top_sva.tcl
include /homes/user/stud/fall23/ym3000/6863/CSEE-6863-Final-Project/SVA/top/top_sva.tcl
prove -bg -all
include /homes/user/stud/fall23/ym3000/6863/CSEE-6863-Final-Project/SVA/top/top_sva.tcl
prove -bg -all
include /homes/user/stud/fall23/ym3000/6863/CSEE-6863-Final-Project/SVA/top/top_sva.tcl
prove -bg -all
include /homes/user/stud/fall23/ym3000/6863/CSEE-6863-Final-Project/SVA/top/top_sva.tcl
include /homes/user/stud/fall23/ym3000/6863/CSEE-6863-Final-Project/SVA/top/top_sva.tcl
prove -bg -all
include /homes/user/stud/fall23/ym3000/6863/CSEE-6863-Final-Project/SVA/top/top_sva.tcl
prove -bg -all
visualize -violation -property <embedded>::Bridge_Top.chk_top.Write_after_read_addr -new_window
include /homes/user/stud/fall23/ym3000/6863/CSEE-6863-Final-Project/SVA/top/top_sva.tcl
include /homes/user/stud/fall23/ym3000/6863/CSEE-6863-Final-Project/SVA/top/top_sva.tcl
prove -bg -all
include /homes/user/stud/fall23/ym3000/6863/CSEE-6863-Final-Project/SVA/top/top_sva.tcl
prove -bg -all
visualize -property <embedded>::Bridge_Top.chk_top._assume_7:precondition1 -new_window
include /homes/user/stud/fall23/ym3000/6863/CSEE-6863-Final-Project/SVA/top/top_sva.tcl
prove -bg -all
include /homes/user/stud/fall23/ym3000/6863/CSEE-6863-Final-Project/SVA/top/top_sva.tcl
include /homes/user/stud/fall23/ym3000/6863/CSEE-6863-Final-Project/SVA/top/top_sva.tcl
prove -bg -all
include /homes/user/stud/fall23/ym3000/6863/CSEE-6863-Final-Project/SVA/top/top_sva.tcl
prove -bg -all
include /homes/user/stud/fall23/ym3000/6863/CSEE-6863-Final-Project/SVA/top/top_sva.tcl
prove -bg -all
include /homes/user/stud/fall23/ym3000/6863/CSEE-6863-Final-Project/SVA/top/top_sva.tcl
prove -bg -all
include /homes/user/stud/fall23/ym3000/6863/CSEE-6863-Final-Project/SVA/top/top_sva.tcl
prove -bg -all
include /homes/user/stud/fall23/ym3000/6863/CSEE-6863-Final-Project/SVA/top/top_sva.tcl
prove -bg -all
visualize -violation -property <embedded>::Bridge_Top.chk_top.Write_data_transfer -new_window
include /homes/user/stud/fall23/ym3000/6863/CSEE-6863-Final-Project/SVA/top/top_sva.tcl
include /homes/user/stud/fall23/ym3000/6863/CSEE-6863-Final-Project/SVA/top/top_sva.tcl
prove -bg -all
visualize -violation -property <embedded>::Bridge_Top.chk_top.Single_read_check -new_window
include /homes/user/stud/fall23/ym3000/6863/CSEE-6863-Final-Project/SVA/top/top_sva.tcl
include /homes/user/stud/fall23/ym3000/6863/CSEE-6863-Final-Project/SVA/top/top_sva.tcl
prove -bg -all
visualize -violation -property <embedded>::Bridge_Top.chk_top.Single_read_check -new_window
include /homes/user/stud/fall23/ym3000/6863/CSEE-6863-Final-Project/SVA/top/top_sva.tcl
prove -bg -all
include /homes/user/stud/fall23/ym3000/6863/CSEE-6863-Final-Project/SVA/top/top_sva.tcl
prove -bg -all
visualize -violation -property <embedded>::Bridge_Top.chk_top.Write_Penable2 -new_window
include /homes/user/stud/fall23/ym3000/6863/CSEE-6863-Final-Project/SVA/top/top_sva.tcl
prove -bg -all
visualize -violation -property <embedded>::Bridge_Top.chk_top.Write_Penable2 -new_window
visualize -min_length [expr [visualize -get_length -window visualize:0] + 1] -window visualize:0; visualize -freeze [visualize -get_length -window visualize:0] -window visualize:0; visualize -replot -bg -window visualize:0
visualize -min_length [expr [visualize -get_length -window visualize:0] + 1] -window visualize:0; visualize -freeze [visualize -get_length -window visualize:0] -window visualize:0; visualize -replot -bg -window visualize:0
visualize -min_length [expr [visualize -get_length -window visualize:0] + 1] -window visualize:0; visualize -freeze [visualize -get_length -window visualize:0] -window visualize:0; visualize -replot -bg -window visualize:0
include /homes/user/stud/fall23/ym3000/6863/CSEE-6863-Final-Project/SVA/top/top_sva.tcl
prove -bg -all
include /homes/user/stud/fall23/ym3000/6863/CSEE-6863-Final-Project/SVA/top/top_sva.tcl
prove -bg -all
visualize -violation -property <embedded>::Bridge_Top.chk_top.Burst_write_addr2 -new_window
include /homes/user/stud/fall23/ym3000/6863/CSEE-6863-Final-Project/SVA/top/top_sva.tcl
prove -bg -all
