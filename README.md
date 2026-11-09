# sky130_efx_ip__lvdig

(c) 2026 Eric Fogleman

A library of low-voltage (1.8-V) digital cells for sky130 using relaxed lambda-based dimensions.  The lambda-based methodology allows easy placement and routing while snapping to a coarse grid.  See ([`mag/README.md`](mag/README.md)) for details on the lambda-based methodology and tcl utilities.

Repository naming convention: `<process>_<designer>_ip__<design-name>`, e.g. `sky130_efx_ip__sar`. This is the convention Efabless uses for its IP blocks (`sky130_ef_ip__…`).

## Cells

The library's logic cells and tap cells, all placed in `mag/sky130_efx_lvdig__allcells.mag`. Names are `sky130_efx_lvdig__<cell>`, where the suffix is the drive strength, as in hd. Descriptions are SkyWater's for the `sky130_fd_sc_hd` cell of the same name ([`doc/cells_skywater.md`](doc/cells_skywater.md)). Widths are the layout outline (`FIXED_BBOX`). Every cell is 3.24 µm tall (y −0.18 to 3.06 µm), taller than hd's 2.72 µm.

| Cell | Description | Width (µm) |
|---|---|---:|
| `a21o_1` | 2-input AND into first input of 2-input OR. | 4.32 |
| `a22o_1` | 2-input AND into both inputs of 2-input OR. | 5.04 |
| `and2_1` | 2-input AND. | 3.24 |
| `and2_2` | 2-input AND. | 3.60 |
| `and2_4` | 2-input AND. | 4.68 |
| `and3_1` | 3-input AND. | 4.32 |
| `and4_2` | 4-input AND. | 5.40 |
| `buf_1` | Buffer. | 2.52 |
| `buf_2` | Buffer. | 3.24 |
| `buf_4` | Buffer. | 4.32 |
| `clkbuf_1` | Clock tree buffer. | 2.52 |
| `clkbuf_2` | Clock tree buffer. | 3.24 |
| `clkbuf_4` | Clock tree buffer. | 4.32 |
| `clkbuf_8` | Clock tree buffer. | 6.84 |
| `clkdlybuf4s50_1` | Clock Delay Buffer 4-stage 0.59um length inner stage gates. | 5.76 |
| `clkinv_1` | Clock tree inverter. | 1.80 |
| `clkinv_2` | Clock tree inverter. | 2.52 |
| `clkinv_4` | Clock tree inverter. | 3.96 |
| `clkinv_8` | Clock tree inverter. | 7.20 |
| `conb_1` | Constant value, low, high outputs. | 1.08 |
| `dfbbp_1` | D flip-flop, inverted set, inverted reset, complementary outputs. | 22.32 |
| `dfrbp_1` | D flip-flop, inverted reset, complementary outputs. | 16.20 |
| `dfrbp_2` | D flip-flop, inverted reset, complementary outputs. | 17.28 |
| `dfrtp_1` | D flip-flop, inverted reset, single output. | 13.68 |
| `dfrtp_2` | D flip-flop, inverted reset, single output. | 14.04 |
| `dfstp_1` | D flip-flop, inverted set, single output. | 16.92 |
| `dfstp_2` | D flip-flop, inverted set, single output. | 17.28 |
| `dfxbp_2` | D flip-flop, complementary outputs. | 15.12 |
| `dfxtp_2` | D flip-flop, single output. | 11.88 |
| `dlygate4sd3_1` | Delay Buffer 4-stage 0.50um length inner stage gates. | 5.76 |
| `edfxbp_1` | D flip-flop with loopback enable, non-inverted clock, complementary outputs. | 19.80 |
| `edfxtp_1` | D flip-flop with loopback enable, non-inverted clock, single output. | 18.72 |
| `ha_1` | Half adder. | 6.84 |
| `inv_1` | Inverter. | 1.44 |
| `inv_2` | Inverter. | 1.80 |
| `inv_4` | Inverter. | 2.88 |
| `mux2_1` | 2-input multiplexer. | 6.84 |
| `mux2_2` | 2-input multiplexer. | 7.56 |
| `nand2_1` | 2-input NAND. | 1.80 |
| `nand2_2` | 2-input NAND. | 2.88 |
| `nor2_1` | 2-input NOR. | 1.80 |
| `nor2_2` | 2-input NOR. | 2.88 |
| `nor3_2` | 3-input NOR. | 4.68 |
| `o21a_1` | 2-input OR into first input of 2-input AND. | 4.32 |
| `or2_1` | 2-input OR. | 3.24 |
| `or2_2` | 2-input OR. | 3.60 |
| `or2_4` | 2-input OR. | 4.68 |
| `or3_1` | 3-input OR. | 4.32 |

