set cell_list ""

foreach_in_collection cell [get_cell] {
    set cell_type [get_attribute $cell is_combinational]
    if($cell_type == true){
        set cell_name [get_attribute $cell full_name]
        set cell_ref [get_attribute $cell ref_name]
        set cell_leakage [get_attribute $cell leakage_power]
        lappend cell_list "$cell_name $cell_ref $cell_leakage"
    }
}
sorted_cell_list [lsort -index 2 -real $cell_list]
puts $sorted_cell_list

set sorted_cell_list [lsort -index 2 -real $cell_list]
set sorted_cell_name [lindex $sorted_cell_list 0]
set sorted_cell_ref [lindex $sorted_cell_list 1]
set sorted_cell_leakage [lindex $sorted_cell_list 2]