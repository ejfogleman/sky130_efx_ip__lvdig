v {xschem version=3.4.7 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
T {Schematic of sky130_efx_lvdig__nand2_1, from the PDK netlist of sky130_fd_sc_hd__nand2_1
(libs.ref/sky130_fd_sc_hd/spice/sky130_fd_sc_hd.spice)} -60 -550 0 0 0.3 0.3 {}
N 220 -140 220 -170 {}
C {sky130_fd_pr/pfet_01v8_hvt.sym} 200 -200 0 0 {name=M0
L=0.15
W=1.08
nf=1
mult=1
model=pfet_01v8_hvt
spiceprefix=X
}
N 220 -200 320 -200 {}
C {devices/lab_pin.sym} 320 -200 0 1 {name=l1 lab=VPB}
N 160 -200 180 -200 {}
C {devices/lab_pin.sym} 160 -200 0 0 {name=l2 lab=A}
N 220 -230 220 -260 {}
N 500 -140 500 -170 {}
C {sky130_fd_pr/pfet_01v8_hvt.sym} 480 -200 0 0 {name=M1
L=0.15
W=1.08
nf=1
mult=1
model=pfet_01v8_hvt
spiceprefix=X
}
N 500 -200 600 -200 {}
C {devices/lab_pin.sym} 600 -200 0 1 {name=l3 lab=VPB}
N 440 -200 460 -200 {}
C {devices/lab_pin.sym} 440 -200 0 0 {name=l4 lab=B}
N 500 -230 500 -260 {}
N 220 -140 500 -140 {}
N 220 -260 500 -260 {}
N 220 -260 220 -280 {}
C {devices/lab_pin.sym} 220 -280 0 1 {name=l5 lab=VPWR}
N 220 -60 220 -30 {}
C {sky130_fd_pr/nfet_01v8.sym} 200 0 0 0 {name=M2
L=0.15
W=0.63
nf=1
mult=1
model=nfet_01v8
spiceprefix=X
}
N 220 0 320 0 {}
C {devices/lab_pin.sym} 320 0 0 1 {name=l6 lab=VNB}
N 160 0 180 0 {}
C {devices/lab_pin.sym} 160 0 0 0 {name=l7 lab=A}
N 220 30 220 50 {}
C {sky130_fd_pr/nfet_01v8.sym} 200 80 0 0 {name=M3
L=0.15
W=0.63
nf=1
mult=1
model=nfet_01v8
spiceprefix=X
}
N 220 80 320 80 {}
C {devices/lab_pin.sym} 320 80 0 1 {name=l8 lab=VNB}
N 160 80 180 80 {}
C {devices/lab_pin.sym} 160 80 0 0 {name=l9 lab=B}
N 220 110 220 130 {}
C {devices/lab_pin.sym} 220 130 0 1 {name=l10 lab=VGND}
N 220 -140 220 -100 {}
N 220 -100 220 -60 {}
N 220 -100 660 -100 {}
C {devices/opin.sym} 660 -100 0 0 {name=p1 lab=Y}
C {devices/ipin.sym} -40 -470 0 0 {name=p2 lab=A}
C {devices/ipin.sym} -40 -440 0 0 {name=p3 lab=B}
C {devices/iopin.sym} -40 -410 0 1 {name=p4 lab=VGND}
C {devices/iopin.sym} -40 -380 0 1 {name=p5 lab=VNB}
C {devices/iopin.sym} -40 -350 0 1 {name=p6 lab=VPB}
C {devices/iopin.sym} -40 -320 0 1 {name=p7 lab=VPWR}
C {title_efx.sym} 160 250 0 0 {name=t1 author="ejfogleman"}
C {copyright.sym} 160 320 0 0 {name=s1 place=header value="* Copyright (c) 2026 Eric Fogleman
* SPDX-License-Identifier: Apache-2.0
* Derived from SkyWater sky130_fd_sc_hd (Apache-2.0); see NOTICE"}
