# Build sky130_efx_lvdig__mux2_1 (38L) and mux2_2 (42L) (2026-11-07), li plus one met1 strap
# (the stage output, approved by the user for crossings), and the plain
# device cells it needs.
#
#   cd mag && magic -dnull -noconsole ../scripts/mag_build_mux2.tcl
#
# Writes new cells only (skips any whose .mag exists). Procs:
# scripts/mag_lvdig_lib.tcl.
#
# The mux stage's select gates take S on one row and S_N on the other, so
# their columns are split: the device cells have short poly (lvdig_mos
# short) and the poly between the rows is drawn here. Polycontacts at three
# heights: PL y 0.90-1.26 (nmos side, licon 0.19 from the W 0.45 ndiff), the
# gap 1.08-1.44, PH 1.62-1.98 (pmos side). Left to right (W 0.45 except the
# output inverter):
#   X island  net1(0.90) -A0- n(1.44) -cX- rails(1.98)
#             cX: nmos S_N (PL contact over 1.98), pmos S
#   S inverter  S_N(2.70) -S- rails(3.24)
#   Y island  rails(3.96) -cY- n(4.50) -A1- net1(5.04)
#             cY: nmos S, pmos S_N (PH contact over 3.96)
#   output inverter  rails(5.94) -net1- X(6.48), W 0.63 / 1.08
# S reaches the select gates in poly: from the S inverter's gate a bar at PH
# level runs left to cX's pmos stub, and one at PL level runs right to cY's
# nmos stub (S contact on it over 3.24). S_N from the inverter's output
# riser: li at PL level left to cX's contact, at PH level right to cY's;
# each crosses the other S poly bar. net1: li verticals just outside the X
# and Y islands, joined by a met1 strap at y 0.40-0.68 (kept off the A0/A1
# contacts, which sit above the gap over 0.90 and 5.04 at PH level); the
# right one feeds the output inverter's gate.

source ../scripts/mag_lvdig_lib.tcl

lvdig_mos nmos_n2f5_f2_l150_fnf_sp      n 90 fnf 1
lvdig_mos pmos_n2f5_f2_l150_hvt_fnf_sp  p 90 fnf 1
lvdig_mos nmos_n2f5_f1_l150_ff_sp       n 90 ff 1
lvdig_mos pmos_n2f5_f1_l150_hvt_ff_sp   p 90 ff 1

proc nstrap {x} { li [expr {$x - 0.18}] 0 [expr {$x + 0.18}] 0.36 }
proc pstrap {x} { li [expr {$x - 0.18}] 2.52 [expr {$x + 0.18}] 2.88 }
proc pcat {x0 y0 x1 y1} { um $x0 $y0 $x1 $y1; efx::polycont_draw }
proc via {x y} {
    um [expr {$x - 0.085}] [expr {$y - 0.085}] [expr {$x + 0.085}] [expr {$y + 0.085}]
    paint viali
}
proc pinat {name x0 y0 x1 y1 class} {
    um $x0 $y0 $x1 $y1
    efx::pin_place $name li 0 FreeSans 0.18 center {} $class signal
}
# gate poly x range of the gate right of strip x
proc gx {x} { list [expr {$x + 0.195}] [expr {$x + 0.345}] }

