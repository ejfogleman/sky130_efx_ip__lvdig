#!/usr/bin/env python3
"""Draw xschem schematics of simple and complex sky130_fd_sc_hd gates: chains
of static CMOS stages, each a pull-up and a pull-down series/parallel network.

    scripts/gen_gates.py              # all cells in CELLS
    scripts/gen_gates.py nand2_1 ...  # some of them

Writes xschem/sky130_efx_lvdig__<cell>.sch. Check them with scripts/check_sch.sh.

Each cell is written by hand from its PDK netlist (sky130_fd_sc_hd__<cell> in the PDK's
libs.ref/sky130_fd_sc_hd/spice/sky130_fd_sc_hd.spice; `scripts/lambda_widths.py --ref <cell> OUT`
writes it renamed and snapped):
  - a network is an input name (one transistor), S(...) (series, listed from
    the stage output towards the rail) or P(...) (parallel, drawn left to right);
  - the series order matters: Netgen does not reorder transistors in a stack;
  - identical transistors in parallel are one device with mult=N.
  - widths are the PDK's, written snapped to the lambda grid (lambda_widths.snap_w:
    2, 2.5, 3, 3.5, 4, 4.5, 5, 6 L per finger); tables keep the PDK values.

Layout: pfets above, nfets below, the stage output between them; gates of an
inverter are wired, other gates labelled; body ties are VPB/VNB labels.
"""
import os
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from lambda_widths import snap_w  # noqa: E402

REPO = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))


def S(*a): return ('s', a)
def P(*a): return ('p', a)


class D:
    """One transistor with its own width and/or model (default: the stage's
    width, nfet_01v8 / pfet_01v8_hvt), e.g. D('CLK_P', 0.36, 'special_nfet_01v8')."""
    def __init__(s, gate, w=None, model=None):
        s.gate, s.w, s.model = gate, w, model


def is_leaf(t):
    return t is None or isinstance(t, (str, D))


# A stage: (pull-up, pull-down, Wp, Wn, mult p, mult n, inp, out, L).
#   inp  inverter only: the net on its wired gates when no previous stage
#        drives it (a port gets a pin, an internal net a label)
#   out  name of the stage output net: an output port gets a pin, any other
#        net a label, and the output does not drive the next stage. Without it
#        the output is wired to the next stage (which must be an inverter), or
#        to the output pin if it is the last stage.
#   l    gate length of all its transistors
def inv(wp, wn, mp=1, mn=1, inp=None, out=None, l=0.15):
    return (None, None, wp, wn, mp, mn, inp, out, l)  # gates wired, no labels


def nand(ins, wp, wn, mp=1, mn=1, out=None, l=0.15):  # ins: nfet stack, output first
    ins = ins.split()
    return (P(*sorted(ins)), S(*ins), wp, wn, mp, mn, None, out, l)


def nor(ins, wp, wn, mp=1, mn=1, out=None, l=0.15):   # ins: pfet stack, output first
    ins = ins.split()
    return (S(*ins), P(*sorted(ins)), wp, wn, mp, mn, None, out, l)


def stage(pu, pd, wp, wn, mp=1, mn=1, out=None, l=0.15):
    return (pu, pd, wp, wn, mp, mn, None, out, l)


# 2:1 mux: S_N = !S, then two tristate inverters onto one node (A0 conducts
# for S=0, A1 for S=1; data transistors next to the node), then an inverter
def mux2(wp, wn, mo):
    return [inv(wp, wn, inp='S', out='S_N'),
            stage(P(S('A0', 'S'), S('A1', 'S_N')), P(S('A0', 'S_N'), S('A1', 'S')), wp, wn),
            inv(1, 0.65, mo, mo)]


