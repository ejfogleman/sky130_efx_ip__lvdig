# sky130_efx_lvdig__allcells: every sky130_efx_lvdig layout, abutted by
# FIXED_BBOX in rows, with a tap cell at each end of every row; odd rows
# flipped (v) so neighbouring rows share a rail. Widths are read from each
# cell's FIXED_BBOX (all cells have it at x 0.., y -0.18..3.06).
#   cd mag && magic -dnull -noconsole ../scripts/mag_build_allcells.tcl
# Rewritten 2026-11-07 to compute positions and add the taps.
if {[file exists sky130_efx_lvdig__allcells.mag]} { puts "sky130_efx_lvdig__allcells.mag exists; delete it first"; quit -noprompt }

set ROWS {
    {tapvpwrvgnd_1 inv_1 inv_2 inv_4 nand2_1 nor2_1 nand2_2 nor2_2 buf_1 tapvgnd_1}
    {tapvpwrvgnd_2 buf_2 buf_4 clkinv_1 clkinv_2 nor3_2 tapvgnd_2}
    {tapvgnd_1 clkinv_4 clkinv_8 clkbuf_1 and2_1 and2_2 tapvpwrvgnd_1}
    {tapvgnd_2 clkbuf_2 clkbuf_4 clkbuf_8 and2_4 tapvpwrvgnd_2}
    {tapvpwrvgnd_1 and3_1 and4_2 or2_1 or2_2 tapvgnd_1}
    {tapvgnd_2 or2_4 or3_1 a21o_1 o21a_1 a22o_1 tapvpwrvgnd_2}
    {tapvpwrvgnd_1 mux2_1 mux2_2 ha_1 tapvgnd_1}
    {tapvgnd_2 dfxtp_2 tapvpwrvgnd_2}
    {tapvpwrvgnd_1 dfxbp_2 tapvgnd_1}
    {tapvgnd_2 dfrtp_1 tapvpwrvgnd_2}
    {tapvpwrvgnd_1 dfrtp_2 tapvgnd_1}
    {tapvgnd_2 dfrbp_1 tapvpwrvgnd_2}
    {tapvpwrvgnd_1 dfrbp_2 tapvgnd_1}
    {tapvgnd_2 dfstp_1 tapvpwrvgnd_2}
    {tapvpwrvgnd_1 dfstp_2 tapvgnd_1}
    {tapvgnd_2 dfbbp_1 tapvpwrvgnd_2}
    {tapvpwrvgnd_1 edfxtp_1 tapvgnd_1}
    {tapvgnd_2 edfxbp_1 tapvpwrvgnd_2}
    {tapvpwrvgnd_1 conb_1 dlygate4sd3_1 clkdlybuf4s50_1 decap10 decap20 tapvgnd_1}
}

# FIXED_BBOX width in um, from the .mag file (internal units 0.005 um)
proc width {cell} {
    set f [open $cell.mag]; set t [read $f]; close $f
    if {![regexp {string FIXED_BBOX (-?\d+) -?\d+ (-?\d+) -?\d+} $t -> x0 x1]} {
        error "$cell has no FIXED_BBOX"
    }
    return [expr {($x1 - $x0) * 0.005}]
}

# Pad every row to the widest with filler cells (2026-11-09), placed after the
# row's closing tap so no logic diffusion moves away from a tap (fillers have
# no diffusion, so LU.2/LU.3 don't apply to them; their n-well joins the row's
# tapped n-well). The shortfall is a multiple of 2L (all widths are even L):
# filler8s, then one filler6/4/2 for the rest. Fillers are not in ROWS, so
# gen_allcells_sch.py (no schematic for them) is unaffected.
proc row_width {row} {
    set w 0.0
    foreach c $row { set w [expr {$w + [width sky130_efx_lvdig__$c]}] }
    return $w
}
set wmax 0.0
foreach row $ROWS { set wmax [expr {max($wmax, [row_width $row])}] }
proc padding {gap} {
    set n [expr {round($gap / 0.18)}]   ;# shortfall in L, even
    set out {}
    while {$n >= 8} { lappend out filler8; incr n -8 }
    if {$n > 0} { lappend out filler$n }
    return $out
}

load sky130_efx_lvdig__allcells
set r 0
foreach row $ROWS {
    set x 0.0
    # row r's outline is y 3.24r - 0.18 .. 3.24r + 3.06; a flipped row's
    # origin is at its top, 3.24r + 2.88
    set flip [expr {$r % 2}]
    set y [expr {3.24 * $r + ($flip ? 2.88 : 0)}]
    set pad [padding [expr {$wmax - [row_width $row]}]]
    if {[llength $pad]} { puts "row $r: padding $pad" }
    foreach c [concat $row $pad] {
        set cell sky130_efx_lvdig__$c
        set xs [format %.2f $x]; set ys [format %.2f $y]
        box values ${xs}um ${ys}um ${xs}um ${ys}um
        if {$flip} {
            getcell $cell v child 0 0 parent ${xs}um ${ys}um
        } else {
            getcell $cell child 0 0 parent ${xs}um ${ys}um
        }
        set x [expr {$x + [width $cell]}]
    }
    puts "row $r: width [format %.2f $x] um"
    incr r
}
# Top-level ports (2026-11-07), named as in xschem/sky130_efx_lvdig__allcells.sch
# (scripts/gen_allcells_sch.py): VGND on the bottom rail, and VPWR_R01,
# VPWR_R23, ... on each row pair's shared VPWR rail (pair k: y 6.48k + 2.88 ..
# 3.24). Netgen fails the pin check of a portless top cell ("Top level cell
# failed pin matching") once dfxtp_2 is in; matching named ports fix it. Each
# label sits on a 2L met1 patch painted here over the rail, as a label needs
# paint in its own cell.
proc rail_port {name y0 use} {
    box values 0um ${y0}um 0.36um [expr {$y0 + 0.36}]um; paint m1
    efx::pin_place $name m1 0 FreeSans 0.18 center {} bidirectional $use
}
rail_port VGND -0.36 ground
for {set k 0} {2 * $k < [llength $ROWS]} {incr k} {
    rail_port VPWR_R[expr {2 * $k}][expr {2 * $k + 1}] [expr {6.48 * $k + 2.88}] power
}
save sky130_efx_lvdig__allcells
select top cell; drc check; drc catchup
puts "allcells DRC: [drc list count total]"; puts [drc listall why]
quit -noprompt
