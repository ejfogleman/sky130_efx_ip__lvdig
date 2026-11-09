# One-off (2026-11-07): narrow sky130_efx_lvdig__nand2_1 / nor2_1 from 14L to
# 10L now that their series stacks are the uncontacted fnf device cells
# (then named *_series; renamed 2026-11-07).
#
#   cd mag && magic -dnull -noconsole ../scripts/mag_shrink_nand2_nor2.tcl
#
# With no contact on the series stack's middle diffusion, Y crosses it in li
# inside the device row, so the gap above the right strip (x 1.44) is free:
# the right input's polycont moves from x 1.80-2.16 to 1.26-1.62 (its poly bar
# 1.08-1.62), everything right of x 1.80 is erased, and lvdig_rails redraws
# rails, wells, rail viali and FIXED_BBOX at 1.80. nor2_1 also loses the li
# stub at x 1.08-1.26 in the gap (left from an old output bar), which would
# touch the moved polycont. Not rerunnable.

proc um {x0 y0 x1 y1} { box values ${x0}um ${y0}um ${x1}um ${y1}um }

# as in scripts/mag_rails_grid.tcl
proc lvdig_rails {w} {
    um 0 -0.36 $w 0;    erase viali
    um 0 2.88 $w 3.24;  erase viali
    um 0 -0.54 $w 0.18; paint m1
    um 0 2.70 $w 3.42;  paint m1
    um 0 -0.36 $w 0;    paint li
    um 0 2.88 $w 3.24;  paint li
    um 0 1.44 $w 3.42;  paint nwell
    um 0 0 $w 1.08;     paint pwell
    set n [expr {round($w / 0.36)}]
    for {set k 0} {$k < $n} {incr k} {
        set x [expr {0.36 * $k}]
        um [expr {$x + 0.095}] -0.265 [expr {$x + 0.265}] -0.095; paint viali
        um [expr {$x + 0.095}] 2.975 [expr {$x + 0.265}] 3.145;   paint viali
    }
    um 0 -0.18 $w 3.06; efx::fixed_bbox
}

# cell, the input on the right gate (series order: nand2 nmos VGND-B-A-Y,
# nor2 pmos VPWR-A-B-Y)
foreach {cell in} {nand2_1 A nor2_1 B} {
    set c sky130_efx_lvdig__$cell
    load $c
    # old right-hand poly bar, polycont and its pin label
    um 1.08 1.08 2.52 1.44; erase poly; erase polycont
    um 1.85 1.10 2.10 1.40; erase labels
    if {$cell eq "nor2_1"} { um 1.08 1.08 1.26 1.44; erase li }
    # everything right of the new edge
    um 1.80 -0.60 2.60 3.50; erase
    # new poly bar and polycont over the right strip's column
    um 1.08 1.08 1.62 1.44; paint poly
    um 1.26 1.08 1.62 1.44; efx::polycont_draw
    lvdig_rails 1.80
    um 1.26 1.08 1.62 1.44
    efx::pin_place $in li 0 FreeSans 0.18 center {} input signal
    save $c
    select top cell; drc check; drc catchup
    puts "R $c: bbox [property FIXED_BBOX] DRC [drc list count total] [drc listall why]"
}
quit -noprompt
