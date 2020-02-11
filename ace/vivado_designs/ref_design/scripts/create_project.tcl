# VIVADO IPI Project Launch Script
set proj_name ref_design 
set top_file ref_design_wrapper
set design_top ref_design 
set device xcu250-figd2104-2L-e 
set proj_dir ./../runs/ref_design
set local_ip {../../../master/pcore/ ../../../slave/pcore/}

create_project -force $proj_name -dir $proj_dir -part $device
set_property BOARD_PART xilinx.com:au250:part0:1.0 [current_project]

# Project Settings
set_property ip_repo_paths ${local_ip} [current_fileset]
update_ip_catalog

# BD for design
source ref_design.tcl

regenerate_bd_layout
save_bd_design

# validate block diagram
validate_bd_design

# save block diagram
save_bd_design

# block diagram wrapper
make_wrapper -files [get_files ${proj_dir}/${proj_name}.srcs/sources_1/bd/${design_top}/${design_top}.bd] -top
add_files -force -norecurse ${proj_dir}/${proj_name}.srcs/sources_1/bd/${design_top}/hdl/${design_top}_wrapper.v

set_property top ${design_top}_wrapper [get_fileset sources_1]
update_compile_order -fileset sources_1
update_compile_order -fileset sim_1

#xdc
file mkdir ${proj_dir}/${proj_name}.srcs/constrs_1
file mkdir ${proj_dir}/${proj_name}.srcs/constrs_1/new
exec cp -f ${proj_dir}/../../xdc/ref_design.xdc  ${proj_dir}/${proj_name}.srcs/constrs_1/new/ref_design.xdc
add_files -fileset constrs_1 ${proj_dir}/${proj_name}.srcs/constrs_1/new/ref_design.xdc


#Run in non-OOC mode
generate_target all [get_files  ${proj_dir}/${proj_name}.srcs/sources_1/bd/${design_top}/${design_top}.bd]

#file mkdir ${proj_dir}/${proj_name}.sdk
#write_hwdef -force  -file ../system.hdf

set_property synth_checkpoint_mode None [get_files *.bd]


launch_runs synth_1
wait_on_run synth_1
launch_runs impl_1 -to write_bitstream
wait_on_run impl_1
exit
