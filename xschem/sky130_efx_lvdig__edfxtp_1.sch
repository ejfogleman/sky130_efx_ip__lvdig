v {xschem version=3.4.7 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
T {Schematic of sky130_efx_lvdig__edfxtp_1, from the PDK netlist of sky130_fd_sc_hd__edfxtp_1
(libs.ref/sky130_fd_sc_hd/spice/sky130_fd_sc_hd.spice)} -60 -600 0 0 0.3 0.3 {}
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
N 160 -200 180 -200 {}
C {devices/lab_pin.sym} 160 -200 0 0 {name=l2 lab=D}
N 220 -230 220 -250 {}
C {sky130_fd_pr/pfet_01v8_hvt.sym} 200 -280 0 0 {name=M1
L=0.15
W=0.63
nf=1
mult=1
model=pfet_01v8_hvt
spiceprefix=X
}
N 220 -280 320 -280 {}
C {devices/lab_pin.sym} 320 -280 0 1 {name=l3 lab=VPB}
N 160 -280 180 -280 {}
C {devices/lab_pin.sym} 160 -280 0 0 {name=l4 lab=DE_N}
N 220 -310 220 -340 {}
N 500 -140 500 -170 {}
C {sky130_fd_pr/pfet_01v8_hvt.sym} 480 -200 0 0 {name=M2
L=0.15
W=0.63
nf=1
mult=1
model=pfet_01v8_hvt
spiceprefix=X
}
N 500 -200 600 -200 {}
C {devices/lab_pin.sym} 600 -200 0 1 {name=l5 lab=VPB}
N 440 -200 460 -200 {}
C {devices/lab_pin.sym} 440 -200 0 0 {name=l6 lab=S_N}
N 500 -230 500 -250 {}
C {sky130_fd_pr/pfet_01v8_hvt.sym} 480 -280 0 0 {name=M3
L=0.15
W=0.63
nf=1
mult=1
model=pfet_01v8_hvt
spiceprefix=X
}
N 500 -280 600 -280 {}
C {devices/lab_pin.sym} 600 -280 0 1 {name=l7 lab=VPB}
N 440 -280 460 -280 {}
C {devices/lab_pin.sym} 440 -280 0 0 {name=l8 lab=DE}
N 500 -310 500 -340 {}
N 220 -140 500 -140 {}
N 220 -340 500 -340 {}
N 220 -340 220 -360 {}
C {devices/lab_pin.sym} 220 -360 0 1 {name=l9 lab=VPWR}
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
C {devices/lab_pin.sym} 160 0 0 0 {name=l11 lab=D}
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
C {devices/lab_pin.sym} 160 80 0 0 {name=l13 lab=DE}
N 220 110 220 140 {}
N 500 -60 500 -30 {}
C {sky130_fd_pr/nfet_01v8.sym} 480 0 0 0 {name=M6
L=0.15
W=0.45
nf=1
mult=1
model=nfet_01v8
spiceprefix=X
}
N 500 0 600 0 {}
C {devices/lab_pin.sym} 600 0 0 1 {name=l14 lab=VNB}
N 440 0 460 0 {}
C {devices/lab_pin.sym} 440 0 0 0 {name=l15 lab=S_N}
N 500 30 500 50 {}
C {sky130_fd_pr/nfet_01v8.sym} 480 80 0 0 {name=M7
L=0.15
W=0.45
nf=1
mult=1
model=nfet_01v8
spiceprefix=X
}
N 500 80 600 80 {}
C {devices/lab_pin.sym} 600 80 0 1 {name=l16 lab=VNB}
N 440 80 460 80 {}
C {devices/lab_pin.sym} 440 80 0 0 {name=l17 lab=DE_N}
N 500 110 500 140 {}
N 220 -60 500 -60 {}
N 220 140 500 140 {}
N 220 140 220 160 {}
C {devices/lab_pin.sym} 220 160 0 1 {name=l18 lab=VGND}
N 220 -140 220 -100 {}
N 220 -100 220 -60 {}
N 220 -100 660 -100 {}
N 660 -100 660 -70 {}
C {devices/lab_pin.sym} 660 -70 0 1 {name=l19 lab=DM_N}
C {sky130_fd_pr/nfet3_01v8.sym} 830 -210 1 0 {name=M8
L=0.15
W=0.36
body=VNB
nf=1
mult=1
model=special_nfet_01v8
spiceprefix=X
}
N 830 -230 830 -250 {}
C {devices/lab_pin.sym} 830 -250 0 1 {name=l20 lab=CLK_N}
C {sky130_fd_pr/pfet3_01v8_hvt.sym} 830 10 3 0 {name=M9
L=0.15
W=0.45
body=VPB
nf=1
mult=1
model=pfet_01v8_hvt
spiceprefix=X
}
N 830 30 830 50 {}
C {devices/lab_pin.sym} 830 50 0 1 {name=l21 lab=CLK_P}
N 800 -190 760 -190 {}
N 760 -190 760 -100 {}
N 800 -10 760 -10 {}
N 760 -10 760 -100 {}
N 860 -190 900 -190 {}
N 900 -190 900 -100 {}
N 860 -10 900 -10 {}
N 900 -10 900 -100 {}
N 660 -100 760 -100 {}
N 900 -100 960 -100 {}
N 220 470 220 440 {}
C {sky130_fd_pr/pfet_01v8_hvt.sym} 200 410 0 0 {name=M10
L=0.15
W=0.45
nf=1
mult=1
model=pfet_01v8_hvt
spiceprefix=X
}
N 220 410 320 410 {}
C {devices/lab_pin.sym} 320 410 0 1 {name=l22 lab=VPB}
N 160 410 180 410 {}
C {devices/lab_pin.sym} 160 410 0 0 {name=l23 lab=CLK_N}
N 220 380 220 360 {}
C {sky130_fd_pr/pfet_01v8_hvt.sym} 200 330 0 0 {name=M11
L=0.15
W=0.45
nf=1
mult=1
model=pfet_01v8_hvt
spiceprefix=X
}
N 220 330 320 330 {}
C {devices/lab_pin.sym} 320 330 0 1 {name=l24 lab=VPB}
N 160 330 180 330 {}
C {devices/lab_pin.sym} 160 330 0 0 {name=l25 lab=M}
N 220 300 220 280 {}
C {devices/lab_pin.sym} 220 280 0 1 {name=l26 lab=VPWR}
N 220 550 220 580 {}
C {sky130_fd_pr/nfet_01v8.sym} 200 610 0 0 {name=M12
L=0.15
W=0.36
nf=1
mult=1
model=special_nfet_01v8
spiceprefix=X
}
N 220 610 320 610 {}
C {devices/lab_pin.sym} 320 610 0 1 {name=l27 lab=VNB}
N 160 610 180 610 {}
C {devices/lab_pin.sym} 160 610 0 0 {name=l28 lab=CLK_P}
N 220 640 220 660 {}
C {sky130_fd_pr/nfet_01v8.sym} 200 690 0 0 {name=M13
L=0.15
W=0.45
nf=1
mult=1
model=nfet_01v8
spiceprefix=X
}
N 220 690 320 690 {}
C {devices/lab_pin.sym} 320 690 0 1 {name=l29 lab=VNB}
N 160 690 180 690 {}
C {devices/lab_pin.sym} 160 690 0 0 {name=l30 lab=M}
N 220 720 220 740 {}
C {devices/lab_pin.sym} 220 740 0 1 {name=l31 lab=VGND}
N 220 470 220 510 {}
N 220 510 220 550 {}
N 220 510 960 510 {}
N 960 510 960 245 {}
N 960 245 960 -100 {}
C {devices/lab_pin.sym} 960 245 0 1 {name=l32 lab=M_N}
N 1180 -140 1180 -170 {}
C {sky130_fd_pr/pfet_01v8_hvt.sym} 1160 -200 0 0 {name=M14
L=0.15
W=0.72
nf=1
mult=1
model=pfet_01v8_hvt
spiceprefix=X
}
N 1180 -200 1280 -200 {}
C {devices/lab_pin.sym} 1280 -200 0 1 {name=l33 lab=VPB}
N 1180 -230 1180 -250 {}
C {devices/lab_pin.sym} 1180 -250 0 1 {name=l34 lab=VPWR}
N 1180 -60 1180 -30 {}
C {sky130_fd_pr/nfet_01v8.sym} 1160 0 0 0 {name=M15
L=0.15
W=0.63
nf=1
mult=1
model=nfet_01v8
spiceprefix=X
}
N 1180 0 1280 0 {}
C {devices/lab_pin.sym} 1280 0 0 1 {name=l35 lab=VNB}
N 1180 30 1180 50 {}
C {devices/lab_pin.sym} 1180 50 0 1 {name=l36 lab=VGND}
N 1180 -140 1180 -100 {}
N 1180 -100 1180 -60 {}
N 1140 -200 1100 -200 {}
N 1100 -200 1100 -100 {}
N 1100 -100 1100 0 {}
N 1100 0 1140 0 {}
N 1060 -100 1100 -100 {}
N 960 -100 1060 -100 {}
N 1180 -100 1340 -100 {}
N 1340 -100 1340 -70 {}
C {devices/lab_pin.sym} 1340 -70 0 1 {name=l37 lab=M}
N 1560 -140 1560 -170 {}
C {sky130_fd_pr/pfet_01v8_hvt.sym} 1540 -200 0 0 {name=M16
L=0.15
W=0.45
nf=1
mult=1
model=pfet_01v8_hvt
spiceprefix=X
}
N 1560 -200 1660 -200 {}
C {devices/lab_pin.sym} 1660 -200 0 1 {name=l38 lab=VPB}
N 1500 -200 1520 -200 {}
C {devices/lab_pin.sym} 1500 -200 0 0 {name=l39 lab=CLK_N}
N 1560 -230 1560 -250 {}
C {sky130_fd_pr/pfet_01v8_hvt.sym} 1540 -280 0 0 {name=M17
L=0.15
W=0.45
nf=1
mult=1
model=pfet_01v8_hvt
spiceprefix=X
}
N 1560 -280 1660 -280 {}
C {devices/lab_pin.sym} 1660 -280 0 1 {name=l40 lab=VPB}
N 1500 -280 1520 -280 {}
C {devices/lab_pin.sym} 1500 -280 0 0 {name=l41 lab=M}
N 1560 -310 1560 -330 {}
C {devices/lab_pin.sym} 1560 -330 0 1 {name=l42 lab=VPWR}
N 1560 -60 1560 -30 {}
C {sky130_fd_pr/nfet_01v8.sym} 1540 0 0 0 {name=M18
L=0.15
W=0.36
nf=1
mult=1
model=special_nfet_01v8
spiceprefix=X
}
N 1560 0 1660 0 {}
C {devices/lab_pin.sym} 1660 0 0 1 {name=l43 lab=VNB}
N 1500 0 1520 0 {}
C {devices/lab_pin.sym} 1500 0 0 0 {name=l44 lab=CLK_P}
N 1560 30 1560 50 {}
C {sky130_fd_pr/nfet_01v8.sym} 1540 80 0 0 {name=M19
L=0.15
W=0.45
nf=1
mult=1
model=nfet_01v8
spiceprefix=X
}
N 1560 80 1660 80 {}
C {devices/lab_pin.sym} 1660 80 0 1 {name=l45 lab=VNB}
N 1500 80 1520 80 {}
C {devices/lab_pin.sym} 1500 80 0 0 {name=l46 lab=M}
N 1560 110 1560 130 {}
C {devices/lab_pin.sym} 1560 130 0 1 {name=l47 lab=VGND}
N 1560 -140 1560 -100 {}
N 1560 -100 1560 -60 {}
N 1560 -100 1720 -100 {}
N 1160 470 1160 440 {}
C {sky130_fd_pr/pfet_01v8_hvt.sym} 1140 410 0 0 {name=M20
L=0.15
W=0.45
nf=1
mult=1
model=pfet_01v8_hvt
spiceprefix=X
}
N 1160 410 1260 410 {}
C {devices/lab_pin.sym} 1260 410 0 1 {name=l48 lab=VPB}
N 1100 410 1120 410 {}
C {devices/lab_pin.sym} 1100 410 0 0 {name=l49 lab=CLK_P}
N 1160 380 1160 360 {}
C {sky130_fd_pr/pfet_01v8_hvt.sym} 1140 330 0 0 {name=M21
L=0.15
W=0.45
nf=1
mult=1
model=pfet_01v8_hvt
spiceprefix=X
}
N 1160 330 1260 330 {}
C {devices/lab_pin.sym} 1260 330 0 1 {name=l50 lab=VPB}
N 1100 330 1120 330 {}
C {devices/lab_pin.sym} 1100 330 0 0 {name=l51 lab=S_N}
N 1160 300 1160 280 {}
C {devices/lab_pin.sym} 1160 280 0 1 {name=l52 lab=VPWR}
N 1160 550 1160 580 {}
C {sky130_fd_pr/nfet_01v8.sym} 1140 610 0 0 {name=M22
L=0.15
W=0.36
nf=1
mult=1
model=special_nfet_01v8
spiceprefix=X
}
N 1160 610 1260 610 {}
C {devices/lab_pin.sym} 1260 610 0 1 {name=l53 lab=VNB}
N 1100 610 1120 610 {}
C {devices/lab_pin.sym} 1100 610 0 0 {name=l54 lab=CLK_N}
N 1160 640 1160 660 {}
C {sky130_fd_pr/nfet_01v8.sym} 1140 690 0 0 {name=M23
L=0.15
W=0.45
nf=1
mult=1
model=nfet_01v8
spiceprefix=X
}
N 1160 690 1260 690 {}
C {devices/lab_pin.sym} 1260 690 0 1 {name=l55 lab=VNB}
N 1100 690 1120 690 {}
C {devices/lab_pin.sym} 1100 690 0 0 {name=l56 lab=S_N}
N 1160 720 1160 740 {}
C {devices/lab_pin.sym} 1160 740 0 1 {name=l57 lab=VGND}
N 1160 470 1160 510 {}
N 1160 510 1160 550 {}
N 1160 510 1720 510 {}
N 1720 510 1720 245 {}
N 1720 245 1720 -100 {}
C {devices/lab_pin.sym} 1720 245 0 1 {name=l58 lab=S}
N 1940 -140 1940 -170 {}
C {sky130_fd_pr/pfet_01v8_hvt.sym} 1920 -200 0 0 {name=M24
L=0.15
W=1.08
nf=1
mult=1
model=pfet_01v8_hvt
spiceprefix=X
}
N 1940 -200 2040 -200 {}
C {devices/lab_pin.sym} 2040 -200 0 1 {name=l59 lab=VPB}
N 1940 -230 1940 -250 {}
C {devices/lab_pin.sym} 1940 -250 0 1 {name=l60 lab=VPWR}
N 1940 -60 1940 -30 {}
C {sky130_fd_pr/nfet_01v8.sym} 1920 0 0 0 {name=M25
L=0.15
W=0.63
nf=1
mult=1
model=nfet_01v8
spiceprefix=X
}
N 1940 0 2040 0 {}
C {devices/lab_pin.sym} 2040 0 0 1 {name=l61 lab=VNB}
N 1940 30 1940 50 {}
C {devices/lab_pin.sym} 1940 50 0 1 {name=l62 lab=VGND}
N 1940 -140 1940 -100 {}
N 1940 -100 1940 -60 {}
N 1900 -200 1860 -200 {}
N 1860 -200 1860 -100 {}
N 1860 -100 1860 0 {}
N 1860 0 1900 0 {}
N 1820 -100 1860 -100 {}
N 1720 -100 1820 -100 {}
N 1940 -100 2100 -100 {}
C {devices/opin.sym} 2100 -100 0 0 {name=p1 lab=Q}
N 1980 470 1980 440 {}
C {sky130_fd_pr/pfet_01v8_hvt.sym} 1960 410 0 0 {name=M26
L=0.15
W=0.63
nf=1
mult=1
model=pfet_01v8_hvt
spiceprefix=X
}
N 1980 410 2080 410 {}
C {devices/lab_pin.sym} 2080 410 0 1 {name=l63 lab=VPB}
N 1980 380 1980 360 {}
C {devices/lab_pin.sym} 1980 360 0 1 {name=l64 lab=VPWR}
N 1980 550 1980 580 {}
C {sky130_fd_pr/nfet_01v8.sym} 1960 610 0 0 {name=M27
L=0.15
W=0.45
nf=1
mult=1
model=nfet_01v8
spiceprefix=X
}
N 1980 610 2080 610 {}
C {devices/lab_pin.sym} 2080 610 0 1 {name=l65 lab=VNB}
N 1980 640 1980 660 {}
C {devices/lab_pin.sym} 1980 660 0 1 {name=l66 lab=VGND}
N 1980 470 1980 510 {}
N 1980 510 1980 550 {}
N 1940 410 1900 410 {}
N 1900 410 1900 510 {}
N 1900 510 1900 610 {}
N 1900 610 1940 610 {}
N 1860 510 1900 510 {}
C {devices/ipin.sym} 1860 510 0 0 {name=p2 lab=CLK}
N 1980 510 2140 510 {}
N 2140 510 2140 540 {}
C {devices/lab_pin.sym} 2140 540 0 1 {name=l67 lab=CLK_N}
N 2360 470 2360 440 {}
C {sky130_fd_pr/pfet_01v8_hvt.sym} 2340 410 0 0 {name=M28
L=0.15
W=0.63
nf=1
mult=1
model=pfet_01v8_hvt
spiceprefix=X
}
N 2360 410 2460 410 {}
C {devices/lab_pin.sym} 2460 410 0 1 {name=l68 lab=VPB}
N 2360 380 2360 360 {}
C {devices/lab_pin.sym} 2360 360 0 1 {name=l69 lab=VPWR}
N 2360 550 2360 580 {}
C {sky130_fd_pr/nfet_01v8.sym} 2340 610 0 0 {name=M29
L=0.15
W=0.45
nf=1
mult=1
model=nfet_01v8
spiceprefix=X
}
N 2360 610 2460 610 {}
C {devices/lab_pin.sym} 2460 610 0 1 {name=l70 lab=VNB}
N 2360 640 2360 660 {}
C {devices/lab_pin.sym} 2360 660 0 1 {name=l71 lab=VGND}
N 2360 470 2360 510 {}
N 2360 510 2360 550 {}
N 2320 410 2280 410 {}
N 2280 410 2280 510 {}
N 2280 510 2280 610 {}
N 2280 610 2320 610 {}
N 2240 510 2280 510 {}
N 2140 510 2240 510 {}
N 2360 510 2520 510 {}
C {devices/lab_pin.sym} 2520 510 0 1 {name=l72 lab=CLK_P}
N 2840 470 2840 440 {}
C {sky130_fd_pr/pfet_01v8_hvt.sym} 2820 410 0 0 {name=M30
L=0.15
W=0.63
nf=1
mult=1
model=pfet_01v8_hvt
spiceprefix=X
}
N 2840 410 2940 410 {}
C {devices/lab_pin.sym} 2940 410 0 1 {name=l73 lab=VPB}
N 2840 380 2840 360 {}
C {devices/lab_pin.sym} 2840 360 0 1 {name=l74 lab=VPWR}
N 2840 550 2840 580 {}
C {sky130_fd_pr/nfet_01v8.sym} 2820 610 0 0 {name=M31
L=0.15
W=0.45
nf=1
mult=1
model=nfet_01v8
spiceprefix=X
}
N 2840 610 2940 610 {}
C {devices/lab_pin.sym} 2940 610 0 1 {name=l75 lab=VNB}
N 2840 640 2840 660 {}
C {devices/lab_pin.sym} 2840 660 0 1 {name=l76 lab=VGND}
N 2840 470 2840 510 {}
N 2840 510 2840 550 {}
N 2800 410 2760 410 {}
N 2760 410 2760 510 {}
N 2760 510 2760 610 {}
N 2760 610 2800 610 {}
N 2720 510 2760 510 {}
C {devices/ipin.sym} 2720 510 0 0 {name=p3 lab=DE}
N 2840 510 3000 510 {}
C {devices/lab_pin.sym} 3000 510 0 1 {name=l77 lab=DE_N}
N 3320 470 3320 440 {}
C {sky130_fd_pr/pfet_01v8_hvt.sym} 3300 410 0 0 {name=M32
L=0.15
W=0.63
nf=1
mult=1
model=pfet_01v8_hvt
spiceprefix=X
}
N 3320 410 3420 410 {}
C {devices/lab_pin.sym} 3420 410 0 1 {name=l78 lab=VPB}
N 3320 380 3320 360 {}
C {devices/lab_pin.sym} 3320 360 0 1 {name=l79 lab=VPWR}
N 3320 550 3320 580 {}
C {sky130_fd_pr/nfet_01v8.sym} 3300 610 0 0 {name=M33
L=0.15
W=0.45
nf=1
mult=1
model=nfet_01v8
spiceprefix=X
}
N 3320 610 3420 610 {}
C {devices/lab_pin.sym} 3420 610 0 1 {name=l80 lab=VNB}
N 3320 640 3320 660 {}
C {devices/lab_pin.sym} 3320 660 0 1 {name=l81 lab=VGND}
N 3320 470 3320 510 {}
N 3320 510 3320 550 {}
N 3280 410 3240 410 {}
N 3240 410 3240 510 {}
N 3240 510 3240 610 {}
N 3240 610 3280 610 {}
N 3200 510 3240 510 {}
C {devices/lab_pin.sym} 3200 510 0 0 {name=l82 lab=S}
N 3320 510 3480 510 {}
C {devices/lab_pin.sym} 3480 510 0 1 {name=l83 lab=S_N}
C {devices/ipin.sym} -40 -520 0 0 {name=p4 lab=D}
C {devices/iopin.sym} -40 -490 0 1 {name=p5 lab=VGND}
C {devices/iopin.sym} -40 -460 0 1 {name=p6 lab=VNB}
C {devices/iopin.sym} -40 -430 0 1 {name=p7 lab=VPB}
C {devices/iopin.sym} -40 -400 0 1 {name=p8 lab=VPWR}
C {title_efx.sym} 2690 860 0 0 {name=t1 author="ejfogleman"}
C {copyright.sym} 2690 930 0 0 {name=s1 place=header value="* Copyright (c) 2026 Eric Fogleman
* SPDX-License-Identifier: Apache-2.0
* Derived from SkyWater sky130_fd_sc_hd (Apache-2.0); see NOTICE"}
