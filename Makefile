# Netlists and LVS for this IP block. Run from the repo root, with Magic,
# xschem and Netgen on PATH (e.g. inside nix develop ~/nix-efx).
#
#   make sim                netlist every xschem/tb_*.sch into sim/ (ngspice)
#   make sim/tb_foo.spice   one testbench
#   make lvs CELL=foo       netlists of foo from xschem and Magic, then Netgen
#   make clean-lvs          remove generated LVS and PEX files (keeps the folders)
#   make libcdl             cdl/sky130_efx_lvdig.cdl: schematic netlist of every
#                           sky130_efx_lvdig__ cell (not allcells), as hd's cdl/
#   make libspice           spice/sky130_efx_lvdig_c.spice: layout-extracted
#                           netlist of the same cells with parasitic C
#   make libspice PEX=none  spice/sky130_efx_lvdig.spice: devices only, as hd's spice/
#   make libspice PEX=rc    spice/sky130_efx_lvdig_rc.spice: parasitic R and C
#
# Each netlist is remade only when a schematic/symbol (or, for the layout, a
# .mag) in this repo or its dependencies is newer than it.

PDK      ?= sky130A
PDK_ROOT ?= $(HOME)/.ciel
NETGEN_SETUP := $(PDK_ROOT)/$(PDK)/libs.tech/netgen/$(PDK)_setup.tcl

XSCHEM := xschem -n -s -q -x --rcfile xschemrc
MAGIC  := magic -dnull -noconsole

