# Finish the user-drawn decap cells (2026-11-09): rails, gridded rail viali,
# wells, FIXED_BBOX and power pins, as every other lvdig cell (lvdig_rails,
# power_pins in mag_lvdig_lib.tcl).
#
# The user drew both cells with their geometry 0.18 um right of and below the
# library frame (left edge at x 0.18, bottom li rail at y -0.54..-0.18); it was
# translated by (-0.18, +0.18) um in the .mag text before this script ran.
#
#   decap10: 10L (1.80 um). One nmos W 0.54 L 0.72 (gate to VPWR, S/D to VGND)
#            and one pmos W 0.72 L 0.72 (gate to VGND, S/D to VPWR).
#   (Both were later rebuilt in hd's decap style by mag_build_decap20.tcl and
#   mag_build_decap10.tcl; this script is a record of the first versions only.)
#   decap20: 20L (3.60 um). Two fingers of each, L 1.08, sharing the middle
#            strip. Two li ties added here, missing from the drawn cell: the
#            middle pmos strip up to VPWR, the right nmos strip down to VGND.
#
#   cd mag && magic -dnull -noconsole ../scripts/mag_finish_decap.tcl

source ../scripts/mag_lvdig_lib.tcl

load sky130_efx_lvdig__decap10
lvdig_rails 1.80
power_pins
save_drc sky130_efx_lvdig__decap10

load sky130_efx_lvdig__decap20
li 1.62 2.52 1.98 2.88      ;# middle pmos strip -> VPWR rail
li 3.06 0.00 3.42 0.36      ;# right nmos strip -> VGND rail
lvdig_rails 3.60
power_pins
save_drc sky130_efx_lvdig__decap20
quit -noprompt
