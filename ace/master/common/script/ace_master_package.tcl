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
  set_property display_name {ace_mst_v1_00} $::core

  set_property description {POSH ACE-Mst Bridge} $::core

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
set ::core [::ipx::create_core xilinx.com ip ace_mst 1.00]
set_property root_directory {.} $::core

# Source files
foreach fg {xilinx_vivadoverilogsynthesis xilinx_vivadoverilogbehavioralsimulation} {
  set current_filegroup [::ipx::add_file_group $fg $::core]
  set_property library_name ace_mst [::ipx::add_file hdl/verilog/ace_mst.v $current_filegroup]
  set_property library_name ace_mst [::ipx::add_file hdl/verilog/ace_defines_common.vh $current_filegroup]
  set_property model_name ace_mst $current_filegroup
}

set_global_properties

# Customization Parameters
::ipx::remove_all_hdl_parameter $::core
::ipx::add_model_parameters_from_hdl -top_level_hdl_file hdl/verilog/ace_mst.v -top_module_name ace_mst $::core

add_param ACE_PROTOCOL                  FULLACE    "User Slave ACE Protocol"        ""  STRING  
add_param S_AXI_ADDR_WIDTH              32      "Slave AXI Addr-Width"          ""  LONG  
add_param S_AXI_DATA_WIDTH              32      "Slave AXI Data-Width"          ""  LONG  
add_param M_AXI_ADDR_WIDTH              64      "Master AXI Addr-Width"         ""  LONG  
add_param M_AXI_DATA_WIDTH              128     "Master AXI Data-Width"         ""  LONG  
add_param M_AXI_ID_WIDTH                4       "Master AXI ID-Width"           ""  LONG  
add_param M_AXI_USER_WIDTH              32      "Master AXI User-Width"         ""  LONG  
add_param M_ACE_USR_ADDR_WIDTH          64      "User Mst ACE Addr-Width"    ""  LONG  
add_param M_ACE_USR_DATA_WIDTH          128     "User Mst ACE Data-Width"    ""  LONG  
add_param M_ACE_USR_ID_WIDTH            16      "User Mst ACE ID-Width"      ""  LONG  
add_param M_ACE_USR_AWUSER_WIDTH        32      "User Mst ACE AWUser-Width"    ""  LONG  
add_param M_ACE_USR_WUSER_WIDTH         32      "User Mst ACE WUser-Width"    ""  LONG  
add_param M_ACE_USR_BUSER_WIDTH         32      "User Mst ACE BUser-Width"    ""  LONG  
add_param M_ACE_USR_ARUSER_WIDTH        32      "User Mst ACE ARUser-Width"    ""  LONG  
add_param M_ACE_USR_RUSER_WIDTH         32      "User Mst ACE Ruser-Width"    ""  LONG  
add_param RAM_SIZE                      16384   "RDATA,WDATA,WSTRB RAM Size (in Bytes)"                      ""  LONG  
add_param MAX_DESC                      16      "Maximum Number of Descripter"  ""  LONG  
add_param CACHE_LINE_SIZE               64      "Size of Cache line size (in Bytes)"    ""  LONG  
add_param LAST_BRIDGE                   0       "Last Bridge"    ""  LONG  
add_param USR_RST_NUM                   4       "Number of User Reset"          ""  LONG  

set_property value_validation_list {32:32 64:64} [::ipx::get_hdl_parameters -of_objects  $::core S_AXI_ADDR_WIDTH]
set_property value_validation_list {32:32} [::ipx::get_hdl_parameters -of_objects  $::core S_AXI_DATA_WIDTH]
set_property value_validation_list {32:32 64:64} [::ipx::get_hdl_parameters -of_objects  $::core M_AXI_ADDR_WIDTH]
set_property value_validation_list {32:32 64:64 128:128} [::ipx::get_hdl_parameters -of_objects  $::core M_ACE_USR_ADDR_WIDTH]
set_property value_validation_list {32:32 64:64 128:128} [::ipx::get_hdl_parameters -of_objects  $::core M_ACE_USR_ADDR_WIDTH]
set_property value_validation_list {32:32 64:64 128:128} [::ipx::get_hdl_parameters -of_objects  $::core M_ACE_USR_DATA_WIDTH]
set_property value_validation_list {16384:16384} [::ipx::get_hdl_parameters -of_objects  $::core RAM_SIZE] 
set_property value_validation_list {16:16} [::ipx::get_hdl_parameters -of_objects  $::core MAX_DESC] 
set_property value_validation_list {64:64} [::ipx::get_hdl_parameters -of_objects  $::core CACHE_LINE_SIZE] 
set_property value_validation_list {0:0 1:1} [::ipx::get_hdl_parameters -of_objects  $::core LAST_BRIDGE] 

