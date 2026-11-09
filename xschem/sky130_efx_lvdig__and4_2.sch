v {xschem version=3.4.7 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
T {Schematic of sky130_efx_lvdig__and4_2, from the PDK netlist of sky130_fd_sc_hd__and4_2
(libs.ref/sky130_fd_sc_hd/spice/sky130_fd_sc_hd.spice)} -60 -610 0 0 0.3 0.3 {}
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
C {devices/lab_pin.sym} 160 -200 0 0 {name=l2 lab=A}
N 220 -230 220 -260 {}
N 500 -140 500 -170 {}
C {sky130_fd_pr/pfet_01v8_hvt.sym} 480 -200 0 0 {name=M1
L=0.15
W=0.45
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
N 780 -140 780 -170 {}
C {sky130_fd_pr/pfet_01v8_hvt.sym} 760 -200 0 0 {name=M2
L=0.15
W=0.45
nf=1
mult=1
model=pfet_01v8_hvt
spiceprefix=X
}
N 780 -200 880 -200 {}
C {devices/lab_pin.sym} 880 -200 0 1 {name=l5 lab=VPB}
N 720 -200 740 -200 {}
C {devices/lab_pin.sym} 720 -200 0 0 {name=l6 lab=C}
N 780 -230 780 -260 {}
N 500 -140 780 -140 {}
N 500 -260 780 -260 {}
N 1060 -140 1060 -170 {}
C {sky130_fd_pr/pfet_01v8_hvt.sym} 1040 -200 0 0 {name=M3
L=0.15
W=0.45
nf=1
mult=1
model=pfet_01v8_hvt
spiceprefix=X
}
N 1060 -200 1160 -200 {}
C {devices/lab_pin.sym} 1160 -200 0 1 {name=l7 lab=VPB}
N 1000 -200 1020 -200 {}
C {devices/lab_pin.sym} 1000 -200 0 0 {name=l8 lab=D}
N 1060 -230 1060 -260 {}
N 780 -140 1060 -140 {}
N 780 -260 1060 -260 {}
N 220 -260 220 -280 {}
C {devices/lab_pin.sym} 220 -280 0 1 {name=l9 lab=VPWR}
N 220 -60 220 -30 {}
C {sky130_fd_pr/nfet_01v8.sym} 200 0 0 0 {name=M4
L=0.15
W=0.45
nf=1
mult=1
model=nfet_01v8
spiceprefix=X
}
N 220 0 320 0 {}
C {devices/lab_pin.sym} 320 0 0 1 {name=l10 lab=VNB}
N 160 0 180 0 {}
C {devices/lab_pin.sym} 160 0 0 0 {name=l11 lab=A}
N 220 30 220 50 {}
C {sky130_fd_pr/nfet_01v8.sym} 200 80 0 0 {name=M5
L=0.15
W=0.45
nf=1
mult=1
model=nfet_01v8
spiceprefix=X
}
N 220 80 320 80 {}
C {devices/lab_pin.sym} 320 80 0 1 {name=l12 lab=VNB}
N 160 80 180 80 {}
C {devices/lab_pin.sym} 160 80 0 0 {name=l13 lab=B}
N 220 110 220 130 {}
C {sky130_fd_pr/nfet_01v8.sym} 200 160 0 0 {name=M6
L=0.15
W=0.45
nf=1
mult=1
model=nfet_01v8
spiceprefix=X
}
N 220 160 320 160 {}
C {devices/lab_pin.sym} 320 160 0 1 {name=l14 lab=VNB}
N 160 160 180 160 {}
C {devices/lab_pin.sym} 160 160 0 0 {name=l15 lab=C}
N 220 190 220 210 {}
C {sky130_fd_pr/nfet_01v8.sym} 200 240 0 0 {name=M7
L=0.15
W=0.45
nf=1
mult=1
model=nfet_01v8
spiceprefix=X
}
N 220 240 320 240 {}
C {devices/lab_pin.sym} 320 240 0 1 {name=l16 lab=VNB}
N 160 240 180 240 {}
C {devices/lab_pin.sym} 160 240 0 0 {name=l17 lab=D}
N 220 270 220 290 {}
C {devices/lab_pin.sym} 220 290 0 1 {name=l18 lab=VGND}
N 220 -140 220 -100 {}
N 220 -100 220 -60 {}
N 1360 -140 1360 -170 {}
C {sky130_fd_pr/pfet_01v8_hvt.sym} 1340 -200 0 0 {name=M8
L=0.15
W=1.08
nf=1
mult=2
model=pfet_01v8_hvt
spiceprefix=X
}
N 1360 -200 1460 -200 {}
C {devices/lab_pin.sym} 1460 -200 0 1 {name=l19 lab=VPB}
N 1360 -230 1360 -250 {}
C {devices/lab_pin.sym} 1360 -250 0 1 {name=l20 lab=VPWR}
N 1360 -60 1360 -30 {}
C {sky130_fd_pr/nfet_01v8.sym} 1340 0 0 0 {name=M9
L=0.15
W=0.63
nf=1
mult=2
model=nfet_01v8
spiceprefix=X
}
N 1360 0 1460 0 {}
C {devices/lab_pin.sym} 1460 0 0 1 {name=l21 lab=VNB}
N 1360 30 1360 50 {}
C {devices/lab_pin.sym} 1360 50 0 1 {name=l22 lab=VGND}
N 1360 -140 1360 -100 {}
N 1360 -100 1360 -60 {}
N 1320 -200 1280 -200 {}
N 1280 -200 1280 -100 {}
N 1280 -100 1280 0 {}
N 1280 0 1320 0 {}
N 1240 -100 1280 -100 {}
N 220 -100 1240 -100 {}
N 1360 -100 1520 -100 {}
C {devices/opin.sym} 1520 -100 0 0 {name=p1 lab=X}
C {devices/ipin.sym} -40 -530 0 0 {name=p2 lab=A}
C {devices/ipin.sym} -40 -500 0 0 {name=p3 lab=B}
C {devices/ipin.sym} -40 -470 0 0 {name=p4 lab=C}
C {devices/ipin.sym} -40 -440 0 0 {name=p5 lab=D}
C {devices/iopin.sym} -40 -410 0 1 {name=p6 lab=VGND}
C {devices/iopin.sym} -40 -380 0 1 {name=p7 lab=VNB}
C {devices/iopin.sym} -40 -350 0 1 {name=p8 lab=VPB}
C {devices/iopin.sym} -40 -320 0 1 {name=p9 lab=VPWR}
C {title_efx.sym} 750 410 0 0 {name=t1 author="ejfogleman"}
C {copyright.sym} 750 480 0 0 {name=s1 place=header value="* Copyright (c) 2026 Eric Fogleman
* SPDX-License-Identifier: Apache-2.0
* Derived from SkyWater sky130_fd_sc_hd (Apache-2.0); see NOTICE"}