# cell: (input ports, output ports, stages)
CELLS = {
    'inv_1':    ('A', 'Y', [inv(1, 0.65)]),
    'clkinv_1': ('A', 'Y', [inv(0.84, 0.42, 2, 1)]),
    'inv_2':    ('A', 'Y', [inv(1, 0.65, 2, 2)]),
    'inv_4':    ('A', 'Y', [inv(1, 0.65, 4, 4)]),
    'clkinv_2': ('A', 'Y', [inv(1, 0.42, 3, 2)]),
    'clkinv_4': ('A', 'Y', [inv(1, 0.42, 6, 4)]),
    'clkinv_8': ('A', 'Y', [inv(1, 0.42, 12, 8)]),
    'buf_1':    ('A', 'X', [inv(0.79, 0.52), inv(0.79, 0.52)]),
    'clkbuf_1': ('A', 'X', [inv(0.79, 0.52), inv(0.79, 0.52)]),
    'buf_2':    ('A', 'X', [inv(0.64, 0.42), inv(1, 0.65, 2, 2)]),
    'clkbuf_2': ('A', 'X', [inv(1, 0.42), inv(1, 0.42, 2, 2)]),
    'buf_4':    ('A', 'X', [inv(1, 0.65), inv(1, 0.65, 4, 4)]),
    'clkbuf_4': ('A', 'X', [inv(1, 0.42), inv(1, 0.42, 4, 4)]),
    'clkbuf_8': ('A', 'X', [inv(1, 0.42, 2, 2), inv(1, 0.42, 8, 8)]),
    'nand2_1':  ('A B', 'Y', [nand('A B', 1, 0.65)]),
    'nand2_2':  ('A B', 'Y', [nand('A B', 1, 0.65, 2, 2)]),
    'nor2_1':   ('A B', 'Y', [nor('B A', 1, 0.65)]),
    'nor2_2':   ('A B', 'Y', [nor('B A', 1, 0.65, 2, 2)]),
    'nor3_2':   ('A B C', 'Y', [nor('C B A', 1, 0.65, 2, 2)]),
    'and2_1':   ('A B', 'X', [nand('A B', 0.42, 0.42), inv(1, 0.65)]),
    'and2_2':   ('A B', 'X', [nand('A B', 0.42, 0.42), inv(1, 0.65, 2, 2)]),
    'and2_4':   ('A B', 'X', [nand('A B', 1, 0.65), inv(1, 0.65, 4, 4)]),
    'and3_1':   ('A B C', 'X', [nand('A B C', 0.42, 0.42), inv(1, 0.65)]),
    'and4_2':   ('A B C D', 'X', [nand('A B C D', 0.42, 0.42), inv(1, 0.65, 2, 2)]),
    'or2_1':    ('A B', 'X', [nor('B A', 0.42, 0.42), inv(1, 0.65)]),
    'or2_2':    ('A B', 'X', [nor('B A', 0.42, 0.42), inv(1, 0.65, 2, 2)]),
    'or2_4':    ('A B', 'X', [nor('B A', 1, 0.65), inv(1, 0.65, 4, 4)]),
    'or3_1':    ('A B C', 'X', [nor('C B A', 0.42, 0.42), inv(1, 0.65)]),
    # complex gates: AND-OR-invert / OR-AND-invert, then an inverter
    'a21o_1':   ('A1 A2 B1', 'X', [stage(S('B1', P('A1', 'A2')), P(S('A1', 'A2'), 'B1'), 1, 0.65),
                                   inv(1, 0.65)]),
    'a22o_1':   ('A1 A2 B1 B2', 'X', [stage(S(P('B1', 'B2'), P('A1', 'A2')),
                                            P(S('A1', 'A2'), S('B1', 'B2')), 1, 0.65),
                                      inv(1, 0.65)]),
    'o21a_1':   ('A1 A2 B1', 'X', [stage(P(S('A2', 'A1'), 'B1'), S('B1', P('A1', 'A2')), 1, 0.65),
                                   inv(1, 0.65)]),
    'mux2_1':   ('A0 A1 S', 'X', mux2(0.42, 0.42, 1)),
    'mux2_2':   ('A0 A1 S', 'X', mux2(0.64, 0.42, 2)),
    # half adder: COUT_N = !(A.B), COUT = A.B, SUM = COUT_N.(A+B) = A xor B
    'ha_1':     ('A B', 'COUT SUM', [nand('B A', 0.42, 0.42, out='COUT_N'),
                                     inv(1, 0.65, inp='COUT_N', out='COUT'),
                                     stage(P('COUT_N', S('B', 'A')), S('COUT_N', P('A', 'B')),
                                           0.42, 0.42),
                                     inv(1, 0.65, out='SUM')]),
    # delay buffers: four inverters, the middle two with long (0.5 um) gates
    'dlygate4sd3_1':   ('A', 'X', [inv(0.42, 0.42), inv(0.42, 0.42, l=0.5),
                                   inv(0.42, 0.42, l=0.5), inv(1, 0.65)]),
    'clkdlybuf4s50_1': ('A', 'X', [inv(1, 0.42), inv(0.82, 0.65, l=0.5),
                                   inv(0.82, 0.65, l=0.5), inv(1, 0.42)]),
}

P_X = 280              # column pitch
GAP = 20               # wire between series elements
PMARGIN = 30           # wire from a parallel bus to its branches
YOUT = -100            # stage output row; pfets above, nfets below
BUS = 40               # output bus distance from YOUT


