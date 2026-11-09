# Shared procs and the D-flop core for the sky130_efx_lvdig flop build
# scripts (2026-11-07). Source after scripts/mag_lvdig_lib.tcl, from mag/.
# The core and its floorplan are described in scripts/mag_build_dfxtp.tcl.

lvdig_mos pmos_n3f5_f1_l150_hvt_ff  p 126 ff
# scnmos (special nfet) is in sky130's default locked layers: unpainted
# until unlocked
tech unlock scnmos

proc pa {layer x0 y0 x1 y1} { um $x0 $y0 $x1 $y1; paint $layer }
proc via {x y} {
    um [expr {$x - 0.085}] [expr {$y - 0.085}] [expr {$x + 0.085}] [expr {$y + 0.085}]
    paint viali
}
# polycontact: poly rect, li rect, licon 0.17 square centred at (cx, cy)
proc pcpad {p l cx cy} {
    pa poly {*}$p; pa li {*}$l
    um [expr {$cx - 0.085}] [expr {$cy - 0.085}] [expr {$cx + 0.085}] [expr {$cy + 0.085}]
    paint polycont
}
proc nstrap {x} { li [expr {$x - 0.18}] 0 [expr {$x + 0.18}] 0.36 }
proc pstrap {x} { li [expr {$x - 0.18}] 2.52 [expr {$x + 0.18}] 2.88 }
proc gleft {x} { pl [expr {$x - 0.18}] 1.08 [expr {$x + 0.36}] 1.44; pc $x }
proc m1 {x0 y0 x1 y1} { um $x0 $y0 $x1 $y1; paint m1 }
# D input (2026-11-08): contact and pin 1L above the usual gate bar (y
# 1.26-1.62), and the master CLK_N line (PH) jogged up 1L over it (y
# 1.84-2.12, x 2.06-3.70), so a via centred on the D pin clears both met1
# clock lines by 0.285 (met1.2 0.14). CLK_N runs on from x 3.42 to x1.
proc d_input {} { pl 2.70 1.26 3.24 1.62; um 2.70 1.26 3.06 1.62; efx::polycont_draw }
proc d_pin {} {
    um 2.70 1.26 3.06 1.62
    efx::pin_place D li 0 FreeSans 0.18 center {} input signal
}
proc clkn_master {x1} {
    m1 0.75 1.66 2.34 1.94
    m1 2.06 1.84 3.70 2.12
    m1 3.42 1.66 $x1 1.94
}

# Island cell at absolute coordinates (placed at 0 0). pol n: diffusion
# bottom at y 0.18; p: top at y 2.70. rects: {x0 x1 w}; gates {xc w type};
# contacts {x c0 c1 l0 l1} (licon y and li y, absolute).
proc island {name pol rects gates contacts} {
    if {[file exists $name.mag]} { puts "skip $name"; return }
    load $name
    if {$pol eq "n"} {
        lassign {ndiff ndiffc pwell} diff cont well
    } else {
        lassign {pdiff pdiffc nwell} diff cont well
    }
    set xa 1e9; set xb -1e9
    foreach r $rects {
        lassign $r x0 x1 w
        if {$pol eq "n"} { pa $diff $x0 0.18 $x1 [expr {0.18 + $w}] } \
        else { pa $diff $x0 [expr {2.70 - $w}] $x1 2.70 }
        set xa [expr {min($xa, $x0)}]; set xb [expr {max($xb, $x1)}]
    }
    if {$pol eq "n"} { pa $well [expr {$xa - 0.18}] 0 [expr {$xb + 0.18}] 1.08 } \
    else { pa $well [expr {$xa - 0.18}] 1.44 [expr {$xb + 0.18}] 3.42 }
    foreach g $gates {
        lassign $g xc w type
        set g0 [expr {$xc - 0.075}]; set g1 [expr {$xc + 0.075}]
        if {$pol eq "n"} { set b 0.18; set t [expr {0.18 + $w}] } \
        else { set b [expr {2.70 - $w}]; set t 2.70 }
        pa $type $g0 $b $g1 $t
        pa poly $g0 [expr {$b - 0.18}] $g1 $b
        pa poly $g0 $t $g1 [expr {$t + 0.18}]
    }
    foreach c $contacts {
        lassign $c x c0 c1 l0 l1
        pa $cont [expr {$x - 0.085}] $c0 [expr {$x + 0.085}] $c1
        pa li [expr {$x - 0.18}] $l0 [expr {$x + 0.18}] $l1
    }
    save_drc $name
}

