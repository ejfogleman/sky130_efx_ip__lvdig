# sky130_efx_ip__template

Template for Sky130 analog IP block repositories.

Repository naming convention: `<process>_<designer>_ip__<design-name>`, e.g. `sky130_efx_ip__sar`. This is the convention Efabless uses for its IP blocks (`sky130_ef_ip__…`).

## Files

- `xschem/xschemrc`: loads the PDK (once), this directory's symbols and each dependency's xschemrc. Run `xschem` in `xschem/`.
- `mag/.magicrc`: loads the Sky130 Magic setup, then `mag/efx.tcl`, then each dependency's `mag/` on the cell search path. Run `magic <cell>` in `mag/`, or `magic -rcfile mag/.magicrc mag/<cell>` from anywhere.
- `mag/efx.tcl`: the efx lambda-grid generators (L = 0.18 µm) and the "efx" menu. A copy of `~/Projects/glayout_test/magic/efx.tcl`, where it is developed and checked against its Python twin; recopy it from there after changes.
- `mag/README.md`: the efx lambda methodology: grid, rules, every generator, pins, checking.
- `dependencies/`: other IP blocks, as git submodules (below).
- `doc/`: documentation.
- `sim/`: testbench netlists from xschem (tracked) and ngspice runs (outputs ignored), with the Sky130 `.spiceinit`.
- `lvs/`: LVS netlists (`schematic/`, `layout/`) and Netgen reports, all generated and ignored by git.
- `Makefile`: makes the simulation and LVS netlists and runs LVS (below).
- `LICENSE`, `LICENSE-MPL-2.0`: the two licenses (below).

## Netlists and LVS

Run these from the repo root, with Magic, xschem and Netgen on PATH (e.g. inside `nix develop ~/nix-efx`). `PDK` and `PDK_ROOT` default to `sky130A` and `~/.ciel`.

```bash
make sim                  # netlist every xschem/tb_*.sch into sim/, for ngspice
make sim/tb_foo.spice     # one testbench
make lvs CELL=foo         # xschem and Magic netlists of foo, then Netgen
make clean-lvs            # remove the generated LVS files (keeps the folders)
```

- **Testbenches** are the `xschem/tb_*.sch` files. Run ngspice yourself in `sim/` (`cd sim; ngspice tb_foo.spice`), so it reads `sim/.spiceinit`.
- **`make lvs` reads the report.** It prints `LVS foo: match`, or fails with `MISMATCH, see lvs/foo.out` and Netgen's final result. Netgen itself always exits 0.
- **Only what's out of date is remade.** Any `.sch`/`.sym` change, here or in `dependencies/`, re-netlists the schematics, and any `.mag` change re-extracts the layout.
- **The steps by hand:** `mag/README.md`, section 9.

## Licensing

- **The design** (schematics, symbols, layouts, netlists, scripts and documentation) is licensed under the Apache License 2.0: [`LICENSE`](LICENSE).
- **The efx generators** (`mag/efx.tcl`) are licensed under the Mozilla Public License 2.0: [`LICENSE-MPL-2.0`](LICENSE-MPL-2.0). Each such file starts with an `SPDX-License-Identifier: MPL-2.0` header.

Anything without an MPL-2.0 header is Apache-2.0. Layouts drawn with the efx generators are part of the design, so they are Apache-2.0. Only the generator code is MPL-2.0.

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
