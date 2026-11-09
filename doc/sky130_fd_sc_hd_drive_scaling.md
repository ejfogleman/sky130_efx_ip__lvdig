# Drive strength scaling in sky130_fd_sc_hd

How `sky130_fd_sc_hd` cells grow from 1× to 2× to 4× (the `_1`, `_2`, `_4` suffix), for gates and flip-flops.

Read from the PDK netlist `libs.ref/sky130_fd_sc_hd/spice/sky130_fd_sc_hd.spice` (sky130A in `~/.ciel`, 2026-11-06). The cells in `cells_sar_dev.txt` and `cells_pll96.txt` were compared transistor by transistor while drawing their schematics (`xschem/`). The 4× cells and `dfxtp_1` are not in those lists; for them only the output devices and the transistor counts were checked. Sizes are written pfet W / nfet W in µm; all L = 0.15 µm.

## Summary

The library scales mostly by putting more fixed-size transistors ("fingers") in parallel, not by making transistors wider. Only the stage that drives the output pin grows. The internal stages stay at or near minimum size until the output is large enough to need a bigger driver.

## The unit device

A 1× output stage is a 1.0 µm pfet and a 0.65 µm nfet. That size stays the same at every strength: 2× and 4× are two and four of those transistors in parallel. The cell is only 2.72 µm tall, which caps how wide one transistor can be, so the extra drive goes sideways as more fingers.

## Single-stage gates: inv, nand, nor

Every transistor is replicated, including the series stacks:

| Cell | 1× | 2× | 4× |
|---|---|---|---|
| `inv` | 1 / 0.65 | ×2 | ×4 |
| `nand2`, `nor2` | 1 / 0.65 each | ×2 | ×4 |

Series transistors are not made wider to make up for being stacked. A `nand2`'s two series 0.65 µm nfets are the same size as an inverter's single one. So a `nand2_1` pulls down more weakly than an `inv_1`, and a `nor2_1` pulls up more weakly. The suffix is a nominal size, not equalised drive.

## Multi-stage gates: buf, and, or, mux

The output stage takes the multiplier. The input stage stays small and grows only once the output needs it, which keeps the step-up between stages to about 4× or less:

| Cell | Input stage | Output stage |
|---|---|---|
| `buf_1` | 0.79 / 0.52 | 0.79 / 0.52 |
| `buf_2` | 0.64 / 0.42 | 1 / 0.65 ×2 |
| `buf_4` | 1 / 0.65 | 1 / 0.65 ×4 |
| `and2_1`, `and2_2` | NAND 0.42 / 0.42 | 1 / 0.65 ×1, ×2 |
| `and2_4` | NAND 1 / 0.65 | 1 / 0.65 ×4 |
| `clkbuf_4` → `clkbuf_8` | 1 / 0.42 → ×2 | ×4 → ×8 |

The `or2` cells follow the same pattern as `and2` (NOR input stage). `mux2_2` widens its core pfets (0.42 → 0.64) and its select inverter's pfet, as well as doubling the output stage.

## Clock cells use a different size ratio

`clkbuf` and `clkinv` use a 1 / 0.42 pfet-to-nfet ratio instead of 1 / 0.65, presumably to make rising and falling edges equal, which matters more for clocks than for logic. Their multipliers are also uneven: `clkinv_1` is 2 pfets (0.84) to 1 nfet, `clkinv_2` is 3 to 2, and `clkinv_8` is 12 to 8.

## Flip-flops: only the output stage changes

The clock buffers, latches and feedback are the same at every strength; only the output inverter is replicated. In `dfrtp_1` and `dfrtp_2` this was checked transistor by transistor. For the 4× cells, only transistor counts were compared: `dfrtp_4` has 34 against `dfrtp_1`'s 28, and `dfxtp_1`/`_2`/`_4` have 24/26/30. Both are exactly the extra output fingers.

| Cell | Stage driving the output | `Q` output stage |
|---|---|---|
| `dfrtp_1/2/4` | slave NAND, 0.42 / 0.42, all strengths | ×1 / ×2 / ×4 |
| `dfxtp_1/2/4` | slave inverter, 1 / 0.65 | ×1 / ×2 / ×4 |
| `dfstp_1` → `_2` | inverter grows, 0.64 / 0.42 → 1 / 0.65 | ×1 → ×2 |
| `dfrbp_1` → `_2` | `Q_N` pre-inverter fixed at 0.64 / 0.42 | `Q` and `Q_N` ×1 → ×2 |

The exception is `dfstp`, which enlarges the stage before the output when going to 2×. In `dfrtp`, the slave NAND (0.42 µm) drives the output stage directly at all three strengths. So `dfrtp_4` puts a large load on a small internal node: the storage stays small and the larger load costs some clock-to-Q delay.

## For choosing cells

These follow from the sizes above; they have not been checked by simulation.

- A higher drive suffix makes a flop or buffer drive a heavy load better. It doesn't make its input or internal timing faster, and it adds input capacitance only where the input stage grows (as in `buf_4` and `and2_4`).
- A NAND or NOR of the same suffix as an inverter is weaker in one direction, because series stacks aren't widened.
- For a heavily loaded flop output, `dfxtp_2` followed by a separate buffer can beat `dfrtp_4`, because `dfrtp_4` drives its big output stage from a minimum-size NAND.

## Reproducing

```bash
F=~/.ciel/sky130A/libs.ref/sky130_fd_sc_hd/spice/sky130_fd_sc_hd.spice
# one cell's netlist
awk '$1==".subckt" && $2=="sky130_fd_sc_hd__dfrtp_4" {f=1} f {print} f && /^.ends/ {exit}' $F
# transistor counts across strengths
for c in dfxtp_1 dfxtp_2 dfxtp_4; do
  echo "$c $(awk -v c=sky130_fd_sc_hd__$c '$1==".subckt"&&$2==c{f=1} f&&/^X/{n++} f&&/^.ends/{print n; exit}' $F)"
done
```

The netlist writes widths as `w=650000u`, which is 0.65 µm under the PDK's scale option.