# W 0.45 contacts: n 'f' licon 0.36-0.54 li 0.18-0.63; next to a 0.36
# device or 'b': licon 0.275-0.445, li 0.18-0.54. p 0.45 'f': licon
# 2.43-2.61, li 2.25-2.70.
set nb {0.275 0.445 0.18 0.54}
set pf {2.43 2.61 2.25 2.70}
island nmos_isl_dfxtp_2 n {
    {2.70 3.50 0.45} {3.24 5.13 0.36} {5.13 6.12 0.45} {5.85 6.54 0.63}
    {6.48 8.37 0.36} {8.37 9.36 0.45} {9.09 9.90 0.63}
} {
    {3.15 0.45 nmos} {3.69 0.36 scnmos} {4.77 0.36 scnmos} {5.67 0.45 nmos}
    {6.21 0.63 nmos} {6.93 0.36 scnmos} {8.01 0.36 scnmos} {8.91 0.45 nmos}
    {9.45 0.63 nmos}
} [list {2.88 0.36 0.54 0.18 0.63} [list 3.42 {*}$nb] [list 4.50 {*}$nb] \
       [list 5.94 {*}$nb] [list 6.66 {*}$nb] [list 7.74 {*}$nb] \
       [list 9.18 {*}$nb] {9.72 0.36 0.72 0.18 0.81}]
island pmos_isl_dfxtp_2 p {
    {2.70 6.12 0.45} {5.85 6.54 0.72} {6.48 9.36 0.45} {9.09 9.90 1.08}
} {
    {3.15 0.45 pmoshvt} {3.69 0.45 pmoshvt} {4.77 0.45 pmoshvt}
    {5.67 0.45 pmoshvt} {6.21 0.72 pmoshvt} {6.93 0.45 pmoshvt}
    {8.01 0.45 pmoshvt} {8.91 0.45 pmoshvt} {9.45 1.08 pmoshvt}
} [list [list 2.88 {*}$pf] [list 3.42 {*}$pf] [list 4.50 {*}$pf] \
       [list 5.94 {*}$pf] [list 6.66 {*}$pf] [list 7.74 {*}$pf] \
       [list 9.18 {*}$pf] {9.72 1.80 2.52 1.62 2.70}]

