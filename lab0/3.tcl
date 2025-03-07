# Write a TCL program to:
#   1. create a new list variable containing the numbers from 0 to 10 (using the lappend command)
#   2. displays the content of the list, one item per line (using the foreach command)
#   3. calculate the sum of the 5th and 10th element in the list and append the result at the end of the list itself
#   4. displays on the screen the last item of the list


lappend x 1 2 3 4 5 6 7 8 9 10
foreach var $x {
    puts "$var"
}
lappend x [expr {[lindex $x 4]+[lindex $x 9]} ]
puts "[lindex $x 10]"