
# Getting info of env variables
if { [info exists ::env(V_IP_TOP) ] } {
	set ip_top $::env(V_IP_TOP)
} else {
	puts "No IP Top specified in env variable V_IP_TOP"
	exit
	#set ip_top cxs_bridge_hn_top
}


if { [info exists ::env(V_IP_FILELIST) ] } {
	set rtl_flist $::env(V_IP_FILELIST)
} else {
	puts "No Filelist Specified in env variable V_IP_FILELIST"
	exit
}


if { [info exists ::env(V_RTL_DIR) ] } {
	set rtl_dir $::env(V_RTL_DIR)
} else {
	puts "No Directory pecified in env variable V_RTL_DIR"
	exit
}

if { [info exists ::env(V_BRIDGE_TYPE) ] } {
	set bridge_type $::env(V_BRIDGE_TYPE)
} else {
	puts "No Bridge type specified in env variable V_BRIDGE_TYPE"
	exit
}


set rtl_dir [exec python -c "import os.path; print os.path.relpath('$rtl_dir','./')"]

puts "RTL Dir is"
puts $rtl_dir 

puts "RTL Filelist is"
puts $rtl_flist

set ip_name ${ip_top}_v1_0

proc set_global_properties {ip_name} {
  set_property display_name $ip_name $::core

  set_property description {CXS Bridge} $::core

  set_property taxonomy {{/Embedded Processing/Debug & Verification/Debug}} $::core

  set families { \
    aartix7   Production     \
    artix7    Production     \
    artix7l   Production     \
    azynq     Production     \
    kintex7   Production     \
    kintex7l  Production     \
    kintexu   Pre-Production \
    qartix7   Production     \
    qkintex7  Production     \
    qkintex7l Production     \
    qvirtex7  Production     \
    qzynq     Production     \
    virtex7   Production     \
    virtexu   Production \
    virtexuplus   Production \
    virtexuplusHBM   Production \
    zynq      Production     \
    zynquplus Production }

  set_property supported_families $families $::core
}


proc add_port_map_cxs {logical_name physical_name busif_name enablement} {
set bus_interface [::ipx::get_bus_interfaces -of_objects $::core $busif_name]
::ipx::add_port_map $logical_name $bus_interface
set_property PHYSICAL_NAME $physical_name [::ipx::get_port_maps -of_objects $bus_interface $logical_name]

#set_property enablement_dependency {} [ipx::get_ports $physical_name -of_objects [ipx::current_core]]
}
proc add_port_map_axi {logical_name physical_name busif_name enablement} {
  set bus_interface [::ipx::get_bus_interfaces -of_objects $::core $busif_name]
  ::ipx::add_port_map $logical_name $bus_interface
  set_property PHYSICAL_NAME $physical_name [::ipx::get_port_maps -of_objects $bus_interface $logical_name]
  if {$enablement == "AXI4"} {
    set_property enablement_dependency {$AXI_PROTOCOL == "AXI4"} [ipx::get_ports $physical_name -of_objects [ipx::current_core]]  
  } elseif {$enablement == "AXI4LITE"} {
    set_property enablement_dependency {$AXI_PROTOCOL == "AXI4LITE"} [ipx::get_ports $physical_name -of_objects [ipx::current_core]]  
  } elseif {$enablement == "AXI3"} {
    set_property enablement_dependency {$AXI_PROTOCOL == "AXI3"} [ipx::get_ports $physical_name -of_objects [ipx::current_core]]  
  } elseif {$enablement == "AXI4_OR_AXI3"} {
    set_property enablement_dependency {$AXI_PROTOCOL == "AXI4" || $AXI_PROTOCOL == "AXI3"} [ipx::get_ports $physical_name -of_objects [ipx::current_core]]  
  } else {
  }
     
}



