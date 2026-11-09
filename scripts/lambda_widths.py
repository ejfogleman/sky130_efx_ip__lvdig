"""Transistor finger widths on the efx lambda grid (L = 0.18 um).

MOS lengths are not snapped (only the source/drain pitch is on the grid);
resistor lengths are (conb_1: 0.5 -> 0.54).

The sky130_efx_lvdig layouts use finger widths of 2, 2.5, 3, 3.5, 4, 4.5, 5
and 6 L. snap_w() takes a total width (as xschem's W, which is the total over
nf fingers) and returns the total width with each finger snapped to the
nearest of those. Exact ties go to the wider finger.

    python3 scripts/lambda_widths.py                 # the mapping for the library cells' PDK widths
    python3 scripts/lambda_widths.py --ref CELL OUT.spice # PDK cell, renamed and snapped
    python3 scripts/lambda_widths.py IN.spice OUT.spice   # snap every w= in a PDK-style netlist

The PDK cells come straight from the PDK's library netlist,
$PDK_ROOT/$PDK/libs.ref/sky130_fd_sc_hd/spice/sky130_fd_sc_hd.spice (defaults
~/.ciel, sky130A), which is Magic's extraction of hd's layouts: one device per
finger, so each w= is a finger width. --ref is how scripts/check_sch.sh builds
its LVS references: sky130_fd_sc_hd__CELL renamed sky130_efx_lvdig__CELL, sizes
snapped. (Until 2026-11-08 these were copies kept in netlist/.)
"""
import glob
import os
import re
import sys

L = 0.18
GRID_L = (2, 2.5, 3, 3.5, 4, 4.5, 5, 6)
GRID = tuple(round(n * L, 6) for n in GRID_L)


def snap_finger(w):
    """The grid width nearest to finger width w (um); ties go wider."""
    return min(GRID, key=lambda g: (abs(g - w), -g))


def snap_w(w_total, nf=1):
    """Total width w_total (um) over nf fingers, each finger snapped."""
    return round(snap_finger(w_total / nf) * nf, 6)


def pdk_spice():
    root = os.environ.get('PDK_ROOT') or os.path.expanduser('~/.ciel')
    pdk = os.environ.get('PDK') or 'sky130A'
    return os.path.join(root, pdk, 'libs.ref', 'sky130_fd_sc_hd', 'spice', 'sky130_fd_sc_hd.spice')


def pdk_cells():
    """{cell: .subckt text} of every hd cell in the PDK's library netlist."""
    text = open(pdk_spice()).read()
    return {m.group(1): m.group(0) for m in
            re.finditer(r'^\.subckt sky130_fd_sc_hd__(\S+) .*?^\.ends', text, re.M | re.S)}


def lib_cells():
    """The library's cells: every xschem/sky130_efx_lvdig__*.sch but allcells."""
    repo = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
    names = (os.path.basename(f)[len('sky130_efx_lvdig__'):-4]
             for f in glob.glob(os.path.join(repo, 'xschem', 'sky130_efx_lvdig__*.sch')))
    return sorted(c for c in names if c != 'allcells')


def ref_netlist(cell, dst):
    """The PDK's sky130_fd_sc_hd__<cell>, renamed sky130_efx_lvdig__<cell>,
    with its sizes snapped (snap_netlist)."""
    cells = pdk_cells()
    if cell not in cells:
        sys.exit(f'{cell}: no sky130_fd_sc_hd__{cell} in {pdk_spice()}')
    body = cells[cell].replace(f'sky130_fd_sc_hd__{cell}', f'sky130_efx_lvdig__{cell}', 1)
    open(dst, 'w').write(f'* sky130_fd_sc_hd__{cell} from {pdk_spice()}\n'
                         f'* renamed, sizes snapped to the lambda grid\n{snap_text(body)}\n')


def snap_netlist(src, dst):
    open(dst, 'w').write(snap_text(open(src).read()))


def snap_text(text):
    """A SPICE netlist with every finger width and every resistor length
    snapped (MOS lengths are kept: the layouts put the source/drain strips on a
    lambda pitch, not the gate edges). The PDK
    writes MOS widths as w=<n>u in its scaled units, so w=420000u is 0.42 um
    and w=1e+06u is 1.00 um; the output uses the same form (w=450000u).
    Unitless widths (conb_1's resistors: w=0.48) are in um."""

    def rw(m):
        if m.group(2):
            return f'w={snap_finger(float(m.group(1)) * 1e-6) * 1e6:.0f}u'
        return f'w={snap_finger(float(m.group(1))):g}'

    text = re.sub(r'\bw=([0-9.e+]+)(u?)(?=\s|$)', rw, text, flags=re.M)

    # resistor lengths (conb_1: l=0.5) go to the nearest multiple of L
    # (0.54); MOS lengths are kept, as their strip pitch carries the grid
    def rl(line):
        if 'sky130_fd_pr__res_' not in line:
            return line
        return re.sub(r'\bl=([0-9.e+]+)(?=\s|$)',
                      lambda m: f'l={round(round(float(m.group(1)) / L) * L, 6):g}', line)
    return ''.join(rl(x) for x in text.splitlines(keepends=True))


if __name__ == '__main__':
    if len(sys.argv) == 4 and sys.argv[1] == '--ref':
        ref_netlist(sys.argv[2], sys.argv[3])
    elif len(sys.argv) == 3:
        snap_netlist(sys.argv[1], sys.argv[2])
    else:
        cells = pdk_cells()
        widths = {}
        for c in lib_cells():
            for line in cells[c].splitlines():
                m = re.match(r'^X\S*\s.*\s(sky130_fd_pr__\S+)\s+w=([0-9.e+]+)u', line)
                if m:
                    key = (m.group(1).replace('sky130_fd_pr__', ''), float(m.group(2)) * 1e-6)
                    widths[key] = widths.get(key, 0) + 1
        print(f'{"model":20s} {"W":>6s} -> {"snapped":>7s}  {"(L)":>5s}  count')
        for (model, w), n in sorted(widths.items()):
            g = snap_finger(w)
            print(f'{model:20s} {w:6.2f} -> {g:7.2f}  {g / L:5.1f}  {n}')
