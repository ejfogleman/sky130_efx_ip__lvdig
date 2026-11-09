# Fresh-context pickup -- all 48 sky130_efx_lvdig logic layouts done (gates, mux2, ha, 11 flops, conb, delay cells); allcells LVS/DRC clean

**Written**: 2026-11-08 (later the same day), superseding `pickup-2026-11-08-lvdig-45-logic-cells-flops-done.md`, which superseded `pickup-2026-11-06-lvdig-16-layouts-abutment-clean.md`. This memo covers both handoffs
**Repo**: sky130_efx_ip__diglib, branch `main`
**HEAD**: `97d0bd5` -- "Add standard cell lists for sar_dev and pll96". **Nothing since the initial cell lists is committed**: ~266 modified/untracked paths (`git status --short`). The user has not asked for a commit; ask before making one (suggest a branch).

The library is `sky130_efx_lvdig__<cell>`: the sky130_fd_sc_hd cells used by sar_dev and pll96 (`/home/ejf/Projects/sky130_efx_ip__diglib/doc/cells_*.txt`), as xschem schematics and new Magic layouts on the efx lambda grid (L = 0.18 um). Read `/home/ejf/Projects/sky130_efx_ip__diglib/CLAUDE.md` first: it now documents the tap cells, allcells ports, the met1 rules and the flop scripts. This memo covers what isn't there.

## 1. What landed (all uncommitted; file list from this session's edits)

Most recent first.

- **Library netlists**, laid out like the PDK's `libs.ref/sky130_fd_sc_hd/` and tracked in git:
  - `make libcdl` writes `cdl/sky130_efx_lvdig.cdl`, the schematic netlist.
  - `make libspice` writes `spice/sky130_efx_lvdig.spice`: Magic's flat extraction with parasitic C (2317 caps, no R), with ports put in the CDL's order.
  - Both are built by `scripts/gen_lib_netlist.py`. The extraction lives in `lvs/pex/` and takes about 12 s for all cells.
  - Checks: the sky130 Netgen setup plus `ignore class c` matches all 48 extracted cells against the CDL.
  - ngspice smoke test with each library: inv_1, conb_1 and dfxtp_2 are correct. dlygate4sd3_1's delay is 0.39 ns from the CDL and 0.52 ns from the extracted netlist.
  - The user said the library is for custom design only, with no place and route, so no LEF, Liberty or SITE work.
- **The last three cells**:
  - Cells:
    - **conb_1**: 1.08 um wide (6L). Two `rmp` resistors stacked in one poly column; LO pin at y 0.90-1.26, HI pin at 1.62-1.98.
    - **dlygate4sd3_1** and **clkdlybuf4s50_1**: 5.76 um each. Four single-finger inverters; the middle two have the PDK's L 0.5 on a 0.90 (5 lambda) strip pitch.
  - Lengths, after a first try at snapping the transistors to 0.54:
    - The user corrected it: MOS lengths need not be on the lambda grid, only the source/drain pitch (as with L 0.15). The long-channel transistors are therefore back at 0.5, with device cells `*_l500_*`. The `*_l540_*` cells and the L 0.54 delay layouts were moved to `/tmp/nix-shell.GCuCCo/claude-1000/-home-ejf-Projects-sky130-efx-ip--diglib/ab917cca-4ef1-4843-94b1-fefd54a0e39a/scratchpad/dly_l540/`, which is temporary.
    - Resistor lengths stay snapped: conb_1 is L 0.54, set in `snap_netlist` on `res_` lines only.
  - conb_1's resistor W 0.48 was snapped to 0.45 by the existing width rule.
  - Each cell is DRC 0 and matches in `make lvs` (rerun after the revert; no property errors in the delay cells, whose long gates extract as l=0.5).
  - `scripts/check_sch.sh`:
    - The full run (48 cells match; allcells "no report", as it has no PDK reference) was made before the L 0.5 revert.
    - After the revert, conb_1, dlygate4sd3_1, clkdlybuf4s50_1 and inv_1 match. The revert only changes `l=` handling, and every other cell is L 0.15, so the others should be unaffected; a full rerun is a cheap confirmation.
  - allcells: a 19th row (`tapvpwrvgnd_1 conb_1 dlygate4sd3_1 clkdlybuf4s50_1 tapvgnd_1`) brings it to 48 cells. After the revert it is DRC 0 in both styles and its LVS matches. It wasn't rebuilt, as no cell widths changed.
  - The previous allcells .mag/.sch are saved at `/tmp/nix-shell.GCuCCo/claude-1000/-home-ejf-Projects-sky130-efx-ip--diglib/ab917cca-4ef1-4843-94b1-fefd54a0e39a/scratchpad/allcells_45.mag` and `.sch`. The scratchpad is temporary.
  - New files: `scripts/mag_build_dly.tcl` and `scripts/mag_build_conb.tcl`, plus six device cells in `mag/`: `nmos_n2f5_f1_l500_ff`, `nmos_n3f5_f1_l500_ff`, `pmos_n2f5_f1_l500_hvt_ff`, `pmos_n4f5_f1_l500_hvt_ff`, `nmos_n3f5_f1_l150_ff` and `pmos_n6_f1_l150_hvt_ff`.
  - `lvdig_mos` in `scripts/mag_lvdig_lib.tcl` takes a gate-length argument `l` (internal units). The strip pitch is 72 + l, rounded up to a multiple of 36.
  - Netgen treats `res_generic_po` as a black box, so LVS doesn't check conb_1's resistor size. The extraction gives `l=108 w=90`, which is 0.54 x 0.45 um.
