# ----------------------------------------
# Jasper Version Info
# tool      : Jasper 2024.06
# platform  : Linux 4.18.0-553.32.1.el8_10.x86_64
# version   : 2024.06p002 64 bits
# build date: 2024.09.02 16:28:38 UTC
# ----------------------------------------
# started   : 2024-12-19 15:46:59 EST
# hostname  : micro02.(none)
# pid       : 102242
# arguments : '-label' 'session_0' '-console' '//127.0.0.1:41591' '-style' 'windows' '-data' 'AAAAfnicY2RgYLCp////PwMYMD6A0Aw2jAyoAMRnQhUJbEChGRhYYZqRNYkxlDDkMxQwxDMUM5QxJDLoAfnJDDlgeQDxagtE' '-proj' '/homes/user/stud/fall23/ym3000/6863/CSEE-6863-Final-Project/SVA/top/jgproject/sessionLogs/session_0' '-init' '-hidden' '/homes/user/stud/fall23/ym3000/6863/CSEE-6863-Final-Project/SVA/top/jgproject/.tmp/.initCmds.tcl' 'top_sva.tcl'
clear -all

analyze -sv09 top_sva.sv
analyze -sv09 ../../RTL/top.v
analyze -sv09 ../../RTL/AHB_Interface.v
analyze -sv09 ../../RTL/APB_FSM.v
elaborate -top Bridge_Top

clock clk
reset ~rst
prove -bg -all
visualize -violation -property <embedded>::Bridge_Top.chk_top.Read_Pwrite -new_window
include /homes/user/stud/fall23/ym3000/6863/CSEE-6863-Final-Project/SVA/top/top_sva.tcl
prove -bg -all
include /homes/user/stud/fall23/ym3000/6863/CSEE-6863-Final-Project/SVA/top/top_sva.tcl
prove -bg -all
visualize -violation -property <embedded>::Bridge_Top.chk_top.Back2back_Pwrite -new_window
include /homes/user/stud/fall23/ym3000/6863/CSEE-6863-Final-Project/SVA/top/top_sva.tcl
prove -bg -all
visualize -violation -property <embedded>::Bridge_Top.chk_top.Read_Pwrite -new_window
visualize -violation -property <embedded>::Bridge_Top.chk_top.Read_Penable -new_window
visualize -violation -property <embedded>::Bridge_Top.chk_top.Burst_read_addr -new_window
visualize -violation -property <embedded>::Bridge_Top.chk_top.Burst_read_addr -new_window
include /homes/user/stud/fall23/ym3000/6863/CSEE-6863-Final-Project/SVA/top/top_sva.tcl
prove -bg -all
visualize -violation -property <embedded>::Bridge_Top.chk_top.Read_Pwrite -new_window
visualize -violation -property <embedded>::Bridge_Top.chk_top.Write_Pwrite -new_window
visualize -violation -property <embedded>::Bridge_Top.chk_top.Back_to_back_Penable -new_window
include /homes/user/stud/fall23/ym3000/6863/CSEE-6863-Final-Project/SVA/top/top_sva.tcl
prove -bg -all
include /homes/user/stud/fall23/ym3000/6863/CSEE-6863-Final-Project/SVA/top/top_sva.tcl
prove -bg -all
visualize -violation -property <embedded>::Bridge_Top.chk_top.Burst_write_psel0 -new_window
