# Build sky130_efx_lvdig__dfbbp_1 (124L, 22.32 um) (2026-11-07): D flop with
# active-low async set SET_B and reset RESET_B, outputs Q and Q_N. Procs:
# scripts/mag_lvdig_lib.tcl, scripts/mag_lvdig_flop.tcl (floorplan of the
# front in mag_build_dfxtp.tcl).
#
#   cd mag && magic -dnull -noconsole ../scripts/mag_build_dfbbp.tcl
#
# Netlist: the dfxtp_2 front (D inverter, TG1, master feedback with M gate);
# M = !((M_N + RB_N) . SET_B) (OAI, nmos M-M_N-net4 || M-RB_N-net4,
# net4-SET_B-VGND; pmos M-SET_B-VPWR || M-M_N-net3-RB_N-VPWR); slave input:
# clocked inverter of M (S-CLK_P special-net6-M-VGND, S-CLK_N-net5-M-VPWR);
# slave feedback as dfxtp_2; S_N = the same OAI of S; Q_N = !S_N; net11 =
# !S_N; Q = !net11; RB_N = !RESET_B.
#
# Strips / gates (x um):
#   front as dfxtp_2 to 4.50 M_N | mfb clk 4.77 | | M 5.67 | 5.94 rails
#   [gap: RB_N contact at 6.66, track HI]
#   OAI_M  7.20 (n net4'; p VPWR) | RB_N 7.47 | 7.74 (n M) | M_N 8.01 |
#          8.28 (n net4; p M) | SET_B 8.55 | 8.82 rails
#   [gap: SET_B contact at 9.54, track LO]
#   10.08 rails | M 10.35 | | cinv clk 11.07 | 11.88 S | sfb clk 12.15 | |
#   S_N 13.05 | 13.32 rails
#   [gap: SET_B contact at 14.04, track LO; SET_B pin]
#   OAI_S  14.58 rails | SET_B 14.85 | 15.12 (n net10; p S_N) | S 15.39 |
#          15.66 (n S_N) | RB_N 15.93 | 16.20 (n net10'; p VPWR)
#   [gap: RB_N contact at 16.74, track HI]
#   Q_N inverter 17.46 | net11 inverter 18.72 | Q inverter 19.98 |
#   RB_N inverter 21.24 (RESET_B pin)
# met1 tracks: LO y 0.32-0.60 (over the nmos contacts), PL 0.76-1.04, mid
# 1.21-1.49, PH 1.66-1.94, HI 2.195-2.475 (over the pmos contacts). Clocks as
# dfxtp_2 (CLK_N PH -> mid at 5.10 -> PL past the clocked inverter, whose
# crossing column swaps the lines). SET_B on LO and RB_N on HI: their gates
# sit at the OAIs' ends and reach contacts in the island gaps through poly
# jogs (SET_B just above the nmos diffusion, y 0.705-0.855; RB_N just above
# the pmos, y 2.775-2.925), so no li band is spent on them. Each OAI's nmos
# node net4 / net10 spans two strips: a met1 jumper on LO.
# M: nmos 7.74 along PL to the M gate's contact (5.67) and to 8.28, up a 1L
# vertical to the pmos M, and along mid to the clocked inverter's M contact.
# M_N: corridor (mid) to the OAI's M_N contact. S: corridor to the OAI_S S
# contact. S_N: nmos 15.66 up to PH, joined to the pmos 15.12, along PH to
# the slave feedback's S_N contact, and along the gap level to the Q_N
# inverter, whose gate bar runs on under Q_N's li to the net11 inverter.

source ../scripts/mag_lvdig_lib.tcl
source ../scripts/mag_lvdig_flop.tcl

