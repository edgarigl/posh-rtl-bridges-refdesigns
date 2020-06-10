set_false_path -through [get_pins -of [get_cells -hier -filter {name =~ *sync_?}] -filter {DIRECTION =~ IN && name =~ *data_in*}]
set_property BITSTREAM.GENERAL.COMPRESS {TRUE} [current_design ]
