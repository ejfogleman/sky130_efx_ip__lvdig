# Build sky130_efx_lvdig__a21o_1 and o21a_1 (24L each) (2026-11-07), li only,
# and the plain device cells they need.
#
#   cd mag && magic -dnull -noconsole ../scripts/mag_build_a21o_o21a.tcl
#
# Writes new cells only (skips any whose .mag exists). Procs:
# scripts/mag_lvdig_lib.tcl.
#
# An and-or-invert / or-and-invert stage on two islands (two gates at x 0.36,
# strips 0.36 0.90 1.44; one gate at x 2.16, strips 2.16 2.70; diffusion gap
# 0.36), nmos W 0.63 / pmos W 1.08, then an inverter at x 3.42 as the and/or
# cells. Stage output n:
#   a21o_1  nmos  VGND -A2- x -A1- n  |  n -B1- VGND            (fnf | ff)
#           pmos  y -A2- VPWR -A1- y  |  n -B1- y               (ftf | bt)
#     n:  nmos 1.44-2.16 link along the bottom of the nmos row (y 0.18-0.54),
#         riser at 2.16 through the gap to the pmos 2.16 bottom contact, out
#         bar y 1.62-1.98 under the pmos 2.70 top contact to the inverter.
#     y:  bar along the bottom of the pmos row 0.36-1.44 (under the VPWR top
#         contact at 0.90), link along its top 1.44-2.70 (over the n bottom
#         contact at 2.16).
#   o21a_1  nmos  VGND -A1- z -A2- VGND |  z -B1- n             (ffb | ff)
#           pmos  VPWR -A1- w -A2- n  |  VPWR -B1- n            (fnf | tf)
#     z:  link above the nmos diffusion, y 0.72-0.90, 0.90-2.16 (over the
#         VGND bottom contact at 1.44; 0.18 below the gap's polyconts).
#     n:  riser at 2.70 from the nmos up to the pmos, out bar y 1.62-1.98
#         from the pmos 1.44 strip (under the VPWR top contact at 2.16) to
#         the inverter.
# Polyconts: the island's end column on the gate's side; the one-gate island's
# on the column not used by the riser.

source ../scripts/mag_lvdig_lib.tcl

lvdig_mos pmos_n6_f1_l150_hvt_bt p 216 bt
lvdig_mos nmos_n3f5_f2_l150_ffb  n 126 ffb

proc inverter {x0} {
    inst nmos_n3f5_f1_l150 $x0 0.18
    inst pmos_n6_f1_l150_hvt_tf $x0 1.62
    pl [expr {$x0 - 0.18}] 1.08 [expr {$x0 + 0.36}] 1.44; pc $x0
    li [expr {$x0 - 0.18}] 0 [expr {$x0 + 0.18}] 0.36
    li [expr {$x0 - 0.18}] 2.52 [expr {$x0 + 0.18}] 2.88
    set xf [expr {$x0 + 0.54}]
    li [expr {$xf - 0.18}] 0.54 [expr {$xf + 0.18}] 2.16
    lvdig_rails [expr {ceil(($xf + 0.36) / 0.36 - 1e-6) * 0.36}]
    gpin X $xf output signal
}
proc outbar {xl x0} {
    li [expr {$xl - 0.18}] 1.62 [expr {$x0 + 0.18}] 1.98
    li [expr {$x0 - 0.18}] 1.08 [expr {$x0 + 0.18}] 1.98
}
proc riser {x} { li [expr {$x - 0.18}] 0.54 [expr {$x + 0.18}] 1.98 }
proc nstrap {x} { li [expr {$x - 0.18}] 0 [expr {$x + 0.18}] 0.36 }
proc pstrap {x} { li [expr {$x - 0.18}] 2.52 [expr {$x + 0.18}] 2.88 }
proc gleft {x} { pl [expr {$x - 0.18}] 1.08 [expr {$x + 0.36}] 1.44; pc $x }
proc gright {x} { pl [expr {$x - 0.36}] 1.08 [expr {$x + 0.18}] 1.44; pc $x }

proc a21o {cell} {
    if {[file exists $cell.mag]} { puts "skip $cell"; return }
    load $cell
    inst nmos_n3f5_f2_l150_fnf   0.36 0.18
    inst pmos_n6_f2_l150_hvt_ftf 0.36 1.62
    inst nmos_n3f5_f1_l150       2.16 0.18
    inst pmos_n6_f1_l150_hvt_bt  2.16 1.62
    gleft 0.36; gright 1.44; gright 2.70
    nstrap 0.36; nstrap 2.70; pstrap 0.90
    li 1.26 0.18 2.34 0.54
    li 0.18 1.62 1.62 1.98
    li 1.26 2.34 2.88 2.70
    riser 2.16
    outbar 2.16 3.42
    inverter 3.42
    gpin A2 0.36 input signal
    gpin A1 1.44 input signal
    gpin B1 2.70 input signal
    power_pins
    save_drc $cell
}

proc o21a {cell} {
    if {[file exists $cell.mag]} { puts "skip $cell"; return }
    load $cell
    inst nmos_n3f5_f2_l150_ffb   0.36 0.18
    inst pmos_n6_f2_l150_hvt_fnf 0.36 1.62
    inst nmos_n3f5_f1_l150       2.16 0.18
    inst pmos_n6_f1_l150_hvt_tf  2.16 1.62
    gleft 0.36; gright 1.44; gleft 2.16
    nstrap 0.36; nstrap 1.44; pstrap 0.36; pstrap 2.16
    li 0.72 0.72 2.34 0.90
    riser 2.70
    outbar 1.44 3.42
    inverter 3.42
    gpin A1 0.36 input signal
    gpin A2 1.44 input signal
    gpin B1 2.16 input signal
    power_pins
    save_drc $cell
}

a21o sky130_efx_lvdig__a21o_1
o21a sky130_efx_lvdig__o21a_1
quit -noprompt
