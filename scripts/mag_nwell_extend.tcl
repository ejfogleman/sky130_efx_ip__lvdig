# Extend each sky130_efx_lvdig cell's n-well to y 3.42 um (over the VPWR rail) so
# flipped rows sharing VPWR have overlapping wells (nwell.2a). 2026-11-06.
#   cd mag && magic -dnull -noconsole ../scripts/mag_nwell_extend.tcl
load sky130_efx_lvdig__buf_1; box values 0um 1.44um 2.52um 3.42um; paint nwell; save sky130_efx_lvdig__buf_1
load sky130_efx_lvdig__buf_2; box values 0um 1.44um 3.06um 3.42um; paint nwell; save sky130_efx_lvdig__buf_2
load sky130_efx_lvdig__buf_4; box values 0um 1.44um 4.14um 3.42um; paint nwell; save sky130_efx_lvdig__buf_4
load sky130_efx_lvdig__clkbuf_1; box values 0um 1.44um 2.52um 3.42um; paint nwell; save sky130_efx_lvdig__clkbuf_1
load sky130_efx_lvdig__clkbuf_2; box values 0um 1.44um 3.06um 3.42um; paint nwell; save sky130_efx_lvdig__clkbuf_2
load sky130_efx_lvdig__clkbuf_4; box values 0um 1.44um 4.14um 3.42um; paint nwell; save sky130_efx_lvdig__clkbuf_4
load sky130_efx_lvdig__clkbuf_8; box values 0um 1.44um 6.84um 3.42um; paint nwell; save sky130_efx_lvdig__clkbuf_8
load sky130_efx_lvdig__clkinv_1; box values 0um 1.44um 1.80um 3.42um; paint nwell; save sky130_efx_lvdig__clkinv_1
load sky130_efx_lvdig__clkinv_2; box values 0um 1.44um 2.34um 3.42um; paint nwell; save sky130_efx_lvdig__clkinv_2
load sky130_efx_lvdig__clkinv_4; box values 0um 1.44um 3.96um 3.42um; paint nwell; save sky130_efx_lvdig__clkinv_4
load sky130_efx_lvdig__clkinv_8; box values 0um 1.44um 7.20um 3.42um; paint nwell; save sky130_efx_lvdig__clkinv_8
load sky130_efx_lvdig__inv_1; box values 0um 1.44um 1.26um 3.42um; paint nwell; save sky130_efx_lvdig__inv_1
load sky130_efx_lvdig__inv_2; box values 0um 1.44um 1.80um 3.42um; paint nwell; save sky130_efx_lvdig__inv_2
load sky130_efx_lvdig__inv_4; box values 0um 1.44um 2.88um 3.42um; paint nwell; save sky130_efx_lvdig__inv_4
load sky130_efx_lvdig__nand2_1; box values 0um 1.44um 2.34um 3.42um; paint nwell; save sky130_efx_lvdig__nand2_1
load sky130_efx_lvdig__nor2_1; box values 0um 1.44um 2.34um 3.42um; paint nwell; save sky130_efx_lvdig__nor2_1
foreach c {sky130_efx_lvdig__buf_1 sky130_efx_lvdig__buf_2 sky130_efx_lvdig__buf_4 sky130_efx_lvdig__clkbuf_1 sky130_efx_lvdig__clkbuf_2 sky130_efx_lvdig__clkbuf_4 sky130_efx_lvdig__clkbuf_8 sky130_efx_lvdig__clkinv_1 sky130_efx_lvdig__clkinv_2 sky130_efx_lvdig__clkinv_4 sky130_efx_lvdig__clkinv_8 sky130_efx_lvdig__inv_1 sky130_efx_lvdig__inv_2 sky130_efx_lvdig__inv_4 sky130_efx_lvdig__nand2_1 sky130_efx_lvdig__nor2_1 sky130_efx_lvdig__allcells} { load $c; select top cell; drc check; drc catchup; puts "$c DRC: [drc list count total]" }
load sky130_efx_lvdig__allcells; select top cell; drc check; drc catchup; puts [drc listall why]
quit -noprompt
