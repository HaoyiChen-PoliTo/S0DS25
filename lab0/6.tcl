# This Tcl script prints a Sierpinski Triangle to the Tclsh terminal 
# using the '*' character, where the edge length is defined by the variable `edge_len`.

# The triangle's outer equilateral edges contain `edge_len` stars.
# 
# Advanced solution requirement:
# - Solve the problem using only **two loop statements**.
# - Utilize Tcl functions: `lset`, `lrepeat`, `lappend`, and `join` to construct the pattern efficiently.
set edge_len 32

for {set i 0} {$i < $edge_len} {incr i} {
    set row [lrepeat [expr {2 * $edge_len - 1}] " "]
    set start_j [expr {$edge_len - 1 - $i}]
    #set end_j [expr {$edge_len - 1 + $i}]
    for {set j 0} {$j <= $i} {incr j} {
        if {($j & ($i - $j)) == 0} {
            lset row [expr {$start_j + 2 * $j}] "*"
        }
    }
    puts [join $row ""]
}