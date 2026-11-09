# Build sky130_efx_lvdig__ha_1 (38L) (2026-11-07), li plus two short met1
# straps (approved by the user for crossings), and the plain device cells it
# needs. Matches the user's revision of the layout (2026-11-07): A contact
# moved to the pmos side, straps in the mux2_1 style, no met1 over A.
#
#   cd mag && magic -dnull -noconsole ../scripts/mag_build_ha.tcl
#
# Writes new cells only (skips any whose .mag exists). Procs:
# scripts/mag_lvdig_lib.tcl.
#
# COUT_N = nand2(A, B); COUT = !COUT_N; net2 = o21ai(A1 = A, A2 = B,
# B1 = COUT_N) (the o21a_1 stage); SUM = !net2. Left to right:
#   COUT inverter  COUT(0.36) -COUT_N- rails(0.90), pmos ft (W 1.08)
#   K island (W 0.45): the nand and the o21ai's A/B half on one diffusion,
#     sharing the rails strip between the two A gates; the A contact sits
#     over it at PH level (y 1.62-1.98) on a poly U whose legs run down
#     through the gap to the two gates, leaving the gap free for B's strap
#     nmos  COUT_N(1.62) -B- n1 -A- VGND(2.70) -A- z -B- VGND(3.78)  fnffb
#     pmos  VPWR -B- COUT_N(2.16) -A- VPWR -A- w -B- net2(3.78)       fffnf
#   C island (W 0.45)  nmos z(4.50) -C- net2(5.04); pmos VPWR -C- net2
#   SUM inverter at 5.76 (first pmos strip top-only, tf)
# COUT_N: nmos 1.62 jogs over n1 (li down to y 0.36, landing the met1 via)
#   to a riser at 2.16 up to the pmos; li at y 1.62-1.98 left to the COUT
#   inverter's contact over 0.90.
# z: li link above the nmos row (y 0.72-0.90) over the VGND bottom contact
#   at 3.78. net2: as o21a_1 (pmos 3.78 stub, bar y 1.62-1.98, riser at 5.04,
#   on to the SUM inverter).
# met1, mux2_1 style (0.28 lines centred on the vias, ending 0.15 past a via
#   centre): B straight through the gap between its contacts over 1.62 and
#   3.78 (y 1.12-1.40, over the COUT_N riser); COUT_N from a via on the jog
#   at (2.16, 0.54) along y 0.40-0.68, up at 4.50 to the C contact. A's pin
#   has no met1 over it.

source ../scripts/mag_lvdig_lib.tcl

lvdig_mos nmos_n2f5_f4_l150_fnffb     n 90 fnffb
lvdig_mos pmos_n2f5_f4_l150_hvt_fffnf p 90 fffnf
lvdig_mos pmos_n6_f1_l150_hvt_ft      p 216 ft

proc nstrap {x} { li [expr {$x - 0.18}] 0 [expr {$x + 0.18}] 0.36 }
proc pstrap {x} { li [expr {$x - 0.18}] 2.52 [expr {$x + 0.18}] 2.88 }
proc gleft {x} { pl [expr {$x - 0.18}] 1.08 [expr {$x + 0.36}] 1.44; pc $x }
proc gright {x} { pl [expr {$x - 0.36}] 1.08 [expr {$x + 0.18}] 1.44; pc $x }
proc pcat {x0 y0 x1 y1} { um $x0 $y0 $x1 $y1; efx::polycont_draw }
proc via {x y} {
    um [expr {$x - 0.085}] [expr {$y - 0.085}] [expr {$x + 0.085}] [expr {$y + 0.085}]
    paint viali
}

set cell sky130_efx_lvdig__ha_1
if {[file exists $cell.mag]} { puts "skip $cell"; quit -noprompt }
load $cell

inst nmos_n3f5_f1_l150            0.36 0.18
inst pmos_n6_f1_l150_hvt_ft       0.36 1.62
inst nmos_n2f5_f4_l150_fnffb      1.62 0.18
inst pmos_n2f5_f4_l150_hvt_fffnf  1.62 2.25
inst nmos_n2f5_f1_l150_ff         4.50 0.18
inst pmos_n2f5_f1_l150_hvt_ff     4.50 2.25
inst nmos_n3f5_f1_l150            5.76 0.18
inst pmos_n6_f1_l150_hvt_tf       5.76 1.62

# gates
gright 0.90                                  ;# COUT inverter (COUT_N)
gleft 1.62                                   ;# B (nand)
# A, both gates: contact over 2.70 at PH level, legs down to the gates
pl 2.34 1.62 3.06 1.98; pcat 2.52 1.62 2.88 1.98
pl 2.34 1.08 2.52 1.62; pl 2.88 1.08 3.06 1.62
gright 3.78                                  ;# B (o21ai)
gleft 4.50                                   ;# C (COUT_N)
gleft 5.76                                   ;# SUM inverter (net2)

# COUT inverter: COUT riser, rail straps
li 0.18 0.54 0.54 2.16
nstrap 0.90; pstrap 0.90
# COUT_N: jog, riser, bar left to the COUT inverter's contact
li 1.44 0.36 2.34 0.72
li 1.98 0.36 2.34 2.70
li 0.72 1.62 2.34 1.98
li 0.72 1.08 1.08 1.98
# K rails
nstrap 2.70; nstrap 3.78
pstrap 1.62; pstrap 2.70
# z link, down onto the W 0.45 contacts (their li ends at 0.63)
li 3.06 0.72 4.68 0.90
li 3.06 0.54 3.42 0.90
li 4.32 0.54 4.68 0.90
# C island, net2 to the SUM inverter
pstrap 4.50
li 3.60 1.62 3.96 2.70
li 3.60 1.62 5.94 1.98
li 4.86 0.54 5.22 2.70
li 5.58 1.08 5.94 1.98
# SUM inverter
nstrap 5.76; pstrap 5.76
li 6.12 0.54 6.48 2.16

# met1 straps
um 1.47 1.12 3.93 1.40; paint m1                 ;# B
via 1.62 1.26; via 3.78 1.26
um 2.01 0.40 4.64 0.68; paint m1                 ;# COUT_N
um 4.36 0.40 4.64 1.41; paint m1
via 2.16 0.54; via 4.50 1.26

lvdig_rails 6.84
um 2.52 1.62 2.88 1.98
efx::pin_place A li 0 FreeSans 0.18 center {} input signal
# B: sticky, so the label keeps its full square over the via
um 1.44 1.08 1.80 1.44
efx::pin_place B li 1 FreeSans 0.18 center {} input signal
gpin COUT 0.36 output signal
gpin SUM 6.30 output signal
power_pins
save_drc $cell
quit -noprompt