Tap cells, one at each end of every allcells row (no schematics; LVS skips them):

| Cell | Description | Width (µm) |
|---|---|---:|
| `tapvgnd_1` | Tap cell with tap to ground, isolated power connection 1 row down. | 0.72 |
| `tapvgnd_2` | Tap cell with tap to ground, isolated power connection 1 row down. | 1.08 |
| `tapvpwrvgnd_1` | Substrate and well tap cell. | 0.72 |
| `tapvpwrvgnd_2` | Substrate and well tap cell. | 1.08 |

Decoupling capacitors (lvdig cells with no hd counterpart). Each is an nfet with its gate on VPWR and an hvt pfet with its gate on VGND, source and drain on the opposite rail; the suffix is the width in lambda (0.18 µm):

| Cell | Description | Width (µm) |
|---|---|---:|
| `decap10` | Decoupling capacitor in decap20's style: one nfet W 0.63 / L 0.72 and one pfet W 0.90 / L 0.72, gates tied off through poly pads between them. | 1.80 |
| `decap20` | Decoupling capacitor in hd's decap style: one nfet W 0.63 / L 2.52 and one pfet W 0.90 / L 2.52, gates tied off through poly pads between them. | 3.60 |

Filler cells (layout only, no schematic or symbol): rails, gridded rail contacts, n-well and p-well, to fill gaps in a row (allcells pads each row to the widest with them). filler2 and filler4 run their n-well past both edges to meet the 0.84 µm minimum width, as the 4L tap cells do:

| Cell | Description | Width (µm) |
|---|---|---:|
| `filler2` | Filler, 2L. | 0.36 |
| `filler4` | Filler, 4L. | 0.72 |
| `filler6` | Filler, 6L. | 1.08 |
| `filler8` | Filler, 8L. | 1.44 |

hd's descriptions of the delay cells give an inner-stage gate length (0.50 µm for dlygate4sd3, 0.59 µm for clkdlybuf4s50); both cells here use the 0.5 µm of hd's netlists. Transistor widths are snapped to the lambda grid, so cells don't match hd's sizes exactly (see `NOTICE` and CLAUDE.md).

## Files

- `xschem/xschemrc`: loads the PDK (once), this directory's symbols and each dependency's xschemrc. Run `xschem` in `xschem/`.
- `mag/.magicrc`: loads the Sky130 Magic setup, then `mag/efx.tcl`, then each dependency's `mag/` on the cell search path. Run `magic <cell>` in `mag/`, or `magic -rcfile mag/.magicrc mag/<cell>` from anywhere.
- `mag/efx.tcl`: the efx lambda-grid generators (L = 0.18 µm) and the "efx" menu. A copy of `~/Projects/glayout_test/magic/efx.tcl`, where it is developed and checked against its Python twin; recopy it from there after changes.
- `mag/README.md`: the efx lambda methodology: grid, rules, every generator, pins, checking.
- `dependencies/`: other IP blocks, as git submodules (below).
- `doc/`: documentation.
- `sim/`: testbench netlists from xschem (tracked) and ngspice runs (outputs ignored), with the Sky130 `.spiceinit`.
- `lvs/`: LVS netlists (`schematic/`, `layout/`) and Netgen reports, all generated and ignored by git.
- `cdl/sky130_efx_lvdig.cdl` and `spice/sky130_efx_lvdig{,_c,_rc}.spice`: the library netlists, one `.subckt` per cell. They are generated and not tracked in git (the folders hold a `.gitkeep`); run `make libcdl libspice` after cloning. They mirror the PDK's `libs.ref/sky130_fd_sc_hd/`. `cdl/` is the schematic (source) netlist (`make libcdl`). `spice/` holds the netlists extracted from the layouts (`make libspice`): devices only, as in the PDK, or with parasitic C, or with parasitic R and C. Their ports are in the same order, so a testbench can include either after the PDK models.
- `Makefile`: makes the simulation and LVS netlists and runs LVS (below).
- `LICENSE`, `LICENSE-MPL-2.0`: the two licenses (below).

