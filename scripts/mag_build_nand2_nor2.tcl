# Reference: the batch script that built these sky130_efx_lvdig layouts (2026-11-06).
# Rerunning it adds to existing cells: delete or rename the target .mag first.
#   cd mag && magic -dnull -noconsole ../scripts/mag_build_nand2_nor2.tcl
# All coordinates in um. Two columns (gates) between strips at 0.36 / 0.90 / 1.44;
# left input polycont at x 0.18-0.54, right one at 1.80-2.16, output jog in the
# gap between rows at y 1.08-1.44 (x 0.72-1.62).
proc um {x0 y0 x1 y1} { box values ${x0}um ${y0}um ${x1}um ${y1}um }
proc inst {cell x y} { box values ${x}um ${y}um ${x}um ${y}um; getcell $cell child 0 0 }
proc li {x0 y0 x1 y1} { um $x0 $y0 $x1 $y1; paint li }
proc pl {x0 y0 x1 y1} { um $x0 $y0 $x1 $y1; paint poly }
proc pin {name x0 y0 x1 y1 layer class use} {
    um $x0 $y0 $x1 $y1; efx::pin_place $name $layer 0 FreeSans 0.18 center {} $class $use
}
proc gate2 {cell left right nstraps pstraps outv} {
    set w 2.34
    load $cell
    foreach x {0.36 0.90} {
        inst nmos_n3f5_f1_l150 $x 0.18
        inst pmos_n6_f1_l150_hvt $x 1.62
    }
    # wells across the whole cell, so they reach both edges for abutment
    um 0 1.44 $w 3.42; paint nwell   ;# to the rail's outer edge, so flipped rows share the well
    um 0 0 $w 1.08;    paint pwell
    # inputs: left column via a polycont at the left, right column via one at the right
    pl 0.18 1.08 0.72 1.44; um 0.18 1.08 0.54 1.44; efx::polycont_draw
    pl 1.08 1.08 2.16 1.44; um 1.80 1.08 2.16 1.44; efx::polycont_draw
    # output: the jog plus a riser to the pmos output strip and one to the nmos output strip
    li 0.72 1.08 1.62 1.44
    foreach v $outv { li {*}$v }
    # rails and straps
    um 0 2.70 $w 3.42;  paint m1
    um 0 -0.54 $w 0.18; paint m1
    um 0 2.88 $w 3.24;  efx::mcon_draw
    um 0 -0.36 $w 0;    efx::mcon_draw
    foreach x $nstraps { li $x 0 [expr {$x + 0.36}] 0.36 }
    foreach x $pstraps { li $x 2.52 [expr {$x + 0.36}] 2.88 }
    # pins, in .subckt order: A B Y, then the supplies as inv_1
    foreach {name x} [list $left 0.18 $right 1.80] { set px($name) $x }
    pin A $px(A) 1.08 [expr {$px(A) + 0.36}] 1.44 li input signal
    pin B $px(B) 1.08 [expr {$px(B) + 0.36}] 1.44 li input signal
    pin Y 1.26 1.08 1.62 1.44 li output signal
    pin VPWR 0 2.88 0.36 3.24 m1 bidirectional power
    pin VGND 0 -0.36 0.36 0 m1 bidirectional ground
    um 0 2.70 0.18 2.88; efx::pin_place VPB nwell 0 FreeSans 0.18 center {} bidirectional power
    um 0 0 0.18 0.18;    efx::pin_place VNB pwell 0 FreeSans 0.18 center {} bidirectional ground
    um 0 -0.18 $w 3.06; efx::fixed_bbox
    save $cell
}
# nand2_1: nmos strips VGND | mid | Y (B left gate, A right), pmos VPWR | Y | VPWR
gate2 sky130_efx_lvdig__nand2_1 B A {0.18} {0.18 1.26} {
    {0.72 1.08 1.08 1.80} {1.26 0.72 1.62 1.44}
}
# nor2_1: pmos strips VPWR | mid | Y (A left gate, B right), nmos VGND | Y | VGND
gate2 sky130_efx_lvdig__nor2_1 A B {0.18 1.26} {0.18} {
    {1.26 1.08 1.62 1.80} {0.72 0.72 1.08 1.44}
}
foreach c {sky130_efx_lvdig__nand2_1 sky130_efx_lvdig__nor2_1} {
    load $c; select top cell; drc check; drc catchup
    puts "$c DRC: [drc list count total]"; puts [drc listall why]
}
quit -noprompt