# The dfxtp_2 core: clock inverters, main islands, Q inverter (2 fingers),
# met1 clock lines, pins CLK D Q. The caller loads the cell first and adds
# rails and power pins.
proc dfx_core {} {
    inst nmos_isl_dfxtp_2                0 0
    inst pmos_isl_dfxtp_2                0 0
    inst nmos_n3f5_f2_l150_fff        10.44 0.18
    inst pmos_n6_f2_l150_hvt          10.44 1.62
    flop_front
    pa poly 5.595 0.63 5.745 2.25                ;# M (master feedback)
    pa poly 6.135 0.81 6.285 1.98                ;# M_N (M inverter)
    pa poly 8.835 0.63 8.985 2.25                ;# S_N (slave feedback)
    pa poly 9.375 0.81 9.525 1.62                ;# S (S_N inverter)
    li 4.50 1.26 6.30 1.44                       ;# M_N corridor

    # M gate: PL contact, shifted left (licon.14 to the M_N inverter's 0.63;
    # li.5 wants 0.08 of li both sides in x)
    pcpad {5.44 0.825 5.745 1.155} {5.40 0.72 5.76 1.08} 5.575 0.99
    nstrap 5.94; pstrap 5.94
    # M_N gate: contact in the corridor
    pcpad {6.075 1.095 6.345 1.425} {6.12 1.08 6.30 1.44} 6.21 1.26
    # M: vertical, back along y 0.72-0.90 to the M gate's contact
    li 6.48 0.18 6.66 2.70
    li 5.40 0.72 6.66 0.90

    tgx 6.93                                     ;# TG2 (crossing)

    # S: vertical, corridor to the S_N inverter's contact
    li 7.74 0.18 7.92 2.70
    li 7.74 1.26 9.54 1.44

    dcol 8.01                                    ;# slave feedback clock

    # S_N gate (slave feedback): PL contact, shifted left
    pcpad {8.68 0.825 8.985 1.155} {8.64 0.72 9.00 1.08} 8.815 0.99
    nstrap 9.18; pstrap 9.18
    # S gate: contact in the corridor
    pcpad {9.315 1.095 9.585 1.425} {9.36 1.08 9.54 1.44} 9.45 1.26
    # S_N: vertical, back to the S_N gate, on to the Q inverter
    li 9.72 0.18 9.90 2.70
    li 8.64 0.72 9.90 0.90
    li 9.72 1.08 10.62 1.44

    # ---- Q inverter (2 fingers): contact over 10.44, bar across both gates
    pl 10.26 1.08 11.34 1.44; pc 10.44
    li 10.80 0.54 11.16 2.16
    nstrap 10.44; pstrap 10.44; nstrap 11.52; pstrap 11.52

    # ---- met1 clock lines (0.28, mux2_1 style)
    # master CLK_N on PH, steps down through the mid track to the slave's PL
    clkn_master 6.50
    m1 6.22 1.21 6.50 1.94
    m1 6.22 1.21 7.52 1.49
    m1 7.24 0.76 7.52 1.49
    m1 7.24 0.76 8.34 1.04
    via 0.90 1.80; via 3.69 1.80; via 4.95 1.80; via 7.47 0.90; via 8.19 0.90
    # CLK_P: master on PL to TG2's riser bottom; slave on PH from its top
    m1 2.01 0.76 7.08 1.04
    m1 6.78 1.66 8.34 1.94
    via 2.16 0.90; via 4.23 0.90; via 4.95 0.90; via 6.93 0.90
    via 6.93 1.80; via 8.19 1.80
    gpin CLK 0.36 input signal
    d_pin
    um 10.80 1.08 11.16 1.44
    efx::pin_place Q li 0 FreeSans 0.18 center {} output signal
}