## Netlists and LVS

Run these from the repo root, with Magic, xschem and Netgen on PATH (e.g. inside `nix develop ~/nix-efx`). `PDK` and `PDK_ROOT` default to `sky130A` and `~/.ciel`.

```bash
make sim                  # netlist every xschem/tb_*.sch into sim/, for ngspice
make sim/tb_foo.spice     # one testbench
make lvs CELL=foo         # xschem and Magic netlists of foo, then Netgen
make clean-lvs            # remove the generated LVS files (keeps the folders)
make libcdl               # schematic library netlist cdl/sky130_efx_lvdig.cdl
make libspice             # extracted library netlist with parasitic C, spice/sky130_efx_lvdig_c.spice
make libspice PEX=none    # devices only (as the PDK's spice/), spice/sky130_efx_lvdig.spice
make libspice PEX=rc      # parasitic R and C, spice/sky130_efx_lvdig_rc.spice
```

- **Testbenches** are the `xschem/tb_*.sch` files. Run ngspice yourself in `sim/` (`cd sim; ngspice tb_foo.spice`), so it reads `sim/.spiceinit`.
- **`make libcdl`** joins the cells' xschem netlists (the same ones LVS uses). It is written in SPICE syntax, which both Netgen and ngspice read.
- **`make libspice [PEX=none|c|rc]`** extracts a flattened copy of each layout in Magic, into `lvs/pex_<mode>/`, and joins the cells. Flattening gives every device its own source/drain area. `PEX=c` (the default) adds every non-zero capacitance; `PEX=rc` also adds resistance (`extresist`), splitting nets at the resistors (`<net>.n<k>`, `<net>.t<k>`). The joiner puts each cell's ports in the CDL's order (Magic orders them by pin-label number) and removes Magic's `$ **FLOATING` notes, which Netgen misreads. All four netlists have the same ports and can be swapped in a testbench.
- **These netlists differ from the PDK's.** They have the lambda-grid widths and this library's port order (logic pins, then `VGND VNB VPB VPWR`), so neither is interchangeable with the PDK's `sky130_fd_sc_hd` netlists. Rerun both targets after changing a schematic or layout.
- **`make lvs` reads the report.** It prints `LVS foo: match`, or fails with `MISMATCH, see lvs/foo.out` and Netgen's final result. Netgen itself always exits 0.
- **Only what's out of date is remade.** Any `.sch`/`.sym` change, here or in `dependencies/`, re-netlists the schematics, and any `.mag` change re-extracts the layout.
- **The steps by hand:** `mag/README.md`, section 9.

## Licensing

- **The design** (schematics, symbols, layouts, netlists, scripts and documentation) is licensed under the Apache License 2.0: [`LICENSE`](LICENSE).
- **The efx generators** (`mag/efx.tcl`) are licensed under the Mozilla Public License 2.0: [`LICENSE-MPL-2.0`](LICENSE-MPL-2.0). Each such file starts with an `SPDX-License-Identifier: MPL-2.0` header.

Anything without an MPL-2.0 header is Apache-2.0. Layouts drawn with the efx generators are part of the design, so they are Apache-2.0. Only the generator code is MPL-2.0.

