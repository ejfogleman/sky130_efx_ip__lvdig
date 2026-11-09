v {xschem version=3.4.7 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
T {Schematic of sky130_efx_lvdig__ha_1, from the PDK netlist of sky130_fd_sc_hd__ha_1
(libs.ref/sky130_fd_sc_hd/spice/sky130_fd_sc_hd.spice)} -60 -630 0 0 0.3 0.3 {}
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
N 220 -260 220 -280 {}
C {devices/lab_pin.sym} 220 -280 0 1 {name=l5 lab=VPWR}
N 220 -60 220 -30 {}
C {sky130_fd_pr/nfet_01v8.sym} 200 0 0 0 {name=M2
L=0.15
W=0.45
nf=1
mult=1
model=nfet_01v8
spiceprefix=X
}
N 220 0 320 0 {}
C {devices/lab_pin.sym} 320 0 0 1 {name=l6 lab=VNB}
N 160 0 180 0 {}
C {devices/lab_pin.sym} 160 0 0 0 {name=l7 lab=B}
N 220 30 220 50 {}
C {sky130_fd_pr/nfet_01v8.sym} 200 80 0 0 {name=M3
L=0.15
W=0.45
nf=1
mult=1
model=nfet_01v8
spiceprefix=X
}
N 220 80 320 80 {}
C {devices/lab_pin.sym} 320 80 0 1 {name=l8 lab=VNB}
N 160 80 180 80 {}
C {devices/lab_pin.sym} 160 80 0 0 {name=l9 lab=A}
N 220 110 220 130 {}
C {devices/lab_pin.sym} 220 130 0 1 {name=l10 lab=VGND}
N 220 -140 220 -100 {}
N 220 -100 220 -60 {}
N 220 -100 660 -100 {}
C {devices/lab_pin.sym} 660 -100 0 1 {name=l11 lab=COUT_N}
N 900 -140 900 -170 {}
C {sky130_fd_pr/pfet_01v8_hvt.sym} 880 -200 0 0 {name=M4
L=0.15
W=1.08
nf=1
mult=1
model=pfet_01v8_hvt
spiceprefix=X
}
N 900 -200 1000 -200 {}
C {devices/lab_pin.sym} 1000 -200 0 1 {name=l12 lab=VPB}
N 900 -230 900 -250 {}
C {devices/lab_pin.sym} 900 -250 0 1 {name=l13 lab=VPWR}
N 900 -60 900 -30 {}
C {sky130_fd_pr/nfet_01v8.sym} 880 0 0 0 {name=M5
L=0.15
W=0.63
nf=1
mult=1
model=nfet_01v8
spiceprefix=X
}
N 900 0 1000 0 {}
C {devices/lab_pin.sym} 1000 0 0 1 {name=l14 lab=VNB}
N 900 30 900 50 {}
C {devices/lab_pin.sym} 900 50 0 1 {name=l15 lab=VGND}
N 900 -140 900 -100 {}
N 900 -100 900 -60 {}
N 860 -200 820 -200 {}
N 820 -200 820 -100 {}
N 820 -100 820 0 {}
N 820 0 860 0 {}
N 780 -100 820 -100 {}
N 660 -100 780 -100 {}
N 900 -100 1060 -100 {}
C {devices/opin.sym} 1060 -100 0 0 {name=p1 lab=COUT}
N 1300 -140 1300 -170 {}
C {sky130_fd_pr/pfet_01v8_hvt.sym} 1280 -200 0 0 {name=M6
L=0.15
W=0.45
nf=1
mult=1
model=pfet_01v8_hvt
spiceprefix=X
}
N 1300 -200 1400 -200 {}
C {devices/lab_pin.sym} 1400 -200 0 1 {name=l16 lab=VPB}
N 1240 -200 1260 -200 {}
C {devices/lab_pin.sym} 1240 -200 0 0 {name=l17 lab=COUT_N}
N 1300 -230 1300 -340 {}
N 1580 -140 1580 -170 {}
C {sky130_fd_pr/pfet_01v8_hvt.sym} 1560 -200 0 0 {name=M7
L=0.15
W=0.45
nf=1
mult=1
model=pfet_01v8_hvt
spiceprefix=X
}
N 1580 -200 1680 -200 {}
C {devices/lab_pin.sym} 1680 -200 0 1 {name=l18 lab=VPB}
N 1520 -200 1540 -200 {}
C {devices/lab_pin.sym} 1520 -200 0 0 {name=l19 lab=B}
N 1580 -230 1580 -250 {}
C {sky130_fd_pr/pfet_01v8_hvt.sym} 1560 -280 0 0 {name=M8
L=0.15
W=0.45
nf=1
mult=1
model=pfet_01v8_hvt
spiceprefix=X
}
N 1580 -280 1680 -280 {}
C {devices/lab_pin.sym} 1680 -280 0 1 {name=l20 lab=VPB}
N 1520 -280 1540 -280 {}
C {devices/lab_pin.sym} 1520 -280 0 0 {name=l21 lab=A}
N 1580 -310 1580 -340 {}
N 1300 -140 1580 -140 {}
N 1300 -340 1580 -340 {}
N 1300 -340 1300 -360 {}
C {devices/lab_pin.sym} 1300 -360 0 1 {name=l22 lab=VPWR}
N 1300 -60 1300 -30 {}
C {sky130_fd_pr/nfet_01v8.sym} 1280 0 0 0 {name=M9
L=0.15
W=0.45
nf=1
mult=1
model=nfet_01v8
spiceprefix=X
}
N 1300 0 1400 0 {}
C {devices/lab_pin.sym} 1400 0 0 1 {name=l23 lab=VNB}
N 1240 0 1260 0 {}
C {devices/lab_pin.sym} 1240 0 0 0 {name=l24 lab=COUT_N}
N 1300 30 1300 50 {}
N 1300 50 1300 80 {}
C {sky130_fd_pr/nfet_01v8.sym} 1280 110 0 0 {name=M10
L=0.15
W=0.45
nf=1
mult=1
model=nfet_01v8
spiceprefix=X
}
N 1300 110 1400 110 {}
C {devices/lab_pin.sym} 1400 110 0 1 {name=l25 lab=VNB}
N 1240 110 1260 110 {}
C {devices/lab_pin.sym} 1240 110 0 0 {name=l26 lab=A}
N 1300 140 1300 170 {}
N 1580 50 1580 80 {}
C {sky130_fd_pr/nfet_01v8.sym} 1560 110 0 0 {name=M11
L=0.15
W=0.45
nf=1
mult=1
model=nfet_01v8
spiceprefix=X
}
N 1580 110 1680 110 {}
C {devices/lab_pin.sym} 1680 110 0 1 {name=l27 lab=VNB}
N 1520 110 1540 110 {}
C {devices/lab_pin.sym} 1520 110 0 0 {name=l28 lab=B}
N 1580 140 1580 170 {}
N 1300 50 1580 50 {}
N 1300 170 1580 170 {}
N 1300 170 1300 190 {}
C {devices/lab_pin.sym} 1300 190 0 1 {name=l29 lab=VGND}
N 1300 -140 1300 -100 {}
N 1300 -100 1300 -60 {}
N 1880 -140 1880 -170 {}
C {sky130_fd_pr/pfet_01v8_hvt.sym} 1860 -200 0 0 {name=M12
L=0.15
W=1.08
nf=1
mult=1
model=pfet_01v8_hvt
spiceprefix=X
}
N 1880 -200 1980 -200 {}
C {devices/lab_pin.sym} 1980 -200 0 1 {name=l30 lab=VPB}
N 1880 -230 1880 -250 {}
C {devices/lab_pin.sym} 1880 -250 0 1 {name=l31 lab=VPWR}
N 1880 -60 1880 -30 {}
C {sky130_fd_pr/nfet_01v8.sym} 1860 0 0 0 {name=M13
L=0.15
W=0.63
nf=1
mult=1
model=nfet_01v8
spiceprefix=X
}
N 1880 0 1980 0 {}
C {devices/lab_pin.sym} 1980 0 0 1 {name=l32 lab=VNB}
N 1880 30 1880 50 {}
C {devices/lab_pin.sym} 1880 50 0 1 {name=l33 lab=VGND}
N 1880 -140 1880 -100 {}
N 1880 -100 1880 -60 {}
N 1840 -200 1800 -200 {}
N 1800 -200 1800 -100 {}
N 1800 -100 1800 0 {}
N 1800 0 1840 0 {}
N 1760 -100 1800 -100 {}
N 1300 -100 1760 -100 {}
N 1880 -100 2040 -100 {}
C {devices/opin.sym} 2040 -100 0 0 {name=p2 lab=SUM}
C {devices/ipin.sym} -40 -550 0 0 {name=p3 lab=A}
C {devices/ipin.sym} -40 -520 0 0 {name=p4 lab=B}
C {devices/iopin.sym} -40 -490 0 1 {name=p5 lab=VGND}
C {devices/iopin.sym} -40 -460 0 1 {name=p6 lab=VNB}
C {devices/iopin.sym} -40 -430 0 1 {name=p7 lab=VPB}
C {devices/iopin.sym} -40 -400 0 1 {name=p8 lab=VPWR}
C {title_efx.sym} 1270 310 0 0 {name=t1 author="ejfogleman"}
C {copyright.sym} 1270 380 0 0 {name=s1 place=header value="* Copyright (c) 2026 Eric Fogleman
* SPDX-License-Identifier: Apache-2.0
* Derived from SkyWater sky130_fd_sc_hd (Apache-2.0); see NOTICE"}
