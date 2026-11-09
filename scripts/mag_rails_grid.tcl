# Rail contacts on a global 2L grid (user's option (b), 2026-11-06), and every
# sky130_efx_lvdig cell widened to an even number of L where needed.
#
# Each rail (li 2L, met1 4L) gets one viali area in every 0.36 um slot, the
# size of the cut (0.17 square) and centred in the slot: cuts at x = 0.36k + 0.18.
# Magic checks mcon spacing (0.19) between the viali areas, not the cuts, so the
# areas are cut-sized: 0.19 apart within and across cells. A 1L area would be
# only 0.18 apart.
# With all widths a multiple of 2L, cells abutted from x = 0 put their contacts
# on one grid, so rows sharing a rail have coinciding (not partly overlapping)
# contacts. A widened cell gets its rails, wells and FIXED_BBOX extended by L.
#
#   cd mag && magic -dnull -noconsole ../scripts/mag_rails_grid.tcl
proc um {x0 y0 x1 y1} { box values ${x0}um ${y0}um ${x1}um ${y1}um }
# rails, wells and outline of a cell w um wide (w a multiple of 0.36)
proc lvdig_rails {w} {
    um 0 -0.36 $w 0;    erase viali
    um 0 2.88 $w 3.24;  erase viali
    um 0 -0.54 $w 0.18; paint m1
    um 0 2.70 $w 3.42;  paint m1
    um 0 -0.36 $w 0;    paint li
    um 0 2.88 $w 3.24;  paint li
    um 0 1.44 $w 3.42;  paint nwell
    um 0 0 $w 1.08;     paint pwell
    set n [expr {round($w / 0.36)}]
    for {set k 0} {$k < $n} {incr k} {
        set x [expr {0.36 * $k}]
        um [expr {$x + 0.095}] -0.265 [expr {$x + 0.265}] -0.095; paint viali
        um [expr {$x + 0.095}] 2.975 [expr {$x + 0.265}] 3.145;   paint viali
    }
    um 0 -0.18 $w 3.06; efx::fixed_bbox
}

# sky130_efx_lvdig__buf_1: 14L -> 14L
load sky130_efx_lvdig__buf_1; lvdig_rails 2.52; save sky130_efx_lvdig__buf_1
# sky130_efx_lvdig__buf_2: 17L -> 18L
load sky130_efx_lvdig__buf_2; lvdig_rails 3.24; save sky130_efx_lvdig__buf_2
# sky130_efx_lvdig__buf_4: 23L -> 24L
load sky130_efx_lvdig__buf_4; lvdig_rails 4.32; save sky130_efx_lvdig__buf_4
# sky130_efx_lvdig__clkbuf_1: 14L -> 14L
load sky130_efx_lvdig__clkbuf_1; lvdig_rails 2.52; save sky130_efx_lvdig__clkbuf_1
# sky130_efx_lvdig__clkbuf_2: 17L -> 18L
load sky130_efx_lvdig__clkbuf_2; lvdig_rails 3.24; save sky130_efx_lvdig__clkbuf_2
# sky130_efx_lvdig__clkbuf_4: 23L -> 24L
load sky130_efx_lvdig__clkbuf_4; lvdig_rails 4.32; save sky130_efx_lvdig__clkbuf_4
# sky130_efx_lvdig__clkbuf_8: 38L -> 38L
load sky130_efx_lvdig__clkbuf_8; lvdig_rails 6.84; save sky130_efx_lvdig__clkbuf_8
# sky130_efx_lvdig__clkinv_1: 10L -> 10L
load sky130_efx_lvdig__clkinv_1; lvdig_rails 1.80; save sky130_efx_lvdig__clkinv_1
# sky130_efx_lvdig__clkinv_2: 13L -> 14L
load sky130_efx_lvdig__clkinv_2; lvdig_rails 2.52; save sky130_efx_lvdig__clkinv_2
# sky130_efx_lvdig__clkinv_4: 22L -> 22L
load sky130_efx_lvdig__clkinv_4; lvdig_rails 3.96; save sky130_efx_lvdig__clkinv_4
# sky130_efx_lvdig__clkinv_8: 40L -> 40L
load sky130_efx_lvdig__clkinv_8; lvdig_rails 7.20; save sky130_efx_lvdig__clkinv_8
# sky130_efx_lvdig__inv_1: 7L -> 8L
load sky130_efx_lvdig__inv_1; lvdig_rails 1.44; save sky130_efx_lvdig__inv_1
# sky130_efx_lvdig__inv_2: 10L -> 10L
load sky130_efx_lvdig__inv_2; lvdig_rails 1.80; save sky130_efx_lvdig__inv_2
# sky130_efx_lvdig__inv_4: 16L -> 16L
load sky130_efx_lvdig__inv_4; lvdig_rails 2.88; save sky130_efx_lvdig__inv_4
# sky130_efx_lvdig__nand2_1: 13L -> 14L
load sky130_efx_lvdig__nand2_1; lvdig_rails 2.52; save sky130_efx_lvdig__nand2_1
# sky130_efx_lvdig__nor2_1: 13L -> 14L
load sky130_efx_lvdig__nor2_1; lvdig_rails 2.52; save sky130_efx_lvdig__nor2_1
foreach c {sky130_efx_lvdig__buf_1 sky130_efx_lvdig__buf_2 sky130_efx_lvdig__buf_4 sky130_efx_lvdig__clkbuf_1 sky130_efx_lvdig__clkbuf_2 sky130_efx_lvdig__clkbuf_4 sky130_efx_lvdig__clkbuf_8 sky130_efx_lvdig__clkinv_1 sky130_efx_lvdig__clkinv_2 sky130_efx_lvdig__clkinv_4 sky130_efx_lvdig__clkinv_8 sky130_efx_lvdig__inv_1 sky130_efx_lvdig__inv_2 sky130_efx_lvdig__inv_4 sky130_efx_lvdig__nand2_1 sky130_efx_lvdig__nor2_1} { load $c; select top cell; drc check; drc catchup; puts "$c DRC: [drc list count total] [drc listall why]" }
quit -noprompt