**Acknowledgements** ([`NOTICE`](NOTICE)). The cells re-implement SkyWater's `sky130_fd_sc_hd` library (Apache-2.0). The schematics and library netlists take their topology and device sizes from hd's netlists; the layouts were drawn independently. The cell symbols are modified copies of Stefan Schippers' `xschem_sky130` symbols (Apache-2.0), and `doc/cells_skywater.md` is copied from the SkyWater PDK documentation (an unofficial build at sky130-unofficial.readthedocs.io).

## Dependencies

An IP block that uses other IP blocks keeps each one as a **git submodule inside `dependencies/`**: every dependency is a complete repository of its own at `dependencies/<ip_block>/`, with its own `xschem/`, `mag/` and so on.

This follows Efabless's [sky130_ef_ip__template](https://github.com/efabless/sky130_ef_ip__template), where the same folder is called `ip/` (in older copies, `deps/`). Its README describes it as "IP blocks that the project depends on".

### Adding a dependency

Use a relative URL, so the submodule is cloned the same way as the parent repository (HTTPS or SSH):

```bash
# dependency owned by the same GitHub user as this repository
git submodule add ../<ip_block>.git dependencies/<ip_block>

# dependency owned by another GitHub user
git submodule add ../../<user>/<ip_block>.git dependencies/<ip_block>
```

Cloning a repository that has dependencies, including their own dependencies:

```bash
git clone --recurse-submodules <url>
# or, in an existing clone:
git submodule update --init --recursive
```

### Making the tools see dependencies

A submodule in `dependencies/` does nothing on its own. Each tool's startup file has to load it.

**xschem** (`xschem/xschemrc`). Efabless's template sources the xschemrc of every dependency, which adds that block's symbols to the search path. Because each dependency's xschemrc does the same, this repeats down the tree. The `info exists PDK` guard stops a dependency from loading the PDK a second time when its xschemrc is sourced from a parent.

```tcl
# Source the PDK xschemrc (only once, at the top level)
if {![info exists PDK]} {
    source $env(PDK_ROOT)/$env(PDK)/libs.tech/xschem/xschemrc
}

# Add this directory to the xschem library path
append XSCHEM_LIBRARY_PATH :[file dirname [info script]]

# Load each dependency's own xschemrc (recursive: they do the same)
foreach rc [glob -nocomplain [file dirname [info script]]/../dependencies/*/xschem/xschemrc] {
    source $rc
}
```

**Magic** (`mag/.magicrc`). Efabless's README says nothing about Magic and dependencies. The sketch below sources the PDK and adds each dependency's `mag/` to Magic's cell search path. Both snippets were tested (2026-11-06) on a mock project with one dependency, one level deep: xschem gained the dependency's symbol folder and loaded the PDK once; Magic loaded sky130A and gained the dependency's `mag/` in `path search`.

```tcl
# Sky130 technology, DRC, extraction and device generators
source $env(PDK_ROOT)/$env(PDK)/libs.tech/magic/$env(PDK).magicrc

# Find cells of each dependency (not recursive)
foreach d [glob -nocomplain -type d [file dirname [file normalize [info script]]]/../dependencies/*/mag] {
    addpath $d
}
```

Start Magic in `mag/` (`cd mag; magic <cell>`), so it reads `./.magicrc`, or pass `-rcfile mag/.magicrc` from anywhere else. Plain Magic saves a new cell in the folder it was started in; efx saves a new efx gencell beside the cell it is placed in (in a dependency's `mag/` if that is where the parent lives). Other new cells (a new top cell, a PDK gencell) still go to the start folder, so starting in `mag/` is the simplest habit. Placing a dependency's cell while started elsewhere records a path relative to the start folder in the parent's `use` line; Magic still finds the cell through the dependency search path. `-rcfile <file>` replaces `./.magicrc`, so an alias such as `magic -rcfile …/sky130A.magicrc` skips this file and its dependency paths.

## Sources

- Efabless template repository: https://github.com/efabless/sky130_ef_ip__template
- Its `xschem/xschemrc`: https://raw.githubusercontent.com/efabless/sky130_ef_ip__template/main/xschem/xschemrc
