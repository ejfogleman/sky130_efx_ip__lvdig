# Fresh-context pickup -- 16 sky130_efx_lvdig layouts LVS-clean and abutting DRC-clean

**Written**: 2026-11-06, superseding `pickup-2026-11-06-lvdig-schematics-first-layouts.md`
**Repo**: sky130_efx_ip__diglib, branch `main`
**HEAD**: `97d0bd5` -- "Add standard cell lists for sar_dev and pll96". **Nothing from this session or the previous one is committed**: ~160 modified/untracked paths (`git status --short`).

The library is `sky130_efx_lvdig__<cell>`: the sky130_fd_sc_hd cells used by sar_dev and pll96 (`/home/ejf/Projects/sky130_efx_ip__diglib/doc/cells_*.txt`), as xschem schematics (all done) and new Magic layouts on the efx lambda grid (L = 0.18 um; `/home/ejf/Projects/sky130_efx_ip__diglib/mag/README.md`). Repo conventions: `/home/ejf/Projects/sky130_efx_ip__diglib/CLAUDE.md` (read first). Everything in the prior pickup's section 1 (rename, width snapping, schematics, Makefile LVS fixes, efx tool changes) still stands; this memo covers what came after.

## 1. What landed (all uncommitted; file list from this session's edits)

Most recent first.

- **Rail contacts on a global 2L grid, even-L widths** (user chose this, "option (b)"): every cell's rails now have one viali area, the cut's size (0.17 um square), centred in each 0.36 um slot (cuts at x = 0.36k + 0.18). Cells whose width was an odd number of L were widened by L on the right: inv_1 (8L), nand2_1, nor2_1, clkinv_2 (14L), buf_2, clkbuf_2 (18L), buf_4, clkbuf_4 (24L). Script: `/home/ejf/Projects/sky130_efx_ip__diglib/scripts/mag_rails_grid.tcl` (proc `lvdig_rails w`: rails, wells, viali, FIXED_BBOX). Why: with per-cell contact runs, abutted cells gave mcon.2 across edges and flipped rows sharing a rail had partly overlapping viali (Magic error "can't abut or partially overlap between subcells").
- **N-well extended to y 3.42** (outer edge of the VPWR met1 rail) in all 16 cells, so flipped rows sharing VPWR have one well (was 2.88, giving nwell.2a 0.36 < 1.27 between rows). Script: `scripts/mag_nwell_extend.tcl` (one-off).
- **`mag/sky130_efx_lvdig__allcells.mag`**: all 16 cells abutted by FIXED_BBOX in 4 rows, rows 1 and 3 flipped (`getcell ... v`). Built by `scripts/mag_build_allcells.tcl` (reads widths from FIXED_BBOX; delete the .mag before rerunning).
- **9 more layouts** via the parameterised builder `/home/ejf/Projects/sky130_efx_ip__diglib/scripts/mag_build_inverters.tcl` (1- or 2-stage inverters, uneven nmos/pmos finger counts, now uses `lvdig_rails` and even-L widths; skips cells whose .mag exists): clkinv_1/2/4/8, clkbuf_1/2/4/8, buf_4.
- **clkinv_4 added to the library** (not in the cell lists, like inv_4): `netlist/sky130_efx_lvdig__clkinv_4.spice`, `xschem/sky130_efx_lvdig__clkinv_4.sym`, `'clkinv_4'` in `scripts/gen_gates.py`. 48 schematics now.
- Earlier layouts (prior pickup): inv_1, inv_2, buf_1 (user-drawn, finished by Claude), inv_4, buf_2, nand2_1, nor2_1.

## 2. Current state / gate status

Inside `nix develop ~/nix-efx`, from the repo root:
```
for c in inv_1 inv_2 inv_4 buf_1 buf_2 buf_4 nand2_1 nor2_1 clkinv_1 clkinv_2 clkinv_4 clkinv_8 clkbuf_1 clkbuf_2 clkbuf_4 clkbuf_8; do make lvs CELL=sky130_efx_lvdig__$c | grep '^LVS'; done
                                     # 16 x "match" (checked this session, after the rail change)
scripts/check_sch.sh                 # 48 x "match", exit 0 (last full run before clkinv_4; clkinv_4 checked alone)
cd mag && magic -dnull -noconsole    # then: load sky130_efx_lvdig__allcells; select top cell; drc check; drc catchup; drc list count total  -> 0
```
`make lvs` prints xschem `Error 10 (ignored)`: expected. Each cell alone: Magic DRC 0.