class Sch:
    def __init__(s):
        s.lines, s.n = [], {'M': 0, 'l': 0, 'p': 0}
        s.xmin = s.ymin = s.xmax = s.ymax = 0
        s.yout, s.L = YOUT, 0.15        # row of the stage being drawn, gate length

    def _id(s, k):
        s.n[k] += 1
        return f'{k}{s.n[k] - (1 if k == "M" else 0)}'

    def ext(s, x, y):
        s.xmin, s.xmax = min(s.xmin, x), max(s.xmax, x)
        s.ymin, s.ymax = min(s.ymin, y), max(s.ymax, y)

    def wire(s, x1, y1, x2, y2):
        if (x1, y1) == (x2, y2):
            return
        s.ext(x1, y1); s.ext(x2, y2)
        s.lines.append(f'N {x1} {y1} {x2} {y2} {{}}')

    def lab(s, x, y, net, right=True):
        s.lines.append(f'C {{devices/lab_pin.sym}} {x} {y} 0 {1 if right else 0} '
                       f'{{name={s._id("l")} lab={net}}}')

    def pin(s, kind, x, y, net, flip=0):
        s.lines.append(f'C {{devices/{kind}.sym}} {x} {y} 0 {flip} '
                       f'{{name={s._id("p")} lab={net}}}')

    def fet(s, pmos, x, y, w, m, gate, model=None):
        model = model or ('pfet_01v8_hvt' if pmos else 'nfet_01v8')
        sym = 'pfet_01v8_hvt' if pmos else 'nfet_01v8'
        s.ext(x - 20, y - 30); s.ext(x + 20, y + 30)
        s.lines.append(f'C {{sky130_fd_pr/{sym}.sym}} {x} {y} 0 0 {{name={s._id("M")}\n'
                       f'L={s.L:g}\nW={snap_w(w, 1):g}\nnf=1\nmult={m}\nmodel={model}\n'
                       f'spiceprefix=X\n}}')
        s.wire(x + 20, y, x + 120, y)
        s.lab(x + 120, y, 'VPB' if pmos else 'VNB')
        if gate:
            s.wire(x - 40, y, x - 20, y)
            s.lab(x - 40, y, gate, right=False)


def size(t):
    """(columns, height) of a network; height runs from its output-side
    terminal to its rail-side terminal."""
    if is_leaf(t):
        return 1, 60
    kind, ch = t
    sz = [size(c) for c in ch]
    if kind == 's':
        return max(c for c, _ in sz), sum(h for _, h in sz) + GAP * (len(ch) - 1)
    return sum(c for c, _ in sz), max(h for _, h in sz) + 2 * PMARGIN


def place(s, t, pmos, x, d, w, m):
    """Draw network t with its output-side terminal at (x+20, depth d). Depth
    grows away from the output: down for nfets, up for pfets."""
    y = (lambda dd: s.yout - dd) if pmos else (lambda dd: s.yout + dd)
    cols, h = size(t)
    if isinstance(t, D):
        s.fet(pmos, x, y(d + 30), t.w or w, m, t.gate, t.model)
    elif is_leaf(t):
        s.fet(pmos, x, y(d + 30), w, m, t)
    elif t[0] == 's':
        for i, c in enumerate(t[1]):
            if i:
                s.wire(x + 20, y(d), x + 20, y(d + GAP)); d += GAP
            place(s, c, pmos, x, d, w, m)
            d += size(c)[1]
    else:
        xc = x
        for i, c in enumerate(t[1]):
            cc, ch = size(c)
            s.wire(xc + 20, y(d), xc + 20, y(d + PMARGIN))
            place(s, c, pmos, xc, d + PMARGIN, w, m)
            s.wire(xc + 20, y(d + PMARGIN + ch), xc + 20, y(d + h))
            if i:
                s.wire(xp + 20, y(d), xc + 20, y(d))
                s.wire(xp + 20, y(d + h), xc + 20, y(d + h))
            xp, xc = xc, xc + cc * P_X
    return cols, h


def network(s, t, pmos, X, w, m):
    """A stage's pull-up or pull-down, from the output bus to its rail."""
    y = (lambda dd: s.yout - dd) if pmos else (lambda dd: s.yout + dd)
    d0 = BUS if (not is_leaf(t) and t[0] == 'p') else BUS + PMARGIN
    s.wire(X + 20, y(BUS), X + 20, y(d0))
    cols, h = place(s, t, pmos, X, d0, w, m)
    rail = d0 + h
    s.wire(X + 20, y(rail), X + 20, y(rail + 20))
    s.lab(X + 20, y(rail + 20), 'VPWR' if pmos else 'VGND')
    return cols


