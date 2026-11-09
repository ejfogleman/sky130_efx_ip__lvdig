# Build sky130_efx_lvdig__or2_1 (18L), or2_2 (20L), or2_4 (26L) and or3_1
# (24L) (2026-11-07), li only, and the plain device cells they need.
#
#   cd mag && magic -dnull -noconsole ../scripts/mag_build_or.tcl
#
# Writes new cells only (skips any whose .mag exists). Procs:
# scripts/mag_lvdig_lib.tcl.
#
# A nor stage, then an inverter on its own diffusion from 0.72 past the nor's
# last strip (as the and cells). Strips at x + 0.54k; at most two gates per
# diffusion island (only an island's end gates can have a polycont in the gap):
#   or2   pmos  VPWR -A- n -B- out       (fnf: series, middle uncontacted)
#         nmos  VGND -A- out -B- VGND    (fff)
#   or3_1 pmos  VPWR -A- x  |  x -B- n -C- out     (ff | fnf)
#         nmos  VGND -A- out | VGND -B- out -C- VGND (ff | fff)
#         x (a_183_297#, the series node between the islands): li bar along
#         the top of the pmos row (y 2.34-2.70)
# Each gate's polycont is over its island's end column on its side. out: li
# risers on the nmos out strips through the gap up to an li bar at y
# 1.62-1.98 (below the W 0.45 pmos, or along the bottom of or2_4's W 1.08
# pmos, crossing only its uncontacted middle) that takes in the pmos out strip
# and runs right to the inverter's polycont column, then down to it. The
# inverter's first pmos strip is contacted only at the top (tf).

source ../scripts/mag_lvdig_lib.tcl

lvdig_mos nmos_n2f5_f2_l150_fff     n 90 fff
lvdig_mos nmos_n3f5_f2_l150_fff     n 126 fff
lvdig_mos pmos_n2f5_f2_l150_hvt_fnf p 90 fnf

proc inverter {x0 nf} {
    for {set i 0} {$i < $nf} {incr i} {
        set x [expr {$x0 + 0.54 * $i}]
        inst nmos_n3f5_f1_l150 $x 0.18
        inst [expr {$i == 0 ? "pmos_n6_f1_l150_hvt_tf" : "pmos_n6_f1_l150_hvt"}] $x 1.62
    }
    pl [expr {$x0 - 0.18}] 1.08 [expr {$x0 + 0.54 * ($nf - 1) + 0.36}] 1.44; pc $x0
    for {set k 0} {$k <= $nf} {incr k} {
        set x [expr {$x0 + 0.54 * $k}]
        if {$k % 2 == 0} {
            li [expr {$x - 0.18}] 0 [expr {$x + 0.18}] 0.36
            li [expr {$x - 0.18}] 2.52 [expr {$x + 0.18}] 2.88
        } else {
            li [expr {$x - 0.18}] 0.54 [expr {$x + 0.18}] 2.16
            set xx $x
        }
    }
    set xf [expr {$x0 + 0.54}]
    if {$xx > $xf} { li [expr {$xf - 0.18}] 1.08 [expr {$xx + 0.18}] 1.44 }
    set end [expr {$x0 + 0.54 * $nf}]
    lvdig_rails [expr {ceil(($end + 0.36) / 0.36 - 1e-6) * 0.36}]
    gpin X $xf output signal
}

# out bar from x0l to the inverter polycont column x0, and down to it
proc outbar {xl x0} {
    li [expr {$xl - 0.18}] 1.62 [expr {$x0 + 0.18}] 1.98
    li [expr {$x0 - 0.18}] 1.08 [expr {$x0 + 0.18}] 1.98
}
proc riser {x} { li [expr {$x - 0.18}] 0.54 [expr {$x + 0.18}] 1.98 }
proc pstub {x} { li [expr {$x - 0.18}] 1.62 [expr {$x + 0.18}] 2.70 }
proc nstrap {x} { li [expr {$x - 0.18}] 0 [expr {$x + 0.18}] 0.36 }
proc pstrap {x} { li [expr {$x - 0.18}] 2.52 [expr {$x + 0.18}] 2.88 }
# poly bar + polycont for the left / right gate of an island (strip x)
proc gleft {x} { pl [expr {$x - 0.18}] 1.08 [expr {$x + 0.36}] 1.44; pc $x }
proc gright {x} { pl [expr {$x - 0.36}] 1.08 [expr {$x + 0.18}] 1.44; pc $x }

proc or2 {cell ncell pcell py invnf} {
    if {[file exists $cell.mag]} { puts "skip $cell"; return }
    load $cell
    inst $ncell 0.36 0.18
    inst $pcell 0.36 $py
    gleft 0.36;  gright 1.44
    nstrap 0.36; nstrap 1.44; pstrap 0.36
    riser 0.90
    pstub 1.44
    outbar 0.90 2.16
    inverter 2.16 $invnf
    gpin A 0.36 input signal
    gpin B 1.44 input signal
    power_pins
    save_drc $cell
}

proc or3 {cell invnf} {
    if {[file exists $cell.mag]} { puts "skip $cell"; return }
    load $cell
    inst nmos_n2f5_f1_l150_ff     0.36 0.18
    inst pmos_n2f5_f1_l150_hvt_ff 0.36 2.25
    inst nmos_n2f5_f2_l150_fff     1.62 0.18
    inst pmos_n2f5_f2_l150_hvt_fnf 1.62 2.25
    gleft 0.36; gleft 1.62; gright 2.70
    nstrap 0.36; nstrap 1.62; nstrap 2.70; pstrap 0.36
    # series node x: pmos 0.90 to 1.62 along the row's top
    li 0.72 2.34 1.80 2.70
    riser 0.90; riser 2.16
    pstub 2.70
    outbar 0.90 3.42
    inverter 3.42 $invnf
    gpin A 0.36 input signal
    gpin B 1.62 input signal
    gpin C 2.70 input signal
    power_pins
    save_drc $cell
}

# snapped widths: or2_1/2 and or3_1 nor W 0.45, or2_4 nmos 0.63 / pmos 1.08
or2 sky130_efx_lvdig__or2_1 nmos_n2f5_f2_l150_fff pmos_n2f5_f2_l150_hvt_fnf 2.25 1
or2 sky130_efx_lvdig__or2_2 nmos_n2f5_f2_l150_fff pmos_n2f5_f2_l150_hvt_fnf 2.25 2
or2 sky130_efx_lvdig__or2_4 nmos_n3f5_f2_l150_fff pmos_n6_f2_l150_hvt_fnf  1.62 4
or3 sky130_efx_lvdig__or3_1 1
quit -noprompt
