# Build sky130_efx_lvdig__dfstp_1 (94L, 16.92 um) and dfstp_2 (96L, 17.28 um)
# (2026-11-07): D flop with active-low async set SET_B. Procs:
# scripts/mag_lvdig_lib.tcl, scripts/mag_lvdig_flop.tcl (floorplan ideas in
# mag_build_dfxtp.tcl).
#
#   cd mag && magic -dnull -noconsole ../scripts/mag_build_dfstp.tcl
#
# Netlist: D_N = !D (p 0.81 / n 0.63); TG1 D_N-M_N; M = nand(M_N, SET_B)
# (nmos M-M_N-net1-SET_B-VGND); master feedback as dfxtp_2 (M_N-CLK-net-M);
# slave input: clocked inverter of M_N, S-CLK_P-net5-M_N-VGND /
# S-CLK_N-net4-M_N-VPWR (0.45 nfets, no special); S_N = !S (0.81 / 0.54);
# slave feedback S-CLK_N-net7-S_N-net8-SET_B-VGND, pmos S-CLK_P-net6-S_N-VPWR
# || S-SET_B-VPWR; net9 = !S; Q = !net9 (1 or 2 fingers).
#
# Strips / gates (x um):
#   0.36 .. 2.16 clock inverters | 2.88 rails | D 3.15 | 3.42 D_N | TG1 3.87 |
#   4.68 M_N | mfb clk 4.95 | | M 5.85 | 6.12 rails
#   nand: 6.84 (n M; p VPWR) | M_N 7.11 | 7.38 (p M) | SET_B 7.65 | 7.92 rails
#   [gap: SET_B stub 8.46, SET_B pin]
#   9.00 rails | M_N 9.27 | 9.54 | cinv clk 9.81 | 10.62 S | sfb clk 10.89 | |
#   S_N 11.79 | 12.06 (p VPWR) | SET_B 12.33 | 12.60 (n VGND; p S)
#   S_N inverter 13.32 rails | S 13.59 | 13.86 S_N
#   net9 inverter 14.58 rails | S 14.85 | 15.12 net9;  Q from 15.84
# TG1 sits 0.45 (not 0.27) right of D_N: the D inverter's 0.63 nmos has to run
# 0.25 past its gate (poly.7) and end 0.19 short of TG1's contact (licon.14).
# M has no vertical: its nmos (6.84) returns along PL and its pmos (7.38)
# along PH, to PL and PH contacts on the M gate, which joins them (as the
# gate poly is M). M_N runs along the mid corridor to the nand's and the
# clocked inverter's M_N contacts. SET_B: contact over the nand's end strip at
# PH, li on to a stub in the island gap (pin there), met1 track HI (y
# 2.195-2.475) to the slave feedback's SET_B gate, down to its PH contact.
# Slave: the clocked inverter's clock column crosses (as dfxtp_2's TG2, also
# swapping the clock lines); S runs along the corridor to the S_N inverter's
# contact; the pmos S at 12.60 joins the corridor; the S_N inverter's gate
# bar runs on in poly under S_N's li to the net9 inverter; S_N returns along
# PL to the slave feedback's S_N gate.

source ../scripts/mag_lvdig_lib.tcl
source ../scripts/mag_lvdig_flop.tcl

lvdig_mos nmos_n3_f1_l150_bf        n 108 bf
lvdig_mos pmos_n4f5_f1_l150_hvt_ff  p 162 ff

set nf {0.36 0.54 0.18 0.63}
set nb {0.275 0.445 0.18 0.54}
set pf {2.43 2.61 2.25 2.70}
island nmos_isl_dfstp_m n {
    {2.70 3.48 0.63} {3.24 5.31 0.36} {5.31 6.30 0.45}
} {
    {3.15 0.63 nmos} {3.87 0.36 scnmos} {4.95 0.36 scnmos} {5.85 0.45 nmos}
} [list {2.88 0.36 0.72 0.18 0.81} [list 3.42 {*}$nb] [list 4.68 {*}$nb] [list 6.12 {*}$nb]]
island pmos_isl_dfstp_m p {
    {2.70 3.48 0.81} {3.24 6.30 0.45}
} {
    {3.15 0.81 pmoshvt} {3.87 0.45 pmoshvt} {4.95 0.45 pmoshvt} {5.85 0.45 pmoshvt}
} [list {2.88 2.07 2.61 1.89 2.70} [list 3.42 {*}$pf] [list 4.68 {*}$pf] [list 6.12 {*}$pf]]
island nmos_isl_dfstp_nand n {{6.66 8.10 0.45}} {{7.11 0.45 nmos} {7.65 0.45 nmos}} \
    [list [list 6.84 {*}$nf] [list 7.92 {*}$nf]]
