set a 2
set b 5
set c 3
set x1 0
set x2 0

set delta [expr {$b*$b-4*$a*$c}]

if {$delta>0} {
    set x1 [expr {(-$b + sqrt($delta)) / (2.0 * $a)}]
    set x2 [expr {(-$b - sqrt($delta)) / (2.0 * $a)}]
    puts "Two real solution, x1=$x1, x2=$x2"
} elseif {$delta==0} {
    set x1 [expr {-$b +  / (2.0 * $a)}]
    puts "One real solution, x=$x1"
} else {
    puts "No real solution"
}