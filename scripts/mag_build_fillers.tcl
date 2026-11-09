# Build the filler cells sky130_efx_lvdig__filler2/4/6/8 (2026-11-09): 2, 4,
# 6 and 8 L wide (0.36-1.44 um), nothing but the row's continuation: VGND and
# VPWR rails (li + met1, gridded viali), n-well and p-well, FIXED_BBOX and the
# power pins (lvdig_rails, power_pins). Layout only: no schematic or symbol.
#
# nwell.1 (width 0.84): a 2L or 4L n-well alone is too narrow, so, as the 4L
# tap cells do, the n-well runs past both cell edges (2L each side for filler2,
# 1L for filler4), to 1.08 um. In a row it overlaps the neighbours' n-well.
#
#   cd mag && magic -dnull -noconsole ../scripts/mag_build_fillers.tcl
# (skips a filler whose .mag exists)

source ../scripts/mag_lvdig_lib.tcl

foreach {n ext} {2 0.36 4 0.18 6 0 8 0} {
    set cell sky130_efx_lvdig__filler$n
    if {[file exists $cell.mag]} { puts "skip $cell"; continue }
    load $cell
    set w [format %.2f [expr {0.18 * $n}]]
    lvdig_rails $w
    if {$ext > 0} { um -$ext 1.44 [expr {$w + $ext}] 3.42; paint nwell }
    power_pins
    save_drc $cell
    drc style drc(full); drc check; drc catchup
    puts "R $cell: DRC(full) [drc list count total] [drc listall why]"
    drc style drc(fast)
}
quit -noprompt