# ---- reusable pieces for the other flops (2026-11-07) ----------------------
proc f3 {x} { format %.3f $x }
# Crossing (transmission-gate) clock column, gate at c, left strip c - 0.27
# with its data vertical on its left half: nmos stub contact at PL (licon
# c, 0.90) rising in li to y 1.98; pmos stub jogging in poly (y 1.275-1.455)
# to a PL contact at c + 0.54. Vias are the caller's.
# ly: PL licon centre, 0.90 over a 0.36 special nfet; 0.905 over a 0.45 nfet
# (licon.14), whose diffusion tops at 0.63 (stubs start there).
proc tgx {c {ly 0.90}} {
    if {$ly == 0.90} {
        set nt 0.54; set np [list [f3 [expr {$c - 0.135}]] 0.735 [f3 [expr {$c + 0.135}]] 1.065]
        set pb 0.735
    } else {
        set nt 0.63; set np [list [f3 [expr {$c - 0.165}]] 0.77 [f3 [expr {$c + 0.165}]] 1.04]
        set pb 0.74
    }
    pa poly [f3 [expr {$c - 0.075}]] $nt [f3 [expr {$c + 0.075}]] [lindex $np 1]
    pcpad $np [list [f3 [expr {$c - 0.09}]] 0.72 [f3 [expr {$c + 0.09}]] 1.98] $c $ly
    pa poly [f3 [expr {$c - 0.075}]] 1.275 [f3 [expr {$c + 0.075}]] 2.25
    pa poly [f3 [expr {$c - 0.075}]] 1.275 [f3 [expr {$c + 0.675}]] 1.455
    pcpad [list [f3 [expr {$c + 0.405}]] $pb [f3 [expr {$c + 0.675}]] 1.455] \
          [list [f3 [expr {$c + 0.45}]] 0.72 [f3 [expr {$c + 0.63}]] 1.08] [f3 [expr {$c + 0.54}]] $ly
}
# Direct clock column, gate at c: nmos PL and pmos PH contacts offset right
# (licon x c + 0.18), clear of a 1L data vertical on the left strip's right
# half; the li corridor y 1.26-1.44 passes between them.
proc dcol {c {ly 0.90}} {
    set a [f3 [expr {$c - 0.075}]]; set b [f3 [expr {$c + 0.075}]]
    set p1 [f3 [expr {$c + 0.315}]]; set l0 [f3 [expr {$c + 0.09}]]; set l1 [f3 [expr {$c + 0.27}]]
    set x [f3 [expr {$c + 0.18}]]
    if {$ly == 0.90} { set nt 0.54; set y0 0.735; set y1 1.065 } \
    else { set nt 0.63; set y0 0.74; set y1 1.07 }
    pa poly $a $nt $b $y0
    pcpad [list $a $y0 $p1 $y1] [list $l0 0.72 $l1 1.08] $x $ly
    pa poly $a 1.965 $b 2.25
    pcpad [list $a 1.635 $p1 1.965] [list $l0 1.62 $l1 1.98] $x 1.80
}
# Clock inverters, D inverter contact, D_N vertical, TG1, M_N vertical and the
# master feedback clock column: the dfxtp_2 core left of x 5.1 (no met1).
proc flop_front {} {
    inst nmos_n2f5_f1_l150_ff         0.36 0.18
    inst pmos_n3f5_f1_l150_hvt_ff     0.36 2.07
    inst nmos_n2f5_f1_l150_ff         1.62 0.18
    inst pmos_n3f5_f1_l150_hvt_ff     1.62 2.07
    gleft 0.36; gleft 1.62
    nstrap 0.36; pstrap 0.36; nstrap 1.62; pstrap 1.62
    li 0.72 0.54 1.08 2.16
    li 0.72 1.08 1.80 1.44
    li 1.98 0.54 2.34 2.16
    pa poly 3.075 0.63 3.225 2.25
    d_input
    nstrap 2.88; pstrap 2.88
    li 3.24 0.18 3.42 2.70
    tgx 3.69
    li 4.50 0.18 4.68 2.70
    dcol 4.77
}
# Q_N chain after a Q inverter whose gate bar (y 1.08-1.44) carries S_N and
# ends at x bar1: the bar runs on (under Q's li) to the gate of an inverter
# (p 0.63 / n 0.45) at rails strip x0, whose output drives the Q_N inverter
# (nqn fingers, 1.08 / 0.63) with its contact over x0 + 1.26. Returns {cell
# width (even L), x of the Q_N riser}; the caller places the Q_N pin (after Q).
proc qn_chain {bar1 x0 nqn} {
    set g [f3 [expr {$x0 + 0.36}]]
    inst nmos_n2f5_f1_l150_ff     $x0 0.18
    inst pmos_n3f5_f1_l150_hvt_ff $x0 2.07
    pl $bar1 1.08 $g 1.44
    nstrap $x0; pstrap $x0
    set n [f3 [expr {$x0 + 0.54}]]
    li [f3 [expr {$n - 0.18}]] 0.54 [f3 [expr {$n + 0.18}]] 2.16
    set q0 [f3 [expr {$x0 + 1.26}]]
    if {$nqn == 1} {
        inst nmos_n3f5_f1_l150 $q0 0.18; inst pmos_n6_f1_l150_hvt $q0 1.62
        gleft $q0
        set last [f3 [expr {$q0 + 0.54}]]
    } else {
        inst nmos_n3f5_f2_l150_fff $q0 0.18; inst pmos_n6_f2_l150_hvt $q0 1.62
        pl [f3 [expr {$q0 - 0.18}]] 1.08 [f3 [expr {$q0 + 0.90}]] 1.44; pc $q0
        set last [f3 [expr {$q0 + 1.08}]]
        nstrap $last; pstrap $last
    }
    nstrap $q0; pstrap $q0
    li [f3 [expr {$n + 0.18}]] 1.08 [f3 [expr {$q0 + 0.18}]] 1.44
    set qx [f3 [expr {$q0 + 0.54}]]
    li [f3 [expr {$qx - 0.18}]] 0.54 [f3 [expr {$qx + 0.18}]] 2.16
    set w [expr {$last + 0.36}]
    set nl [expr {round($w / 0.18)}]
    if {$nl % 2} { incr nl }
    return [list [f3 [expr {$nl * 0.18}]] $qx]
}
proc qn_pin {qx} {
    um [f3 [expr {$qx - 0.18}]] 1.08 [f3 [expr {$qx + 0.18}]] 1.44
    efx::pin_place Q_N li 0 FreeSans 0.18 center {} output signal
}
