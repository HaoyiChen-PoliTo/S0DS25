proc slack_histogram {leftEdge rightEdge} {
    set window [expr {$rightEdge - $leftEdge}]
    set bin_width [expr {$window / 10.0}]
    set histogram_list [list 0 0 0 0 0 0 0 0 0 0]

    set cells [get_cells *]

    foreach_in_collection cell $cells {
        set output_pins [filter_collection [get_pins -of_objects $cell] "direction == out"]

        foreach_in_collection pin $output_pins {
            set rise_slack [get_attribute $pin max_rise_slack]
            set fall_slack [get_attribute $pin max_fall_slack]
            set pin_slack [expr {max($rise_slack, $fall_slack)}]

            if { $pin_slack >= $leftEdge && $pin_slack <= $rightEdge } {
                set bin_index [expr {int( ($pin_slack - $leftEdge) / $bin_width )}]
                if {$bin_index >= 10} {
                    set bin_index 9
                }
                set current_count [lindex $histogram_list $bin_index]
                lset histogram_list $bin_index [expr {$current_count + 1}]
            }
        }
    }
    return $histogram_list
}