v {xschem version=3.4.7 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
T {Schematic of sky130_efx_lvdig__dfrbp_1, from the PDK netlist of sky130_fd_sc_hd__dfrbp_1
(libs.ref/sky130_fd_sc_hd/spice/sky130_fd_sc_hd.spice)} -60 -520 0 0 0.3 0.3 {}
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
N 220 500 220 470 {}
C {sky130_fd_pr/pfet_01v8_hvt.sym} 200 440 0 0 {name=M4
L=0.15
W=0.45
nf=1
mult=1
model=pfet_01v8_hvt
spiceprefix=X
}
N 220 440 320 440 {}
C {devices/lab_pin.sym} 320 440 0 1 {name=l8 lab=VPB}
N 160 440 180 440 {}
C {devices/lab_pin.sym} 160 440 0 0 {name=l9 lab=CLK_N}
N 220 410 220 390 {}
N 220 390 220 360 {}
C {sky130_fd_pr/pfet_01v8_hvt.sym} 200 330 0 0 {name=M5
L=0.15
W=0.45
nf=1
mult=1
model=pfet_01v8_hvt
spiceprefix=X
}
N 220 330 320 330 {}
C {devices/lab_pin.sym} 320 330 0 1 {name=l10 lab=VPB}
N 160 330 180 330 {}
C {devices/lab_pin.sym} 160 330 0 0 {name=l11 lab=RESET_B}
N 220 300 220 270 {}
N 500 390 500 360 {}
C {sky130_fd_pr/pfet_01v8_hvt.sym} 480 330 0 0 {name=M6
L=0.15
W=0.45
nf=1
mult=1
model=pfet_01v8_hvt
spiceprefix=X
}
N 500 330 600 330 {}
C {devices/lab_pin.sym} 600 330 0 1 {name=l12 lab=VPB}
N 440 330 460 330 {}
C {devices/lab_pin.sym} 440 330 0 0 {name=l13 lab=M}
N 500 300 500 270 {}
N 220 390 500 390 {}
N 220 270 500 270 {}
N 220 270 220 250 {}
C {devices/lab_pin.sym} 220 250 0 1 {name=l14 lab=VPWR}
N 220 580 220 610 {}
C {sky130_fd_pr/nfet_01v8.sym} 200 640 0 0 {name=M7
L=0.15
W=0.36
nf=1
mult=1
model=special_nfet_01v8
spiceprefix=X
}
N 220 640 320 640 {}
C {devices/lab_pin.sym} 320 640 0 1 {name=l15 lab=VNB}
N 160 640 180 640 {}
C {devices/lab_pin.sym} 160 640 0 0 {name=l16 lab=CLK_P}
N 220 670 220 690 {}
C {sky130_fd_pr/nfet_01v8.sym} 200 720 0 0 {name=M8
L=0.15
W=0.45
nf=1
mult=1
model=nfet_01v8
spiceprefix=X
}
N 220 720 320 720 {}
C {devices/lab_pin.sym} 320 720 0 1 {name=l17 lab=VNB}
N 160 720 180 720 {}
C {devices/lab_pin.sym} 160 720 0 0 {name=l18 lab=M}
N 220 750 220 770 {}
C {sky130_fd_pr/nfet_01v8.sym} 200 800 0 0 {name=M9
L=0.15
W=0.45
nf=1
mult=1
model=nfet_01v8
spiceprefix=X
}
N 220 800 320 800 {}
C {devices/lab_pin.sym} 320 800 0 1 {name=l19 lab=VNB}
N 160 800 180 800 {}
C {devices/lab_pin.sym} 160 800 0 0 {name=l20 lab=RESET_B}
N 220 830 220 850 {}
C {devices/lab_pin.sym} 220 850 0 1 {name=l21 lab=VGND}
N 220 500 220 540 {}
N 220 540 220 580 {}
N 220 540 680 540 {}
N 680 540 680 260 {}
N 680 260 680 -100 {}
C {devices/lab_pin.sym} 680 260 0 1 {name=l22 lab=M_N}
N 900 -140 900 -170 {}
C {sky130_fd_pr/pfet_01v8_hvt.sym} 880 -200 0 0 {name=M10
L=0.15
W=0.81
nf=1
mult=1
model=pfet_01v8_hvt
spiceprefix=X
}
N 900 -200 1000 -200 {}
C {devices/lab_pin.sym} 1000 -200 0 1 {name=l23 lab=VPB}
N 900 -230 900 -250 {}
C {devices/lab_pin.sym} 900 -250 0 1 {name=l24 lab=VPWR}
N 900 -60 900 -30 {}
C {sky130_fd_pr/nfet_01v8.sym} 880 0 0 0 {name=M11
L=0.15
W=0.63
nf=1
mult=1
model=nfet_01v8
spiceprefix=X
}
N 900 0 1000 0 {}
C {devices/lab_pin.sym} 1000 0 0 1 {name=l25 lab=VNB}
N 900 30 900 50 {}
C {devices/lab_pin.sym} 900 50 0 1 {name=l26 lab=VGND}
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
C {devices/lab_pin.sym} 1060 -70 0 1 {name=l27 lab=M}
C {sky130_fd_pr/nfet3_01v8.sym} 1230 -210 1 0 {name=M12
L=0.15
W=0.36
body=VNB
nf=1
mult=1
model=special_nfet_01v8
spiceprefix=X
}
N 1230 -230 1230 -250 {}
C {devices/lab_pin.sym} 1230 -250 0 1 {name=l28 lab=CLK_P}
C {sky130_fd_pr/pfet3_01v8_hvt.sym} 1230 10 3 0 {name=M13
L=0.15
W=0.45
body=VPB
nf=1
mult=1
model=pfet_01v8_hvt
spiceprefix=X
}
N 1230 30 1230 50 {}
C {devices/lab_pin.sym} 1230 50 0 1 {name=l29 lab=CLK_N}
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
N 880 500 880 470 {}
C {sky130_fd_pr/pfet_01v8_hvt.sym} 860 440 0 0 {name=M14
L=0.15
W=0.45
nf=1
mult=1
model=pfet_01v8_hvt
spiceprefix=X
}
N 880 440 980 440 {}
C {devices/lab_pin.sym} 980 440 0 1 {name=l30 lab=VPB}
N 820 440 840 440 {}
C {devices/lab_pin.sym} 820 440 0 0 {name=l31 lab=CLK_P}
N 880 410 880 390 {}
C {sky130_fd_pr/pfet_01v8_hvt.sym} 860 360 0 0 {name=M15
L=0.15
W=0.45
nf=1
mult=1
model=pfet_01v8_hvt
spiceprefix=X
}
N 880 360 980 360 {}
C {devices/lab_pin.sym} 980 360 0 1 {name=l32 lab=VPB}
N 820 360 840 360 {}
C {devices/lab_pin.sym} 820 360 0 0 {name=l33 lab=S_N}
N 880 330 880 310 {}
C {devices/lab_pin.sym} 880 310 0 1 {name=l34 lab=VPWR}
N 880 580 880 610 {}
C {sky130_fd_pr/nfet_01v8.sym} 860 640 0 0 {name=M16
L=0.15
W=0.36
nf=1
mult=1
model=special_nfet_01v8
spiceprefix=X
}
N 880 640 980 640 {}
C {devices/lab_pin.sym} 980 640 0 1 {name=l35 lab=VNB}
N 820 640 840 640 {}
C {devices/lab_pin.sym} 820 640 0 0 {name=l36 lab=CLK_N}
N 880 670 880 690 {}
C {sky130_fd_pr/nfet_01v8.sym} 860 720 0 0 {name=M17
L=0.15
W=0.45
nf=1
mult=1
model=nfet_01v8
spiceprefix=X
}
N 880 720 980 720 {}
C {devices/lab_pin.sym} 980 720 0 1 {name=l37 lab=VNB}
N 820 720 840 720 {}
C {devices/lab_pin.sym} 820 720 0 0 {name=l38 lab=S_N}
N 880 750 880 770 {}
C {devices/lab_pin.sym} 880 770 0 1 {name=l39 lab=VGND}
N 880 500 880 540 {}
N 880 540 880 580 {}
N 880 540 1360 540 {}
N 1360 540 1360 260 {}
N 1360 260 1360 -100 {}
C {devices/lab_pin.sym} 1360 260 0 1 {name=l40 lab=S}
N 1580 -140 1580 -170 {}
C {sky130_fd_pr/pfet_01v8_hvt.sym} 1560 -200 0 0 {name=M18
L=0.15
W=0.45
nf=1
mult=1
model=pfet_01v8_hvt
spiceprefix=X
}
N 1580 -200 1680 -200 {}
C {devices/lab_pin.sym} 1680 -200 0 1 {name=l41 lab=VPB}
N 1520 -200 1540 -200 {}
C {devices/lab_pin.sym} 1520 -200 0 0 {name=l42 lab=S}
N 1580 -230 1580 -260 {}
N 1860 -140 1860 -170 {}
C {sky130_fd_pr/pfet_01v8_hvt.sym} 1840 -200 0 0 {name=M19
L=0.15
W=0.45
nf=1
mult=1
model=pfet_01v8_hvt
spiceprefix=X
}
N 1860 -200 1960 -200 {}
C {devices/lab_pin.sym} 1960 -200 0 1 {name=l43 lab=VPB}
N 1800 -200 1820 -200 {}
C {devices/lab_pin.sym} 1800 -200 0 0 {name=l44 lab=RESET_B}
N 1860 -230 1860 -260 {}
N 1580 -140 1860 -140 {}
N 1580 -260 1860 -260 {}
N 1580 -260 1580 -280 {}
C {devices/lab_pin.sym} 1580 -280 0 1 {name=l45 lab=VPWR}
N 1580 -60 1580 -30 {}
C {sky130_fd_pr/nfet_01v8.sym} 1560 0 0 0 {name=M20
L=0.15
W=0.45
nf=1
mult=1
model=nfet_01v8
spiceprefix=X
}
N 1580 0 1680 0 {}
C {devices/lab_pin.sym} 1680 0 0 1 {name=l46 lab=VNB}
N 1520 0 1540 0 {}
C {devices/lab_pin.sym} 1520 0 0 0 {name=l47 lab=S}
N 1580 30 1580 50 {}
C {sky130_fd_pr/nfet_01v8.sym} 1560 80 0 0 {name=M21
L=0.15
W=0.45
nf=1
mult=1
model=nfet_01v8
spiceprefix=X
}
N 1580 80 1680 80 {}
C {devices/lab_pin.sym} 1680 80 0 1 {name=l48 lab=VNB}
N 1520 80 1540 80 {}
C {devices/lab_pin.sym} 1520 80 0 0 {name=l49 lab=RESET_B}
N 1580 110 1580 130 {}
C {devices/lab_pin.sym} 1580 130 0 1 {name=l50 lab=VGND}
N 1580 -140 1580 -100 {}
N 1580 -100 1580 -60 {}
N 1580 -100 2020 -100 {}
N 2020 -100 2020 -70 {}
C {devices/lab_pin.sym} 2020 -70 0 1 {name=l51 lab=S_N}
N 2240 -140 2240 -170 {}
C {sky130_fd_pr/pfet_01v8_hvt.sym} 2220 -200 0 0 {name=M22
L=0.15
W=1.08
nf=1
mult=1
model=pfet_01v8_hvt
spiceprefix=X
}
N 2240 -200 2340 -200 {}
C {devices/lab_pin.sym} 2340 -200 0 1 {name=l52 lab=VPB}
N 2240 -230 2240 -250 {}
C {devices/lab_pin.sym} 2240 -250 0 1 {name=l53 lab=VPWR}
N 2240 -60 2240 -30 {}
C {sky130_fd_pr/nfet_01v8.sym} 2220 0 0 0 {name=M23
L=0.15
W=0.63
nf=1
mult=1
model=nfet_01v8
spiceprefix=X
}
N 2240 0 2340 0 {}
C {devices/lab_pin.sym} 2340 0 0 1 {name=l54 lab=VNB}
N 2240 30 2240 50 {}
C {devices/lab_pin.sym} 2240 50 0 1 {name=l55 lab=VGND}
N 2240 -140 2240 -100 {}
N 2240 -100 2240 -60 {}
N 2200 -200 2160 -200 {}
N 2160 -200 2160 -100 {}
N 2160 -100 2160 0 {}
N 2160 0 2200 0 {}
N 2120 -100 2160 -100 {}
N 2020 -100 2120 -100 {}
N 2240 -100 2400 -100 {}
C {devices/opin.sym} 2400 -100 0 0 {name=p2 lab=Q}
N 1620 500 1620 470 {}
C {sky130_fd_pr/pfet_01v8_hvt.sym} 1600 440 0 0 {name=M24
L=0.15
W=0.63
nf=1
mult=1
model=pfet_01v8_hvt
spiceprefix=X
}
N 1620 440 1720 440 {}
C {devices/lab_pin.sym} 1720 440 0 1 {name=l56 lab=VPB}
N 1620 410 1620 390 {}
C {devices/lab_pin.sym} 1620 390 0 1 {name=l57 lab=VPWR}
N 1620 580 1620 610 {}
C {sky130_fd_pr/nfet_01v8.sym} 1600 640 0 0 {name=M25
L=0.15
W=0.45
nf=1
mult=1
model=nfet_01v8
spiceprefix=X
}
N 1620 640 1720 640 {}
C {devices/lab_pin.sym} 1720 640 0 1 {name=l58 lab=VNB}
N 1620 670 1620 690 {}
C {devices/lab_pin.sym} 1620 690 0 1 {name=l59 lab=VGND}
N 1620 500 1620 540 {}
N 1620 540 1620 580 {}
N 1580 440 1540 440 {}
N 1540 440 1540 540 {}
N 1540 540 1540 640 {}
N 1540 640 1580 640 {}
N 1500 540 1540 540 {}
C {devices/ipin.sym} 1500 540 0 0 {name=p3 lab=CLK}
N 1620 540 1780 540 {}
N 1780 540 1780 570 {}
C {devices/lab_pin.sym} 1780 570 0 1 {name=l60 lab=CLK_N}
N 2000 500 2000 470 {}
C {sky130_fd_pr/pfet_01v8_hvt.sym} 1980 440 0 0 {name=M26
L=0.15
W=0.63
nf=1
mult=1
model=pfet_01v8_hvt
spiceprefix=X
}
N 2000 440 2100 440 {}
C {devices/lab_pin.sym} 2100 440 0 1 {name=l61 lab=VPB}
N 2000 410 2000 390 {}
C {devices/lab_pin.sym} 2000 390 0 1 {name=l62 lab=VPWR}
N 2000 580 2000 610 {}
C {sky130_fd_pr/nfet_01v8.sym} 1980 640 0 0 {name=M27
L=0.15
W=0.45
nf=1
mult=1
model=nfet_01v8
spiceprefix=X
}
N 2000 640 2100 640 {}
C {devices/lab_pin.sym} 2100 640 0 1 {name=l63 lab=VNB}
N 2000 670 2000 690 {}
C {devices/lab_pin.sym} 2000 690 0 1 {name=l64 lab=VGND}
N 2000 500 2000 540 {}
N 2000 540 2000 580 {}
N 1960 440 1920 440 {}
N 1920 440 1920 540 {}
N 1920 540 1920 640 {}
N 1920 640 1960 640 {}
N 1880 540 1920 540 {}
N 1780 540 1880 540 {}
N 2000 540 2160 540 {}
C {devices/lab_pin.sym} 2160 540 0 1 {name=l65 lab=CLK_P}
N 2480 500 2480 470 {}
C {sky130_fd_pr/pfet_01v8_hvt.sym} 2460 440 0 0 {name=M28
L=0.15
W=0.63
nf=1
mult=1
model=pfet_01v8_hvt
spiceprefix=X
}
N 2480 440 2580 440 {}
C {devices/lab_pin.sym} 2580 440 0 1 {name=l66 lab=VPB}
N 2480 410 2480 390 {}
C {devices/lab_pin.sym} 2480 390 0 1 {name=l67 lab=VPWR}
N 2480 580 2480 610 {}
C {sky130_fd_pr/nfet_01v8.sym} 2460 640 0 0 {name=M29
L=0.15
W=0.45
nf=1
mult=1
model=nfet_01v8
spiceprefix=X
}
N 2480 640 2580 640 {}
C {devices/lab_pin.sym} 2580 640 0 1 {name=l68 lab=VNB}
N 2480 670 2480 690 {}
C {devices/lab_pin.sym} 2480 690 0 1 {name=l69 lab=VGND}
N 2480 500 2480 540 {}
N 2480 540 2480 580 {}
N 2440 440 2400 440 {}
N 2400 440 2400 540 {}
N 2400 540 2400 640 {}
N 2400 640 2440 640 {}
N 2360 540 2400 540 {}
C {devices/lab_pin.sym} 2360 540 0 0 {name=l70 lab=S_N}
N 2780 500 2780 470 {}
C {sky130_fd_pr/pfet_01v8_hvt.sym} 2760 440 0 0 {name=M30
L=0.15
W=1.08
nf=1
mult=1
model=pfet_01v8_hvt
spiceprefix=X
}
N 2780 440 2880 440 {}
C {devices/lab_pin.sym} 2880 440 0 1 {name=l71 lab=VPB}
N 2780 410 2780 390 {}
C {devices/lab_pin.sym} 2780 390 0 1 {name=l72 lab=VPWR}
N 2780 580 2780 610 {}
C {sky130_fd_pr/nfet_01v8.sym} 2760 640 0 0 {name=M31
L=0.15
W=0.63
nf=1
mult=1
model=nfet_01v8
spiceprefix=X
}
N 2780 640 2880 640 {}
C {devices/lab_pin.sym} 2880 640 0 1 {name=l73 lab=VNB}
N 2780 670 2780 690 {}
C {devices/lab_pin.sym} 2780 690 0 1 {name=l74 lab=VGND}
N 2780 500 2780 540 {}
N 2780 540 2780 580 {}
N 2740 440 2700 440 {}
N 2700 440 2700 540 {}
N 2700 540 2700 640 {}
N 2700 640 2740 640 {}
N 2660 540 2700 540 {}
N 2480 540 2660 540 {}
N 2780 540 2940 540 {}
C {devices/opin.sym} 2940 540 0 0 {name=p4 lab=Q_N}
C {devices/ipin.sym} -40 -440 0 0 {name=p5 lab=RESET_B}
C {devices/iopin.sym} -40 -410 0 1 {name=p6 lab=VGND}
C {devices/iopin.sym} -40 -380 0 1 {name=p7 lab=VNB}
C {devices/iopin.sym} -40 -350 0 1 {name=p8 lab=VPB}
C {devices/iopin.sym} -40 -320 0 1 {name=p9 lab=VPWR}
C {title_efx.sym} 2150 970 0 0 {name=t1 author="ejfogleman"}
C {copyright.sym} 2150 1040 0 0 {name=s1 place=header value="* Copyright (c) 2026 Eric Fogleman
* SPDX-License-Identifier: Apache-2.0
* Derived from SkyWater sky130_fd_sc_hd (Apache-2.0); see NOTICE"}
