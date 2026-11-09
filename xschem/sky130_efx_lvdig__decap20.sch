v {xschem version=3.4.7 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
T {Schematic of sky130_efx_lvdig__decap20: decoupling capacitor, 20L (3.60 um) wide,
in hd's decap style: one long nfet and hvt pfet, L 2.52, each gate tied to the opposite rail
(lvdig cell, no hd counterpart; scripts/mag_build_decap20.tcl, 2026-11-09)} -60 -480 0 0 0.3 0.3 {}
C {sky130_fd_pr/pfet_01v8_hvt.sym} 200 -200 0 0 {name=M0
L=2.52
W=0.90
nf=1
mult=1
model=pfet_01v8_hvt
spiceprefix=X
}
N 220 -230 220 -250 {}
C {devices/lab_pin.sym} 220 -250 0 1 {name=l1 lab=VPWR}
N 220 -170 220 -150 {}
C {devices/lab_pin.sym} 220 -150 0 1 {name=l2 lab=VPWR}
N 220 -200 320 -200 {}
C {devices/lab_pin.sym} 320 -200 0 1 {name=l3 lab=VPB}
N 180 -200 140 -200 {}
C {devices/lab_pin.sym} 140 -200 0 0 {name=l4 lab=VGND}
C {sky130_fd_pr/nfet_01v8.sym} 200 0 0 0 {name=M1
L=2.52
W=0.63
nf=1
mult=1
model=nfet_01v8
spiceprefix=X
}
N 220 -30 220 -50 {}
C {devices/lab_pin.sym} 220 -50 0 1 {name=l5 lab=VGND}
N 220 30 220 50 {}
C {devices/lab_pin.sym} 220 50 0 1 {name=l6 lab=VGND}
N 220 0 320 0 {}
C {devices/lab_pin.sym} 320 0 0 1 {name=l7 lab=VNB}
N 180 0 140 0 {}
C {devices/lab_pin.sym} 140 0 0 0 {name=l8 lab=VPWR}
C {devices/iopin.sym} -40 -380 0 1 {name=p1 lab=VGND}
C {devices/iopin.sym} -40 -350 0 1 {name=p2 lab=VNB}
C {devices/iopin.sym} -40 -320 0 1 {name=p3 lab=VPB}
C {devices/iopin.sym} -40 -290 0 1 {name=p4 lab=VPWR}
C {title_efx.sym} 160 170 0 0 {name=t1 author="ejfogleman"}
C {copyright.sym} 160 240 0 0 {name=s1 place=header value="* Copyright (c) 2026 Eric Fogleman
* SPDX-License-Identifier: Apache-2.0"}