proc add_bus_param {busif_name name value {value_format long} {type immediate} {dependency ""}} {
  set current_bus_parameter [::ipx::add_bus_parameter $name [::ipx::get_bus_interfaces -of_objects $::core $busif_name]]
  set_property value $value $current_bus_parameter
  set_property value_format $value_format $current_bus_parameter
  set_property value_resolve_type $type $current_bus_parameter
  if {$dependency != ""} {
    set_property value_dependency $dependency $current_bus_parameter
  }
}

proc add_param {name value {display_name ""} {dependency ""} {format LONG} {length 32}} {
  ::ipx::add_user_parameter $name $::core
  if {$format == "LONG"} {
    set_property data_type integer [::ipx::get_hdl_parameters -of_objects $::core $name]
  }
  if {$format == "BITSTRING"} {
    set_property data_type std_logic_vector [::ipx::get_hdl_parameters -of_objects $::core $name]
  }
  if {$format == "BOOL"} {
    set_property data_type integer [::ipx::get_hdl_parameters -of_objects $::core $name]
    set_property value_validation_list {false:0 true:1} [::ipx::get_hdl_parameters -of_objects $::core $name]
    set_property value_validation_list {false:0 true:1} [::ipx::get_user_parameters -of_objects $::core $name]
    set_property value_format LONG [::ipx::get_hdl_parameters -of_objects $::core $name]
    set_property value_format LONG [::ipx::get_user_parameters -of_objects $::core $name]
  } else {
    set_property value_format $format [::ipx::get_hdl_parameters -of_objects $::core $name]
    set_property value_format $format [::ipx::get_user_parameters -of_objects $::core $name]
  }
  set_property value $value [::ipx::get_hdl_parameters -of_objects $::core $name]
  set_property value $value [::ipx::get_user_parameters -of_objects $::core $name]
  if {$display_name != ""} {
    set_property display_name $display_name [::ipx::get_hdl_parameters -of_objects $::core $name]
    set_property display_name $display_name [::ipx::get_user_parameters -of_objects $::core $name]
  }
  if {$format == "BITSTRING"} {
    set_property value_bit_string_length $length [::ipx::get_hdl_parameters -of_objects $::core $name]
    set_property value_bit_string_length $length [::ipx::get_user_parameters -of_objects $::core $name]
  }
  set_property value_resolve_type generated [::ipx::get_hdl_parameters -of_objects $::core $name]
  set_property value_resolve_type user [::ipx::get_user_parameters -of_objects $::core $name]
  if {$dependency != ""} {
    set_property enablement_presence optional [::ipx::get_hdl_parameters -of_objects $::core $name]
    set_property enablement_value true [::ipx::get_hdl_parameters -of_objects $::core $name]
    set_property enablement_resolve_type "dependent" [::ipx::get_hdl_parameters -of_objects $::core $name]
    set_property enablement_dependency $dependency [::ipx::get_hdl_parameters -of_objects $::core $name]
  }
}

proc add_user_param {name value {display_name ""} {format LONG} {length 32}} {
  ::ipx::add_user_parameter $name $::core
  if {$format == "BOOL"} {
    set_property value_validation_list {false:0 true:1} [::ipx::get_user_parameters -of_objects $::core $name]
    set_property value_format LONG [::ipx::get_user_parameters -of_objects $::core $name]
  } else {
    set_property value_format $format [::ipx::get_user_parameters -of_objects $::core $name]
  }
  set_property value $value [::ipx::get_user_parameters -of_objects $::core $name]
  if {$display_name != ""} {
    set_property display_name $display_name [::ipx::get_user_parameters -of_objects $::core $name]
  }
  if {$format == "BITSTRING"} {
    set_property value_bit_string_length $length [::ipx::get_user_parameters -of_objects $::core $name]
  }
  set_property value_resolve_type user [::ipx::get_user_parameters -of_objects $::core $name]
}


set ::core [::ipx::create_core xilinx.com ip $ip_top 1.00]
set_property root_directory {.} $::core