- **D pin raised 1L, CLK_N jogged up 1L over it**, in the 9 flops with the dfxtp front. That is all of them except edfx, whose D pin is elsewhere.
  - The D contact and pin are now at y 1.26-1.62.
  - The master CLK_N met1 line runs at y 1.84-2.12 for x 2.06-3.70, widened by 1L on each side at the user's request.
  - The procs are `d_input`, `d_pin` and `clkn_master` in `scripts/mag_lvdig_flop.tcl`.
  - Why: a via centred on D used to break met1.2 against a clock line. It now clears met1 by 0.285 um with a pad widened in x, or 0.225 um with one widened in y.
  - After the change, all 9 are DRC 0 and `make lvs` matches. allcells is DRC 0 in the default and `drc(full)` styles, and its LVS matches.
  - The pre-change layouts are saved in `/tmp/nix-shell.GCuCCo/claude-1000/-home-ejf-Projects-sky130-efx-ip--diglib/ab917cca-4ef1-4843-94b1-fefd54a0e39a/scratchpad/flops_pre_dpin/`. The scratchpad is temporary.

- **All 11 flops**, each DRC 0 and `make lvs` match (no property errors). No met1 lies over any li pin (checked by script for each one).

  | Cell | Width (um) |
  |---|---|
  | dfxtp_2 | 11.88 |
  | dfxbp_2 | 15.12 |
  | dfrtp_1 | 13.68 |
  | dfrtp_2 | 14.04 |
  | dfrbp_1 | 16.20 |
  | dfrbp_2 | 17.28 |
  | dfstp_1 | 16.92 |
  | dfstp_2 | 17.28 |
  | dfbbp_1 | 22.32 |
  | edfxtp_1 | 18.72 |
  | edfxbp_1 | 19.80 |

  - **Scripts**:
    - Shared library: `/home/ejf/Projects/sky130_efx_ip__diglib/scripts/mag_lvdig_flop.tcl`. It holds `island` (mixed-width diffusion as cells `mag/nmos_isl_<flop>_<part>.mag` and `pmos_isl_…`, renamed from `isl_<flop>_<part>_<n|p>` on 2026-11-08), the `tgx` crossing clock column, the `dcol` direct column, `pcpad`, `m1`/`via`, `dfx_core` (the full dfxtp_2), `flop_front`, `qn_chain` and `qn_pin`.
    - Per family: `scripts/mag_build_{dfxtp,dfxbp,dfrtp,dfstp,dfbbp,edfx}.tcl`. dfrtp also builds dfrbp; edfx builds both edfx cells.
    - Each script skips cells whose .mag exists, so delete the .mag to rebuild.
    - Each header documents its floorplan (strip/gate x positions, li bands, met1 tracks).
  - **Architecture**:
    - Two met1 clock lines, CLK_N and CLK_P, chosen by the user.
    - The slave's crossing column swaps the lines between tracks.
    - met1 tracks (y um): LO 0.32-0.60, PL 0.76-1.04, mid 1.21-1.49, PH 1.66-1.94, HI 2.195-2.475.
    - Vias are 0.17 squares stacked exactly on a licon.
    - met1 lines are 0.28 wide and end 0.15 past the via centre (the "mux2_1 style" the user approved).
  - **Extra met1 beyond the clock lines, by the user's rule** (2026-11-07: "minimize use of metal1, but use it if all else fails; metal1 must not block any li pin"):
    - dfrtp/dfrbp: the RESET_B HI line and the net1 jumper.
    - dfstp: the SET_B HI line.
    - dfbbp: the SET_B LO line, the RB_N HI line, and the net4/net10 LO jumpers.
    - edfx: the DM_N LO strap and the S_N HI line.
  - **New device cells** in `mag/` (`lvdig_mos`; `_sp` = short poly): for example `pmos_n3f5_f1_l150_hvt_ff`, `nmos_n3_f1_l150_bf`, `pmos_n4f5_f1_l150_hvt_ff`, `nmos_n2f5_f2_l150_bnf_sp`, `nmos_n2f5_f1_l150_fb_sp`.
