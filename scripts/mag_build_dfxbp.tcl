# Build sky130_efx_lvdig__dfxbp_2 (84L, 15.12 um) (2026-11-07): the dfxtp_2
# core (scripts/mag_lvdig_flop.tcl, floorplan in mag_build_dfxtp.tcl) plus
# the Q_N chain, li only beyond the two met1 clock lines.
#
#   cd mag && magic -dnull -noconsole ../scripts/mag_build_dfxbp.tcl
#
# Q_N chain: net5 = !S_N (p 0.63 / n 0.45), Q_N = !net5 (2 fingers, 1.08 /
# 0.63). S_N reaches the net5 inverter's gate in poly: the Q inverter's gate
# bar (y 1.08-1.44, fed by S_N's contact over 10.44) runs on under Q's li
# riser to the net5 gate, so no li has to cross Q.
#   net5 inverter  rails 12.24 | net5 12.78
#   Q_N inverter   rails 13.50 | Q_N 14.04 | rails 14.58, contact over 13.50

source ../scripts/mag_lvdig_lib.tcl
source ../scripts/mag_lvdig_flop.tcl

set cell sky130_efx_lvdig__dfxbp_2
if {[file exists $cell.mag]} { puts "skip $cell"; quit -noprompt }
load $cell
dfx_core

inst nmos_n2f5_f1_l150_ff         12.24 0.18
inst pmos_n3f5_f1_l150_hvt_ff     12.24 2.07
inst nmos_n3f5_f2_l150_fff        13.50 0.18
inst pmos_n6_f2_l150_hvt          13.50 1.62

# S_N: the Q inverter's gate bar continues to the net5 gate (12.435-12.585)
pl 11.34 1.08 12.60 1.44
nstrap 12.24; pstrap 12.24
li 12.60 0.54 12.96 2.16                     ;# net5
# Q_N inverter: contact over 13.50, bar across both gates
pl 13.32 1.08 14.40 1.44; pc 13.50
li 12.96 1.08 13.68 1.44                     ;# net5 to it
li 13.86 0.54 14.22 2.16                     ;# Q_N
nstrap 13.50; pstrap 13.50; nstrap 14.58; pstrap 14.58

lvdig_rails 15.12
um 13.86 1.08 14.22 1.44
efx::pin_place Q_N li 0 FreeSans 0.18 center {} output signal
power_pins
save_drc $cell
quit -noprompt
