# One-off (2026-11-07): bring the user-drawn tap cells into the logic cells'
# frame and conventions.
#
#   cd mag && magic -dnull -noconsole ../scripts/mag_fix_taps.tcl
#
# The taps were drawn with the outline at x 1.44.., y 0..3.24; the logic cells
# have it at x 0.., y -0.18..3.06. Each cell is moved by (-1.44, -0.18), its
# wells and labels are erased, lvdig_rails redraws rails, wells, gridded rail
# viali and FIXED_BBOX, and the pins are placed as in the PDK cells:
# tapvgnd: VGND VPB VPWR (VPB on the n-tap li), tapvpwrvgnd: VGND VPWR.
# Not rerunnable: a second run would move the cells again.

# um and lvdig_rails as in scripts/mag_rails_grid.tcl
proc um {x0 y0 x1 y1} { box values ${x0}um ${y0}um ${x1}um ${y1}um }

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

proc pin {name x0 y0 x1 y1 layer class use} {
    um $x0 $y0 $x1 $y1; efx::pin_place $name $layer 0 FreeSans 0.18 center {} $class $use
}

foreach {cell w} {tapvgnd_1 0.72 tapvgnd_2 1.08 tapvpwrvgnd_1 0.72 tapvpwrvgnd_2 1.08} {
    set c sky130_efx_lvdig__$cell
    load $c
    um -3 -3 8 8; select area; move w 1.44um; move s 0.18um; select clear
    um -3 -3 8 8; erase labels; erase nwell; erase pwell
    lvdig_rails $w
    # a 4L cell's n-well (0.72) is under nwell.1 (0.84) on its own: run it L
    # past both edges (1.08), as the user drew it and as hd's tap_1 does
    if {$w < 0.84} { um -0.18 1.44 [expr {$w + 0.18}] 3.42; paint nwell }
    pin VGND 0 -0.36 0.36 0 m1 bidirectional ground
    pin VPWR 0 2.88 0.36 3.24 m1 bidirectional power
    if {[string match tapvgnd_* $cell]} {
        pin VPB 0.18 1.98 0.54 2.34 li bidirectional power
    }
    save $c
    select top cell; drc check; drc catchup
    puts "R $c: bbox [property FIXED_BBOX], DRC [drc list count total] [drc listall why]"
}
quit -noprompt
