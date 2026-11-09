# Build sky130_efx_lvdig inverter / buffer layouts (one or two inverter stages)
# in the conventions of sky130_efx_lvdig__inv_1 / inv_2 / buf_2 (2026-11-06).
#
#   cd mag && magic -dnull -noconsole ../scripts/mag_build_inverters.tcl
#
# Writes new cells only: a cell whose .mag already exists is skipped (rerunning
# would add paint to it). All coordinates in um.
#
# Each stage is {nf ntype pf ptype}: nf nmos and pf pmos fingers of the given
# device cells. Fingers share strips on a 0.54 pitch; strip 0 is at the
# stage's first x; even strips go to the rails, odd strips are the stage's
# output. A column with no nmos (pf > nf) has just the pmos. Gates: one poly bar
# per stage at y 1.08-1.44 with a polycont over strip 0's column in the gap
# between rows (stage 1: the A pin at x 0.18-0.54; stage 2: joined to stage 1's
# output in li). Outputs: each odd strip runs into the gap between
# rows, where an li bar at y 1.08-1.44 joins them.

proc um {x0 y0 x1 y1} { box values ${x0}um ${y0}um ${x1}um ${y1}um }
proc inst {cell x y} { box values ${x}um ${y}um ${x}um ${y}um; getcell $cell child 0 0 }
proc li {x0 y0 x1 y1} { um $x0 $y0 $x1 $y1; paint li }
proc pl {x0 y0 x1 y1} { um $x0 $y0 $x1 $y1; paint poly }

# device cells: nmos -> its poly top above its origin; pmos -> its diffusion top
array set NTOP {n2f5 0.72 n3 0.72 n3f5 0.90}
array set PTOP {n4f5 0.90 n6 1.08}
array set NCELL {n2f5 nmos_n2f5_f1_l150 n3 nmos_n3_f1_l150 n3f5 nmos_n3f5_f1_l150}
array set PCELL {n4f5 pmos_n4f5_f1_l150_hvt n6 pmos_n6_f1_l150_hvt}

# one stage with strip 0 at x0; returns the x of its odd (output) strips and its last strip
proc stage {x0 nf nt pf pt} {
    global NTOP PTOP NCELL PCELL
    set py [expr {2.70 - $PTOP($pt)}]
    set cols [expr {max($nf, $pf)}]
    for {set i 0} {$i < $cols} {incr i} {
        set x [expr {$x0 + 0.54 * $i}]
        if {$i < $nf} {
            inst $NCELL($nt) $x 0.18
            set top [expr {0.18 + $NTOP($nt)}]
            if {$top < 1.08 - 1e-6} { pl [expr {$x + 0.18}] $top [expr {$x + 0.36}] 1.08 }
        }
        if {$i < $pf} {
            inst $PCELL($pt) $x $py
            set bot [expr {$py - 0.18}]
            if {$bot > 1.44 + 1e-6} { pl [expr {$x + 0.18}] 1.44 [expr {$x + 0.36}] $bot }
        }
    }
    # straps from the rail strips; risers from the output strips into the gap
    set outs {}
    for {set k 0} {$k <= $cols} {incr k} {
        set x [expr {$x0 + 0.54 * $k}]
        set hasn [expr {$k <= $nf}]
        set hasp [expr {$k <= $pf}]
        if {$k % 2 == 0} {
            if {$hasn} { li [expr {$x - 0.18}] 0 [expr {$x + 0.18}] 0.36 }
            if {$hasp} { li [expr {$x - 0.18}] 2.52 [expr {$x + 0.18}] 2.88 }
        } else {
            set y0 [expr {$hasn ? 0.54 : 1.08}]
            set y1 [expr {$hasp ? 2.16 : 1.44}]
            li [expr {$x - 0.18}] $y0 [expr {$x + 0.18}] $y1
            lappend outs $x
        }
    }
    # gate bar from the polycont (over strip 0's column, in the gap between
    # rows) to the last gate column
    pl [expr {$x0 - 0.18}] 1.08 [expr {$x0 + 0.54 * ($cols - 1) + 0.36}] 1.44
    um [expr {$x0 - 0.18}] 1.08 [expr {$x0 + 0.18}] 1.44; efx::polycont_draw
    return [list $outs [expr {$x0 + 0.54 * $cols}]]
}

# rails, wells and outline of a cell w um wide (w a multiple of 0.36)
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

proc build {cell out stages} {
    if {[file exists $cell.mag]} { puts "skip $cell: $cell.mag exists"; return }
    load $cell
    set x0 0.36
    set prev {}
    foreach st $stages {
        lassign [stage $x0 {*}$st] outs last
        if {$prev ne {}} {
            # previous stage's output to this stage's polycont (left edge x0 - 0.18)
            li [expr {[lindex $prev 0] - 0.18}] 1.08 [expr {$x0 - 0.18}] 1.44
        }
        set prev $outs
        set x0 [expr {$last + 0.72}]
    }
    # last stage's output bar across its odd strips
    li [expr {[lindex $prev 0] - 0.18}] 1.08 [expr {[lindex $prev end] + 0.18}] 1.44
    # width rounded up to an even number of L; rails, wells and outline by
    # lvdig_rails (rail contacts on the global 2L grid)
    set w [expr {ceil(($last + 0.36) / 0.36 - 1e-6) * 0.36}]
    lvdig_rails $w
    set xo [lindex $prev 0]
    pin A 0.18 1.08 0.54 1.44 li input signal
    pin $out [expr {$xo - 0.18}] 1.08 [expr {$xo + 0.18}] 1.44 li output signal
    pin VPWR 0 2.88 0.36 3.24 m1 bidirectional power
    pin VGND 0 -0.36 0.36 0 m1 bidirectional ground
    um 0 2.70 0.18 2.88; efx::pin_place VPB nwell 0 FreeSans 0.18 center {} bidirectional power
    um 0 0 0.18 0.18;    efx::pin_place VNB pwell 0 FreeSans 0.18 center {} bidirectional ground
    save $cell
    select top cell; drc check; drc catchup
    puts "$cell: width $w um, DRC [drc list count total]"
    puts [drc listall why]
}

# snapped widths (scripts/lambda_widths.py): n 0.45 = n2f5, 0.54 = n3, 0.63 = n3f5;
# p 0.81 = n4f5, 1.08 = n6
build sky130_efx_lvdig__clkinv_1 Y {{1 n2f5 2 n4f5}}
build sky130_efx_lvdig__clkinv_2 Y {{2 n2f5 3 n6}}
build sky130_efx_lvdig__clkinv_4 Y {{4 n2f5 6 n6}}
build sky130_efx_lvdig__clkinv_8 Y {{8 n2f5 12 n6}}
build sky130_efx_lvdig__clkbuf_1 X {{1 n3 1 n4f5} {1 n3 1 n4f5}}
build sky130_efx_lvdig__clkbuf_2 X {{1 n2f5 1 n6} {2 n2f5 2 n6}}
build sky130_efx_lvdig__clkbuf_4 X {{1 n2f5 1 n6} {4 n2f5 4 n6}}
build sky130_efx_lvdig__clkbuf_8 X {{2 n2f5 2 n6} {8 n2f5 8 n6}}
build sky130_efx_lvdig__buf_4    X {{1 n3f5 1 n6} {4 n3f5 4 n6}}
quit -noprompt
