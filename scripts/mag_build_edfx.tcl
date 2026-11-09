# Build sky130_efx_lvdig__edfxtp_1 (104L, 18.72 um) and edfxbp_1 (110L,
# 19.80 um) (2026-11-07): D flop with data enable DE (DE = 0 holds Q). Procs:
# scripts/mag_lvdig_lib.tcl, scripts/mag_lvdig_flop.tcl (the master and
# clock-line scheme are dfxtp_2's, mag_build_dfxtp.tcl).
#
#   cd mag && magic -dnull -noconsole ../scripts/mag_build_edfx.tcl
#
# Netlist: DM_N = !(D.DE + S_N.DE_N) (pmos DM_N-D-net1-DE_N-VPWR,
# DM_N-S_N-net2-DE-VPWR; nmos DM_N-D-net3-DE-VGND, DM_N-S_N-net4-DE_N-VGND),
# DE_N = !DE; TG1 DM_N-M_N; master feedback and M inverter as dfxtp_2; slave
# input: clocked inverter of M (S-CLK_P special-net8-M-VGND /
# S-CLK_N-net7-M-VPWR); slave feedback as dfxtp_2; Q = !S (1.08 / 0.63);
# S_N = !S (0.63 / 0.45); edfxbp: Q_N = !S_N.
#
# Left to right (x um):
#   mux (the mux2_2 layout, mirrored top to bottom in its select routing):
#     0.90 DM_N | D | 1.44 | cX (n DE, p DE_N) | 1.98 rails |
#     DE inverter 2.70 DE_N | DE | 3.24 rails |
#     3.96 rails | cY (n DE_N, p DE) | 4.50 | S_N | 5.04 DM_N
#   DE in poly: from the inverter's gate, a bar at y 0.72-1.08 left to cX's
#   nmos and one at 1.62-1.98 right to cY's pmos; the DE contact (pin) in the
#   gap over 3.24. DE_N in li from the inverter's riser: y 1.44-1.80 left to
#   cX's pmos contact (over 1.98), 0.72-0.90 right to cY's nmos contact (over
#   3.96). DM_N: li verticals outside the mux (0.18, 5.40), joined on met1
#   track LO (y 0.32-0.60), which runs on under the clock inverters to TG1's
#   DM_N strip. S_N: contact over 5.04 at y 1.44-1.80, li stub over the
#   contactless 4.50 strip up to track HI.
#   clock inverters 5.94 / 7.20 (CLK pin over 5.94)
#   8.46 DM_N | TG1 8.73 | 9.54 M_N | mfb clk 9.81 | | M 10.71 | 10.98 rails |
#   M_N 11.25 | 11.70 M          (dfxtp_2's master shifted 5.04)
#   12.42 rails | M 12.69 | | cinv clk 13.41 | 14.22 S | sfb clk 14.49 | |
#   S_N 15.39 | 15.66 rails
#   Q inverter 16.38 (S contact, its gate bar runs on under Q's li to the
#   S_N inverter at 17.64); edfxbp: Q_N inverter 18.90
# M: PL back to the M gate (as dfxtp_2), mid on to the clocked inverter's M
# contact. The clocked inverter's clock column crosses and swaps the clock
# lines (as dfxtp_2's TG2). S_N returns on met1 track HI (y 2.195-2.475) from
# its inverter to the slave feedback's S_N gate (PH contact, li stub over the
# contactless strip before it) and on to the mux.

source ../scripts/mag_lvdig_lib.tcl
source ../scripts/mag_lvdig_flop.tcl

lvdig_mos nmos_n2f5_f2_l150_bnf_sp  n 90 bnf 1
lvdig_mos nmos_n2f5_f1_l150_fb_sp   n 90 fb 1

set nb {0.275 0.445 0.18 0.54}
set nf {0.36 0.54 0.18 0.63}
set pf {2.43 2.61 2.25 2.70}
island nmos_isl_edfx_m n {{8.28 10.17 0.36} {10.17 11.16 0.45} {10.89 11.88 0.63}} {
    {8.73 0.36 scnmos} {9.81 0.36 scnmos} {10.71 0.45 nmos} {11.25 0.63 nmos}
} [list [list 8.46 {*}$nb] [list 9.54 {*}$nb] [list 10.98 {*}$nb] {11.70 0.36 0.72 0.18 0.81}]
island pmos_isl_edfx_m p {{8.28 11.16 0.45} {10.89 11.88 0.72}} {
    {8.73 0.45 pmoshvt} {9.81 0.45 pmoshvt} {10.71 0.45 pmoshvt} {11.25 0.72 pmoshvt}
} [list [list 8.46 {*}$pf] [list 9.54 {*}$pf] [list 10.98 {*}$pf] {11.70 2.16 2.52 1.98 2.70}]
island nmos_isl_edfx_s n {{12.24 13.05 0.45} {13.00 14.85 0.36} {14.85 15.84 0.45}} {
    {12.69 0.45 nmos} {13.41 0.36 scnmos} {14.49 0.36 scnmos} {15.39 0.45 nmos}
} [list [list 12.42 {*}$nf] [list 14.22 {*}$nb] [list 15.66 {*}$nf]]
island pmos_isl_edfx_s p {{12.24 15.84 0.45}} {
    {12.69 0.45 pmoshvt} {13.41 0.45 pmoshvt} {14.49 0.45 pmoshvt} {15.39 0.45 pmoshvt}
} [list [list 12.42 {*}$pf] [list 14.22 {*}$pf] [list 15.66 {*}$pf]]

