# Fresh-context pickup -- lvdig library complete (48 cells); library CDL/extracted netlists, netlist/ removed, unused layouts set aside

**Written**: 2026-11-08 (end of session), superseding `pickup-2026-11-08-lvdig-all-48-cells-done.md` (and, through it, the earlier 2026-11-08 and 2026-11-06 pickups)
**Repo**: sky130_efx_ip__lvdig (renamed from sky130_efx_ip__diglib on 2026-11-08), branch `main`
**HEAD**: `97d0bd5` -- "Add standard cell lists for sar_dev and pll96". **Nothing since the initial cell lists is committed**: ~248 modified/untracked paths (`git status --short`). The user has not asked for a commit; ask before making one (suggest a branch).

The library is `sky130_efx_lvdig__<cell>`: the sky130_fd_sc_hd cells used by sar_dev and pll96 (`/home/ejf/Projects/sky130_efx_ip__lvdig/doc/cells_*.txt`), redrawn as xschem schematics and new Magic layouts on the efx lambda grid (L = 0.18 um). Read `/home/ejf/Projects/sky130_efx_ip__lvdig/CLAUDE.md` first: it documents the conventions, scripts, met1 rules, library netlists and checks. This memo covers what isn't there. The library is **for hand-placed custom design only** (user, 2026-11-08): no place-and-route collateral.

## 1. What landed (all uncommitted; file list from this session's edits)

Most recent first.

- **Copyright notices**:
  - All 49 schematics have a `copyright.sym` header instance (copyright, SPDX Apache-2.0, "Derived from SkyWater sky130_fd_sc_hd"). It's added by the generators, and by hand for conb_1. It appears at the top of every netlist and once at the top of each library netlist.
  - `xschem/copyright.sym` was rewritten from scratch as Apache-2.0, replacing a copy of xschem's GPL `netlist.sym`. The user will handle pll96's copy.
  - The user declined a visible notice on the cell symbols (too large).
  - Checks: `check_sch.sh` 48 match, allcells LVS match, extracted (none) vs CDL 48/48. Regenerating the schematics before the change reproduced all 49 byte for byte, and the only differences after it are the copyright lines.
- **Repo renamed `sky130_efx_ip__diglib` -> `sky130_efx_ip__lvdig`**, to match the cell prefix.
  - The user renamed it on GitHub and set the `origin` URL; `git ls-remote` works.
  - Claude updated the README title and NOTICE line 1, and copied the Claude Code memory to `~/.claude/projects/-home-ejf-Projects-sky130-efx-ip--lvdig/memory/`.
  - The user moved the local folder to `~/Projects/sky130_efx_ip__lvdig` (2026-11-08). The repo is intact there: same changes, new remote, memory present.
  - The old memory folder `~/.claude/projects/-home-ejf-Projects-sky130-efx-ip--diglib/` can be deleted once sessions run from the new folder.
  - The scratchpad paths below still contain `-diglib`; that's the old session's temporary folder.
  - GitHub's HEAD is `5418e03`: the local commit `97d0bd5` hasn't been pushed.
- **Absolute `use` paths removed** from `mag/sky130_efx_lvdig__nand2_2.mag` (3 lines) and `nor2_2.mag` (2 lines). They ended in `~/Projects/sky130_efx_ip__diglib/mag` and would have broken with the folder rename.
  - Both cells are DRC 0 and match LVS.
  - Backup: `scratchpad/pre_usepath/`.
- **Makefile repaired.** When the `PEX` section was restructured, the edit accidentally deleted `.PHONY`, `.SECONDARY`, `sim`, the LVS netlist and report rules and the `lvs` target.
  - All were restored from the version read at session start.
  - Rechecked: `make lvs` (nand2_2, nor2_2 match; usage message without CELL).
  - Fresh-clone `make libcdl`: rebuilds a missing schematic netlist, and the output is identical.
