# Build sky130_efx_lvdig__dfrtp_1 (76L, 13.68 um) and dfrtp_2 (78L, 14.04 um),
# and dfrbp_1 (90L, 16.20 um) / dfrbp_2 (96L, 17.28 um), which add the Q_N
# chain of dfxbp_2 (qn_chain in scripts/mag_lvdig_flop.tcl)
# (2026-11-07): D flop with active-low async reset RESET_B. The dfxtp_2
# front (scripts/mag_lvdig_flop.tcl: clock inverters, D inverter, TG1, master
# feedback clock column) plus:
#   master feedback  pmos M_N-CLK_N-net1, net1-M-VPWR || net1-RESET_B-VPWR
#                    nmos M_N-CLK_P-net2-M-net3-RESET_B-VGND
#   M = !M_N (p 0.81 / n 0.63), TG2, slave feedback (as dfxtp_2)
#   S_N = nand(S, RESET_B): nmos S_N-S-net6-RESET_B-VGND, pmos parallel
#   Q = !S_N (1 or 2 fingers)
#
#   cd mag && magic -dnull -noconsole ../scripts/mag_build_dfrtp.tcl
#
# Strips / gates (x um), both rows unless noted:
#   ... 4.50 M_N | mfb clk 4.77 | 5.40 (p net1; n net2, no contact) | M 5.67 |
#   5.94 (p VPWR; n net3, no contact) | RESET_B 6.21 | 6.48 (n VGND; p net1)
#   [island gap: RESET_B stub at 7.02]
#   7.56 rails | M_N 7.83 | 8.28 M | TG2 8.55 | 9.36 S | sfb clk 9.63 | |
#   S_N 10.53 | 10.80 rails | RESET_B 11.07 | 11.34 (p S_N; n net6) | S 11.61 |
#   11.88 (n S_N; p VPWR)   [Q inverter from 12.60]
# Gap li bands across the master's M / RESET_B columns: PL y 0.72-0.90 M
# (back to the M gate's contact), mid 1.26-1.44 M_N (corridor to the M
# inverter), PH 1.62-1.98 RESET_B (contact over the RESET_B gate, li on to a
# stub in the island gap; the RESET_B pin is on it). The pmos node net1 (CLK_N
# device, and the two parallel devices on either side of the VPWR strip) is
# linked by a met1 jumper over the pmos contacts (track HI, y 2.195-2.475);
# RESET_B goes to the slave nand on the same track (it would have to cross
# M, M_N and the clock column otherwise), dropping to a via on the nand's
# RESET_B contact at PH. Slave: S corridor (mid) to the nand's S contact; S_N
# back along PL to the slave feedback gate; the nand's pmos S_N (middle strip)
# joins its nmos S_N (end strip) along PH.
# met1: CLK_N PH -> mid at 5.10 (so no met1 lies over the RESET_B pin) ->
# PL past TG2 (8.86); CLK_P PL to TG2's riser, PH after it (as dfxtp_2).

source ../scripts/mag_lvdig_lib.tcl
source ../scripts/mag_lvdig_flop.tcl

set nf {0.36 0.54 0.18 0.63}
set nb {0.275 0.445 0.18 0.54}
set pf {2.43 2.61 2.25 2.70}
island nmos_isl_dfrtp_m n {
    {2.70 3.50 0.45} {3.24 5.13 0.36} {5.13 6.66 0.45}
} {
    {3.15 0.45 nmos} {3.69 0.36 scnmos} {4.77 0.36 scnmos} {5.67 0.45 nmos}
    {6.21 0.45 nmos}
} [list [list 2.88 {*}$nf] [list 3.42 {*}$nb] [list 4.50 {*}$nb] [list 6.48 {*}$nb]]
island pmos_isl_dfrtp_m p {
    {2.70 6.66 0.45}
} {
    {3.15 0.45 pmoshvt} {3.69 0.45 pmoshvt} {4.77 0.45 pmoshvt}
    {5.67 0.45 pmoshvt} {6.21 0.45 pmoshvt}
} [list [list 2.88 {*}$pf] [list 3.42 {*}$pf] [list 4.50 {*}$pf] [list 5.40 {*}$pf] \
       [list 5.94 {*}$pf] [list 6.48 {*}$pf]]
island nmos_isl_dfrtp_s n {
    {7.38 8.16 0.63} {8.10 9.99 0.36} {9.99 12.06 0.45}
} {
    {7.83 0.63 nmos} {8.55 0.36 scnmos} {9.63 0.36 scnmos} {10.53 0.45 nmos}
    {11.07 0.45 nmos} {11.61 0.45 nmos}
} [list [list 7.56 {*}$nb] [list 8.28 {*}$nb] [list 9.36 {*}$nb] [list 10.80 {*}$nb] \
       [list 11.88 {*}$nf]]
island pmos_isl_dfrtp_s p {
    {7.38 8.16 0.81} {8.10 12.06 0.45}
} {
    {7.83 0.81 pmoshvt} {8.55 0.45 pmoshvt} {9.63 0.45 pmoshvt}
    {10.53 0.45 pmoshvt} {11.07 0.45 pmoshvt} {11.61 0.45 pmoshvt}
} [list {7.56 2.07 2.61 1.89 2.70} [list 8.28 {*}$pf] [list 9.36 {*}$pf] \
       [list 10.80 {*}$pf] [list 11.34 {*}$pf] [list 11.88 {*}$pf]]

