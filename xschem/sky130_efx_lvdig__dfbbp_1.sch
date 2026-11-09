v {xschem version=3.4.7 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
T {Schematic of sky130_efx_lvdig__dfbbp_1, from the PDK netlist of sky130_fd_sc_hd__dfbbp_1
(libs.ref/sky130_fd_sc_hd/spice/sky130_fd_sc_hd.spice)} -60 -600 0 0 0.3 0.3 {}
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
C {sky130_fd_pr/pfet_01v8_hvt.sym} 200 360 0 0 {name=M5
L=0.15
W=0.45
nf=1
mult=1
model=pfet_01v8_hvt
spiceprefix=X
}
N 220 360 320 360 {}
C {devices/lab_pin.sym} 320 360 0 1 {name=l10 lab=VPB}
N 160 360 180 360 {}
C {devices/lab_pin.sym} 160 360 0 0 {name=l11 lab=M}
N 220 330 220 310 {}
C {devices/lab_pin.sym} 220 310 0 1 {name=l12 lab=VPWR}
N 220 580 220 610 {}
C {sky130_fd_pr/nfet_01v8.sym} 200 640 0 0 {name=M6
L=0.15
W=0.36
nf=1
mult=1
model=special_nfet_01v8
spiceprefix=X
}
N 220 640 320 640 {}
C {devices/lab_pin.sym} 320 640 0 1 {name=l13 lab=VNB}
N 160 640 180 640 {}
C {devices/lab_pin.sym} 160 640 0 0 {name=l14 lab=CLK_P}
N 220 670 220 690 {}
C {sky130_fd_pr/nfet_01v8.sym} 200 720 0 0 {name=M7
L=0.15
W=0.45
nf=1
mult=1
model=nfet_01v8
spiceprefix=X
}
N 220 720 320 720 {}
C {devices/lab_pin.sym} 320 720 0 1 {name=l15 lab=VNB}
N 160 720 180 720 {}
C {devices/lab_pin.sym} 160 720 0 0 {name=l16 lab=M}
N 220 750 220 770 {}
C {devices/lab_pin.sym} 220 770 0 1 {name=l17 lab=VGND}
N 220 500 220 540 {}
N 220 540 220 580 {}
N 220 540 680 540 {}
N 680 540 680 260 {}
N 680 260 680 -100 {}
C {devices/lab_pin.sym} 680 260 0 1 {name=l18 lab=M_N}
N 900 -140 900 -170 {}
C {sky130_fd_pr/pfet_01v8_hvt.sym} 880 -200 0 0 {name=M8
L=0.15
W=0.45
nf=1
mult=1
model=pfet_01v8_hvt
spiceprefix=X
}
N 900 -200 1000 -200 {}
C {devices/lab_pin.sym} 1000 -200 0 1 {name=l19 lab=VPB}
N 840 -200 860 -200 {}
C {devices/lab_pin.sym} 840 -200 0 0 {name=l20 lab=SET_B}
N 900 -230 900 -340 {}
N 1180 -140 1180 -170 {}
C {sky130_fd_pr/pfet_01v8_hvt.sym} 1160 -200 0 0 {name=M9
L=0.15
W=0.81
nf=1
mult=1
model=pfet_01v8_hvt
spiceprefix=X
}
N 1180 -200 1280 -200 {}
C {devices/lab_pin.sym} 1280 -200 0 1 {name=l21 lab=VPB}
N 1120 -200 1140 -200 {}
C {devices/lab_pin.sym} 1120 -200 0 0 {name=l22 lab=M_N}
N 1180 -230 1180 -250 {}
C {sky130_fd_pr/pfet_01v8_hvt.sym} 1160 -280 0 0 {name=M10
L=0.15
W=0.81
nf=1
mult=1
model=pfet_01v8_hvt
spiceprefix=X
}
N 1180 -280 1280 -280 {}
C {devices/lab_pin.sym} 1280 -280 0 1 {name=l23 lab=VPB}
N 1120 -280 1140 -280 {}
C {devices/lab_pin.sym} 1120 -280 0 0 {name=l24 lab=RB_N}
N 1180 -310 1180 -340 {}
N 900 -140 1180 -140 {}
N 900 -340 1180 -340 {}
N 900 -340 900 -360 {}
C {devices/lab_pin.sym} 900 -360 0 1 {name=l25 lab=VPWR}
N 900 -60 900 -30 {}
N 900 -30 900 0 {}
C {sky130_fd_pr/nfet_01v8.sym} 880 30 0 0 {name=M11
L=0.15
W=0.63
nf=1
mult=1
model=nfet_01v8
spiceprefix=X
}
N 900 30 1000 30 {}
C {devices/lab_pin.sym} 1000 30 0 1 {name=l26 lab=VNB}
N 840 30 860 30 {}
C {devices/lab_pin.sym} 840 30 0 0 {name=l27 lab=M_N}
N 900 60 900 90 {}
N 1180 -30 1180 0 {}
C {sky130_fd_pr/nfet_01v8.sym} 1160 30 0 0 {name=M12
L=0.15
W=0.63
nf=1
mult=1
model=nfet_01v8
spiceprefix=X
}
N 1180 30 1280 30 {}
C {devices/lab_pin.sym} 1280 30 0 1 {name=l28 lab=VNB}
N 1120 30 1140 30 {}
C {devices/lab_pin.sym} 1120 30 0 0 {name=l29 lab=RB_N}
N 1180 60 1180 90 {}
N 900 -30 1180 -30 {}
N 900 90 1180 90 {}
N 900 90 900 110 {}
C {sky130_fd_pr/nfet_01v8.sym} 880 140 0 0 {name=M13
L=0.15
W=0.45
nf=1
mult=1
model=nfet_01v8
spiceprefix=X
}
N 900 140 1000 140 {}
C {devices/lab_pin.sym} 1000 140 0 1 {name=l30 lab=VNB}
N 840 140 860 140 {}
C {devices/lab_pin.sym} 840 140 0 0 {name=l31 lab=SET_B}
N 900 170 900 190 {}
C {devices/lab_pin.sym} 900 190 0 1 {name=l32 lab=VGND}
N 900 -140 900 -100 {}
N 900 -100 900 -60 {}
N 900 -100 1340 -100 {}
N 1340 -100 1340 -70 {}
C {devices/lab_pin.sym} 1340 -70 0 1 {name=l33 lab=M}
N 1560 -140 1560 -170 {}
C {sky130_fd_pr/pfet_01v8_hvt.sym} 1540 -200 0 0 {name=M14
L=0.15
W=0.45
nf=1
mult=1
model=pfet_01v8_hvt
spiceprefix=X
}
N 1560 -200 1660 -200 {}
C {devices/lab_pin.sym} 1660 -200 0 1 {name=l34 lab=VPB}
N 1500 -200 1520 -200 {}
C {devices/lab_pin.sym} 1500 -200 0 0 {name=l35 lab=CLK_N}
N 1560 -230 1560 -250 {}
C {sky130_fd_pr/pfet_01v8_hvt.sym} 1540 -280 0 0 {name=M15
L=0.15
W=0.81
nf=1
mult=1
model=pfet_01v8_hvt
spiceprefix=X
}
N 1560 -280 1660 -280 {}
C {devices/lab_pin.sym} 1660 -280 0 1 {name=l36 lab=VPB}
N 1500 -280 1520 -280 {}
C {devices/lab_pin.sym} 1500 -280 0 0 {name=l37 lab=M}
N 1560 -310 1560 -330 {}
C {devices/lab_pin.sym} 1560 -330 0 1 {name=l38 lab=VPWR}
N 1560 -60 1560 -30 {}
C {sky130_fd_pr/nfet_01v8.sym} 1540 0 0 0 {name=M16
L=0.15
W=0.36
nf=1
mult=1
model=special_nfet_01v8
spiceprefix=X
}
N 1560 0 1660 0 {}
C {devices/lab_pin.sym} 1660 0 0 1 {name=l39 lab=VNB}
N 1500 0 1520 0 {}
C {devices/lab_pin.sym} 1500 0 0 0 {name=l40 lab=CLK_P}
N 1560 30 1560 50 {}
C {sky130_fd_pr/nfet_01v8.sym} 1540 80 0 0 {name=M17
L=0.15
W=0.63
nf=1
mult=1
model=nfet_01v8
spiceprefix=X
}
N 1560 80 1660 80 {}
C {devices/lab_pin.sym} 1660 80 0 1 {name=l41 lab=VNB}
N 1500 80 1520 80 {}
C {devices/lab_pin.sym} 1500 80 0 0 {name=l42 lab=M}
N 1560 110 1560 130 {}
C {devices/lab_pin.sym} 1560 130 0 1 {name=l43 lab=VGND}
N 1560 -140 1560 -100 {}
N 1560 -100 1560 -60 {}
N 1560 -100 1720 -100 {}
N 880 500 880 470 {}
C {sky130_fd_pr/pfet_01v8_hvt.sym} 860 440 0 0 {name=M18
L=0.15
W=0.45
nf=1
mult=1
model=pfet_01v8_hvt
spiceprefix=X
}
N 880 440 980 440 {}
C {devices/lab_pin.sym} 980 440 0 1 {name=l44 lab=VPB}
N 820 440 840 440 {}
C {devices/lab_pin.sym} 820 440 0 0 {name=l45 lab=CLK_P}
N 880 410 880 390 {}
C {sky130_fd_pr/pfet_01v8_hvt.sym} 860 360 0 0 {name=M19
L=0.15
W=0.45
nf=1
mult=1
model=pfet_01v8_hvt
spiceprefix=X
}
N 880 360 980 360 {}
C {devices/lab_pin.sym} 980 360 0 1 {name=l46 lab=VPB}
N 820 360 840 360 {}
C {devices/lab_pin.sym} 820 360 0 0 {name=l47 lab=S_N}
N 880 330 880 310 {}
C {devices/lab_pin.sym} 880 310 0 1 {name=l48 lab=VPWR}
N 880 580 880 610 {}
C {sky130_fd_pr/nfet_01v8.sym} 860 640 0 0 {name=M20
L=0.15
W=0.36
nf=1
mult=1
model=special_nfet_01v8
spiceprefix=X
}
N 880 640 980 640 {}
C {devices/lab_pin.sym} 980 640 0 1 {name=l49 lab=VNB}
N 820 640 840 640 {}
C {devices/lab_pin.sym} 820 640 0 0 {name=l50 lab=CLK_N}
N 880 670 880 690 {}
C {sky130_fd_pr/nfet_01v8.sym} 860 720 0 0 {name=M21
L=0.15
W=0.45
nf=1
mult=1
model=nfet_01v8
spiceprefix=X
}
N 880 720 980 720 {}
C {devices/lab_pin.sym} 980 720 0 1 {name=l51 lab=VNB}
N 820 720 840 720 {}
C {devices/lab_pin.sym} 820 720 0 0 {name=l52 lab=S_N}
N 880 750 880 770 {}
C {devices/lab_pin.sym} 880 770 0 1 {name=l53 lab=VGND}
N 880 500 880 540 {}
N 880 540 880 580 {}
N 880 540 1720 540 {}
N 1720 540 1720 260 {}
N 1720 260 1720 -100 {}
C {devices/lab_pin.sym} 1720 260 0 1 {name=l54 lab=S}
N 1940 -140 1940 -170 {}
C {sky130_fd_pr/pfet_01v8_hvt.sym} 1920 -200 0 0 {name=M22
L=0.15
W=0.45
nf=1
mult=1
model=pfet_01v8_hvt
spiceprefix=X
}
N 1940 -200 2040 -200 {}
C {devices/lab_pin.sym} 2040 -200 0 1 {name=l55 lab=VPB}
N 1880 -200 1900 -200 {}
C {devices/lab_pin.sym} 1880 -200 0 0 {name=l56 lab=SET_B}
N 1940 -230 1940 -340 {}
N 2220 -140 2220 -170 {}
C {sky130_fd_pr/pfet_01v8_hvt.sym} 2200 -200 0 0 {name=M23
L=0.15
W=0.81
nf=1
mult=1
model=pfet_01v8_hvt
spiceprefix=X
}
N 2220 -200 2320 -200 {}
C {devices/lab_pin.sym} 2320 -200 0 1 {name=l57 lab=VPB}
N 2160 -200 2180 -200 {}
C {devices/lab_pin.sym} 2160 -200 0 0 {name=l58 lab=S}
N 2220 -230 2220 -250 {}
C {sky130_fd_pr/pfet_01v8_hvt.sym} 2200 -280 0 0 {name=M24
L=0.15
W=0.81
nf=1
mult=1
model=pfet_01v8_hvt
spiceprefix=X
}
N 2220 -280 2320 -280 {}
C {devices/lab_pin.sym} 2320 -280 0 1 {name=l59 lab=VPB}
N 2160 -280 2180 -280 {}
C {devices/lab_pin.sym} 2160 -280 0 0 {name=l60 lab=RB_N}
N 2220 -310 2220 -340 {}
N 1940 -140 2220 -140 {}
N 1940 -340 2220 -340 {}
N 1940 -340 1940 -360 {}
C {devices/lab_pin.sym} 1940 -360 0 1 {name=l61 lab=VPWR}
N 1940 -60 1940 -30 {}
N 1940 -30 1940 0 {}
C {sky130_fd_pr/nfet_01v8.sym} 1920 30 0 0 {name=M25
L=0.15
W=0.63
nf=1
mult=1
model=nfet_01v8
spiceprefix=X
}
N 1940 30 2040 30 {}
C {devices/lab_pin.sym} 2040 30 0 1 {name=l62 lab=VNB}
N 1880 30 1900 30 {}
C {devices/lab_pin.sym} 1880 30 0 0 {name=l63 lab=S}
N 1940 60 1940 90 {}
N 2220 -30 2220 0 {}
C {sky130_fd_pr/nfet_01v8.sym} 2200 30 0 0 {name=M26
L=0.15
W=0.63
nf=1
mult=1
model=nfet_01v8
spiceprefix=X
}
N 2220 30 2320 30 {}
C {devices/lab_pin.sym} 2320 30 0 1 {name=l64 lab=VNB}
N 2160 30 2180 30 {}
C {devices/lab_pin.sym} 2160 30 0 0 {name=l65 lab=RB_N}
N 2220 60 2220 90 {}
N 1940 -30 2220 -30 {}
N 1940 90 2220 90 {}
N 1940 90 1940 110 {}
C {sky130_fd_pr/nfet_01v8.sym} 1920 140 0 0 {name=M27
L=0.15
W=0.45
nf=1
mult=1
model=nfet_01v8
spiceprefix=X
}
N 1940 140 2040 140 {}
C {devices/lab_pin.sym} 2040 140 0 1 {name=l66 lab=VNB}
N 1880 140 1900 140 {}
C {devices/lab_pin.sym} 1880 140 0 0 {name=l67 lab=SET_B}
N 1940 170 1940 190 {}
C {devices/lab_pin.sym} 1940 190 0 1 {name=l68 lab=VGND}
N 1940 -140 1940 -100 {}
N 1940 -100 1940 -60 {}
N 1940 -100 2380 -100 {}
N 2380 -100 2380 -70 {}
C {devices/lab_pin.sym} 2380 -70 0 1 {name=l69 lab=S_N}
N 2600 -140 2600 -170 {}
C {sky130_fd_pr/pfet_01v8_hvt.sym} 2580 -200 0 0 {name=M28
L=0.15
W=0.63
nf=1
mult=1
model=pfet_01v8_hvt
spiceprefix=X
}
N 2600 -200 2700 -200 {}
C {devices/lab_pin.sym} 2700 -200 0 1 {name=l70 lab=VPB}
N 2600 -230 2600 -250 {}
C {devices/lab_pin.sym} 2600 -250 0 1 {name=l71 lab=VPWR}
N 2600 -60 2600 -30 {}
C {sky130_fd_pr/nfet_01v8.sym} 2580 0 0 0 {name=M29
L=0.15
W=0.45
nf=1
mult=1
model=nfet_01v8
spiceprefix=X
}
N 2600 0 2700 0 {}
C {devices/lab_pin.sym} 2700 0 0 1 {name=l72 lab=VNB}
N 2600 30 2600 50 {}
C {devices/lab_pin.sym} 2600 50 0 1 {name=l73 lab=VGND}
N 2600 -140 2600 -100 {}
N 2600 -100 2600 -60 {}
N 2560 -200 2520 -200 {}
N 2520 -200 2520 -100 {}
N 2520 -100 2520 0 {}
N 2520 0 2560 0 {}
N 2480 -100 2520 -100 {}
N 2380 -100 2480 -100 {}
N 2900 -140 2900 -170 {}
C {sky130_fd_pr/pfet_01v8_hvt.sym} 2880 -200 0 0 {name=M30
L=0.15
W=1.08
nf=1
mult=1
model=pfet_01v8_hvt
spiceprefix=X
}
N 2900 -200 3000 -200 {}
C {devices/lab_pin.sym} 3000 -200 0 1 {name=l74 lab=VPB}
N 2900 -230 2900 -250 {}
C {devices/lab_pin.sym} 2900 -250 0 1 {name=l75 lab=VPWR}
N 2900 -60 2900 -30 {}
C {sky130_fd_pr/nfet_01v8.sym} 2880 0 0 0 {name=M31
L=0.15
W=0.63
nf=1
mult=1
model=nfet_01v8
spiceprefix=X
}
N 2900 0 3000 0 {}
C {devices/lab_pin.sym} 3000 0 0 1 {name=l76 lab=VNB}
N 2900 30 2900 50 {}
C {devices/lab_pin.sym} 2900 50 0 1 {name=l77 lab=VGND}
N 2900 -140 2900 -100 {}
N 2900 -100 2900 -60 {}
N 2860 -200 2820 -200 {}
N 2820 -200 2820 -100 {}
N 2820 -100 2820 0 {}
N 2820 0 2860 0 {}
N 2780 -100 2820 -100 {}
N 2600 -100 2780 -100 {}
N 2900 -100 3060 -100 {}
C {devices/opin.sym} 3060 -100 0 0 {name=p2 lab=Q}
N 1980 500 1980 470 {}
C {sky130_fd_pr/pfet_01v8_hvt.sym} 1960 440 0 0 {name=M32
L=0.15
W=0.63
nf=1
mult=1
model=pfet_01v8_hvt
spiceprefix=X
}
N 1980 440 2080 440 {}
C {devices/lab_pin.sym} 2080 440 0 1 {name=l78 lab=VPB}
N 1980 410 1980 390 {}
C {devices/lab_pin.sym} 1980 390 0 1 {name=l79 lab=VPWR}
N 1980 580 1980 610 {}
C {sky130_fd_pr/nfet_01v8.sym} 1960 640 0 0 {name=M33
L=0.15
W=0.45
nf=1
mult=1
model=nfet_01v8
spiceprefix=X
}
N 1980 640 2080 640 {}
C {devices/lab_pin.sym} 2080 640 0 1 {name=l80 lab=VNB}
N 1980 670 1980 690 {}
C {devices/lab_pin.sym} 1980 690 0 1 {name=l81 lab=VGND}
N 1980 500 1980 540 {}
N 1980 540 1980 580 {}
N 1940 440 1900 440 {}
N 1900 440 1900 540 {}
N 1900 540 1900 640 {}
N 1900 640 1940 640 {}
N 1860 540 1900 540 {}
C {devices/ipin.sym} 1860 540 0 0 {name=p3 lab=CLK}
N 1980 540 2140 540 {}
N 2140 540 2140 570 {}
C {devices/lab_pin.sym} 2140 570 0 1 {name=l82 lab=CLK_N}
N 2360 500 2360 470 {}
C {sky130_fd_pr/pfet_01v8_hvt.sym} 2340 440 0 0 {name=M34
L=0.15
W=0.63
nf=1
mult=1
model=pfet_01v8_hvt
spiceprefix=X
}
N 2360 440 2460 440 {}
C {devices/lab_pin.sym} 2460 440 0 1 {name=l83 lab=VPB}
N 2360 410 2360 390 {}
C {devices/lab_pin.sym} 2360 390 0 1 {name=l84 lab=VPWR}
N 2360 580 2360 610 {}
C {sky130_fd_pr/nfet_01v8.sym} 2340 640 0 0 {name=M35
L=0.15
W=0.45
nf=1
mult=1
model=nfet_01v8
spiceprefix=X
}
N 2360 640 2460 640 {}
C {devices/lab_pin.sym} 2460 640 0 1 {name=l85 lab=VNB}
N 2360 670 2360 690 {}
C {devices/lab_pin.sym} 2360 690 0 1 {name=l86 lab=VGND}
N 2360 500 2360 540 {}
N 2360 540 2360 580 {}
N 2320 440 2280 440 {}
N 2280 440 2280 540 {}
N 2280 540 2280 640 {}
N 2280 640 2320 640 {}
N 2240 540 2280 540 {}
N 2140 540 2240 540 {}
N 2360 540 2520 540 {}
C {devices/lab_pin.sym} 2520 540 0 1 {name=l87 lab=CLK_P}
N 2840 500 2840 470 {}
C {sky130_fd_pr/pfet_01v8_hvt.sym} 2820 440 0 0 {name=M36
L=0.15
W=0.63
nf=1
mult=1
model=pfet_01v8_hvt
spiceprefix=X
}
N 2840 440 2940 440 {}
C {devices/lab_pin.sym} 2940 440 0 1 {name=l88 lab=VPB}
N 2840 410 2840 390 {}
C {devices/lab_pin.sym} 2840 390 0 1 {name=l89 lab=VPWR}
N 2840 580 2840 610 {}
C {sky130_fd_pr/nfet_01v8.sym} 2820 640 0 0 {name=M37
L=0.15
W=0.45
nf=1
mult=1
model=nfet_01v8
spiceprefix=X
}
N 2840 640 2940 640 {}
C {devices/lab_pin.sym} 2940 640 0 1 {name=l90 lab=VNB}
N 2840 670 2840 690 {}
C {devices/lab_pin.sym} 2840 690 0 1 {name=l91 lab=VGND}
N 2840 500 2840 540 {}
N 2840 540 2840 580 {}
N 2800 440 2760 440 {}
N 2760 440 2760 540 {}
N 2760 540 2760 640 {}
N 2760 640 2800 640 {}
N 2720 540 2760 540 {}
C {devices/ipin.sym} 2720 540 0 0 {name=p4 lab=RESET_B}
N 2840 540 3000 540 {}
C {devices/lab_pin.sym} 3000 540 0 1 {name=l92 lab=RB_N}
N 3320 500 3320 470 {}
C {sky130_fd_pr/pfet_01v8_hvt.sym} 3300 440 0 0 {name=M38
L=0.15
W=1.08
nf=1
mult=1
model=pfet_01v8_hvt
spiceprefix=X
}
N 3320 440 3420 440 {}
C {devices/lab_pin.sym} 3420 440 0 1 {name=l93 lab=VPB}
N 3320 410 3320 390 {}
C {devices/lab_pin.sym} 3320 390 0 1 {name=l94 lab=VPWR}
N 3320 580 3320 610 {}
C {sky130_fd_pr/nfet_01v8.sym} 3300 640 0 0 {name=M39
L=0.15
W=0.63
nf=1
mult=1
model=nfet_01v8
spiceprefix=X
}
N 3320 640 3420 640 {}
C {devices/lab_pin.sym} 3420 640 0 1 {name=l95 lab=VNB}
N 3320 670 3320 690 {}
C {devices/lab_pin.sym} 3320 690 0 1 {name=l96 lab=VGND}
N 3320 500 3320 540 {}
N 3320 540 3320 580 {}
N 3280 440 3240 440 {}
N 3240 440 3240 540 {}
N 3240 540 3240 640 {}
N 3240 640 3280 640 {}
N 3200 540 3240 540 {}
C {devices/lab_pin.sym} 3200 540 0 0 {name=l97 lab=S_N}
N 3320 540 3480 540 {}
C {devices/opin.sym} 3480 540 0 0 {name=p5 lab=Q_N}
C {devices/ipin.sym} -40 -520 0 0 {name=p6 lab=SET_B}
C {devices/iopin.sym} -40 -490 0 1 {name=p7 lab=VGND}
C {devices/iopin.sym} -40 -460 0 1 {name=p8 lab=VNB}
C {devices/iopin.sym} -40 -430 0 1 {name=p9 lab=VPB}
C {devices/iopin.sym} -40 -400 0 1 {name=p10 lab=VPWR}
C {title_efx.sym} 2690 890 0 0 {name=t1 author="ejfogleman"}
C {copyright.sym} 2690 960 0 0 {name=s1 place=header value="* Copyright (c) 2026 Eric Fogleman
* SPDX-License-Identifier: Apache-2.0
* Derived from SkyWater sky130_fd_sc_hd (Apache-2.0); see NOTICE"}
