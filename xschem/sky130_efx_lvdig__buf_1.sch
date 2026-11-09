v {xschem version=3.4.7 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
T {Schematic of sky130_efx_lvdig__buf_1, from the PDK netlist of sky130_fd_sc_hd__buf_1
(libs.ref/sky130_fd_sc_hd/spice/sky130_fd_sc_hd.spice)} -60 -460 0 0 0.3 0.3 {}
N 220 -140 220 -170 {}
C {sky130_fd_pr/pfet_01v8_hvt.sym} 200 -200 0 0 {name=M0
L=0.15
W=0.81
nf=1
mult=1
model=pfet_01v8_hvt
spiceprefix=X
}
N 220 -200 320 -200 {}
C {devices/lab_pin.sym} 320 -200 0 1 {name=l1 lab=VPB}
N 220 -230 220 -250 {}
C {devices/lab_pin.sym} 220 -250 0 1 {name=l2 lab=VPWR}
N 220 -60 220 -30 {}
C {sky130_fd_pr/nfet_01v8.sym} 200 0 0 0 {name=M1
L=0.15
W=0.54
nf=1
mult=1
model=nfet_01v8
spiceprefix=X
}
N 220 0 320 0 {}
C {devices/lab_pin.sym} 320 0 0 1 {name=l3 lab=VNB}
N 220 30 220 50 {}
C {devices/lab_pin.sym} 220 50 0 1 {name=l4 lab=VGND}
N 220 -140 220 -100 {}
N 220 -100 220 -60 {}
N 180 -200 140 -200 {}
N 140 -200 140 -100 {}
N 140 -100 140 0 {}
N 140 0 180 0 {}
N 100 -100 140 -100 {}
C {devices/ipin.sym} 100 -100 0 0 {name=p1 lab=A}
N 520 -140 520 -170 {}
C {sky130_fd_pr/pfet_01v8_hvt.sym} 500 -200 0 0 {name=M2
L=0.15
W=0.81
nf=1
mult=1
model=pfet_01v8_hvt
spiceprefix=X
}
N 520 -200 620 -200 {}
C {devices/lab_pin.sym} 620 -200 0 1 {name=l5 lab=VPB}
N 520 -230 520 -250 {}
C {devices/lab_pin.sym} 520 -250 0 1 {name=l6 lab=VPWR}
N 520 -60 520 -30 {}
C {sky130_fd_pr/nfet_01v8.sym} 500 0 0 0 {name=M3
L=0.15
W=0.54
nf=1
mult=1
model=nfet_01v8
spiceprefix=X
}
N 520 0 620 0 {}
C {devices/lab_pin.sym} 620 0 0 1 {name=l7 lab=VNB}
N 520 30 520 50 {}
C {devices/lab_pin.sym} 520 50 0 1 {name=l8 lab=VGND}
N 520 -140 520 -100 {}
N 520 -100 520 -60 {}
N 480 -200 440 -200 {}
N 440 -200 440 -100 {}
N 440 -100 440 0 {}
N 440 0 480 0 {}
N 400 -100 440 -100 {}
N 220 -100 400 -100 {}
N 520 -100 680 -100 {}
C {devices/opin.sym} 680 -100 0 0 {name=p2 lab=X}
C {devices/iopin.sym} -40 -380 0 1 {name=p3 lab=VGND}
C {devices/iopin.sym} -40 -350 0 1 {name=p4 lab=VNB}
C {devices/iopin.sym} -40 -320 0 1 {name=p5 lab=VPB}
C {devices/iopin.sym} -40 -290 0 1 {name=p6 lab=VPWR}
C {title_efx.sym} 160 170 0 0 {name=t1 author="ejfogleman"}
C {copyright.sym} 160 240 0 0 {name=s1 place=header value="* Copyright (c) 2026 Eric Fogleman
* SPDX-License-Identifier: Apache-2.0
* Derived from SkyWater sky130_fd_sc_hd (Apache-2.0); see NOTICE"}
