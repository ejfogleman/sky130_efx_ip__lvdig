# Shared procs for the sky130_efx_lvdig layout build scripts (2026-11-07).
# Source from a script run in mag/:  source ../scripts/mag_lvdig_lib.tcl
# Coordinates in um unless a value ends in i (internal units, 0.005 um).

proc um {x0 y0 x1 y1} { box values ${x0}um ${y0}um ${x1}um ${y1}um }
proc iu {x0 y0 x1 y1} { box values ${x0}i ${y0}i ${x1}i ${y1}i }
proc inst {cell x y} { box values ${x}um ${y}um ${x}um ${y}um; getcell $cell child 0 0 }
proc li {x0 y0 x1 y1} { um $x0 $y0 $x1 $y1; paint li }
proc pl {x0 y0 x1 y1} { um $x0 $y0 $x1 $y1; paint poly }
proc pc {x} { um [expr {$x - 0.18}] 1.08 [expr {$x + 0.18}] 1.44; efx::polycont_draw }

# Rails, wells, gridded rail viali and FIXED_BBOX of a cell w um wide (an even
# number of L). Same as scripts/mag_rails_grid.tcl.
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

# li pin over the gap between rows at strip column x
proc gpin {name x class use} {
    um [expr {$x - 0.18}] 1.08 [expr {$x + 0.18}] 1.44
    efx::pin_place $name li 0 FreeSans 0.18 center {} $class $use
}
proc power_pins {} {
    um 0 -0.36 0.36 0;   efx::pin_place VGND m1 0 FreeSans 0.18 center {} bidirectional ground
    um 0 2.88 0.36 3.24; efx::pin_place VPWR m1 0 FreeSans 0.18 center {} bidirectional power
    um 0 2.70 0.18 2.88; efx::pin_place VPB nwell 0 FreeSans 0.18 center {} bidirectional power
    um 0 0 0.18 0.18;    efx::pin_place VNB pwell 0 FreeSans 0.18 center {} bidirectional ground
}

proc save_drc {cell} {
    save $cell
    select top cell; drc check; drc catchup
    puts "R $cell: DRC [drc list count total] [drc listall why]"
}

# Plain multi-finger MOS cell in the efx device cells' geometry. Internal
# units: strip k centred at x 108k, diffusion y 0..h (h = W / 0.005), L 0.15.
# spec: one letter per strip (fingers + 1): f full-height contact, t top only,
# b bottom only (one licon, as the user-drawn fbf / ftf cells), n none.
# Placed as the lvdig cells place devices: nmos origin at y 0.18, poly to
# local 180 (the gap at y 1.08), pwell; pmos with the diffusion top at y 2.70,
# poly down to local h - 252 (y 1.44), nwell. Skips an existing cell.
# short 1: poly only 36 (0.18 um) past the diffusion at both ends, for cells
# that draw their own poly between the rows (split gate columns).
# l: gate length in internal units (default 30 = 0.15 um). Strip pitch
# p = 72 + l rounded up to a multiple of 36 = lambda (108 for 0.15, 180 for 0.5:
# the delay cells' long gates, 2026-11-08), gate centred between strips.
proc lvdig_mos {name pol h spec {short 0} {l 30}} {
    if {[file exists $name.mag]} { puts "skip $name"; return }
    load $name
    set nf [expr {[string length $spec] - 1}]
    set p [expr {36 * int(ceil((72 + $l) / 36.0))}]
    set xr [expr {$p * $nf}]
    if {$pol eq "n"} {
        lassign [list -36 180 pwell ndiff nmos ndiffc] pb pt well diff gate cont
    } else {
        lassign [list [expr {$h - 252}] [expr {$h + 36}] nwell pdiff pmoshvt pdiffc] pb pt well diff gate cont
    }
    if {$short} { set pb -36; set pt [expr {$h + 36}] }
    # (short: well 0.18 past the poly, at least nwell.1's 0.84)
    iu -72 [expr {min($pb, -36) - 36 * $short}] [expr {$xr + 72}] [expr {$pt + 36 * $short}]
    paint $well
    iu -36 0 [expr {$xr + 36}] $h; paint $diff
    for {set g 0} {$g < $nf} {incr g} {
        set gx [expr {$p * $g + ($p - $l) / 2}]
        iu $gx 0 [expr {$gx + $l}] $h; paint $gate
        iu $gx $pb [expr {$gx + $l}] 0; paint poly
        iu $gx $h [expr {$gx + $l}] $pt; paint poly
    }
    # full contact as the efx f1 cells: 36 .. 36 * floor((h - 18) / 36)
    set ftop [expr {36 * int(($h - 18) / 36)}]
    for {set k 0} {$k <= $nf} {incr k} {
        set x [expr {$p * $k}]
        switch [string index $spec $k] {
            f { lassign [list 36 $ftop 0 $h] c0 c1 l0 l1 }
            b { lassign [list 19 53 0 72] c0 c1 l0 l1 }
            t { lassign [list [expr {$h - 53}] [expr {$h - 19}] [expr {$h - 72}] $h] c0 c1 l0 l1 }
            n { continue }
            default { error "lvdig_mos $name: bad strip code in $spec" }
        }
        iu [expr {$x - 17}] $c0 [expr {$x + 17}] $c1; paint $cont
        iu [expr {$x - 36}] $l0 [expr {$x + 36}] $l1; paint li
    }
    save_drc $name
}
