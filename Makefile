# Netlists and LVS for this IP block. Run from the repo root, with Magic,
# xschem and Netgen on PATH (e.g. inside nix develop ~/nix-efx).
#
#   make sim                netlist every xschem/tb_*.sch into sim/ (ngspice)
#   make sim/tb_foo.spice   one testbench
#   make lvs CELL=foo       netlists of foo from xschem and Magic, then Netgen
#   make clean-lvs          remove generated LVS files (keeps the folders)
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

.PHONY: sim lvs clean-lvs

# Keep the netlists: make would otherwise delete them as intermediate files
# of the lvs/%.out chain once the report is written
.SECONDARY:

sim: $(TESTBENCHES)

# Simulation netlist: a top-level testbench, into sim/ (xschemrc's netlist_dir)
sim/%.spice: xschem/%.sch $(SCH_FILES)
	cd xschem && $(XSCHEM) $*.sch

# LVS schematic netlist: the cell as a .subckt
lvs/schematic/%.spice: xschem/%.sch $(SCH_FILES)
	cd xschem && $(XSCHEM) --tcl 'set top_is_subckt 1' -o ../lvs/schematic $*.sch

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
	@if grep -q "Circuits match uniquely" $<; then echo "LVS $(CELL): match"; \
	 else echo "LVS $(CELL): MISMATCH, see $<"; grep "Final result" $<; exit 1; fi
endif

clean-lvs:
	rm -f lvs/*.out lvs/schematic/*.spice lvs/layout/*.spice lvs/layout/*.ext
