set verilog_file [lindex $argv 0]
set target_part  [lindex $argv 1]
set output_file  [lindex $argv 2]

create_project -force tmp tmp -part $target_part
add_files -norecurse $verilog_file
update_compile_order -fileset sources_1
set_property file_type SystemVerilog [get_files $verilog_file]
reset_run synth_1
launch_runs synth_1 -jobs 20
synth_design -rtl -rtl_skip_mlo -name rtl_1
write_schematic -orientation landscape -format pdf $output_file
