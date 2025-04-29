set comb_cells [get_cells -filter "is_combinational==true"]
set sorted_cells [sort_collection $comb_cells leakage_power]

set sorted_list_name {get_attribute $sorted_cells full_name}
set sorted_list_leakage {get_attribute $sorted_cells leakage_power}

puts $sorted_list_name