# Build sky130_efx_lvdig__nor3_2 (2026-11-07), 26L wide, li only (no met1
# besides the rails), and the four plain device cells it uses.
#
#   cd mag && magic -dnull -noconsole ../scripts/mag_build_nor3_2.tcl
#
# Writes new cells only (skips any whose .mag exists). Coordinates in um unless
# a value ends in i (internal units, 0.005 um).
#
# As hd's nor3_2, the diffusion is two islands: gates A A B B on strips s0..s4
# (x 0.36 + 0.54k) and C C on strips t0..t2 (x 3.24 + 0.54k; the 0.72 step
# leaves 0.36 between islands, diff/tap.3). The routes cross strips that are
# contacted only at their top (t) or bottom (b) end, as the user's fbf / ftf
# cells do (f: full-height contact):
#   pmos  s: n1 f, VPWR t, n1 f, n2 t, n1 b    t: n2 f, Y b, n2 f
#         n1 (a_27_297#): li bar along the pmos row's bottom, s0..s4
#         n2 (a_281_297#): li bar along its top, s3..t2
#         VPWR: strap from s1's top contact to the rail
#   nmos  s: VGND f, Y f, VGND b, Y f, VGND b   t: VGND b, Y f, VGND f
#         Y: li bar along the nmos row's top (y 0.72-0.90), s1..t1, with a
#         riser through the gap at t1 to the pmos Y contact (t1, bottom)
#         VGND: straps from s0, s2, s4, t0, t2 to the rail
# Gates: poly bars in the gap (y 1.08-1.44) over A (g1-g2), B (g3-g4), C (both
# island-2 gates), polyconts over s0, s3 and t0.

source ../scripts/mag_lvdig_lib.tcl

lvdig_mos nmos_n3f5_f4_l150_ffbfb n 126 ffbfb
lvdig_mos nmos_n3f5_f2_l150_bff   n 126 bff
lvdig_mos pmos_n6_f4_l150_hvt_ftftb p 216 ftftb
lvdig_mos pmos_n6_f2_l150_hvt_fbf   p 216 fbf

set c sky130_efx_lvdig__nor3_2
if {[file exists $c.mag]} { puts "skip $c" } else {
    load $c
    proc s {k} { expr {0.36 + 0.54 * $k} }
    proc t {k} { expr {3.24 + 0.54 * $k} }
    inst nmos_n3f5_f4_l150_ffbfb   [s 0] 0.18
    inst nmos_n3f5_f2_l150_bff     [t 0] 0.18
    inst pmos_n6_f4_l150_hvt_ftftb [s 0] 1.62
    inst pmos_n6_f2_l150_hvt_fbf   [t 0] 1.62
    # gate bars and polyconts
    pl 0.18 1.08 1.26 1.44
    pl 1.62 1.08 2.34 1.44
    pl 3.06 1.08 4.14 1.44
    foreach x [list [s 0] [s 3] [t 0]] {
        um [expr {$x - 0.18}] 1.08 [expr {$x + 0.18}] 1.44; efx::polycont_draw
    }
    # nmos: VGND straps, Y bar along the row's top
    foreach x [list [s 0] [s 2] [s 4] [t 0] [t 2]] { li [expr {$x - 0.18}] 0 [expr {$x + 0.18}] 0.36 }
    li [expr {[s 1] - 0.18}] 0.72 [expr {[t 1] + 0.18}] 0.90
    # Y riser at t1 to the pmos Y contact (t1, bottom)
    li [expr {[t 1] - 0.18}] 0.72 [expr {[t 1] + 0.18}] 1.98
    # pmos: n1 bar along the row's bottom, n2 bar along its top, VPWR strap
    li [expr {[s 0] - 0.18}] 1.62 [expr {[s 4] + 0.18}] 1.98
    li [expr {[s 3] - 0.18}] 2.34 [expr {[t 2] + 0.18}] 2.70
    li [expr {[s 1] - 0.18}] 2.52 [expr {[s 1] + 0.18}] 2.88
    lvdig_rails 4.68
    gpin A [s 0] input signal
    gpin B [s 3] input signal
    gpin C [t 0] input signal
    gpin Y [t 1] output signal
    power_pins
    save_drc $c
}
quit -noprompt
