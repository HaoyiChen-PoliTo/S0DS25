# Write a Tcl script that reads the assignment of this exercise 
# (or any other arbitrary text) from a previously created file 
# (e.g., exercise.txt). The script should be able to:
#
#    1.  Report the count of characters and lines of the text 
#        contained in the file
#    2.  Create a new variable where the original text is modified as 
#        to include the word "program" instead of the word "script"; then, 
#        print the obtained result to a new file (refer to the functions replace or lreplace).

set file [open "5_exercise.txt" "r"]
set content [read $file]
close $file

set char_count [string length $content]
set line_count [llength [split $content "\n"]]

puts "characcters: $char_count, lines: $line_count"

set modified_content [string map {"script" "program"} $content]
set new_file [open "5_modified.txt" "w"]
puts $new_file $modified_content
close $new_file