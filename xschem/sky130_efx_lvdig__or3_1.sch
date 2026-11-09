v {xschem version=3.4.7 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
T {Schematic of sky130_efx_lvdig__or3_1, from the PDK netlist of sky130_fd_sc_hd__or3_1
(libs.ref/sky130_fd_sc_hd/spice/sky130_fd_sc_hd.spice)} -60 -710 0 0 0.3 0.3 {}
N 220 -140 220 -170 {}
C {sky130_fd_pr/pfet_01v8_hvt.sym} 200 -200 0 0 {name=M0
L=0.15
W=0.45
nf=1
mult=1
model=pfet_01v8_hvt
spiceprefix=X
}
N 220 -200 320 -200 {}
C {devices/lab_pin.sym} 320 -200 0 1 {name=l1 lab=VPB}
N 160 -200 180 -200 {}
C {devices/lab_pin.sym} 160 -200 0 0 {name=l2 lab=C}
N 220 -230 220 -250 {}
C {sky130_fd_pr/pfet_01v8_hvt.sym} 200 -280 0 0 {name=M1
L=0.15
W=0.45
nf=1
mult=1
model=pfet_01v8_hvt
spiceprefix=X
}
N 220 -280 320 -280 {}
C {devices/lab_pin.sym} 320 -280 0 1 {name=l3 lab=VPB}
N 160 -280 180 -280 {}
C {devices/lab_pin.sym} 160 -280 0 0 {name=l4 lab=B}
N 220 -310 220 -330 {}
C {sky130_fd_pr/pfet_01v8_hvt.sym} 200 -360 0 0 {name=M2
L=0.15
W=0.45
nf=1
mult=1
model=pfet_01v8_hvt
spiceprefix=X
}
N 220 -360 320 -360 {}
C {devices/lab_pin.sym} 320 -360 0 1 {name=l5 lab=VPB}
N 160 -360 180 -360 {}
C {devices/lab_pin.sym} 160 -360 0 0 {name=l6 lab=A}
N 220 -390 220 -410 {}
C {devices/lab_pin.sym} 220 -410 0 1 {name=l7 lab=VPWR}
N 220 -60 220 -30 {}
C {sky130_fd_pr/nfet_01v8.sym} 200 0 0 0 {name=M3
L=0.15
W=0.45
nf=1
mult=1
model=nfet_01v8
spiceprefix=X
}
N 220 0 320 0 {}
C {devices/lab_pin.sym} 320 0 0 1 {name=l8 lab=VNB}
N 160 0 180 0 {}
C {devices/lab_pin.sym} 160 0 0 0 {name=l9 lab=A}
N 220 30 220 60 {}
N 500 -60 500 -30 {}
C {sky130_fd_pr/nfet_01v8.sym} 480 0 0 0 {name=M4
L=0.15
W=0.45
nf=1
mult=1
model=nfet_01v8
spiceprefix=X
}
N 500 0 600 0 {}
C {devices/lab_pin.sym} 600 0 0 1 {name=l10 lab=VNB}
N 440 0 460 0 {}
C {devices/lab_pin.sym} 440 0 0 0 {name=l11 lab=B}
N 500 30 500 60 {}
N 220 -60 500 -60 {}
N 220 60 500 60 {}
N 780 -60 780 -30 {}
C {sky130_fd_pr/nfet_01v8.sym} 760 0 0 0 {name=M5
L=0.15
W=0.45
nf=1
mult=1
model=nfet_01v8
spiceprefix=X
}
N 780 0 880 0 {}
C {devices/lab_pin.sym} 880 0 0 1 {name=l12 lab=VNB}
N 720 0 740 0 {}
C {devices/lab_pin.sym} 720 0 0 0 {name=l13 lab=C}
N 780 30 780 60 {}
N 500 -60 780 -60 {}
N 500 60 780 60 {}
N 220 60 220 80 {}
C {devices/lab_pin.sym} 220 80 0 1 {name=l14 lab=VGND}
N 220 -140 220 -100 {}
N 220 -100 220 -60 {}
N 1080 -140 1080 -170 {}
C {sky130_fd_pr/pfet_01v8_hvt.sym} 1060 -200 0 0 {name=M6
L=0.15
W=1.08
nf=1
mult=1
model=pfet_01v8_hvt
spiceprefix=X
}
N 1080 -200 1180 -200 {}
C {devices/lab_pin.sym} 1180 -200 0 1 {name=l15 lab=VPB}
N 1080 -230 1080 -250 {}
C {devices/lab_pin.sym} 1080 -250 0 1 {name=l16 lab=VPWR}
N 1080 -60 1080 -30 {}
C {sky130_fd_pr/nfet_01v8.sym} 1060 0 0 0 {name=M7
L=0.15
W=0.63
nf=1
mult=1
model=nfet_01v8
spiceprefix=X
}
N 1080 0 1180 0 {}
C {devices/lab_pin.sym} 1180 0 0 1 {name=l17 lab=VNB}
N 1080 30 1080 50 {}
C {devices/lab_pin.sym} 1080 50 0 1 {name=l18 lab=VGND}
N 1080 -140 1080 -100 {}
N 1080 -100 1080 -60 {}
N 1040 -200 1000 -200 {}
N 1000 -200 1000 -100 {}
N 1000 -100 1000 0 {}
N 1000 0 1040 0 {}
N 960 -100 1000 -100 {}
N 220 -100 960 -100 {}
N 1080 -100 1240 -100 {}
C {devices/opin.sym} 1240 -100 0 0 {name=p1 lab=X}
C {devices/ipin.sym} -40 -630 0 0 {name=p2 lab=A}
C {devices/ipin.sym} -40 -600 0 0 {name=p3 lab=B}
C {devices/ipin.sym} -40 -570 0 0 {name=p4 lab=C}
C {devices/iopin.sym} -40 -540 0 1 {name=p5 lab=VGND}
C {devices/iopin.sym} -40 -510 0 1 {name=p6 lab=VNB}
C {devices/iopin.sym} -40 -480 0 1 {name=p7 lab=VPB}
C {devices/iopin.sym} -40 -450 0 1 {name=p8 lab=VPWR}
C {title_efx.sym} 470 200 0 0 {name=t1 author="ejfogleman"}
C {copyright.sym} 470 270 0 0 {name=s1 place=header value="* Copyright (c) 2026 Eric Fogleman
* SPDX-License-Identifier: Apache-2.0
* Derived from SkyWater sky130_fd_sc_hd (Apache-2.0); see NOTICE"}
