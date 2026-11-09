v {xschem version=3.4.7 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
T {Schematic of sky130_efx_lvdig__a22o_1, from the PDK netlist of sky130_fd_sc_hd__a22o_1
(libs.ref/sky130_fd_sc_hd/spice/sky130_fd_sc_hd.spice)} -60 -780 0 0 0.3 0.3 {}
N 220 -140 220 -170 {}
N 220 -170 220 -200 {}
C {sky130_fd_pr/pfet_01v8_hvt.sym} 200 -230 0 0 {name=M0
L=0.15
W=1.08
nf=1
mult=1
model=pfet_01v8_hvt
spiceprefix=X
}
N 220 -230 320 -230 {}
C {devices/lab_pin.sym} 320 -230 0 1 {name=l1 lab=VPB}
N 160 -230 180 -230 {}
C {devices/lab_pin.sym} 160 -230 0 0 {name=l2 lab=B1}
N 220 -260 220 -290 {}
N 500 -170 500 -200 {}
C {sky130_fd_pr/pfet_01v8_hvt.sym} 480 -230 0 0 {name=M1
L=0.15
W=1.08
nf=1
mult=1
model=pfet_01v8_hvt
spiceprefix=X
}
N 500 -230 600 -230 {}
C {devices/lab_pin.sym} 600 -230 0 1 {name=l3 lab=VPB}
N 440 -230 460 -230 {}
C {devices/lab_pin.sym} 440 -230 0 0 {name=l4 lab=B2}
N 500 -260 500 -290 {}
N 220 -170 500 -170 {}
N 220 -290 500 -290 {}
N 220 -290 220 -310 {}
N 220 -310 220 -340 {}
C {sky130_fd_pr/pfet_01v8_hvt.sym} 200 -370 0 0 {name=M2
L=0.15
W=1.08
nf=1
mult=1
model=pfet_01v8_hvt
spiceprefix=X
}
N 220 -370 320 -370 {}
C {devices/lab_pin.sym} 320 -370 0 1 {name=l5 lab=VPB}
N 160 -370 180 -370 {}
C {devices/lab_pin.sym} 160 -370 0 0 {name=l6 lab=A1}
N 220 -400 220 -430 {}
N 500 -310 500 -340 {}
C {sky130_fd_pr/pfet_01v8_hvt.sym} 480 -370 0 0 {name=M3
L=0.15
W=1.08
nf=1
mult=1
model=pfet_01v8_hvt
spiceprefix=X
}
N 500 -370 600 -370 {}
C {devices/lab_pin.sym} 600 -370 0 1 {name=l7 lab=VPB}
N 440 -370 460 -370 {}
C {devices/lab_pin.sym} 440 -370 0 0 {name=l8 lab=A2}
N 500 -400 500 -430 {}
N 220 -310 500 -310 {}
N 220 -430 500 -430 {}
N 220 -430 220 -450 {}
C {devices/lab_pin.sym} 220 -450 0 1 {name=l9 lab=VPWR}
N 220 -60 220 -30 {}
C {sky130_fd_pr/nfet_01v8.sym} 200 0 0 0 {name=M4
L=0.15
W=0.63
nf=1
mult=1
model=nfet_01v8
spiceprefix=X
}
N 220 0 320 0 {}
C {devices/lab_pin.sym} 320 0 0 1 {name=l10 lab=VNB}
N 160 0 180 0 {}
C {devices/lab_pin.sym} 160 0 0 0 {name=l11 lab=A1}
N 220 30 220 50 {}
C {sky130_fd_pr/nfet_01v8.sym} 200 80 0 0 {name=M5
L=0.15
W=0.63
nf=1
mult=1
model=nfet_01v8
spiceprefix=X
}
N 220 80 320 80 {}
C {devices/lab_pin.sym} 320 80 0 1 {name=l12 lab=VNB}
N 160 80 180 80 {}
C {devices/lab_pin.sym} 160 80 0 0 {name=l13 lab=A2}
N 220 110 220 140 {}
N 500 -60 500 -30 {}
C {sky130_fd_pr/nfet_01v8.sym} 480 0 0 0 {name=M6
L=0.15
W=0.63
nf=1
mult=1
model=nfet_01v8
spiceprefix=X
}
N 500 0 600 0 {}
C {devices/lab_pin.sym} 600 0 0 1 {name=l14 lab=VNB}
N 440 0 460 0 {}
C {devices/lab_pin.sym} 440 0 0 0 {name=l15 lab=B1}
N 500 30 500 50 {}
C {sky130_fd_pr/nfet_01v8.sym} 480 80 0 0 {name=M7
L=0.15
W=0.63
nf=1
mult=1
model=nfet_01v8
spiceprefix=X
}
N 500 80 600 80 {}
C {devices/lab_pin.sym} 600 80 0 1 {name=l16 lab=VNB}
N 440 80 460 80 {}
C {devices/lab_pin.sym} 440 80 0 0 {name=l17 lab=B2}
N 500 110 500 140 {}
N 220 -60 500 -60 {}
N 220 140 500 140 {}
N 220 140 220 160 {}
C {devices/lab_pin.sym} 220 160 0 1 {name=l18 lab=VGND}
N 220 -140 220 -100 {}
N 220 -100 220 -60 {}
N 800 -140 800 -170 {}
C {sky130_fd_pr/pfet_01v8_hvt.sym} 780 -200 0 0 {name=M8
L=0.15
W=1.08
nf=1
mult=1
model=pfet_01v8_hvt
spiceprefix=X
}
N 800 -200 900 -200 {}
C {devices/lab_pin.sym} 900 -200 0 1 {name=l19 lab=VPB}
N 800 -230 800 -250 {}
C {devices/lab_pin.sym} 800 -250 0 1 {name=l20 lab=VPWR}
N 800 -60 800 -30 {}
C {sky130_fd_pr/nfet_01v8.sym} 780 0 0 0 {name=M9
L=0.15
W=0.63
nf=1
mult=1
model=nfet_01v8
spiceprefix=X
}
N 800 0 900 0 {}
C {devices/lab_pin.sym} 900 0 0 1 {name=l21 lab=VNB}
N 800 30 800 50 {}
C {devices/lab_pin.sym} 800 50 0 1 {name=l22 lab=VGND}
N 800 -140 800 -100 {}
N 800 -100 800 -60 {}
N 760 -200 720 -200 {}
N 720 -200 720 -100 {}
N 720 -100 720 0 {}
N 720 0 760 0 {}
N 680 -100 720 -100 {}
N 220 -100 680 -100 {}
N 800 -100 960 -100 {}
C {devices/opin.sym} 960 -100 0 0 {name=p1 lab=X}
C {devices/ipin.sym} -40 -700 0 0 {name=p2 lab=A1}
C {devices/ipin.sym} -40 -670 0 0 {name=p3 lab=A2}
C {devices/ipin.sym} -40 -640 0 0 {name=p4 lab=B1}
C {devices/ipin.sym} -40 -610 0 0 {name=p5 lab=B2}
C {devices/iopin.sym} -40 -580 0 1 {name=p6 lab=VGND}
C {devices/iopin.sym} -40 -550 0 1 {name=p7 lab=VNB}
C {devices/iopin.sym} -40 -520 0 1 {name=p8 lab=VPB}
C {devices/iopin.sym} -40 -490 0 1 {name=p9 lab=VPWR}
C {title_efx.sym} 190 280 0 0 {name=t1 author="ejfogleman"}
C {copyright.sym} 190 350 0 0 {name=s1 place=header value="* Copyright (c) 2026 Eric Fogleman
* SPDX-License-Identifier: Apache-2.0
* Derived from SkyWater sky130_fd_sc_hd (Apache-2.0); see NOTICE"}