set_property value_validation_list {32:32 64:64} [::ipx::get_user_parameters -of_objects  $::core S_AXI_ADDR_WIDTH]
set_property value_validation_list {32:32} [::ipx::get_user_parameters -of_objects  $::core S_AXI_DATA_WIDTH]
set_property value_validation_list {32:32 64:64} [::ipx::get_user_parameters -of_objects  $::core M_AXI_ADDR_WIDTH]
set_property value_validation_list {32:32 64:64 128:128} [::ipx::get_user_parameters -of_objects  $::core M_ACE_USR_ADDR_WIDTH]
set_property value_validation_list {32:32 64:64 128:128} [::ipx::get_user_parameters -of_objects  $::core M_ACE_USR_DATA_WIDTH]
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
ipgui::add_param -name {M_ACE_USR_ADDR_WIDTH} -component [ipx::current_core] -show_label {true} -show_range {true} -widget {}
ipgui::add_param -name {M_ACE_USR_DATA_WIDTH} -component [ipx::current_core] -show_label {true} -show_range {true} -widget {}
ipgui::add_param -name {M_ACE_USR_ID_WIDTH} -component [ipx::current_core] -show_label {true} -show_range {true} -widget {}
ipgui::add_param -name {M_ACE_USR_AWUSER_WIDTH} -component [ipx::current_core] -show_label {true} -show_range {true} -widget {}
ipgui::add_param -name {M_ACE_USR_WUSER_WIDTH} -component [ipx::current_core] -show_label {true} -show_range {true} -widget {}
ipgui::add_param -name {M_ACE_USR_BUSER_WIDTH} -component [ipx::current_core] -show_label {true} -show_range {true} -widget {}
ipgui::add_param -name {M_ACE_USR_ARUSER_WIDTH} -component [ipx::current_core] -show_label {true} -show_range {true} -widget {}
ipgui::add_param -name {M_ACE_USR_RUSER_WIDTH} -component [ipx::current_core] -show_label {true} -show_range {true} -widget {}
ipgui::add_param -name {RAM_SIZE} -component [ipx::current_core] -show_label {true} -show_range {true} -widget {}
ipgui::add_param -name {MAX_DESC} -component [ipx::current_core] -show_label {true} -show_range {true} -widget {}
ipgui::add_param -name {CACHE_LINE_SIZE} -component [ipx::current_core] -show_label {true} -show_range {true} -widget {}
ipgui::add_param -name {LAST_BRIDGE} -component [ipx::current_core] -show_label {true} -show_range {true} -widget {}
ipgui::add_param -name {USR_RST_NUM} -component [ipx::current_core] -show_label {true} -show_range {true} -widget {}


