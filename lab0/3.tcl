lappend x 1 2 3 4 5 6 7 8 9 10
foreach var $x {
    puts "$var"
}
lappend x [expr {[lindex $x 4]+[lindex $x 9]} ]
puts "[lindex $x 10]"