# Any schematic or symbol change can affect a netlist (hierarchy), so every
# netlist depends on all of them; likewise every layout netlist on all .mag.
SCH_FILES := $(wildcard xschem/*.sch xschem/*.sym dependencies/*/xschem/*.sch dependencies/*/xschem/*.sym)
MAG_FILES := $(wildcard mag/*.mag dependencies/*/mag/*.mag)
TESTBENCHES := $(patsubst xschem/%.sch,sim/%.spice,$(wildcard xschem/tb_*.sch))
# Library cells: every sky130_efx_lvdig__ schematic but the allcells test layout
LIB_CELLS := $(filter-out sky130_efx_lvdig__allcells,\
               $(patsubst xschem/%.sch,%,$(wildcard xschem/sky130_efx_lvdig__*.sch)))
LIB_CDL   := cdl/sky130_efx_lvdig.cdl
# Extracted library netlist (make libspice), all from a flattened copy of each
# cell: PEX=none devices only (as the PDK's spice/), PEX=c (default) parasitic
# C, PEX=rc parasitic R and C (Magic extresist)
PEX ?= c
ifeq ($(PEX),none)
LIB_SPICE := spice/sky130_efx_lvdig.spice
else ifeq ($(PEX),c)
LIB_SPICE := spice/sky130_efx_lvdig_c.spice
else ifeq ($(PEX),rc)
LIB_SPICE := spice/sky130_efx_lvdig_rc.spice
else
$(error PEX must be none, c or rc, not '$(PEX)')
endif
PEX_DIR := lvs/pex_$(PEX)

.PHONY: sim lvs clean-lvs libcdl libspice

# Keep the netlists: make would otherwise delete them as intermediate files
# of the lvs/%.out chain once the report is written
.SECONDARY:

sim: $(TESTBENCHES)

# Simulation netlist: a top-level testbench, into sim/ (xschemrc's netlist_dir)
sim/%.spice: xschem/%.sch $(SCH_FILES)
	cd xschem && $(XSCHEM) $*.sch

# LVS schematic netlist: the cell as a .subckt. xschem exits 10 for cells
# with a subcircuit symbol (e.g. the sky130_efx_lvdig__ cells) even though
# the netlist it writes is complete, so its exit code is ignored; instead the
# old netlist is removed first and the new one must hold the cell's .subckt.
lvs/schematic/%.spice: xschem/%.sch $(SCH_FILES)
	rm -f $@
	-cd xschem && $(XSCHEM) --tcl 'set top_is_subckt 1' -o ../lvs/schematic $*.sch
	@grep -qE '^\.subckt $*( |$$)' $@ || { echo "xschem wrote no .subckt $* to $@"; rm -f $@; exit 1; }

# LVS layout netlist: Magic in mag/ (reads ./.magicrc), .ext files to lvs/layout
lvs/layout/%.spice: mag/%.mag $(MAG_FILES)
	cd mag && printf '%s\n' 'load $*' 'extract path ../lvs/layout' 'extract all' \
	  'ext2spice lvs' 'ext2spice -p ../lvs/layout -o ../lvs/layout/$*.spice' \
	  'quit -noprompt' | $(MAGIC)

# Netgen report, remade when either netlist changes
lvs/%.out: lvs/layout/%.spice lvs/schematic/%.spice
	cd lvs && netgen -batch lvs "layout/$*.spice $*" "schematic/$*.spice $*" \
	  $(NETGEN_SETUP) $*.out

# Netgen always exits 0, so check the report: make fails on a mismatch
ifeq ($(CELL),)
lvs:
	@echo "usage: make lvs CELL=<cell>"; exit 2
else
lvs: lvs/$(CELL).out
	@if ! grep -q "Circuits match uniquely" $<; then \
	   echo "LVS $(CELL): MISMATCH, see $<"; grep "Final result" $<; exit 1; \
	 elif grep -q "Property errors were found" $<; then \
	   echo "LVS $(CELL): PROPERTY ERRORS (device sizes differ), see $<"; exit 1; \
	 else echo "LVS $(CELL): match"; fi
endif

# Library netlists (generated, not tracked; cdl/ and spice/ hold a .gitkeep),
# joined by scripts/gen_lib_netlist.py.
# Schematic (source) netlist: the cells' LVS schematic netlists (same xschem
# settings, remade as above).
libcdl: $(LIB_CDL)

$(LIB_CDL): $(LIB_CELLS:%=lvs/schematic/%.spice) scripts/gen_lib_netlist.py
	@mkdir -p $(@D)
	@python3 scripts/gen_lib_netlist.py cdl $@ $(filter %.spice,$^)

# Layout-extracted netlist, ports put in the cdl's order when joined.
libspice: $(LIB_SPICE)

$(LIB_SPICE): $(LIB_CELLS:%=$(PEX_DIR)/%.spice) $(LIB_CDL) scripts/gen_lib_netlist.py
	@mkdir -p $(@D)
	@python3 scripts/gen_lib_netlist.py spice_$(PEX) $@ $(LIB_CDL) $(filter $(PEX_DIR)/%.spice,$^)

# Each cell is flattened into an unsaved <cell>_flat and extracted in
# lvs/pex_<mode>/ (Magic starts in mag/ to read .magicrc, then cd's there).
# Flat, so every device gets its own source/drain area: the hierarchical
# extraction gave one device per shared node (e.g. a supply) that node's whole
# area. extresist (rc) also needs a flat cell it can find by name, and reads
# the .ext/.sim files from the working directory. _flat is removed when joining.
PEX_HEAD = 'load $*' 'flatten $*_flat' 'load $*_flat' 'select top cell' \
  'cd $(CURDIR)/$(@D)' 'extract all'
PEX_OUT  = 'ext2spice lvs' 'ext2spice hierarchy off' 'ext2spice subcircuit top on'
PEX_END  = 'ext2spice -o $(CURDIR)/$@' 'quit -noprompt'

lvs/pex_none/%.spice: mag/%.mag $(MAG_FILES)
	@mkdir -p $(@D)
	cd mag && printf '%s\n' $(PEX_HEAD) $(PEX_OUT) $(PEX_END) | $(MAGIC) >/dev/null

lvs/pex_c/%.spice: mag/%.mag $(MAG_FILES)
	@mkdir -p $(@D)
	cd mag && printf '%s\n' $(PEX_HEAD) $(PEX_OUT) 'ext2spice cthresh 0' $(PEX_END) \
	  | $(MAGIC) >/dev/null

lvs/pex_rc/%.spice: mag/%.mag $(MAG_FILES)
	@mkdir -p $(@D)
	cd mag && printf '%s\n' $(PEX_HEAD) 'ext2sim labels on' 'ext2sim' \
	  'extresist tolerance 10' 'extresist cell $*_flat' 'extresist all' \
	  $(PEX_OUT) 'ext2spice cthresh 0' 'ext2spice extresist on' $(PEX_END) \
	  | $(MAGIC) >/dev/null

clean-lvs:
	rm -f lvs/*.out lvs/schematic/*.spice lvs/layout/*.spice lvs/layout/*.ext \
	  lvs/pex_*/*.spice lvs/pex_*/*.ext lvs/pex_*/*.sim lvs/pex_*/*.nodes
