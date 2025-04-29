proc get_info_cells {cell_type} {
    # Build the filter expression
    set filter_str "is_${cell_type} == true"

    # Get the filtered cells
    set cells [get_cells -filter $filter_str]

    # Initialize totals
    set total_area 0.0
    set total_leakage 0.0
    set total_dynamic 0.0

    # Accumulate attribute values
    foreach_in_collection cell $cells {
        set area    [get_attribute $cell area]
        set leakage [get_attribute $cell leakage_power]
        set dynamic [get_attribute $cell dynamic_power]

        set total_area    [expr $total_area + $area]
        set total_leakage [expr $total_leakage + $leakage]
        set total_dynamic [expr $total_dynamic + $dynamic]
    }

    # Output the result
    puts "========== Cell Type: $cell_type =========="
    puts "Total area           : $total_area"
    puts "Total leakage power  : $total_leakage"
    puts "Total dynamic power  : $total_dynamic"
}