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