def draw_stage(s, X, pu, pd, wp, wn, mp, mn, L=0.15, yout=YOUT):
    """One stage with its first column at X and its output at (X+20, yout).
    Returns the x of its right edge (body labels included). An inverter
    (pu is None) has its gates wired together and tapped at (X-100, yout)."""
    s.yout, s.L = yout, L
    cols = max(network(s, pu, True, X, wp, mp), network(s, pd, False, X, wn, mn))
    s.wire(X + 20, yout - BUS, X + 20, yout); s.wire(X + 20, yout, X + 20, yout + BUS)
    if pu is None:
        yp, yn = yout - BUS - PMARGIN - 30, yout + BUS + PMARGIN + 30
        s.wire(X - 20, yp, X - 60, yp); s.wire(X - 60, yp, X - 60, yout)
        s.wire(X - 60, yout, X - 60, yn); s.wire(X - 60, yn, X - 20, yn)
        s.wire(X - 100, yout, X - 60, yout)
    return X + (cols - 1) * P_X + 140


def port_column(s, nets, ports):
    """Pins for nets (ipin for ports, iopin for power and body) in a column
    above the drawing; returns the y of the top pin."""
    y = top = s.ymin - 40 - 30 * (len(nets) - 1)
    for net in nets:
        sig = net in ports
        s.pin('ipin' if sig else 'iopin', s.xmin - 40, y, net, flip=0 if sig else 1)
        y += 30
    return top


# Copyright/license notice (xschem/copyright.sym, place=header): written at
# the top of every netlist made from the schematic.
COPYRIGHT = '* Copyright (c) 2026 Eric Fogleman\n* SPDX-License-Identifier: Apache-2.0\n* Derived from SkyWater sky130_fd_sc_hd (Apache-2.0); see NOTICE'


def finish(s, cell, top):
    """Header, provenance note, title block and copyright notice; returns the
    file text."""
    hdr = ['v {xschem version=3.4.7 file_version=1.2}', 'G {}', 'K {}', 'V {}', 'S {}', 'E {}',
           f'T {{Schematic of sky130_efx_lvdig__{cell}, from the PDK netlist of sky130_fd_sc_hd__{cell}\n'
           f'(libs.ref/sky130_fd_sc_hd/spice/sky130_fd_sc_hd.spice)}} '
           f'{s.xmin - 60} {top - 80} 0 0 0.3 0.3 {{}}']
    tx = max(s.xmin + 160, s.xmax - 790)
    s.lines.append(f'C {{title_efx.sym}} {tx} {s.ymax + 120} 0 0 {{name=t1 author="ejfogleman"}}')
    s.lines.append(f'C {{copyright.sym}} {tx} {s.ymax + 190} 0 0 {{name=s1 place=header value="{COPYRIGHT}"}}')
    return '\n'.join(hdr + s.lines) + '\n'


def draw(cell, ins, out, stages):
    s = Sch()
    X, prev, named = 200, None, None   # named: last labelled stage output (x, y, net)
    ports, pinned = ins.split(), set()
    outs = out.split()
    for k, (pu, pd, wp, wn, mp, mn, inp, sout, L) in enumerate(stages):
        right = draw_stage(s, X, pu, pd, wp, wn, mp, mn, L)
        if pu is None:                          # inverter: drive its gate tap
            net = inp or ins
            if prev:
                s.wire(*prev, X - 100, YOUT)
            elif named and net == named[2]:     # labelled just before: wire it
                s.wire(named[0], named[1], X - 100, YOUT)
            elif net in ports:
                s.pin('ipin', X - 100, YOUT, net); pinned.add(net)
            else:
                s.lab(X - 100, YOUT, net, right=False)
        if k == len(stages) - 1 or sout:       # output pin or labelled net
            net = sout or out
            s.wire(X + 20, YOUT, right + 40, YOUT)
            if net in outs: s.pin('opin', right + 40, YOUT, net)
            else:           s.lab(right + 40, YOUT, net)
            named = (right + 40, YOUT, net)
            s.ext(right + 60, YOUT)
            prev, X = None, right + 260
        else:
            prev, X = (X + 20, YOUT), right + 160
    # port column: inputs not wired to a pin above, power and body
    col = [p for p in ports if p not in pinned] + ['VGND', 'VNB', 'VPB', 'VPWR']
    return finish(s, cell, port_column(s, col, ports))


if __name__ == '__main__':
    for cell in sys.argv[1:] or CELLS:
        ins, out, stages = CELLS[cell]
        path = os.path.join(REPO, 'xschem', f'sky130_efx_lvdig__{cell}.sch')
        with open(path, 'w') as f:
            f.write(draw(cell, ins, out, stages))
        print(cell)