set nf {0.36 0.54 0.18 0.63}
set nf63 {0.36 0.72 0.18 0.81}
set nb {0.275 0.445 0.18 0.54}
set pf {2.43 2.61 2.25 2.70}
set pt81 {2.435 2.605 2.34 2.70}
island nmos_isl_dfbbp_m n {
    {2.70 3.50 0.45} {3.24 5.13 0.36} {5.13 6.12 0.45}
} {
    {3.15 0.45 nmos} {3.69 0.36 scnmos} {4.77 0.36 scnmos} {5.67 0.45 nmos}
} [list [list 2.88 {*}$nf] [list 3.42 {*}$nb] [list 4.50 {*}$nb] [list 5.94 {*}$nb]]
island pmos_isl_dfbbp_m p {{2.70 6.12 0.45}} {
    {3.15 0.45 pmoshvt} {3.69 0.45 pmoshvt} {4.77 0.45 pmoshvt} {5.67 0.45 pmoshvt}
} [list [list 2.88 {*}$pf] [list 3.42 {*}$pf] [list 4.50 {*}$pf] [list 5.94 {*}$pf]]
island nmos_isl_dfbbp_oaim n {{7.02 8.36 0.63} {8.10 9.00 0.45}} {
    {7.47 0.63 nmos} {8.01 0.63 nmos} {8.55 0.45 nmos}
} [list [list 7.20 {*}$nb] [list 7.74 {*}$nf63] [list 8.28 {*}$nb] [list 8.82 {*}$nf]]
island pmos_isl_dfbbp_oaim p {{7.02 8.36 0.81} {8.10 9.00 0.45}} {
    {7.47 0.81 pmoshvt} {8.01 0.81 pmoshvt} {8.55 0.45 pmoshvt}
} [list [list 7.20 {*}$pt81] [list 8.28 {*}$pf] [list 8.82 {*}$pf]]
island nmos_isl_dfbbp_s n {{9.90 10.70 0.63} {10.62 12.51 0.36} {12.51 13.50 0.45}} {
    {10.35 0.63 nmos} {11.07 0.36 scnmos} {12.15 0.36 scnmos} {13.05 0.45 nmos}
} [list [list 10.08 {*}$nf63] [list 11.88 {*}$nb] [list 13.32 {*}$nf]]
island pmos_isl_dfbbp_s p {{9.90 10.70 0.81} {10.62 13.50 0.45}} {
    {10.35 0.81 pmoshvt} {11.07 0.45 pmoshvt} {12.15 0.45 pmoshvt} {13.05 0.45 pmoshvt}
} [list {10.08 2.07 2.61 1.89 2.70} [list 11.88 {*}$pf] [list 13.32 {*}$pf]]
island nmos_isl_dfbbp_oais n {{14.40 15.30 0.45} {15.04 16.38 0.63}} {
    {14.85 0.45 nmos} {15.39 0.63 nmos} {15.93 0.63 nmos}
} [list [list 14.58 {*}$nf] [list 15.12 {*}$nb] [list 15.66 {*}$nf63] [list 16.20 {*}$nb]]
island pmos_isl_dfbbp_oais p {{14.40 15.30 0.45} {15.04 16.38 0.81}} {
    {14.85 0.45 pmoshvt} {15.39 0.81 pmoshvt} {15.93 0.81 pmoshvt}
} [list [list 14.58 {*}$pf] [list 15.12 {*}$pf] [list 16.20 {*}$pt81]]

set cell sky130_efx_lvdig__dfbbp_1
if {[file exists $cell.mag]} { puts "skip $cell"; quit -noprompt }
load $cell
foreach i {nmos_isl_dfbbp_m pmos_isl_dfbbp_m nmos_isl_dfbbp_oaim pmos_isl_dfbbp_oaim
           nmos_isl_dfbbp_s pmos_isl_dfbbp_s nmos_isl_dfbbp_oais pmos_isl_dfbbp_oais} {
    inst $i 0 0
}
flop_front

# ---- master feedback M gate
pa poly 5.595 0.63 5.745 2.25
pcpad {5.44 0.825 5.745 1.155} {5.40 0.72 5.76 1.08} 5.575 0.99   ;# M, PL
nstrap 5.94; pstrap 5.94

# ---- OAI_M
pa poly 7.395 0.81 7.545 1.89                ;# RB_N
pa poly 7.935 0.81 8.085 1.89                ;# M_N
pa poly 8.475 0.63 8.625 2.25                ;# SET_B
pcpad {7.875 1.095 8.145 1.425} {7.92 1.08 8.10 1.44} 8.01 1.26   ;# M_N, mid
# RB_N: poly jog over the pmos top, left to a contact at 6.66 (track HI)
pa poly 6.48 2.775 7.545 2.925
pa poly 6.48 2.47 6.84 2.925
pcpad {6.48 2.20 6.84 2.47} {6.48 2.16 6.84 2.52} 6.66 2.335
# SET_B: poly jog over the nmos top, right to a contact at 9.54 (track LO)
pa poly 8.475 0.705 9.72 0.855
pa poly 9.36 0.625 9.72 0.855
pcpad {9.36 0.295 9.72 0.625} {9.36 0.36 9.72 0.72} 9.54 0.46
pstrap 7.20; nstrap 8.82; pstrap 8.82
li 4.50 1.26 8.10 1.44                       ;# M_N corridor
li 5.40 0.72 8.46 0.90                       ;# M: nmos 7.74 to the M gate, and to 8.28
li 8.28 0.72 8.46 2.70                       ;#   up to the pmos M
li 8.28 1.26 10.44 1.44                      ;#   along mid to the clocked inverter

# ---- slave: clocked inverter of M, slave feedback
pa poly 10.275 0.81 10.425 1.89              ;# M (clocked inverter)
pcpad {10.215 1.095 10.485 1.425} {10.26 1.08 10.44 1.44} 10.35 1.26 ;# M, mid
nstrap 10.08; pstrap 10.08
tgx 11.07
li 11.88 0.18 12.06 2.70                     ;# S
dcol 12.15
pa poly 12.975 0.63 13.125 2.25              ;# S_N (slave feedback)
pcpad {12.915 1.635 13.185 1.965} {12.96 1.62 13.14 1.98} 13.05 1.80 ;# S_N, PH
nstrap 13.32; pstrap 13.32
li 11.88 1.26 15.48 1.44                     ;# S corridor

