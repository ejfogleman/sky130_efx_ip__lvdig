# Sky130 standard cell libraries

The seven `sky130_fd_sc_*` libraries in `$PDK_ROOT/sky130A/libs.ref`, and why this repo uses `sky130_fd_sc_hd`.

The names stand for high density (hd), high density low leakage (hdll), high speed (hs), medium speed (ms), low speed (ls), low power (lp) and high voltage (hvl).

## Comparison

Read from each library's tech LEF (site size), cell LEF (`MACRO` count) and SPICE netlist (transistor models), in `~/.ciel/sky130A` on 2026-11-06.

| Library | Row height × site width (µm) | Cells | NMOS / PMOS used | Supply |
|---|---|---|---|---|
| **hd** | 2.72 × 0.46 | 437 | `nfet_01v8` / `pfet_01v8_hvt` | 1.8 V |
| **hdll** | 2.72 × 0.46 | 332 | `nfet_01v8` / `pfet_01v8_hvt` | 1.8 V |
| **hs** | 3.33 × 0.48 | 390 | `nfet_01v8_lvt` / `pfet_01v8` | 1.8 V |
| **ms** | 3.33 × 0.48 | 390 | `nfet_01v8_lvt` / `pfet_01v8` | 1.8 V |
| **ls** | 3.33 × 0.48 | 397 | `nfet_01v8` / `pfet_01v8_hvt` | 1.8 V |
| **lp** | 3.33 × 0.48 | 733 | `nfet_01v8` / `pfet_01v8_hvt` | 1.8 V, some corners up to 3.15 V |
| **hvl** | 4.07 × 0.48 | 69 | `g5v0d10v5` 5 V devices | 5 V |

## Differences

- **Row height.** There are two families. hd and hdll share one row height and site, so their cells can be placed in the same rows. hs, ms, ls and lp share the other, taller one. Rows from the two families can't be mixed.
- **Transistor threshold.** hs and ms use low-threshold NMOS and standard PMOS, so they are faster but leak more. hd, hdll, ls and lp use standard NMOS and high-threshold PMOS, which leak less.
- **Cell sizes** (width × height, µm):

  | Cell | hd | hdll | hs / ms / ls | lp |
  |---|---|---|---|---|
  | `inv_1` | 1.38 × 2.72 | 1.38 × 2.72 | 1.44 × 3.33 | 0.96 × 3.33 |
  | `nand2_1` | 1.38 × 2.72 | 1.84 × 2.72 | 1.44 × 3.33 | 1.44 × 3.33 |
  | `dfxtp_1` | 7.36 × 2.72 | — | 8.16 × 3.33 | 8.16 × 3.33 |

  The hd flop takes about 25% less area than the others. hdll has no `dfxtp_1`. hdll uses the same transistor types as hd, so its lower leakage probably comes from wider spacing rather than different transistors (an inference, not checked).
- **lp** has the most cells, and has 3.15 V timing corners as well as 1.8 V ones.
- **hvl** is the 5 V library: mainly level shifters and a small set of logic cells for the 5 V domain. Its few 1.8 V transistors are the low-voltage side of the level shifters.

## Why hd

This part is general knowledge, not read from the PDK files. hd is the default library in OpenLane and the caravel flow. It has the most silicon use and the most community checking. The other libraries were released with less verification, and some cells have known LVS or characterisation issues.

For the SAR and PLL logic, hd is the smallest library, it uses the same 1.8 V transistors as the analog blocks, and it is what `sky130_ejf_ip__sar_dev` and `sky130_efx_ip__pll96` already use (`cells_sar_dev.txt`, `cells_pll96.txt`). hs or ms would only help if a timing path near 96 MHz is short of margin. hvl matters only for 5 V logic or level shifting into a 5 V domain.

## Reproducing

```bash
cd ~/.ciel/sky130A/libs.ref
# site sizes
grep -A3 '^SITE' sky130_fd_sc_hd/techlef/*nom*.tlef
# cell count
grep -c '^MACRO' sky130_fd_sc_hd/lef/sky130_fd_sc_hd.lef
# transistor models
grep -hoE 'sky130_fd_pr__[a-z0-9_]+' sky130_fd_sc_hd/spice/sky130_fd_sc_hd.spice | sort | uniq -c | sort -rn
```