set_property widget {comboBox} [ipgui::get_guiparamspec -name "ACE_PROTOCOL" -component [ipx::current_core] ]
set_property widget {comboBox} [ipgui::get_guiparamspec -name "S_AXI_ADDR_WIDTH" -component [ipx::current_core] ]
set_property widget {comboBox} [ipgui::get_guiparamspec -name "S_AXI_DATA_WIDTH" -component [ipx::current_core] ]
set_property widget {comboBox} [ipgui::get_guiparamspec -name "M_AXI_ADDR_WIDTH" -component [ipx::current_core] ]
set_property widget {comboBox} [ipgui::get_guiparamspec -name "M_ACE_USR_ADDR_WIDTH" -component [ipx::current_core] ]
set_property widget {comboBox} [ipgui::get_guiparamspec -name "M_ACE_USR_DATA_WIDTH" -component [ipx::current_core] ]
set_property widget {comboBox} [ipgui::get_guiparamspec -name "RAM_SIZE" -component [ipx::current_core] ]
set_property widget {comboBox} [ipgui::get_guiparamspec -name "MAX_DESC" -component [ipx::current_core] ]
set_property widget {comboBox} [ipgui::get_guiparamspec -name "CACHE_LINE_SIZE" -component [ipx::current_core] ]
set_property widget {comboBox} [ipgui::get_guiparamspec -name "LAST_BRIDGE" -component [ipx::current_core] ]

set_property value_validation_type pairs [ipx::get_user_parameters ACE_PROTOCOL -of_objects [ipx::current_core]]
set_property value_validation_type list [ipx::get_user_parameters S_AXI_ADDR_WIDTH     -of_objects [ipx::current_core]]
set_property value_validation_type list [ipx::get_user_parameters S_AXI_DATA_WIDTH     -of_objects [ipx::current_core]]
set_property value_validation_type list [ipx::get_user_parameters M_AXI_ADDR_WIDTH     -of_objects [ipx::current_core]]
set_property value_validation_type list [ipx::get_user_parameters M_ACE_USR_ADDR_WIDTH -of_objects [ipx::current_core]]
set_property value_validation_type list [ipx::get_user_parameters M_ACE_USR_DATA_WIDTH -of_objects [ipx::current_core]]
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
set_property widget {textEdit} [ipgui::get_guiparamspec -name "M_ACE_USR_ID_WIDTH" -component [ipx::current_core] ]
set_property value_validation_range_minimum 1 [ipx::get_user_parameters M_ACE_USR_ID_WIDTH -of_objects [ipx::current_core]]
set_property value_validation_range_maximum 16 [ipx::get_user_parameters M_ACE_USR_ID_WIDTH -of_objects [ipx::current_core]]
set_property widget {textEdit} [ipgui::get_guiparamspec -name "M_AXI_USER_WIDTH" -component [ipx::current_core] ]
set_property value_validation_range_minimum 1 [ipx::get_user_parameters M_AXI_USER_WIDTH -of_objects [ipx::current_core]]
set_property value_validation_range_maximum 32 [ipx::get_user_parameters M_AXI_USER_WIDTH -of_objects [ipx::current_core]]
set_property widget {textEdit} [ipgui::get_guiparamspec -name "M_ACE_USR_AWUSER_WIDTH" -component [ipx::current_core] ]
set_property value_validation_range_minimum 1 [ipx::get_user_parameters M_ACE_USR_AWUSER_WIDTH -of_objects [ipx::current_core]]
set_property value_validation_range_maximum 32 [ipx::get_user_parameters M_ACE_USR_AWUSER_WIDTH -of_objects [ipx::current_core]]
set_property widget {textEdit} [ipgui::get_guiparamspec -name "M_ACE_USR_WUSER_WIDTH" -component [ipx::current_core] ]
set_property value_validation_range_minimum 1 [ipx::get_user_parameters M_ACE_USR_WUSER_WIDTH -of_objects [ipx::current_core]]
set_property value_validation_range_maximum 32 [ipx::get_user_parameters M_ACE_USR_WUSER_WIDTH -of_objects [ipx::current_core]]
set_property widget {textEdit} [ipgui::get_guiparamspec -name "M_ACE_USR_BUSER_WIDTH" -component [ipx::current_core] ]
set_property value_validation_range_minimum 1 [ipx::get_user_parameters M_ACE_USR_BUSER_WIDTH -of_objects [ipx::current_core]]
set_property value_validation_range_maximum 32 [ipx::get_user_parameters M_ACE_USR_BUSER_WIDTH -of_objects [ipx::current_core]]
set_property widget {textEdit} [ipgui::get_guiparamspec -name "M_ACE_USR_ARUSER_WIDTH" -component [ipx::current_core] ]
set_property value_validation_range_minimum 1 [ipx::get_user_parameters M_ACE_USR_ARUSER_WIDTH -of_objects [ipx::current_core]]
set_property value_validation_range_maximum 32 [ipx::get_user_parameters M_ACE_USR_ARUSER_WIDTH -of_objects [ipx::current_core]]
set_property widget {textEdit} [ipgui::get_guiparamspec -name "M_ACE_USR_RUSER_WIDTH" -component [ipx::current_core] ]
set_property value_validation_range_minimum 1 [ipx::get_user_parameters M_ACE_USR_RUSER_WIDTH -of_objects [ipx::current_core]]
set_property value_validation_range_maximum 32 [ipx::get_user_parameters M_ACE_USR_RUSER_WIDTH -of_objects [ipx::current_core]]
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
::ipx::add_ports_from_hdl -top_level_hdl_file hdl/verilog/ace_mst.v -top_module_name ace_mst $::core

