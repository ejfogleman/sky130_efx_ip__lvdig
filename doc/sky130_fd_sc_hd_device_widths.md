# Transistor widths in the used sky130_fd_sc_hd cells

Which per-finger transistor widths the 46 cells in `cells_sar_dev.txt` and `cells_pll96.txt` use, how they sit on the efx lambda grid (L = 0.18 µm, `mag/README.md`), and whether they can be drawn without a dogbone diffusion.

Widths are read from each used cell's `.subckt` in the PDK's `libs.ref/sky130_fd_sc_hd/spice/sky130_fd_sc_hd.spice` (copies were kept in `netlist/` until 2026-11-08); rules from Magic's `sky130A.tech` (sky130A in `~/.ciel`, 2026-11-06). Counts are per finger: mult and parallel copies are each counted as separate transistors. 652 transistors in all.

Checked against the layouts: the gate rectangles (`scnmos`, `scpmoshvt`) in the 46 PDK `.mag` files have exactly these widths and counts.

## nmos

| Model | W (µm) | W / L | Nearest grid widths | Transistors | Used in |
|---|---|---|---|---|---|
| `special_nfet_01v8` | 0.36 | **2.00** | on grid | 40 | all 11 flops (transmission gates, clocked feedback) |
| `nfet_01v8` | 0.42 | 2.33 | 0.36 / 0.54 | 165 | most cells: minimum inner stages, clock cells, flops |
| `nfet_01v8` | 0.52 | 2.89 | 0.36 / 0.54 | 4 | `buf_1`, `clkbuf_1` |
| `nfet_01v8` | 0.54 | **3.00** | on grid | 2 | `dfstp_1/2` (`S_N` inverter) |
| `nfet_01v8` | 0.64 | 3.56 | 0.54 / 0.72 | 15 | flops' master inverter, `dfbbp` set/reset gates |
| `nfet_01v8` | 0.65 | 3.61 | 0.54 / 0.72 | 97 | 1× output stages and logic (36 cells) |

## pmos (all `pfet_01v8_hvt`)

| W (µm) | W / L | Nearest grid widths | Transistors | Used in |
|---|---|---|---|---|
| 0.42 | 2.33 | 0.36 / 0.54 | 128 | minimum inner stages, flop latches |
| 0.64 | 3.56 | 0.54 / 0.72 | 46 | flop clock buffers, `buf_2` input, `mux2_2` |
| 0.75 | 4.17 | 0.72 / 0.90 | 4 | `dfxtp`/`dfxbp`/`edfx` master inverter |
| 0.79 | 4.39 | 0.72 / 0.90 | 4 | `buf_1`, `clkbuf_1` |
| 0.82 | 4.56 | 0.72 / 0.90 | 2 | `clkdlybuf4s50_1` (L = 0.5 stages) |
| 0.84 | 4.67 | 0.72 / 0.90 | 15 | `clkinv_1`, reset/set flops' master inverter and `S_N` inverter |
| 1.00 | 5.56 | 0.90 / 1.08 | 130 | 1× output stages and logic (42 cells) |

## What this means for the grid

- **Only two widths are already on the grid:** the special nfet at 0.36 µm (2L) and `dfstp`'s 0.54 µm nfet (3L).
- **Four widths cover most transistors:** nmos 0.42 and 0.65, and pmos 0.42 and 1.00 make up 520 of the 652 transistors.
- **Some widths are nearly the same:** 0.64 and 0.65 µm (nmos), and 0.79, 0.82 and 0.84 µm (pmos), would each round to the same grid width.
- **The n-well caps the pmos finger width.** The n-well is 1.605 µm (about 8.9L) tall in every one of the 46 cells, and it must hold the p-diffusion plus its enclosure. The widest pmos finger is 1.00 µm (5.56L); more pmos drive comes from parallel fingers, not wider ones.
- **Gate lengths are off the grid too:** every transistor uses L = 0.15 µm, except the long-channel delay stages (`dlygate4sd3_1`, `clkdlybuf4s50_1`) at 0.5 µm. Neither is a multiple of 0.18 µm.
- **Not a transistor:** `conb_1`'s two poly resistors are W = 0.48 µm (2.67L), L = 0.5 µm.

## Dogbones: not needed for 0.36 or 0.42

One diffusion contact fits inside a straight diffusion strip of either width.

| Rule | Value (µm) |
|---|---|
| `licon.1`: contact size | 0.17 × 0.17 |
| `licon.5a`: diffusion around the contact, all sides | ≥ 0.04 |
| `licon.5c`: diffusion around the contact, both sides in one direction | ≥ 0.06 |

Taking the 0.06 across the width, a straight diffusion holds a contact once W ≥ 0.17 + 2 × 0.06 = 0.29 µm:

| W | Margin each side of the contact, across W | Dogbone needed? |
|---|---|---|
| 0.36 (2L) | 0.095 | no |
| 0.42 | 0.125 | no |

Along the transistor's length, the contact needs only 0.04 µm of diffusion, plus its spacing from the gate; neither depends on W. A 2L diffusion holding exactly one contact matches the efx rule "diff, 1 cut: 2L" (`mag/README.md`, section 3).

## The real limit: minimum transistor width (diff/tap.2)

Magic's deck sets two minimum widths:

- **0.42 µm** for ordinary devices (`nfet`, `pfet`, `pfethvt`, …).
- **0.36 µm** only for the standard-cell device types `scnfet`, `scnfetlvt`, `scpfet` and `scpfethvt`. Magic adds the `STDCELL` marker layer automatically to any cell containing them. `scnfet` is the type behind `special_nfet_01v8`.

On the 0.18 µm grid:

- **0.36 µm (the special nfets)** draws exactly as 2L, but must be painted as `scnfet` (or `scpfethvt` for a pmos), not as an ordinary nfet. Drawn as an ordinary `nfet`, a 2L device fails diff/tap.2.
- **0.42 µm (the ordinary minimum)** is not on the grid. The nearest legal grid width is 3L = 0.54 µm. 2L = 0.36 µm is allowed only if the device becomes a standard-cell type, which changes what it extracts as.
- **The efx MOS generator** takes n ≥ 3 (W ≥ 0.54 µm), default 5, since 2026-11-06 (it was n ≥ 5). At 3L and 4L each source/drain and tap strip gets one contact; the 3L test cells pass the Magic/Python comparison and DRC (Magic 0, KLayout 0) and extract as `nfet_01v8` / `pfet_01v8` W = 0.54. 2L would still need the standard-cell device types, and its contact count `floor((n − 1)/2)` gives zero at n = 2.

## Not yet checked

- How Magic decides whether an `scnfet` extracts as `special_nfet_01v8` or `nfet_01v8`: the tech file maps `scnfet` to both (`device msubcircuit` lines for each). Test on a drawn device before relying on it.
- Whether the foundry's KLayout DRC deck requires the standard-cell marker in the same way Magic's deck does.

## Reproducing

```bash
# widths by model across the library's cells, with the snapped width
python3 scripts/lambda_widths.py
# the rules
T=~/.ciel/sky130A/libs.tech/magic/sky130A.tech
grep -n -B1 'diff/tap\.2)' $T
grep -n 'licon\.5[ac]' $T
```