set cell sky130_efx_lvdig__mux2_1
# A0/A1 contacts at y 1.62-1.98 (3L above the gap: the highest that keeps
# licon.9/.14 and li.3 to the W 0.45 pmos strip); met1 strap y 0.40-0.68
# (4L below the gap's 1.12-1.40), clear of the input contacts
set dyA 0.54; set ym 0.54
if {[file exists $cell.mag]} { puts "skip $cell" } else {
load $cell

# devices
inst nmos_n2f5_f2_l150_fnf_sp     0.90 0.18
inst pmos_n2f5_f2_l150_hvt_fnf_sp 0.90 2.25
inst nmos_n2f5_f1_l150_ff_sp      2.70 0.18
inst pmos_n2f5_f1_l150_hvt_ff_sp  2.70 2.25
inst nmos_n2f5_f2_l150_fnf_sp     3.96 0.18
inst pmos_n2f5_f2_l150_hvt_fnf_sp 3.96 2.25
inst nmos_n3f5_f1_l150            5.94 0.18
inst pmos_n6_f1_l150_hvt          5.94 1.62

# poly between the rows (W 0.45 rows: ndiff top 0.63, pdiff bottom 2.25)
lassign [gx 0.90] a b; pl $a 0.63 $b 2.25            ;# A0, full
lassign [gx 1.44] a b; pl $a 0.63 $b 1.26            ;# cX nmos (S_N)
                       pl $a 1.62 $b 2.25            ;# cX pmos (S)
lassign [gx 2.70] a b; pl $a 0.63 $b 2.25            ;# S inverter gate
lassign [gx 3.96] a b; pl $a 0.63 $b 1.26            ;# cY nmos (S)
                       pl $a 1.62 $b 2.25            ;# cY pmos (S_N)
lassign [gx 4.50] a b; pl $a 0.63 $b 2.25            ;# A1, full
# A0 contact over 0.90 in the gap
pl 0.72 [expr {1.08 + $dyA}] 1.26 [expr {1.44 + $dyA}]; pcat 0.72 [expr {1.08 + $dyA}] 1.08 [expr {1.44 + $dyA}]
# cX nmos: PL contact over 1.98
pl 1.62 0.90 2.16 1.26; pcat 1.80 0.90 2.16 1.26
# S: PH bar left from the inverter gate to cX pmos, PL bar right to cY
# nmos, with the S contact over 3.24
pl 1.62 1.62 3.06 1.98
pl 2.88 0.90 4.32 1.26; pcat 3.06 0.90 3.42 1.26
# cY pmos: PH contact over 3.96
pl 3.78 1.62 4.32 1.98; pcat 3.78 1.62 4.14 1.98
# A1 contact over 5.04 in the gap
pl 4.68 [expr {1.08 + $dyA}] 5.22 [expr {1.44 + $dyA}]; pcat 4.86 [expr {1.08 + $dyA}] 5.22 [expr {1.44 + $dyA}]
# output inverter: contact over 5.94 in the gap
pl 5.76 1.08 6.30 1.44; pcat 5.76 1.08 6.12 1.44

# S_N: riser on the inverter output, li to cX (PL) and cY (PH)
li 2.52 0.18 2.88 2.70
li 1.80 0.90 2.88 1.26
li 2.52 1.62 4.14 1.98

# net1: verticals outside the islands, nubs to the contacts, met1 strap,
# right one into the output inverter's contact
li 0.18 0.18 0.36 2.70
li 0.18 0.18 1.08 0.54
li 0.18 2.34 1.08 2.70
li 5.40 0.18 5.58 2.70
li 4.86 0.18 5.58 0.54
li 4.86 2.34 5.58 2.70
li 5.58 1.08 5.76 1.44
via 0.27 $ym; via 5.49 $ym
um 0.12 [expr {$ym - 0.14}] 5.64 [expr {$ym + 0.14}]; paint m1

# rail straps; X riser
nstrap 1.98; pstrap 1.98
nstrap 3.24; pstrap 3.24
nstrap 3.96; pstrap 3.96
nstrap 5.94; pstrap 5.94
li 6.30 0.54 6.66 2.16

lvdig_rails 6.84
pinat A0 0.72 [expr {1.08 + $dyA}] 1.08 [expr {1.44 + $dyA}] input
pinat A1 4.86 [expr {1.08 + $dyA}] 5.22 [expr {1.44 + $dyA}] input
pinat S  3.06 0.90 3.42 1.26 input
pinat X  6.30 1.08 6.66 1.44 output
power_pins
save_drc $cell
}

# mux2_2: mux pmos and S inverter pmos W 0.63 (pdiff 2.07-2.70, so pmos-side
# contacts at 1.44-1.80, licon 0.19 below it), output inverter 2 fingers
# (7.56 = 42L). Otherwise as mux2_1, except: cY's PH contact and the S_N li
# to it at 1.44-1.80; the S PL bar drops to 0.72-1.08 past the S contact
# (poly 0.36 below cY's contact); the S PH bar stays at 1.62-1.98 (poly
# only, 0.09 from the pdiff).
lvdig_mos pmos_n3f5_f2_l150_hvt_fnf_sp  p 126 fnf 1
lvdig_mos pmos_n3f5_f1_l150_hvt_ff_sp   p 126 ff 1

