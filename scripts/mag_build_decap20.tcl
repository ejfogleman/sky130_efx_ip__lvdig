# Build sky130_efx_lvdig__decap20 in the style of sky130_fd_sc_hd's decap
# cells (2026-11-09, replacing the user's two-finger L 1.08 version):
#   - one long device of each type, gate across the cell, one source/drain
#     strip at each edge: nfet W 0.63 (3.5L), pfet hvt W 0.90 (5L), L 2.52
#     (strip pitch 2.88 = 16L; cell 1L + 2L strip + 14L gate + 2L strip + 1L);
#   - devices as tall as the gap between them allows (the gate-tie pads need
#     about 0.8 um there, as in hd's);
#   - gates tied off by two poly pads between the rows, each with three
#     contacts: the pfet's pad (left, y 1.26-1.62) to VGND, the nfet's pad
#     (right, y 0.99-1.35) to VPWR;
#   - li: hd floods it over each device; the user replaced the flood with
#     strip columns (2026-11-09), VGND up the left into the pfet pad, VPWR
#     down the right into the nfet pad.
#
# Rows (um): ndiff 0.18-0.81 | nfet poly band 0.81-0.99 | pads | pfet poly
# band 1.62-1.80 | pdiff 1.80-2.70. Spacings: pads 0.27 from the other gate's
# band and 0.36 apart in x; contacts 0.275 from diffusion (licon.14 0.19);
# li 0.18 apart; contacts enclosed 0.095 by poly and li on all sides.
#
#   cd mag && magic -dnull -noconsole ../scripts/mag_build_decap20.tcl
# (delete mag/sky130_efx_lvdig__decap20.mag first)

source ../scripts/mag_lvdig_lib.tcl

set cell sky130_efx_lvdig__decap20
if {[file exists $cell.mag]} { puts "skip $cell"; quit -noprompt }

# device cells: one finger, full contacts both strips, short poly, L 2.52
lvdig_mos nmos_n3f5_f1_l2520_ff_sp n 126 ff 1 504
lvdig_mos pmos_n5_f1_l2520_hvt_ff_sp p 180 ff 1 504

load $cell
inst nmos_n3f5_f1_l2520_ff_sp 0.36 0.18
inst pmos_n5_f1_l2520_hvt_ff_sp 0.36 1.80

proc cont {x y} {
    um [expr {$x - 0.085}] [expr {$y - 0.085}] [expr {$x + 0.085}] [expr {$y + 0.085}]
    paint polycont
}
# nfet gate: band above the channel, pad on the right with three contacts
pl 0.54 0.81 3.06 0.99
pl 1.98 0.99 3.06 1.35
foreach x {2.16 2.52 2.88} { cont $x 1.17 }
# pfet gate: band below the channel, pad on the left with three contacts
pl 0.54 1.62 3.06 1.80
pl 0.54 1.26 1.62 1.62
foreach x {0.72 1.08 1.44} { cont $x 1.44 }

# li, as the user revised it (2026-11-09): strip columns only, no flood over
# the channels. VGND: left strip column from the bottom rail up into the pfet
# pad's li, right nfet strip to the rail. VPWR: left pfet strip to the top
# rail, right column from the top rail down into the nfet pad's li.
li 0.18 0.00 0.54 1.26
li 0.18 1.26 1.62 1.62
li 3.06 0.00 3.42 0.81
li 0.18 1.80 0.54 2.88
li 3.06 1.35 3.42 2.88
li 1.98 0.99 3.42 1.35

lvdig_rails 3.60
power_pins
save_drc $cell
quit -noprompt
