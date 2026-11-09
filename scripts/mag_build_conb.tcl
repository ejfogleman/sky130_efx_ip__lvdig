# Build sky130_efx_lvdig__conb_1 (2026-11-08): tie cell, 6L (1.08 um) wide.
# Two res_generic_po resistors (rmp layer, as hd's conb_1), W 0.45 x L 0.54
# (PDK 0.48 x 0.5 snapped to the lambda grid, as the schematic), stacked in
# one poly column centred at x 0.54:
#   LO: head y 0-0.36 (contact into the VGND rail's li), body 0.36-0.90,
#       head 0.90-1.26 (contact, LO pin)
#   HI: head 1.62-1.98 (contact, HI pin), body 1.98-2.52, head 2.52-2.88
#       (contact into the VPWR rail's li)
# Heads are 2L of poly around a 0.17 licon (0.14 enclosure across, 0.095
# along); li 0.36-0.72 (0.095 enclosure). The two poly columns are 0.36 apart.
#
#   cd mag && magic -dnull -noconsole ../scripts/mag_build_conb.tcl

source ../scripts/mag_lvdig_lib.tcl

set cell sky130_efx_lvdig__conb_1
if {[file exists $cell.mag]} { puts "skip $cell"; quit -noprompt }
load $cell
proc head {y0} {
    pl 0.315 $y0 0.765 [expr {$y0 + 0.36}]
    li 0.36 $y0 0.72 [expr {$y0 + 0.36}]
    set c [expr {$y0 + 0.18}]
    um 0.455 [expr {$c - 0.085}] 0.625 [expr {$c + 0.085}]; paint polycont
}
proc body {y0} { um 0.315 $y0 0.765 [expr {$y0 + 0.54}]; paint rmp }
head 0.00; body 0.36; head 0.90      ;# LO
head 1.62; body 1.98; head 2.52      ;# HI
lvdig_rails 1.08
um 0.36 0.90 0.72 1.26; efx::pin_place LO li 0 FreeSans 0.18 center {} output signal
um 0.36 1.62 0.72 1.98; efx::pin_place HI li 0 FreeSans 0.18 center {} output signal
power_pins
save_drc $cell
quit -noprompt
