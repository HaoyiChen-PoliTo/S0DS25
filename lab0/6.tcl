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