#!/usr/bin/env python3
"""Draw xschem schematics of sky130_fd_sc_hd flip-flops, with the stage
drawing of gen_gates.py plus transmission gates.

    scripts/gen_flops.py              # all cells in CELLS
    scripts/gen_flops.py dfrtp_1      # some of them

Writes xschem/sky130_efx_lvdig__<cell>.sch. Check them with scripts/check_sch.sh.

A flop is a top row (the data path) and chains on the bottom row, each a list
of elements placed left to right:
  Pin(net) / Lab(net)   start a chain at an input pin / a label
  Inv(wp, wn, mp, mn)   inverter, gates wired to the incoming wire
  Tg(ngate, pgate)      transmission gate (special_nfet W=0.36, pfet W=0.42)
  Stg(pu, pd, ...)      a stage with labelled gates (gen_gates networks)
  Net(name, below)      name the wire here; `below` is a list of gen_gates
                        stages drawn on the bottom row (labelled outputs, the
                        last one wired up to this net): the clocked feedback
  Out(port)             output pin
Each spec is read from the PDK's sky130_fd_sc_hd__<cell> (libs.ref/sky130_fd_sc_hd/spice/
sky130_fd_sc_hd.spice); series order and per-transistor
widths/models (D(...)) follow it, so Netgen matches sizes as well.

Transmission-gate transistors are drawn on their side with the 3-terminal
symbols (body as a property); the PDK has no special_nfet symbol, so those use
the nfet_01v8 symbol with model=special_nfet_01v8.
"""
import os
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from lambda_widths import snap_w  # noqa: E402
from gen_gates import (REPO, Sch, D, S, P, inv, stage, is_leaf, size,  # noqa: E402
                       draw_stage, port_column, finish, P_X, BUS, PMARGIN)

YA = -100                   # top row
SPECIAL = 'special_nfet_01v8'
TGDY = 110                  # transmission gate: centre to each transistor
TGX = 70                    # ... and to its vertical terminal wires


class Pin:
    def __init__(s, net): s.net = net
class Lab:
    def __init__(s, net): s.net = net
class Out:
    def __init__(s, net): s.net = net
class Inv:
    def __init__(s, wp, wn, mp=1, mn=1): s.st = inv(wp, wn, mp, mn)
class Stg:
    def __init__(s, pu, pd, wp, wn, mp=1, mn=1): s.st = stage(pu, pd, wp, wn, mp, mn)
class Tg:
    def __init__(s, ngate, pgate, wn=0.36, wp=0.42): s.a = (ngate, pgate, wn, wp)
class Net:
    def __init__(s, net, below=()): s.net, s.below = net, list(below)


def tgate(s, x, y, ngate, pgate, wn, wp, nmodel=SPECIAL):
    """Transmission gate centred at (x, y): nfet above (gate up), pfet below
    (gate down). Returns its left and right terminals."""
    for pmos, yy, rot, gate, w in ((False, y - TGDY, 1, ngate, wn), (True, y + TGDY, 3, pgate, wp)):
        sym = 'pfet3_01v8_hvt' if pmos else 'nfet3_01v8'
        model = 'pfet_01v8_hvt' if pmos else nmodel
        s.ext(x - 30, yy - 30); s.ext(x + 30, yy + 30)
        s.lines.append(f'C {{sky130_fd_pr/{sym}.sym}} {x} {yy} {rot} 0 {{name={s._id("M")}\n'
                       f'L=0.15\nW={snap_w(w, 1):g}\nbody={"VPB" if pmos else "VNB"}\nnf=1\nmult=1\n'
                       f'model={model}\nspiceprefix=X\n}}')
        yg, yl = (yy + 20, yy + 40) if pmos else (yy - 20, yy - 40)
        s.wire(x, yg, x, yl); s.lab(x, yl, gate)
    for sd, xx in ((-30, x - TGX), (30, x + TGX)):
        for yy in (y - TGDY + 20, y + TGDY - 20):
            s.wire(x + sd, yy, xx, yy); s.wire(xx, yy, xx, y)
    return (x - TGX, y), (x + TGX, y)