Cell widths now (L): inv_1 8, inv_2 10, inv_4 16, buf_1 14, buf_2 18, buf_4 24, nand2_1 14, nor2_1 14, clkinv_1 10, clkinv_2 14, clkinv_4 22, clkinv_8 40, clkbuf_1 14, clkbuf_2 18, clkbuf_4 24, clkbuf_8 38. Height: FIXED_BBOX y -0.18 .. 3.06 um.

Layout conventions (updated from the prior pickup):
- Rails: li 2L (2.88-3.24 / -0.36-0), met1 4L (2.70-3.42 / -0.54-0.18), viali cut-sized on the 0.36 grid. **Widths must be an even number of L.**
- Wells: nwell full width y 1.44-3.42, pwell full width 0-1.08.
- Devices at x = 0.36 + 0.54 i, nmos y 0.18, pmos with diffusion top at 2.70; gate bar y 1.08-1.44; polycont over the stage's first strip column in the inter-row gap; outputs joined in li in that gap; li straps to rails; pins as inv_1 (A, output, VPWR, VGND, VPB on nwell square, VNB on pwell square).
- Settled: 6L (1.08) pmos fine (cells are taller than hd); nand2/nor2 13L->14L accepted with a right-hand input polycont (met1 alternative never requested).

Backups of the .mag files before the nwell and rail changes (scratchpad, will not survive the session): not to be relied on.

## 3. What's still to do

- **Remaining 32 cells**: nand2_2, nor2_2, nor3_2, and2_1/2/4, and3_1, and4_2, or2_1/2/4, or3_1, a21o_1, a22o_1, o21a_1, mux2_1/2, ha_1, conb_1, dlygate4sd3_1, clkdlybuf4s50_1 (L = 0.5 stages), and the 11 flops (dfrtp, dfrbp, dfstp, dfxtp, dfxbp, dfbbp, edfxtp, edfxbp; they use 0.36 um special nfets -> `scnmos_n2_f1_l150`). Series stacks must follow the netlist order (Netgen merges parallel, not series). New cells must be even-L wide and use `lvdig_rails`. Extending `mag_build_inverters.tcl` to series/parallel gates is the natural next step. ~15-30 min per simple gate.
- **Tap cells**: the user is drawing `sky130_efx_lvdig__tap_*` .mag files; tap symbols already emit those names. Don't make them. Once they exist, add taps to allcells and check LU.2/LU.3.
- **Update stale reference scripts**: `scripts/mag_build_nand2_nor2.tcl` and `scripts/mag_build_inv4_buf2.tcl` still draw the old rails (efx::mcon_draw, odd widths). Fine as history; don't rerun as-is.
- **Commit**: ask the user first (suggest a branch). `netlist/*.spice` still gitignored (decide); `xschem_backup/*.spice` tracked.
- **Housekeeping**: old `mag/sky130_fd_sc_hd__*.mag` copies and `mag/test.mag` remain; `doc/sky130_fd_sc_hd_device_widths.md` "Not yet checked" scnfet item is answered (scnfet w < 0.42 extracts as special_nfet_01v8, confirmed on `scnmos_n2`). xschem exit 10 cause unknown.

## 4. Relevant references

- Repo guide: `/home/ejf/Projects/sky130_efx_ip__diglib/CLAUDE.md`
- Prior pickup: `/home/ejf/Projects/sky130_efx_ip__diglib/doc/pickups/superseded/pickup-2026-11-06-lvdig-schematics-first-layouts.md`
- efx layout method: `/home/ejf/Projects/sky130_efx_ip__diglib/mag/README.md`; upstream `/home/ejf/Projects/glayout_test/PRIMITIVES.md`
- Builders: `/home/ejf/Projects/sky130_efx_ip__diglib/scripts/mag_build_inverters.tcl`, `/home/ejf/Projects/sky130_efx_ip__diglib/scripts/mag_rails_grid.tcl`, `/home/ejf/Projects/sky130_efx_ip__diglib/scripts/mag_build_allcells.tcl`
- Memory: `lvdig-cell-conventions.md`, `magic-batch-gotchas.md`

## 5. Recommended next-session opening move

Enter `nix develop ~/nix-efx`; confirm no Magic session holds `mag/*.mag` (scan `/proc/*/fd` or ask the user), then run the 16-cell `make lvs` loop above and the allcells DRC (expect 16 x match, DRC 0). Then extend `scripts/mag_build_inverters.tcl` with a series/parallel stage (nand/nor style: per-column inputs with their own poly bar and polycont) and build nand2_2 and nor2_2 first, checking LVS and the allcells DRC after adding them to `scripts/mag_build_allcells.tcl`.
