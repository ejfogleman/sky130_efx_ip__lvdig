# Reference: the batch script that built these sky130_efx_lvdig layouts (2026-11-06).
# Rerunning it adds to existing cells: delete or rename the target .mag first.
#   cd mag && magic -dnull -noconsole ../scripts/mag_build_inv4_buf2.tcl
# All coordinates in um. Conventions from sky130_efx_lvdig__inv_1/inv_2/buf_1.
proc um {x0 y0 x1 y1} { box values ${x0}um ${y0}um ${x1}um ${y1}um }
proc inst {cell x y} { box values ${x}um ${y}um ${x}um ${y}um; getcell $cell child 0 0 }
proc li {x0 y0 x1 y1} { um $x0 $y0 $x1 $y1; paint li }
proc pl {x0 y0 x1 y1} { um $x0 $y0 $x1 $y1; paint poly }
# rails (li + viali + met1, as inv_1), source straps, wells for the labels, pins, outline
proc frame {w straps out xo} {
    um 0 2.70 $w 3.42;  paint m1
    um 0 -0.54 $w 0.18; paint m1
    um 0 2.88 $w 3.24;  efx::mcon_draw
    um 0 -0.36 $w 0;    efx::mcon_draw
    foreach x $straps { li $x 0 [expr {$x + 0.36}] 0.36; li $x 2.52 [expr {$x + 0.36}] 2.88 }
    um 0 2.70 0.18 2.88; paint nwell
    um 0 0 0.18 0.18;    paint pwell
    um 0.18 1.08 0.54 1.44; efx::pin_place A li 0 FreeSans 0.18 center {} input signal
    um {*}$xo;              efx::pin_place $out li 0 FreeSans 0.18 center {} output signal
    um 0 2.88 0.36 3.24;    efx::pin_place VPWR m1 0 FreeSans 0.18 center {} bidirectional power
    um 0 -0.36 0.36 0;      efx::pin_place VGND m1 0 FreeSans 0.18 center {} bidirectional ground
    um 0 2.70 0.18 2.88;    efx::pin_place VPB nwell 0 FreeSans 0.18 center {} bidirectional power
    um 0 0 0.18 0.18;       efx::pin_place VNB pwell 0 FreeSans 0.18 center {} bidirectional ground
    um 0 -0.18 $w 3.06;     efx::fixed_bbox
}

# inv_4: 4 fingers, strips at 0.36 + 0.54k (k = 0..4); even strips to the rails, odd ones Y
load sky130_efx_lvdig__inv_4
foreach i {0 1 2 3} {
    set x [expr {0.36 + 0.54 * $i}]
    inst nmos_n3f5_f1_l150 $x 0.18
    inst pmos_n6_f1_l150_hvt $x 1.62
}
pl 0.18 1.08 2.34 1.44
um 0.18 1.08 0.54 1.44; efx::polycont_draw
li 0.72 0.72 1.08 1.80
li 1.80 0.72 2.16 1.80
li 0.72 1.08 2.16 1.44
frame 2.88 {0.18 1.26 2.34} Y {0.72 1.08 1.08 1.44}
save sky130_efx_lvdig__inv_4

# buf_2: stage 1 (n 2.5L, p 3.5L) at strips 0.36 / 0.90; stage 2 (2 fingers, n 3.5L, p 6L)
# at strips 1.62 / 2.16 / 2.70, gate driven from stage 1's output through a polycont
load sky130_efx_lvdig__buf_2
inst nmos_n2f5_f1_l150 0.36 0.18
inst pmos_n3f5_f1_l150_hvt 0.36 1.98
foreach x {1.62 2.16} {
    inst nmos_n3f5_f1_l150 $x 0.18
    inst pmos_n6_f1_l150_hvt $x 1.62
}
pl 0.18 1.08 0.72 1.44
pl 0.54 0.90 0.72 1.08
pl 0.54 1.44 0.72 1.80
um 0.18 1.08 0.54 1.44; efx::polycont_draw
li 0.72 0.54 1.08 2.16
pl 1.08 1.08 2.52 1.44
um 1.08 1.08 1.44 1.44; efx::polycont_draw
li 1.98 0.72 2.34 1.80
frame 3.06 {0.18 1.44 2.52} X {1.98 1.08 2.34 1.44}
save sky130_efx_lvdig__buf_2

foreach c {sky130_efx_lvdig__inv_4 sky130_efx_lvdig__buf_2} {
    load $c; select top cell; drc check; drc catchup
    puts "$c DRC: [drc list count total]"; puts [drc listall why]
}
quit -noprompt
