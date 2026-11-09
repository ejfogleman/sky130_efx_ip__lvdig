v {xschem version=3.4.7 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
T {Schematic of sky130_efx_lvdig__dfstp_2, from the PDK netlist of sky130_fd_sc_hd__dfstp_2
(libs.ref/sky130_fd_sc_hd/spice/sky130_fd_sc_hd.spice)} -60 -570 0 0 0.3 0.3 {}
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
W=0.63
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
N 620 -100 1060 -100 {}
N 220 470 220 440 {}
C {sky130_fd_pr/pfet_01v8_hvt.sym} 200 410 0 0 {name=M4
L=0.15
W=0.45
nf=1
mult=1
model=pfet_01v8_hvt
spiceprefix=X
}
N 220 410 320 410 {}
C {devices/lab_pin.sym} 320 410 0 1 {name=l8 lab=VPB}
N 160 410 180 410 {}
C {devices/lab_pin.sym} 160 410 0 0 {name=l9 lab=M_N}
N 220 380 220 350 {}
N 500 470 500 440 {}
C {sky130_fd_pr/pfet_01v8_hvt.sym} 480 410 0 0 {name=M5
L=0.15
W=0.45
nf=1
mult=1
model=pfet_01v8_hvt
spiceprefix=X
}
N 500 410 600 410 {}
C {devices/lab_pin.sym} 600 410 0 1 {name=l10 lab=VPB}
N 440 410 460 410 {}
C {devices/lab_pin.sym} 440 410 0 0 {name=l11 lab=SET_B}
N 500 380 500 350 {}
N 220 470 500 470 {}
N 220 350 500 350 {}
N 220 350 220 330 {}
C {devices/lab_pin.sym} 220 330 0 1 {name=l12 lab=VPWR}
N 220 550 220 580 {}
C {sky130_fd_pr/nfet_01v8.sym} 200 610 0 0 {name=M6
L=0.15
W=0.45
nf=1
mult=1
model=nfet_01v8
spiceprefix=X
}
N 220 610 320 610 {}
C {devices/lab_pin.sym} 320 610 0 1 {name=l13 lab=VNB}
N 160 610 180 610 {}
C {devices/lab_pin.sym} 160 610 0 0 {name=l14 lab=M_N}
N 220 640 220 660 {}
C {sky130_fd_pr/nfet_01v8.sym} 200 690 0 0 {name=M7
L=0.15
W=0.45
nf=1
mult=1
model=nfet_01v8
spiceprefix=X
}
N 220 690 320 690 {}
C {devices/lab_pin.sym} 320 690 0 1 {name=l15 lab=VNB}
N 160 690 180 690 {}
C {devices/lab_pin.sym} 160 690 0 0 {name=l16 lab=SET_B}
N 220 720 220 740 {}
C {devices/lab_pin.sym} 220 740 0 1 {name=l17 lab=VGND}
N 220 470 220 510 {}
N 220 510 220 550 {}
N 220 510 660 510 {}
C {devices/lab_pin.sym} 660 510 0 1 {name=l18 lab=M}
N 900 470 900 440 {}
C {sky130_fd_pr/pfet_01v8_hvt.sym} 880 410 0 0 {name=M8
L=0.15
W=0.45
nf=1
mult=1
model=pfet_01v8_hvt
spiceprefix=X
}
N 900 410 1000 410 {}
C {devices/lab_pin.sym} 1000 410 0 1 {name=l19 lab=VPB}
N 840 410 860 410 {}
C {devices/lab_pin.sym} 840 410 0 0 {name=l20 lab=CLK_N}
N 900 380 900 360 {}
C {sky130_fd_pr/pfet_01v8_hvt.sym} 880 330 0 0 {name=M9
L=0.15
W=0.45
nf=1
mult=1
model=pfet_01v8_hvt
spiceprefix=X
}
N 900 330 1000 330 {}
C {devices/lab_pin.sym} 1000 330 0 1 {name=l21 lab=VPB}
N 840 330 860 330 {}
C {devices/lab_pin.sym} 840 330 0 0 {name=l22 lab=M}
N 900 300 900 280 {}
C {devices/lab_pin.sym} 900 280 0 1 {name=l23 lab=VPWR}
N 900 550 900 580 {}
C {sky130_fd_pr/nfet_01v8.sym} 880 610 0 0 {name=M10
L=0.15
W=0.36
nf=1
mult=1
model=special_nfet_01v8
spiceprefix=X
}
N 900 610 1000 610 {}
C {devices/lab_pin.sym} 1000 610 0 1 {name=l24 lab=VNB}
N 840 610 860 610 {}
C {devices/lab_pin.sym} 840 610 0 0 {name=l25 lab=CLK_P}
N 900 640 900 660 {}
C {sky130_fd_pr/nfet_01v8.sym} 880 690 0 0 {name=M11
L=0.15
W=0.45
nf=1
mult=1
model=nfet_01v8
spiceprefix=X
}
N 900 690 1000 690 {}
C {devices/lab_pin.sym} 1000 690 0 1 {name=l26 lab=VNB}
N 840 690 860 690 {}
C {devices/lab_pin.sym} 840 690 0 0 {name=l27 lab=M}
N 900 720 900 740 {}
C {devices/lab_pin.sym} 900 740 0 1 {name=l28 lab=VGND}
N 900 470 900 510 {}
N 900 510 900 550 {}
N 900 510 1060 510 {}
N 1060 510 1060 245 {}
N 1060 245 1060 -100 {}
C {devices/lab_pin.sym} 1060 245 0 1 {name=l29 lab=M_N}
N 1280 -140 1280 -170 {}
C {sky130_fd_pr/pfet_01v8_hvt.sym} 1260 -200 0 0 {name=M12
L=0.15
W=0.45
nf=1
mult=1
model=pfet_01v8_hvt
spiceprefix=X
}
N 1280 -200 1380 -200 {}
C {devices/lab_pin.sym} 1380 -200 0 1 {name=l30 lab=VPB}
N 1220 -200 1240 -200 {}
C {devices/lab_pin.sym} 1220 -200 0 0 {name=l31 lab=CLK_N}
N 1280 -230 1280 -250 {}
C {sky130_fd_pr/pfet_01v8_hvt.sym} 1260 -280 0 0 {name=M13
L=0.15
W=0.45
nf=1
mult=1
model=pfet_01v8_hvt
spiceprefix=X
}
N 1280 -280 1380 -280 {}
C {devices/lab_pin.sym} 1380 -280 0 1 {name=l32 lab=VPB}
N 1220 -280 1240 -280 {}
C {devices/lab_pin.sym} 1220 -280 0 0 {name=l33 lab=M_N}
N 1280 -310 1280 -330 {}
C {devices/lab_pin.sym} 1280 -330 0 1 {name=l34 lab=VPWR}
N 1280 -60 1280 -30 {}
C {sky130_fd_pr/nfet_01v8.sym} 1260 0 0 0 {name=M14
L=0.15
W=0.45
nf=1
mult=1
model=nfet_01v8
spiceprefix=X
}
N 1280 0 1380 0 {}
C {devices/lab_pin.sym} 1380 0 0 1 {name=l35 lab=VNB}
N 1220 0 1240 0 {}
C {devices/lab_pin.sym} 1220 0 0 0 {name=l36 lab=CLK_P}
N 1280 30 1280 50 {}
C {sky130_fd_pr/nfet_01v8.sym} 1260 80 0 0 {name=M15
L=0.15
W=0.45
nf=1
mult=1
model=nfet_01v8
spiceprefix=X
}
N 1280 80 1380 80 {}
C {devices/lab_pin.sym} 1380 80 0 1 {name=l37 lab=VNB}
N 1220 80 1240 80 {}
C {devices/lab_pin.sym} 1220 80 0 0 {name=l38 lab=M_N}
N 1280 110 1280 130 {}
C {devices/lab_pin.sym} 1280 130 0 1 {name=l39 lab=VGND}
N 1280 -140 1280 -100 {}
N 1280 -100 1280 -60 {}
N 1280 -100 2100 -100 {}
N 1260 470 1260 440 {}
C {sky130_fd_pr/pfet_01v8_hvt.sym} 1240 410 0 0 {name=M16
L=0.15
W=0.81
nf=1
mult=1
model=pfet_01v8_hvt
spiceprefix=X
}
N 1260 410 1360 410 {}
C {devices/lab_pin.sym} 1360 410 0 1 {name=l40 lab=VPB}
N 1260 380 1260 360 {}
C {devices/lab_pin.sym} 1260 360 0 1 {name=l41 lab=VPWR}
N 1260 550 1260 580 {}
C {sky130_fd_pr/nfet_01v8.sym} 1240 610 0 0 {name=M17
L=0.15
W=0.54
nf=1
mult=1
model=nfet_01v8
spiceprefix=X
}
N 1260 610 1360 610 {}
C {devices/lab_pin.sym} 1360 610 0 1 {name=l42 lab=VNB}
N 1260 640 1260 660 {}
C {devices/lab_pin.sym} 1260 660 0 1 {name=l43 lab=VGND}
N 1260 470 1260 510 {}
N 1260 510 1260 550 {}
N 1220 410 1180 410 {}
N 1180 410 1180 510 {}
N 1180 510 1180 610 {}
N 1180 610 1220 610 {}
N 1140 510 1180 510 {}
C {devices/lab_pin.sym} 1140 510 0 0 {name=l44 lab=S}
N 1260 510 1420 510 {}
C {devices/lab_pin.sym} 1420 510 0 1 {name=l45 lab=S_N}
N 1660 470 1660 440 {}
C {sky130_fd_pr/pfet_01v8_hvt.sym} 1640 410 0 0 {name=M18
L=0.15
W=0.45
nf=1
mult=1
model=pfet_01v8_hvt
spiceprefix=X
}
N 1660 410 1760 410 {}
C {devices/lab_pin.sym} 1760 410 0 1 {name=l46 lab=VPB}
N 1600 410 1620 410 {}
C {devices/lab_pin.sym} 1600 410 0 0 {name=l47 lab=CLK_P}
N 1660 380 1660 360 {}
C {sky130_fd_pr/pfet_01v8_hvt.sym} 1640 330 0 0 {name=M19
L=0.15
W=0.45
nf=1
mult=1
model=pfet_01v8_hvt
spiceprefix=X
}
N 1660 330 1760 330 {}
C {devices/lab_pin.sym} 1760 330 0 1 {name=l48 lab=VPB}
N 1600 330 1620 330 {}
C {devices/lab_pin.sym} 1600 330 0 0 {name=l49 lab=S_N}
N 1660 300 1660 270 {}
N 1940 470 1940 440 {}
C {sky130_fd_pr/pfet_01v8_hvt.sym} 1920 410 0 0 {name=M20
L=0.15
W=0.45
nf=1
mult=1
model=pfet_01v8_hvt
spiceprefix=X
}
N 1940 410 2040 410 {}
C {devices/lab_pin.sym} 2040 410 0 1 {name=l50 lab=VPB}
N 1880 410 1900 410 {}
C {devices/lab_pin.sym} 1880 410 0 0 {name=l51 lab=SET_B}
N 1940 380 1940 270 {}
N 1660 470 1940 470 {}
N 1660 270 1940 270 {}
N 1660 270 1660 250 {}
C {devices/lab_pin.sym} 1660 250 0 1 {name=l52 lab=VPWR}
N 1660 550 1660 580 {}
C {sky130_fd_pr/nfet_01v8.sym} 1640 610 0 0 {name=M21
L=0.15
W=0.45
nf=1
mult=1
model=nfet_01v8
spiceprefix=X
}
N 1660 610 1760 610 {}
C {devices/lab_pin.sym} 1760 610 0 1 {name=l53 lab=VNB}
N 1600 610 1620 610 {}
C {devices/lab_pin.sym} 1600 610 0 0 {name=l54 lab=CLK_N}
N 1660 640 1660 660 {}
C {sky130_fd_pr/nfet_01v8.sym} 1640 690 0 0 {name=M22
L=0.15
W=0.45
nf=1
mult=1
model=nfet_01v8
spiceprefix=X
}
N 1660 690 1760 690 {}
C {devices/lab_pin.sym} 1760 690 0 1 {name=l55 lab=VNB}
N 1600 690 1620 690 {}
C {devices/lab_pin.sym} 1600 690 0 0 {name=l56 lab=S_N}
N 1660 720 1660 740 {}
C {sky130_fd_pr/nfet_01v8.sym} 1640 770 0 0 {name=M23
L=0.15
W=0.45
nf=1
mult=1
model=nfet_01v8
spiceprefix=X
}
N 1660 770 1760 770 {}
C {devices/lab_pin.sym} 1760 770 0 1 {name=l57 lab=VNB}
N 1600 770 1620 770 {}
C {devices/lab_pin.sym} 1600 770 0 0 {name=l58 lab=SET_B}
N 1660 800 1660 820 {}
C {devices/lab_pin.sym} 1660 820 0 1 {name=l59 lab=VGND}
N 1660 470 1660 510 {}
N 1660 510 1660 550 {}
N 1660 510 2100 510 {}
N 2100 510 2100 245 {}
N 2100 245 2100 -100 {}
C {devices/lab_pin.sym} 2100 245 0 1 {name=l60 lab=S}
N 2320 -140 2320 -170 {}
C {sky130_fd_pr/pfet_01v8_hvt.sym} 2300 -200 0 0 {name=M24
L=0.15
W=1.08
nf=1
mult=1
model=pfet_01v8_hvt
spiceprefix=X
}
N 2320 -200 2420 -200 {}
C {devices/lab_pin.sym} 2420 -200 0 1 {name=l61 lab=VPB}
N 2320 -230 2320 -250 {}
C {devices/lab_pin.sym} 2320 -250 0 1 {name=l62 lab=VPWR}
N 2320 -60 2320 -30 {}
C {sky130_fd_pr/nfet_01v8.sym} 2300 0 0 0 {name=M25
L=0.15
W=0.63
nf=1
mult=1
model=nfet_01v8
spiceprefix=X
}
N 2320 0 2420 0 {}
C {devices/lab_pin.sym} 2420 0 0 1 {name=l63 lab=VNB}
N 2320 30 2320 50 {}
C {devices/lab_pin.sym} 2320 50 0 1 {name=l64 lab=VGND}
N 2320 -140 2320 -100 {}
N 2320 -100 2320 -60 {}
N 2280 -200 2240 -200 {}
N 2240 -200 2240 -100 {}
N 2240 -100 2240 0 {}
N 2240 0 2280 0 {}
N 2200 -100 2240 -100 {}
N 2100 -100 2200 -100 {}
N 2620 -140 2620 -170 {}
C {sky130_fd_pr/pfet_01v8_hvt.sym} 2600 -200 0 0 {name=M26
L=0.15
W=1.08
nf=1
mult=2
model=pfet_01v8_hvt
spiceprefix=X
}
N 2620 -200 2720 -200 {}
C {devices/lab_pin.sym} 2720 -200 0 1 {name=l65 lab=VPB}
N 2620 -230 2620 -250 {}
C {devices/lab_pin.sym} 2620 -250 0 1 {name=l66 lab=VPWR}
N 2620 -60 2620 -30 {}
C {sky130_fd_pr/nfet_01v8.sym} 2600 0 0 0 {name=M27
L=0.15
W=0.63
nf=1
mult=2
model=nfet_01v8
spiceprefix=X
}
N 2620 0 2720 0 {}
C {devices/lab_pin.sym} 2720 0 0 1 {name=l67 lab=VNB}
N 2620 30 2620 50 {}
C {devices/lab_pin.sym} 2620 50 0 1 {name=l68 lab=VGND}
N 2620 -140 2620 -100 {}
N 2620 -100 2620 -60 {}
N 2580 -200 2540 -200 {}
N 2540 -200 2540 -100 {}
N 2540 -100 2540 0 {}
N 2540 0 2580 0 {}
N 2500 -100 2540 -100 {}
N 2320 -100 2500 -100 {}
N 2620 -100 2780 -100 {}
C {devices/opin.sym} 2780 -100 0 0 {name=p2 lab=Q}
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
C {devices/lab_pin.sym} 2460 410 0 1 {name=l69 lab=VPB}
N 2360 380 2360 360 {}
C {devices/lab_pin.sym} 2360 360 0 1 {name=l70 lab=VPWR}
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
C {devices/lab_pin.sym} 2460 610 0 1 {name=l71 lab=VNB}
N 2360 640 2360 660 {}
C {devices/lab_pin.sym} 2360 660 0 1 {name=l72 lab=VGND}
N 2360 470 2360 510 {}
N 2360 510 2360 550 {}
N 2320 410 2280 410 {}
N 2280 410 2280 510 {}
N 2280 510 2280 610 {}
N 2280 610 2320 610 {}
N 2240 510 2280 510 {}
C {devices/ipin.sym} 2240 510 0 0 {name=p3 lab=CLK}
N 2360 510 2520 510 {}
N 2520 510 2520 540 {}
C {devices/lab_pin.sym} 2520 540 0 1 {name=l73 lab=CLK_N}
N 2740 470 2740 440 {}
C {sky130_fd_pr/pfet_01v8_hvt.sym} 2720 410 0 0 {name=M30
L=0.15
W=0.63
nf=1
mult=1
model=pfet_01v8_hvt
spiceprefix=X
}
N 2740 410 2840 410 {}
C {devices/lab_pin.sym} 2840 410 0 1 {name=l74 lab=VPB}
N 2740 380 2740 360 {}
C {devices/lab_pin.sym} 2740 360 0 1 {name=l75 lab=VPWR}
N 2740 550 2740 580 {}
C {sky130_fd_pr/nfet_01v8.sym} 2720 610 0 0 {name=M31
L=0.15
W=0.45
nf=1
mult=1
model=nfet_01v8
spiceprefix=X
}
N 2740 610 2840 610 {}
C {devices/lab_pin.sym} 2840 610 0 1 {name=l76 lab=VNB}
N 2740 640 2740 660 {}
C {devices/lab_pin.sym} 2740 660 0 1 {name=l77 lab=VGND}
N 2740 470 2740 510 {}
N 2740 510 2740 550 {}
N 2700 410 2660 410 {}
N 2660 410 2660 510 {}
N 2660 510 2660 610 {}
N 2660 610 2700 610 {}
N 2620 510 2660 510 {}
N 2520 510 2620 510 {}
N 2740 510 2900 510 {}
C {devices/lab_pin.sym} 2900 510 0 1 {name=l78 lab=CLK_P}
C {devices/ipin.sym} -40 -490 0 0 {name=p4 lab=SET_B}
C {devices/iopin.sym} -40 -460 0 1 {name=p5 lab=VGND}
C {devices/iopin.sym} -40 -430 0 1 {name=p6 lab=VNB}
C {devices/iopin.sym} -40 -400 0 1 {name=p7 lab=VPB}
C {devices/iopin.sym} -40 -370 0 1 {name=p8 lab=VPWR}
C {title_efx.sym} 2110 940 0 0 {name=t1 author="ejfogleman"}
C {copyright.sym} 2110 1010 0 0 {name=s1 place=header value="* Copyright (c) 2026 Eric Fogleman
* SPDX-License-Identifier: Apache-2.0
* Derived from SkyWater sky130_fd_sc_hd (Apache-2.0); see NOTICE"}
