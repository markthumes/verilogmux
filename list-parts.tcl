# part_lister.tcl
# Loop through all parts in the database and print them
foreach p [get_parts] {
    puts $p
}
