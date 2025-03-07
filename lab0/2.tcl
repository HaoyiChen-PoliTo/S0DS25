# This TCL program determines whether the quadratic equation (ax^2 + bx + c = 0) 
# has real solutions, and if so, prints the results on the screen.
#
# 1. Define three variables (a, b, and c) for the equation coefficients,
#    and two variables (x1 and x2) to store the solutions.
# 2. Set values for a, b, and c.
# 3. Calculate the discriminant (delta) to determine the nature of the solutions.
#    3.3.1. If delta is positive, use the sqrt function to compute the roots.
#    3.3.2. Otherwise, display a message indicating no real solutions exist.



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