proc edfx {cell qn} {
    if {[file exists $cell.mag]} { puts "skip $cell"; return }
    load $cell
    foreach i {nmos_isl_edfx_m pmos_isl_edfx_m nmos_isl_edfx_s pmos_isl_edfx_s} { inst $i 0 0 }

    # ---- mux
    inst nmos_n2f5_f2_l150_fnf_sp     0.90 0.18
    inst pmos_n3f5_f2_l150_hvt_fnf_sp 0.90 2.07
    inst nmos_n2f5_f1_l150_fb_sp      2.70 0.18
    inst pmos_n3f5_f1_l150_hvt_ff_sp  2.70 2.07
    inst nmos_n2f5_f2_l150_bnf_sp     3.96 0.18
    inst pmos_n3f5_f2_l150_hvt_fnf_sp 3.96 2.07
    pa poly 1.095 0.63 1.245 2.07                ;# D
    pa poly 1.635 0.63 1.785 0.72                ;# cX nmos (DE)
    pa poly 1.635 1.80 1.785 2.07                ;# cX pmos (DE_N)
    pa poly 2.895 0.63 3.045 2.07                ;# DE inverter gate
    pa poly 4.155 0.63 4.305 0.90                ;# cY nmos (DE_N)
    pa poly 4.155 1.98 4.305 2.07                ;# cY pmos (DE)
    pa poly 4.695 0.63 4.845 2.07                ;# S_N
    pl 0.72 1.08 1.26 1.44; pcat 0.72 1.08 1.08 1.44   ;# D contact (pin)
    pl 1.62 0.72 3.06 1.08                       ;# DE bar left, to cX nmos
    pl 2.88 1.62 4.32 1.98                       ;# DE bar right, to cY pmos
    pl 3.045 1.08 3.42 1.62; pcat 3.06 1.08 3.42 1.44  ;# DE contact (pin)
    pl 1.62 1.44 2.16 1.80; pcat 1.80 1.44 2.16 1.80   ;# cX pmos (DE_N)
    pl 3.78 0.90 4.32 1.26; pcat 3.78 0.90 4.14 1.26   ;# cY nmos (DE_N)
    pl 4.68 1.44 5.22 1.80; pcat 4.86 1.44 5.22 1.80   ;# S_N
    li 2.52 0.18 2.88 2.70                       ;# DE_N riser
    li 1.80 1.44 2.88 1.80                       ;#   left to cX pmos
    li 2.52 0.72 4.14 0.90                       ;#   right to cY nmos
    li 4.41 1.44 5.22 1.80                       ;# S_N: stub up to HI
    li 4.41 1.44 4.59 2.42
    li 0.18 0.18 0.36 2.70                       ;# DM_N, left
    li 0.18 0.18 1.08 0.54
    li 0.18 2.34 1.08 2.70
    li 5.40 0.18 5.58 2.70                       ;# DM_N, right
    li 4.86 0.18 5.58 0.54
    li 4.86 2.34 5.58 2.70
    nstrap 1.98; pstrap 1.98; nstrap 3.24; pstrap 3.24; nstrap 3.96; pstrap 3.96

    # ---- clock inverters (flop_front's, shifted 5.58)
    inst nmos_n2f5_f1_l150_ff         5.94 0.18
    inst pmos_n3f5_f1_l150_hvt_ff     5.94 2.07
    inst nmos_n2f5_f1_l150_ff         7.20 0.18
    inst pmos_n3f5_f1_l150_hvt_ff     7.20 2.07
    gleft 5.94; gleft 7.20
    nstrap 5.94; pstrap 5.94; nstrap 7.20; pstrap 7.20
    li 6.30 0.54 6.66 2.16                       ;# CLK_N
    li 6.30 1.08 7.38 1.44
    li 7.56 0.54 7.92 2.16                       ;# CLK_P

    # ---- master (dfxtp_2's, shifted 5.04)
    li 8.28 0.18 8.46 2.70                       ;# DM_N
    tgx 8.73
    li 9.54 0.18 9.72 2.70                       ;# M_N
    dcol 9.81
    pa poly 10.635 0.63 10.785 2.25              ;# M
    pa poly 11.175 0.81 11.325 1.98              ;# M_N (M inverter)
    pcpad {10.48 0.825 10.785 1.155} {10.44 0.72 10.80 1.08} 10.615 0.99
    nstrap 10.98; pstrap 10.98
    pcpad {11.115 1.095 11.385 1.425} {11.16 1.08 11.34 1.44} 11.25 1.26
    li 9.54 1.26 11.34 1.44                      ;# M_N corridor
    li 11.52 0.18 11.70 2.70                     ;# M
    li 10.44 0.72 11.70 0.90                     ;#   back to the M gate
    li 11.52 1.26 12.78 1.44                     ;#   on to the clocked inverter

    # ---- slave
    pa poly 12.615 0.63 12.765 2.25              ;# M (clocked inverter)
    pcpad {12.555 1.095 12.825 1.425} {12.60 1.08 12.78 1.44} 12.69 1.26
    nstrap 12.42; pstrap 12.42
    tgx 13.41
    li 14.22 0.18 14.40 2.70                     ;# S
    dcol 14.49
    pa poly 15.315 0.63 15.465 2.25              ;# S_N (slave feedback)
    pcpad {15.255 1.635 15.525 1.965} {15.30 1.62 15.48 1.98} 15.39 1.80
    li 14.94 1.62 15.48 1.98                     ;#   stub up to HI
    li 14.94 1.62 15.12 2.42
    nstrap 15.66; pstrap 15.66
    li 14.22 1.26 16.74 1.44                     ;# S corridor

    # ---- Q inverter (S), bar on to the S_N inverter
    inst nmos_n3f5_f1_l150 16.38 0.18; inst pmos_n6_f1_l150_hvt 16.38 1.62
    pcpad {16.515 1.095 16.785 1.425} {16.56 1.08 16.74 1.44} 16.65 1.26
    pl 16.515 1.08 17.985 1.44
    nstrap 16.38; pstrap 16.38
    li 16.92 0.18 17.10 2.70                     ;# Q
    inst nmos_n2f5_f1_l150_ff 17.64 0.18; inst pmos_n3f5_f1_l150_hvt_ff 17.64 2.07
    nstrap 17.64; pstrap 17.64
    li 18.00 0.54 18.36 2.70                     ;# S_N
    set w 18.72
    if {$qn} {
        inst nmos_n3f5_f1_l150 18.90 0.18; inst pmos_n6_f1_l150_hvt 18.90 1.62
        gleft 18.90
        nstrap 18.90; pstrap 18.90
        li 18.36 1.08 19.08 1.44
        li 19.26 0.54 19.62 2.16                 ;# Q_N
        set w 19.80
    }

    # ---- met1
    # DM_N (LO): mux ends to TG1
    m1 0.12 0.32 8.61 0.60
    via 0.27 0.46; via 5.49 0.46; via 8.46 0.46
    # S_N (HI): its inverter to the slave feedback and the mux
    m1 4.35 2.195 18.33 2.475
    via 4.50 2.335; via 15.03 2.335; via 18.18 2.335
    # CLK_N: PH, down to mid at 10.14, down to PL past the clocked inverter
    m1 6.33 1.66 10.42 1.94
    m1 10.14 1.21 10.42 1.94
    m1 10.14 1.21 14.00 1.49
    m1 13.72 0.76 14.00 1.49
    m1 13.72 0.76 14.82 1.04
    via 6.48 1.80; via 8.73 1.80; via 9.99 1.80; via 13.95 0.90; via 14.67 0.90
    # CLK_P: PL to the clocked inverter's riser, PH after it
    m1 7.59 0.76 13.56 1.04
    m1 13.26 1.66 14.82 1.94
    via 7.74 0.90; via 9.27 0.90; via 9.99 0.90; via 13.41 0.90
    via 13.41 1.80; via 14.67 1.80

    lvdig_rails $w
    gpin CLK 5.94 input signal
    um 0.72 1.08 1.08 1.44
    efx::pin_place D li 0 FreeSans 0.18 center {} input signal
    um 3.06 1.08 3.42 1.44
    efx::pin_place DE li 0 FreeSans 0.18 center {} input signal
    um 16.92 1.08 17.10 1.44
    efx::pin_place Q li 0 FreeSans 0.18 center {} output signal
    if {$qn} {
        um 19.26 1.08 19.62 1.44
        efx::pin_place Q_N li 0 FreeSans 0.18 center {} output signal
    }
    power_pins
    save_drc $cell
}
proc pcat {x0 y0 x1 y1} { um $x0 $y0 $x1 $y1; efx::polycont_draw }

edfx sky130_efx_lvdig__edfxtp_1 0
edfx sky130_efx_lvdig__edfxbp_1 1
quit -noprompt
