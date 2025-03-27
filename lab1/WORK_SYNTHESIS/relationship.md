

synthesis.tcl
├── External Files
│   ├── synopsys_dc.setup (Loads library configuration)
│   ├── HDL source files (./rtl/${blockName}/verilog/*.v*)
│   └── SDC constraint file (./rtl/${blockName}/sdc/${blockName}.sdc)
├── Directory and Intermediate File Creation
│   ├── ./saved/${blockName}/synthesis/
│   └── ./saved/${blockName}/synthesis/synlib/
├── Synthesis Tool Commands
│   ├── analyze and elaborate (Analyze and elaborate the design)
│   ├── link and compile (Link and synthesize the design)
│   └── report_* (Generate reports)
└── Output Files
    ├── Synthesized netlist (${dirname}/${blockName}_postsyn.v)
    ├── Synthesized constraint file (${dirname}/${blockName}_postsyn.sdc)
    └── Report files (area, timing, power)