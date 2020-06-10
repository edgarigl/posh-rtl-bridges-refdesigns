# VIVADO IPI Project Launch Script
set proj_name u250_ep_posh_cxs 
set top_file u250_ep_posh_cxs_wrapper
set design_top u250_ep_posh_cxs 
set device xcu250-figd2104-2L-e 
set runs_dir runs_build

set proj_dir ./../${runs_dir}/u250_ep_posh_cxs
set local_ip {../../../cxs/pcore }

create_project $proj_name -dir $proj_dir -part $device
set_property BOARD_PART xilinx.com:au250:part0:1.0 [current_project]


# Project Settings
# Adding the Constraints file
set_property ip_repo_paths ${local_ip} [current_fileset]
update_ip_catalog

# BD for design
source u250_ep_posh_cxs.tcl

regenerate_bd_layout
save_bd_design
validate_bd_design
save_bd_design

make_wrapper -files [get_files ${proj_dir}/${proj_name}.srcs/sources_1/bd/${design_top}/${design_top}.bd] -top
add_files -force -norecurse ${proj_dir}/${proj_name}.srcs/sources_1/bd/${design_top}/hdl/${design_top}_wrapper.v
add_files -fileset constrs_1 -norecurse ../xdc/${design_top}.xdc
#add_files -force -norecurse ../wrapper/tb.v
#set_property top tb [get_fileset sim_1]
set_property top ${design_top}_wrapper [get_fileset sources_1]
update_compile_order -fileset sources_1
update_compile_order -fileset sim_1


#Run in non-OOC mode
generate_target all [get_files  ${proj_dir}/${proj_name}.srcs/sources_1/bd/${design_top}/${design_top}.bd]

file mkdir ${proj_dir}/${proj_name}.sdk
write_hwdef -force  -file ../system.hdf

set_property synth_checkpoint_mode None [get_files *.bd]


launch_runs synth_1
wait_on_run synth_1
launch_runs impl_1 -to write_bitstream
wait_on_run impl_1
exit
