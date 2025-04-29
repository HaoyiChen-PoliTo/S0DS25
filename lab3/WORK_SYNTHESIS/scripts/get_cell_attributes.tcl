proc get_cell_attributes {cellName} {
    # check if the cell name is provided
    set cell_obj [get_cells $cellName]
    if {[llength $cell_obj] == 0} {
        puts "Cell $cellName not found in the design."
        return
    }
    set full_name [get_attribute $cell_obj full_name]
    set ref_name [get_attribute $cell_obj ref_name]
    set area [get_attribute $cell_obj area]

    #get the size of the cell using regexp
    if {[regexp {X(\d+)} $ref_name match size]} {
    } else {
        set size "N/A"
    }

    set leakage_power [get_attribute $cell_obj leakage_power]
    set dynamic_power [get_attribute $cell_obj dynamic_power]
    set total_power [expr $leakage_power + $dynamic_power]

    #get the max arrival time
    set output_pins [filter_collection [get_pins -of_objects $cell_obj] "direction == out"]
    set max_arrival_time 0
    foreach pin $output_pins {
        set rise_arrival [get_attribute $pin max_rise_arrival]
        set fall_arrival [get_attribute $pin max_fall_arrival]
        set arrival_time [expr max($rise_arrival, $fall_arrival)]
        if {$arrival_time > $max_arrival_time} {
            set max_arrival_time $arrival_time
        }
    }

    #get the max slack
    # use -slack_lesser_than 1000, because defaultly it only shows negative slack
    set paths [get_timing_paths -through $cell_obj -max_paths 100 -slack_lesser_than 1000]

    if {[llength $paths] == 0} {
        set max_slack "N/A"
    } else {
        set max_slack 1e6
        foreach_in_collection path $paths {
            set path_slack [get_attribute $path slack]
            if {$path_slack < $max_slack} {
                set max_slack $path_slack
            }
        }
    }

    #output the result
    puts "Full Name        : $full_name"
    puts "Reference Name   : $ref_name"
    puts "Area             : $area"
    puts "Size             : $size"
    puts "Leakage Power    : $leakage_power"
    puts "Dynamic Power    : $dynamic_power"
    puts "Total Power      : $total_power"
    puts "Max Arrival Time : $max_arrival_time"
    puts "Max Slack        : $max_slack"
    return
}