::ipx::add_bus_interface CLK.ACLK $::core
set_property bus_type_vlnv xilinx.com:signal:clock:1.0 [::ipx::get_bus_interfaces -of_objects $::core CLK.ACLK]
set_property abstraction_type_vlnv xilinx.com:signal:clock_rtl:1.0 [::ipx::get_bus_interfaces -of_objects $::core CLK.ACLK]
set_property interface_mode slave [::ipx::get_bus_interfaces -of_objects $::core CLK.ACLK]
set_property display_name clk [::ipx::get_bus_interfaces -of_objects $::core CLK.ACLK]
set_property description {Clock input} [::ipx::get_bus_interfaces -of_objects $::core CLK.ACLK]
::ipx::add_port_map CLK [::ipx::get_bus_interfaces -of_objects $::core CLK.ACLK]
set_property PHYSICAL_NAME clk [::ipx::get_port_maps -of_objects [::ipx::get_bus_interfaces -of_objects $::core CLK.ACLK] CLK]

add_bus_param CLK.ACLK ASSOCIATED_BUSIF "S_AXI:M_AXI:M_ACE_USR:M_LITEACE_USR:" string
 
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

::ipx::add_bus_interface M_ACE_USR $::core
set_property abstraction_type_vlnv xilinx.com:interface:acemm_rtl:1.0 [ipx::get_bus_interfaces M_ACE_USR -of_objects [ipx::current_core]]
set_property bus_type_vlnv xilinx.com:interface:acemm:1.0 [ipx::get_bus_interfaces M_ACE_USR -of_objects [ipx::current_core]]
set_property interface_mode master [::ipx::get_bus_interfaces -of_objects $::core M_ACE_USR]
set_property display_name M_ACE_USR [::ipx::get_bus_interfaces -of_objects $::core M_ACE_USR]
set_property description {Slave User AXI Interface} [::ipx::get_bus_interfaces -of_objects $::core M_ACE_USR]
set_property enablement_presence "optional" [::ipx::get_bus_interfaces -of_objects $::core M_ACE_USR]
set_property enablement_value "false" [::ipx::get_bus_interfaces -of_objects $::core M_ACE_USR]
set_property enablement_resolve_type "dependent" [::ipx::get_bus_interfaces -of_objects $::core M_ACE_USR]
set_property enablement_dependency {$ACE_PROTOCOL == "FULLACE"} [::ipx::get_bus_interfaces -of_objects $::core M_ACE_USR]

