# ----------------------------------------
# Jasper Version Info
# tool      : Jasper 2024.06
# platform  : Linux 4.18.0-553.30.1.el8_10.x86_64
# version   : 2024.06p002 64 bits
# build date: 2024.09.02 16:28:38 UTC
# ----------------------------------------
# started   : 2024-12-11 11:42:16 EST
# hostname  : micro27.(none)
# pid       : 1306978
# arguments : '-label' 'session_0' '-console' '//127.0.0.1:39729' '-style' 'windows' '-data' 'AAAAhnicY2RgYLCp////PwMYMD6A0Aw2jAyoAMRnQhUJbEChGRhYYZqRNckxODIEMDgxxDO4MQQz+ALpYoYyhkQGPYYShmSGHLA6AEPFDBE=' '-proj' '/homes/user/stud/fall23/ym3000/6863/CSEE-6863-Final-Project/SVA/APB_FSM/jgproject/sessionLogs/session_0' '-init' '-hidden' '/homes/user/stud/fall23/ym3000/6863/CSEE-6863-Final-Project/SVA/APB_FSM/jgproject/.tmp/.initCmds.tcl' 'APB_FSM_sva.tcl'
clear -all

analyze -sv09 APB_FSM_sva.sv
analyze -sv09 ../RTL/APB_FSM.v
prove -bg -all
include /homes/user/stud/fall23/ym3000/6863/CSEE-6863-Final-Project/SVA/APB_FSM/APB_FSM_sva.tcl
prove -bg -all
visualize -violation -property <embedded>::APB_FSM.APB_FSM_chk.assert_outputs -new_window
include /homes/user/stud/fall23/ym3000/6863/CSEE-6863-Final-Project/SVA/APB_FSM/APB_FSM_sva.tcl
prove -bg -all
include /homes/user/stud/fall23/ym3000/6863/CSEE-6863-Final-Project/SVA/APB_FSM/APB_FSM_sva.tcl
prove -bg -all
include /homes/user/stud/fall23/ym3000/6863/CSEE-6863-Final-Project/SVA/APB_FSM/APB_FSM_sva.tcl
prove -bg -all
visualize -violation -property <embedded>::APB_FSM.APB_FSM_chk.assert_outputs -new_window
include /homes/user/stud/fall23/ym3000/6863/CSEE-6863-Final-Project/SVA/APB_FSM/APB_FSM_sva.tcl
prove -bg -all
visualize -violation -property <embedded>::APB_FSM.APB_FSM_chk.assert_outputs -new_window
prove -bg -all
include /homes/user/stud/fall23/ym3000/6863/CSEE-6863-Final-Project/SVA/APB_FSM/APB_FSM_sva.tcl
prove -bg -all
include /homes/user/stud/fall23/ym3000/6863/CSEE-6863-Final-Project/SVA/APB_FSM/APB_FSM_sva.tcl
include /homes/user/stud/fall23/ym3000/6863/CSEE-6863-Final-Project/SVA/APB_FSM/APB_FSM_sva.tcl
prove -bg -all
visualize -violation -property <embedded>::APB_FSM.APB_FSM_chk.assert_outputs -new_window
include /homes/user/stud/fall23/ym3000/6863/CSEE-6863-Final-Project/SVA/APB_FSM/APB_FSM_sva.tcl
prove -bg -all
visualize -violation -property <embedded>::APB_FSM.APB_FSM_chk.assert_outputs -new_window
include /homes/user/stud/fall23/ym3000/6863/CSEE-6863-Final-Project/SVA/APB_FSM/APB_FSM_sva.tcl
prove -bg -all
visualize -violation -property <embedded>::APB_FSM.APB_FSM_chk.assert_outputs -new_window
include /homes/user/stud/fall23/ym3000/6863/CSEE-6863-Final-Project/SVA/APB_FSM/APB_FSM_sva.tcl
prove -bg -all
visualize -violation -property <embedded>::APB_FSM.APB_FSM_chk.assert_outputs -new_window
include /homes/user/stud/fall23/ym3000/6863/CSEE-6863-Final-Project/SVA/APB_FSM/APB_FSM_sva.tcl
prove -bg -all
visualize -violation -property <embedded>::APB_FSM.APB_FSM_chk.assert_outputs -new_window
visualize -violation -property <embedded>::APB_FSM.APB_FSM_chk.assert_outputs -new_window
include /homes/user/stud/fall23/ym3000/6863/CSEE-6863-Final-Project/SVA/APB_FSM/APB_FSM_sva.tcl
prove -bg -all
visualize -violation -property <embedded>::APB_FSM.APB_FSM_chk.assert_outputs -new_window
include /homes/user/stud/fall23/ym3000/6863/CSEE-6863-Final-Project/SVA/APB_FSM/APB_FSM_sva.tcl
prove -bg -all
