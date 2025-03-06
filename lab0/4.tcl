set seasons {spring summer autumn winter}
foreach season $seasons {
    puts "$season"
}
set position [lsearch $seasons "spring"]
puts "spring in the position of $position"