::ipx::add_bus_interface M_LITEACE_USR $::core
set_property abstraction_type_vlnv xilinx.com:interface:acemm_rtl:1.0 [ipx::get_bus_interfaces M_LITEACE_USR -of_objects [ipx::current_core]]
set_property bus_type_vlnv xilinx.com:interface:acemm:1.0 [ipx::get_bus_interfaces M_LITEACE_USR -of_objects [ipx::current_core]]
set_property interface_mode master [::ipx::get_bus_interfaces -of_objects $::core M_LITEACE_USR]
set_property display_name M_LITEACE_USR [::ipx::get_bus_interfaces -of_objects $::core M_LITEACE_USR]
set_property description {Slave User AXI Interface} [::ipx::get_bus_interfaces -of_objects $::core M_LITEACE_USR]
set_property enablement_presence "optional" [::ipx::get_bus_interfaces -of_objects $::core M_LITEACE_USR]
set_property enablement_value "false" [::ipx::get_bus_interfaces -of_objects $::core M_LITEACE_USR]
set_property enablement_resolve_type "dependent" [::ipx::get_bus_interfaces -of_objects $::core M_LITEACE_USR]
set_property enablement_dependency {$ACE_PROTOCOL == "LITEACE"} [::ipx::get_bus_interfaces -of_objects $::core M_LITEACE_USR]

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

add_port_map_ace  AWID         m_ace_usr_awid            M_ACE_USR     1
add_port_map_ace  AWADDR       m_ace_usr_awaddr          M_ACE_USR     1
add_port_map_ace  AWLEN        m_ace_usr_awlen           M_ACE_USR     1
add_port_map_ace  AWSIZE       m_ace_usr_awsize          M_ACE_USR     1
add_port_map_ace  AWBURST      m_ace_usr_awburst         M_ACE_USR     1
add_port_map_ace  AWLOCK       m_ace_usr_awlock          M_ACE_USR     1
add_port_map_ace  AWCACHE      m_ace_usr_awcache         M_ACE_USR     1
add_port_map_ace  AWPROT       m_ace_usr_awprot          M_ACE_USR     1
add_port_map_ace  AWQOS        m_ace_usr_awqos           M_ACE_USR     1
add_port_map_ace  AWREGION     m_ace_usr_awregion        M_ACE_USR     1
add_port_map_ace  AWUSER       m_ace_usr_awuser          M_ACE_USR     1
add_port_map_ace  AWSNOOP      m_ace_usr_awsnoop         M_ACE_USR     1
add_port_map_ace  AWDOMAIN     m_ace_usr_awdomain        M_ACE_USR     1
add_port_map_ace  AWBAR        m_ace_usr_awbar           M_ACE_USR     1
add_port_map_ace  AWVALID      m_ace_usr_awvalid         M_ACE_USR     1
add_port_map_ace  AWREADY      m_ace_usr_awready         M_ACE_USR     1
add_port_map_ace  WDATA        m_ace_usr_wdata           M_ACE_USR     1
add_port_map_ace  WSTRB        m_ace_usr_wstrb           M_ACE_USR     1
add_port_map_ace  WLAST        m_ace_usr_wlast           M_ACE_USR     1
add_port_map_ace  WUSER        m_ace_usr_wuser           M_ACE_USR     1
add_port_map_ace  WVALID       m_ace_usr_wvalid          M_ACE_USR     1
add_port_map_ace  WREADY       m_ace_usr_wready          M_ACE_USR     1
add_port_map_ace  BID          m_ace_usr_bid             M_ACE_USR     1
add_port_map_ace  BRESP        m_ace_usr_bresp           M_ACE_USR     1
add_port_map_ace  BUSER        m_ace_usr_buser           M_ACE_USR     1
add_port_map_ace  BVALID       m_ace_usr_bvalid          M_ACE_USR     1
add_port_map_ace  BREADY       m_ace_usr_bready          M_ACE_USR     1
add_port_map_ace  WACK         m_ace_usr_wack            M_ACE_USR     1
add_port_map_ace  ARID         m_ace_usr_arid            M_ACE_USR     1
add_port_map_ace  ARADDR       m_ace_usr_araddr          M_ACE_USR     1
add_port_map_ace  ARLEN        m_ace_usr_arlen           M_ACE_USR     1
add_port_map_ace  ARSIZE       m_ace_usr_arsize          M_ACE_USR     1
add_port_map_ace  ARBURST      m_ace_usr_arburst         M_ACE_USR     1
add_port_map_ace  ARLOCK       m_ace_usr_arlock          M_ACE_USR     1
add_port_map_ace  ARCACHE      m_ace_usr_arcache         M_ACE_USR     1
add_port_map_ace  ARPROT       m_ace_usr_arprot          M_ACE_USR     1
add_port_map_ace  ARQOS        m_ace_usr_arqos           M_ACE_USR     1
add_port_map_ace  ARREGION     m_ace_usr_arregion        M_ACE_USR     1
add_port_map_ace  ARUSER       m_ace_usr_aruser          M_ACE_USR     1
add_port_map_ace  ARSNOOP      m_ace_usr_arsnoop         M_ACE_USR     1
add_port_map_ace  ARDOMAIN     m_ace_usr_ardomain        M_ACE_USR     1
add_port_map_ace  ARBAR        m_ace_usr_arbar           M_ACE_USR     1
add_port_map_ace  ARVALID      m_ace_usr_arvalid         M_ACE_USR     1
add_port_map_ace  ARREADY      m_ace_usr_arready         M_ACE_USR     1
add_port_map_ace  RID          m_ace_usr_rid             M_ACE_USR     1
add_port_map_ace  RDATA        m_ace_usr_rdata           M_ACE_USR     1
add_port_map_ace  RRESP        m_ace_usr_rresp           M_ACE_USR     1
add_port_map_ace  RLAST        m_ace_usr_rlast           M_ACE_USR     1
add_port_map_ace  RUSER        m_ace_usr_ruser           M_ACE_USR     1
add_port_map_ace  RVALID       m_ace_usr_rvalid          M_ACE_USR     1
add_port_map_ace  RREADY       m_ace_usr_rready          M_ACE_USR     1    
add_port_map_ace  RACK         m_ace_usr_rack            M_ACE_USR     1
add_port_map_ace  ACADDR       m_ace_usr_acaddr          M_ACE_USR     1   
add_port_map_ace  ACSNOOP      m_ace_usr_acsnoop         M_ACE_USR     1   
add_port_map_ace  ACPROT       m_ace_usr_acprot          M_ACE_USR     1   
add_port_map_ace  ACVALID      m_ace_usr_acvalid         M_ACE_USR     1   
add_port_map_ace  ACREADY      m_ace_usr_acready         M_ACE_USR     1   
add_port_map_ace  CRRESP       m_ace_usr_crresp          M_ACE_USR     1  
add_port_map_ace  CRVALID      m_ace_usr_crvalid         M_ACE_USR     1  
add_port_map_ace  CRREADY      m_ace_usr_crready         M_ACE_USR     1  
add_port_map_ace  CDDATA       m_ace_usr_cddata          M_ACE_USR     1  
add_port_map_ace  CDLAST       m_ace_usr_cdlast          M_ACE_USR     1  
add_port_map_ace  CDVALID      m_ace_usr_cdvalid         M_ACE_USR     1  
add_port_map_ace  CDREADY      m_ace_usr_cdready         M_ACE_USR     1  