- **Extraction modes**: `make libspice PEX=none|c|rc` writes `spice/sky130_efx_lvdig.spice` (devices only, as the PDK's), `_c.spice` (the default, parasitic C) or `_rc.spice` (R and C). All are untracked.
  - Every mode extracts a flattened copy of each cell. This fixed the hierarchical extraction's double-counted source/drain area on shared supply nodes, at the user's request.
  - Checks: the none and c netlists match the CDL in Netgen (48/48 each; c with `ignore class c`). All three have identical transistors and areas and the CDL's ports. The ngspice smoke test passes with all four netlists.
  - **Open, unexplained:** dlygate4sd3_1's delay is 0.504 ns (rc) vs 0.518 ns (c) vs 0.399 ns (none) vs 0.390 ns (cdl).
- **User decisions, end of session** (2026-11-08), all carried out:
  - **Acknowledgements added.**
    - `NOTICE` (new) credits three sources: SkyWater `sky130_fd_sc_hd`, for the cell names, functions, pins and netlists the schematics derive from (the layouts are independent); Stefan Schippers' `xschem_sky130`, for the symbols; and the SkyWater PDK docs, for `doc/cells_skywater.md`.
    - All 55 copied symbols (`xschem/sky130_efx_lvdig__*.sym`) have a "Modified for sky130_efx_lvdig" note below the original header, saying what changed.
    - The README has an Acknowledgements paragraph, and the `cdl/` and `spice/` headers cite NOTICE.
    - After the symbol edits: `check_sch.sh` 48 match (exit 0), and allcells LVS matches. All 7 tap symbols netlist correctly in a scratch schematic.
  - **Library netlists are not tracked.**
    - `cdl/*.cdl` is ignored, and the `!spice/*.spice` exception was removed, so `*.spice` ignores the extracted file.
    - `cdl/.gitkeep` and `spice/.gitkeep` keep the folders in a clone. Run `make libcdl libspice` after cloning.
  - **conb_1 resistor W stays 0.45** (settled).
  - **The user will review the flops** in the GUI.
  - **The `.gitignore` pattern `unused/` stays as is** (it matches at any depth).
  - **Fixed:** CLAUDE.md's stale line saying the README was still the template's, and the README typo "for for".
- **`netlist/` removed.**
  - It held renamed copies of the PDK's hd cells, all 48 identical to the PDK's `libs.ref/sky130_fd_sc_hd/spice/sky130_fd_sc_hd.spice`, and was gitignored, so a fresh clone lacked it.
  - `scripts/lambda_widths.py --ref CELL OUT` now takes the cell straight from the PDK file, renames it and snaps it.
  - `scripts/check_sch.sh` uses `--ref`, and its default list skips allcells.
  - Result: 48 match, exit 0; the reference device lines are identical to the old ones.
  - Docstrings and `doc/sky130_fd_sc_hd_device_widths.md` were updated.
  - Backup: `/tmp/nix-shell.GCuCCo/claude-1000/-home-ejf-Projects-sky130-efx-ip--diglib/ab917cca-4ef1-4843-94b1-fefd54a0e39a/scratchpad/netlist_removed/` (temporary).
- **Library netlists mirroring the PDK's `libs.ref/sky130_fd_sc_hd/`.** In the PDK, `cdl/` is the schematic netlist and `spice/` is Magic's layout extraction without parasitics.
  - `make libcdl` writes `cdl/sky130_efx_lvdig.cdl` (schematic, SPICE syntax).
  - `make libspice` first wrote the C-only netlist from a hierarchical extraction. It is superseded by the extraction modes above, and the netlists were later untracked; see the user decisions below.
  - Both are built by `scripts/gen_lib_netlist.py`.
  - The extracted ports are rewritten to the CDL's order, since Magic orders them by pin-label number.
  - Magic's `$ **FLOATING` notes are removed (Netgen reads the `$` as an element; every flagged node reaches a source/drain), and so are zero caps.
  - Checks: the Netgen sky130 setup plus `ignore class c` matches all 48 extracted cells against the CDL. In the ngspice smoke test with both files, inv_1, conb_1 and dfxtp_2 are correct, and dlygate4sd3_1's delay is 0.39 ns (CDL) vs 0.52 ns (extracted).
- **Unused layouts set aside.** 19 `.mag` files unreachable from any library cell were moved to `mag/unused/`, now gitignored (`unused/`).
  - The 12 old `sky130_fd_sc_hd__*` copies and `test.mag`.
  - `nmos_n4_f1_l150` and `pmos_n{3,4,5}_f1_l150_hvt`, used only by `test`.
  - `scnmos_n2_f1_l150`.
  - `nmos_n5_f2_l180_tl_tr_gt`, an efx default nmos that someone placed from the GUI on 2026-11-07; not used.
  - After the move, allcells is DRC 0 and matches LVS.
- **Island cells renamed** `isl_<flop>_<part>_<n|p>` -> `<nmos|pmos>_isl_<flop>_<part>` (user request, to match the device-cell naming). This covered 24 files and 144 references.
  - The 11 flops and allcells are still DRC 0 and match LVS.
  - A rebuild of dfxtp_2 from the scripts gave identical geometry.
  - Backup: `/tmp/nix-shell.GCuCCo/claude-1000/-home-ejf-Projects-sky130-efx-ip--diglib/ab917cca-4ef1-4843-94b1-fefd54a0e39a/scratchpad/pre_isl_rename/`.
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
    - Shared library: `/home/ejf/Projects/sky130_efx_ip__lvdig/scripts/mag_lvdig_flop.tcl`. It holds `island` (mixed-width diffusion as cells `mag/nmos_isl_<flop>_<part>.mag` and `pmos_isl_…`, renamed from `isl_<flop>_<part>_<n|p>` on 2026-11-08), the `tgx` crossing clock column, the `dcol` direct column, `pcpad`, `m1`/`via`, `dfx_core` (the full dfxtp_2), `flop_front`, `qn_chain` and `qn_pin`.
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
make lvs CELL=sky130_efx_lvdig__<cell>        # "LVS ... match" for all 48 cells (each rerun after its last change)
make lvs CELL=sky130_efx_lvdig__allcells      # match
scripts/check_sch.sh                          # 48 x "match", exit 0 (allcells skipped)
make libcdl libspice                          # "Nothing to be done" when current; 48 cells each (outputs ignored by git)
make libspice PEX=none; make libspice PEX=rc  # devices-only and RC netlists, 48 cells each
cd mag && magic -dnull -noconsole <script>    # allcells DRC 0 in default and drc(full) styles
```
- `make lvs` prints xschem `Error 10 (ignored)`. This is expected.
- Every cell in `doc/cells_sar_dev.txt` and `doc/cells_pll96.txt` has a layout.
- Before any batch Magic edit, run `pgrep -a magic` in its own tool call. If the user's Magic has the target open, stop and ask.

## 3. What's still to do

- **Flop review by the user** (they said they will). Act on their feedback; don't open GUI windows unless asked.
- `xschem_backup/` was removed by the user (2026-11-08). The CLAUDE.md mention and the `.gitignore` exception are gone.
- **Commit** when the user asks, on a branch. (`cdl/` and `spice/` outputs are not tracked; only their `.gitkeep` files are.) The scratchpad backups won't survive the session.
- **Optional:** explain why the RC delay of dlygate4sd3_1 (0.504 ns) is below the C-only one (0.518 ns). A start: compare per-net ground vs coupling C in `_c` and `_rc`.
- **Optional:** simulate the delay cells. The sizes match hd's except for the snapped widths.
- History scripts, not to be rerun: `scripts/mag_build_inv4_buf2.tcl`, `mag_shrink_nand2_nor2.tcl`.

### Settled decisions (don't re-litigate)

- **conb_1 resistors:** W 0.45 x L 0.54.
- **Library netlists untracked:** regenerate them, don't commit them.
- **Custom design only:** no LEF, maglef, techlef/SITE, Liberty, mask hints or fill/decap cells.
- **met1 in logic layouts:**
  - li only, except the mux2 strap, ha_1's two straps and the flops' clock lines and minimal extra lines.
  - Never put met1 over an li pin.
- **Lengths:** MOS gate lengths are never snapped; only the source/drain pitch is on the lambda grid. The delay cells use the PDK's L 0.5 on a 0.90 pitch. Resistor lengths are snapped: conb_1 is 0.54.
- **Flop widths:** our flops are 1.5-1.9x hd's widths. This is accepted.
- **Leave mux2 as is.**
- **Port order** in our netlists: logic pins, then `VGND VNB VPB VPWR`. This is not hd's order; instantiate by our `.subckt` lines.

### Gotchas (also in memory or CLAUDE.md)

- Run `tech unlock scnmos` before painting special nfets. Without it, the paint silently fails.
- Non-sticky labels shrink to their layer when the paint under them changes. Erasing a label drops its port.
- Netgen merges parallel devices, not series ones, so series order must follow the netlist.
- Netgen treats `res_generic_po` as a black box, so LVS doesn't check conb_1's resistor W/L. The extraction gives `l=108 w=90`, which is 0.54 x 0.45 um.
- `extract do local` in a batch Magic script stopped `ext2spice` from writing anything; leave it out.

## 4. Relevant references

- Repo guide: `/home/ejf/Projects/sky130_efx_ip__lvdig/CLAUDE.md`; user-facing: `/home/ejf/Projects/sky130_efx_ip__lvdig/README.md`
- Layout method: `/home/ejf/Projects/sky130_efx_ip__lvdig/mag/README.md` (section 6: gencell naming and unused files)
- Library netlists: `/home/ejf/Projects/sky130_efx_ip__lvdig/scripts/gen_lib_netlist.py`, `/home/ejf/Projects/sky130_efx_ip__lvdig/Makefile`
- PDK reference cells: `/home/ejf/Projects/sky130_efx_ip__lvdig/scripts/lambda_widths.py`
- Flop library: `/home/ejf/Projects/sky130_efx_ip__lvdig/scripts/mag_lvdig_flop.tcl`; floorplan in the header of `/home/ejf/Projects/sky130_efx_ip__lvdig/scripts/mag_build_dfxtp.tcl`
- Prior pickups: `/home/ejf/Projects/sky130_efx_ip__lvdig/doc/pickups/superseded/` (the latest is `pickup-2026-11-08-lvdig-all-48-cells-done.md`)
- Memory: `lvdig-cell-conventions.md` (grid, widths, lengths, met1 rules), `lvdig-custom-design-only.md`, `magic-batch-gotchas.md`

## 5. Recommended next-session opening move

1. Enter `nix develop ~/nix-efx`.
2. Run `pgrep -a magic`.
3. Run `scripts/check_sch.sh` (expect 48 match, exit 0) and `make libcdl libspice` (on a fresh clone this generates the netlists, which aren't tracked; otherwise "Nothing to be done").
4. Ask whether the user has flop-review feedback, and whether to commit (on a branch).
