# Build sky130_efx_lvdig__and3_1 (24L) and and4_2 (30L) (2026-11-07), li
# only, and the plain device cells they need.
#
#   cd mag && magic -dnull -noconsole ../scripts/mag_build_and3_and4.tcl
#
# Writes new cells only (skips any whose .mag exists). Procs:
# scripts/mag_lvdig_lib.tcl.
#
# Only a diffusion island's two end gates can have a polycont in the gap (a
# polycont over a strip between two different gates is 0.015 from both), so
# the nand stage is two islands of one or two gates, joined in li at the
# series node x between them (nmos row, y 0.18-0.54), then an inverter on its
# own diffusion, as and2:
#   and3_1  nmos  VGND -C- x  |  x -B- n -A- out     (ff | fnf)
#           pmos  VPWR -C- out | VPWR -B- out -A- VPWR (ff | fff)
#   and4_2  nmos  VGND -D- n -C- x  |  x -B- n -A- out (fnf | fnf)
#           pmos  VPWR -D- out -C- VPWR | VPWR -B- out -A- VPWR (fff | fff)
# Islands 0.72 apart (diffusion gap 0.36). Each gate's polycont is over its
# island's end column on its side. out: the last island's nmos out strip jogs
# left over its uncontacted middle (y 0.54-0.72) to an li riser at that
# middle column, up through the gap to an li bar at y 1.62-1.98 (below the
# W 0.45 pmos) that joins the pmos out strips (stubs down from their
# contacts) and runs right to the inverter's polycont column, then down to it.
# The inverter's first pmos strip is contacted only at the top (tf).

source ../scripts/mag_lvdig_lib.tcl

lvdig_mos nmos_n2f5_f1_l150_ff n 90 ff
lvdig_mos pmos_n2f5_f1_l150_hvt_ff p 90 ff

# islands: {x nf nmos-cell pmos-cell gates}, left to right; the last has two
# gates (fnf nmos); inverter of invnf fingers
proc andn {cell islands invnf} {
    if {[file exists $cell.mag]} { puts "skip $cell"; return }
    load $cell
    set pins {}
    set outs {}
    set prev {}
    foreach isl $islands {
        lassign $isl x nf ncell pcell gates
        inst $ncell $x 0.18
        inst $pcell $x 2.25
        set xr [expr {$x + 0.54 * $nf}]
        # polycont at the left column for the first gate, the right column
        # for a second
        lassign $gates g0 g1
        pl [expr {$x - 0.18}] 1.08 [expr {$x + 0.36}] 1.44; pc $x
        lappend pins $g0 $x
        if {$nf == 2} {
            pl [expr {$xr - 0.36}] 1.08 [expr {$xr + 0.18}] 1.44; pc $xr
            lappend pins $g1 $xr
        }
        # pmos: VPWR on even strips (straps), out on odd (stubs to the bar)
        for {set k 0} {$k <= $nf} {incr k} {
            set xs [expr {$x + 0.54 * $k}]
            if {$k % 2 == 0} {
                li [expr {$xs - 0.18}] 2.52 [expr {$xs + 0.18}] 2.88
            } else {
                li [expr {$xs - 0.18}] 1.62 [expr {$xs + 0.18}] 2.70
                lappend outs $xs
            }
        }
        if {$prev eq {}} {
            # VGND strap at the first island's left strip
            li [expr {$x - 0.18}] 0 [expr {$x + 0.18}] 0.36
        } else {
            # series node x: previous island's right strip to this left strip
            li [expr {$prev - 0.18}] 0.18 [expr {$x + 0.18}] 0.54
        }
        set prev $xr
        set last [list $x $xr]
    }
    # nmos out (last island's right strip) over the middle to a riser
    lassign $last xl xr
    set xm [expr {$xl + 0.54}]
    li [expr {$xm - 0.18}] 0.54 [expr {$xr + 0.18}] 0.72
    li [expr {$xm - 0.18}] 0.54 [expr {$xm + 0.18}] 1.98
    # out bar to the inverter polycont column
    set x0 [expr {$xr + 0.72}]
    li [expr {[lindex $outs 0] - 0.18}] 1.62 [expr {$x0 + 0.18}] 1.98
    li [expr {$x0 - 0.18}] 1.08 [expr {$x0 + 0.18}] 1.98
    # inverter
    for {set i 0} {$i < $invnf} {incr i} {
        set x [expr {$x0 + 0.54 * $i}]
        inst nmos_n3f5_f1_l150 $x 0.18
        inst [expr {$i == 0 ? "pmos_n6_f1_l150_hvt_tf" : "pmos_n6_f1_l150_hvt"}] $x 1.62
    }
    pl [expr {$x0 - 0.18}] 1.08 [expr {$x0 + 0.54 * ($invnf - 1) + 0.36}] 1.44; pc $x0
    for {set k 0} {$k <= $invnf} {incr k} {
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
    set end [expr {$x0 + 0.54 * $invnf}]
    lvdig_rails [expr {ceil(($end + 0.36) / 0.36 - 1e-6) * 0.36}]
    foreach {name x} $pins { gpin $name $x input signal }
    gpin X $xf output signal
    power_pins
    save_drc $cell
}

andn sky130_efx_lvdig__and3_1 {
    {0.36 1 nmos_n2f5_f1_l150_ff  pmos_n2f5_f1_l150_hvt_ff  {C}}
    {1.62 2 nmos_n2f5_f2_l150_fnf pmos_n2f5_f2_l150_hvt_fff {B A}}
} 1
andn sky130_efx_lvdig__and4_2 {
    {0.36 2 nmos_n2f5_f2_l150_fnf pmos_n2f5_f2_l150_hvt_fff {D C}}
    {2.16 2 nmos_n2f5_f2_l150_fnf pmos_n2f5_f2_l150_hvt_fff {B A}}
} 2
quit -noprompt