def depth(t):
    """Distance from a stage output to its rail label, for one network."""
    d0 = BUS if (not is_leaf(t) and t[0] == 'p') else BUS + PMARGIN
    return d0 + size(t)[1] + 20


def ncols(st):
    pu, pd = st[0], st[1]
    return 1 if pu is None else max(size(pu)[0], size(pd)[0])


class Flop:
    def __init__(f, cell):
        f.s, f.cell, f.pinned, f.xb = Sch(), cell, set(), 40

    # ---- bottom-row stage groups (feedback) --------------------------------
    def group_right(f, x0, group):
        """Right edge of a group of stages started at x0 (no drawing)."""
        X = x0 + 160
        for st in group:
            right = X + (ncols(st) - 1) * P_X + 140
            X = right + 260
        return right

    def draw_group(f, x0, group, yb):
        """Draw stages from x0 on row yb; returns the last stage's output."""
        s, X, named = f.s, x0 + 160, None
        for k, (pu, pd, wp, wn, mp, mn, inp, out, L) in enumerate(group):
            right = draw_stage(s, X, pu, pd, wp, wn, mp, mn, L, yout=yb)
            if pu is None:
                if named and inp == named[2]:
                    s.wire(named[0], named[1], X - 100, yb)
                else:
                    s.lab(X - 100, yb, inp, right=False)
            if k == len(group) - 1:
                return (X + 20, yb)
            s.wire(X + 20, yb, right + 40, yb); s.lab(right + 40, yb, out)
            named = (right + 40, yb, out)
            X = right + 260

    # ---- a chain of elements on one row ------------------------------------
    def chain(f, items, y, x0, yb=None):
        """Place items from x0 on row y; returns the right edge."""
        s = f.s
        pt, minx, start = None, x0, None
        for i, it in enumerate(items):
            last = i == len(items) - 1
            if isinstance(it, (Pin, Lab)):
                start = it
            elif isinstance(it, Inv):
                X = minx + 160
                right = draw_stage(s, X, *it.st[:6], yout=y)
                tap = (X - 100, y)
                if pt:
                    s.wire(*pt, *tap)
                elif isinstance(start, Pin):
                    s.pin('ipin', *tap, start.net); f.pinned.add(start.net)
                else:
                    s.lab(*tap, start.net, right=False)
                pt, minx = (X + 20, y), right
            elif isinstance(it, Stg):
                X = minx + 160
                right = draw_stage(s, X, *it.st[:6], yout=y)
                pt, minx = (X + 20, y), right
            elif isinstance(it, Tg):
                x = minx + 60 + TGX
                l, r = tgate(s, x, y, *it.a)
                if pt:
                    s.wire(*pt, *l)
                pt, minx = r, x + TGX + 20
            elif isinstance(it, Net):
                x = max(minx, pt[0]) + 40
                if it.below:
                    x = max(x, f.group_right(f.xb, it.below) + 40)
                s.wire(*pt, x, y)
                if it.below:
                    out = f.draw_group(f.xb, it.below, yb)
                    ym = (y + yb) // 2 + 40
                    s.wire(*out, x, yb); s.wire(x, yb, x, ym); s.wire(x, ym, x, y)
                    s.lab(x, ym, it.net)
                    f.xb = x + 20
                elif last:
                    s.lab(x, y, it.net)
                else:
                    s.wire(x, y, x, y + 30); s.lab(x, y + 30, it.net)
                pt, minx = (x, y), x + 40
            elif isinstance(it, Out):
                x = minx + 40
                s.wire(*pt, x, y); s.pin('opin', x, y, it.net)
                minx = x + 20
        return minx

    def draw(f, top, chains, ports):
        """top: the data path; chains: bottom-row chains after the feedback."""
        # bottom row low enough for the deepest top-row pull-down and the
        # tallest bottom-row pull-up
        down = [TGDY + 60]
        for it in top:
            if isinstance(it, (Inv, Stg)):
                down.append(depth(it.st[1]))
        up = [depth(None)]
        for it in top:
            if isinstance(it, Net):
                up += [depth(st[0]) for st in it.below]
        for ch in chains:
            up += [depth(it.st[0]) for it in ch if isinstance(it, (Inv, Stg))]
        yb = YA + max(down) + max(up) + 120
        f.chain(top, YA, 40, yb)
        for ch in chains:
            f.xb = f.chain(ch, yb, f.xb + 60) + 40
        col = [p for p in ports.split() if p not in f.pinned] + ['VGND', 'VNB', 'VPB', 'VPWR']
        return finish(f.s, f.cell, port_column(f.s, col, ports.split()))


