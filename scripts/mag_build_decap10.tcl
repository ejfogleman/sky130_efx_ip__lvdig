# Build sky130_efx_lvdig__decap10 in decap20's style (2026-11-09, replacing
# the user's first version; see scripts/mag_build_decap20.tcl):
#   - one long device of each type, one source/drain strip at each edge:
#     nfet W 0.63 (3.5L), pfet hvt W 0.90 (5L), L 0.72 (strip pitch 1.08 = 6L;
#     cell 1L + 2L strip + 4L gate + 2L strip + 1L);
#   - same rows as decap20 (um): ndiff 0.18-0.81 | nfet poly band 0.81-0.99 |
#     pads | pfet poly band 1.62-1.80 | pdiff 1.80-2.70;
#   - gate-tie pads with one contact each, as two 3-contact pads don't fit
#     beside each other over a 0.72 gate. Each pad runs out over its strip
#     column so the contact sits under that column's li: the pfet pad (x
#     0.18-0.72, y 1.26-1.62, contact x 0.36) under the VGND column, the nfet
#     pad (x 1.08-1.62, y 0.99-1.35, contact x 1.44) under the VPWR column.
#     Pads 0.36 apart in x, 0.27 from the other gate's band; contacts 0.275
#     from diffusion; poly and li enclose the contacts 0.095 on all sides;
#   - li in strip columns, as the user drew decap20: left column VGND from the
#     bottom rail up to the pfet pad, right column VPWR from the top rail down
#     to the nfet pad; the other two strips straight to their rails.
#
#   cd mag && magic -dnull -noconsole ../scripts/mag_build_decap10.tcl
# (delete mag/sky130_efx_lvdig__decap10.mag first)

source ../scripts/mag_lvdig_lib.tcl

set cell sky130_efx_lvdig__decap10
if {[file exists $cell.mag]} { puts "skip $cell"; quit -noprompt }

# device cells: one finger, full contacts both strips, short poly, L 0.72
lvdig_mos nmos_n3f5_f1_l720_ff_sp n 126 ff 1 144
lvdig_mos pmos_n5_f1_l720_hvt_ff_sp p 180 ff 1 144

load $cell
inst nmos_n3f5_f1_l720_ff_sp 0.36 0.18
inst pmos_n5_f1_l720_hvt_ff_sp 0.36 1.80

proc cont {x y} {
    um [expr {$x - 0.085}] [expr {$y - 0.085}] [expr {$x + 0.085}] [expr {$y + 0.085}]
    paint polycont
}
# nfet gate: band above the channel, pad out to the right strip column
pl 0.54 0.81 1.26 0.99
pl 1.08 0.99 1.62 1.35
cont 1.44 1.17
# pfet gate: band below the channel, pad out to the left strip column
pl 0.54 1.62 1.26 1.80
pl 0.18 1.26 0.72 1.62
cont 0.36 1.44

# li columns. VGND: left from the bottom rail up over the pfet pad contact,
# right nfet strip to the rail. VPWR: left pfet strip to the top rail, right
# from the top rail down over the nfet pad contact.
li 0.18 0.00 0.54 1.62
li 1.26 0.00 1.62 0.81
li 0.18 1.80 0.54 2.88
li 1.26 0.99 1.62 2.88

lvdig_rails 1.80
power_pins
save_drc $cell
quit -noprompt
