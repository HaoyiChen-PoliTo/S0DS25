#Write a TCL program to:
#
#    1. create a new list variable containing the name of the 4 seasons (one per item)
#    2. display the content of the list, one item per line
#    3. search in which position of the list is stored the item "spring"


set seasons {spring summer autumn winter}
foreach season $seasons {
    puts "$season"
}
set position [lsearch $seasons "spring"]
puts "spring in the position of $position"