v {xschem version=3.4.7 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
T {Schematic of sky130_efx_lvdig__mux2_2, from the PDK netlist of sky130_fd_sc_hd__mux2_2
(libs.ref/sky130_fd_sc_hd/spice/sky130_fd_sc_hd.spice)} -60 -630 0 0 0.3 0.3 {}
N 220 -140 220 -170 {}
C {sky130_fd_pr/pfet_01v8_hvt.sym} 200 -200 0 0 {name=M0
L=0.15
W=0.63
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
W=0.45
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
C {devices/ipin.sym} 100 -100 0 0 {name=p1 lab=S}
N 220 -100 380 -100 {}
C {devices/lab_pin.sym} 380 -100 0 1 {name=l5 lab=S_N}
N 620 -140 620 -170 {}
C {sky130_fd_pr/pfet_01v8_hvt.sym} 600 -200 0 0 {name=M2
L=0.15
W=0.63
nf=1
mult=1
model=pfet_01v8_hvt
spiceprefix=X
}
N 620 -200 720 -200 {}
C {devices/lab_pin.sym} 720 -200 0 1 {name=l6 lab=VPB}
N 560 -200 580 -200 {}
C {devices/lab_pin.sym} 560 -200 0 0 {name=l7 lab=A0}
N 620 -230 620 -250 {}
C {sky130_fd_pr/pfet_01v8_hvt.sym} 600 -280 0 0 {name=M3
L=0.15
W=0.63
nf=1
mult=1
model=pfet_01v8_hvt
spiceprefix=X
}
N 620 -280 720 -280 {}
C {devices/lab_pin.sym} 720 -280 0 1 {name=l8 lab=VPB}
N 560 -280 580 -280 {}
C {devices/lab_pin.sym} 560 -280 0 0 {name=l9 lab=S}
N 620 -310 620 -340 {}
N 900 -140 900 -170 {}
C {sky130_fd_pr/pfet_01v8_hvt.sym} 880 -200 0 0 {name=M4
L=0.15
W=0.63
nf=1
mult=1
model=pfet_01v8_hvt
spiceprefix=X
}
N 900 -200 1000 -200 {}
C {devices/lab_pin.sym} 1000 -200 0 1 {name=l10 lab=VPB}
N 840 -200 860 -200 {}
C {devices/lab_pin.sym} 840 -200 0 0 {name=l11 lab=A1}
N 900 -230 900 -250 {}
C {sky130_fd_pr/pfet_01v8_hvt.sym} 880 -280 0 0 {name=M5
L=0.15
W=0.63
nf=1
mult=1
model=pfet_01v8_hvt
spiceprefix=X
}
N 900 -280 1000 -280 {}
C {devices/lab_pin.sym} 1000 -280 0 1 {name=l12 lab=VPB}
N 840 -280 860 -280 {}
C {devices/lab_pin.sym} 840 -280 0 0 {name=l13 lab=S_N}
N 900 -310 900 -340 {}
N 620 -140 900 -140 {}
N 620 -340 900 -340 {}
N 620 -340 620 -360 {}
C {devices/lab_pin.sym} 620 -360 0 1 {name=l14 lab=VPWR}
N 620 -60 620 -30 {}
C {sky130_fd_pr/nfet_01v8.sym} 600 0 0 0 {name=M6
L=0.15
W=0.45
nf=1
mult=1
model=nfet_01v8
spiceprefix=X
}
N 620 0 720 0 {}
C {devices/lab_pin.sym} 720 0 0 1 {name=l15 lab=VNB}
N 560 0 580 0 {}
C {devices/lab_pin.sym} 560 0 0 0 {name=l16 lab=A0}
N 620 30 620 50 {}
C {sky130_fd_pr/nfet_01v8.sym} 600 80 0 0 {name=M7
L=0.15
W=0.45
nf=1
mult=1
model=nfet_01v8
spiceprefix=X
}
N 620 80 720 80 {}
C {devices/lab_pin.sym} 720 80 0 1 {name=l17 lab=VNB}
N 560 80 580 80 {}
C {devices/lab_pin.sym} 560 80 0 0 {name=l18 lab=S_N}
N 620 110 620 140 {}
N 900 -60 900 -30 {}
C {sky130_fd_pr/nfet_01v8.sym} 880 0 0 0 {name=M8
L=0.15
W=0.45
nf=1
mult=1
model=nfet_01v8
spiceprefix=X
}
N 900 0 1000 0 {}
C {devices/lab_pin.sym} 1000 0 0 1 {name=l19 lab=VNB}
N 840 0 860 0 {}
C {devices/lab_pin.sym} 840 0 0 0 {name=l20 lab=A1}
N 900 30 900 50 {}
C {sky130_fd_pr/nfet_01v8.sym} 880 80 0 0 {name=M9
L=0.15
W=0.45
nf=1
mult=1
model=nfet_01v8
spiceprefix=X
}
N 900 80 1000 80 {}
C {devices/lab_pin.sym} 1000 80 0 1 {name=l21 lab=VNB}
N 840 80 860 80 {}
C {devices/lab_pin.sym} 840 80 0 0 {name=l22 lab=S}
N 900 110 900 140 {}
N 620 -60 900 -60 {}
N 620 140 900 140 {}
N 620 140 620 160 {}
C {devices/lab_pin.sym} 620 160 0 1 {name=l23 lab=VGND}
N 620 -140 620 -100 {}
N 620 -100 620 -60 {}
N 1200 -140 1200 -170 {}
C {sky130_fd_pr/pfet_01v8_hvt.sym} 1180 -200 0 0 {name=M10
L=0.15
W=1.08
nf=1
mult=2
model=pfet_01v8_hvt
spiceprefix=X
}
N 1200 -200 1300 -200 {}
C {devices/lab_pin.sym} 1300 -200 0 1 {name=l24 lab=VPB}
N 1200 -230 1200 -250 {}
C {devices/lab_pin.sym} 1200 -250 0 1 {name=l25 lab=VPWR}
N 1200 -60 1200 -30 {}
C {sky130_fd_pr/nfet_01v8.sym} 1180 0 0 0 {name=M11
L=0.15
W=0.63
nf=1
mult=2
model=nfet_01v8
spiceprefix=X
}
N 1200 0 1300 0 {}
C {devices/lab_pin.sym} 1300 0 0 1 {name=l26 lab=VNB}
N 1200 30 1200 50 {}
C {devices/lab_pin.sym} 1200 50 0 1 {name=l27 lab=VGND}
N 1200 -140 1200 -100 {}
N 1200 -100 1200 -60 {}
N 1160 -200 1120 -200 {}
N 1120 -200 1120 -100 {}
N 1120 -100 1120 0 {}
N 1120 0 1160 0 {}
N 1080 -100 1120 -100 {}
N 620 -100 1080 -100 {}
N 1200 -100 1360 -100 {}
C {devices/opin.sym} 1360 -100 0 0 {name=p2 lab=X}
C {devices/ipin.sym} -40 -550 0 0 {name=p3 lab=A0}
C {devices/ipin.sym} -40 -520 0 0 {name=p4 lab=A1}
C {devices/iopin.sym} -40 -490 0 1 {name=p5 lab=VGND}
C {devices/iopin.sym} -40 -460 0 1 {name=p6 lab=VNB}
C {devices/iopin.sym} -40 -430 0 1 {name=p7 lab=VPB}
C {devices/iopin.sym} -40 -400 0 1 {name=p8 lab=VPWR}
C {title_efx.sym} 590 280 0 0 {name=t1 author="ejfogleman"}
C {copyright.sym} 590 350 0 0 {name=s1 place=header value="* Copyright (c) 2026 Eric Fogleman
* SPDX-License-Identifier: Apache-2.0
* Derived from SkyWater sky130_fd_sc_hd (Apache-2.0); see NOTICE"}
