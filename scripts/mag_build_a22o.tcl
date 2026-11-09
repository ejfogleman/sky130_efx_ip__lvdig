# Build sky130_efx_lvdig__a22o_1 (28L) (2026-11-07), li only, and the plain
# device cell it needs.
#
#   cd mag && magic -dnull -noconsole ../scripts/mag_build_a22o.tcl
#
# Writes new cells only (skips any whose .mag exists). Procs:
# scripts/mag_lvdig_lib.tcl.
#
# An and-or-invert stage on two islands of two gates (strips 0.36 0.90 1.44
# and 2.16 2.70 3.24; diffusion gap 0.36), nmos W 0.63 / pmos W 1.08, then an
# inverter at x 3.96 as the and/or cells. Stage output n:
#   nmos  VGND -A2- p -A1- n  |  n -B1- q -B2- VGND     (fnf | fnf)
#   pmos  VPWR -A2- y -A1- VPWR | y -B1- n -B2- y       (fft | fbt)
#   n:  nmos 1.44-2.16 link along the bottom of the nmos row (y 0.18-0.54);
#       2.16 jogs over the uncontacted q (y 0.54-0.72) to a riser at 2.70
#       through the gap (between the B1 and B2 polyconts) to the pmos 2.70
#       bottom contact; out bar y 1.62-1.98 under the pmos 3.24 top contact
#       to the inverter.
#   y:  bar along the bottom of the pmos row 0.90-2.16 (under the VPWR top
#       contact at 1.44), link along its top 2.16-3.24 (over the n bottom
#       contact at 2.70).

source ../scripts/mag_lvdig_lib.tcl

lvdig_mos pmos_n6_f2_l150_hvt_fbt p 216 fbt

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
proc nstrap {x} { li [expr {$x - 0.18}] 0 [expr {$x + 0.18}] 0.36 }
proc pstrap {x} { li [expr {$x - 0.18}] 2.52 [expr {$x + 0.18}] 2.88 }
proc gleft {x} { pl [expr {$x - 0.18}] 1.08 [expr {$x + 0.36}] 1.44; pc $x }
proc gright {x} { pl [expr {$x - 0.36}] 1.08 [expr {$x + 0.18}] 1.44; pc $x }

set cell sky130_efx_lvdig__a22o_1
if {[file exists $cell.mag]} { puts "skip $cell"; quit -noprompt }
load $cell
inst nmos_n3f5_f2_l150_fnf   0.36 0.18
inst pmos_n6_f2_l150_hvt_fft 0.36 1.62
inst nmos_n3f5_f2_l150_fnf   2.16 0.18
inst pmos_n6_f2_l150_hvt_fbt 2.16 1.62
gleft 0.36; gright 1.44; gleft 2.16; gright 3.24
nstrap 0.36; nstrap 3.24; pstrap 0.36; pstrap 1.44
# n
li 1.26 0.18 2.34 0.54
li 1.98 0.54 2.88 0.72
li 2.52 0.54 2.88 1.98
li 2.52 1.62 4.14 1.98
li 3.78 1.08 4.14 1.98
# y
li 0.72 1.62 2.34 1.98
li 1.98 2.34 3.42 2.70
inverter 3.96
gpin A2 0.36 input signal
gpin A1 1.44 input signal
gpin B1 2.16 input signal
gpin B2 3.24 input signal
power_pins
save_drc $cell
quit -noprompt