# Source files
 foreach fg {xilinx_vivadoverilogsynthesis xilinx_vivadoverilogbehavioralsimulation} {
  set current_filegroup [::ipx::add_file_group $fg $::core]
  set_property library_name $ip_top [::ipx::add_file ${rtl_dir}/${ip_top}.v $current_filegroup]
  set_property library_name $ip_top [::ipx::add_file ${rtl_dir}/../common/include/cxs_defines_regspace.vh $current_filegroup]
  set_property model_name $ip_top $current_filegroup
 }


set_global_properties $ip_name

# Customization Parameters
 ::ipx::remove_all_hdl_parameter $::core
 ::ipx::add_model_parameters_from_hdl -top_level_hdl_file ${rtl_dir}/${ip_top}.v -top_module_name $ip_top $::core




add_param LAST_BRIDGE                   0      "Last bridge in design  "    ""  LONG  
add_param USR_RST_NUM                   4       "Number of User Reset"          ""  LONG  
add_param CXS_DATA_FLIT_WIDTH          256    "CXS DATA FLIT WIDTH      "  ""  LONG 
add_param CXS_CNTL_WIDTH        14  "CXS CNTL WIDTH    "  ""  LONG
add_param CXS_DATACHECK             0    "CXS DATACHECK         "  ""  LONG
add_param CXS_REPLICATION           0    "CXS REPLICATION       "  ""  LONG


set_property value_validation_list {0:0 1:1} [::ipx::get_hdl_parameters -of_objects  $::core LAST_BRIDGE]
set_property value_validation_list {1:1 2:2 3:3 4:4} [::ipx::get_hdl_parameters -of_objects  $::core USR_RST_NUM]
set_property value_validation_list {1024:1024 512:512 256:256} [::ipx::get_hdl_parameters -of_objects  $::core CXS_DATA_FLIT_WIDTH]
set_property value_validation_list {14:14 18:18 22:22 27:27 33:33 36:36 44:44} [::ipx::get_hdl_parameters -of_objects  $::core CXS_CNTL_WIDTH]
set_property value_validation_list {0:0 1:1} [::ipx::get_hdl_parameters -of_objects  $::core CXS_DATACHECK ]
set_property value_validation_list {0:0 1:1} [::ipx::get_hdl_parameters -of_objects  $::core CXS_REPLICATION ]

set_property value_validation_list {0:0 1:1} [::ipx::get_user_parameters -of_objects  $::core LAST_BRIDGE]
set_property value_validation_list {1:1 2:2 3:3 4:4} [::ipx::get_user_parameters -of_objects  $::core USR_RST_NUM]
set_property value_validation_list {1024:1024 512:512 256:256} [::ipx::get_user_parameters -of_objects  $::core CXS_DATA_FLIT_WIDTH]
set_property value_validation_list {14:14 36:36 44:44} [::ipx::get_user_parameters -of_objects  $::core CXS_CNTL_WIDTH]
set_property value_validation_list {0:0 1:1} [::ipx::get_user_parameters -of_objects  $::core CXS_DATACHECK ]
set_property value_validation_list {0:0 1:1} [::ipx::get_user_parameters -of_objects  $::core CXS_REPLICATION ]

ipx::create_xgui_files [ipx::current_core]

ipgui::add_param -name {LAST_BRIDGE} -component [ipx::current_core] -show_label {true} -show_range {true} -widget {}
ipgui::add_param -name {USR_RST_NUM} -component [ipx::current_core] -show_label {true} -show_range {true} -widget {}
ipgui::add_param -name {CXS_DATA_FLIT_WIDTH} -component [ipx::current_core] -show_label {true} -show_range {true} -widget {}
ipgui::add_param -name {CXS_CNTL_WIDTH} -component [ipx::current_core] -show_label {true} -show_range {true} -widget {}
ipgui::add_param -name {CXS_DATACHECK} -component [ipx::current_core] -show_label {true} -show_range {true} -widget {}
ipgui::add_param -name {CXS_REPLICATION} -component [ipx::current_core] -show_label {true} -show_range {true} -widget {}