# ---- OAI_S
pa poly 14.775 0.63 14.925 2.25              ;# SET_B
pa poly 15.315 0.81 15.465 1.89              ;# S
pa poly 15.855 0.81 16.005 1.89              ;# RB_N
pcpad {15.255 1.095 15.525 1.425} {15.30 1.08 15.48 1.44} 15.39 1.26 ;# S, mid
# SET_B: poly jog left to a contact at 14.04 (track LO); the SET_B pin
pa poly 13.86 0.705 14.925 0.855
pa poly 13.86 0.625 14.22 0.855
pcpad {13.86 0.295 14.22 0.625} {13.86 0.36 14.22 1.08} 14.04 0.46
# RB_N: poly jog right to a contact at 16.74 (track HI)
pa poly 15.855 2.775 16.92 2.925
pa poly 16.56 2.47 16.92 2.925
pcpad {16.56 2.20 16.92 2.47} {16.56 2.16 16.92 2.52} 16.74 2.335
nstrap 14.58; pstrap 14.58; pstrap 16.20
li 15.66 0.18 15.84 1.98                     ;# S_N: nmos up to PH
li 15.12 1.62 15.84 1.98                     ;#   joined to the pmos S_N
li 15.12 1.62 15.30 2.70
li 12.96 1.62 15.30 1.98                     ;#   along PH to the S_N gate
li 15.66 1.08 17.64 1.44                     ;#   along the gap to the Q_N inverter

# ---- Q_N inverter (gate S_N, bar on to the net11 inverter), net11, Q, RB_N
inst nmos_n3f5_f1_l150 17.46 0.18; inst pmos_n6_f1_l150_hvt 17.46 1.62
pl 17.28 1.08 19.08 1.44; pc 17.46
li 17.82 0.54 18.18 2.16                     ;# Q_N
nstrap 17.46; pstrap 17.46
inst nmos_n2f5_f1_l150_ff 18.72 0.18; inst pmos_n3f5_f1_l150_hvt_ff 18.72 2.07
nstrap 18.72; pstrap 18.72
li 19.08 0.54 19.44 2.16                     ;# net11
li 19.08 1.08 20.16 1.44
inst nmos_n3f5_f1_l150 19.98 0.18; inst pmos_n6_f1_l150_hvt 19.98 1.62
gleft 19.98
nstrap 19.98; pstrap 19.98
li 20.34 0.54 20.70 2.16                     ;# Q
inst nmos_n2f5_f1_l150_ff 21.24 0.18; inst pmos_n3f5_f1_l150_hvt_ff 21.24 2.07
gleft 21.24
nstrap 21.24; pstrap 21.24
li 21.60 0.54 21.96 2.70                     ;# RB_N

# ---- met1
# CLK_N: PH, down to mid at 5.10, down to PL past the clocked inverter
clkn_master 5.38
m1 5.10 1.21 5.38 1.94
m1 5.10 1.21 11.66 1.49
m1 11.38 0.76 11.66 1.49
m1 11.38 0.76 12.48 1.04
via 0.90 1.80; via 3.69 1.80; via 4.95 1.80; via 11.61 0.90; via 12.33 0.90
# CLK_P: PL to the clocked inverter's riser, PH after it
m1 2.01 0.76 11.22 1.04
m1 10.92 1.66 12.48 1.94
via 2.16 0.90; via 4.23 0.90; via 4.95 0.90; via 11.07 0.90
via 11.07 1.80; via 12.33 1.80
# net4 / net10 jumpers, SET_B (LO)
m1 7.05 0.32 8.43 0.60;   via 7.20 0.46; via 8.28 0.46
m1 14.97 0.32 16.35 0.60; via 15.12 0.46; via 16.20 0.46
m1 9.39 0.32 14.19 0.60;  via 9.54 0.46; via 14.04 0.46
# RB_N (HI)
m1 6.51 2.195 21.93 2.475
via 6.66 2.335; via 16.74 2.335; via 21.78 2.335

lvdig_rails 22.32
gpin CLK 0.36 input signal
d_pin
gpin RESET_B 21.24 input signal
um 13.86 0.72 14.22 1.08
efx::pin_place SET_B li 0 FreeSans 0.18 center {} input signal
um 20.34 1.08 20.70 1.44
efx::pin_place Q li 0 FreeSans 0.18 center {} output signal
um 17.82 1.08 18.18 1.44
efx::pin_place Q_N li 0 FreeSans 0.18 center {} output signal
power_pins
save_drc $cell
quit -noprompt
