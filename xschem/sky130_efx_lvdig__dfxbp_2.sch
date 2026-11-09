v {xschem version=3.4.7 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
T {Schematic of sky130_efx_lvdig__dfxbp_2, from the PDK netlist of sky130_fd_sc_hd__dfxbp_2
(libs.ref/sky130_fd_sc_hd/spice/sky130_fd_sc_hd.spice)} -60 -460 0 0 0.3 0.3 {}
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
C {devices/ipin.sym} 100 -100 0 0 {name=p1 lab=D}
N 220 -100 380 -100 {}
N 380 -100 380 -70 {}
C {devices/lab_pin.sym} 380 -70 0 1 {name=l5 lab=D_N}
C {sky130_fd_pr/nfet3_01v8.sym} 550 -210 1 0 {name=M2
L=0.15
W=0.36
body=VNB
nf=1
mult=1
model=special_nfet_01v8
spiceprefix=X
}
N 550 -230 550 -250 {}
C {devices/lab_pin.sym} 550 -250 0 1 {name=l6 lab=CLK_N}
C {sky130_fd_pr/pfet3_01v8_hvt.sym} 550 10 3 0 {name=M3
L=0.15
W=0.45
body=VPB
nf=1
mult=1
model=pfet_01v8_hvt
spiceprefix=X
}
N 550 30 550 50 {}
C {devices/lab_pin.sym} 550 50 0 1 {name=l7 lab=CLK_P}
N 520 -190 480 -190 {}
N 480 -190 480 -100 {}
N 520 -10 480 -10 {}
N 480 -10 480 -100 {}
N 580 -190 620 -190 {}
N 620 -190 620 -100 {}
N 580 -10 620 -10 {}
N 620 -10 620 -100 {}
N 380 -100 480 -100 {}
N 620 -100 680 -100 {}
N 220 380 220 350 {}
C {sky130_fd_pr/pfet_01v8_hvt.sym} 200 320 0 0 {name=M4
L=0.15
W=0.45
nf=1
mult=1
model=pfet_01v8_hvt
spiceprefix=X
}
N 220 320 320 320 {}
C {devices/lab_pin.sym} 320 320 0 1 {name=l8 lab=VPB}
N 160 320 180 320 {}
C {devices/lab_pin.sym} 160 320 0 0 {name=l9 lab=CLK_N}
N 220 290 220 270 {}
C {sky130_fd_pr/pfet_01v8_hvt.sym} 200 240 0 0 {name=M5
L=0.15
W=0.45
nf=1
mult=1
model=pfet_01v8_hvt
spiceprefix=X
}
N 220 240 320 240 {}
C {devices/lab_pin.sym} 320 240 0 1 {name=l10 lab=VPB}
N 160 240 180 240 {}
C {devices/lab_pin.sym} 160 240 0 0 {name=l11 lab=M}
N 220 210 220 190 {}
C {devices/lab_pin.sym} 220 190 0 1 {name=l12 lab=VPWR}
N 220 460 220 490 {}
C {sky130_fd_pr/nfet_01v8.sym} 200 520 0 0 {name=M6
L=0.15
W=0.36
nf=1
mult=1
model=special_nfet_01v8
spiceprefix=X
}
N 220 520 320 520 {}
C {devices/lab_pin.sym} 320 520 0 1 {name=l13 lab=VNB}
N 160 520 180 520 {}
C {devices/lab_pin.sym} 160 520 0 0 {name=l14 lab=CLK_P}
N 220 550 220 570 {}
C {sky130_fd_pr/nfet_01v8.sym} 200 600 0 0 {name=M7
L=0.15
W=0.45
nf=1
mult=1
model=nfet_01v8
spiceprefix=X
}
N 220 600 320 600 {}
C {devices/lab_pin.sym} 320 600 0 1 {name=l15 lab=VNB}
N 160 600 180 600 {}
C {devices/lab_pin.sym} 160 600 0 0 {name=l16 lab=M}
N 220 630 220 650 {}
C {devices/lab_pin.sym} 220 650 0 1 {name=l17 lab=VGND}
N 220 380 220 420 {}
N 220 420 220 460 {}
N 220 420 680 420 {}
N 680 420 680 200 {}
N 680 200 680 -100 {}
C {devices/lab_pin.sym} 680 200 0 1 {name=l18 lab=M_N}
N 900 -140 900 -170 {}
C {sky130_fd_pr/pfet_01v8_hvt.sym} 880 -200 0 0 {name=M8
L=0.15
W=0.72
nf=1
mult=1
model=pfet_01v8_hvt
spiceprefix=X
}
N 900 -200 1000 -200 {}
C {devices/lab_pin.sym} 1000 -200 0 1 {name=l19 lab=VPB}
N 900 -230 900 -250 {}
C {devices/lab_pin.sym} 900 -250 0 1 {name=l20 lab=VPWR}
N 900 -60 900 -30 {}
C {sky130_fd_pr/nfet_01v8.sym} 880 0 0 0 {name=M9
L=0.15
W=0.63
nf=1
mult=1
model=nfet_01v8
spiceprefix=X
}
N 900 0 1000 0 {}
C {devices/lab_pin.sym} 1000 0 0 1 {name=l21 lab=VNB}
N 900 30 900 50 {}
C {devices/lab_pin.sym} 900 50 0 1 {name=l22 lab=VGND}
N 900 -140 900 -100 {}
N 900 -100 900 -60 {}
N 860 -200 820 -200 {}
N 820 -200 820 -100 {}
N 820 -100 820 0 {}
N 820 0 860 0 {}
N 780 -100 820 -100 {}
N 680 -100 780 -100 {}
N 900 -100 1060 -100 {}
N 1060 -100 1060 -70 {}
C {devices/lab_pin.sym} 1060 -70 0 1 {name=l23 lab=M}
C {sky130_fd_pr/nfet3_01v8.sym} 1230 -210 1 0 {name=M10
L=0.15
W=0.36
body=VNB
nf=1
mult=1
model=special_nfet_01v8
spiceprefix=X
}
N 1230 -230 1230 -250 {}
C {devices/lab_pin.sym} 1230 -250 0 1 {name=l24 lab=CLK_P}
C {sky130_fd_pr/pfet3_01v8_hvt.sym} 1230 10 3 0 {name=M11
L=0.15
W=0.45
body=VPB
nf=1
mult=1
model=pfet_01v8_hvt
spiceprefix=X
}
N 1230 30 1230 50 {}
C {devices/lab_pin.sym} 1230 50 0 1 {name=l25 lab=CLK_N}
N 1200 -190 1160 -190 {}
N 1160 -190 1160 -100 {}
N 1200 -10 1160 -10 {}
N 1160 -10 1160 -100 {}
N 1260 -190 1300 -190 {}
N 1300 -190 1300 -100 {}
N 1260 -10 1300 -10 {}
N 1300 -10 1300 -100 {}
N 1060 -100 1160 -100 {}
N 1300 -100 1360 -100 {}
N 880 380 880 350 {}
C {sky130_fd_pr/pfet_01v8_hvt.sym} 860 320 0 0 {name=M12
L=0.15
W=0.45
nf=1
mult=1
model=pfet_01v8_hvt
spiceprefix=X
}
N 880 320 980 320 {}
C {devices/lab_pin.sym} 980 320 0 1 {name=l26 lab=VPB}
N 820 320 840 320 {}
C {devices/lab_pin.sym} 820 320 0 0 {name=l27 lab=CLK_P}
N 880 290 880 270 {}
C {sky130_fd_pr/pfet_01v8_hvt.sym} 860 240 0 0 {name=M13
L=0.15
W=0.45
nf=1
mult=1
model=pfet_01v8_hvt
spiceprefix=X
}
N 880 240 980 240 {}
C {devices/lab_pin.sym} 980 240 0 1 {name=l28 lab=VPB}
N 820 240 840 240 {}
C {devices/lab_pin.sym} 820 240 0 0 {name=l29 lab=S_N}
N 880 210 880 190 {}
C {devices/lab_pin.sym} 880 190 0 1 {name=l30 lab=VPWR}
N 880 460 880 490 {}
C {sky130_fd_pr/nfet_01v8.sym} 860 520 0 0 {name=M14
L=0.15
W=0.36
nf=1
mult=1
model=special_nfet_01v8
spiceprefix=X
}
N 880 520 980 520 {}
C {devices/lab_pin.sym} 980 520 0 1 {name=l31 lab=VNB}
N 820 520 840 520 {}
C {devices/lab_pin.sym} 820 520 0 0 {name=l32 lab=CLK_N}
N 880 550 880 570 {}
C {sky130_fd_pr/nfet_01v8.sym} 860 600 0 0 {name=M15
L=0.15
W=0.45
nf=1
mult=1
model=nfet_01v8
spiceprefix=X
}
N 880 600 980 600 {}
C {devices/lab_pin.sym} 980 600 0 1 {name=l33 lab=VNB}
N 820 600 840 600 {}
C {devices/lab_pin.sym} 820 600 0 0 {name=l34 lab=S_N}
N 880 630 880 650 {}
C {devices/lab_pin.sym} 880 650 0 1 {name=l35 lab=VGND}
N 880 380 880 420 {}
N 880 420 880 460 {}
N 880 420 1360 420 {}
N 1360 420 1360 200 {}
N 1360 200 1360 -100 {}
C {devices/lab_pin.sym} 1360 200 0 1 {name=l36 lab=S}
N 1580 -140 1580 -170 {}
C {sky130_fd_pr/pfet_01v8_hvt.sym} 1560 -200 0 0 {name=M16
L=0.15
W=1.08
nf=1
mult=1
model=pfet_01v8_hvt
spiceprefix=X
}
N 1580 -200 1680 -200 {}
C {devices/lab_pin.sym} 1680 -200 0 1 {name=l37 lab=VPB}
N 1580 -230 1580 -250 {}
C {devices/lab_pin.sym} 1580 -250 0 1 {name=l38 lab=VPWR}
N 1580 -60 1580 -30 {}
C {sky130_fd_pr/nfet_01v8.sym} 1560 0 0 0 {name=M17
L=0.15
W=0.63
nf=1
mult=1
model=nfet_01v8
spiceprefix=X
}
N 1580 0 1680 0 {}
C {devices/lab_pin.sym} 1680 0 0 1 {name=l39 lab=VNB}
N 1580 30 1580 50 {}
C {devices/lab_pin.sym} 1580 50 0 1 {name=l40 lab=VGND}
N 1580 -140 1580 -100 {}
N 1580 -100 1580 -60 {}
N 1540 -200 1500 -200 {}
N 1500 -200 1500 -100 {}
N 1500 -100 1500 0 {}
N 1500 0 1540 0 {}
N 1460 -100 1500 -100 {}
N 1360 -100 1460 -100 {}
N 1580 -100 1740 -100 {}
N 1740 -100 1740 -70 {}
C {devices/lab_pin.sym} 1740 -70 0 1 {name=l41 lab=S_N}
N 1960 -140 1960 -170 {}
C {sky130_fd_pr/pfet_01v8_hvt.sym} 1940 -200 0 0 {name=M18
L=0.15
W=1.08
nf=1
mult=2
model=pfet_01v8_hvt
spiceprefix=X
}
N 1960 -200 2060 -200 {}
C {devices/lab_pin.sym} 2060 -200 0 1 {name=l42 lab=VPB}
N 1960 -230 1960 -250 {}
C {devices/lab_pin.sym} 1960 -250 0 1 {name=l43 lab=VPWR}
N 1960 -60 1960 -30 {}
C {sky130_fd_pr/nfet_01v8.sym} 1940 0 0 0 {name=M19
L=0.15
W=0.63
nf=1
mult=2
model=nfet_01v8
spiceprefix=X
}
N 1960 0 2060 0 {}
C {devices/lab_pin.sym} 2060 0 0 1 {name=l44 lab=VNB}
N 1960 30 1960 50 {}
C {devices/lab_pin.sym} 1960 50 0 1 {name=l45 lab=VGND}
N 1960 -140 1960 -100 {}
N 1960 -100 1960 -60 {}
N 1920 -200 1880 -200 {}
N 1880 -200 1880 -100 {}
N 1880 -100 1880 0 {}
N 1880 0 1920 0 {}
N 1840 -100 1880 -100 {}
N 1740 -100 1840 -100 {}
N 1960 -100 2120 -100 {}
C {devices/opin.sym} 2120 -100 0 0 {name=p2 lab=Q}
N 1620 380 1620 350 {}
C {sky130_fd_pr/pfet_01v8_hvt.sym} 1600 320 0 0 {name=M20
L=0.15
W=0.63
nf=1
mult=1
model=pfet_01v8_hvt
spiceprefix=X
}
N 1620 320 1720 320 {}
C {devices/lab_pin.sym} 1720 320 0 1 {name=l46 lab=VPB}
N 1620 290 1620 270 {}
C {devices/lab_pin.sym} 1620 270 0 1 {name=l47 lab=VPWR}
N 1620 460 1620 490 {}
C {sky130_fd_pr/nfet_01v8.sym} 1600 520 0 0 {name=M21
L=0.15
W=0.45
nf=1
mult=1
model=nfet_01v8
spiceprefix=X
}
N 1620 520 1720 520 {}
C {devices/lab_pin.sym} 1720 520 0 1 {name=l48 lab=VNB}
N 1620 550 1620 570 {}
C {devices/lab_pin.sym} 1620 570 0 1 {name=l49 lab=VGND}
N 1620 380 1620 420 {}
N 1620 420 1620 460 {}
N 1580 320 1540 320 {}
N 1540 320 1540 420 {}
N 1540 420 1540 520 {}
N 1540 520 1580 520 {}
N 1500 420 1540 420 {}
C {devices/ipin.sym} 1500 420 0 0 {name=p3 lab=CLK}
N 1620 420 1780 420 {}
N 1780 420 1780 450 {}
C {devices/lab_pin.sym} 1780 450 0 1 {name=l50 lab=CLK_N}
N 2000 380 2000 350 {}
C {sky130_fd_pr/pfet_01v8_hvt.sym} 1980 320 0 0 {name=M22
L=0.15
W=0.63
nf=1
mult=1
model=pfet_01v8_hvt
spiceprefix=X
}
N 2000 320 2100 320 {}
C {devices/lab_pin.sym} 2100 320 0 1 {name=l51 lab=VPB}
N 2000 290 2000 270 {}
C {devices/lab_pin.sym} 2000 270 0 1 {name=l52 lab=VPWR}
N 2000 460 2000 490 {}
C {sky130_fd_pr/nfet_01v8.sym} 1980 520 0 0 {name=M23
L=0.15
W=0.45
nf=1
mult=1
model=nfet_01v8
spiceprefix=X
}
N 2000 520 2100 520 {}
C {devices/lab_pin.sym} 2100 520 0 1 {name=l53 lab=VNB}
N 2000 550 2000 570 {}
C {devices/lab_pin.sym} 2000 570 0 1 {name=l54 lab=VGND}
N 2000 380 2000 420 {}
N 2000 420 2000 460 {}
N 1960 320 1920 320 {}
N 1920 320 1920 420 {}
N 1920 420 1920 520 {}
N 1920 520 1960 520 {}
N 1880 420 1920 420 {}
N 1780 420 1880 420 {}
N 2000 420 2160 420 {}
C {devices/lab_pin.sym} 2160 420 0 1 {name=l55 lab=CLK_P}
N 2480 380 2480 350 {}
C {sky130_fd_pr/pfet_01v8_hvt.sym} 2460 320 0 0 {name=M24
L=0.15
W=0.63
nf=1
mult=1
model=pfet_01v8_hvt
spiceprefix=X
}
N 2480 320 2580 320 {}
C {devices/lab_pin.sym} 2580 320 0 1 {name=l56 lab=VPB}
N 2480 290 2480 270 {}
C {devices/lab_pin.sym} 2480 270 0 1 {name=l57 lab=VPWR}
N 2480 460 2480 490 {}
C {sky130_fd_pr/nfet_01v8.sym} 2460 520 0 0 {name=M25
L=0.15
W=0.45
nf=1
mult=1
model=nfet_01v8
spiceprefix=X
}
N 2480 520 2580 520 {}
C {devices/lab_pin.sym} 2580 520 0 1 {name=l58 lab=VNB}
N 2480 550 2480 570 {}
C {devices/lab_pin.sym} 2480 570 0 1 {name=l59 lab=VGND}
N 2480 380 2480 420 {}
N 2480 420 2480 460 {}
N 2440 320 2400 320 {}
N 2400 320 2400 420 {}
N 2400 420 2400 520 {}
N 2400 520 2440 520 {}
N 2360 420 2400 420 {}
C {devices/lab_pin.sym} 2360 420 0 0 {name=l60 lab=S_N}
N 2780 380 2780 350 {}
C {sky130_fd_pr/pfet_01v8_hvt.sym} 2760 320 0 0 {name=M26
L=0.15
W=1.08
nf=1
mult=2
model=pfet_01v8_hvt
spiceprefix=X
}
N 2780 320 2880 320 {}
C {devices/lab_pin.sym} 2880 320 0 1 {name=l61 lab=VPB}
N 2780 290 2780 270 {}
C {devices/lab_pin.sym} 2780 270 0 1 {name=l62 lab=VPWR}
N 2780 460 2780 490 {}
C {sky130_fd_pr/nfet_01v8.sym} 2760 520 0 0 {name=M27
L=0.15
W=0.63
nf=1
mult=2
model=nfet_01v8
spiceprefix=X
}
N 2780 520 2880 520 {}
C {devices/lab_pin.sym} 2880 520 0 1 {name=l63 lab=VNB}
N 2780 550 2780 570 {}
C {devices/lab_pin.sym} 2780 570 0 1 {name=l64 lab=VGND}
N 2780 380 2780 420 {}
N 2780 420 2780 460 {}
N 2740 320 2700 320 {}
N 2700 320 2700 420 {}
N 2700 420 2700 520 {}
N 2700 520 2740 520 {}
N 2660 420 2700 420 {}
N 2480 420 2660 420 {}
N 2780 420 2940 420 {}
C {devices/opin.sym} 2940 420 0 0 {name=p4 lab=Q_N}
C {devices/iopin.sym} -40 -380 0 1 {name=p5 lab=VGND}
C {devices/iopin.sym} -40 -350 0 1 {name=p6 lab=VNB}
C {devices/iopin.sym} -40 -320 0 1 {name=p7 lab=VPB}
C {devices/iopin.sym} -40 -290 0 1 {name=p8 lab=VPWR}
C {title_efx.sym} 2150 770 0 0 {name=t1 author="ejfogleman"}
C {copyright.sym} 2150 840 0 0 {name=s1 place=header value="* Copyright (c) 2026 Eric Fogleman
* SPDX-License-Identifier: Apache-2.0
* Derived from SkyWater sky130_fd_sc_hd (Apache-2.0); see NOTICE"}
