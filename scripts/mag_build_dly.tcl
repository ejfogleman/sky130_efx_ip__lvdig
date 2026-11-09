# Build sky130_efx_lvdig__dlygate4sd3_1 and clkdlybuf4s50_1 (2026-11-08):
# four inverters in a row, the middle two with long gates (L 0.5 um,
# as the PDK: gate length is not snapped, only the strip pitch is on the grid).
#
#   cd mag && magic -dnull -noconsole ../scripts/mag_build_dly.tcl
#
# Skips a cell whose .mag exists. Each stage is one nmos and one pmos finger
# (lvdig_mos device cells): rails strip at x0, output strip at x0 + pitch
# (0.54 for L 0.15, 0.90 for L 0.5; the long gate is centred between
# the strips, 0.115 from their licons; pitch = gate length + 0.36, rounded up to a multiple of lambda).
# Gate bar y 1.08-1.44 from the polycont over the rails
# strip's column (in the gap between rows) to the gate; the output strip
# rises in li into the gap and runs along y 1.08-1.44 to the next stage's
# polycont. Stages 0.72 apart (strip to strip; diffusions 0.36 apart).
# Pins: A on stage 1's polycont, X on the last output strip in the gap.

source ../scripts/mag_lvdig_lib.tcl

# W (internal units, 0.005 um): 90 0.45, 126 0.63, 162 0.81, 216 1.08
lvdig_mos nmos_n2f5_f1_l150_ff     n  90 ff
lvdig_mos nmos_n3f5_f1_l150_ff     n 126 ff
lvdig_mos pmos_n2f5_f1_l150_hvt_ff p  90 ff
lvdig_mos pmos_n6_f1_l150_hvt_ff   p 216 ff
lvdig_mos nmos_n2f5_f1_l500_ff     n  90 ff 0 100
lvdig_mos nmos_n3f5_f1_l500_ff     n 126 ff 0 100
lvdig_mos pmos_n2f5_f1_l500_hvt_ff p  90 ff 0 100
lvdig_mos pmos_n4f5_f1_l500_hvt_ff p 162 ff 0 100

# stage {ncell pcell wp long}: wp the pmos width (um), long 1 for L 0.5
proc dly {cell stages} {
    if {[file exists $cell.mag]} { puts "skip $cell"; return }
    load $cell
    set x0 0.36; set prev {}
    foreach st $stages {
        lassign $st nc pc wp long
        set pitch [expr {$long ? 0.90 : 0.54}]
        set xo [expr {$x0 + $pitch}]
        inst $nc $x0 0.18
        inst $pc $x0 [expr {2.70 - $wp}]
        li [expr {$x0 - 0.18}] 0 [expr {$x0 + 0.18}] 0.36        ;# to VGND
        li [expr {$x0 - 0.18}] 2.52 [expr {$x0 + 0.18}] 2.88     ;# to VPWR
        li [expr {$xo - 0.18}] 0.54 [expr {$xo + 0.18}] 2.34     ;# output riser
        pl [expr {$x0 - 0.18}] 1.08 [expr {$xo - 0.18}] 1.44     ;# gate bar
        um [expr {$x0 - 0.18}] 1.08 [expr {$x0 + 0.18}] 1.44; efx::polycont_draw
        if {$prev ne {}} { li [expr {$prev - 0.18}] 1.08 $x0 1.44 }
        set prev $xo
        set x0 [expr {$xo + 0.72}]
    }
    set w [expr {ceil(($prev + 0.36) / 0.36 - 1e-6) * 0.36}]
    lvdig_rails $w
    gpin A 0.36 input signal
    gpin X $prev output signal
    power_pins
    save_drc $cell
    puts "$cell: width $w um"
}

# PDK widths snapped: dlygate4sd3_1 n/p 0.42 -> 0.45, out p 1.00 -> 1.08,
# n 0.65 -> 0.63; clkdlybuf4s50_1 long stages p 0.82 -> 0.81, n 0.65 -> 0.63
dly sky130_efx_lvdig__dlygate4sd3_1 {
    {nmos_n2f5_f1_l150_ff pmos_n2f5_f1_l150_hvt_ff 0.45 0}
    {nmos_n2f5_f1_l500_ff pmos_n2f5_f1_l500_hvt_ff 0.45 1}
    {nmos_n2f5_f1_l500_ff pmos_n2f5_f1_l500_hvt_ff 0.45 1}
    {nmos_n3f5_f1_l150_ff pmos_n6_f1_l150_hvt_ff   1.08 0}
}
dly sky130_efx_lvdig__clkdlybuf4s50_1 {
    {nmos_n2f5_f1_l150_ff pmos_n6_f1_l150_hvt_ff   1.08 0}
    {nmos_n3f5_f1_l500_ff pmos_n4f5_f1_l500_hvt_ff 0.81 1}
    {nmos_n3f5_f1_l500_ff pmos_n4f5_f1_l500_hvt_ff 0.81 1}
    {nmos_n2f5_f1_l150_ff pmos_n6_f1_l150_hvt_ff   1.08 0}
}
quit -noprompt
