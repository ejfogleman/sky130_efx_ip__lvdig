# Build sky130_efx_lvdig__dfxtp_2 (66L, 11.88 um) (2026-11-07): li plus two
# met1 clock lines (CLK_N, CLK_P; approved by the user for the flops), and the
# device cells it needs.
#
#   cd mag && magic -dnull -noconsole ../scripts/mag_build_dfxtp.tcl
#
# Writes new cells only (skips any whose .mag exists). Procs:
# scripts/mag_lvdig_lib.tcl.
#
# Netlist (xschem/sky130_efx_lvdig__dfxtp_2.sch): CLK_N = !CLK, CLK_P =
# !CLK_N; D_N = !D; TG1 D_N-M_N (n CLK_N special 0.36, p CLK_P); master
# feedback M_N-CLK_P-net2-M-VGND / M_N-CLK_N-net1-M-VPWR; M = !M_N; TG2 M-S
# (n CLK_P special, p CLK_N); slave feedback S-CLK_N-net4-S_N-VGND /
# S-CLK_P-net3-S_N-VPWR; S_N = !S; Q = !S_N (2 fingers).
#
# Left to right: the two clock inverters (each its own island, contact over
# its rails strip), then one main island per row from the D inverter to the
# S_N inverter, then the Q inverter. Main island strips (x um):
#   2.88 rails | D | 3.42 D_N | TG1 3.69 | 4.50 M_N | mfb clk 4.77 | (no
#   contact) | M 5.67 | 5.94 rails | M_N 6.21 | 6.66 M | TG2 6.93 | 7.74 S |
#   sfb clk 8.01 | (no contact) | S_N 8.91 | 9.18 rails | S 9.45 | 9.72 S_N
# The rows have mixed widths (special nfets 0.36 beside 0.45/0.63 nfets), so
# the islands are drawn here as overlapping diffusion rectangles: each width
# step sits >= 0.25 past its own gate (poly.7) and >= 0.075 from the next
# gate (poly.4), and clear of the polycontacts (licon.14).
#
# Clock gates are short stubs (technique 1: the nmos and pmos halves of a
# column take different clocks). Their contacts: PL y 0.72-1.08 above the
# 0.36 nmos (licon at y 0.90), PH y 1.62-1.98 below the 0.45 pmos (licon at
# 1.80); each has a via stacked on its licon. met1 tracks: PL y 0.76-1.04,
# mid 1.21-1.49, PH 1.66-1.94. Master: CLK_P on PL, CLK_N on PH; slave the
# reverse. So the feedback columns (mfb, sfb) are direct (each pad under its
# own line) and leave a li corridor at y 1.26-1.44 between their pads, for
# M_N and S to reach the inverter after them. The transmission gates are
# crossing columns: the nmos pad rises in li to the PH line, the pmos stub
# jogs in poly (y 1.275-1.455) to a PL contact 0.54 to the right. TG2's
# riser also swaps the lines: master CLK_P (PL) lands on its bottom, slave
# CLK_P (PH) on its top; CLK_N steps from PH down through the mid track to
# PL around it.
# Data verticals (D_N, M_N, M, S, S_N) are 1L li on the side away from the
# clock pads. M and S_N return to the gate before them along y 0.72-0.90
# (over 'b'-contact rails strips) to a contact on that gate.

source ../scripts/mag_lvdig_lib.tcl
source ../scripts/mag_lvdig_flop.tcl

set cell sky130_efx_lvdig__dfxtp_2
if {[file exists $cell.mag]} { puts "skip $cell"; quit -noprompt }
load $cell
dfx_core
lvdig_rails 11.88
power_pins
save_drc $cell
quit -noprompt