- **allcells**:
  - Content: 19 rows and 48 logic cells. Row 18 holds the three newest cells. Each flop gets its own row, because of the 15 um latch-up tap spacing (LU.2/LU.3). Each row ends in tap cells, and the tap types alternate by row.
  - Ports: the top cell has real ports, VGND and VPWR_R01, VPWR_R23, ... These are labels on 2L met1 patches (`rail_port` in `scripts/mag_build_allcells.tcl`), matched by `iopin`s from `scripts/gen_allcells_sch.py`.
  - Why the ports: without them, Netgen reported "Top level cell failed pin matching" even though everything matched.
  - Status: DRC 0 in both the default and `drc(full)` styles, and LVS matches.
- **mux2_1 / mux2_2**:
  - The met1 strap moved down 4L, to y 0.40-0.68.
  - The A0/A1 inputs moved up as far as DRC allows: 3L in mux2_1, 2L in mux2_2. A full 4L breaks licon.9/14 and li.3.
  - The user then said "leave the mux as is".
- **ha_1**:
  - The user re-edited the layout.
  - Claude then narrowed the B strap to the 0.28 met1 style, and fixed the B label. It is now sticky and on port index 2; a non-sticky label re-clipped onto the via and became a new port.
  - `scripts/mag_build_ha.tcl` was rewritten to reproduce the user's layout exactly (checked identical by raster compare).
- **Earlier in this period** (between the prior pickup and this session):
  - nand2_2, nor2_2, nor3_2, and2_1/2/4, and3_1, and4_2, or2_1/2/4, or3_1, a21o_1, o21a_1, a22o_1. Builders are `scripts/mag_build_{nand2_nor2,nor3_2,and2,and3_and4,or,a21o_o21a,a22o}.tcl` on `scripts/mag_lvdig_lib.tcl`.
  - Tap cells (drawn by the user, moved to the frame by `scripts/mag_fix_taps.tcl`).

## 2. Current state / gate status

All of these ran this session, inside `nix develop ~/nix-efx` from the repo root:
```
make lvs CELL=sky130_efx_lvdig__<cell>        # "LVS ... match" for all 48 logic cells
make libcdl libspice                          # wrote cdl/...cdl and spice/...spice: 48 cells each
make lvs CELL=sky130_efx_lvdig__allcells      # match (regenerate the .sch with scripts/gen_allcells_sch.py after editing ROWS)
cd mag && rm sky130_efx_lvdig__allcells.mag && magic -dnull -noconsole ../scripts/mag_build_allcells.tcl
                                              # prints "allcells DRC: 0"
```
- `make lvs` prints xschem `Error 10 (ignored)`. This is expected.
- `scripts/check_sch.sh`: the 48 cells match. It exits 1 only because allcells has no PDK reference netlist ("no report").
- Every cell in `doc/cells_sar_dev.txt` and `doc/cells_pll96.txt` now has a layout.
- Before any batch Magic edit, run `pgrep -a magic` in its own tool call. If the user's Magic has the target open, stop and ask.

