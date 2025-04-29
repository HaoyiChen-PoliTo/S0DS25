# Get all combinational cells from the design
set comb_cells [get_cells -filter "is_combinational==true"]

# Initialize total values
set chip_area 0.0
set chip_leakage 0.0
set chip_dynamic 0.0

# Initialize property lists
set cell_list_name {}
set cell_list_ref {}
set cell_list_area {}
set cell_list_leakage {}
set cell_list_dynamic {}

# Iterate through each combinational cell to collect data and compute totals
foreach_in_collection cell $comb_cells {
    # Extract attributes from the current cell
    set name [get_attribute $cell full_name]
    set ref [get_attribute $cell ref_name]
    set area [get_attribute $cell area]
    set leakage [get_attribute $cell leakage_power]
    set dynamic [get_attribute $cell dynamic_power]

    # Append attributes to respective lists
    lappend cell_list_name $name
    lappend cell_list_ref $ref
    lappend cell_list_area $area
    lappend cell_list_leakage $leakage
    lappend cell_list_dynamic $dynamic

    # Accumulate totals
    set chip_area [expr $chip_area + $area]
    set chip_leakage [expr $chip_leakage + $leakage]
    set chip_dynamic [expr $chip_dynamic + $dynamic]
}

# Sort the leakage power list in ascending order
set sorted_leakage [lsort -real $cell_list_leakage]

# Print total results
puts "Total chip area           : $chip_area"
puts "Total chip leakage power  : $chip_leakage"
puts "Total chip dynamic power  : $chip_dynamic"