add_port_map_ace  AWID         m_ace_usr_awid            M_LITEACE_USR 1
add_port_map_ace  AWADDR       m_ace_usr_awaddr          M_LITEACE_USR 1
add_port_map_ace  AWLEN        m_ace_usr_awlen           M_LITEACE_USR 1
add_port_map_ace  AWSIZE       m_ace_usr_awsize          M_LITEACE_USR 1
add_port_map_ace  AWBURST      m_ace_usr_awburst         M_LITEACE_USR 1
add_port_map_ace  AWLOCK       m_ace_usr_awlock          M_LITEACE_USR 1
add_port_map_ace  AWCACHE      m_ace_usr_awcache         M_LITEACE_USR 1
add_port_map_ace  AWPROT       m_ace_usr_awprot          M_LITEACE_USR 1
add_port_map_ace  AWQOS        m_ace_usr_awqos           M_LITEACE_USR 1
add_port_map_ace  AWREGION     m_ace_usr_awregion        M_LITEACE_USR 1
add_port_map_ace  AWUSER       m_ace_usr_awuser          M_LITEACE_USR 1
add_port_map_ace  AWVALID      m_ace_usr_awvalid         M_LITEACE_USR 1
add_port_map_ace  AWREADY      m_ace_usr_awready         M_LITEACE_USR 1
add_port_map_ace  WDATA        m_ace_usr_wdata           M_LITEACE_USR 1
add_port_map_ace  WSTRB        m_ace_usr_wstrb           M_LITEACE_USR 1
add_port_map_ace  WLAST        m_ace_usr_wlast           M_LITEACE_USR 1
add_port_map_ace  WUSER        m_ace_usr_wuser           M_LITEACE_USR 1
add_port_map_ace  WVALID       m_ace_usr_wvalid          M_LITEACE_USR 1
add_port_map_ace  WREADY       m_ace_usr_wready          M_LITEACE_USR 1
add_port_map_ace  BID          m_ace_usr_bid             M_LITEACE_USR 1
add_port_map_ace  BRESP        m_ace_usr_bresp           M_LITEACE_USR 1
add_port_map_ace  BUSER        m_ace_usr_buser           M_LITEACE_USR 1
add_port_map_ace  BVALID       m_ace_usr_bvalid          M_LITEACE_USR 1
add_port_map_ace  BREADY       m_ace_usr_bready          M_LITEACE_USR 1
add_port_map_ace  ARID         m_ace_usr_arid            M_LITEACE_USR 1
add_port_map_ace  ARADDR       m_ace_usr_araddr          M_LITEACE_USR 1
add_port_map_ace  ARLEN        m_ace_usr_arlen           M_LITEACE_USR 1
add_port_map_ace  ARSIZE       m_ace_usr_arsize          M_LITEACE_USR 1
add_port_map_ace  ARBURST      m_ace_usr_arburst         M_LITEACE_USR 1
add_port_map_ace  ARLOCK       m_ace_usr_arlock          M_LITEACE_USR 1
add_port_map_ace  ARCACHE      m_ace_usr_arcache         M_LITEACE_USR 1
add_port_map_ace  ARPROT       m_ace_usr_arprot          M_LITEACE_USR 1
add_port_map_ace  ARQOS        m_ace_usr_arqos           M_LITEACE_USR 1
add_port_map_ace  ARREGION     m_ace_usr_arregion        M_LITEACE_USR 1
add_port_map_ace  ARUSER       m_ace_usr_aruser          M_LITEACE_USR 1
add_port_map_ace  ARVALID      m_ace_usr_arvalid         M_LITEACE_USR 1
add_port_map_ace  ARREADY      m_ace_usr_arready         M_LITEACE_USR 1
add_port_map_ace  RID          m_ace_usr_rid             M_LITEACE_USR 1
add_port_map_ace  RDATA        m_ace_usr_rdata           M_LITEACE_USR 1
add_port_map_ace  RRESP        m_ace_usr_rresp           M_LITEACE_USR 1
add_port_map_ace  RLAST        m_ace_usr_rlast           M_LITEACE_USR 1
add_port_map_ace  RUSER        m_ace_usr_ruser           M_LITEACE_USR 1
add_port_map_ace  RVALID       m_ace_usr_rvalid          M_LITEACE_USR 1
add_port_map_ace  RREADY       m_ace_usr_rready          M_LITEACE_USR 1

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

set current_addrspace [::ipx::add_address_space {M_ACE_USR} $::core]
set_property range {16E} $current_addrspace
set_property range_format {long} $current_addrspace
set_property range_resolve_type {dependent} $current_addrspace
set_property width 64 $current_addrspace
set_property width_format {long} $current_addrspace
set_property master_address_space_ref {M_ACE_USR} [::ipx::get_bus_interfaces -of_objects $::core M_ACE_USR]

set current_addrspace [::ipx::add_address_space {M_LITEACE_USR} $::core]
set_property range {16E} $current_addrspace
set_property range_format {long} $current_addrspace
set_property range_resolve_type {dependent} $current_addrspace
set_property width 64 $current_addrspace
set_property width_format {long} $current_addrspace
set_property master_address_space_ref {M_LITEACE_USR} [::ipx::get_bus_interfaces -of_objects $::core M_LITEACE_USR]

# Validate and save core
::ipx::save_core $::core