# Combobox
set_property widget {comboBox} [ipgui::get_guiparamspec -name "LAST_BRIDGE" -component [ipx::current_core] ]
set_property widget {comboBox} [ipgui::get_guiparamspec -name "USR_RST_NUM" -component [ipx::current_core] ]
set_property widget {comboBox} [ipgui::get_guiparamspec -name "CXS_DATA_FLIT_WIDTH" -component [ipx::current_core] ]
set_property widget {comboBox} [ipgui::get_guiparamspec -name "CXS_CNTL_WIDTH" -component [ipx::current_core] ]
set_property widget {comboBox} [ipgui::get_guiparamspec -name "CXS_DATACHECK" -component [ipx::current_core] ]
set_property widget {comboBox} [ipgui::get_guiparamspec -name "CXS_REPLICATION" -component [ipx::current_core] ]


ipx::create_xgui_files [ipx::current_core]



# Ports
 ::ipx::remove_all_port $::core
 ::ipx::add_ports_from_hdl -top_level_hdl_file ${rtl_dir}/${ip_top}.v -top_module_name $ip_top $::core


### CLOCK AND RESET

::ipx::add_bus_interface CLK.ACLK $::core
set_property bus_type_vlnv xilinx.com:signal:clock:1.0 [::ipx::get_bus_interfaces -of_objects $::core CLK.ACLK]
set_property abstraction_type_vlnv xilinx.com:signal:clock_rtl:1.0 [::ipx::get_bus_interfaces -of_objects $::core CLK.ACLK]
set_property interface_mode slave [::ipx::get_bus_interfaces -of_objects $::core CLK.ACLK]
set_property display_name axi_aclk [::ipx::get_bus_interfaces -of_objects $::core CLK.ACLK]
set_property description {Clock input} [::ipx::get_bus_interfaces -of_objects $::core CLK.ACLK]
::ipx::add_port_map CLK [::ipx::get_bus_interfaces -of_objects $::core CLK.ACLK]
set_property PHYSICAL_NAME clk [::ipx::get_port_maps -of_objects [::ipx::get_bus_interfaces -of_objects $::core CLK.ACLK] CLK]


::ipx::add_bus_interface RST.ARESETN $::core
set_property bus_type_vlnv xilinx.com:signal:reset:1.0 [::ipx::get_bus_interfaces -of_objects $::core RST.ARESETN]
set_property abstraction_type_vlnv xilinx.com:signal:reset_rtl:1.0 [::ipx::get_bus_interfaces -of_objects $::core RST.ARESETN]
set_property interface_mode slave [::ipx::get_bus_interfaces -of_objects $::core RST.ARESETN]
set_property display_name axi_aresetn [::ipx::get_bus_interfaces -of_objects $::core RST.ARESETN]
set_property description {Reset} [::ipx::get_bus_interfaces -of_objects $::core RST.ARESETN]
add_bus_param RST.ARESETN POLARITY ACTIVE_LOW string dependent
::ipx::add_port_map RST [::ipx::get_bus_interfaces -of_objects $::core RST.ARESETN]
set_property PHYSICAL_NAME resetn [::ipx::get_port_maps -of_objects [::ipx::get_bus_interfaces -of_objects $::core RST.ARESETN] RST]


add_bus_param CLK.ACLK ASSOCIATED_BUSIF "S_AXI:cxs_t:cxs_r" string
set cxs_intfc_t "cxs_t"
set cxs_intfc_r "cxs_r"
add_bus_param CLK.ACLK ASSOCIATED_RESET resetn string