proc dfrtp {cell nq {nqn 0}} {
    if {[file exists $cell.mag]} { puts "skip $cell"; return }
    load $cell
    inst nmos_isl_dfrtp_m 0 0; inst pmos_isl_dfrtp_m 0 0
    inst nmos_isl_dfrtp_s 0 0; inst pmos_isl_dfrtp_s 0 0
    flop_front

    # ---- master: M and RESET_B gates, M inverter
    pa poly 5.595 0.63 5.745 2.25                ;# M
    pa poly 6.135 0.63 6.285 2.25                ;# RESET_B
    pa poly 7.755 0.81 7.905 1.89                ;# M_N (M inverter)
    pcpad {5.44 0.825 5.745 1.155} {5.40 0.72 5.76 1.08} 5.575 0.99   ;# M, PL
    pcpad {6.075 1.635 6.345 1.965} {6.12 1.62 6.30 1.98} 6.21 1.80   ;# RESET_B, PH
    li 6.12 1.62 7.11 1.98                       ;# RESET_B on to its stub
    li 6.93 1.62 7.11 2.42
    pstrap 5.94; nstrap 6.48
    nstrap 7.56; pstrap 7.56
    li 4.50 1.26 7.92 1.44                       ;# M_N corridor
    pcpad {7.695 1.095 7.965 1.425} {7.74 1.08 7.92 1.44} 7.83 1.26   ;# M_N, mid
    li 8.10 0.18 8.28 2.70                       ;# M
    li 5.40 0.72 8.28 0.90                       ;# M back to its gate

    # ---- slave
    tgx 8.55                                     ;# TG2
    li 9.36 0.18 9.54 2.70                       ;# S
    dcol 9.63                                    ;# slave feedback clock
    pa poly 10.455 0.63 10.605 2.25              ;# S_N (slave feedback)
    pa poly 10.995 0.63 11.145 2.25              ;# RESET_B (nand)
    pa poly 11.535 0.63 11.685 2.25              ;# S (nand)
    pcpad {10.30 0.825 10.605 1.155} {10.26 0.72 10.62 1.08} 10.435 0.99 ;# S_N, PL
    pcpad {10.935 1.635 11.205 1.965} {10.98 1.62 11.16 1.98} 11.07 1.80 ;# RESET_B, PH
    pcpad {11.475 1.095 11.745 1.425} {11.52 1.08 11.70 1.44} 11.61 1.26 ;# S, mid
    nstrap 10.80; pstrap 10.80; pstrap 11.88
    li 9.36 1.26 11.70 1.44                      ;# S corridor
    li 11.88 0.18 12.06 1.98                     ;# S_N (nmos end strip)
    li 11.34 1.62 12.06 1.98                     ;#   ... joined to the pmos S_N
    li 11.34 1.62 11.52 2.70
    li 10.26 0.72 12.06 0.90                     ;# S_N back to its gate
    li 11.70 0.54 12.06 0.90                     ;#   (fills the notch to the contact)
    li 11.88 1.08 12.78 1.44                     ;# S_N on to the Q inverter

    # ---- Q inverter, contact over 12.60
    if {$nq == 1} {
        inst nmos_n3f5_f1_l150 12.60 0.18; inst pmos_n6_f1_l150_hvt 12.60 1.62
        gleft 12.60
        set w 13.68; set bar1 12.96; set x7 13.86
    } else {
        inst nmos_n3f5_f2_l150_fff 12.60 0.18; inst pmos_n6_f2_l150_hvt 12.60 1.62
        pl 12.42 1.08 13.50 1.44; pc 12.60
        nstrap 13.68; pstrap 13.68
        set w 14.04; set bar1 13.50; set x7 14.40
    }
    nstrap 12.60; pstrap 12.60
    li 12.96 0.54 13.32 2.16                     ;# Q

    # ---- met1
    # CLK_N: PH, down to mid at 5.10, down to PL past TG2
    clkn_master 5.38
    m1 5.10 1.21 5.38 1.94
    m1 5.10 1.21 9.14 1.49
    m1 8.86 0.76 9.14 1.49
    m1 8.86 0.76 9.96 1.04
    via 0.90 1.80; via 3.69 1.80; via 4.95 1.80; via 9.09 0.90; via 9.81 0.90
    # CLK_P: PL to TG2's riser, PH after it
    m1 2.01 0.76 8.70 1.04
    m1 8.40 1.66 9.96 1.94
    via 2.16 0.90; via 4.23 0.90; via 4.95 0.90; via 8.55 0.90
    via 8.55 1.80; via 9.81 1.80
    # net1 jumper (track HI)
    m1 5.25 2.195 6.63 2.475
    via 5.40 2.335; via 6.48 2.335
    # RESET_B: track HI to the nand, down to its PH contact
    m1 6.87 2.195 11.21 2.475
    m1 10.93 1.65 11.21 2.475
    via 7.02 2.335; via 11.07 1.80

    # Q_N chain (dfrbp): net7 = !S_N, Q_N = !net7
    if {$nqn} { lassign [qn_chain $bar1 $x7 $nqn] w qx }
    lvdig_rails $w
    gpin CLK 0.36 input signal
    d_pin
    um 6.48 1.62 6.84 1.98
    efx::pin_place RESET_B li 0 FreeSans 0.18 center {} input signal
    um 12.96 1.08 13.32 1.44
    efx::pin_place Q li 0 FreeSans 0.18 center {} output signal
    if {$nqn} { qn_pin $qx }
    power_pins
    save_drc $cell
}

dfrtp sky130_efx_lvdig__dfrtp_1 1
dfrtp sky130_efx_lvdig__dfrtp_2 2
dfrtp sky130_efx_lvdig__dfrbp_1 1 1
dfrtp sky130_efx_lvdig__dfrbp_2 2 2
quit -noprompt
