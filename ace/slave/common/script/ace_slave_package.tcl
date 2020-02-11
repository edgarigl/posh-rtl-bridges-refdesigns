# 
# Copyright (c) 2019 Xilinx Inc.
# Written by Meera Bagdai.
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.
# 
# Description: 
#   tcl script to generate ip core.
# 


proc set_global_properties {} {
  set_property display_name {ace_slv_v1_00} $::core

  set_property description {POSH ACE-interconect Bridge} $::core

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

proc add_port_map_axi {logical_name physical_name busif_name enablement} {
  set bus_interface [::ipx::get_bus_interfaces -of_objects $::core $busif_name]
  ::ipx::add_port_map $logical_name $bus_interface
  set_property PHYSICAL_NAME $physical_name [::ipx::get_port_maps -of_objects $bus_interface $logical_name]
}


proc add_port_map_ace {logical_name physical_name busif_name enablement} {
  set bus_interface [::ipx::get_bus_interfaces -of_objects $::core $busif_name]
  ::ipx::add_port_map $logical_name $bus_interface
  set_property PHYSICAL_NAME $physical_name [::ipx::get_port_maps -of_objects $bus_interface $logical_name]
  if {$enablement == "FULLACE"} {
    set_property enablement_dependency {$ACE_PROTOCOL == "FULLACE"} [ipx::get_ports $physical_name -of_objects [ipx::current_core]]  
  } elseif {$enablement == "LITEACE"} {
    set_property enablement_dependency {$ACE_PROTOCOL == "LITEACE"} [ipx::get_ports $physical_name -of_objects [ipx::current_core]]  
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

# Create new Core
set ::core [::ipx::create_core xilinx.com ip ace_slv 1.00]
set_property root_directory {.} $::core

# Source files
foreach fg {xilinx_vivadoverilogsynthesis xilinx_vivadoverilogbehavioralsimulation} {
  set current_filegroup [::ipx::add_file_group $fg $::core]
  set_property library_name ace_slv [::ipx::add_file hdl/verilog/ace_slv.v $current_filegroup]
  set_property library_name ace_slv [::ipx::add_file hdl/verilog/ace_defines_common.vh $current_filegroup]
  set_property model_name ace_slv $current_filegroup
}

set_global_properties

# Customization Parameters
::ipx::remove_all_hdl_parameter $::core
::ipx::add_model_parameters_from_hdl -top_level_hdl_file hdl/verilog/ace_slv.v -top_module_name ace_slv $::core

add_param ACE_PROTOCOL                  FULLACE    "User Slave ACE Protocol"        ""  STRING  
add_param S_AXI_ADDR_WIDTH              32      "Slave AXI Addr-Width"          ""  LONG  
add_param S_AXI_DATA_WIDTH              32      "Slave AXI Data-Width"          ""  LONG  
add_param M_AXI_ADDR_WIDTH              64      "Master AXI Addr-Width"         ""  LONG  
add_param M_AXI_DATA_WIDTH              128     "Master AXI Data-Width"         ""  LONG  
add_param M_AXI_ID_WIDTH                4       "Master AXI ID-Width"           ""  LONG  
add_param M_AXI_USER_WIDTH              32      "Master AXI User-Width"         ""  LONG  
add_param S_ACE_USR_ADDR_WIDTH          64      "User Slave ACE Addr-Width"    ""  LONG  
add_param S_ACE_USR_DATA_WIDTH          128     "User Slave ACE Data-Width"    ""  LONG  
add_param S_ACE_USR_ID_WIDTH            16      "User Slave ACE ID-Width"      ""  LONG  
add_param S_ACE_USR_AWUSER_WIDTH        32      "User Slave ACE AWUser-Width"    ""  LONG  
add_param S_ACE_USR_WUSER_WIDTH         32      "User Slave ACE WUser-Width"    ""  LONG  
add_param S_ACE_USR_BUSER_WIDTH         32      "User Slave ACE BUser-Width"    ""  LONG  
add_param S_ACE_USR_ARUSER_WIDTH        32      "User Slave ACE ARUser-Width"    ""  LONG  
add_param S_ACE_USR_RUSER_WIDTH         32      "User Slave ACE Ruser-Width"    ""  LONG  
add_param RAM_SIZE                      16384   "RDATA,WDATA,WSTRB RAM Size (in Bytes)"                      ""  LONG  
add_param MAX_DESC                      16      "Maximum Number of Descripter"  ""  LONG  
add_param CACHE_LINE_SIZE               64      "Size of Cache line size (in Bytes)"    ""  LONG  
add_param LAST_BRIDGE                   0       "Last Bridge"    ""  LONG  
add_param USR_RST_NUM                   4       "Number of User Reset"          ""  LONG  

set_property value_validation_list {32:32 64:64} [::ipx::get_hdl_parameters -of_objects  $::core S_AXI_ADDR_WIDTH]
set_property value_validation_list {32:32} [::ipx::get_hdl_parameters -of_objects  $::core S_AXI_DATA_WIDTH]
set_property value_validation_list {32:32 64:64} [::ipx::get_hdl_parameters -of_objects  $::core M_AXI_ADDR_WIDTH]
set_property value_validation_list {32:32 64:64 128:128} [::ipx::get_hdl_parameters -of_objects  $::core S_ACE_USR_ADDR_WIDTH]
set_property value_validation_list {32:32 64:64 128:128} [::ipx::get_hdl_parameters -of_objects  $::core S_ACE_USR_ADDR_WIDTH]
set_property value_validation_list {32:32 64:64 128:128} [::ipx::get_hdl_parameters -of_objects  $::core S_ACE_USR_DATA_WIDTH]
set_property value_validation_list {16384:16384} [::ipx::get_hdl_parameters -of_objects  $::core RAM_SIZE] 
set_property value_validation_list {16:16} [::ipx::get_hdl_parameters -of_objects  $::core MAX_DESC] 
set_property value_validation_list {64:64} [::ipx::get_hdl_parameters -of_objects  $::core CACHE_LINE_SIZE] 
set_property value_validation_list {0:0 1:1} [::ipx::get_hdl_parameters -of_objects  $::core LAST_BRIDGE] 

set_property value_validation_list {32:32 64:64} [::ipx::get_user_parameters -of_objects  $::core S_AXI_ADDR_WIDTH]
set_property value_validation_list {32:32} [::ipx::get_user_parameters -of_objects  $::core S_AXI_DATA_WIDTH]
set_property value_validation_list {32:32 64:64} [::ipx::get_user_parameters -of_objects  $::core M_AXI_ADDR_WIDTH]
set_property value_validation_list {32:32 64:64 128:128} [::ipx::get_user_parameters -of_objects  $::core S_ACE_USR_ADDR_WIDTH]
set_property value_validation_list {32:32 64:64 128:128} [::ipx::get_user_parameters -of_objects  $::core S_ACE_USR_DATA_WIDTH]
set_property value_validation_list {16384:16384} [::ipx::get_user_parameters -of_objects  $::core RAM_SIZE] 
set_property value_validation_list {16:16} [::ipx::get_user_parameters -of_objects  $::core MAX_DESC] 
set_property value_validation_list {64:64} [::ipx::get_user_parameters -of_objects  $::core CACHE_LINE_SIZE] 
set_property value_validation_list {0:0 1:1} [::ipx::get_user_parameters -of_objects  $::core LAST_BRIDGE] 

ipx::create_xgui_files [ipx::current_core]
ipgui::add_param -name {ACE_PROTOCOL} -component [ipx::current_core] -show_label {true} -show_range {true} -widget {}
ipgui::add_param -name {S_AXI_ADDR_WIDTH} -component [ipx::current_core] -show_label {true} -show_range {true} -widget {}
ipgui::add_param -name {S_AXI_DATA_WIDTH} -component [ipx::current_core] -show_label {true} -show_range {true} -widget {}
ipgui::add_param -name {M_AXI_ADDR_WIDTH} -component [ipx::current_core] -show_label {true} -show_range {true} -widget {}
ipgui::add_param -name {M_AXI_DATA_WIDTH} -component [ipx::current_core] -show_label {true} -show_range {true} -widget {}
ipgui::add_param -name {M_AXI_ID_WIDTH} -component [ipx::current_core] -show_label {true} -show_range {true} -widget {}
ipgui::add_param -name {M_AXI_USER_WIDTH} -component [ipx::current_core] -show_label {true} -show_range {true} -widget {}
ipgui::add_param -name {S_ACE_USR_ADDR_WIDTH} -component [ipx::current_core] -show_label {true} -show_range {true} -widget {}
ipgui::add_param -name {S_ACE_USR_DATA_WIDTH} -component [ipx::current_core] -show_label {true} -show_range {true} -widget {}
ipgui::add_param -name {S_ACE_USR_ID_WIDTH} -component [ipx::current_core] -show_label {true} -show_range {true} -widget {}
ipgui::add_param -name {S_ACE_USR_AWUSER_WIDTH} -component [ipx::current_core] -show_label {true} -show_range {true} -widget {}
ipgui::add_param -name {S_ACE_USR_WUSER_WIDTH} -component [ipx::current_core] -show_label {true} -show_range {true} -widget {}
ipgui::add_param -name {S_ACE_USR_BUSER_WIDTH} -component [ipx::current_core] -show_label {true} -show_range {true} -widget {}
ipgui::add_param -name {S_ACE_USR_ARUSER_WIDTH} -component [ipx::current_core] -show_label {true} -show_range {true} -widget {}
ipgui::add_param -name {S_ACE_USR_RUSER_WIDTH} -component [ipx::current_core] -show_label {true} -show_range {true} -widget {}
ipgui::add_param -name {RAM_SIZE} -component [ipx::current_core] -show_label {true} -show_range {true} -widget {}
ipgui::add_param -name {MAX_DESC} -component [ipx::current_core] -show_label {true} -show_range {true} -widget {}
ipgui::add_param -name {CACHE_LINE_SIZE} -component [ipx::current_core] -show_label {true} -show_range {true} -widget {}
ipgui::add_param -name {LAST_BRIDGE} -component [ipx::current_core] -show_label {true} -show_range {true} -widget {}
ipgui::add_param -name {USR_RST_NUM} -component [ipx::current_core] -show_label {true} -show_range {true} -widget {}


set_property widget {comboBox} [ipgui::get_guiparamspec -name "ACE_PROTOCOL" -component [ipx::current_core] ]
set_property widget {comboBox} [ipgui::get_guiparamspec -name "S_AXI_ADDR_WIDTH" -component [ipx::current_core] ]
set_property widget {comboBox} [ipgui::get_guiparamspec -name "S_AXI_DATA_WIDTH" -component [ipx::current_core] ]
set_property widget {comboBox} [ipgui::get_guiparamspec -name "M_AXI_ADDR_WIDTH" -component [ipx::current_core] ]
set_property widget {comboBox} [ipgui::get_guiparamspec -name "S_ACE_USR_ADDR_WIDTH" -component [ipx::current_core] ]
set_property widget {comboBox} [ipgui::get_guiparamspec -name "S_ACE_USR_DATA_WIDTH" -component [ipx::current_core] ]
set_property widget {comboBox} [ipgui::get_guiparamspec -name "RAM_SIZE" -component [ipx::current_core] ]
set_property widget {comboBox} [ipgui::get_guiparamspec -name "MAX_DESC" -component [ipx::current_core] ]
set_property widget {comboBox} [ipgui::get_guiparamspec -name "CACHE_LINE_SIZE" -component [ipx::current_core] ]
set_property widget {comboBox} [ipgui::get_guiparamspec -name "LAST_BRIDGE" -component [ipx::current_core] ]

set_property value_validation_type pairs [ipx::get_user_parameters ACE_PROTOCOL -of_objects [ipx::current_core]]
set_property value_validation_type list [ipx::get_user_parameters S_AXI_ADDR_WIDTH     -of_objects [ipx::current_core]]
set_property value_validation_type list [ipx::get_user_parameters S_AXI_DATA_WIDTH     -of_objects [ipx::current_core]]
set_property value_validation_type list [ipx::get_user_parameters M_AXI_ADDR_WIDTH     -of_objects [ipx::current_core]]
set_property value_validation_type list [ipx::get_user_parameters S_ACE_USR_ADDR_WIDTH -of_objects [ipx::current_core]]
set_property value_validation_type list [ipx::get_user_parameters S_ACE_USR_DATA_WIDTH -of_objects [ipx::current_core]]
set_property value_validation_type list [ipx::get_user_parameters RAM_SIZE             -of_objects [ipx::current_core]]
set_property value_validation_type list [ipx::get_user_parameters MAX_DESC             -of_objects [ipx::current_core]]
set_property value_validation_type list [ipx::get_user_parameters CACHE_LINE_SIZE             -of_objects [ipx::current_core]]
set_property value_validation_type list [ipx::get_user_parameters LAST_BRIDGE             -of_objects [ipx::current_core]]

set_property widget {textEdit} [ipgui::get_guiparamspec -name "M_AXI_DATA_WIDTH" -component [ipx::current_core] ]
set_property value_validation_range_minimum 128 [ipx::get_user_parameters M_AXI_DATA_WIDTH -of_objects [ipx::current_core]]
set_property value_validation_range_maximum 128 [ipx::get_user_parameters M_AXI_DATA_WIDTH -of_objects [ipx::current_core]]
set_property widget {textEdit} [ipgui::get_guiparamspec -name "M_AXI_ID_WIDTH" -component [ipx::current_core] ]
set_property value_validation_range_minimum 4 [ipx::get_user_parameters M_AXI_ID_WIDTH -of_objects [ipx::current_core]]
set_property value_validation_range_maximum 32 [ipx::get_user_parameters M_AXI_ID_WIDTH -of_objects [ipx::current_core]]
set_property widget {textEdit} [ipgui::get_guiparamspec -name "S_ACE_USR_ID_WIDTH" -component [ipx::current_core] ]
set_property value_validation_range_minimum 1 [ipx::get_user_parameters S_ACE_USR_ID_WIDTH -of_objects [ipx::current_core]]
set_property value_validation_range_maximum 16 [ipx::get_user_parameters S_ACE_USR_ID_WIDTH -of_objects [ipx::current_core]]
set_property widget {textEdit} [ipgui::get_guiparamspec -name "M_AXI_USER_WIDTH" -component [ipx::current_core] ]
set_property value_validation_range_minimum 1 [ipx::get_user_parameters M_AXI_USER_WIDTH -of_objects [ipx::current_core]]
set_property value_validation_range_maximum 32 [ipx::get_user_parameters M_AXI_USER_WIDTH -of_objects [ipx::current_core]]
set_property widget {textEdit} [ipgui::get_guiparamspec -name "S_ACE_USR_AWUSER_WIDTH" -component [ipx::current_core] ]
set_property value_validation_range_minimum 1 [ipx::get_user_parameters S_ACE_USR_AWUSER_WIDTH -of_objects [ipx::current_core]]
set_property value_validation_range_maximum 32 [ipx::get_user_parameters S_ACE_USR_AWUSER_WIDTH -of_objects [ipx::current_core]]
set_property widget {textEdit} [ipgui::get_guiparamspec -name "S_ACE_USR_WUSER_WIDTH" -component [ipx::current_core] ]
set_property value_validation_range_minimum 1 [ipx::get_user_parameters S_ACE_USR_WUSER_WIDTH -of_objects [ipx::current_core]]
set_property value_validation_range_maximum 32 [ipx::get_user_parameters S_ACE_USR_WUSER_WIDTH -of_objects [ipx::current_core]]
set_property widget {textEdit} [ipgui::get_guiparamspec -name "S_ACE_USR_BUSER_WIDTH" -component [ipx::current_core] ]
set_property value_validation_range_minimum 1 [ipx::get_user_parameters S_ACE_USR_BUSER_WIDTH -of_objects [ipx::current_core]]
set_property value_validation_range_maximum 32 [ipx::get_user_parameters S_ACE_USR_BUSER_WIDTH -of_objects [ipx::current_core]]
set_property widget {textEdit} [ipgui::get_guiparamspec -name "S_ACE_USR_ARUSER_WIDTH" -component [ipx::current_core] ]
set_property value_validation_range_minimum 1 [ipx::get_user_parameters S_ACE_USR_ARUSER_WIDTH -of_objects [ipx::current_core]]
set_property value_validation_range_maximum 32 [ipx::get_user_parameters S_ACE_USR_ARUSER_WIDTH -of_objects [ipx::current_core]]
set_property widget {textEdit} [ipgui::get_guiparamspec -name "S_ACE_USR_RUSER_WIDTH" -component [ipx::current_core] ]
set_property value_validation_range_minimum 1 [ipx::get_user_parameters S_ACE_USR_RUSER_WIDTH -of_objects [ipx::current_core]]
set_property value_validation_range_maximum 32 [ipx::get_user_parameters S_ACE_USR_RUSER_WIDTH -of_objects [ipx::current_core]]
set_property widget {textEdit} [ipgui::get_guiparamspec -name "USR_RST_NUM" -component [ipx::current_core] ]
set_property value_validation_range_minimum 1 [ipx::get_user_parameters USR_RST_NUM -of_objects [ipx::current_core]]
set_property value_validation_range_maximum 16 [ipx::get_user_parameters USR_RST_NUM -of_objects [ipx::current_core]]


set_property widget {comboBox} [ipgui::get_guiparamspec -name "USR_RST_NUM" -component [ipx::current_core] ]
set_property value_validation_type list [ipx::get_user_parameters USR_RST_NUM -of_objects [ipx::current_core]]
set_property value_validation_list {1 2 3 4} [ipx::get_user_parameters USR_RST_NUM -of_objects [ipx::current_core]]

#set_property value_validation_pairs {FULLACE FULLACE LITEACE LITEACE} [ipx::get_user_parameters ACE_PROTOCOL -of_objects [ipx::current_core]]
set_property value_validation_pairs {FULLACE FULLACE} [ipx::get_user_parameters ACE_PROTOCOL -of_objects [ipx::current_core]]

set_property enablement_value false [ipx::get_user_parameters M_AXI_DATA_WIDTH -of_objects [ipx::current_core]]

# Ports
::ipx::remove_all_port $::core
::ipx::add_ports_from_hdl -top_level_hdl_file hdl/verilog/ace_slv.v -top_module_name ace_slv $::core

::ipx::add_bus_interface CLK.ACLK $::core
set_property bus_type_vlnv xilinx.com:signal:clock:1.0 [::ipx::get_bus_interfaces -of_objects $::core CLK.ACLK]
set_property abstraction_type_vlnv xilinx.com:signal:clock_rtl:1.0 [::ipx::get_bus_interfaces -of_objects $::core CLK.ACLK]
set_property interface_mode slave [::ipx::get_bus_interfaces -of_objects $::core CLK.ACLK]
set_property display_name clk [::ipx::get_bus_interfaces -of_objects $::core CLK.ACLK]
set_property description {Clock input} [::ipx::get_bus_interfaces -of_objects $::core CLK.ACLK]
::ipx::add_port_map CLK [::ipx::get_bus_interfaces -of_objects $::core CLK.ACLK]
set_property PHYSICAL_NAME clk [::ipx::get_port_maps -of_objects [::ipx::get_bus_interfaces -of_objects $::core CLK.ACLK] CLK]

add_bus_param CLK.ACLK ASSOCIATED_BUSIF "S_AXI:M_AXI:S_ACE_USR:S_LITEACE_USR:" string
 
add_bus_param CLK.ACLK ASSOCIATED_RESET resetn string

::ipx::add_bus_interface RST.ARESETN $::core
set_property bus_type_vlnv xilinx.com:signal:reset:1.0 [::ipx::get_bus_interfaces -of_objects $::core RST.ARESETN]
set_property abstraction_type_vlnv xilinx.com:signal:reset_rtl:1.0 [::ipx::get_bus_interfaces -of_objects $::core RST.ARESETN]
set_property interface_mode slave [::ipx::get_bus_interfaces -of_objects $::core RST.ARESETN]
set_property display_name resetn [::ipx::get_bus_interfaces -of_objects $::core RST.ARESETN]
set_property description {Reset} [::ipx::get_bus_interfaces -of_objects $::core RST.ARESETN]
add_bus_param RST.ARESETN POLARITY ACTIVE_LOW string dependent
::ipx::add_port_map RST [::ipx::get_bus_interfaces -of_objects $::core RST.ARESETN]
set_property PHYSICAL_NAME resetn [::ipx::get_port_maps -of_objects [::ipx::get_bus_interfaces -of_objects $::core RST.ARESETN] RST]

::ipx::add_bus_interface RST.USRRESETN $::core
set_property bus_type_vlnv xilinx.com:signal:reset:1.0 [::ipx::get_bus_interfaces -of_objects $::core RST.USRRESETN]
set_property abstraction_type_vlnv xilinx.com:signal:reset_rtl:1.0 [::ipx::get_bus_interfaces -of_objects $::core RST.USRRESETN]
set_property interface_mode master [::ipx::get_bus_interfaces -of_objects $::core RST.USRRESETN]
set_property display_name usr_resetn [::ipx::get_bus_interfaces -of_objects $::core RST.USRRESETN]
set_property description {Reset} [::ipx::get_bus_interfaces -of_objects $::core RST.USRRESETN]
add_bus_param RST.USRRESETN POLARITY ACTIVE_LOW string dependent
::ipx::add_port_map RST [::ipx::get_bus_interfaces -of_objects $::core RST.USRRESETN]
set_property PHYSICAL_NAME usr_resetn [::ipx::get_port_maps -of_objects [::ipx::get_bus_interfaces -of_objects $::core RST.USRRESETN] RST]

::ipx::add_bus_interface S_AXI $::core
set_property bus_type_vlnv xilinx.com:interface:aximm:1.0 [::ipx::get_bus_interfaces -of_objects $::core S_AXI]
set_property abstraction_type_vlnv xilinx.com:interface:aximm_rtl:1.0 [::ipx::get_bus_interfaces -of_objects $::core S_AXI]
set_property interface_mode slave [::ipx::get_bus_interfaces -of_objects $::core S_AXI]
set_property display_name S_AXI [::ipx::get_bus_interfaces -of_objects $::core S_AXI]
set_property description {Slave FULLACE Interface} [::ipx::get_bus_interfaces -of_objects $::core S_AXI]

::ipx::add_bus_interface M_AXI $::core
set_property bus_type_vlnv xilinx.com:interface:aximm:1.0 [::ipx::get_bus_interfaces -of_objects $::core M_AXI]
set_property abstraction_type_vlnv xilinx.com:interface:aximm_rtl:1.0 [::ipx::get_bus_interfaces -of_objects $::core M_AXI]
set_property interface_mode master [::ipx::get_bus_interfaces -of_objects $::core M_AXI]
set_property display_name M_AXI [::ipx::get_bus_interfaces -of_objects $::core M_AXI]
set_property description {Master AXI4 Interface} [::ipx::get_bus_interfaces -of_objects $::core M_AXI]

::ipx::add_bus_interface S_ACE_USR $::core
set_property abstraction_type_vlnv xilinx.com:interface:acemm_rtl:1.0 [ipx::get_bus_interfaces S_ACE_USR -of_objects [ipx::current_core]]
set_property bus_type_vlnv xilinx.com:interface:acemm:1.0 [ipx::get_bus_interfaces S_ACE_USR -of_objects [ipx::current_core]]
set_property interface_mode slave [::ipx::get_bus_interfaces -of_objects $::core S_ACE_USR]
set_property display_name S_ACE_USR [::ipx::get_bus_interfaces -of_objects $::core S_ACE_USR]
set_property description {Slave User AXI Interface} [::ipx::get_bus_interfaces -of_objects $::core S_ACE_USR]
set_property enablement_presence "optional" [::ipx::get_bus_interfaces -of_objects $::core S_ACE_USR]
set_property enablement_value "false" [::ipx::get_bus_interfaces -of_objects $::core S_ACE_USR]
set_property enablement_resolve_type "dependent" [::ipx::get_bus_interfaces -of_objects $::core S_ACE_USR]
set_property enablement_dependency {$ACE_PROTOCOL == "FULLACE"} [::ipx::get_bus_interfaces -of_objects $::core S_ACE_USR]

::ipx::add_bus_interface S_LITEACE_USR $::core
set_property abstraction_type_vlnv xilinx.com:interface:acemm_rtl:1.0 [ipx::get_bus_interfaces S_LITEACE_USR -of_objects [ipx::current_core]]
set_property bus_type_vlnv xilinx.com:interface:acemm:1.0 [ipx::get_bus_interfaces S_LITEACE_USR -of_objects [ipx::current_core]]
set_property interface_mode slave [::ipx::get_bus_interfaces -of_objects $::core S_LITEACE_USR]
set_property display_name S_LITEACE_USR [::ipx::get_bus_interfaces -of_objects $::core S_LITEACE_USR]
set_property description {Slave User AXI Interface} [::ipx::get_bus_interfaces -of_objects $::core S_LITEACE_USR]
set_property enablement_presence "optional" [::ipx::get_bus_interfaces -of_objects $::core S_LITEACE_USR]
set_property enablement_value "false" [::ipx::get_bus_interfaces -of_objects $::core S_LITEACE_USR]
set_property enablement_resolve_type "dependent" [::ipx::get_bus_interfaces -of_objects $::core S_LITEACE_USR]
set_property enablement_dependency {$ACE_PROTOCOL == "LITEACE"} [::ipx::get_bus_interfaces -of_objects $::core S_LITEACE_USR]

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

add_port_map_axi  AWID         m_axi_awid       M_AXI 1    
add_port_map_axi  AWADDR       m_axi_awaddr     M_AXI 1      
add_port_map_axi  AWLEN        m_axi_awlen      M_AXI 1     
add_port_map_axi  AWSIZE       m_axi_awsize     M_AXI 1      
add_port_map_axi  AWBURST      m_axi_awburst    M_AXI 1       
add_port_map_axi  AWLOCK       m_axi_awlock     M_AXI 1      
add_port_map_axi  AWCACHE      m_axi_awcache    M_AXI 1       
add_port_map_axi  AWPROT       m_axi_awprot     M_AXI 1      
add_port_map_axi  AWQOS        m_axi_awqos      M_AXI 1     
add_port_map_axi  AWREGION     m_axi_awregion   M_AXI 1         
add_port_map_axi  AWUSER       m_axi_awuser     M_AXI 1      
add_port_map_axi  AWVALID      m_axi_awvalid    M_AXI 1       
add_port_map_axi  AWREADY      m_axi_awready    M_AXI 1       
add_port_map_axi  WDATA        m_axi_wdata      M_AXI 1     
add_port_map_axi  WSTRB        m_axi_wstrb      M_AXI 1     
add_port_map_axi  WLAST        m_axi_wlast      M_AXI 1     
add_port_map_axi  WUSER        m_axi_wuser      M_AXI 1     
add_port_map_axi  WVALID       m_axi_wvalid     M_AXI 1      
add_port_map_axi  WREADY       m_axi_wready     M_AXI 1      
add_port_map_axi  BID          m_axi_bid        M_AXI 1   
add_port_map_axi  BRESP        m_axi_bresp      M_AXI 1     
add_port_map_axi  BUSER        m_axi_buser      M_AXI 1     
add_port_map_axi  BVALID       m_axi_bvalid     M_AXI 1      
add_port_map_axi  BREADY       m_axi_bready     M_AXI 1      
add_port_map_axi  ARID         m_axi_arid       M_AXI 1    
add_port_map_axi  ARADDR       m_axi_araddr     M_AXI 1      
add_port_map_axi  ARLEN        m_axi_arlen      M_AXI 1     
add_port_map_axi  ARSIZE       m_axi_arsize     M_AXI 1      
add_port_map_axi  ARBURST      m_axi_arburst    M_AXI 1       
add_port_map_axi  ARLOCK       m_axi_arlock     M_AXI 1      
add_port_map_axi  ARCACHE      m_axi_arcache    M_AXI 1       
add_port_map_axi  ARPROT       m_axi_arprot     M_AXI 1      
add_port_map_axi  ARQOS        m_axi_arqos      M_AXI 1     
add_port_map_axi  ARREGION     m_axi_arregion   M_AXI 1        
add_port_map_axi  ARUSER       m_axi_aruser     M_AXI 1      
add_port_map_axi  ARVALID      m_axi_arvalid    M_AXI 1       
add_port_map_axi  ARREADY      m_axi_arready    M_AXI 1       
add_port_map_axi  RID          m_axi_rid        M_AXI 1   
add_port_map_axi  RDATA        m_axi_rdata      M_AXI 1     
add_port_map_axi  RRESP        m_axi_rresp      M_AXI 1     
add_port_map_axi  RLAST        m_axi_rlast      M_AXI 1     
add_port_map_axi  RUSER        m_axi_ruser      M_AXI 1     
add_port_map_axi  RVALID       m_axi_rvalid     M_AXI 1      
add_port_map_axi  RREADY       m_axi_rready     M_AXI 1      

add_port_map_ace  AWID         s_ace_usr_awid            S_ACE_USR     1
add_port_map_ace  AWADDR       s_ace_usr_awaddr          S_ACE_USR     1
add_port_map_ace  AWLEN        s_ace_usr_awlen           S_ACE_USR     1
add_port_map_ace  AWSIZE       s_ace_usr_awsize          S_ACE_USR     1
add_port_map_ace  AWBURST      s_ace_usr_awburst         S_ACE_USR     1
add_port_map_ace  AWLOCK       s_ace_usr_awlock          S_ACE_USR     1
add_port_map_ace  AWCACHE      s_ace_usr_awcache         S_ACE_USR     1
add_port_map_ace  AWPROT       s_ace_usr_awprot          S_ACE_USR     1
add_port_map_ace  AWQOS        s_ace_usr_awqos           S_ACE_USR     1
add_port_map_ace  AWREGION     s_ace_usr_awregion        S_ACE_USR     1
add_port_map_ace  AWUSER       s_ace_usr_awuser          S_ACE_USR     1
add_port_map_ace  AWSNOOP      s_ace_usr_awsnoop         S_ACE_USR     1
add_port_map_ace  AWDOMAIN     s_ace_usr_awdomain        S_ACE_USR     1
add_port_map_ace  AWBAR        s_ace_usr_awbar           S_ACE_USR     1
add_port_map_ace  AWVALID      s_ace_usr_awvalid         S_ACE_USR     1
add_port_map_ace  AWREADY      s_ace_usr_awready         S_ACE_USR     1
add_port_map_ace  WDATA        s_ace_usr_wdata           S_ACE_USR     1
add_port_map_ace  WSTRB        s_ace_usr_wstrb           S_ACE_USR     1
add_port_map_ace  WLAST        s_ace_usr_wlast           S_ACE_USR     1
add_port_map_ace  WUSER        s_ace_usr_wuser           S_ACE_USR     1
add_port_map_ace  WVALID       s_ace_usr_wvalid          S_ACE_USR     1
add_port_map_ace  WREADY       s_ace_usr_wready          S_ACE_USR     1
add_port_map_ace  BID          s_ace_usr_bid             S_ACE_USR     1
add_port_map_ace  BRESP        s_ace_usr_bresp           S_ACE_USR     1
add_port_map_ace  BUSER        s_ace_usr_buser           S_ACE_USR     1
add_port_map_ace  BVALID       s_ace_usr_bvalid          S_ACE_USR     1
add_port_map_ace  BREADY       s_ace_usr_bready          S_ACE_USR     1
add_port_map_ace  WACK         s_ace_usr_wack            S_ACE_USR     1
add_port_map_ace  ARID         s_ace_usr_arid            S_ACE_USR     1
add_port_map_ace  ARADDR       s_ace_usr_araddr          S_ACE_USR     1
add_port_map_ace  ARLEN        s_ace_usr_arlen           S_ACE_USR     1
add_port_map_ace  ARSIZE       s_ace_usr_arsize          S_ACE_USR     1
add_port_map_ace  ARBURST      s_ace_usr_arburst         S_ACE_USR     1
add_port_map_ace  ARLOCK       s_ace_usr_arlock          S_ACE_USR     1
add_port_map_ace  ARCACHE      s_ace_usr_arcache         S_ACE_USR     1
add_port_map_ace  ARPROT       s_ace_usr_arprot          S_ACE_USR     1
add_port_map_ace  ARQOS        s_ace_usr_arqos           S_ACE_USR     1
add_port_map_ace  ARREGION     s_ace_usr_arregion        S_ACE_USR     1
add_port_map_ace  ARUSER       s_ace_usr_aruser          S_ACE_USR     1
add_port_map_ace  ARSNOOP      s_ace_usr_arsnoop         S_ACE_USR     1
add_port_map_ace  ARDOMAIN     s_ace_usr_ardomain        S_ACE_USR     1
add_port_map_ace  ARBAR        s_ace_usr_arbar           S_ACE_USR     1
add_port_map_ace  ARVALID      s_ace_usr_arvalid         S_ACE_USR     1
add_port_map_ace  ARREADY      s_ace_usr_arready         S_ACE_USR     1
add_port_map_ace  RID          s_ace_usr_rid             S_ACE_USR     1
add_port_map_ace  RDATA        s_ace_usr_rdata           S_ACE_USR     1
add_port_map_ace  RRESP        s_ace_usr_rresp           S_ACE_USR     1
add_port_map_ace  RLAST        s_ace_usr_rlast           S_ACE_USR     1
add_port_map_ace  RUSER        s_ace_usr_ruser           S_ACE_USR     1
add_port_map_ace  RVALID       s_ace_usr_rvalid          S_ACE_USR     1
add_port_map_ace  RREADY       s_ace_usr_rready          S_ACE_USR     1    
add_port_map_ace  RACK         s_ace_usr_rack            S_ACE_USR     1
add_port_map_ace  ACADDR       s_ace_usr_acaddr          S_ACE_USR     1   
add_port_map_ace  ACSNOOP      s_ace_usr_acsnoop         S_ACE_USR     1   
add_port_map_ace  ACPROT       s_ace_usr_acprot          S_ACE_USR     1   
add_port_map_ace  ACVALID      s_ace_usr_acvalid         S_ACE_USR     1   
add_port_map_ace  ACREADY      s_ace_usr_acready         S_ACE_USR     1   
add_port_map_ace  CRRESP       s_ace_usr_crresp          S_ACE_USR     1  
add_port_map_ace  CRVALID      s_ace_usr_crvalid         S_ACE_USR     1  
add_port_map_ace  CRREADY      s_ace_usr_crready         S_ACE_USR     1  
add_port_map_ace  CDDATA       s_ace_usr_cddata          S_ACE_USR     1  
add_port_map_ace  CDLAST       s_ace_usr_cdlast          S_ACE_USR     1  
add_port_map_ace  CDVALID      s_ace_usr_cdvalid         S_ACE_USR     1  
add_port_map_ace  CDREADY      s_ace_usr_cdready         S_ACE_USR     1  

add_port_map_ace  AWID         s_ace_usr_awid            S_LITEACE_USR 1
add_port_map_ace  AWADDR       s_ace_usr_awaddr          S_LITEACE_USR 1
add_port_map_ace  AWLEN        s_ace_usr_awlen           S_LITEACE_USR 1
add_port_map_ace  AWSIZE       s_ace_usr_awsize          S_LITEACE_USR 1
add_port_map_ace  AWBURST      s_ace_usr_awburst         S_LITEACE_USR 1
add_port_map_ace  AWLOCK       s_ace_usr_awlock          S_LITEACE_USR 1
add_port_map_ace  AWCACHE      s_ace_usr_awcache         S_LITEACE_USR 1
add_port_map_ace  AWPROT       s_ace_usr_awprot          S_LITEACE_USR 1
add_port_map_ace  AWQOS        s_ace_usr_awqos           S_LITEACE_USR 1
add_port_map_ace  AWREGION     s_ace_usr_awregion        S_LITEACE_USR 1
add_port_map_ace  AWUSER       s_ace_usr_awuser          S_LITEACE_USR 1
add_port_map_ace  AWVALID      s_ace_usr_awvalid         S_LITEACE_USR 1
add_port_map_ace  AWREADY      s_ace_usr_awready         S_LITEACE_USR 1
add_port_map_ace  WDATA        s_ace_usr_wdata           S_LITEACE_USR 1
add_port_map_ace  WSTRB        s_ace_usr_wstrb           S_LITEACE_USR 1
add_port_map_ace  WLAST        s_ace_usr_wlast           S_LITEACE_USR 1
add_port_map_ace  WUSER        s_ace_usr_wuser           S_LITEACE_USR 1
add_port_map_ace  WVALID       s_ace_usr_wvalid          S_LITEACE_USR 1
add_port_map_ace  WREADY       s_ace_usr_wready          S_LITEACE_USR 1
add_port_map_ace  BID          s_ace_usr_bid             S_LITEACE_USR 1
add_port_map_ace  BRESP        s_ace_usr_bresp           S_LITEACE_USR 1
add_port_map_ace  BUSER        s_ace_usr_buser           S_LITEACE_USR 1
add_port_map_ace  BVALID       s_ace_usr_bvalid          S_LITEACE_USR 1
add_port_map_ace  BREADY       s_ace_usr_bready          S_LITEACE_USR 1
add_port_map_ace  ARID         s_ace_usr_arid            S_LITEACE_USR 1
add_port_map_ace  ARADDR       s_ace_usr_araddr          S_LITEACE_USR 1
add_port_map_ace  ARLEN        s_ace_usr_arlen           S_LITEACE_USR 1
add_port_map_ace  ARSIZE       s_ace_usr_arsize          S_LITEACE_USR 1
add_port_map_ace  ARBURST      s_ace_usr_arburst         S_LITEACE_USR 1
add_port_map_ace  ARLOCK       s_ace_usr_arlock          S_LITEACE_USR 1
add_port_map_ace  ARCACHE      s_ace_usr_arcache         S_LITEACE_USR 1
add_port_map_ace  ARPROT       s_ace_usr_arprot          S_LITEACE_USR 1
add_port_map_ace  ARQOS        s_ace_usr_arqos           S_LITEACE_USR 1
add_port_map_ace  ARREGION     s_ace_usr_arregion        S_LITEACE_USR 1
add_port_map_ace  ARUSER       s_ace_usr_aruser          S_LITEACE_USR 1
add_port_map_ace  ARVALID      s_ace_usr_arvalid         S_LITEACE_USR 1
add_port_map_ace  ARREADY      s_ace_usr_arready         S_LITEACE_USR 1
add_port_map_ace  RID          s_ace_usr_rid             S_LITEACE_USR 1
add_port_map_ace  RDATA        s_ace_usr_rdata           S_LITEACE_USR 1
add_port_map_ace  RRESP        s_ace_usr_rresp           S_LITEACE_USR 1
add_port_map_ace  RLAST        s_ace_usr_rlast           S_LITEACE_USR 1
add_port_map_ace  RUSER        s_ace_usr_ruser           S_LITEACE_USR 1
add_port_map_ace  RVALID       s_ace_usr_rvalid          S_LITEACE_USR 1
add_port_map_ace  RREADY       s_ace_usr_rready          S_LITEACE_USR 1

# Memory maps
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


set current_addrspace [::ipx::add_address_space {M_AXI} $::core]
set_property range {16E} $current_addrspace
set_property range_format {long} $current_addrspace
set_property range_resolve_type {dependent} $current_addrspace
set_property width 64 $current_addrspace
set_property width_format {long} $current_addrspace
set_property master_address_space_ref {M_AXI} [::ipx::get_bus_interfaces -of_objects $::core M_AXI]

set slaveifs {S_ACE_USR}
lappend slaveifs S_LITEACE_USR
foreach slaveif $slaveifs {
  set current_memory_map [::ipx::add_memory_map $slaveif $::core]
  set_property description "$slaveif memory map" $current_memory_map
  set current_address_block [::ipx::add_address_block Mem $current_memory_map]
  set_property width {64} $current_address_block
  set_property access {read-write} $current_address_block
  set_property usage {memory} $current_address_block
  set_property base_address {0} $current_address_block
  set_property base_address_format {long} $current_address_block
  set_property range {16E} $current_address_block
  set_property range_format {long} $current_address_block
  set_property slave_memory_map_ref $slaveif [::ipx::get_bus_interfaces -of_objects $::core $slaveif]
}

# Validate and save core
::ipx::save_core $::core