### SAXI Interface
::ipx::add_bus_interface S_AXI $::core
set_property bus_type_vlnv xilinx.com:interface:aximm:1.0 [::ipx::get_bus_interfaces -of_objects $::core S_AXI]
set_property abstraction_type_vlnv xilinx.com:interface:aximm_rtl:1.0 [::ipx::get_bus_interfaces -of_objects $::core S_AXI]
set_property interface_mode slave [::ipx::get_bus_interfaces -of_objects $::core S_AXI]
set_property display_name S_AXI [::ipx::get_bus_interfaces -of_objects $::core S_AXI]
set_property description {Slave AXI4 Interface} [::ipx::get_bus_interfaces -of_objects $::core S_AXI]



add_port_map_axi AWADDR    s_axi_awaddr    S_AXI 1
add_port_map_axi AWPROT    s_axi_awprot    S_AXI 1
add_port_map_axi AWVALID   s_axi_awvalid   S_AXI 1
add_port_map_axi AWREADY   s_axi_awready   S_AXI 1
add_port_map_axi WDATA     s_axi_wdata     S_AXI 1
add_port_map_axi WSTRB     s_axi_wstrb     S_AXI 1
add_port_map_axi WVALID    s_axi_wvalid    S_AXI 1
add_port_map_axi WREADY    s_axi_wready    S_AXI 1
add_port_map_axi BRESP     s_axi_bresp     S_AXI 1
add_port_map_axi BVALID    s_axi_bvalid    S_AXI 1
add_port_map_axi BREADY    s_axi_bready    S_AXI 1
add_port_map_axi ARADDR    s_axi_araddr    S_AXI 1
add_port_map_axi ARPROT    s_axi_arprot    S_AXI 1
add_port_map_axi ARVALID   s_axi_arvalid   S_AXI 1
add_port_map_axi ARREADY   s_axi_arready   S_AXI 1
add_port_map_axi RDATA     s_axi_rdata     S_AXI 1
add_port_map_axi RRESP     s_axi_rresp     S_AXI 1
add_port_map_axi RVALID    s_axi_rvalid    S_AXI 1
add_port_map_axi RREADY    s_axi_rready    S_AXI 1

# Mem Map

set slaveifs {S_AXI}
foreach slaveif $slaveifs {
  set current_memory_map [::ipx::add_memory_map $slaveif $::core]
  set_property description "$slaveif memory map" $current_memory_map
  set current_address_block [::ipx::add_address_block Mem $current_memory_map]
  set_property width {32} $current_address_block
  set_property access {read-write} $current_address_block
  set_property usage {memory} $current_address_block
  set_property base_address {0} $current_address_block
  set_property base_address_format {long} $current_address_block
  set_property range {4294967296} $current_address_block
  set_property range_format {long} $current_address_block
  set_property slave_memory_map_ref $slaveif [::ipx::get_bus_interfaces -of_objects $::core $slaveif]
}



ipx::add_bus_interface $cxs_intfc_t [ipx::current_core]
set_property abstraction_type_vlnv xilinx.com:interface:cxs_rtl:1.0 [ipx::get_bus_interfaces $cxs_intfc_t -of_objects [ipx::current_core]]
set_property bus_type_vlnv xilinx.com:interface:cxs:1.0 [ipx::get_bus_interfaces $cxs_intfc_t -of_objects [ipx::current_core]]

ipx::add_bus_interface $cxs_intfc_r [ipx::current_core]
set_property abstraction_type_vlnv xilinx.com:interface:cxs_rtl:1.0 [ipx::get_bus_interfaces $cxs_intfc_r -of_objects [ipx::current_core]]
set_property bus_type_vlnv xilinx.com:interface:cxs:1.0 [ipx::get_bus_interfaces $cxs_intfc_r -of_objects [ipx::current_core]]

set_property interface_mode slave [ipx::get_bus_interfaces $cxs_intfc_r -of_objects [ipx::current_core]]
set_property interface_mode master [ipx::get_bus_interfaces $cxs_intfc_t -of_objects [ipx::current_core]]

