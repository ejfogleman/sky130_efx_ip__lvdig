# Fresh-context pickup -- lvdig cell symbols are primitives (hd style); library netlists tracked; make libnet

**Written**: 2026-11-12, superseding `pickup-2026-11-08-lvdig-library-netlists-cleanup.md` (now in `superseded/`)
**Repo**: sky130_efx_ip__lvdig, branch `main`, at `/home/ejf/Projects/sky130_efx_ip__lvdig`
**HEAD**: `a2b2ced` -- "Changed from type=subcircuit to type=primitive; included extracted netlists", committed and pushed by the user. `main` matched `origin/main` after a fetch (2026-11-12). The only uncommitted change is this memo and the move of the prior one.

The library is `sky130_efx_lvdig__<cell>`: the sky130_fd_sc_hd cells used by sar_dev and pll96, redrawn as xschem schematics and Magic layouts on the efx lambda grid (L = 0.18 um), plus lvdig-only decaps and fillers. It is for hand-placed custom design only. Read `/home/ejf/Projects/sky130_efx_ip__lvdig/CLAUDE.md` first: it documents the conventions, scripts, met1 rules, library netlists and checks. This memo covers what isn't there.

## 1. What landed since the prior pickup

Most recent first.

- **`a2b2ced` (2026-11-12)**:
  - **Cell symbols are primitives, the PDK's hd mechanism.** The 50 `xschem/sky130_efx_lvdig__*.sym` with a schematic changed from `type=subcircuit` to `type=primitive`. The format is unchanged, `@name @pinlist @VGND @VNB @VPB @VPWR @symname`, so instance lines are the same. `prefix` (template, extra) and `verilogprefix` were removed: unused with `@symname`, so no doubled prefix is possible. The header comments say so. The 7 tap symbols were already primitives and keep `@prefix`.
    - xschem now writes only `X…` lines for library cells. A design includes the `.subckt`s **once**, in a code block (tcleval), from paths `xschem/xschemrc` sets (absolute, also when lvdig is a submodule): `.include $::LVDIG_SPICE/sky130_efx_lvdig_c.spice` (or `_rc`, or `sky130_efx_lvdig.spice`), or `.include $::LVDIG_CDL/sky130_efx_lvdig.cdl`.
    - Tested: a scratch inv_1 testbench netlisted with no `.subckt` and one `.include`; ngspice ran it (tpd 19 ps unloaded).
    - `allcells.sch` (`scripts/gen_allcells_sch.py`) has a `place=header` code block including `$::LVDIG_CDL/sky130_efx_lvdig.cdl` (before allcells' own `.subckt`, not nested in it); instances lost `prefix=`. The Makefile makes `lvs/schematic/sky130_efx_lvdig__allcells.spice` depend on the CDL. `make lvs CELL=sky130_efx_lvdig__allcells`: match, 50 devices, Netgen followed the include.
    - Unaffected and rechecked: `scripts/check_sch.sh` (exit 0), cell LVS and `libcdl`/`libspice` (each netlists a cell's `.sch` as the top level). CDL and devices-only netlist byte-identical after the change.
  - **Library netlists tracked in git** (user decision, reversing 2026-11-08): `.gitignore` drops `cdl/*.cdl` and adds `!spice/sky130_efx_lvdig*.spice` after `!sim/**/*.spice`. All four were regenerated first (none and rc were stale, 48 cells, no decaps); all have 50 cells.
  - **`make libnet`**: forced rebuild (`-B`) of all four (three sub-makes, one per PEX), about 1 minute. Run before committing any `.sch`/`.sym`/`.mag` change and commit the netlists with it. A comparison target (`check-libnet`) was built and then dropped at the user's request, because:
    - **The c and rc netlists' element order varies between runs** (same elements; in rc some caps have their terminals swapped). `git diff` of `_c`/`_rc` shows reordered lines even when nothing changed. The CDL and the devices-only netlist are byte-stable, so a diff there is real. (Claude first said only rc varied; a later rebuild showed c varies too.)
  - **Decap extraction warnings** "device missing 1 terminal" (2 per decap) are expected: source and drain are one net. Noted in CLAUDE.md.
  - **Flop symbols**: the user moved `@symname` above the box and `@name` to the lower right in `dfxtp_2.sym`; Claude applied the same offsets to the other 10 flops (symname 26 above the box top, name at x 65, 2 above the box bottom).
  - **pll96 rename** reflected in lvdig: `CLAUDE.md` and `doc/sky130_fd_sc_libraries.md` say `sky130_efx_ip__pll96`. `sky130_ejf_ip__sar_dev` is unchanged (not renamed).
  - The user's own changes in the commit: `xschem/title.sym` deleted, `xschem/title_efx.sym` edited.
- **`aa30658` "Added decaps and fillers"** (user, 2026-11-09): the decap10/decap20 and filler2/4/6/8 work described in the superseded pickup's section 0, plus padded allcells.

### Elsewhere (not this repo)

- `ejfogleman/sky130_ejf_ip__pll96` was renamed to `sky130_efx_ip__pll96` on GitHub; the local folder is `~/Projects/sky130_efx_ip__pll96` with the new `origin`. When last checked it was **1 commit behind** origin (`afa3e7b`, a web edit setting the README title to `sky130_ejf_ip__pll_dev`). Suggested to the user: `git pull --ff-only`, set README line 1 to `# sky130_efx_ip__pll96`, commit, push. Unverified whether done.

## 2. Current state / gate status

Inside `nix develop ~/nix-efx`, from the repo root; all ran 2026-11-12 after the symbol change:
```
scripts/check_sch.sh                          # all match, decap10/20 skipped, exit 0
make lvs CELL=sky130_efx_lvdig__allcells      # match (schematic side via the CDL include)
make libnet                                   # 4 netlists, 50 cells each; cdl and devices-only unchanged
git status                                    # clean except this memo
```
- `make lvs` prints xschem `Error 10 (ignored)`; expected.
- Before any batch Magic edit, `pgrep -a magic` in its own tool call; before editing a `.sym`/`.sch`, `pgrep -a xschem` (the user often has one open, e.g. `xschem -b <file>`); ask if a target is open.

## 3. What's still to do

- ~~Check xschem descend on a primitive~~ Answered (user, 2026-11-12): `e` on a placed lvdig cell still opens its `.sch`; `type=primitive` only affects netlisting.
- **Flop review by the user** (pending since 2026-11-08). Act on feedback.
- **Optional:** make the c/rc netlist order deterministic (sort R/C lines, canonical terminal order, renumber in `scripts/gen_lib_netlist.py`) so `git diff` shows only real changes. Offered; the user chose plain forced regeneration instead. Don't do it unasked.
- **Optional, open since 2026-11-08:** why dlygate4sd3_1's RC delay (0.504 ns) is below its C-only delay (0.518 ns).
- **Optional:** rename pll96's `ejf_pll96_` cell prefix (separate, larger task in the pll96 repo).

### Settled decisions (don't re-litigate)

- **Cell names keep the full `sky130_efx_lvdig__` prefix**; no `prefix` property on cell symbols (2026-11-12).
- **hd mechanism, not `spice_sym_def`**: the user rejected one `.include` per cell type (xschem writes `spice_sym_def` once per symbol type). Designs include one library netlist once.
- **Library netlists are tracked**; regenerate with `make libnet` before committing; no automated up-to-date check.
- Earlier decisions in the superseded pickup still hold (conb_1 W 0.45 x L 0.54; custom design only; hvt decaps in hd style with li strip columns; fillers layout only; met1 rules; MOS lengths unsnapped; leave mux2 as is; port order logic pins then `VGND VNB VPB VPWR`).

## 4. Relevant references

- Repo guide: `/home/ejf/Projects/sky130_efx_ip__lvdig/CLAUDE.md`; user-facing: `/home/ejf/Projects/sky130_efx_ip__lvdig/README.md`
- Library path variables: `/home/ejf/Projects/sky130_efx_ip__lvdig/xschem/xschemrc` (`LVDIG_SPICE`, `LVDIG_CDL`)
- Netlist targets: `/home/ejf/Projects/sky130_efx_ip__lvdig/Makefile` (`libcdl`, `libspice PEX=…`, `libnet`); joiner `/home/ejf/Projects/sky130_efx_ip__lvdig/scripts/gen_lib_netlist.py`
- allcells schematic generator: `/home/ejf/Projects/sky130_efx_ip__lvdig/scripts/gen_allcells_sch.py`
- xschem manual (spice_sym_def, primitives): `/nix/store/d9fdbzzm4a2w5j9skdbhjfdvll484h1v-xschem-3.4.7/share/doc/xschem/xschem_man/symbol_property_syntax.html`
- Prior pickup: `/home/ejf/Projects/sky130_efx_ip__lvdig/doc/pickups/superseded/pickup-2026-11-08-lvdig-library-netlists-cleanup.md` (full history of cells, flops, decaps, fillers)
- Memory: `lvdig-cell-conventions.md`, `lvdig-custom-design-only.md`, `magic-batch-gotchas.md`

## 5. Recommended next-session opening move

Enter `nix develop ~/nix-efx`, run `git status -sb` (expect clean, level with origin once this memo is committed) and `pgrep -a magic; pgrep -a xschem`. Run `scripts/check_sch.sh` and `make lvs CELL=sky130_efx_lvdig__allcells` to confirm the primitive-symbol setup still matches. Then ask the user whether they have flop-review feedback.
