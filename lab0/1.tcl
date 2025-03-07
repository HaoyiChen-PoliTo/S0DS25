# This TCL program defines three variables: operand1, operand2, and result.
# 
#   1. Set the values of operand1 and operand2 using the "set" command.
#   2. Calculate the sum of operand1 and operand2, and store it in the variable "result".
#   3. Display the value of "result" on the screen using the "puts" function.

set operand1 5
set operand2 3
set values [expr {$operand1 + $operand2}]
puts $values