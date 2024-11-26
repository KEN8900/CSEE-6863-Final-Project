# ----------------------------------------
# Jasper Version Info
# tool      : Jasper 2024.06
# platform  : Linux 4.18.0-553.27.1.el8_10.x86_64
# version   : 2024.06p002 64 bits
# build date: 2024.09.02 16:28:38 UTC
# ----------------------------------------
# started   : 2024-11-26 17:20:12 EST
# hostname  : micro04.(none)
# pid       : 2001334
# arguments : '-label' 'session_0' '-console' '//127.0.0.1:33897' '-style' 'windows' '-data' 'AAAAhnicY2RgYLCp////PwMYMD6A0Aw2jAyoAMRnQhUJbEChGRhYYZqRNckxODIEMDgxxDO4MQQz+ALpYoYyhkQGPYYShmSGHLA6AEPFDBE=' '-proj' '/homes/user/stud/fall23/yx2821/Documents/6863/final_project/CSEE-6863-Final-Project/SVA/jgproject/sessionLogs/session_0' '-init' '-hidden' '/homes/user/stud/fall23/yx2821/Documents/6863/final_project/CSEE-6863-Final-Project/SVA/jgproject/.tmp/.initCmds.tcl' 'APB_FSM_sva.tcl'
clear -all

analyze -sv09 APB_FSM_sva.sv
include /homes/user/stud/fall23/yx2821/Documents/6863/final_project/CSEE-6863-Final-Project/SVA/APB_FSM_sva.tcl
include /homes/user/stud/fall23/yx2821/Documents/6863/final_project/CSEE-6863-Final-Project/SVA/APB_FSM_sva.tcl
prove -bg -all
include /homes/user/stud/fall23/yx2821/Documents/6863/final_project/CSEE-6863-Final-Project/SVA/APB_FSM_sva.tcl
prove -bg -all
