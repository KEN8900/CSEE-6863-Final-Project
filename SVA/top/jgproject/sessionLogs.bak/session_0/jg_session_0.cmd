# ----------------------------------------
# Jasper Version Info
# tool      : Jasper 2024.06
# platform  : Linux 4.18.0-553.30.1.el8_10.x86_64
# version   : 2024.06p002 64 bits
# build date: 2024.09.02 16:28:38 UTC
# ----------------------------------------
# started   : 2024-12-16 14:53:51 EST
# hostname  : micro06.(none)
# pid       : 325418
# arguments : '-label' 'session_0' '-console' '//127.0.0.1:45009' '-style' 'windows' '-data' 'AAAAfnicY2RgYLCp////PwMYMD6A0Aw2jAyoAMRnQhUJbEChGRhYYZqRNYkxlDDkMxQwxDMUM5QxJDLoAfnJDDlgeQDxagtE' '-proj' '/homes/user/stud/fall23/ym3000/6863/CSEE-6863-Final-Project/SVA/top/jgproject/sessionLogs/session_0' '-init' '-hidden' '/homes/user/stud/fall23/ym3000/6863/CSEE-6863-Final-Project/SVA/top/jgproject/.tmp/.initCmds.tcl' 'top_sva.tcl'
clear -all

analyze -sv09 top_sva.sv
include /homes/user/stud/fall23/ym3000/6863/CSEE-6863-Final-Project/SVA/top/top_sva.tcl
include /homes/user/stud/fall23/ym3000/6863/CSEE-6863-Final-Project/SVA/top/top_sva.tcl
prove -bg -all
visualize -violation -property <embedded>::Bridge_Top.chk_top.Read_Penable -new_window
visualize -violation -property <embedded>::Bridge_Top.chk_top.Write_Penable1 -new_window
include /homes/user/stud/fall23/ym3000/6863/CSEE-6863-Final-Project/SVA/top/top_sva.tcl
prove -bg -all
include /homes/user/stud/fall23/ym3000/6863/CSEE-6863-Final-Project/SVA/top/top_sva.tcl
prove -bg -all
visualize -violation -property <embedded>::Bridge_Top.chk_top.Write_Penable1 -new_window
include /homes/user/stud/fall23/ym3000/6863/CSEE-6863-Final-Project/SVA/top/top_sva.tcl
prove -bg -all
visualize -violation -property <embedded>::Bridge_Top.chk_top.Write_Penable1 -new_window
include /homes/user/stud/fall23/ym3000/6863/CSEE-6863-Final-Project/SVA/top/top_sva.tcl
prove -bg -all
visualize -violation -property <embedded>::Bridge_Top.chk_top.Write_Penable1 -new_window
visualize -violation -property <embedded>::Bridge_Top.chk_top.Write_Penable1 -new_window
include /homes/user/stud/fall23/ym3000/6863/CSEE-6863-Final-Project/SVA/top/top_sva.tcl
include /homes/user/stud/fall23/ym3000/6863/CSEE-6863-Final-Project/SVA/top/top_sva.tcl
prove -bg -all
visualize -violation -property <embedded>::Bridge_Top.chk_top.Write_Penable2 -new_window
include /homes/user/stud/fall23/ym3000/6863/CSEE-6863-Final-Project/SVA/top/top_sva.tcl
include /homes/user/stud/fall23/ym3000/6863/CSEE-6863-Final-Project/SVA/top/top_sva.tcl
prove -bg -all
visualize -violation -property <embedded>::Bridge_Top.chk_top.Write_Penable3 -new_window
include /homes/user/stud/fall23/ym3000/6863/CSEE-6863-Final-Project/SVA/top/top_sva.tcl
include /homes/user/stud/fall23/ym3000/6863/CSEE-6863-Final-Project/SVA/top/top_sva.tcl
prove -bg -all
visualize -property <embedded>::Bridge_Top.chk_top.Write_Penable2:precondition1 -new_window
visualize -violation -property <embedded>::Bridge_Top.chk_top.Write_Penable2 -new_window
include /homes/user/stud/fall23/ym3000/6863/CSEE-6863-Final-Project/SVA/top/top_sva.tcl
prove -bg -all
visualize -violation -property <embedded>::Bridge_Top.chk_top.Write_Penable2 -new_window
include /homes/user/stud/fall23/ym3000/6863/CSEE-6863-Final-Project/SVA/top/top_sva.tcl
prove -bg -all
include /homes/user/stud/fall23/ym3000/6863/CSEE-6863-Final-Project/SVA/top/top_sva.tcl
prove -bg -all
visualize -violation -property <embedded>::Bridge_Top.chk_top.Read_addr0 -new_window
visualize -violation -property <embedded>::Bridge_Top.chk_top.Read_addr0 -new_window
include /homes/user/stud/fall23/ym3000/6863/CSEE-6863-Final-Project/SVA/top/top_sva.tcl
prove -bg -all
visualize -violation -property <embedded>::Bridge_Top.chk_top.Read_Penable -new_window
include /homes/user/stud/fall23/ym3000/6863/CSEE-6863-Final-Project/SVA/top/top_sva.tcl
prove -bg -all
visualize -violation -property <embedded>::Bridge_Top.chk_top.Read_Penable -new_window
include /homes/user/stud/fall23/ym3000/6863/CSEE-6863-Final-Project/SVA/top/top_sva.tcl
include /homes/user/stud/fall23/ym3000/6863/CSEE-6863-Final-Project/SVA/top/top_sva.tcl
prove -bg -all