island pmos_isl_dfstp_nand p {{6.66 8.10 0.45}} {{7.11 0.45 pmoshvt} {7.65 0.45 pmoshvt}} \
    [list [list 6.84 {*}$pf] [list 7.38 {*}$pf] [list 7.92 {*}$pf]]
island nmos_isl_dfstp_s n {{8.82 12.78 0.45}} {
    {9.27 0.45 nmos} {9.81 0.45 nmos} {10.89 0.45 nmos} {11.79 0.45 nmos} {12.33 0.45 nmos}
} [list [list 9.00 {*}$nf] [list 10.62 {*}$nb] [list 12.60 {*}$nb]]
island pmos_isl_dfstp_s p {{8.82 12.78 0.45}} {
    {9.27 0.45 pmoshvt} {9.81 0.45 pmoshvt} {10.89 0.45 pmoshvt} {11.79 0.45 pmoshvt}
    {12.33 0.45 pmoshvt}
} [list [list 9.00 {*}$pf] [list 10.62 {*}$pf] [list 12.06 {*}$pf] [list 12.60 {*}$pf]]

proc dfstp {cell nq} {
    if {[file exists $cell.mag]} { puts "skip $cell"; return }
    load $cell
    foreach i {nmos_isl_dfstp_m pmos_isl_dfstp_m nmos_isl_dfstp_nand pmos_isl_dfstp_nand nmos_isl_dfstp_s pmos_isl_dfstp_s} {
        inst $i 0 0
    }
    # ---- clock inverters (as flop_front)
    inst nmos_n2f5_f1_l150_ff         0.36 0.18
    inst pmos_n3f5_f1_l150_hvt_ff     0.36 2.07
    inst nmos_n2f5_f1_l150_ff         1.62 0.18
    inst pmos_n3f5_f1_l150_hvt_ff     1.62 2.07
    gleft 0.36; gleft 1.62
    nstrap 0.36; pstrap 0.36; nstrap 1.62; pstrap 1.62
    li 0.72 0.54 1.08 2.16
    li 0.72 1.08 1.80 1.44
    li 1.98 0.54 2.34 2.16

    # ---- D inverter, TG1, M_N, master feedback clock
    pa poly 3.075 0.81 3.225 1.89
    d_input
    nstrap 2.88; pstrap 2.88
    li 3.24 0.18 3.42 2.70                       ;# D_N
    tgx 3.87
    li 4.68 0.18 4.86 2.70                       ;# M_N
    dcol 4.95
    # M gate: PL and PH contacts (its poly joins nmos and pmos M)
    pa poly 5.775 0.63 5.925 2.25
    pcpad {5.685 0.855 6.015 1.125} {5.67 0.72 6.03 1.08} 5.85 0.99
    pcpad {5.715 1.635 5.985 1.965} {5.76 1.62 5.94 1.98} 5.85 1.80
    nstrap 6.12; pstrap 6.12

    # ---- nand M = !(M_N . SET_B)
    pa poly 7.035 0.63 7.185 2.25                ;# M_N
    pa poly 7.575 0.63 7.725 2.25                ;# SET_B
    pcpad {6.975 1.095 7.245 1.425} {7.02 1.08 7.20 1.44} 7.11 1.26   ;# M_N, mid
    pa poly 7.575 1.635 8.10 1.965               ;# SET_B contact over 7.92 at PH
    pcpad {7.74 1.635 8.10 1.965} {7.74 1.62 8.10 1.98} 7.92 1.80
    nstrap 7.92; pstrap 6.84; pstrap 7.92        ;# (nmos 6.84 is M)
    li 6.66 0.54 7.02 0.90                       ;# nmos M up to PL
    li 5.67 0.72 7.02 0.90                       ;#   ... back to the M gate
    li 7.38 1.62 7.56 2.70                       ;# pmos M down to PH
    li 5.76 1.62 7.56 1.98                       ;#   ... back to the M gate
    li 7.74 1.62 8.55 1.98                       ;# SET_B on to its stub
    li 8.37 1.62 8.55 2.42
    li 4.68 1.26 9.36 1.44                       ;# M_N corridor

    # ---- slave: clocked inverter of M_N, slave feedback
    pa poly 9.195 0.63 9.345 2.25                ;# M_N (clocked inverter)
    pcpad {9.135 1.095 9.405 1.425} {9.18 1.08 9.36 1.44} 9.27 1.26   ;# M_N, mid
    nstrap 9.00; pstrap 9.00
    tgx 9.81 0.905
    li 10.62 0.18 10.80 2.70                     ;# S
    dcol 10.89 0.905
    pa poly 11.715 0.63 11.865 2.25              ;# S_N
    pcpad {11.625 0.855 11.955 1.125} {11.61 0.72 11.97 1.08} 11.79 0.99 ;# S_N, PL
    pa poly 12.255 0.63 12.405 2.25              ;# SET_B
    pcpad {12.195 1.635 12.465 1.965} {12.24 1.62 12.42 1.98} 12.33 1.80 ;# SET_B, PH
    pstrap 12.06; nstrap 12.60
    li 12.60 1.26 12.78 2.70                     ;# pmos S down to the corridor
    li 10.62 1.26 13.68 1.44                     ;# S corridor

    # ---- S_N inverter (0.81 / 0.54), S contact in the corridor
    inst nmos_n3_f1_l150_bf          13.32 0.18
    inst pmos_n4f5_f1_l150_hvt_ff    13.32 1.89
    pcpad {13.455 1.095 13.725 1.425} {13.50 1.08 13.68 1.44} 13.59 1.26
    nstrap 13.32; pstrap 13.32
    li 13.86 0.18 14.04 2.70                     ;# S_N
    li 11.61 0.72 14.04 0.90                     ;#   ... back to its gate
    # ---- net9 inverter: the S bar runs on under S_N's li
    if {$nq == 1} {
        inst nmos_n2f5_f1_l150_ff 14.58 0.18; inst pmos_n3f5_f1_l150_hvt_ff 14.58 2.07
    } else {
        inst nmos_n3f5_f1_l150 14.58 0.18; inst pmos_n6_f1_l150_hvt 14.58 1.62
    }
    pl 13.455 1.08 14.94 1.44
    nstrap 14.58; pstrap 14.58
    li 14.94 0.54 15.30 2.16                     ;# net9
    li 15.30 1.08 16.02 1.44
    # ---- Q inverter, contact over 15.84
    if {$nq == 1} {
        inst nmos_n3f5_f1_l150 15.84 0.18; inst pmos_n6_f1_l150_hvt 15.84 1.62
        gleft 15.84
        set w 16.92
    } else {
        inst nmos_n3f5_f2_l150_fff 15.84 0.18; inst pmos_n6_f2_l150_hvt 15.84 1.62
        pl 15.66 1.08 16.74 1.44; pc 15.84
        nstrap 16.92; pstrap 16.92
        set w 17.28
    }
    nstrap 15.84; pstrap 15.84
    li 16.20 0.54 16.56 2.16                     ;# Q

    # ---- met1
    # CLK_N: PH, down to mid at 5.28, down to PL past the clocked inverter
    clkn_master 5.56
    m1 5.28 1.21 5.56 1.94
    m1 5.28 1.21 10.40 1.49
    m1 10.12 0.765 10.40 1.49
    m1 10.12 0.765 11.22 1.045
    via 0.90 1.80; via 3.87 1.80; via 5.13 1.80; via 10.35 0.905; via 11.07 0.905
    # CLK_P: PL to the clocked inverter's riser, PH after it
    m1 2.01 0.76 9.96 1.04
    m1 9.66 1.66 11.22 1.94
    via 2.16 0.90; via 4.41 0.90; via 5.13 0.90; via 9.81 0.905
    via 9.81 1.80; via 11.07 1.80
    # SET_B: track HI to the slave feedback, down to its PH contact
    m1 8.31 2.195 12.47 2.475
    m1 12.19 1.65 12.47 2.475
    via 8.46 2.335; via 12.33 1.80

    lvdig_rails $w
    gpin CLK 0.36 input signal
    d_pin
    um 8.10 1.62 8.46 1.98
    efx::pin_place SET_B li 0 FreeSans 0.18 center {} input signal
    um 16.20 1.08 16.56 1.44
    efx::pin_place Q li 0 FreeSans 0.18 center {} output signal
    power_pins
    save_drc $cell
}

dfstp sky130_efx_lvdig__dfstp_1 1
dfstp sky130_efx_lvdig__dfstp_2 2
quit -noprompt
