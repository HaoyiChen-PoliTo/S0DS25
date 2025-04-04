##	+----------------------------------------------------------------
##	|		 Synthesis and Optimization of Digital Systems			|
##	|				Politecnico di Torino - TO - Italy				|
##	|						DAUIN - EDA GROUP						|
##	+----------------------------------------------------------------
##	|	author: andrea calimera										|
##	|	mail:	andrea.calimera@polito.it							|
##	|	title:	synthesis.tcl										|
##	+----------------------------------------------------------------
##	| 	Copyright 2015 DAUIN - EDA GROUP							|
##	+----------------------------------------------------------------

######################################################################
##
## SPECIFY LIBRARIES
##
######################################################################

# SOURCE SETUP FILE
source "./tech/STcmos65/synopsys_dc.setup"

# SUPPRESS WARNING MESSAGES
suppress_message MWLIBP-319
suppress_message MWLIBP-324
suppress_message TFCHK-012
suppress_message TFCHK-014
suppress_message TFCHK-049
suppress_message TFCHK-072
suppress_message TFCHK-084
suppress_message PSYN-651
suppress_message PSYN-650
suppress_message UID-401
suppress_message LINK-14
suppress_message TIM-134
suppress_message VER-130
suppress_message UISN-40
suppress_message VO-4
suppress_message RTDC-126

######################################################################
##
## READ DESIGN
##
######################################################################

# DEFINE CIRCUITS and WORK DIRS
set blockName "aes_cipher_top"
set active_design $blockName

# DEFINE WORK DIRS
set dirname "./saved/${blockName}"
if {![file exists $dirname]} {
	file mkdir $dirname
}
set dirname "./saved/${blockName}/synthesis"
if {![file exists $dirname]} {
	file mkdir $dirname
}
set libDir "./saved/${blockName}/synthesis/synlib"
file mkdir $libDir
define_design_lib $blockName -path $libDir

# ANALYZE HDL SOURCES
set HdlFileList [glob -dir "./rtl/${blockName}/verilog" "*.v*"]
foreach hdlFile $HdlFileList {
	if {[file extension $hdlFile]==".v"} {
		analyze -format verilog  -library $blockName $hdlFile
   } elseif {[file extension $hdlFile]==".vhd"} {
		analyze -format vhdl -library $blockName $hdlFile
    }
}

# ELABORATE DESIGN
elaborate -lib $blockName $blockName

######################################################################
##
## DEFINE DESIGN ENVIRONMENT
##
######################################################################
set_operating_condition -library  "${target_library}:CORE65LPSVT" wc_1.10V_125C
set_wire_load_model -library "${target_library}:CORE65LPSVT" -name area_12Kto18K [find design *]
set_load 0.05 [all_outputs]

######################################################################
##
## SET DESIGN CONSTRAINTS
##
######################################################################
source "./rtl/${blockName}/sdc/${blockName}.sdc"

######################################################################
##
## OPTIMIZE DESIGN
##
######################################################################
link
ungroup -all -flatten

compile

optimize_registers -clock $clockName -minimum_period_only
set_fix_hold $clockName
compile -incremental_mapping -map_effort high -ungroup_all
######################################################################
##
## SAVE DESIGN
##
######################################################################

write -format verilog -hierarchy -output "${dirname}/${blockName}_postsyn.v"
write_sdc -version 1.3 "${dirname}/${blockName}_postsyn.sdc"

######################################################################
##
## WRITE REPORTS
##
######################################################################

# SET REPORT FILE NAME
set area_rpt "${dirname}/${blockName}_postsyn_area.rpt"
set timing_rpt "${dirname}/${blockName}_postsyn_timing.rpt"
set power_rpt "${dirname}/${blockName}_postsyn_power.rpt"

# AREA REPORT
report_area > $area_rpt

# TIMING REPORT
report_timing > $timing_rpt

# POWER REPORT
report_power > $power_rpt

######################################################################
##
## CLEAN & EXIT
##
######################################################################

exec rm -rf $libDir
exit
