proc custom_report_timing {} {
    set path [get_timing_path]
    set timing_point [get_attribute $path  points]

    set prev_arrival 0

    puts "Point Name\t\tArrival Time\tIncremental Delay"
    puts "-----------------------------------------------------"

    foreach_in_collection point $timing_point {
        set obj [get_attribute $point object]
        set name [get_attribute $obj full_name]
        set arrival [get_attribute $point arrival]
        set incr_delay [expr {$arrival - $prev_arrival}]
        puts "$name\t\t$arrival\t$incr_delay"
        set prev_arrival $arrival
    }
    
}