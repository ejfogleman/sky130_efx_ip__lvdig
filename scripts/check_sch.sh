#!/bin/bash
# Check standard cell schematics against their PDK netlists.
#
#   scripts/check_sch.sh                  # every xschem/sky130_efx_lvdig__*.sch but allcells
#   scripts/check_sch.sh nand2_1 a21o_1   # some of them
#   scripts/check_sch.sh --png [cell...]  # also render each to a PNG
#
# For each cell: netlist xschem/sky130_efx_lvdig__<cell>.sch as a subckt and run
# Netgen against the PDK's sky130_fd_sc_hd__<cell>, taken from the PDK's library
# netlist (libs.ref/sky130_fd_sc_hd/spice/sky130_fd_sc_hd.spice), renamed, with
# its widths snapped to the lambda grid by scripts/lambda_widths.py --ref (written
# to lvs/check/ref/), as the generators snap the schematics' widths. allcells
# has no PDK counterpart; `make lvs CELL=sky130_efx_lvdig__allcells` checks it.
# Nor do the lvdig-only cells in LVDIG_ONLY (the decaps): they are reported
# and skipped, and `make lvs CELL=...` checks them against their layouts. With --png, also render
# it (2700x1600). Rendering needs an X display: xschem opens a window per cell,
# so it runs under xvfb-run when that is installed. Netlisting never opens one.
# Outputs go to lvs/check/ (ignored by git). Netgen's "Final result" line says
# "match uniquely" even when device sizes differ, so property errors are
# reported separately. Exits 1 if any cell fails.
#
# Needs xschem and netgen on PATH; PDK and PDK_ROOT default to sky130A, ~/.ciel.

R=$(cd "$(dirname "$0")/.." && pwd)
O=$R/lvs/check
PDK=${PDK:-sky130A}
PDK_ROOT=${PDK_ROOT:-$HOME/.ciel}
SETUP=$PDK_ROOT/$PDK/libs.tech/netgen/${PDK}_setup.tcl
mkdir -p "$O/ref"

png=0
if [ "$1" = --png ]; then png=1; shift; fi
xvfb=$(command -v xvfb-run >/dev/null && echo 'xvfb-run -a')

if [ $# -eq 0 ]; then
  set -- $(cd "$R/xschem" && ls sky130_efx_lvdig__*.sch | sed 's/^sky130_efx_lvdig__//; s/\.sch$//' | grep -vx allcells)
fi

LVDIG_ONLY=' decap10 decap20 '

fail=0
for c in "$@"; do
  n=sky130_efx_lvdig__$c
  if [[ $LVDIG_ONLY == *" $c "* ]]; then
    printf '%-16s %s\n' "$c" 'skipped (lvdig-only, no PDK reference)'; continue
  fi
  rm -f "$O/$n.spice" "$O/$c.out"
  if ! python3 "$R/scripts/lambda_widths.py" --ref "$c" "$O/ref/$n.spice"; then
    printf '%-16s %s\n' "$c" 'no PDK reference'; fail=1; continue
  fi
  (cd "$R/xschem" && xschem -n -s -q -x --rcfile xschemrc --tcl 'set top_is_subckt 1' \
     -o "$O" $n.sch >/dev/null 2>&1)
  (cd "$O" && netgen -batch lvs "$n.spice $n" "$O/ref/$n.spice $n" \
     "$SETUP" $c.out >/dev/null 2>&1)
  if [ $png = 1 ]; then
    (cd "$R/xschem" && timeout 60 $xvfb xschem --rcfile xschemrc \
       --command "xschem print png $O/$c.png 2700 1600; exit" $n.sch >/dev/null 2>&1)
  fi
  if grep -q 'Circuits match uniquely' "$O/$c.out" 2>/dev/null; then
    if grep -q 'Property errors were found' "$O/$c.out"; then r='PROPERTY ERRORS'; fail=1
    else r='match'; fi
  else
    r=$(grep -m1 'Final result' "$O/$c.out" 2>/dev/null || echo 'no report'); fail=1
  fi
  printf '%-16s %s\n' "$c" "$r"
done
exit $fail
