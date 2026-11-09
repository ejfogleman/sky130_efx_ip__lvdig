# Build sky130_efx_lvdig__and2_1, and2_2, and2_4 (2026-11-07), li only, and
# the plain device cells they need. and2_1 18L, and2_2 20L, and2_4 26L.
#
#   cd mag && magic -dnull -noconsole ../scripts/mag_build_and2.tcl
#
# Writes new cells only (skips any whose .mag exists). Procs:
# scripts/mag_lvdig_lib.tcl.
#
# A nand2 stage (strips s0..s2 at x 0.36, 0.90, 1.44) then an inverter on its
# own diffusion from x0 = 2.16 (0.36 diffusion gap), as nand2_1 + inv:
#   nand nmos  VGND(s0) -B- n -A- out(s2), series, middle uncontacted
#   nand pmos  VPWR(s0) -B- out(s1) -A- VPWR(s2)
#   out: s2 jogs in li over the uncontacted middle (y 0.54-0.72) to an li
#        riser at s1 up to the pmos out contact; from it an li bar at y
#        1.62-1.98 runs right to the inverter's polycont column (x0), then
#        down to the polycont. and2_1/2: that bar is below the small (W 0.45)
#        nand pmos. and2_4: it runs along the bottom of the W 1.08 pmos, whose
#        s2 is contacted only at the top (spec fft).
#   The inverter's first pmos strip (VPWR) is contacted only at the top, so
#   the bar can cross its bottom. Gates: B polycont over s0, A over s2, the
#   inverter's over x0; X risers on the inverter's odd strips, joined by an li
#   bar in the gap when there are several.

source ../scripts/mag_lvdig_lib.tcl

lvdig_mos nmos_n2f5_f2_l150_fnf     n 90 fnf
lvdig_mos pmos_n2f5_f2_l150_hvt_fff p 90 fff
lvdig_mos pmos_n6_f2_l150_hvt_fft   p 216 fft
lvdig_mos pmos_n6_f1_l150_hvt_tf    p 216 tf

# cell, nand nmos cell, nand pmos cell and its y, inverter fingers
proc and2 {cell ncell pcell py nf} {
    if {[file exists $cell.mag]} { puts "skip $cell"; return }
    load $cell
    set x0 2.16
    # nand2 stage
    inst $ncell 0.36 0.18
    inst $pcell 0.36 $py
    pl 0.18 1.08 0.72 1.44; pc 0.36
    pl 1.08 1.08 1.62 1.44; pc 1.44
    li 0.18 0 0.54 0.36
    li 0.18 2.52 0.54 2.88
    li 1.26 2.52 1.62 2.88
    li 0.72 0.54 1.62 0.72
    li 0.72 0.54 1.08 [expr {$py == 2.25 ? 2.70 : 1.98}]
    li 0.72 1.62 [expr {$x0 + 0.18}] 1.98
    li [expr {$x0 - 0.18}] 1.08 [expr {$x0 + 0.18}] 1.98
    # inverter stage
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
            set xl $x
        }
    }
    set xf [expr {$x0 + 0.54}]
    if {$xl > $xf} { li [expr {$xf - 0.18}] 1.08 [expr {$xl + 0.18}] 1.44 }
    set last [expr {$x0 + 0.54 * $nf}]
    lvdig_rails [expr {ceil(($last + 0.36) / 0.36 - 1e-6) * 0.36}]
    gpin B 0.36 input signal
    gpin A 1.44 input signal
    gpin X $xf output signal
    power_pins
    save_drc $cell
}

# snapped widths: and2_1/2 nand W 0.45 (n2f5), and2_4 nmos 0.63 / pmos 1.08
and2 sky130_efx_lvdig__and2_1 nmos_n2f5_f2_l150_fnf pmos_n2f5_f2_l150_hvt_fff 2.25 1
and2 sky130_efx_lvdig__and2_2 nmos_n2f5_f2_l150_fnf pmos_n2f5_f2_l150_hvt_fff 2.25 2
and2 sky130_efx_lvdig__and2_4 nmos_n3f5_f2_l150_fnf pmos_n6_f2_l150_hvt_fft 1.62 4
quit -noprompt
