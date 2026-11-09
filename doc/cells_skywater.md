# List of cells in sky130_fd_sc_hd

Copied from the SkyWater SKY130 PDK documentation, "sky130_fd_sc_hd - SKY130 High Density Digital Standard Cells (SkyWater Provided)", as published at https://sky130-unofficial.readthedocs.io/en/latest/contents/libraries/sky130_fd_sc_hd/README.html (an unofficial build of the documentation from google/skywater-pdk, Apache-2.0; the page itself states no license). See `NOTICE`. Converted from the page's HTML table to Markdown on 2026-11-08, with SkyWater's "Delay flop" written "D flip-flop".

| Cell name | Description | Type | Verilog name |
|---|---|---|---|
| a2111o | 2-input AND into first input of 4-input OR. | cell | sky130_fd_sc_hd__a2111o |
| a2111oi | 2-input AND into first input of 4-input NOR. | cell | sky130_fd_sc_hd__a2111oi |
| a211o | 2-input AND into first input of 3-input OR. | cell | sky130_fd_sc_hd__a211o |
| a211oi | 2-input AND into first input of 3-input NOR. | cell | sky130_fd_sc_hd__a211oi |
| a21bo | 2-input AND into first input of 2-input OR, 2nd input inverted. | cell | sky130_fd_sc_hd__a21bo |
| a21boi | 2-input AND into first input of 2-input NOR, 2nd input inverted. | cell | sky130_fd_sc_hd__a21boi |
| a21o | 2-input AND into first input of 2-input OR. | cell | sky130_fd_sc_hd__a21o |
| a21oi | 2-input AND into first input of 2-input NOR. | cell | sky130_fd_sc_hd__a21oi |
| a221o | 2-input AND into first two inputs of 3-input OR. | cell | sky130_fd_sc_hd__a221o |
| a221oi | 2-input AND into first two inputs of 3-input NOR. | cell | sky130_fd_sc_hd__a221oi |
| a222oi | 2-input AND into all inputs of 3-input NOR. | cell | sky130_fd_sc_hd__a222oi |
| a22o | 2-input AND into both inputs of 2-input OR. | cell | sky130_fd_sc_hd__a22o |
| a22oi | 2-input AND into both inputs of 2-input NOR. | cell | sky130_fd_sc_hd__a22oi |
| a2bb2o | 2-input AND, both inputs inverted, into first input, and 2-input AND into 2nd input of 2-input OR. | cell | sky130_fd_sc_hd__a2bb2o |
| a2bb2oi | 2-input AND, both inputs inverted, into first input, and 2-input AND into 2nd input of 2-input NOR. | cell | sky130_fd_sc_hd__a2bb2oi |
| a311o | 3-input AND into first input of 3-input OR. | cell | sky130_fd_sc_hd__a311o |
| a311oi | 3-input AND into first input of 3-input NOR. | cell | sky130_fd_sc_hd__a311oi |
| a31o | 3-input AND into first input of 2-input OR. | cell | sky130_fd_sc_hd__a31o |
| a31oi | 3-input AND into first input of 2-input NOR. | cell | sky130_fd_sc_hd__a31oi |
| a32o | 3-input AND into first input, and 2-input AND into 2nd input of 2-input OR. | cell | sky130_fd_sc_hd__a32o |
| a32oi | 3-input AND into first input, and 2-input AND into 2nd input of 2-input NOR. | cell | sky130_fd_sc_hd__a32oi |
| a41o | 4-input AND into first input of 2-input OR. | cell | sky130_fd_sc_hd__a41o |
| a41oi | 4-input AND into first input of 2-input NOR. | cell | sky130_fd_sc_hd__a41oi |
| and2 | 2-input AND. | cell | sky130_fd_sc_hd__and2 |
| and2b | 2-input AND, first input inverted. | cell | sky130_fd_sc_hd__and2b |
| and3 | 3-input AND. | cell | sky130_fd_sc_hd__and3 |
| and3b | 3-input AND, first input inverted. | cell | sky130_fd_sc_hd__and3b |
| and4 | 4-input AND. | cell | sky130_fd_sc_hd__and4 |
| and4b | 4-input AND, first input inverted. | cell | sky130_fd_sc_hd__and4b |
| and4bb | 4-input AND, first two inputs inverted. | cell | sky130_fd_sc_hd__and4bb |
| buf | Buffer. | cell | sky130_fd_sc_hd__buf |
| bufbuf | Double buffer. | cell | sky130_fd_sc_hd__bufbuf |
| bufinv | Buffer followed by inverter. | cell | sky130_fd_sc_hd__bufinv |
| clkbuf | Clock tree buffer. | cell | sky130_fd_sc_hd__clkbuf |
| clkdlybuf4s15 | Clock Delay Buffer 4-stage 0.15um length inner stage gates. | cell | sky130_fd_sc_hd__clkdlybuf4s15 |
| clkdlybuf4s18 | Clock Delay Buffer 4-stage 0.18um length inner stage gates. | cell | sky130_fd_sc_hd__clkdlybuf4s18 |
| clkdlybuf4s25 | Clock Delay Buffer 4-stage 0.25um length inner stage gates. | cell | sky130_fd_sc_hd__clkdlybuf4s25 |
| clkdlybuf4s50 | Clock Delay Buffer 4-stage 0.59um length inner stage gates. | cell | sky130_fd_sc_hd__clkdlybuf4s50 |
| clkinv | Clock tree inverter. | cell | sky130_fd_sc_hd__clkinv |
| clkinvlp | Lower power Clock tree inverter. | cell | sky130_fd_sc_hd__clkinvlp |
| conb | Constant value, low, high outputs. | cell | sky130_fd_sc_hd__conb |
| decap | Decoupling capacitance filler. | cell | sky130_fd_sc_hd__decap |
| dfbbn | D flip-flop, inverted set, inverted reset, inverted clock, complementary outputs. | cell | sky130_fd_sc_hd__dfbbn |
| dfbbp | D flip-flop, inverted set, inverted reset, complementary outputs. | cell | sky130_fd_sc_hd__dfbbp |
| dfrbp | D flip-flop, inverted reset, complementary outputs. | cell | sky130_fd_sc_hd__dfrbp |
| dfrtn | D flip-flop, inverted reset, inverted clock, complementary outputs. | cell | sky130_fd_sc_hd__dfrtn |
| dfrtp | D flip-flop, inverted reset, single output. | cell | sky130_fd_sc_hd__dfrtp |
| dfsbp | D flip-flop, inverted set, complementary outputs. | cell | sky130_fd_sc_hd__dfsbp |
| dfstp | D flip-flop, inverted set, single output. | cell | sky130_fd_sc_hd__dfstp |
| dfxbp | D flip-flop, complementary outputs. | cell | sky130_fd_sc_hd__dfxbp |
| dfxtp | D flip-flop, single output. | cell | sky130_fd_sc_hd__dfxtp |
| diode | Antenna tie-down diode. | cell | sky130_fd_sc_hd__diode |
| dlclkp | Clock gate. | cell | sky130_fd_sc_hd__dlclkp |
| dlrbn | Delay latch, inverted reset, inverted enable, complementary outputs. | cell | sky130_fd_sc_hd__dlrbn |
| dlrbp | Delay latch, inverted reset, non-inverted enable, complementary outputs. | cell | sky130_fd_sc_hd__dlrbp |
| dlrtn | Delay latch, inverted reset, inverted enable, single output. | cell | sky130_fd_sc_hd__dlrtn |
| dlrtp | Delay latch, inverted reset, non-inverted enable, single output. | cell | sky130_fd_sc_hd__dlrtp |
| dlxbn | Delay latch, inverted enable, complementary outputs. | cell | sky130_fd_sc_hd__dlxbn |
| dlxbp | Delay latch, non-inverted enable, complementary outputs. | cell | sky130_fd_sc_hd__dlxbp |
| dlxtn | Delay latch, inverted enable, single output. | cell | sky130_fd_sc_hd__dlxtn |
| dlxtp | Delay latch, non-inverted enable, single output. | cell | sky130_fd_sc_hd__dlxtp |
| dlygate4sd1 | Delay Buffer 4-stage 0.15um length inner stage gates. | cell | sky130_fd_sc_hd__dlygate4sd1 |
| dlygate4sd2 | Delay Buffer 4-stage 0.18um length inner stage gates. | cell | sky130_fd_sc_hd__dlygate4sd2 |
| dlygate4sd3 | Delay Buffer 4-stage 0.50um length inner stage gates. | cell | sky130_fd_sc_hd__dlygate4sd3 |
| dlymetal6s2s | 6-inverter delay with output from 2nd stage on horizontal route. | cell | sky130_fd_sc_hd__dlymetal6s2s |
| dlymetal6s4s | 6-inverter delay with output from 4th inverter on horizontal route. | cell | sky130_fd_sc_hd__dlymetal6s4s |
| dlymetal6s6s | 6-inverter delay with output from 6th inverter on horizontal route. | cell | sky130_fd_sc_hd__dlymetal6s6s |
| ebufn | Tri-state buffer, negative enable. | cell | sky130_fd_sc_hd__ebufn |
| edfxbp | D flip-flop with loopback enable, non-inverted clock, complementary outputs. | cell | sky130_fd_sc_hd__edfxbp |
| edfxtp | D flip-flop with loopback enable, non-inverted clock, single output. | cell | sky130_fd_sc_hd__edfxtp |
| einvn | Tri-state inverter, negative enable. | cell | sky130_fd_sc_hd__einvn |
| einvp | Tri-state inverter, positive enable. | cell | sky130_fd_sc_hd__einvp |
| fa | Full adder. | cell | sky130_fd_sc_hd__fa |
| fah | Full adder. | cell | sky130_fd_sc_hd__fah |
| fahcin | Full adder, inverted carry in. | cell | sky130_fd_sc_hd__fahcin |
| fahcon | Full adder, inverted carry in, inverted carry out. | cell | sky130_fd_sc_hd__fahcon |
| fill | Fill cell. | cell | sky130_fd_sc_hd__fill |
| ha | Half adder. | cell | sky130_fd_sc_hd__ha |
| inv | Inverter. | cell | sky130_fd_sc_hd__inv |
| lpflow_bleeder | Current bleeder (weak pulldown to ground). | cell | sky130_fd_sc_hd__lpflow_bleeder |
| lpflow_clkbufkapwr | Clock tree buffer on keep-alive power rail. | cell | sky130_fd_sc_hd__lpflow_clkbufkapwr |
| lpflow_clkinvkapwr | Clock tree inverter on keep-alive rail. | cell | sky130_fd_sc_hd__lpflow_clkinvkapwr |
| lpflow_decapkapwr | Decoupling capacitance filler on keep-alive rail. | cell | sky130_fd_sc_hd__lpflow_decapkapwr |
| lpflow_inputiso0n | Input isolator with inverted enable. | cell | sky130_fd_sc_hd__lpflow_inputiso0n |
| lpflow_inputiso0p | Input isolator with non-inverted enable. | cell | sky130_fd_sc_hd__lpflow_inputiso0p |
| lpflow_inputiso1n | Input isolation, inverted sleep. | cell | sky130_fd_sc_hd__lpflow_inputiso1n |
| lpflow_inputiso1p | Input isolation, noninverted sleep. | cell | sky130_fd_sc_hd__lpflow_inputiso1p |
| lpflow_inputisolatch | Latching input isolator with inverted enable. | cell | sky130_fd_sc_hd__lpflow_inputisolatch |
| lpflow_isobufsrc | Input isolation, noninverted sleep. | cell | sky130_fd_sc_hd__lpflow_isobufsrc |
| lpflow_isobufsrckapwr | Input isolation, noninverted sleep on keep-alive power rail. | cell | sky130_fd_sc_hd__lpflow_isobufsrckapwr |
| lpflow_lsbuf_lh_hl_isowell_tap | Level-shift buffer, low-to-high, isolated well on input buffer, vpb/vnb taps, double-row-height cell. | cell | sky130_fd_sc_hd__lpflow_lsbuf_lh_hl_isowell_tap |
| lpflow_lsbuf_lh_isowell | Level-shift buffer, low-to-high, isolated well on input buffer, no taps, double-row-height cell. | cell | sky130_fd_sc_hd__lpflow_lsbuf_lh_isowell |
| lpflow_lsbuf_lh_isowell_tap | Level-shift buffer, low-to-high, isolated well on input buffer, vpb/vnb taps, double-row-height cell. | cell | sky130_fd_sc_hd__lpflow_lsbuf_lh_isowell_tap |
| macro_sparecell | Macro cell for metal-mask-only revisioning, containing inverter, 2-input NOR, 2-input NAND, and constant cell. | cell | sky130_fd_sc_hd__macro_sparecell |
| maj3 | 3-input majority vote. | cell | sky130_fd_sc_hd__maj3 |
| mux2 | 2-input multiplexer. | cell | sky130_fd_sc_hd__mux2 |
| mux2i | 2-input multiplexer, output inverted. | cell | sky130_fd_sc_hd__mux2i |
| mux4 | 4-input multiplexer. | cell | sky130_fd_sc_hd__mux4 |
| nand2 | 2-input NAND. | cell | sky130_fd_sc_hd__nand2 |
| nand2b | 2-input NAND, first input inverted. | cell | sky130_fd_sc_hd__nand2b |
| nand3 | 3-input NAND. | cell | sky130_fd_sc_hd__nand3 |
| nand3b | 3-input NAND, first input inverted. | cell | sky130_fd_sc_hd__nand3b |
| nand4 | 4-input NAND. | cell | sky130_fd_sc_hd__nand4 |
| nand4b | 4-input NAND, first input inverted. | cell | sky130_fd_sc_hd__nand4b |
| nand4bb | 4-input NAND, first two inputs inverted. | cell | sky130_fd_sc_hd__nand4bb |
| nor2 | 2-input NOR. | cell | sky130_fd_sc_hd__nor2 |
| nor2b | 2-input NOR, first input inverted. | cell | sky130_fd_sc_hd__nor2b |
| nor3 | 3-input NOR. | cell | sky130_fd_sc_hd__nor3 |
| nor3b | 3-input NOR, first input inverted. | cell | sky130_fd_sc_hd__nor3b |
| nor4 | 4-input NOR. | cell | sky130_fd_sc_hd__nor4 |
| nor4b | 4-input NOR, first input inverted. | cell | sky130_fd_sc_hd__nor4b |
| nor4bb | 4-input NOR, first two inputs inverted. | cell | sky130_fd_sc_hd__nor4bb |
| o2111a | 2-input OR into first input of 4-input AND. | cell | sky130_fd_sc_hd__o2111a |
| o2111ai | 2-input OR into first input of 4-input NAND. | cell | sky130_fd_sc_hd__o2111ai |
| o211a | 2-input OR into first input of 3-input AND. | cell | sky130_fd_sc_hd__o211a |
| o211ai | 2-input OR into first input of 3-input NAND. | cell | sky130_fd_sc_hd__o211ai |
| o21a | 2-input OR into first input of 2-input AND. | cell | sky130_fd_sc_hd__o21a |
| o21ai | 2-input OR into first input of 2-input NAND. | cell | sky130_fd_sc_hd__o21ai |
| o21ba | 2-input OR into first input of 2-input AND, 2nd input inverted. | cell | sky130_fd_sc_hd__o21ba |
| o21bai | 2-input OR into first input of 2-input NAND, 2nd iput inverted. | cell | sky130_fd_sc_hd__o21bai |
| o221a | 2-input OR into first two inputs of 3-input AND. | cell | sky130_fd_sc_hd__o221a |
| o221ai | 2-input OR into first two inputs of 3-input NAND. | cell | sky130_fd_sc_hd__o221ai |
| o22a | 2-input OR into both inputs of 2-input AND. | cell | sky130_fd_sc_hd__o22a |
| o22ai | 2-input OR into both inputs of 2-input NAND. | cell | sky130_fd_sc_hd__o22ai |
| o2bb2a | 2-input NAND and 2-input OR into 2-input AND. | cell | sky130_fd_sc_hd__o2bb2a |
| o2bb2ai | 2-input NAND and 2-input OR into 2-input NAND. | cell | sky130_fd_sc_hd__o2bb2ai |
| o311a | 3-input OR into 3-input AND. | cell | sky130_fd_sc_hd__o311a |
| o311ai | 3-input OR into 3-input NAND. | cell | sky130_fd_sc_hd__o311ai |
| o31a | 3-input OR into 2-input AND. | cell | sky130_fd_sc_hd__o31a |
| o31ai | 3-input OR into 2-input NAND. | cell | sky130_fd_sc_hd__o31ai |
| o32a | 3-input OR and 2-input OR into 2-input AND. | cell | sky130_fd_sc_hd__o32a |
| o32ai | 3-input OR and 2-input OR into 2-input NAND. | cell | sky130_fd_sc_hd__o32ai |
| o41a | 4-input OR into 2-input AND. | cell | sky130_fd_sc_hd__o41a |
| o41ai | 4-input OR into 2-input NAND. | cell | sky130_fd_sc_hd__o41ai |
| or2 | 2-input OR. | cell | sky130_fd_sc_hd__or2 |
| or2b | 2-input OR, first input inverted. | cell | sky130_fd_sc_hd__or2b |
| or3 | 3-input OR. | cell | sky130_fd_sc_hd__or3 |
| or3b | 3-input OR, first input inverted. | cell | sky130_fd_sc_hd__or3b |
| or4 | 4-input OR. | cell | sky130_fd_sc_hd__or4 |
| or4b | 4-input OR, first input inverted. | cell | sky130_fd_sc_hd__or4b |
| or4bb | 4-input OR, first two inputs inverted. | cell | sky130_fd_sc_hd__or4bb |
| probe_p | Virtual voltage probe point. | cell | sky130_fd_sc_hd__probe_p |
| probec_p | Virtual current probe point. | cell | sky130_fd_sc_hd__probec_p |
| sdfbbn | Scan D flip-flop, inverted set, inverted reset, inverted clock, complementary outputs. | cell | sky130_fd_sc_hd__sdfbbn |
| sdfbbp | Scan D flip-flop, inverted set, inverted reset, non-inverted clock, complementary outputs. | cell | sky130_fd_sc_hd__sdfbbp |
| sdfrbp | Scan D flip-flop, inverted reset, non-inverted clock, complementary outputs. | cell | sky130_fd_sc_hd__sdfrbp |
| sdfrtn | Scan D flip-flop, inverted reset, inverted clock, single output. | cell | sky130_fd_sc_hd__sdfrtn |
| sdfrtp | Scan D flip-flop, inverted reset, non-inverted clock, single output. | cell | sky130_fd_sc_hd__sdfrtp |
| sdfsbp | Scan D flip-flop, inverted set, non-inverted clock, complementary outputs. | cell | sky130_fd_sc_hd__sdfsbp |
| sdfstp | Scan D flip-flop, inverted set, non-inverted clock, single output. | cell | sky130_fd_sc_hd__sdfstp |
| sdfxbp | Scan D flip-flop, non-inverted clock, complementary outputs. | cell | sky130_fd_sc_hd__sdfxbp |
| sdfxtp | Scan D flip-flop, non-inverted clock, single output. | cell | sky130_fd_sc_hd__sdfxtp |
| sdlclkp | Scan gated clock. | cell | sky130_fd_sc_hd__sdlclkp |
| sedfxbp | Scan D flip-flop, data enable, non-inverted clock, complementary outputs. | cell | sky130_fd_sc_hd__sedfxbp |
| sedfxtp | Scan D flip-flop, data enable, non-inverted clock, single output. | cell | sky130_fd_sc_hd__sedfxtp |
| tap | Tap cell with no tap connections (no contacts on metal1). | cell | sky130_fd_sc_hd__tap |
| tapvgnd | Tap cell with tap to ground, isolated power connection 1 row down. | cell | sky130_fd_sc_hd__tapvgnd |
| tapvgnd2 | Tap cell with tap to ground, isolated power connection 2 rows down. | cell | sky130_fd_sc_hd__tapvgnd2 |
| tapvpwrvgnd | Substrate and well tap cell. | cell | sky130_fd_sc_hd__tapvpwrvgnd |
| xnor2 | 2-input exclusive NOR. | cell | sky130_fd_sc_hd__xnor2 |
| xnor3 | 3-input exclusive NOR. | cell | sky130_fd_sc_hd__xnor3 |
| xor2 | 2-input exclusive OR. | cell | sky130_fd_sc_hd__xor2 |
| xor3 | 3-input exclusive OR. | cell | sky130_fd_sc_hd__xor3 |