# ---- building blocks --------------------------------------------------------
def clk_chain():
    """CLK -> CLK_N -> CLK_P (master transparent while CLK=0, slave while 1)."""
    return [Pin('CLK'), Inv(0.64, 0.42), Net('CLK_N'), Inv(0.64, 0.42), Net('CLK_P')]


def mfb(fb):
    """Master feedback: clocked inverter of fb, on while CLK=1."""
    return stage(S('CLK_N', fb), S(D('CLK_P', 0.36, SPECIAL), fb), 0.42, 0.42)


def sfb(fb='S_N'):
    """Slave feedback: clocked inverter of fb, on while CLK=0."""
    return stage(S('CLK_P', fb), S(D('CLK_N', 0.36, SPECIAL), fb), 0.42, 0.42)


def slave_cinv(wp_m=None, wn_m=None):
    """Slave input: clocked inverter of M (instead of a transmission gate),
    on while CLK=1."""
    return Stg(S('CLK_N', D('M', wp_m) if wp_m else 'M'),
               S(D('CLK_P', 0.36, SPECIAL), D('M', wn_m) if wn_m else 'M'), 0.42, 0.42)


def oai_sr(x):
    """!((x + RB_N) . SET_B): set wins, reset through RB_N = !RESET_B."""
    return Stg(P(D('SET_B', 0.42), S(x, 'RB_N')), S(P(x, 'RB_N'), D('SET_B', 0.42)), 0.84, 0.64)


def qn_chain(src, w1, mq):
    """Q_N from src through one or two inverters (w1: first of two)."""
    mid = [Inv(*w1)] if w1 else []
    return [Lab(src)] + mid + [Inv(1, 0.65, mq, mq), Out('Q_N')]


# ---- the cells --------------------------------------------------------------
def dfrtp(cell, mq=1, qn=None):
    """D flop, active-low async reset RESET_B; qn: Q_N output multiplier."""
    top = [Pin('D'), Inv(0.42, 0.42), Net('D_N'), Tg('CLK_N', 'CLK_P'),
           Net('M_N', [stage(S('CLK_N', P('RESET_B', 'M')),
                             S(D('CLK_P', 0.36, SPECIAL), 'M', 'RESET_B'), 0.42, 0.42)]),
           Inv(0.84, 0.64), Net('M'), Tg('CLK_P', 'CLK_N'), Net('S', [sfb()]),
           Stg(P('S', 'RESET_B'), S('S', 'RESET_B'), 0.42, 0.42), Net('S_N'),
           Inv(1, 0.65, mq, mq), Out('Q')]
    chains = [clk_chain()] + ([qn_chain('S_N', (0.64, 0.42), qn)] if qn else [])
    return Flop(cell).draw(top, chains, 'CLK D RESET_B')


def dfxtp(cell, mq=1, qn=None):
    """D flop, no reset."""
    top = [Pin('D'), Inv(0.42, 0.42), Net('D_N'), Tg('CLK_N', 'CLK_P'),
           Net('M_N', [mfb('M')]), Inv(0.75, 0.64), Net('M'), Tg('CLK_P', 'CLK_N'),
           Net('S', [sfb()]), Inv(1, 0.65), Net('S_N'), Inv(1, 0.65, mq, mq), Out('Q')]
    chains = [clk_chain()] + ([qn_chain('S_N', (0.64, 0.42), qn)] if qn else [])
    return Flop(cell).draw(top, chains, 'CLK D')