add_port_map_cxs ACTIVE_REQ     CXS_ACTIVE_REQ_TX	$cxs_intfc_t 1
add_port_map_cxs CRDGNT         CXS_CRDGNT_TX           $cxs_intfc_t 1
add_port_map_cxs DEACT_HINT     CXS_DEACT_HINT_TX       $cxs_intfc_t 1
add_port_map_cxs ACTIVE_ACK     CXS_ACTIVE_ACK_TX       $cxs_intfc_t 1
add_port_map_cxs VALID          CXS_VALID_TX            $cxs_intfc_t 1
add_port_map_cxs CRDGNT_CHK     CXS_CRDGNT_CHK_TX       $cxs_intfc_t 1
add_port_map_cxs DATA_CHK       CXS_DATA_CHK_TX         $cxs_intfc_t 1
add_port_map_cxs CNTL_CHK       CXS_CNTL_CHK_TX         $cxs_intfc_t 1
add_port_map_cxs CRDRTN         CXS_CRDRTN_TX           $cxs_intfc_t 1
add_port_map_cxs DATA           CXS_DATA_TX             $cxs_intfc_t 1
add_port_map_cxs CNTL           CXS_CNTL_TX             $cxs_intfc_t 1
add_port_map_cxs VALID_CHK      CXS_VALID_CHK_TX        $cxs_intfc_t 1
add_port_map_cxs CRDRTN_CHK     CXS_CRDRTN_CHK_TX       $cxs_intfc_t 1


add_port_map_cxs ACTIVE_REQ	CXS_ACTIVE_REQ_RX	$cxs_intfc_r 1
add_port_map_cxs CRDGNT         CXS_CRDGNT_RX           $cxs_intfc_r 1
add_port_map_cxs DEACT_HINT     CXS_DEACT_HINT_RX       $cxs_intfc_r 1
add_port_map_cxs ACTIVE_ACK     CXS_ACTIVE_ACK_RX       $cxs_intfc_r 1
add_port_map_cxs VALID          CXS_VALID_RX            $cxs_intfc_r 1
add_port_map_cxs CRDGNT_CHK     CXS_CRDGNT_CHK_RX       $cxs_intfc_r 1
add_port_map_cxs DATA_CHK       CXS_DATA_CHK_RX         $cxs_intfc_r 1
add_port_map_cxs CNTL_CHK       CXS_CNTL_CHK_RX         $cxs_intfc_r 1
add_port_map_cxs CRDRTN         CXS_CRDRTN_RX           $cxs_intfc_r 1
add_port_map_cxs DATA           CXS_DATA_RX             $cxs_intfc_r 1
add_port_map_cxs CNTL           CXS_CNTL_RX             $cxs_intfc_r 1
add_port_map_cxs VALID_CHK      CXS_VALID_CHK_RX        $cxs_intfc_r 1
add_port_map_cxs CRDRTN_CHK     CXS_CRDRTN_CHK_RX       $cxs_intfc_r 1


::ipx::save_core $::core


foreach fg {xilinx_vivadoverilogsynthesis xilinx_vivadoverilogbehavioralsimulation} {

set current_filegroup [::ipx::add_file_group $fg $::core]
	foreach n [split $rtl_flist " "] {
		puts $n
		# From Makefile we will get absolute path OR Relative but not relative to
		# This directory. So make it relative.
		set n [exec python -c "import os.path; print os.path.relpath('$n','./')"]
		set_property library_name $ip_top [::ipx::add_file $n $current_filegroup]
	}
		set_property model_name $ip_top $current_filegroup
	}

#foreach fg {xilinx_vivadoverilogsynthesis xilinx_vivadoverilogbehavioralsimulation} {
#	set current_filegroup [::ipx::add_file_group $fg $::core]
#	set_property file_type {Verilog Header} [::ipx::get_files *.vh $current_filegroup]
#}

ipx::create_xgui_files [ipx::current_core]
ipx::update_checksums [ipx::current_core]
::ipx::save_core $::core

exit