## 3. What's still to do

- **Optional: simulate the delay cells.** The sizes match hd's except for the snapped widths. Not checked.
- **conb_1 resistor width**: 0.45, snapped from 0.48. The user approved L 0.54 for the resistors; W followed the existing width rule and was reported to them. Change it if they ask.
- **Ask the user to review the flops in the GUI.** They have not looked at the 10 flops after dfxtp_2 yet. Claude must not open GUI windows unless asked.
- **Commit**, when the user asks. The scratchpad backups won't survive the session.
- `netlist/` was removed on 2026-11-08. The PDK's copies of the hd cells were redundant: `check_sch.sh` and `lambda_widths.py` now read the cells from the PDK's `sky130_fd_sc_hd.spice`. `check_sch.sh` then matched 48 cells with exit 0, using references identical to the old ones. A backup of the folder is in the scratchpad, which is temporary.
- **Housekeeping**:
  - Done 2026-11-08: 19 unused `.mag` files moved to `mag/unused/` (none tracked in git).
    - The 12 `sky130_fd_sc_hd__*` copies and `test.mag`.
    - The `nmos_n4_f1_l150`, `pmos_n{3,4,5}_f1_l150_hvt` cells used only by `test`.
    - `scnmos_n2_f1_l150`, an extraction test.
    - `nmos_n5_f2_l180_tl_tr_gt`, an efx default nmos.
    - None of them is used by any library cell. After the move, allcells is DRC 0 and its LVS matches.
  - `scripts/mag_build_inv4_buf2.tcl` and `mag_shrink_nand2_nor2.tcl` are history, superseded by later builders. Don't rerun them.

### Settled decisions (don't re-litigate)

- **met1 in logic layouts:**
  - li only, except the mux2 strap, ha_1's two straps and the flop rule above.
  - Never put met1 over an li pin.
- **Flop widths:** our flops are 1.5-1.9x hd's widths. This is accepted, because the cells are taller and use a coarse grid.
- **Leave mux2 as is.**

### Gotchas (also in memory)

- Run `tech unlock scnmos` before painting special nfets (W < 0.42). Without it, the paint silently fails.
- Non-sticky labels shrink to their layer when the paint under them changes.
- Erasing a label drops its port, so restore the port index.
- Netgen merges parallel devices, not series ones, so series order must follow the netlist.
- MOS gate lengths are never snapped. Only the source/drain pitch has to be on the lambda grid.

## 4. Relevant references

- Repo guide: `/home/ejf/Projects/sky130_efx_ip__diglib/CLAUDE.md`
- Layout method: `/home/ejf/Projects/sky130_efx_ip__diglib/mag/README.md`
- Flop library: `/home/ejf/Projects/sky130_efx_ip__diglib/scripts/mag_lvdig_flop.tcl`
- Floorplan doc: the header of `/home/ejf/Projects/sky130_efx_ip__diglib/scripts/mag_build_dfxtp.tcl`
- allcells: `/home/ejf/Projects/sky130_efx_ip__diglib/scripts/mag_build_allcells.tcl`, `/home/ejf/Projects/sky130_efx_ip__diglib/scripts/gen_allcells_sch.py`
- Prior pickups: `/home/ejf/Projects/sky130_efx_ip__diglib/doc/pickups/superseded/pickup-2026-11-08-lvdig-45-logic-cells-flops-done.md`, `/home/ejf/Projects/sky130_efx_ip__diglib/doc/pickups/superseded/pickup-2026-11-06-lvdig-16-layouts-abutment-clean.md`
- Memory: `lvdig-cell-conventions.md` (met1 approvals, grid, widths), `magic-batch-gotchas.md` (labels, scnmos lock, file locks)

## 5. Recommended next-session opening move

1. Enter `nix develop ~/nix-efx`.
2. Run `pgrep -a magic` and check that no session of the user's has `mag/*.mag` open.
3. Spot-check `make lvs CELL=sky130_efx_lvdig__dfbbp_1` and `make lvs CELL=sky130_efx_lvdig__allcells`; both should match. Run `scripts/check_sch.sh`: 48 should match, with allcells as "no report".
4. Ask the user whether they've reviewed the flops and whether to commit (on a branch).
5. Then simulate the delay cells, if wanted.