def dfstp(cell, wq1, mq):
    """D flop, active-low async set SET_B; slave driven by a clocked inverter."""
    top = [Pin('D'), Inv(0.84, 0.64), Net('D_N'), Tg('CLK_N', 'CLK_P'),
           Net('M_N', [stage(P('M_N', 'SET_B'), S('M_N', 'SET_B'), 0.42, 0.42, out='M'),
                       mfb('M')]),
           Stg(S('CLK_N', 'M_N'), S('CLK_P', 'M_N'), 0.42, 0.42),
           Net('S', [inv(0.84, 0.54, inp='S', out='S_N'),
                     stage(P(S('CLK_P', 'S_N'), 'SET_B'), S('CLK_N', 'S_N', 'SET_B'), 0.42, 0.42)]),
           Inv(*wq1), Inv(1, 0.65, mq, mq), Out('Q')]
    return Flop(cell).draw(top, [clk_chain()], 'CLK D SET_B')


def dfbbp(cell):
    """D flop, active-low async set SET_B and reset RESET_B, Q and Q_N."""
    top = [Pin('D'), Inv(0.42, 0.42), Net('D_N'), Tg('CLK_N', 'CLK_P'),
           Net('M_N', [mfb('M')]), oai_sr('M_N'), Net('M'),
           slave_cinv(0.84, 0.64), Net('S', [sfb()]),
           oai_sr('S'), Net('S_N'), Inv(0.64, 0.42), Inv(1, 0.65), Out('Q')]
    chains = [clk_chain(), [Pin('RESET_B'), Inv(0.64, 0.42), Net('RB_N')],
              qn_chain('S_N', None, 1)]
    return Flop(cell).draw(top, chains, 'CLK D RESET_B SET_B')


def edfxtp(cell, qn=False):
    """D flop with enable: DE=1 loads D, DE=0 keeps Q (mux from S_N)."""
    top = [Stg(P(S('D', 'DE_N'), S('S_N', 'DE')), P(S('D', 'DE'), S('S_N', 'DE_N')), 0.64, 0.42),
           Net('DM_N'), Tg('CLK_N', 'CLK_P'), Net('M_N', [mfb('M')]),
           Inv(0.75, 0.64), Net('M'), slave_cinv(), Net('S', [sfb()]),
           Inv(1, 0.65), Out('Q')]
    chains = [clk_chain(), [Pin('DE'), Inv(0.64, 0.42), Net('DE_N')],
              [Lab('S'), Inv(0.64, 0.42), Net('S_N')]] + ([qn_chain('S_N', None, 1)] if qn else [])
    return Flop(cell).draw(top, chains, 'CLK D DE')


CELLS = {
    'dfrtp_1':  lambda: dfrtp('dfrtp_1'),
    'dfrtp_2':  lambda: dfrtp('dfrtp_2', mq=2),
    'dfrbp_1':  lambda: dfrtp('dfrbp_1', qn=1),
    'dfrbp_2':  lambda: dfrtp('dfrbp_2', mq=2, qn=2),
    'dfxtp_2':  lambda: dfxtp('dfxtp_2', mq=2),
    'dfxbp_2':  lambda: dfxtp('dfxbp_2', mq=2, qn=2),
    'dfstp_1':  lambda: dfstp('dfstp_1', (0.64, 0.42), 1),
    'dfstp_2':  lambda: dfstp('dfstp_2', (1, 0.65), 2),
    'dfbbp_1':  lambda: dfbbp('dfbbp_1'),
    'edfxtp_1': lambda: edfxtp('edfxtp_1'),
    'edfxbp_1': lambda: edfxtp('edfxbp_1', qn=True),
}

if __name__ == '__main__':
    for cell in sys.argv[1:] or CELLS:
        with open(os.path.join(REPO, 'xschem', f'sky130_efx_lvdig__{cell}.sch'), 'w') as f:
            f.write(CELLS[cell]())
        print(cell)
