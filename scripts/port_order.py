#!/usr/bin/env python3
"""Number each library cell's layout ports in its schematic's port order:

    scripts/port_order.py [--check] [cell ...]

Magic orders a cell's .subckt ports by its pin labels' port numbers; xschem
orders the schematic's by the symbol's pins, which is the order of the cdl
(cdl/sky130_efx_lvdig.cdl): logic pins, then VGND VNB VPB VPWR. A design that
uses the cells as black boxes (primitive symbols) is compared by Netgen pin by
pin in that order, so the two must agree. Since 2026-11-17 every cell's layout
ports are numbered 1..n in the cdl's order; the builders number ports in
placing order, so run this after rebuilding a cell (gen_lib_netlist.py fails
on a cell that is out of order).

Edits the `port N ...` line after each pin label in mag/<cell>.mag in place,
so the geometry and the cell's timestamp don't change (parents don't see a
timestamp mismatch). With no cells: every .subckt in the cdl except allcells,
which is not a library cell. --check only reports cells out of order (exit 1).
"""
import re
import sys

CDL = 'cdl/sky130_efx_lvdig.cdl'
LABEL = re.compile(r'^(?:flabel|rlabel) .* (\S+)\n(port )(\d+)( .*)$', re.M)


def cdl_ports():
    ports = {}
    for ln in open(CDL):
        if ln.startswith('.subckt '):
            t = ln.split()
            ports[t[1]] = t[2:]
    return ports


def fix(cell, want, check):
    path = f'mag/{cell}.mag'
    text = open(path).read()
    have = {}
    for m in LABEL.finditer(text):
        have.setdefault(m.group(1), set()).add(int(m.group(3)))
    if sorted(have) != sorted(want):
        sys.exit(f'{path}: port labels {sorted(have)} differ from {CDL}: {want}')
    new = {name: i + 1 for i, name in enumerate(want)}
    if all(have[n] == {new[n]} for n in want):
        return False
    if check:
        old = sorted(want, key=lambda n: min(have[n]))
        print(f'{cell}: layout {" ".join(old)}, cdl {" ".join(want)}')
        return True
    text = LABEL.sub(lambda m: m.group(0)[:m.start(3) - m.start(0)] + str(new[m.group(1)])
                     + m.group(4), text)
    open(path, 'w').write(text)
    print(f'{cell}: renumbered')
    return True


def main(args):
    check = '--check' in args
    cells = [a for a in args if a != '--check']
    ports = cdl_ports()
    if not cells:
        cells = sorted(c for c in ports if not c.endswith('__allcells'))
    changed = 0
    for c in cells:
        if c not in ports:
            sys.exit(f'{c}: not in {CDL}')
        changed += fix(c, ports[c], check)
    print(f'{len(cells)} cells, {changed} {"out of order" if check else "renumbered"}')
    return 1 if check and changed else 0


if __name__ == '__main__':
    sys.exit(main(sys.argv[1:]))