set cell sky130_efx_lvdig__mux2_2
# A0/A1 contacts at y 1.44-1.80 (2L up, the limit under the W 0.63 pmos)
set dyA 0.36; set ym 0.54
if {[file exists $cell.mag]} { puts "skip $cell" } else {
load $cell
inst nmos_n2f5_f2_l150_fnf_sp     0.90 0.18
inst pmos_n3f5_f2_l150_hvt_fnf_sp 0.90 2.07
inst nmos_n2f5_f1_l150_ff_sp      2.70 0.18
inst pmos_n3f5_f1_l150_hvt_ff_sp  2.70 2.07
inst nmos_n2f5_f2_l150_fnf_sp     3.96 0.18
inst pmos_n3f5_f2_l150_hvt_fnf_sp 3.96 2.07
inst nmos_n3f5_f1_l150            5.94 0.18
inst pmos_n6_f1_l150_hvt          5.94 1.62
inst nmos_n3f5_f1_l150            6.48 0.18
inst pmos_n6_f1_l150_hvt          6.48 1.62

lassign [gx 0.90] a b; pl $a 0.63 $b 2.07            ;# A0, full
lassign [gx 1.44] a b; pl $a 0.63 $b 1.26            ;# cX nmos (S_N)
                       pl $a 1.62 $b 2.07            ;# cX pmos (S)
lassign [gx 2.70] a b; pl $a 0.63 $b 2.07            ;# S inverter gate
lassign [gx 3.96] a b; pl $a 0.63 $b 1.08            ;# cY nmos (S)
                       pl $a 1.44 $b 2.07            ;# cY pmos (S_N)
lassign [gx 4.50] a b; pl $a 0.63 $b 2.07            ;# A1, full
pl 0.72 [expr {1.08 + $dyA}] 1.26 [expr {1.44 + $dyA}]; pcat 0.72 [expr {1.08 + $dyA}] 1.08 [expr {1.44 + $dyA}]
pl 1.62 0.90 2.16 1.26; pcat 1.80 0.90 2.16 1.26
pl 1.62 1.62 3.06 1.98
pl 2.88 0.90 3.60 1.26; pcat 3.06 0.90 3.42 1.26
pl 3.42 0.72 4.32 1.08
pl 3.78 1.44 4.32 1.80; pcat 3.78 1.44 4.14 1.80
pl 4.68 [expr {1.08 + $dyA}] 5.22 [expr {1.44 + $dyA}]; pcat 4.86 [expr {1.08 + $dyA}] 5.22 [expr {1.44 + $dyA}]
# output inverter (2 fingers): contact over 5.94, bar across both gates
pl 5.76 1.08 6.84 1.44; pcat 5.76 1.08 6.12 1.44

li 2.52 0.18 2.88 2.70
li 1.80 0.90 2.88 1.26
li 2.52 1.44 4.14 1.80

li 0.18 0.18 0.36 2.70
li 0.18 0.18 1.08 0.54
li 0.18 2.34 1.08 2.70
li 5.40 0.18 5.58 2.70
li 4.86 0.18 5.58 0.54
li 4.86 2.34 5.58 2.70
li 5.58 1.08 5.76 1.44
via 0.27 $ym; via 5.49 $ym
um 0.12 [expr {$ym - 0.14}] 5.64 [expr {$ym + 0.14}]; paint m1

nstrap 1.98; pstrap 1.98
nstrap 3.24; pstrap 3.24
nstrap 3.96; pstrap 3.96
nstrap 5.94; pstrap 5.94
nstrap 7.02; pstrap 7.02
li 6.30 0.54 6.66 2.16

lvdig_rails 7.56
pinat A0 0.72 [expr {1.08 + $dyA}] 1.08 [expr {1.44 + $dyA}] input
pinat A1 4.86 [expr {1.08 + $dyA}] 5.22 [expr {1.44 + $dyA}] input
pinat S  3.06 0.90 3.42 1.26 input
pinat X  6.30 1.08 6.66 1.44 output
power_pins
save_drc $cell
}
quit -noprompt
