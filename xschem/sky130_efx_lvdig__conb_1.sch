v {xschem version=3.4.7 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
T {Schematic of sky130_efx_lvdig__conb_1, from the PDK netlist of sky130_fd_sc_hd__conb_1
(libs.ref/sky130_fd_sc_hd/spice/sky130_fd_sc_hd.spice); resistors snapped to
the lambda grid: W 0.48 -> 0.45, L 0.5 -> 0.54 (2026-11-08)} -20 -480 0 0 0.3 0.3 {}
T {Tie cell: HI through a poly resistor to VPWR, LO to VGND.
VNB and VPB are ports only; nothing in the cell connects to them.} 160 -360 0 0 0.25 0.25 {}
N 200 -250 200 -230 {}
N 200 -170 200 -140 {}
N 200 -140 320 -140 {}
N 200 -30 200 -60 {}
N 200 -60 320 -60 {}
N 200 30 200 50 {}
C {devices/iopin.sym} 0 -410 0 1 {name=p1 lab=VGND}
C {devices/iopin.sym} 0 -380 0 1 {name=p2 lab=VNB}
C {devices/iopin.sym} 0 -350 0 1 {name=p3 lab=VPB}
C {devices/iopin.sym} 0 -320 0 1 {name=p4 lab=VPWR}
C {devices/opin.sym} 320 -140 0 0 {name=p5 lab=HI}
C {devices/opin.sym} 320 -60 0 0 {name=p6 lab=LO}
C {sky130_fd_pr/res_generic_po.sym} 200 -200 0 0 {name=R1
W=0.45
L=0.54
model=res_generic_po
spiceprefix=X
mult=1}
C {sky130_fd_pr/res_generic_po.sym} 200 0 0 0 {name=R0
W=0.45
L=0.54
model=res_generic_po
spiceprefix=X
mult=1}
C {devices/lab_pin.sym} 200 -250 0 1 {name=l1 lab=VPWR}
C {devices/lab_pin.sym} 200 50 0 1 {name=l2 lab=VGND}
C {title_efx.sym} 360 170 0 0 {name=t1 author="ejfogleman"}
C {copyright.sym} 360 240 0 0 {name=s1 place=header value="* Copyright (c) 2026 Eric Fogleman
* SPDX-License-Identifier: Apache-2.0
* Derived from SkyWater sky130_fd_sc_hd (Apache-2.0); see NOTICE"}
