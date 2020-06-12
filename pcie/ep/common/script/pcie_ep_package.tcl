# 
# Copyright (c) 2020 Xilinx Inc.
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
  set_property display_name {pcie_ep_v1_00} $::core

  set_property description {PCIe-EP Bridge} $::core

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
  if {[string match "M_AXI*_USR_0" $busif_name]} {    
        if {$enablement == "AXI4"} {
          set_property enablement_dependency {$M_AXI_USR_0_PROTOCOL == "AXI4" && $NUM_MASTER_BRIDGE>=1} [ipx::get_ports $physical_name -of_objects [ipx::current_core]]  
        } elseif {$enablement == "AXI4LITE"} {
          set_property enablement_dependency {$M_AXI_USR_0_PROTOCOL == "AXI4LITE" && $NUM_MASTER_BRIDGE>=1} [ipx::get_ports $physical_name -of_objects [ipx::current_core]]  
        } elseif {$enablement == "AXI3"} {
          set_property enablement_dependency {$M_AXI_USR_0_PROTOCOL == "AXI3" && $NUM_MASTER_BRIDGE>=1} [ipx::get_ports $physical_name -of_objects [ipx::current_core]]  
        } elseif {$enablement == "AXI4_OR_AXI3"} {
          set_property enablement_dependency {$M_AXI_USR_0_PROTOCOL == "AXI4" || $M_AXI_USR_0_PROTOCOL == "AXI3" && $NUM_MASTER_BRIDGE>=1} [ipx::get_ports $physical_name -of_objects [ipx::current_core]]  
        } else {
        }
  } elseif {[string match "M_AXI*_USR_1" $busif_name]} {    
        if {$enablement == "AXI4"} {
          set_property enablement_dependency {$M_AXI_USR_1_PROTOCOL == "AXI4" && $NUM_MASTER_BRIDGE>=2} [ipx::get_ports $physical_name -of_objects [ipx::current_core]]  
        } elseif {$enablement == "AXI4LITE"} {
          set_property enablement_dependency {$M_AXI_USR_1_PROTOCOL == "AXI4LITE" && $NUM_MASTER_BRIDGE>=2} [ipx::get_ports $physical_name -of_objects [ipx::current_core]]  
        } elseif {$enablement == "AXI3"} {
          set_property enablement_dependency {$M_AXI_USR_1_PROTOCOL == "AXI3" && $NUM_MASTER_BRIDGE>=2} [ipx::get_ports $physical_name -of_objects [ipx::current_core]]  
        } elseif {$enablement == "AXI4_OR_AXI3"} {
          set_property enablement_dependency{$M_AXI_USR_1_PROTOCOL == "AXI4" || $M_AXI_USR_1_PROTOCOL == "AXI3" && $NUM_MASTER_BRIDGE>=2} [ipx::get_ports $physical_name -of_objects [ipx::current_core]]  
        } else {
        }
  } elseif {[string match "M_AXI*_USR_2" $busif_name]} {    
        if {$enablement == "AXI4"} {
          set_property enablement_dependency {$M_AXI_USR_2_PROTOCOL == "AXI4" && $NUM_MASTER_BRIDGE>=3} [ipx::get_ports $physical_name -of_objects [ipx::current_core]]  
        } elseif {$enablement == "AXI4LITE"} {
          set_property enablement_dependency {$M_AXI_USR_2_PROTOCOL == "AXI4LITE" && $NUM_MASTER_BRIDGE>=3} [ipx::get_ports $physical_name -of_objects [ipx::current_core]]  
        } elseif {$enablement == "AXI3"} {
          set_property enablement_dependency {$M_AXI_USR_2_PROTOCOL == "AXI3" && $NUM_MASTER_BRIDGE>=3} [ipx::get_ports $physical_name -of_objects [ipx::current_core]]  
        } elseif {$enablement == "AXI4_OR_AXI3"} {
          set_property enablement_dependency {$M_AXI_USR_2_PROTOCOL == "AXI4" || $M_AXI_USR_2_PROTOCOL == "AXI3" && $NUM_MASTER_BRIDGE>=3} [ipx::get_ports $physical_name -of_objects [ipx::current_core]]  
        } else {
        }
  } elseif {[string match "M_AXI*_USR_3" $busif_name]} {    
        if {$enablement == "AXI4"} {
          set_property enablement_dependency {$M_AXI_USR_3_PROTOCOL == "AXI4" && $NUM_MASTER_BRIDGE>=4} [ipx::get_ports $physical_name -of_objects [ipx::current_core]]  
        } elseif {$enablement == "AXI4LITE"} {
          set_property enablement_dependency {$M_AXI_USR_3_PROTOCOL == "AXI4LITE" && $NUM_MASTER_BRIDGE>=4} [ipx::get_ports $physical_name -of_objects [ipx::current_core]]  
        } elseif {$enablement == "AXI3"} {
          set_property enablement_dependency {$M_AXI_USR_3_PROTOCOL == "AXI3" && $NUM_MASTER_BRIDGE>=4} [ipx::get_ports $physical_name -of_objects [ipx::current_core]]  
        } elseif {$enablement == "AXI4_OR_AXI3"} {
          set_property enablement_dependency {$M_AXI_USR_3_PROTOCOL == "AXI4" || $M_AXI_USR_3_PROTOCOL == "AXI3" && $NUM_MASTER_BRIDGE>=4} [ipx::get_ports $physical_name -of_objects [ipx::current_core]]  
        } else {
        }
  } elseif {[string match "M_AXI*_USR_4" $busif_name]} {    
        if {$enablement == "AXI4"} {
          set_property enablement_dependency {$M_AXI_USR_4_PROTOCOL == "AXI4" && $NUM_MASTER_BRIDGE>=5} [ipx::get_ports $physical_name -of_objects [ipx::current_core]]  
        } elseif {$enablement == "AXI4LITE"} {
          set_property enablement_dependency {$M_AXI_USR_4_PROTOCOL == "AXI4LITE" && $NUM_MASTER_BRIDGE>=5} [ipx::get_ports $physical_name -of_objects [ipx::current_core]]  
        } elseif {$enablement == "AXI3"} {
          set_property enablement_dependency {$M_AXI_USR_4_PROTOCOL == "AXI3" && $NUM_MASTER_BRIDGE>=5} [ipx::get_ports $physical_name -of_objects [ipx::current_core]]  
        } elseif {$enablement == "AXI4_OR_AXI3"} {
          set_property enablement_dependency {$M_AXI_USR_4_PROTOCOL == "AXI4" || $M_AXI_USR_4_PROTOCOL == "AXI3" && $NUM_MASTER_BRIDGE>=5} [ipx::get_ports $physical_name -of_objects [ipx::current_core]]  
        } else {
        }
  } elseif {[string match "M_AXI*_USR_5" $busif_name]} {    
        if {$enablement == "AXI4"} {
          set_property enablement_dependency {$M_AXI_USR_5_PROTOCOL == "AXI4" && $NUM_MASTER_BRIDGE>=6} [ipx::get_ports $physical_name -of_objects [ipx::current_core]]  
        } elseif {$enablement == "AXI4LITE"} {
          set_property enablement_dependency {$M_AXI_USR_5_PROTOCOL == "AXI4LITE" && $NUM_MASTER_BRIDGE>=6} [ipx::get_ports $physical_name -of_objects [ipx::current_core]]  
        } elseif {$enablement == "AXI3"} {
          set_property enablement_dependency {$M_AXI_USR_5_PROTOCOL == "AXI3" && $NUM_MASTER_BRIDGE>=6} [ipx::get_ports $physical_name -of_objects [ipx::current_core]]  
        } elseif {$enablement == "AXI4_OR_AXI3"} {
          set_property enablement_dependency {$M_AXI_USR_5_PROTOCOL == "AXI4" || $M_AXI_USR_5_PROTOCOL == "AXI3" && $NUM_MASTER_BRIDGE>=6} [ipx::get_ports $physical_name -of_objects [ipx::current_core]]  
        } else {
        }
  } elseif {[string match "S_AXI*_USR_0" $busif_name]} {    
        if {$enablement == "AXI4"} {
          set_property enablement_dependency {$S_AXI_USR_0_PROTOCOL == "AXI4" && $NUM_SLAVE_BRIDGE>=1} [ipx::get_ports $physical_name -of_objects [ipx::current_core]]  
        } elseif {$enablement == "AXI4LITE"} {
          set_property enablement_dependency {$S_AXI_USR_0_PROTOCOL == "AXI4LITE" && $NUM_SLAVE_BRIDGE>=1} [ipx::get_ports $physical_name -of_objects [ipx::current_core]]  
        } elseif {$enablement == "AXI3"} {
          set_property enablement_dependency {$S_AXI_USR_0_PROTOCOL == "AXI3" && $NUM_SLAVE_BRIDGE>=1} [ipx::get_ports $physical_name -of_objects [ipx::current_core]]  
        } elseif {$enablement == "AXI4_OR_AXI3"} {
          set_property enablement_dependency {$S_AXI_USR_0_PROTOCOL == "AXI4" || $S_AXI_USR_0_PROTOCOL == "AXI3" && $NUM_SLAVE_BRIDGE>=1} [ipx::get_ports $physical_name -of_objects [ipx::current_core]]  
        } else {
        }
  } elseif {[string match "S_AXI*_USR_1" $busif_name]} {    
        if {$enablement == "AXI4"} {
          set_property enablement_dependency {$S_AXI_USR_1_PROTOCOL == "AXI4" && $NUM_SLAVE_BRIDGE>=2} [ipx::get_ports $physical_name -of_objects [ipx::current_core]]  
        } elseif {$enablement == "AXI4LITE"} {
          set_property enablement_dependency {$S_AXI_USR_1_PROTOCOL == "AXI4LITE" && $NUM_SLAVE_BRIDGE>=2} [ipx::get_ports $physical_name -of_objects [ipx::current_core]]  
        } elseif {$enablement == "AXI3"} {
          set_property enablement_dependency {$S_AXI_USR_1_PROTOCOL == "AXI3" && $NUM_SLAVE_BRIDGE>=2} [ipx::get_ports $physical_name -of_objects [ipx::current_core]]  
        } elseif {$enablement == "AXI4_OR_AXI3"} {
          set_property enablement_dependency{$S_AXI_USR_1_PROTOCOL == "AXI4" || $S_AXI_USR_1_PROTOCOL == "AXI3" && $NUM_SLAVE_BRIDGE>=2} [ipx::get_ports $physical_name -of_objects [ipx::current_core]]  
        } else {
        }
  } elseif {[string match "S_AXI*_USR_2" $busif_name]} {    
        if {$enablement == "AXI4"} {
          set_property enablement_dependency {$S_AXI_USR_2_PROTOCOL == "AXI4" && $NUM_SLAVE_BRIDGE>=3} [ipx::get_ports $physical_name -of_objects [ipx::current_core]]  
        } elseif {$enablement == "AXI4LITE"} {
          set_property enablement_dependency {$S_AXI_USR_2_PROTOCOL == "AXI4LITE" && $NUM_SLAVE_BRIDGE>=3} [ipx::get_ports $physical_name -of_objects [ipx::current_core]]  
        } elseif {$enablement == "AXI3"} {
          set_property enablement_dependency {$S_AXI_USR_2_PROTOCOL == "AXI3" && $NUM_SLAVE_BRIDGE>=3} [ipx::get_ports $physical_name -of_objects [ipx::current_core]]  
        } elseif {$enablement == "AXI4_OR_AXI3"} {
          set_property enablement_dependency {$S_AXI_USR_2_PROTOCOL == "AXI4" || $S_AXI_USR_2_PROTOCOL == "AXI3" && $NUM_SLAVE_BRIDGE>=3} [ipx::get_ports $physical_name -of_objects [ipx::current_core]]  
        } else {
        }
  } elseif {[string match "S_AXI*_USR_3" $busif_name]} {    
        if {$enablement == "AXI4"} {
          set_property enablement_dependency {$S_AXI_USR_3_PROTOCOL == "AXI4" && $NUM_SLAVE_BRIDGE>=4} [ipx::get_ports $physical_name -of_objects [ipx::current_core]]  
        } elseif {$enablement == "AXI4LITE"} {
          set_property enablement_dependency {$S_AXI_USR_3_PROTOCOL == "AXI4LITE" && $NUM_SLAVE_BRIDGE>=4} [ipx::get_ports $physical_name -of_objects [ipx::current_core]]  
        } elseif {$enablement == "AXI3"} {
          set_property enablement_dependency {$S_AXI_USR_3_PROTOCOL == "AXI3" && $NUM_SLAVE_BRIDGE>=4} [ipx::get_ports $physical_name -of_objects [ipx::current_core]]  
        } elseif {$enablement == "AXI4_OR_AXI3"} {
          set_property enablement_dependency {$S_AXI_USR_3_PROTOCOL == "AXI4" || $S_AXI_USR_3_PROTOCOL == "AXI3" && $NUM_SLAVE_BRIDGE>=4} [ipx::get_ports $physical_name -of_objects [ipx::current_core]]  
        } else {
        }
  } elseif {[string match "S_AXI*_USR_4" $busif_name]} {    
        if {$enablement == "AXI4"} {
          set_property enablement_dependency {$S_AXI_USR_4_PROTOCOL == "AXI4" && $NUM_SLAVE_BRIDGE>=5} [ipx::get_ports $physical_name -of_objects [ipx::current_core]]  
        } elseif {$enablement == "AXI4LITE"} {
          set_property enablement_dependency {$S_AXI_USR_4_PROTOCOL == "AXI4LITE" && $NUM_SLAVE_BRIDGE>=5} [ipx::get_ports $physical_name -of_objects [ipx::current_core]]  
        } elseif {$enablement == "AXI3"} {
          set_property enablement_dependency {$S_AXI_USR_4_PROTOCOL == "AXI3" && $NUM_SLAVE_BRIDGE>=5} [ipx::get_ports $physical_name -of_objects [ipx::current_core]]  
        } elseif {$enablement == "AXI4_OR_AXI3"} {
          set_property enablement_dependency {$S_AXI_USR_4_PROTOCOL == "AXI4" || $S_AXI_USR_4_PROTOCOL == "AXI3" && $NUM_SLAVE_BRIDGE>=5} [ipx::get_ports $physical_name -of_objects [ipx::current_core]]  
        } else {
        }
  } elseif {[string match "S_AXI*_USR_5" $busif_name]} {    
        if {$enablement == "AXI4"} {
          set_property enablement_dependency {$S_AXI_USR_5_PROTOCOL == "AXI4" && $NUM_SLAVE_BRIDGE>=6} [ipx::get_ports $physical_name -of_objects [ipx::current_core]]  
        } elseif {$enablement == "AXI4LITE"} {
          set_property enablement_dependency {$S_AXI_USR_5_PROTOCOL == "AXI4LITE" && $NUM_SLAVE_BRIDGE>=6} [ipx::get_ports $physical_name -of_objects [ipx::current_core]]  
        } elseif {$enablement == "AXI3"} {
          set_property enablement_dependency {$S_AXI_USR_5_PROTOCOL == "AXI3" && $NUM_SLAVE_BRIDGE>=6} [ipx::get_ports $physical_name -of_objects [ipx::current_core]]  
        } elseif {$enablement == "AXI4_OR_AXI3"} {
          set_property enablement_dependency {$S_AXI_USR_5_PROTOCOL == "AXI4" || $S_AXI_USR_5_PROTOCOL == "AXI3" && $NUM_SLAVE_BRIDGE>=6} [ipx::get_ports $physical_name -of_objects [ipx::current_core]]  
        } else {
        }
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
  #if {$dependency != ""} {
  #  set_property enablement_presence optional [::ipx::get_hdl_parameters -of_objects $::core $name]
  #  set_property enablement_value false [::ipx::get_hdl_parameters -of_objects $::core $name]
  #  set_property enablement_resolve_type "dependent" [::ipx::get_hdl_parameters -of_objects $::core $name]
  #  if {$dependency == "M_0"} {
  #      set_property enablement_dependency {$NUM_MASTER_BRIDGE >= 1} [::ipx::get_hdl_parameters -of_objects $::core $name]  
  #  }
  #  #set_property enablement_dependency $dependency [::ipx::get_hdl_parameters -of_objects $::core $name]
  #}
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
set ::core [::ipx::create_core xilinx.com ip pcie_ep 1.00]
set_property root_directory {.} $::core

# Source files
foreach fg {xilinx_vivadoverilogsynthesis xilinx_vivadoverilogbehavioralsimulation} {
  set current_filegroup [::ipx::add_file_group $fg $::core]
  set_property library_name pcie_ep [::ipx::add_file hdl/verilog/pcie_ep.v $current_filegroup]
  set_property library_name pcie_ep [::ipx::add_file hdl/verilog/defines_common.vh $current_filegroup]
  set_property library_name pcie_ep [::ipx::add_file hdl/verilog/defines_pcie.vh $current_filegroup]
  set_property model_name pcie_ep $current_filegroup
}

set_global_properties

# Customization Parameters
::ipx::remove_all_hdl_parameter $::core
::ipx::add_model_parameters_from_hdl -top_level_hdl_file hdl/verilog/pcie_ep.v -top_module_name pcie_ep $::core

add_param PCIE_EP_LAST_BRIDGE       0      "Is it last bridge in design"  "" LONG                                      
add_param NUM_MASTER_BRIDGE                 1      "Number of Master Bridges"                  "" LONG                      
add_param NUM_SLAVE_BRIDGE                  1      "Number of Slave Bridges"                   "" LONG                     
add_param S_AXI_ADDR_WIDTH                  64     "Slave AXI address width"                   "" LONG                     
add_param M_AXI_ADDR_WIDTH                  64     "Master AXI address width"                  "" LONG                      
add_param USR_RST_NUM                       1      "Number of usr resets"                      "" LONG                  

set_property value_validation_list {32:32 64:64} [::ipx::get_hdl_parameters -of_objects  $::core S_AXI_ADDR_WIDTH]
set_property value_validation_list {32:32 64:64} [::ipx::get_user_parameters -of_objects  $::core S_AXI_ADDR_WIDTH]
ipx::create_xgui_files [ipx::current_core]
ipgui::add_param -name {S_AXI_ADDR_WIDTH} -component [ipx::current_core] -show_label {true} -show_range {true} -widget {}
ipgui::add_param -name {M_AXI_ADDR_WIDTH} -component [ipx::current_core] -show_label {true} -show_range {true} -widget {}
ipgui::add_param -name {PCIE_EP_LAST_BRIDGE} -component [ipx::current_core] -show_label {true} -show_range {true} -widget {}
ipgui::add_param -name {USR_RST_NUM} -component [ipx::current_core] -show_label {true} -show_range {true} -widget {}
ipgui::add_param -name {NUM_MASTER_BRIDGE} -component [ipx::current_core] -show_label {true} -show_range {true} -widget {}
ipgui::add_param -name {NUM_SLAVE_BRIDGE} -component [ipx::current_core] -show_label {true} -show_range {true} -widget {}
set_property widget {comboBox} [ipgui::get_guiparamspec -name "S_AXI_ADDR_WIDTH" -component [ipx::current_core] ]
set_property value_validation_type list [ipx::get_user_parameters S_AXI_ADDR_WIDTH     -of_objects [ipx::current_core]]
ipgui::add_page -name {Basic} -component [ipx::current_core] -display_name {Basic}
ipgui::move_param -component [ipx::current_core] -order 0 [ipgui::get_guiparamspec -name "PCIE_EP_LAST_BRIDGE" -component [ipx::current_core]] -parent [ipgui::get_pagespec -name "Basic" -component [ipx::current_core]]
ipgui::move_param -component [ipx::current_core] -order 1 [ipgui::get_guiparamspec -name "NUM_MASTER_BRIDGE" -component [ipx::current_core]] -parent [ipgui::get_pagespec -name "Basic" -component [ipx::current_core]]
ipgui::move_param -component [ipx::current_core] -order 2 [ipgui::get_guiparamspec -name "NUM_SLAVE_BRIDGE" -component [ipx::current_core]] -parent [ipgui::get_pagespec -name "Basic" -component [ipx::current_core]]
ipgui::move_param -component [ipx::current_core] -order 3 [ipgui::get_guiparamspec -name "S_AXI_ADDR_WIDTH" -component [ipx::current_core]] -parent [ipgui::get_pagespec -name "Basic" -component [ipx::current_core]]
ipgui::move_param -component [ipx::current_core] -order 4 [ipgui::get_guiparamspec -name "M_AXI_ADDR_WIDTH" -component [ipx::current_core]] -parent [ipgui::get_pagespec -name "Basic" -component [ipx::current_core]]
ipgui::move_param -component [ipx::current_core] -order 5 [ipgui::get_guiparamspec -name "USR_RST_NUM" -component [ipx::current_core]] -parent [ipgui::get_pagespec -name "Basic" -component [ipx::current_core]]



add_param M_AXI_USR_0_PROTOCOL              AXI4   "Usr Master-0 AXI Protocol"                "M_0" STRING                        
add_param M_AXI_USR_0_ADDR_WIDTH            64     "Usr Master-0 AXI address width"           "" LONG                             
add_param M_AXI_USR_0_DATA_WIDTH            128    "Usr Master-0 AXI data idth"               "" LONG                         
add_param M_AXI_USR_0_ID_WIDTH              16     "Usr Master-0 AXI ID width"                "" LONG                        
add_param M_AXI_USR_0_AWUSER_WIDTH          32     "Usr Master-0 AXI AWuser width"            "" LONG                            
add_param M_AXI_USR_0_WUSER_WIDTH           32     "Usr Master-0 AXI Wuser width"             "" LONG                           
add_param M_AXI_USR_0_BUSER_WIDTH           32     "Usr Master-0 AXI Buser width"             "" LONG                           
add_param M_AXI_USR_0_ARUSER_WIDTH          32     "Usr Master-0 AXI ARuser width"            "" LONG                            
add_param M_AXI_USR_0_RUSER_WIDTH           32     "Usr Master-0 AXI Ruser width"             "" LONG                           

ipgui::add_param -name {M_AXI_USR_0_PROTOCOL} -component [ipx::current_core] -show_label {true} -show_range {true} -widget {}
ipgui::add_param -name {M_AXI_USR_0_ADDR_WIDTH} -component [ipx::current_core] -show_label {true} -show_range {true} -widget {}
ipgui::add_param -name {M_AXI_USR_0_DATA_WIDTH} -component [ipx::current_core] -show_label {true} -show_range {true} -widget {}
ipgui::add_param -name {M_AXI_USR_0_ID_WIDTH} -component [ipx::current_core] -show_label {true} -show_range {true} -widget {}
ipgui::add_param -name {M_AXI_USR_0_AWUSER_WIDTH} -component [ipx::current_core] -show_label {true} -show_range {true} -widget {}
ipgui::add_param -name {M_AXI_USR_0_ARUSER_WIDTH} -component [ipx::current_core] -show_label {true} -show_range {true} -widget {}
ipgui::add_param -name {M_AXI_USR_0_WUSER_WIDTH} -component [ipx::current_core] -show_label {true} -show_range {true} -widget {}
ipgui::add_param -name {M_AXI_USR_0_BUSER_WIDTH} -component [ipx::current_core] -show_label {true} -show_range {true} -widget {}
ipgui::add_param -name {M_AXI_USR_0_RUSER_WIDTH} -component [ipx::current_core] -show_label {true} -show_range {true} -widget {}
set_property widget {comboBox} [ipgui::get_guiparamspec -name "M_AXI_USR_0_PROTOCOL" -component [ipx::current_core] ]
set_property widget {comboBox} [ipgui::get_guiparamspec -name "M_AXI_USR_0_DATA_WIDTH" -component [ipx::current_core] ]
set_property value_validation_type pairs [ipx::get_user_parameters M_AXI_USR_0_PROTOCOL -of_objects [ipx::current_core]]
set_property value_validation_pairs {AXI4 AXI4 AXI4LITE AXI4LITE} [ipx::get_user_parameters M_AXI_USR_0_PROTOCOL -of_objects [ipx::current_core]]
set_property widget {textEdit} [ipgui::get_guiparamspec -name "M_AXI_USR_0_ADDR_WIDTH" -component [ipx::current_core] ]
set_property value_validation_range_minimum 4 [ipx::get_user_parameters M_AXI_USR_0_ADDR_WIDTH -of_objects [ipx::current_core]]
set_property value_validation_range_maximum 64 [ipx::get_user_parameters M_AXI_USR_0_ADDR_WIDTH -of_objects [ipx::current_core]]
set_property value_validation_list {32:32 64:64 128:128} [::ipx::get_user_parameters -of_objects  $::core M_AXI_USR_0_DATA_WIDTH]
set_property value_validation_list {32:32 64:64 128:128} [::ipx::get_hdl_parameters -of_objects  $::core M_AXI_USR_0_DATA_WIDTH]
set_property value_validation_type list [ipx::get_user_parameters M_AXI_USR_0_DATA_WIDTH -of_objects [ipx::current_core]]
set_property widget {textEdit} [ipgui::get_guiparamspec -name "M_AXI_USR_0_ID_WIDTH" -component [ipx::current_core] ]
set_property value_validation_range_minimum 1 [ipx::get_user_parameters M_AXI_USR_0_ID_WIDTH -of_objects [ipx::current_core]]
set_property value_validation_range_maximum 16 [ipx::get_user_parameters M_AXI_USR_0_ID_WIDTH -of_objects [ipx::current_core]]
set_property widget {textEdit} [ipgui::get_guiparamspec -name "M_AXI_USR_0_AWUSER_WIDTH" -component [ipx::current_core] ]
set_property value_validation_range_minimum 1 [ipx::get_user_parameters M_AXI_USR_0_AWUSER_WIDTH -of_objects [ipx::current_core]]
set_property value_validation_range_maximum 32 [ipx::get_user_parameters M_AXI_USR_0_AWUSER_WIDTH -of_objects [ipx::current_core]]
set_property widget {textEdit} [ipgui::get_guiparamspec -name "M_AXI_USR_0_ARUSER_WIDTH" -component [ipx::current_core] ]
set_property value_validation_range_minimum 1 [ipx::get_user_parameters M_AXI_USR_0_ARUSER_WIDTH -of_objects [ipx::current_core]]
set_property value_validation_range_maximum 32 [ipx::get_user_parameters M_AXI_USR_0_ARUSER_WIDTH -of_objects [ipx::current_core]]
set_property widget {textEdit} [ipgui::get_guiparamspec -name "M_AXI_USR_0_WUSER_WIDTH" -component [ipx::current_core] ]
set_property value_validation_range_minimum 1 [ipx::get_user_parameters M_AXI_USR_0_WUSER_WIDTH -of_objects [ipx::current_core]]
set_property value_validation_range_maximum 32 [ipx::get_user_parameters M_AXI_USR_0_WUSER_WIDTH -of_objects [ipx::current_core]]
set_property widget {textEdit} [ipgui::get_guiparamspec -name "M_AXI_USR_0_BUSER_WIDTH" -component [ipx::current_core] ]
set_property value_validation_range_minimum 1 [ipx::get_user_parameters M_AXI_USR_0_BUSER_WIDTH -of_objects [ipx::current_core]]
set_property value_validation_range_maximum 32 [ipx::get_user_parameters M_AXI_USR_0_BUSER_WIDTH -of_objects [ipx::current_core]]
set_property widget {textEdit} [ipgui::get_guiparamspec -name "M_AXI_USR_0_RUSER_WIDTH" -component [ipx::current_core] ]
set_property value_validation_range_minimum 1 [ipx::get_user_parameters M_AXI_USR_0_RUSER_WIDTH -of_objects [ipx::current_core]]
set_property value_validation_range_maximum 32 [ipx::get_user_parameters M_AXI_USR_0_RUSER_WIDTH -of_objects [ipx::current_core]]
ipgui::add_page -name {Master_Usr_0} -component [ipx::current_core] -display_name {Master_Usr_0}
ipgui::move_param -component [ipx::current_core] -order 0 [ipgui::get_guiparamspec -name "M_AXI_USR_0_PROTOCOL" -component [ipx::current_core]] -parent [ipgui::get_pagespec -name "Master_Usr_0" -component [ipx::current_core]]
ipgui::move_param -component [ipx::current_core] -order 1 [ipgui::get_guiparamspec -name "M_AXI_USR_0_ADDR_WIDTH" -component [ipx::current_core]] -parent [ipgui::get_pagespec -name "Master_Usr_0" -component [ipx::current_core]]
ipgui::move_param -component [ipx::current_core] -order 2 [ipgui::get_guiparamspec -name "M_AXI_USR_0_DATA_WIDTH" -component [ipx::current_core]] -parent [ipgui::get_pagespec -name "Master_Usr_0" -component [ipx::current_core]]
ipgui::move_param -component [ipx::current_core] -order 3 [ipgui::get_guiparamspec -name "M_AXI_USR_0_ID_WIDTH" -component [ipx::current_core]] -parent [ipgui::get_pagespec -name "Master_Usr_0" -component [ipx::current_core]]
ipgui::move_param -component [ipx::current_core] -order 4 [ipgui::get_guiparamspec -name "M_AXI_USR_0_AWUSER_WIDTH" -component [ipx::current_core]] -parent [ipgui::get_pagespec -name "Master_Usr_0" -component [ipx::current_core]]
ipgui::move_param -component [ipx::current_core] -order 5 [ipgui::get_guiparamspec -name "M_AXI_USR_0_WUSER_WIDTH" -component [ipx::current_core]] -parent [ipgui::get_pagespec -name "Master_Usr_0" -component [ipx::current_core]]
ipgui::move_param -component [ipx::current_core] -order 6 [ipgui::get_guiparamspec -name "M_AXI_USR_0_BUSER_WIDTH" -component [ipx::current_core]] -parent [ipgui::get_pagespec -name "Master_Usr_0" -component [ipx::current_core]]
ipgui::move_param -component [ipx::current_core] -order 7 [ipgui::get_guiparamspec -name "M_AXI_USR_0_ARUSER_WIDTH" -component [ipx::current_core]] -parent [ipgui::get_pagespec -name "Master_Usr_0" -component [ipx::current_core]]
ipgui::move_param -component [ipx::current_core] -order 8 [ipgui::get_guiparamspec -name "M_AXI_USR_0_RUSER_WIDTH" -component [ipx::current_core]] -parent [ipgui::get_pagespec -name "Master_Usr_0" -component [ipx::current_core]]
set_property enablement_tcl_expr {$NUM_MASTER_BRIDGE >= 1} [ipx::get_user_parameters M_AXI_USR_0_PROTOCOL     -of_objects [ipx::current_core]]
set_property enablement_tcl_expr {$NUM_MASTER_BRIDGE >= 1} [ipx::get_user_parameters M_AXI_USR_0_ADDR_WIDTH   -of_objects [ipx::current_core]]
set_property enablement_tcl_expr {$NUM_MASTER_BRIDGE >= 1} [ipx::get_user_parameters M_AXI_USR_0_DATA_WIDTH   -of_objects [ipx::current_core]]
set_property enablement_tcl_expr {$NUM_MASTER_BRIDGE >= 1} [ipx::get_user_parameters M_AXI_USR_0_ID_WIDTH     -of_objects [ipx::current_core]]
set_property enablement_tcl_expr {$NUM_MASTER_BRIDGE >= 1} [ipx::get_user_parameters M_AXI_USR_0_AWUSER_WIDTH -of_objects [ipx::current_core]]
set_property enablement_tcl_expr {$NUM_MASTER_BRIDGE >= 1} [ipx::get_user_parameters M_AXI_USR_0_WUSER_WIDTH  -of_objects [ipx::current_core]]
set_property enablement_tcl_expr {$NUM_MASTER_BRIDGE >= 1} [ipx::get_user_parameters M_AXI_USR_0_BUSER_WIDTH  -of_objects [ipx::current_core]]
set_property enablement_tcl_expr {$NUM_MASTER_BRIDGE >= 1} [ipx::get_user_parameters M_AXI_USR_0_ARUSER_WIDTH -of_objects [ipx::current_core]]
set_property enablement_tcl_expr {$NUM_MASTER_BRIDGE >= 1} [ipx::get_user_parameters M_AXI_USR_0_RUSER_WIDTH  -of_objects [ipx::current_core]]




add_param M_AXI_USR_1_PROTOCOL              AXI4   "Usr Master-1 AXI Protocol"                "M_1" STRING                        
add_param M_AXI_USR_1_ADDR_WIDTH            64     "Usr Master-1 AXI address width"           "" LONG                             
add_param M_AXI_USR_1_DATA_WIDTH            128    "Usr Master-1 AXI data idth"               "" LONG                         
add_param M_AXI_USR_1_ID_WIDTH              16     "Usr Master-1 AXI ID width"                "" LONG                        
add_param M_AXI_USR_1_AWUSER_WIDTH          32     "Usr Master-1 AXI AWuser width"            "" LONG                            
add_param M_AXI_USR_1_WUSER_WIDTH           32     "Usr Master-1 AXI Wuser width"             "" LONG                           
add_param M_AXI_USR_1_BUSER_WIDTH           32     "Usr Master-1 AXI Buser width"             "" LONG                           
add_param M_AXI_USR_1_ARUSER_WIDTH          32     "Usr Master-1 AXI ARuser width"            "" LONG                            
add_param M_AXI_USR_1_RUSER_WIDTH           32     "Usr Master-1 AXI Ruser width"             "" LONG                           

ipgui::add_param -name {M_AXI_USR_1_PROTOCOL} -component [ipx::current_core] -show_label {true} -show_range {true} -widget {}
ipgui::add_param -name {M_AXI_USR_1_ADDR_WIDTH} -component [ipx::current_core] -show_label {true} -show_range {true} -widget {}
ipgui::add_param -name {M_AXI_USR_1_DATA_WIDTH} -component [ipx::current_core] -show_label {true} -show_range {true} -widget {}
ipgui::add_param -name {M_AXI_USR_1_ID_WIDTH} -component [ipx::current_core] -show_label {true} -show_range {true} -widget {}
ipgui::add_param -name {M_AXI_USR_1_AWUSER_WIDTH} -component [ipx::current_core] -show_label {true} -show_range {true} -widget {}
ipgui::add_param -name {M_AXI_USR_1_ARUSER_WIDTH} -component [ipx::current_core] -show_label {true} -show_range {true} -widget {}
ipgui::add_param -name {M_AXI_USR_1_WUSER_WIDTH} -component [ipx::current_core] -show_label {true} -show_range {true} -widget {}
ipgui::add_param -name {M_AXI_USR_1_BUSER_WIDTH} -component [ipx::current_core] -show_label {true} -show_range {true} -widget {}
ipgui::add_param -name {M_AXI_USR_1_RUSER_WIDTH} -component [ipx::current_core] -show_label {true} -show_range {true} -widget {}
set_property widget {comboBox} [ipgui::get_guiparamspec -name "M_AXI_USR_1_PROTOCOL" -component [ipx::current_core] ]
set_property widget {comboBox} [ipgui::get_guiparamspec -name "M_AXI_USR_1_DATA_WIDTH" -component [ipx::current_core] ]
set_property value_validation_type pairs [ipx::get_user_parameters M_AXI_USR_1_PROTOCOL -of_objects [ipx::current_core]]
set_property value_validation_pairs {AXI4 AXI4 AXI4LITE AXI4LITE} [ipx::get_user_parameters M_AXI_USR_1_PROTOCOL -of_objects [ipx::current_core]]
set_property widget {textEdit} [ipgui::get_guiparamspec -name "M_AXI_USR_1_ADDR_WIDTH" -component [ipx::current_core] ]
set_property value_validation_range_minimum 4 [ipx::get_user_parameters M_AXI_USR_1_ADDR_WIDTH -of_objects [ipx::current_core]]
set_property value_validation_range_maximum 64 [ipx::get_user_parameters M_AXI_USR_1_ADDR_WIDTH -of_objects [ipx::current_core]]
set_property value_validation_list {32:32 64:64 128:128} [::ipx::get_user_parameters -of_objects  $::core M_AXI_USR_1_DATA_WIDTH]
set_property value_validation_list {32:32 64:64 128:128} [::ipx::get_hdl_parameters -of_objects  $::core M_AXI_USR_1_DATA_WIDTH]
set_property value_validation_type list [ipx::get_user_parameters M_AXI_USR_1_DATA_WIDTH -of_objects [ipx::current_core]]
set_property widget {textEdit} [ipgui::get_guiparamspec -name "M_AXI_USR_1_ID_WIDTH" -component [ipx::current_core] ]
set_property value_validation_range_minimum 1 [ipx::get_user_parameters M_AXI_USR_1_ID_WIDTH -of_objects [ipx::current_core]]
set_property value_validation_range_maximum 16 [ipx::get_user_parameters M_AXI_USR_1_ID_WIDTH -of_objects [ipx::current_core]]
set_property widget {textEdit} [ipgui::get_guiparamspec -name "M_AXI_USR_1_AWUSER_WIDTH" -component [ipx::current_core] ]
set_property value_validation_range_minimum 1 [ipx::get_user_parameters M_AXI_USR_1_AWUSER_WIDTH -of_objects [ipx::current_core]]
set_property value_validation_range_maximum 32 [ipx::get_user_parameters M_AXI_USR_1_AWUSER_WIDTH -of_objects [ipx::current_core]]
set_property widget {textEdit} [ipgui::get_guiparamspec -name "M_AXI_USR_1_ARUSER_WIDTH" -component [ipx::current_core] ]
set_property value_validation_range_minimum 1 [ipx::get_user_parameters M_AXI_USR_1_ARUSER_WIDTH -of_objects [ipx::current_core]]
set_property value_validation_range_maximum 32 [ipx::get_user_parameters M_AXI_USR_1_ARUSER_WIDTH -of_objects [ipx::current_core]]
set_property widget {textEdit} [ipgui::get_guiparamspec -name "M_AXI_USR_1_WUSER_WIDTH" -component [ipx::current_core] ]
set_property value_validation_range_minimum 1 [ipx::get_user_parameters M_AXI_USR_1_WUSER_WIDTH -of_objects [ipx::current_core]]
set_property value_validation_range_maximum 32 [ipx::get_user_parameters M_AXI_USR_1_WUSER_WIDTH -of_objects [ipx::current_core]]
set_property widget {textEdit} [ipgui::get_guiparamspec -name "M_AXI_USR_1_BUSER_WIDTH" -component [ipx::current_core] ]
set_property value_validation_range_minimum 1 [ipx::get_user_parameters M_AXI_USR_1_BUSER_WIDTH -of_objects [ipx::current_core]]
set_property value_validation_range_maximum 32 [ipx::get_user_parameters M_AXI_USR_1_BUSER_WIDTH -of_objects [ipx::current_core]]
set_property widget {textEdit} [ipgui::get_guiparamspec -name "M_AXI_USR_1_RUSER_WIDTH" -component [ipx::current_core] ]
set_property value_validation_range_minimum 1 [ipx::get_user_parameters M_AXI_USR_1_RUSER_WIDTH -of_objects [ipx::current_core]]
set_property value_validation_range_maximum 32 [ipx::get_user_parameters M_AXI_USR_1_RUSER_WIDTH -of_objects [ipx::current_core]]
ipgui::add_page -name {Master_Usr_1} -component [ipx::current_core] -display_name {Master_Usr_1}
ipgui::move_param -component [ipx::current_core] -order 0 [ipgui::get_guiparamspec -name "M_AXI_USR_1_PROTOCOL" -component [ipx::current_core]] -parent [ipgui::get_pagespec -name "Master_Usr_1" -component [ipx::current_core]]
ipgui::move_param -component [ipx::current_core] -order 1 [ipgui::get_guiparamspec -name "M_AXI_USR_1_ADDR_WIDTH" -component [ipx::current_core]] -parent [ipgui::get_pagespec -name "Master_Usr_1" -component [ipx::current_core]]
ipgui::move_param -component [ipx::current_core] -order 2 [ipgui::get_guiparamspec -name "M_AXI_USR_1_DATA_WIDTH" -component [ipx::current_core]] -parent [ipgui::get_pagespec -name "Master_Usr_1" -component [ipx::current_core]]
ipgui::move_param -component [ipx::current_core] -order 3 [ipgui::get_guiparamspec -name "M_AXI_USR_1_ID_WIDTH" -component [ipx::current_core]] -parent [ipgui::get_pagespec -name "Master_Usr_1" -component [ipx::current_core]]
ipgui::move_param -component [ipx::current_core] -order 4 [ipgui::get_guiparamspec -name "M_AXI_USR_1_AWUSER_WIDTH" -component [ipx::current_core]] -parent [ipgui::get_pagespec -name "Master_Usr_1" -component [ipx::current_core]]
ipgui::move_param -component [ipx::current_core] -order 5 [ipgui::get_guiparamspec -name "M_AXI_USR_1_WUSER_WIDTH" -component [ipx::current_core]] -parent [ipgui::get_pagespec -name "Master_Usr_1" -component [ipx::current_core]]
ipgui::move_param -component [ipx::current_core] -order 6 [ipgui::get_guiparamspec -name "M_AXI_USR_1_BUSER_WIDTH" -component [ipx::current_core]] -parent [ipgui::get_pagespec -name "Master_Usr_1" -component [ipx::current_core]]
ipgui::move_param -component [ipx::current_core] -order 7 [ipgui::get_guiparamspec -name "M_AXI_USR_1_ARUSER_WIDTH" -component [ipx::current_core]] -parent [ipgui::get_pagespec -name "Master_Usr_1" -component [ipx::current_core]]
ipgui::move_param -component [ipx::current_core] -order 8 [ipgui::get_guiparamspec -name "M_AXI_USR_1_RUSER_WIDTH" -component [ipx::current_core]] -parent [ipgui::get_pagespec -name "Master_Usr_1" -component [ipx::current_core]]
set_property enablement_tcl_expr {$NUM_MASTER_BRIDGE >= 2} [ipx::get_user_parameters M_AXI_USR_1_PROTOCOL     -of_objects [ipx::current_core]]
set_property enablement_tcl_expr {$NUM_MASTER_BRIDGE >= 2} [ipx::get_user_parameters M_AXI_USR_1_ADDR_WIDTH   -of_objects [ipx::current_core]]
set_property enablement_tcl_expr {$NUM_MASTER_BRIDGE >= 2} [ipx::get_user_parameters M_AXI_USR_1_DATA_WIDTH   -of_objects [ipx::current_core]]
set_property enablement_tcl_expr {$NUM_MASTER_BRIDGE >= 2} [ipx::get_user_parameters M_AXI_USR_1_ID_WIDTH     -of_objects [ipx::current_core]]
set_property enablement_tcl_expr {$NUM_MASTER_BRIDGE >= 2} [ipx::get_user_parameters M_AXI_USR_1_AWUSER_WIDTH -of_objects [ipx::current_core]]
set_property enablement_tcl_expr {$NUM_MASTER_BRIDGE >= 2} [ipx::get_user_parameters M_AXI_USR_1_WUSER_WIDTH  -of_objects [ipx::current_core]]
set_property enablement_tcl_expr {$NUM_MASTER_BRIDGE >= 2} [ipx::get_user_parameters M_AXI_USR_1_BUSER_WIDTH  -of_objects [ipx::current_core]]
set_property enablement_tcl_expr {$NUM_MASTER_BRIDGE >= 2} [ipx::get_user_parameters M_AXI_USR_1_ARUSER_WIDTH -of_objects [ipx::current_core]]
set_property enablement_tcl_expr {$NUM_MASTER_BRIDGE >= 2} [ipx::get_user_parameters M_AXI_USR_1_RUSER_WIDTH  -of_objects [ipx::current_core]]



add_param M_AXI_USR_2_PROTOCOL              AXI4   "Usr Master-2 AXI Protocol"                "M_2" STRING                        
add_param M_AXI_USR_2_ADDR_WIDTH            64     "Usr Master-2 AXI address width"           "" LONG                             
add_param M_AXI_USR_2_DATA_WIDTH            128    "Usr Master-2 AXI data idth"               "" LONG                         
add_param M_AXI_USR_2_ID_WIDTH              16     "Usr Master-2 AXI ID width"                "" LONG                        
add_param M_AXI_USR_2_AWUSER_WIDTH          32     "Usr Master-2 AXI AWuser width"            "" LONG                            
add_param M_AXI_USR_2_WUSER_WIDTH           32     "Usr Master-2 AXI Wuser width"             "" LONG                           
add_param M_AXI_USR_2_BUSER_WIDTH           32     "Usr Master-2 AXI Buser width"             "" LONG                           
add_param M_AXI_USR_2_ARUSER_WIDTH          32     "Usr Master-2 AXI ARuser width"            "" LONG                            
add_param M_AXI_USR_2_RUSER_WIDTH           32     "Usr Master-2 AXI Ruser width"             "" LONG                           

ipgui::add_param -name {M_AXI_USR_2_PROTOCOL} -component [ipx::current_core] -show_label {true} -show_range {true} -widget {}
ipgui::add_param -name {M_AXI_USR_2_ADDR_WIDTH} -component [ipx::current_core] -show_label {true} -show_range {true} -widget {}
ipgui::add_param -name {M_AXI_USR_2_DATA_WIDTH} -component [ipx::current_core] -show_label {true} -show_range {true} -widget {}
ipgui::add_param -name {M_AXI_USR_2_ID_WIDTH} -component [ipx::current_core] -show_label {true} -show_range {true} -widget {}
ipgui::add_param -name {M_AXI_USR_2_AWUSER_WIDTH} -component [ipx::current_core] -show_label {true} -show_range {true} -widget {}
ipgui::add_param -name {M_AXI_USR_2_ARUSER_WIDTH} -component [ipx::current_core] -show_label {true} -show_range {true} -widget {}
ipgui::add_param -name {M_AXI_USR_2_WUSER_WIDTH} -component [ipx::current_core] -show_label {true} -show_range {true} -widget {}
ipgui::add_param -name {M_AXI_USR_2_BUSER_WIDTH} -component [ipx::current_core] -show_label {true} -show_range {true} -widget {}
ipgui::add_param -name {M_AXI_USR_2_RUSER_WIDTH} -component [ipx::current_core] -show_label {true} -show_range {true} -widget {}
set_property widget {comboBox} [ipgui::get_guiparamspec -name "M_AXI_USR_2_PROTOCOL" -component [ipx::current_core] ]
set_property widget {comboBox} [ipgui::get_guiparamspec -name "M_AXI_USR_2_DATA_WIDTH" -component [ipx::current_core] ]
set_property value_validation_type pairs [ipx::get_user_parameters M_AXI_USR_2_PROTOCOL -of_objects [ipx::current_core]]
set_property value_validation_pairs {AXI4 AXI4 AXI4LITE AXI4LITE} [ipx::get_user_parameters M_AXI_USR_2_PROTOCOL -of_objects [ipx::current_core]]
set_property widget {textEdit} [ipgui::get_guiparamspec -name "M_AXI_USR_2_ADDR_WIDTH" -component [ipx::current_core] ]
set_property value_validation_range_minimum 4 [ipx::get_user_parameters M_AXI_USR_2_ADDR_WIDTH -of_objects [ipx::current_core]]
set_property value_validation_range_maximum 64 [ipx::get_user_parameters M_AXI_USR_2_ADDR_WIDTH -of_objects [ipx::current_core]]
set_property value_validation_list {32:32 64:64 128:128} [::ipx::get_user_parameters -of_objects  $::core M_AXI_USR_2_DATA_WIDTH]
set_property value_validation_list {32:32 64:64 128:128} [::ipx::get_hdl_parameters -of_objects  $::core M_AXI_USR_2_DATA_WIDTH]
set_property value_validation_type list [ipx::get_user_parameters M_AXI_USR_2_DATA_WIDTH -of_objects [ipx::current_core]]
set_property widget {textEdit} [ipgui::get_guiparamspec -name "M_AXI_USR_2_ID_WIDTH" -component [ipx::current_core] ]
set_property value_validation_range_minimum 1 [ipx::get_user_parameters M_AXI_USR_2_ID_WIDTH -of_objects [ipx::current_core]]
set_property value_validation_range_maximum 16 [ipx::get_user_parameters M_AXI_USR_2_ID_WIDTH -of_objects [ipx::current_core]]
set_property widget {textEdit} [ipgui::get_guiparamspec -name "M_AXI_USR_2_AWUSER_WIDTH" -component [ipx::current_core] ]
set_property value_validation_range_minimum 1 [ipx::get_user_parameters M_AXI_USR_2_AWUSER_WIDTH -of_objects [ipx::current_core]]
set_property value_validation_range_maximum 32 [ipx::get_user_parameters M_AXI_USR_2_AWUSER_WIDTH -of_objects [ipx::current_core]]
set_property widget {textEdit} [ipgui::get_guiparamspec -name "M_AXI_USR_2_ARUSER_WIDTH" -component [ipx::current_core] ]
set_property value_validation_range_minimum 1 [ipx::get_user_parameters M_AXI_USR_2_ARUSER_WIDTH -of_objects [ipx::current_core]]
set_property value_validation_range_maximum 32 [ipx::get_user_parameters M_AXI_USR_2_ARUSER_WIDTH -of_objects [ipx::current_core]]
set_property widget {textEdit} [ipgui::get_guiparamspec -name "M_AXI_USR_2_WUSER_WIDTH" -component [ipx::current_core] ]
set_property value_validation_range_minimum 1 [ipx::get_user_parameters M_AXI_USR_2_WUSER_WIDTH -of_objects [ipx::current_core]]
set_property value_validation_range_maximum 32 [ipx::get_user_parameters M_AXI_USR_2_WUSER_WIDTH -of_objects [ipx::current_core]]
set_property widget {textEdit} [ipgui::get_guiparamspec -name "M_AXI_USR_2_BUSER_WIDTH" -component [ipx::current_core] ]
set_property value_validation_range_minimum 1 [ipx::get_user_parameters M_AXI_USR_2_BUSER_WIDTH -of_objects [ipx::current_core]]
set_property value_validation_range_maximum 32 [ipx::get_user_parameters M_AXI_USR_2_BUSER_WIDTH -of_objects [ipx::current_core]]
set_property widget {textEdit} [ipgui::get_guiparamspec -name "M_AXI_USR_2_RUSER_WIDTH" -component [ipx::current_core] ]
set_property value_validation_range_minimum 1 [ipx::get_user_parameters M_AXI_USR_2_RUSER_WIDTH -of_objects [ipx::current_core]]
set_property value_validation_range_maximum 32 [ipx::get_user_parameters M_AXI_USR_2_RUSER_WIDTH -of_objects [ipx::current_core]]
ipgui::add_page -name {Master_Usr_2} -component [ipx::current_core] -display_name {Master_Usr_2}
ipgui::move_param -component [ipx::current_core] -order 0 [ipgui::get_guiparamspec -name "M_AXI_USR_2_PROTOCOL" -component [ipx::current_core]] -parent [ipgui::get_pagespec -name "Master_Usr_2" -component [ipx::current_core]]
ipgui::move_param -component [ipx::current_core] -order 1 [ipgui::get_guiparamspec -name "M_AXI_USR_2_ADDR_WIDTH" -component [ipx::current_core]] -parent [ipgui::get_pagespec -name "Master_Usr_2" -component [ipx::current_core]]
ipgui::move_param -component [ipx::current_core] -order 2 [ipgui::get_guiparamspec -name "M_AXI_USR_2_DATA_WIDTH" -component [ipx::current_core]] -parent [ipgui::get_pagespec -name "Master_Usr_2" -component [ipx::current_core]]
ipgui::move_param -component [ipx::current_core] -order 3 [ipgui::get_guiparamspec -name "M_AXI_USR_2_ID_WIDTH" -component [ipx::current_core]] -parent [ipgui::get_pagespec -name "Master_Usr_2" -component [ipx::current_core]]
ipgui::move_param -component [ipx::current_core] -order 4 [ipgui::get_guiparamspec -name "M_AXI_USR_2_AWUSER_WIDTH" -component [ipx::current_core]] -parent [ipgui::get_pagespec -name "Master_Usr_2" -component [ipx::current_core]]
ipgui::move_param -component [ipx::current_core] -order 5 [ipgui::get_guiparamspec -name "M_AXI_USR_2_WUSER_WIDTH" -component [ipx::current_core]] -parent [ipgui::get_pagespec -name "Master_Usr_2" -component [ipx::current_core]]
ipgui::move_param -component [ipx::current_core] -order 6 [ipgui::get_guiparamspec -name "M_AXI_USR_2_BUSER_WIDTH" -component [ipx::current_core]] -parent [ipgui::get_pagespec -name "Master_Usr_2" -component [ipx::current_core]]
ipgui::move_param -component [ipx::current_core] -order 7 [ipgui::get_guiparamspec -name "M_AXI_USR_2_ARUSER_WIDTH" -component [ipx::current_core]] -parent [ipgui::get_pagespec -name "Master_Usr_2" -component [ipx::current_core]]
ipgui::move_param -component [ipx::current_core] -order 8 [ipgui::get_guiparamspec -name "M_AXI_USR_2_RUSER_WIDTH" -component [ipx::current_core]] -parent [ipgui::get_pagespec -name "Master_Usr_2" -component [ipx::current_core]]
set_property enablement_tcl_expr {$NUM_MASTER_BRIDGE >= 3} [ipx::get_user_parameters M_AXI_USR_2_PROTOCOL     -of_objects [ipx::current_core]]
set_property enablement_tcl_expr {$NUM_MASTER_BRIDGE >= 3} [ipx::get_user_parameters M_AXI_USR_2_ADDR_WIDTH   -of_objects [ipx::current_core]]
set_property enablement_tcl_expr {$NUM_MASTER_BRIDGE >= 3} [ipx::get_user_parameters M_AXI_USR_2_DATA_WIDTH   -of_objects [ipx::current_core]]
set_property enablement_tcl_expr {$NUM_MASTER_BRIDGE >= 3} [ipx::get_user_parameters M_AXI_USR_2_ID_WIDTH     -of_objects [ipx::current_core]]
set_property enablement_tcl_expr {$NUM_MASTER_BRIDGE >= 3} [ipx::get_user_parameters M_AXI_USR_2_AWUSER_WIDTH -of_objects [ipx::current_core]]
set_property enablement_tcl_expr {$NUM_MASTER_BRIDGE >= 3} [ipx::get_user_parameters M_AXI_USR_2_WUSER_WIDTH  -of_objects [ipx::current_core]]
set_property enablement_tcl_expr {$NUM_MASTER_BRIDGE >= 3} [ipx::get_user_parameters M_AXI_USR_2_BUSER_WIDTH  -of_objects [ipx::current_core]]
set_property enablement_tcl_expr {$NUM_MASTER_BRIDGE >= 3} [ipx::get_user_parameters M_AXI_USR_2_ARUSER_WIDTH -of_objects [ipx::current_core]]
set_property enablement_tcl_expr {$NUM_MASTER_BRIDGE >= 3} [ipx::get_user_parameters M_AXI_USR_2_RUSER_WIDTH  -of_objects [ipx::current_core]]



add_param M_AXI_USR_3_PROTOCOL              AXI4   "Usr Master-3 AXI Protocol"                "M_3" STRING                        
add_param M_AXI_USR_3_ADDR_WIDTH            64     "Usr Master-3 AXI address width"           "" LONG                             
add_param M_AXI_USR_3_DATA_WIDTH            128    "Usr Master-3 AXI data idth"               "" LONG                         
add_param M_AXI_USR_3_ID_WIDTH              16     "Usr Master-3 AXI ID width"                "" LONG                        
add_param M_AXI_USR_3_AWUSER_WIDTH          32     "Usr Master-3 AXI AWuser width"            "" LONG                            
add_param M_AXI_USR_3_WUSER_WIDTH           32     "Usr Master-3 AXI Wuser width"             "" LONG                           
add_param M_AXI_USR_3_BUSER_WIDTH           32     "Usr Master-3 AXI Buser width"             "" LONG                           
add_param M_AXI_USR_3_ARUSER_WIDTH          32     "Usr Master-3 AXI ARuser width"            "" LONG                            
add_param M_AXI_USR_3_RUSER_WIDTH           32     "Usr Master-3 AXI Ruser width"             "" LONG                           

ipgui::add_param -name {M_AXI_USR_3_PROTOCOL} -component [ipx::current_core] -show_label {true} -show_range {true} -widget {}
ipgui::add_param -name {M_AXI_USR_3_ADDR_WIDTH} -component [ipx::current_core] -show_label {true} -show_range {true} -widget {}
ipgui::add_param -name {M_AXI_USR_3_DATA_WIDTH} -component [ipx::current_core] -show_label {true} -show_range {true} -widget {}
ipgui::add_param -name {M_AXI_USR_3_ID_WIDTH} -component [ipx::current_core] -show_label {true} -show_range {true} -widget {}
ipgui::add_param -name {M_AXI_USR_3_AWUSER_WIDTH} -component [ipx::current_core] -show_label {true} -show_range {true} -widget {}
ipgui::add_param -name {M_AXI_USR_3_ARUSER_WIDTH} -component [ipx::current_core] -show_label {true} -show_range {true} -widget {}
ipgui::add_param -name {M_AXI_USR_3_WUSER_WIDTH} -component [ipx::current_core] -show_label {true} -show_range {true} -widget {}
ipgui::add_param -name {M_AXI_USR_3_BUSER_WIDTH} -component [ipx::current_core] -show_label {true} -show_range {true} -widget {}
ipgui::add_param -name {M_AXI_USR_3_RUSER_WIDTH} -component [ipx::current_core] -show_label {true} -show_range {true} -widget {}
set_property widget {comboBox} [ipgui::get_guiparamspec -name "M_AXI_USR_3_PROTOCOL" -component [ipx::current_core] ]
set_property widget {comboBox} [ipgui::get_guiparamspec -name "M_AXI_USR_3_DATA_WIDTH" -component [ipx::current_core] ]
set_property value_validation_type pairs [ipx::get_user_parameters M_AXI_USR_3_PROTOCOL -of_objects [ipx::current_core]]
set_property value_validation_pairs {AXI4 AXI4 AXI4LITE AXI4LITE} [ipx::get_user_parameters M_AXI_USR_3_PROTOCOL -of_objects [ipx::current_core]]
set_property widget {textEdit} [ipgui::get_guiparamspec -name "M_AXI_USR_3_ADDR_WIDTH" -component [ipx::current_core] ]
set_property value_validation_range_minimum 4 [ipx::get_user_parameters M_AXI_USR_3_ADDR_WIDTH -of_objects [ipx::current_core]]
set_property value_validation_range_maximum 64 [ipx::get_user_parameters M_AXI_USR_3_ADDR_WIDTH -of_objects [ipx::current_core]]
set_property value_validation_list {32:32 64:64 128:128} [::ipx::get_user_parameters -of_objects  $::core M_AXI_USR_3_DATA_WIDTH]
set_property value_validation_list {32:32 64:64 128:128} [::ipx::get_hdl_parameters -of_objects  $::core M_AXI_USR_3_DATA_WIDTH]
set_property value_validation_type list [ipx::get_user_parameters M_AXI_USR_3_DATA_WIDTH -of_objects [ipx::current_core]]
set_property widget {textEdit} [ipgui::get_guiparamspec -name "M_AXI_USR_3_ID_WIDTH" -component [ipx::current_core] ]
set_property value_validation_range_minimum 1 [ipx::get_user_parameters M_AXI_USR_3_ID_WIDTH -of_objects [ipx::current_core]]
set_property value_validation_range_maximum 16 [ipx::get_user_parameters M_AXI_USR_3_ID_WIDTH -of_objects [ipx::current_core]]
set_property widget {textEdit} [ipgui::get_guiparamspec -name "M_AXI_USR_3_AWUSER_WIDTH" -component [ipx::current_core] ]
set_property value_validation_range_minimum 1 [ipx::get_user_parameters M_AXI_USR_3_AWUSER_WIDTH -of_objects [ipx::current_core]]
set_property value_validation_range_maximum 32 [ipx::get_user_parameters M_AXI_USR_3_AWUSER_WIDTH -of_objects [ipx::current_core]]
set_property widget {textEdit} [ipgui::get_guiparamspec -name "M_AXI_USR_3_ARUSER_WIDTH" -component [ipx::current_core] ]
set_property value_validation_range_minimum 1 [ipx::get_user_parameters M_AXI_USR_3_ARUSER_WIDTH -of_objects [ipx::current_core]]
set_property value_validation_range_maximum 32 [ipx::get_user_parameters M_AXI_USR_3_ARUSER_WIDTH -of_objects [ipx::current_core]]
set_property widget {textEdit} [ipgui::get_guiparamspec -name "M_AXI_USR_3_WUSER_WIDTH" -component [ipx::current_core] ]
set_property value_validation_range_minimum 1 [ipx::get_user_parameters M_AXI_USR_3_WUSER_WIDTH -of_objects [ipx::current_core]]
set_property value_validation_range_maximum 32 [ipx::get_user_parameters M_AXI_USR_3_WUSER_WIDTH -of_objects [ipx::current_core]]
set_property widget {textEdit} [ipgui::get_guiparamspec -name "M_AXI_USR_3_BUSER_WIDTH" -component [ipx::current_core] ]
set_property value_validation_range_minimum 1 [ipx::get_user_parameters M_AXI_USR_3_BUSER_WIDTH -of_objects [ipx::current_core]]
set_property value_validation_range_maximum 32 [ipx::get_user_parameters M_AXI_USR_3_BUSER_WIDTH -of_objects [ipx::current_core]]
set_property widget {textEdit} [ipgui::get_guiparamspec -name "M_AXI_USR_3_RUSER_WIDTH" -component [ipx::current_core] ]
set_property value_validation_range_minimum 1 [ipx::get_user_parameters M_AXI_USR_3_RUSER_WIDTH -of_objects [ipx::current_core]]
set_property value_validation_range_maximum 32 [ipx::get_user_parameters M_AXI_USR_3_RUSER_WIDTH -of_objects [ipx::current_core]]
ipgui::add_page -name {Master_Usr_3} -component [ipx::current_core] -display_name {Master_Usr_3}
ipgui::move_param -component [ipx::current_core] -order 0 [ipgui::get_guiparamspec -name "M_AXI_USR_3_PROTOCOL" -component [ipx::current_core]] -parent [ipgui::get_pagespec -name "Master_Usr_3" -component [ipx::current_core]]
ipgui::move_param -component [ipx::current_core] -order 1 [ipgui::get_guiparamspec -name "M_AXI_USR_3_ADDR_WIDTH" -component [ipx::current_core]] -parent [ipgui::get_pagespec -name "Master_Usr_3" -component [ipx::current_core]]
ipgui::move_param -component [ipx::current_core] -order 2 [ipgui::get_guiparamspec -name "M_AXI_USR_3_DATA_WIDTH" -component [ipx::current_core]] -parent [ipgui::get_pagespec -name "Master_Usr_3" -component [ipx::current_core]]
ipgui::move_param -component [ipx::current_core] -order 3 [ipgui::get_guiparamspec -name "M_AXI_USR_3_ID_WIDTH" -component [ipx::current_core]] -parent [ipgui::get_pagespec -name "Master_Usr_3" -component [ipx::current_core]]
ipgui::move_param -component [ipx::current_core] -order 4 [ipgui::get_guiparamspec -name "M_AXI_USR_3_AWUSER_WIDTH" -component [ipx::current_core]] -parent [ipgui::get_pagespec -name "Master_Usr_3" -component [ipx::current_core]]
ipgui::move_param -component [ipx::current_core] -order 5 [ipgui::get_guiparamspec -name "M_AXI_USR_3_WUSER_WIDTH" -component [ipx::current_core]] -parent [ipgui::get_pagespec -name "Master_Usr_3" -component [ipx::current_core]]
ipgui::move_param -component [ipx::current_core] -order 6 [ipgui::get_guiparamspec -name "M_AXI_USR_3_BUSER_WIDTH" -component [ipx::current_core]] -parent [ipgui::get_pagespec -name "Master_Usr_3" -component [ipx::current_core]]
ipgui::move_param -component [ipx::current_core] -order 7 [ipgui::get_guiparamspec -name "M_AXI_USR_3_ARUSER_WIDTH" -component [ipx::current_core]] -parent [ipgui::get_pagespec -name "Master_Usr_3" -component [ipx::current_core]]
ipgui::move_param -component [ipx::current_core] -order 8 [ipgui::get_guiparamspec -name "M_AXI_USR_3_RUSER_WIDTH" -component [ipx::current_core]] -parent [ipgui::get_pagespec -name "Master_Usr_3" -component [ipx::current_core]]
set_property enablement_tcl_expr {$NUM_MASTER_BRIDGE >= 4} [ipx::get_user_parameters M_AXI_USR_3_PROTOCOL     -of_objects [ipx::current_core]]
set_property enablement_tcl_expr {$NUM_MASTER_BRIDGE >= 4} [ipx::get_user_parameters M_AXI_USR_3_ADDR_WIDTH   -of_objects [ipx::current_core]]
set_property enablement_tcl_expr {$NUM_MASTER_BRIDGE >= 4} [ipx::get_user_parameters M_AXI_USR_3_DATA_WIDTH   -of_objects [ipx::current_core]]
set_property enablement_tcl_expr {$NUM_MASTER_BRIDGE >= 4} [ipx::get_user_parameters M_AXI_USR_3_ID_WIDTH     -of_objects [ipx::current_core]]
set_property enablement_tcl_expr {$NUM_MASTER_BRIDGE >= 4} [ipx::get_user_parameters M_AXI_USR_3_AWUSER_WIDTH -of_objects [ipx::current_core]]
set_property enablement_tcl_expr {$NUM_MASTER_BRIDGE >= 4} [ipx::get_user_parameters M_AXI_USR_3_WUSER_WIDTH  -of_objects [ipx::current_core]]
set_property enablement_tcl_expr {$NUM_MASTER_BRIDGE >= 4} [ipx::get_user_parameters M_AXI_USR_3_BUSER_WIDTH  -of_objects [ipx::current_core]]
set_property enablement_tcl_expr {$NUM_MASTER_BRIDGE >= 4} [ipx::get_user_parameters M_AXI_USR_3_ARUSER_WIDTH -of_objects [ipx::current_core]]
set_property enablement_tcl_expr {$NUM_MASTER_BRIDGE >= 4} [ipx::get_user_parameters M_AXI_USR_3_RUSER_WIDTH  -of_objects [ipx::current_core]]



add_param M_AXI_USR_4_PROTOCOL              AXI4   "Usr Master-4 AXI Protocol"                "M_4" STRING                        
add_param M_AXI_USR_4_ADDR_WIDTH            64     "Usr Master-4 AXI address width"           "" LONG                             
add_param M_AXI_USR_4_DATA_WIDTH            128    "Usr Master-4 AXI data idth"               "" LONG                         
add_param M_AXI_USR_4_ID_WIDTH              16     "Usr Master-4 AXI ID width"                "" LONG                        
add_param M_AXI_USR_4_AWUSER_WIDTH          32     "Usr Master-4 AXI AWuser width"            "" LONG                            
add_param M_AXI_USR_4_WUSER_WIDTH           32     "Usr Master-4 AXI Wuser width"             "" LONG                           
add_param M_AXI_USR_4_BUSER_WIDTH           32     "Usr Master-4 AXI Buser width"             "" LONG                           
add_param M_AXI_USR_4_ARUSER_WIDTH          32     "Usr Master-4 AXI ARuser width"            "" LONG                            
add_param M_AXI_USR_4_RUSER_WIDTH           32     "Usr Master-4 AXI Ruser width"             "" LONG                           

ipgui::add_param -name {M_AXI_USR_4_PROTOCOL} -component [ipx::current_core] -show_label {true} -show_range {true} -widget {}
ipgui::add_param -name {M_AXI_USR_4_ADDR_WIDTH} -component [ipx::current_core] -show_label {true} -show_range {true} -widget {}
ipgui::add_param -name {M_AXI_USR_4_DATA_WIDTH} -component [ipx::current_core] -show_label {true} -show_range {true} -widget {}
ipgui::add_param -name {M_AXI_USR_4_ID_WIDTH} -component [ipx::current_core] -show_label {true} -show_range {true} -widget {}
ipgui::add_param -name {M_AXI_USR_4_AWUSER_WIDTH} -component [ipx::current_core] -show_label {true} -show_range {true} -widget {}
ipgui::add_param -name {M_AXI_USR_4_ARUSER_WIDTH} -component [ipx::current_core] -show_label {true} -show_range {true} -widget {}
ipgui::add_param -name {M_AXI_USR_4_WUSER_WIDTH} -component [ipx::current_core] -show_label {true} -show_range {true} -widget {}
ipgui::add_param -name {M_AXI_USR_4_BUSER_WIDTH} -component [ipx::current_core] -show_label {true} -show_range {true} -widget {}
ipgui::add_param -name {M_AXI_USR_4_RUSER_WIDTH} -component [ipx::current_core] -show_label {true} -show_range {true} -widget {}
set_property widget {comboBox} [ipgui::get_guiparamspec -name "M_AXI_USR_4_PROTOCOL" -component [ipx::current_core] ]
set_property widget {comboBox} [ipgui::get_guiparamspec -name "M_AXI_USR_4_DATA_WIDTH" -component [ipx::current_core] ]
set_property value_validation_type pairs [ipx::get_user_parameters M_AXI_USR_4_PROTOCOL -of_objects [ipx::current_core]]
set_property value_validation_pairs {AXI4 AXI4 AXI4LITE AXI4LITE} [ipx::get_user_parameters M_AXI_USR_4_PROTOCOL -of_objects [ipx::current_core]]
set_property widget {textEdit} [ipgui::get_guiparamspec -name "M_AXI_USR_4_ADDR_WIDTH" -component [ipx::current_core] ]
set_property value_validation_range_minimum 4 [ipx::get_user_parameters M_AXI_USR_4_ADDR_WIDTH -of_objects [ipx::current_core]]
set_property value_validation_range_maximum 64 [ipx::get_user_parameters M_AXI_USR_4_ADDR_WIDTH -of_objects [ipx::current_core]]
set_property value_validation_list {32:32 64:64 128:128} [::ipx::get_user_parameters -of_objects  $::core M_AXI_USR_4_DATA_WIDTH]
set_property value_validation_list {32:32 64:64 128:128} [::ipx::get_hdl_parameters -of_objects  $::core M_AXI_USR_4_DATA_WIDTH]
set_property value_validation_type list [ipx::get_user_parameters M_AXI_USR_4_DATA_WIDTH -of_objects [ipx::current_core]]
set_property widget {textEdit} [ipgui::get_guiparamspec -name "M_AXI_USR_4_ID_WIDTH" -component [ipx::current_core] ]
set_property value_validation_range_minimum 1 [ipx::get_user_parameters M_AXI_USR_4_ID_WIDTH -of_objects [ipx::current_core]]
set_property value_validation_range_maximum 16 [ipx::get_user_parameters M_AXI_USR_4_ID_WIDTH -of_objects [ipx::current_core]]
set_property widget {textEdit} [ipgui::get_guiparamspec -name "M_AXI_USR_4_AWUSER_WIDTH" -component [ipx::current_core] ]
set_property value_validation_range_minimum 1 [ipx::get_user_parameters M_AXI_USR_4_AWUSER_WIDTH -of_objects [ipx::current_core]]
set_property value_validation_range_maximum 32 [ipx::get_user_parameters M_AXI_USR_4_AWUSER_WIDTH -of_objects [ipx::current_core]]
set_property widget {textEdit} [ipgui::get_guiparamspec -name "M_AXI_USR_4_ARUSER_WIDTH" -component [ipx::current_core] ]
set_property value_validation_range_minimum 1 [ipx::get_user_parameters M_AXI_USR_4_ARUSER_WIDTH -of_objects [ipx::current_core]]
set_property value_validation_range_maximum 32 [ipx::get_user_parameters M_AXI_USR_4_ARUSER_WIDTH -of_objects [ipx::current_core]]
set_property widget {textEdit} [ipgui::get_guiparamspec -name "M_AXI_USR_4_WUSER_WIDTH" -component [ipx::current_core] ]
set_property value_validation_range_minimum 1 [ipx::get_user_parameters M_AXI_USR_4_WUSER_WIDTH -of_objects [ipx::current_core]]
set_property value_validation_range_maximum 32 [ipx::get_user_parameters M_AXI_USR_4_WUSER_WIDTH -of_objects [ipx::current_core]]
set_property widget {textEdit} [ipgui::get_guiparamspec -name "M_AXI_USR_4_BUSER_WIDTH" -component [ipx::current_core] ]
set_property value_validation_range_minimum 1 [ipx::get_user_parameters M_AXI_USR_4_BUSER_WIDTH -of_objects [ipx::current_core]]
set_property value_validation_range_maximum 32 [ipx::get_user_parameters M_AXI_USR_4_BUSER_WIDTH -of_objects [ipx::current_core]]
set_property widget {textEdit} [ipgui::get_guiparamspec -name "M_AXI_USR_4_RUSER_WIDTH" -component [ipx::current_core] ]
set_property value_validation_range_minimum 1 [ipx::get_user_parameters M_AXI_USR_4_RUSER_WIDTH -of_objects [ipx::current_core]]
set_property value_validation_range_maximum 32 [ipx::get_user_parameters M_AXI_USR_4_RUSER_WIDTH -of_objects [ipx::current_core]]
ipgui::add_page -name {Master_Usr_4} -component [ipx::current_core] -display_name {Master_Usr_4}
ipgui::move_param -component [ipx::current_core] -order 0 [ipgui::get_guiparamspec -name "M_AXI_USR_4_PROTOCOL" -component [ipx::current_core]] -parent [ipgui::get_pagespec -name "Master_Usr_4" -component [ipx::current_core]]
ipgui::move_param -component [ipx::current_core] -order 1 [ipgui::get_guiparamspec -name "M_AXI_USR_4_ADDR_WIDTH" -component [ipx::current_core]] -parent [ipgui::get_pagespec -name "Master_Usr_4" -component [ipx::current_core]]
ipgui::move_param -component [ipx::current_core] -order 2 [ipgui::get_guiparamspec -name "M_AXI_USR_4_DATA_WIDTH" -component [ipx::current_core]] -parent [ipgui::get_pagespec -name "Master_Usr_4" -component [ipx::current_core]]
ipgui::move_param -component [ipx::current_core] -order 3 [ipgui::get_guiparamspec -name "M_AXI_USR_4_ID_WIDTH" -component [ipx::current_core]] -parent [ipgui::get_pagespec -name "Master_Usr_4" -component [ipx::current_core]]
ipgui::move_param -component [ipx::current_core] -order 4 [ipgui::get_guiparamspec -name "M_AXI_USR_4_AWUSER_WIDTH" -component [ipx::current_core]] -parent [ipgui::get_pagespec -name "Master_Usr_4" -component [ipx::current_core]]
ipgui::move_param -component [ipx::current_core] -order 5 [ipgui::get_guiparamspec -name "M_AXI_USR_4_WUSER_WIDTH" -component [ipx::current_core]] -parent [ipgui::get_pagespec -name "Master_Usr_4" -component [ipx::current_core]]
ipgui::move_param -component [ipx::current_core] -order 6 [ipgui::get_guiparamspec -name "M_AXI_USR_4_BUSER_WIDTH" -component [ipx::current_core]] -parent [ipgui::get_pagespec -name "Master_Usr_4" -component [ipx::current_core]]
ipgui::move_param -component [ipx::current_core] -order 7 [ipgui::get_guiparamspec -name "M_AXI_USR_4_ARUSER_WIDTH" -component [ipx::current_core]] -parent [ipgui::get_pagespec -name "Master_Usr_4" -component [ipx::current_core]]
ipgui::move_param -component [ipx::current_core] -order 8 [ipgui::get_guiparamspec -name "M_AXI_USR_4_RUSER_WIDTH" -component [ipx::current_core]] -parent [ipgui::get_pagespec -name "Master_Usr_4" -component [ipx::current_core]]
set_property enablement_tcl_expr {$NUM_MASTER_BRIDGE >= 5} [ipx::get_user_parameters M_AXI_USR_4_PROTOCOL     -of_objects [ipx::current_core]]
set_property enablement_tcl_expr {$NUM_MASTER_BRIDGE >= 5} [ipx::get_user_parameters M_AXI_USR_4_ADDR_WIDTH   -of_objects [ipx::current_core]]
set_property enablement_tcl_expr {$NUM_MASTER_BRIDGE >= 5} [ipx::get_user_parameters M_AXI_USR_4_DATA_WIDTH   -of_objects [ipx::current_core]]
set_property enablement_tcl_expr {$NUM_MASTER_BRIDGE >= 5} [ipx::get_user_parameters M_AXI_USR_4_ID_WIDTH     -of_objects [ipx::current_core]]
set_property enablement_tcl_expr {$NUM_MASTER_BRIDGE >= 5} [ipx::get_user_parameters M_AXI_USR_4_AWUSER_WIDTH -of_objects [ipx::current_core]]
set_property enablement_tcl_expr {$NUM_MASTER_BRIDGE >= 5} [ipx::get_user_parameters M_AXI_USR_4_WUSER_WIDTH  -of_objects [ipx::current_core]]
set_property enablement_tcl_expr {$NUM_MASTER_BRIDGE >= 5} [ipx::get_user_parameters M_AXI_USR_4_BUSER_WIDTH  -of_objects [ipx::current_core]]
set_property enablement_tcl_expr {$NUM_MASTER_BRIDGE >= 5} [ipx::get_user_parameters M_AXI_USR_4_ARUSER_WIDTH -of_objects [ipx::current_core]]
set_property enablement_tcl_expr {$NUM_MASTER_BRIDGE >= 5} [ipx::get_user_parameters M_AXI_USR_4_RUSER_WIDTH  -of_objects [ipx::current_core]]



add_param M_AXI_USR_5_PROTOCOL              AXI4   "Usr Master-5 AXI Protocol"                "M_5" STRING                        
add_param M_AXI_USR_5_ADDR_WIDTH            64     "Usr Master-5 AXI address width"           "" LONG                             
add_param M_AXI_USR_5_DATA_WIDTH            128    "Usr Master-5 AXI data idth"               "" LONG                         
add_param M_AXI_USR_5_ID_WIDTH              16     "Usr Master-5 AXI ID width"                "" LONG                        
add_param M_AXI_USR_5_AWUSER_WIDTH          32     "Usr Master-5 AXI AWuser width"            "" LONG                            
add_param M_AXI_USR_5_WUSER_WIDTH           32     "Usr Master-5 AXI Wuser width"             "" LONG                           
add_param M_AXI_USR_5_BUSER_WIDTH           32     "Usr Master-5 AXI Buser width"             "" LONG                           
add_param M_AXI_USR_5_ARUSER_WIDTH          32     "Usr Master-5 AXI ARuser width"            "" LONG                            
add_param M_AXI_USR_5_RUSER_WIDTH           32     "Usr Master-5 AXI Ruser width"             "" LONG                           

ipgui::add_param -name {M_AXI_USR_5_PROTOCOL} -component [ipx::current_core] -show_label {true} -show_range {true} -widget {}
ipgui::add_param -name {M_AXI_USR_5_ADDR_WIDTH} -component [ipx::current_core] -show_label {true} -show_range {true} -widget {}
ipgui::add_param -name {M_AXI_USR_5_DATA_WIDTH} -component [ipx::current_core] -show_label {true} -show_range {true} -widget {}
ipgui::add_param -name {M_AXI_USR_5_ID_WIDTH} -component [ipx::current_core] -show_label {true} -show_range {true} -widget {}
ipgui::add_param -name {M_AXI_USR_5_AWUSER_WIDTH} -component [ipx::current_core] -show_label {true} -show_range {true} -widget {}
ipgui::add_param -name {M_AXI_USR_5_ARUSER_WIDTH} -component [ipx::current_core] -show_label {true} -show_range {true} -widget {}
ipgui::add_param -name {M_AXI_USR_5_WUSER_WIDTH} -component [ipx::current_core] -show_label {true} -show_range {true} -widget {}
ipgui::add_param -name {M_AXI_USR_5_BUSER_WIDTH} -component [ipx::current_core] -show_label {true} -show_range {true} -widget {}
ipgui::add_param -name {M_AXI_USR_5_RUSER_WIDTH} -component [ipx::current_core] -show_label {true} -show_range {true} -widget {}
set_property widget {comboBox} [ipgui::get_guiparamspec -name "M_AXI_USR_5_PROTOCOL" -component [ipx::current_core] ]
set_property widget {comboBox} [ipgui::get_guiparamspec -name "M_AXI_USR_5_DATA_WIDTH" -component [ipx::current_core] ]
set_property value_validation_type pairs [ipx::get_user_parameters M_AXI_USR_5_PROTOCOL -of_objects [ipx::current_core]]
set_property value_validation_pairs {AXI4 AXI4 AXI4LITE AXI4LITE} [ipx::get_user_parameters M_AXI_USR_5_PROTOCOL -of_objects [ipx::current_core]]
set_property widget {textEdit} [ipgui::get_guiparamspec -name "M_AXI_USR_5_ADDR_WIDTH" -component [ipx::current_core] ]
set_property value_validation_range_minimum 4 [ipx::get_user_parameters M_AXI_USR_5_ADDR_WIDTH -of_objects [ipx::current_core]]
set_property value_validation_range_maximum 64 [ipx::get_user_parameters M_AXI_USR_5_ADDR_WIDTH -of_objects [ipx::current_core]]
set_property value_validation_list {32:32 64:64 128:128} [::ipx::get_user_parameters -of_objects  $::core M_AXI_USR_5_DATA_WIDTH]
set_property value_validation_list {32:32 64:64 128:128} [::ipx::get_hdl_parameters -of_objects  $::core M_AXI_USR_5_DATA_WIDTH]
set_property value_validation_type list [ipx::get_user_parameters M_AXI_USR_5_DATA_WIDTH -of_objects [ipx::current_core]]
set_property widget {textEdit} [ipgui::get_guiparamspec -name "M_AXI_USR_5_ID_WIDTH" -component [ipx::current_core] ]
set_property value_validation_range_minimum 1 [ipx::get_user_parameters M_AXI_USR_5_ID_WIDTH -of_objects [ipx::current_core]]
set_property value_validation_range_maximum 16 [ipx::get_user_parameters M_AXI_USR_5_ID_WIDTH -of_objects [ipx::current_core]]
set_property widget {textEdit} [ipgui::get_guiparamspec -name "M_AXI_USR_5_AWUSER_WIDTH" -component [ipx::current_core] ]
set_property value_validation_range_minimum 1 [ipx::get_user_parameters M_AXI_USR_5_AWUSER_WIDTH -of_objects [ipx::current_core]]
set_property value_validation_range_maximum 32 [ipx::get_user_parameters M_AXI_USR_5_AWUSER_WIDTH -of_objects [ipx::current_core]]
set_property widget {textEdit} [ipgui::get_guiparamspec -name "M_AXI_USR_5_ARUSER_WIDTH" -component [ipx::current_core] ]
set_property value_validation_range_minimum 1 [ipx::get_user_parameters M_AXI_USR_5_ARUSER_WIDTH -of_objects [ipx::current_core]]
set_property value_validation_range_maximum 32 [ipx::get_user_parameters M_AXI_USR_5_ARUSER_WIDTH -of_objects [ipx::current_core]]
set_property widget {textEdit} [ipgui::get_guiparamspec -name "M_AXI_USR_5_WUSER_WIDTH" -component [ipx::current_core] ]
set_property value_validation_range_minimum 1 [ipx::get_user_parameters M_AXI_USR_5_WUSER_WIDTH -of_objects [ipx::current_core]]
set_property value_validation_range_maximum 32 [ipx::get_user_parameters M_AXI_USR_5_WUSER_WIDTH -of_objects [ipx::current_core]]
set_property widget {textEdit} [ipgui::get_guiparamspec -name "M_AXI_USR_5_BUSER_WIDTH" -component [ipx::current_core] ]
set_property value_validation_range_minimum 1 [ipx::get_user_parameters M_AXI_USR_5_BUSER_WIDTH -of_objects [ipx::current_core]]
set_property value_validation_range_maximum 32 [ipx::get_user_parameters M_AXI_USR_5_BUSER_WIDTH -of_objects [ipx::current_core]]
set_property widget {textEdit} [ipgui::get_guiparamspec -name "M_AXI_USR_5_RUSER_WIDTH" -component [ipx::current_core] ]
set_property value_validation_range_minimum 1 [ipx::get_user_parameters M_AXI_USR_5_RUSER_WIDTH -of_objects [ipx::current_core]]
set_property value_validation_range_maximum 32 [ipx::get_user_parameters M_AXI_USR_5_RUSER_WIDTH -of_objects [ipx::current_core]]
ipgui::add_page -name {Master_Usr_5} -component [ipx::current_core] -display_name {Master_Usr_5}
ipgui::move_param -component [ipx::current_core] -order 0 [ipgui::get_guiparamspec -name "M_AXI_USR_5_PROTOCOL" -component [ipx::current_core]] -parent [ipgui::get_pagespec -name "Master_Usr_5" -component [ipx::current_core]]
ipgui::move_param -component [ipx::current_core] -order 1 [ipgui::get_guiparamspec -name "M_AXI_USR_5_ADDR_WIDTH" -component [ipx::current_core]] -parent [ipgui::get_pagespec -name "Master_Usr_5" -component [ipx::current_core]]
ipgui::move_param -component [ipx::current_core] -order 2 [ipgui::get_guiparamspec -name "M_AXI_USR_5_DATA_WIDTH" -component [ipx::current_core]] -parent [ipgui::get_pagespec -name "Master_Usr_5" -component [ipx::current_core]]
ipgui::move_param -component [ipx::current_core] -order 3 [ipgui::get_guiparamspec -name "M_AXI_USR_5_ID_WIDTH" -component [ipx::current_core]] -parent [ipgui::get_pagespec -name "Master_Usr_5" -component [ipx::current_core]]
ipgui::move_param -component [ipx::current_core] -order 4 [ipgui::get_guiparamspec -name "M_AXI_USR_5_AWUSER_WIDTH" -component [ipx::current_core]] -parent [ipgui::get_pagespec -name "Master_Usr_5" -component [ipx::current_core]]
ipgui::move_param -component [ipx::current_core] -order 5 [ipgui::get_guiparamspec -name "M_AXI_USR_5_WUSER_WIDTH" -component [ipx::current_core]] -parent [ipgui::get_pagespec -name "Master_Usr_5" -component [ipx::current_core]]
ipgui::move_param -component [ipx::current_core] -order 6 [ipgui::get_guiparamspec -name "M_AXI_USR_5_BUSER_WIDTH" -component [ipx::current_core]] -parent [ipgui::get_pagespec -name "Master_Usr_5" -component [ipx::current_core]]
ipgui::move_param -component [ipx::current_core] -order 7 [ipgui::get_guiparamspec -name "M_AXI_USR_5_ARUSER_WIDTH" -component [ipx::current_core]] -parent [ipgui::get_pagespec -name "Master_Usr_5" -component [ipx::current_core]]
ipgui::move_param -component [ipx::current_core] -order 8 [ipgui::get_guiparamspec -name "M_AXI_USR_5_RUSER_WIDTH" -component [ipx::current_core]] -parent [ipgui::get_pagespec -name "Master_Usr_5" -component [ipx::current_core]]
set_property enablement_tcl_expr {$NUM_MASTER_BRIDGE >= 6} [ipx::get_user_parameters M_AXI_USR_5_PROTOCOL     -of_objects [ipx::current_core]]
set_property enablement_tcl_expr {$NUM_MASTER_BRIDGE >= 6} [ipx::get_user_parameters M_AXI_USR_5_ADDR_WIDTH   -of_objects [ipx::current_core]]
set_property enablement_tcl_expr {$NUM_MASTER_BRIDGE >= 6} [ipx::get_user_parameters M_AXI_USR_5_DATA_WIDTH   -of_objects [ipx::current_core]]
set_property enablement_tcl_expr {$NUM_MASTER_BRIDGE >= 6} [ipx::get_user_parameters M_AXI_USR_5_ID_WIDTH     -of_objects [ipx::current_core]]
set_property enablement_tcl_expr {$NUM_MASTER_BRIDGE >= 6} [ipx::get_user_parameters M_AXI_USR_5_AWUSER_WIDTH -of_objects [ipx::current_core]]
set_property enablement_tcl_expr {$NUM_MASTER_BRIDGE >= 6} [ipx::get_user_parameters M_AXI_USR_5_WUSER_WIDTH  -of_objects [ipx::current_core]]
set_property enablement_tcl_expr {$NUM_MASTER_BRIDGE >= 6} [ipx::get_user_parameters M_AXI_USR_5_BUSER_WIDTH  -of_objects [ipx::current_core]]
set_property enablement_tcl_expr {$NUM_MASTER_BRIDGE >= 6} [ipx::get_user_parameters M_AXI_USR_5_ARUSER_WIDTH -of_objects [ipx::current_core]]
set_property enablement_tcl_expr {$NUM_MASTER_BRIDGE >= 6} [ipx::get_user_parameters M_AXI_USR_5_RUSER_WIDTH  -of_objects [ipx::current_core]]

add_param S_AXI_USR_0_PROTOCOL              AXI4   "Usr Slave-0 AXI Protocol"                "S_0" STRING                        
add_param S_AXI_USR_0_ADDR_WIDTH            64     "Usr Slave-0 AXI address width"           "" LONG                             
add_param S_AXI_USR_0_DATA_WIDTH            128    "Usr Slave-0 AXI data idth"               "" LONG                         
add_param S_AXI_USR_0_ID_WIDTH              16     "Usr Slave-0 AXI ID width"                "" LONG                        
add_param S_AXI_USR_0_AWUSER_WIDTH          32     "Usr Slave-0 AXI AWuser width"            "" LONG                            
add_param S_AXI_USR_0_WUSER_WIDTH           32     "Usr Slave-0 AXI Wuser width"             "" LONG                           
add_param S_AXI_USR_0_BUSER_WIDTH           32     "Usr Slave-0 AXI Buser width"             "" LONG                           
add_param S_AXI_USR_0_ARUSER_WIDTH          32     "Usr Slave-0 AXI ARuser width"            "" LONG                            
add_param S_AXI_USR_0_RUSER_WIDTH           32     "Usr Slave-0 AXI Ruser width"             "" LONG                           

ipgui::add_param -name {S_AXI_USR_0_PROTOCOL} -component [ipx::current_core] -show_label {true} -show_range {true} -widget {}
ipgui::add_param -name {S_AXI_USR_0_ADDR_WIDTH} -component [ipx::current_core] -show_label {true} -show_range {true} -widget {}
ipgui::add_param -name {S_AXI_USR_0_DATA_WIDTH} -component [ipx::current_core] -show_label {true} -show_range {true} -widget {}
ipgui::add_param -name {S_AXI_USR_0_ID_WIDTH} -component [ipx::current_core] -show_label {true} -show_range {true} -widget {}
ipgui::add_param -name {S_AXI_USR_0_AWUSER_WIDTH} -component [ipx::current_core] -show_label {true} -show_range {true} -widget {}
ipgui::add_param -name {S_AXI_USR_0_ARUSER_WIDTH} -component [ipx::current_core] -show_label {true} -show_range {true} -widget {}
ipgui::add_param -name {S_AXI_USR_0_WUSER_WIDTH} -component [ipx::current_core] -show_label {true} -show_range {true} -widget {}
ipgui::add_param -name {S_AXI_USR_0_BUSER_WIDTH} -component [ipx::current_core] -show_label {true} -show_range {true} -widget {}
ipgui::add_param -name {S_AXI_USR_0_RUSER_WIDTH} -component [ipx::current_core] -show_label {true} -show_range {true} -widget {}
set_property widget {comboBox} [ipgui::get_guiparamspec -name "S_AXI_USR_0_PROTOCOL" -component [ipx::current_core] ]
set_property widget {comboBox} [ipgui::get_guiparamspec -name "S_AXI_USR_0_DATA_WIDTH" -component [ipx::current_core] ]
set_property value_validation_type pairs [ipx::get_user_parameters S_AXI_USR_0_PROTOCOL -of_objects [ipx::current_core]]
set_property value_validation_pairs {AXI4 AXI4 AXI4LITE AXI4LITE} [ipx::get_user_parameters S_AXI_USR_0_PROTOCOL -of_objects [ipx::current_core]]
set_property widget {textEdit} [ipgui::get_guiparamspec -name "S_AXI_USR_0_ADDR_WIDTH" -component [ipx::current_core] ]
set_property value_validation_range_minimum 4 [ipx::get_user_parameters S_AXI_USR_0_ADDR_WIDTH -of_objects [ipx::current_core]]
set_property value_validation_range_maximum 64 [ipx::get_user_parameters S_AXI_USR_0_ADDR_WIDTH -of_objects [ipx::current_core]]
set_property value_validation_list {32:32 64:64 128:128} [::ipx::get_user_parameters -of_objects  $::core S_AXI_USR_0_DATA_WIDTH]
set_property value_validation_list {32:32 64:64 128:128} [::ipx::get_hdl_parameters -of_objects  $::core S_AXI_USR_0_DATA_WIDTH]
set_property value_validation_type list [ipx::get_user_parameters S_AXI_USR_0_DATA_WIDTH -of_objects [ipx::current_core]]
set_property widget {textEdit} [ipgui::get_guiparamspec -name "S_AXI_USR_0_ID_WIDTH" -component [ipx::current_core] ]
set_property value_validation_range_minimum 1 [ipx::get_user_parameters S_AXI_USR_0_ID_WIDTH -of_objects [ipx::current_core]]
set_property value_validation_range_maximum 16 [ipx::get_user_parameters S_AXI_USR_0_ID_WIDTH -of_objects [ipx::current_core]]
set_property widget {textEdit} [ipgui::get_guiparamspec -name "S_AXI_USR_0_AWUSER_WIDTH" -component [ipx::current_core] ]
set_property value_validation_range_minimum 1 [ipx::get_user_parameters S_AXI_USR_0_AWUSER_WIDTH -of_objects [ipx::current_core]]
set_property value_validation_range_maximum 32 [ipx::get_user_parameters S_AXI_USR_0_AWUSER_WIDTH -of_objects [ipx::current_core]]
set_property widget {textEdit} [ipgui::get_guiparamspec -name "S_AXI_USR_0_ARUSER_WIDTH" -component [ipx::current_core] ]
set_property value_validation_range_minimum 1 [ipx::get_user_parameters S_AXI_USR_0_ARUSER_WIDTH -of_objects [ipx::current_core]]
set_property value_validation_range_maximum 32 [ipx::get_user_parameters S_AXI_USR_0_ARUSER_WIDTH -of_objects [ipx::current_core]]
set_property widget {textEdit} [ipgui::get_guiparamspec -name "S_AXI_USR_0_WUSER_WIDTH" -component [ipx::current_core] ]
set_property value_validation_range_minimum 1 [ipx::get_user_parameters S_AXI_USR_0_WUSER_WIDTH -of_objects [ipx::current_core]]
set_property value_validation_range_maximum 32 [ipx::get_user_parameters S_AXI_USR_0_WUSER_WIDTH -of_objects [ipx::current_core]]
set_property widget {textEdit} [ipgui::get_guiparamspec -name "S_AXI_USR_0_BUSER_WIDTH" -component [ipx::current_core] ]
set_property value_validation_range_minimum 1 [ipx::get_user_parameters S_AXI_USR_0_BUSER_WIDTH -of_objects [ipx::current_core]]
set_property value_validation_range_maximum 32 [ipx::get_user_parameters S_AXI_USR_0_BUSER_WIDTH -of_objects [ipx::current_core]]
set_property widget {textEdit} [ipgui::get_guiparamspec -name "S_AXI_USR_0_RUSER_WIDTH" -component [ipx::current_core] ]
set_property value_validation_range_minimum 1 [ipx::get_user_parameters S_AXI_USR_0_RUSER_WIDTH -of_objects [ipx::current_core]]
set_property value_validation_range_maximum 32 [ipx::get_user_parameters S_AXI_USR_0_RUSER_WIDTH -of_objects [ipx::current_core]]
ipgui::add_page -name {Slave_Usr_0} -component [ipx::current_core] -display_name {Slave_Usr_0}
ipgui::move_param -component [ipx::current_core] -order 0 [ipgui::get_guiparamspec -name "S_AXI_USR_0_PROTOCOL" -component [ipx::current_core]] -parent [ipgui::get_pagespec -name "Slave_Usr_0" -component [ipx::current_core]]
ipgui::move_param -component [ipx::current_core] -order 1 [ipgui::get_guiparamspec -name "S_AXI_USR_0_ADDR_WIDTH" -component [ipx::current_core]] -parent [ipgui::get_pagespec -name "Slave_Usr_0" -component [ipx::current_core]]
ipgui::move_param -component [ipx::current_core] -order 2 [ipgui::get_guiparamspec -name "S_AXI_USR_0_DATA_WIDTH" -component [ipx::current_core]] -parent [ipgui::get_pagespec -name "Slave_Usr_0" -component [ipx::current_core]]
ipgui::move_param -component [ipx::current_core] -order 3 [ipgui::get_guiparamspec -name "S_AXI_USR_0_ID_WIDTH" -component [ipx::current_core]] -parent [ipgui::get_pagespec -name "Slave_Usr_0" -component [ipx::current_core]]
ipgui::move_param -component [ipx::current_core] -order 4 [ipgui::get_guiparamspec -name "S_AXI_USR_0_AWUSER_WIDTH" -component [ipx::current_core]] -parent [ipgui::get_pagespec -name "Slave_Usr_0" -component [ipx::current_core]]
ipgui::move_param -component [ipx::current_core] -order 5 [ipgui::get_guiparamspec -name "S_AXI_USR_0_WUSER_WIDTH" -component [ipx::current_core]] -parent [ipgui::get_pagespec -name "Slave_Usr_0" -component [ipx::current_core]]
ipgui::move_param -component [ipx::current_core] -order 6 [ipgui::get_guiparamspec -name "S_AXI_USR_0_BUSER_WIDTH" -component [ipx::current_core]] -parent [ipgui::get_pagespec -name "Slave_Usr_0" -component [ipx::current_core]]
ipgui::move_param -component [ipx::current_core] -order 7 [ipgui::get_guiparamspec -name "S_AXI_USR_0_ARUSER_WIDTH" -component [ipx::current_core]] -parent [ipgui::get_pagespec -name "Slave_Usr_0" -component [ipx::current_core]]
ipgui::move_param -component [ipx::current_core] -order 8 [ipgui::get_guiparamspec -name "S_AXI_USR_0_RUSER_WIDTH" -component [ipx::current_core]] -parent [ipgui::get_pagespec -name "Slave_Usr_0" -component [ipx::current_core]]
set_property enablement_tcl_expr {$NUM_SLAVE_BRIDGE >= 1} [ipx::get_user_parameters S_AXI_USR_0_PROTOCOL     -of_objects [ipx::current_core]]
set_property enablement_tcl_expr {$NUM_SLAVE_BRIDGE >= 1} [ipx::get_user_parameters S_AXI_USR_0_ADDR_WIDTH   -of_objects [ipx::current_core]]
set_property enablement_tcl_expr {$NUM_SLAVE_BRIDGE >= 1} [ipx::get_user_parameters S_AXI_USR_0_DATA_WIDTH   -of_objects [ipx::current_core]]
set_property enablement_tcl_expr {$NUM_SLAVE_BRIDGE >= 1} [ipx::get_user_parameters S_AXI_USR_0_ID_WIDTH     -of_objects [ipx::current_core]]
set_property enablement_tcl_expr {$NUM_SLAVE_BRIDGE >= 1} [ipx::get_user_parameters S_AXI_USR_0_AWUSER_WIDTH -of_objects [ipx::current_core]]
set_property enablement_tcl_expr {$NUM_SLAVE_BRIDGE >= 1} [ipx::get_user_parameters S_AXI_USR_0_WUSER_WIDTH  -of_objects [ipx::current_core]]
set_property enablement_tcl_expr {$NUM_SLAVE_BRIDGE >= 1} [ipx::get_user_parameters S_AXI_USR_0_BUSER_WIDTH  -of_objects [ipx::current_core]]
set_property enablement_tcl_expr {$NUM_SLAVE_BRIDGE >= 1} [ipx::get_user_parameters S_AXI_USR_0_ARUSER_WIDTH -of_objects [ipx::current_core]]
set_property enablement_tcl_expr {$NUM_SLAVE_BRIDGE >= 1} [ipx::get_user_parameters S_AXI_USR_0_RUSER_WIDTH  -of_objects [ipx::current_core]]


add_param S_AXI_USR_1_PROTOCOL              AXI4   "Usr Slave-1 AXI Protocol"                "S_1" STRING                        
add_param S_AXI_USR_1_ADDR_WIDTH            64     "Usr Slave-1 AXI address width"           "" LONG                             
add_param S_AXI_USR_1_DATA_WIDTH            128    "Usr Slave-1 AXI data idth"               "" LONG                         
add_param S_AXI_USR_1_ID_WIDTH              16     "Usr Slave-1 AXI ID width"                "" LONG                        
add_param S_AXI_USR_1_AWUSER_WIDTH          32     "Usr Slave-1 AXI AWuser width"            "" LONG                            
add_param S_AXI_USR_1_WUSER_WIDTH           32     "Usr Slave-1 AXI Wuser width"             "" LONG                           
add_param S_AXI_USR_1_BUSER_WIDTH           32     "Usr Slave-1 AXI Buser width"             "" LONG                           
add_param S_AXI_USR_1_ARUSER_WIDTH          32     "Usr Slave-1 AXI ARuser width"            "" LONG                            
add_param S_AXI_USR_1_RUSER_WIDTH           32     "Usr Slave-1 AXI Ruser width"             "" LONG                           

ipgui::add_param -name {S_AXI_USR_1_PROTOCOL} -component [ipx::current_core] -show_label {true} -show_range {true} -widget {}
ipgui::add_param -name {S_AXI_USR_1_ADDR_WIDTH} -component [ipx::current_core] -show_label {true} -show_range {true} -widget {}
ipgui::add_param -name {S_AXI_USR_1_DATA_WIDTH} -component [ipx::current_core] -show_label {true} -show_range {true} -widget {}
ipgui::add_param -name {S_AXI_USR_1_ID_WIDTH} -component [ipx::current_core] -show_label {true} -show_range {true} -widget {}
ipgui::add_param -name {S_AXI_USR_1_AWUSER_WIDTH} -component [ipx::current_core] -show_label {true} -show_range {true} -widget {}
ipgui::add_param -name {S_AXI_USR_1_ARUSER_WIDTH} -component [ipx::current_core] -show_label {true} -show_range {true} -widget {}
ipgui::add_param -name {S_AXI_USR_1_WUSER_WIDTH} -component [ipx::current_core] -show_label {true} -show_range {true} -widget {}
ipgui::add_param -name {S_AXI_USR_1_BUSER_WIDTH} -component [ipx::current_core] -show_label {true} -show_range {true} -widget {}
ipgui::add_param -name {S_AXI_USR_1_RUSER_WIDTH} -component [ipx::current_core] -show_label {true} -show_range {true} -widget {}
set_property widget {comboBox} [ipgui::get_guiparamspec -name "S_AXI_USR_1_PROTOCOL" -component [ipx::current_core] ]
set_property widget {comboBox} [ipgui::get_guiparamspec -name "S_AXI_USR_1_DATA_WIDTH" -component [ipx::current_core] ]
set_property value_validation_type pairs [ipx::get_user_parameters S_AXI_USR_1_PROTOCOL -of_objects [ipx::current_core]]
set_property value_validation_pairs {AXI4 AXI4 AXI4LITE AXI4LITE} [ipx::get_user_parameters S_AXI_USR_1_PROTOCOL -of_objects [ipx::current_core]]
set_property widget {textEdit} [ipgui::get_guiparamspec -name "S_AXI_USR_1_ADDR_WIDTH" -component [ipx::current_core] ]
set_property value_validation_range_minimum 4 [ipx::get_user_parameters S_AXI_USR_1_ADDR_WIDTH -of_objects [ipx::current_core]]
set_property value_validation_range_maximum 64 [ipx::get_user_parameters S_AXI_USR_1_ADDR_WIDTH -of_objects [ipx::current_core]]
set_property value_validation_list {32:32 64:64 128:128} [::ipx::get_user_parameters -of_objects  $::core S_AXI_USR_1_DATA_WIDTH]
set_property value_validation_list {32:32 64:64 128:128} [::ipx::get_hdl_parameters -of_objects  $::core S_AXI_USR_1_DATA_WIDTH]
set_property value_validation_type list [ipx::get_user_parameters S_AXI_USR_1_DATA_WIDTH -of_objects [ipx::current_core]]
set_property widget {textEdit} [ipgui::get_guiparamspec -name "S_AXI_USR_1_ID_WIDTH" -component [ipx::current_core] ]
set_property value_validation_range_minimum 1 [ipx::get_user_parameters S_AXI_USR_1_ID_WIDTH -of_objects [ipx::current_core]]
set_property value_validation_range_maximum 16 [ipx::get_user_parameters S_AXI_USR_1_ID_WIDTH -of_objects [ipx::current_core]]
set_property widget {textEdit} [ipgui::get_guiparamspec -name "S_AXI_USR_1_AWUSER_WIDTH" -component [ipx::current_core] ]
set_property value_validation_range_minimum 1 [ipx::get_user_parameters S_AXI_USR_1_AWUSER_WIDTH -of_objects [ipx::current_core]]
set_property value_validation_range_maximum 32 [ipx::get_user_parameters S_AXI_USR_1_AWUSER_WIDTH -of_objects [ipx::current_core]]
set_property widget {textEdit} [ipgui::get_guiparamspec -name "S_AXI_USR_1_ARUSER_WIDTH" -component [ipx::current_core] ]
set_property value_validation_range_minimum 1 [ipx::get_user_parameters S_AXI_USR_1_ARUSER_WIDTH -of_objects [ipx::current_core]]
set_property value_validation_range_maximum 32 [ipx::get_user_parameters S_AXI_USR_1_ARUSER_WIDTH -of_objects [ipx::current_core]]
set_property widget {textEdit} [ipgui::get_guiparamspec -name "S_AXI_USR_1_WUSER_WIDTH" -component [ipx::current_core] ]
set_property value_validation_range_minimum 1 [ipx::get_user_parameters S_AXI_USR_1_WUSER_WIDTH -of_objects [ipx::current_core]]
set_property value_validation_range_maximum 32 [ipx::get_user_parameters S_AXI_USR_1_WUSER_WIDTH -of_objects [ipx::current_core]]
set_property widget {textEdit} [ipgui::get_guiparamspec -name "S_AXI_USR_1_BUSER_WIDTH" -component [ipx::current_core] ]
set_property value_validation_range_minimum 1 [ipx::get_user_parameters S_AXI_USR_1_BUSER_WIDTH -of_objects [ipx::current_core]]
set_property value_validation_range_maximum 32 [ipx::get_user_parameters S_AXI_USR_1_BUSER_WIDTH -of_objects [ipx::current_core]]
set_property widget {textEdit} [ipgui::get_guiparamspec -name "S_AXI_USR_1_RUSER_WIDTH" -component [ipx::current_core] ]
set_property value_validation_range_minimum 1 [ipx::get_user_parameters S_AXI_USR_1_RUSER_WIDTH -of_objects [ipx::current_core]]
set_property value_validation_range_maximum 32 [ipx::get_user_parameters S_AXI_USR_1_RUSER_WIDTH -of_objects [ipx::current_core]]
ipgui::add_page -name {Slave_Usr_1} -component [ipx::current_core] -display_name {Slave_Usr_1}
ipgui::move_param -component [ipx::current_core] -order 0 [ipgui::get_guiparamspec -name "S_AXI_USR_1_PROTOCOL" -component [ipx::current_core]] -parent [ipgui::get_pagespec -name "Slave_Usr_1" -component [ipx::current_core]]
ipgui::move_param -component [ipx::current_core] -order 1 [ipgui::get_guiparamspec -name "S_AXI_USR_1_ADDR_WIDTH" -component [ipx::current_core]] -parent [ipgui::get_pagespec -name "Slave_Usr_1" -component [ipx::current_core]]
ipgui::move_param -component [ipx::current_core] -order 2 [ipgui::get_guiparamspec -name "S_AXI_USR_1_DATA_WIDTH" -component [ipx::current_core]] -parent [ipgui::get_pagespec -name "Slave_Usr_1" -component [ipx::current_core]]
ipgui::move_param -component [ipx::current_core] -order 3 [ipgui::get_guiparamspec -name "S_AXI_USR_1_ID_WIDTH" -component [ipx::current_core]] -parent [ipgui::get_pagespec -name "Slave_Usr_1" -component [ipx::current_core]]
ipgui::move_param -component [ipx::current_core] -order 4 [ipgui::get_guiparamspec -name "S_AXI_USR_1_AWUSER_WIDTH" -component [ipx::current_core]] -parent [ipgui::get_pagespec -name "Slave_Usr_1" -component [ipx::current_core]]
ipgui::move_param -component [ipx::current_core] -order 5 [ipgui::get_guiparamspec -name "S_AXI_USR_1_WUSER_WIDTH" -component [ipx::current_core]] -parent [ipgui::get_pagespec -name "Slave_Usr_1" -component [ipx::current_core]]
ipgui::move_param -component [ipx::current_core] -order 6 [ipgui::get_guiparamspec -name "S_AXI_USR_1_BUSER_WIDTH" -component [ipx::current_core]] -parent [ipgui::get_pagespec -name "Slave_Usr_1" -component [ipx::current_core]]
ipgui::move_param -component [ipx::current_core] -order 7 [ipgui::get_guiparamspec -name "S_AXI_USR_1_ARUSER_WIDTH" -component [ipx::current_core]] -parent [ipgui::get_pagespec -name "Slave_Usr_1" -component [ipx::current_core]]
ipgui::move_param -component [ipx::current_core] -order 8 [ipgui::get_guiparamspec -name "S_AXI_USR_1_RUSER_WIDTH" -component [ipx::current_core]] -parent [ipgui::get_pagespec -name "Slave_Usr_1" -component [ipx::current_core]]
set_property enablement_tcl_expr {$NUM_SLAVE_BRIDGE >= 2} [ipx::get_user_parameters S_AXI_USR_1_PROTOCOL     -of_objects [ipx::current_core]]
set_property enablement_tcl_expr {$NUM_SLAVE_BRIDGE >= 2} [ipx::get_user_parameters S_AXI_USR_1_ADDR_WIDTH   -of_objects [ipx::current_core]]
set_property enablement_tcl_expr {$NUM_SLAVE_BRIDGE >= 2} [ipx::get_user_parameters S_AXI_USR_1_DATA_WIDTH   -of_objects [ipx::current_core]]
set_property enablement_tcl_expr {$NUM_SLAVE_BRIDGE >= 2} [ipx::get_user_parameters S_AXI_USR_1_ID_WIDTH     -of_objects [ipx::current_core]]
set_property enablement_tcl_expr {$NUM_SLAVE_BRIDGE >= 2} [ipx::get_user_parameters S_AXI_USR_1_AWUSER_WIDTH -of_objects [ipx::current_core]]
set_property enablement_tcl_expr {$NUM_SLAVE_BRIDGE >= 2} [ipx::get_user_parameters S_AXI_USR_1_WUSER_WIDTH  -of_objects [ipx::current_core]]
set_property enablement_tcl_expr {$NUM_SLAVE_BRIDGE >= 2} [ipx::get_user_parameters S_AXI_USR_1_BUSER_WIDTH  -of_objects [ipx::current_core]]
set_property enablement_tcl_expr {$NUM_SLAVE_BRIDGE >= 2} [ipx::get_user_parameters S_AXI_USR_1_ARUSER_WIDTH -of_objects [ipx::current_core]]
set_property enablement_tcl_expr {$NUM_SLAVE_BRIDGE >= 2} [ipx::get_user_parameters S_AXI_USR_1_RUSER_WIDTH  -of_objects [ipx::current_core]]


add_param S_AXI_USR_2_PROTOCOL              AXI4   "Usr Slave-2 AXI Protocol"                "S_2" STRING                        
add_param S_AXI_USR_2_ADDR_WIDTH            64     "Usr Slave-2 AXI address width"           "" LONG                             
add_param S_AXI_USR_2_DATA_WIDTH            128    "Usr Slave-2 AXI data idth"               "" LONG                         
add_param S_AXI_USR_2_ID_WIDTH              16     "Usr Slave-2 AXI ID width"                "" LONG                        
add_param S_AXI_USR_2_AWUSER_WIDTH          32     "Usr Slave-2 AXI AWuser width"            "" LONG                            
add_param S_AXI_USR_2_WUSER_WIDTH           32     "Usr Slave-2 AXI Wuser width"             "" LONG                           
add_param S_AXI_USR_2_BUSER_WIDTH           32     "Usr Slave-2 AXI Buser width"             "" LONG                           
add_param S_AXI_USR_2_ARUSER_WIDTH          32     "Usr Slave-2 AXI ARuser width"            "" LONG                            
add_param S_AXI_USR_2_RUSER_WIDTH           32     "Usr Slave-2 AXI Ruser width"             "" LONG                           

ipgui::add_param -name {S_AXI_USR_2_PROTOCOL} -component [ipx::current_core] -show_label {true} -show_range {true} -widget {}
ipgui::add_param -name {S_AXI_USR_2_ADDR_WIDTH} -component [ipx::current_core] -show_label {true} -show_range {true} -widget {}
ipgui::add_param -name {S_AXI_USR_2_DATA_WIDTH} -component [ipx::current_core] -show_label {true} -show_range {true} -widget {}
ipgui::add_param -name {S_AXI_USR_2_ID_WIDTH} -component [ipx::current_core] -show_label {true} -show_range {true} -widget {}
ipgui::add_param -name {S_AXI_USR_2_AWUSER_WIDTH} -component [ipx::current_core] -show_label {true} -show_range {true} -widget {}
ipgui::add_param -name {S_AXI_USR_2_ARUSER_WIDTH} -component [ipx::current_core] -show_label {true} -show_range {true} -widget {}
ipgui::add_param -name {S_AXI_USR_2_WUSER_WIDTH} -component [ipx::current_core] -show_label {true} -show_range {true} -widget {}
ipgui::add_param -name {S_AXI_USR_2_BUSER_WIDTH} -component [ipx::current_core] -show_label {true} -show_range {true} -widget {}
ipgui::add_param -name {S_AXI_USR_2_RUSER_WIDTH} -component [ipx::current_core] -show_label {true} -show_range {true} -widget {}
set_property widget {comboBox} [ipgui::get_guiparamspec -name "S_AXI_USR_2_PROTOCOL" -component [ipx::current_core] ]
set_property widget {comboBox} [ipgui::get_guiparamspec -name "S_AXI_USR_2_DATA_WIDTH" -component [ipx::current_core] ]
set_property value_validation_type pairs [ipx::get_user_parameters S_AXI_USR_2_PROTOCOL -of_objects [ipx::current_core]]
set_property value_validation_pairs {AXI4 AXI4 AXI4LITE AXI4LITE} [ipx::get_user_parameters S_AXI_USR_2_PROTOCOL -of_objects [ipx::current_core]]
set_property widget {textEdit} [ipgui::get_guiparamspec -name "S_AXI_USR_2_ADDR_WIDTH" -component [ipx::current_core] ]
set_property value_validation_range_minimum 4 [ipx::get_user_parameters S_AXI_USR_2_ADDR_WIDTH -of_objects [ipx::current_core]]
set_property value_validation_range_maximum 64 [ipx::get_user_parameters S_AXI_USR_2_ADDR_WIDTH -of_objects [ipx::current_core]]
set_property value_validation_list {32:32 64:64 128:128} [::ipx::get_user_parameters -of_objects  $::core S_AXI_USR_2_DATA_WIDTH]
set_property value_validation_list {32:32 64:64 128:128} [::ipx::get_hdl_parameters -of_objects  $::core S_AXI_USR_2_DATA_WIDTH]
set_property value_validation_type list [ipx::get_user_parameters S_AXI_USR_2_DATA_WIDTH -of_objects [ipx::current_core]]
set_property widget {textEdit} [ipgui::get_guiparamspec -name "S_AXI_USR_2_ID_WIDTH" -component [ipx::current_core] ]
set_property value_validation_range_minimum 1 [ipx::get_user_parameters S_AXI_USR_2_ID_WIDTH -of_objects [ipx::current_core]]
set_property value_validation_range_maximum 16 [ipx::get_user_parameters S_AXI_USR_2_ID_WIDTH -of_objects [ipx::current_core]]
set_property widget {textEdit} [ipgui::get_guiparamspec -name "S_AXI_USR_2_AWUSER_WIDTH" -component [ipx::current_core] ]
set_property value_validation_range_minimum 1 [ipx::get_user_parameters S_AXI_USR_2_AWUSER_WIDTH -of_objects [ipx::current_core]]
set_property value_validation_range_maximum 32 [ipx::get_user_parameters S_AXI_USR_2_AWUSER_WIDTH -of_objects [ipx::current_core]]
set_property widget {textEdit} [ipgui::get_guiparamspec -name "S_AXI_USR_2_ARUSER_WIDTH" -component [ipx::current_core] ]
set_property value_validation_range_minimum 1 [ipx::get_user_parameters S_AXI_USR_2_ARUSER_WIDTH -of_objects [ipx::current_core]]
set_property value_validation_range_maximum 32 [ipx::get_user_parameters S_AXI_USR_2_ARUSER_WIDTH -of_objects [ipx::current_core]]
set_property widget {textEdit} [ipgui::get_guiparamspec -name "S_AXI_USR_2_WUSER_WIDTH" -component [ipx::current_core] ]
set_property value_validation_range_minimum 1 [ipx::get_user_parameters S_AXI_USR_2_WUSER_WIDTH -of_objects [ipx::current_core]]
set_property value_validation_range_maximum 32 [ipx::get_user_parameters S_AXI_USR_2_WUSER_WIDTH -of_objects [ipx::current_core]]
set_property widget {textEdit} [ipgui::get_guiparamspec -name "S_AXI_USR_2_BUSER_WIDTH" -component [ipx::current_core] ]
set_property value_validation_range_minimum 1 [ipx::get_user_parameters S_AXI_USR_2_BUSER_WIDTH -of_objects [ipx::current_core]]
set_property value_validation_range_maximum 32 [ipx::get_user_parameters S_AXI_USR_2_BUSER_WIDTH -of_objects [ipx::current_core]]
set_property widget {textEdit} [ipgui::get_guiparamspec -name "S_AXI_USR_2_RUSER_WIDTH" -component [ipx::current_core] ]
set_property value_validation_range_minimum 1 [ipx::get_user_parameters S_AXI_USR_2_RUSER_WIDTH -of_objects [ipx::current_core]]
set_property value_validation_range_maximum 32 [ipx::get_user_parameters S_AXI_USR_2_RUSER_WIDTH -of_objects [ipx::current_core]]
ipgui::add_page -name {Slave_Usr_2} -component [ipx::current_core] -display_name {Slave_Usr_2}
ipgui::move_param -component [ipx::current_core] -order 0 [ipgui::get_guiparamspec -name "S_AXI_USR_2_PROTOCOL" -component [ipx::current_core]] -parent [ipgui::get_pagespec -name "Slave_Usr_2" -component [ipx::current_core]]
ipgui::move_param -component [ipx::current_core] -order 1 [ipgui::get_guiparamspec -name "S_AXI_USR_2_ADDR_WIDTH" -component [ipx::current_core]] -parent [ipgui::get_pagespec -name "Slave_Usr_2" -component [ipx::current_core]]
ipgui::move_param -component [ipx::current_core] -order 2 [ipgui::get_guiparamspec -name "S_AXI_USR_2_DATA_WIDTH" -component [ipx::current_core]] -parent [ipgui::get_pagespec -name "Slave_Usr_2" -component [ipx::current_core]]
ipgui::move_param -component [ipx::current_core] -order 3 [ipgui::get_guiparamspec -name "S_AXI_USR_2_ID_WIDTH" -component [ipx::current_core]] -parent [ipgui::get_pagespec -name "Slave_Usr_2" -component [ipx::current_core]]
ipgui::move_param -component [ipx::current_core] -order 4 [ipgui::get_guiparamspec -name "S_AXI_USR_2_AWUSER_WIDTH" -component [ipx::current_core]] -parent [ipgui::get_pagespec -name "Slave_Usr_2" -component [ipx::current_core]]
ipgui::move_param -component [ipx::current_core] -order 5 [ipgui::get_guiparamspec -name "S_AXI_USR_2_WUSER_WIDTH" -component [ipx::current_core]] -parent [ipgui::get_pagespec -name "Slave_Usr_2" -component [ipx::current_core]]
ipgui::move_param -component [ipx::current_core] -order 6 [ipgui::get_guiparamspec -name "S_AXI_USR_2_BUSER_WIDTH" -component [ipx::current_core]] -parent [ipgui::get_pagespec -name "Slave_Usr_2" -component [ipx::current_core]]
ipgui::move_param -component [ipx::current_core] -order 7 [ipgui::get_guiparamspec -name "S_AXI_USR_2_ARUSER_WIDTH" -component [ipx::current_core]] -parent [ipgui::get_pagespec -name "Slave_Usr_2" -component [ipx::current_core]]
ipgui::move_param -component [ipx::current_core] -order 8 [ipgui::get_guiparamspec -name "S_AXI_USR_2_RUSER_WIDTH" -component [ipx::current_core]] -parent [ipgui::get_pagespec -name "Slave_Usr_2" -component [ipx::current_core]]
set_property enablement_tcl_expr {$NUM_SLAVE_BRIDGE >= 3} [ipx::get_user_parameters S_AXI_USR_2_PROTOCOL     -of_objects [ipx::current_core]]
set_property enablement_tcl_expr {$NUM_SLAVE_BRIDGE >= 3} [ipx::get_user_parameters S_AXI_USR_2_ADDR_WIDTH   -of_objects [ipx::current_core]]
set_property enablement_tcl_expr {$NUM_SLAVE_BRIDGE >= 3} [ipx::get_user_parameters S_AXI_USR_2_DATA_WIDTH   -of_objects [ipx::current_core]]
set_property enablement_tcl_expr {$NUM_SLAVE_BRIDGE >= 3} [ipx::get_user_parameters S_AXI_USR_2_ID_WIDTH     -of_objects [ipx::current_core]]
set_property enablement_tcl_expr {$NUM_SLAVE_BRIDGE >= 3} [ipx::get_user_parameters S_AXI_USR_2_AWUSER_WIDTH -of_objects [ipx::current_core]]
set_property enablement_tcl_expr {$NUM_SLAVE_BRIDGE >= 3} [ipx::get_user_parameters S_AXI_USR_2_WUSER_WIDTH  -of_objects [ipx::current_core]]
set_property enablement_tcl_expr {$NUM_SLAVE_BRIDGE >= 3} [ipx::get_user_parameters S_AXI_USR_2_BUSER_WIDTH  -of_objects [ipx::current_core]]
set_property enablement_tcl_expr {$NUM_SLAVE_BRIDGE >= 3} [ipx::get_user_parameters S_AXI_USR_2_ARUSER_WIDTH -of_objects [ipx::current_core]]
set_property enablement_tcl_expr {$NUM_SLAVE_BRIDGE >= 3} [ipx::get_user_parameters S_AXI_USR_2_RUSER_WIDTH  -of_objects [ipx::current_core]]

add_param S_AXI_USR_3_PROTOCOL              AXI4   "Usr Slave-3 AXI Protocol"                "S_3" STRING                        
add_param S_AXI_USR_3_ADDR_WIDTH            64     "Usr Slave-3 AXI address width"           "" LONG                             
add_param S_AXI_USR_3_DATA_WIDTH            128    "Usr Slave-3 AXI data idth"               "" LONG                         
add_param S_AXI_USR_3_ID_WIDTH              16     "Usr Slave-3 AXI ID width"                "" LONG                        
add_param S_AXI_USR_3_AWUSER_WIDTH          32     "Usr Slave-3 AXI AWuser width"            "" LONG                            
add_param S_AXI_USR_3_WUSER_WIDTH           32     "Usr Slave-3 AXI Wuser width"             "" LONG                           
add_param S_AXI_USR_3_BUSER_WIDTH           32     "Usr Slave-3 AXI Buser width"             "" LONG                           
add_param S_AXI_USR_3_ARUSER_WIDTH          32     "Usr Slave-3 AXI ARuser width"            "" LONG                            
add_param S_AXI_USR_3_RUSER_WIDTH           32     "Usr Slave-3 AXI Ruser width"             "" LONG                           

ipgui::add_param -name {S_AXI_USR_3_PROTOCOL} -component [ipx::current_core] -show_label {true} -show_range {true} -widget {}
ipgui::add_param -name {S_AXI_USR_3_ADDR_WIDTH} -component [ipx::current_core] -show_label {true} -show_range {true} -widget {}
ipgui::add_param -name {S_AXI_USR_3_DATA_WIDTH} -component [ipx::current_core] -show_label {true} -show_range {true} -widget {}
ipgui::add_param -name {S_AXI_USR_3_ID_WIDTH} -component [ipx::current_core] -show_label {true} -show_range {true} -widget {}
ipgui::add_param -name {S_AXI_USR_3_AWUSER_WIDTH} -component [ipx::current_core] -show_label {true} -show_range {true} -widget {}
ipgui::add_param -name {S_AXI_USR_3_ARUSER_WIDTH} -component [ipx::current_core] -show_label {true} -show_range {true} -widget {}
ipgui::add_param -name {S_AXI_USR_3_WUSER_WIDTH} -component [ipx::current_core] -show_label {true} -show_range {true} -widget {}
ipgui::add_param -name {S_AXI_USR_3_BUSER_WIDTH} -component [ipx::current_core] -show_label {true} -show_range {true} -widget {}
ipgui::add_param -name {S_AXI_USR_3_RUSER_WIDTH} -component [ipx::current_core] -show_label {true} -show_range {true} -widget {}
set_property widget {comboBox} [ipgui::get_guiparamspec -name "S_AXI_USR_3_PROTOCOL" -component [ipx::current_core] ]
set_property widget {comboBox} [ipgui::get_guiparamspec -name "S_AXI_USR_3_DATA_WIDTH" -component [ipx::current_core] ]
set_property value_validation_type pairs [ipx::get_user_parameters S_AXI_USR_3_PROTOCOL -of_objects [ipx::current_core]]
set_property value_validation_pairs {AXI4 AXI4 AXI4LITE AXI4LITE} [ipx::get_user_parameters S_AXI_USR_3_PROTOCOL -of_objects [ipx::current_core]]
set_property widget {textEdit} [ipgui::get_guiparamspec -name "S_AXI_USR_3_ADDR_WIDTH" -component [ipx::current_core] ]
set_property value_validation_range_minimum 4 [ipx::get_user_parameters S_AXI_USR_3_ADDR_WIDTH -of_objects [ipx::current_core]]
set_property value_validation_range_maximum 64 [ipx::get_user_parameters S_AXI_USR_3_ADDR_WIDTH -of_objects [ipx::current_core]]
set_property value_validation_list {32:32 64:64 128:128} [::ipx::get_user_parameters -of_objects  $::core S_AXI_USR_3_DATA_WIDTH]
set_property value_validation_list {32:32 64:64 128:128} [::ipx::get_hdl_parameters -of_objects  $::core S_AXI_USR_3_DATA_WIDTH]
set_property value_validation_type list [ipx::get_user_parameters S_AXI_USR_3_DATA_WIDTH -of_objects [ipx::current_core]]
set_property widget {textEdit} [ipgui::get_guiparamspec -name "S_AXI_USR_3_ID_WIDTH" -component [ipx::current_core] ]
set_property value_validation_range_minimum 1 [ipx::get_user_parameters S_AXI_USR_3_ID_WIDTH -of_objects [ipx::current_core]]
set_property value_validation_range_maximum 16 [ipx::get_user_parameters S_AXI_USR_3_ID_WIDTH -of_objects [ipx::current_core]]
set_property widget {textEdit} [ipgui::get_guiparamspec -name "S_AXI_USR_3_AWUSER_WIDTH" -component [ipx::current_core] ]
set_property value_validation_range_minimum 1 [ipx::get_user_parameters S_AXI_USR_3_AWUSER_WIDTH -of_objects [ipx::current_core]]
set_property value_validation_range_maximum 32 [ipx::get_user_parameters S_AXI_USR_3_AWUSER_WIDTH -of_objects [ipx::current_core]]
set_property widget {textEdit} [ipgui::get_guiparamspec -name "S_AXI_USR_3_ARUSER_WIDTH" -component [ipx::current_core] ]
set_property value_validation_range_minimum 1 [ipx::get_user_parameters S_AXI_USR_3_ARUSER_WIDTH -of_objects [ipx::current_core]]
set_property value_validation_range_maximum 32 [ipx::get_user_parameters S_AXI_USR_3_ARUSER_WIDTH -of_objects [ipx::current_core]]
set_property widget {textEdit} [ipgui::get_guiparamspec -name "S_AXI_USR_3_WUSER_WIDTH" -component [ipx::current_core] ]
set_property value_validation_range_minimum 1 [ipx::get_user_parameters S_AXI_USR_3_WUSER_WIDTH -of_objects [ipx::current_core]]
set_property value_validation_range_maximum 32 [ipx::get_user_parameters S_AXI_USR_3_WUSER_WIDTH -of_objects [ipx::current_core]]
set_property widget {textEdit} [ipgui::get_guiparamspec -name "S_AXI_USR_3_BUSER_WIDTH" -component [ipx::current_core] ]
set_property value_validation_range_minimum 1 [ipx::get_user_parameters S_AXI_USR_3_BUSER_WIDTH -of_objects [ipx::current_core]]
set_property value_validation_range_maximum 32 [ipx::get_user_parameters S_AXI_USR_3_BUSER_WIDTH -of_objects [ipx::current_core]]
set_property widget {textEdit} [ipgui::get_guiparamspec -name "S_AXI_USR_3_RUSER_WIDTH" -component [ipx::current_core] ]
set_property value_validation_range_minimum 1 [ipx::get_user_parameters S_AXI_USR_3_RUSER_WIDTH -of_objects [ipx::current_core]]
set_property value_validation_range_maximum 32 [ipx::get_user_parameters S_AXI_USR_3_RUSER_WIDTH -of_objects [ipx::current_core]]
ipgui::add_page -name {Slave_Usr_3} -component [ipx::current_core] -display_name {Slave_Usr_3}
ipgui::move_param -component [ipx::current_core] -order 0 [ipgui::get_guiparamspec -name "S_AXI_USR_3_PROTOCOL" -component [ipx::current_core]] -parent [ipgui::get_pagespec -name "Slave_Usr_3" -component [ipx::current_core]]
ipgui::move_param -component [ipx::current_core] -order 1 [ipgui::get_guiparamspec -name "S_AXI_USR_3_ADDR_WIDTH" -component [ipx::current_core]] -parent [ipgui::get_pagespec -name "Slave_Usr_3" -component [ipx::current_core]]
ipgui::move_param -component [ipx::current_core] -order 2 [ipgui::get_guiparamspec -name "S_AXI_USR_3_DATA_WIDTH" -component [ipx::current_core]] -parent [ipgui::get_pagespec -name "Slave_Usr_3" -component [ipx::current_core]]
ipgui::move_param -component [ipx::current_core] -order 3 [ipgui::get_guiparamspec -name "S_AXI_USR_3_ID_WIDTH" -component [ipx::current_core]] -parent [ipgui::get_pagespec -name "Slave_Usr_3" -component [ipx::current_core]]
ipgui::move_param -component [ipx::current_core] -order 4 [ipgui::get_guiparamspec -name "S_AXI_USR_3_AWUSER_WIDTH" -component [ipx::current_core]] -parent [ipgui::get_pagespec -name "Slave_Usr_3" -component [ipx::current_core]]
ipgui::move_param -component [ipx::current_core] -order 5 [ipgui::get_guiparamspec -name "S_AXI_USR_3_WUSER_WIDTH" -component [ipx::current_core]] -parent [ipgui::get_pagespec -name "Slave_Usr_3" -component [ipx::current_core]]
ipgui::move_param -component [ipx::current_core] -order 6 [ipgui::get_guiparamspec -name "S_AXI_USR_3_BUSER_WIDTH" -component [ipx::current_core]] -parent [ipgui::get_pagespec -name "Slave_Usr_3" -component [ipx::current_core]]
ipgui::move_param -component [ipx::current_core] -order 7 [ipgui::get_guiparamspec -name "S_AXI_USR_3_ARUSER_WIDTH" -component [ipx::current_core]] -parent [ipgui::get_pagespec -name "Slave_Usr_3" -component [ipx::current_core]]
ipgui::move_param -component [ipx::current_core] -order 8 [ipgui::get_guiparamspec -name "S_AXI_USR_3_RUSER_WIDTH" -component [ipx::current_core]] -parent [ipgui::get_pagespec -name "Slave_Usr_3" -component [ipx::current_core]]
set_property enablement_tcl_expr {$NUM_SLAVE_BRIDGE >= 4} [ipx::get_user_parameters S_AXI_USR_3_PROTOCOL     -of_objects [ipx::current_core]]
set_property enablement_tcl_expr {$NUM_SLAVE_BRIDGE >= 4} [ipx::get_user_parameters S_AXI_USR_3_ADDR_WIDTH   -of_objects [ipx::current_core]]
set_property enablement_tcl_expr {$NUM_SLAVE_BRIDGE >= 4} [ipx::get_user_parameters S_AXI_USR_3_DATA_WIDTH   -of_objects [ipx::current_core]]
set_property enablement_tcl_expr {$NUM_SLAVE_BRIDGE >= 4} [ipx::get_user_parameters S_AXI_USR_3_ID_WIDTH     -of_objects [ipx::current_core]]
set_property enablement_tcl_expr {$NUM_SLAVE_BRIDGE >= 4} [ipx::get_user_parameters S_AXI_USR_3_AWUSER_WIDTH -of_objects [ipx::current_core]]
set_property enablement_tcl_expr {$NUM_SLAVE_BRIDGE >= 4} [ipx::get_user_parameters S_AXI_USR_3_WUSER_WIDTH  -of_objects [ipx::current_core]]
set_property enablement_tcl_expr {$NUM_SLAVE_BRIDGE >= 4} [ipx::get_user_parameters S_AXI_USR_3_BUSER_WIDTH  -of_objects [ipx::current_core]]
set_property enablement_tcl_expr {$NUM_SLAVE_BRIDGE >= 4} [ipx::get_user_parameters S_AXI_USR_3_ARUSER_WIDTH -of_objects [ipx::current_core]]
set_property enablement_tcl_expr {$NUM_SLAVE_BRIDGE >= 4} [ipx::get_user_parameters S_AXI_USR_3_RUSER_WIDTH  -of_objects [ipx::current_core]]


add_param S_AXI_USR_4_PROTOCOL              AXI4   "Usr Slave-4 AXI Protocol"                "S_4" STRING                        
add_param S_AXI_USR_4_ADDR_WIDTH            64     "Usr Slave-4 AXI address width"           "" LONG                             
add_param S_AXI_USR_4_DATA_WIDTH            128    "Usr Slave-4 AXI data idth"               "" LONG                         
add_param S_AXI_USR_4_ID_WIDTH              16     "Usr Slave-4 AXI ID width"                "" LONG                        
add_param S_AXI_USR_4_AWUSER_WIDTH          32     "Usr Slave-4 AXI AWuser width"            "" LONG                            
add_param S_AXI_USR_4_WUSER_WIDTH           32     "Usr Slave-4 AXI Wuser width"             "" LONG                           
add_param S_AXI_USR_4_BUSER_WIDTH           32     "Usr Slave-4 AXI Buser width"             "" LONG                           
add_param S_AXI_USR_4_ARUSER_WIDTH          32     "Usr Slave-4 AXI ARuser width"            "" LONG                            
add_param S_AXI_USR_4_RUSER_WIDTH           32     "Usr Slave-4 AXI Ruser width"             "" LONG                           

ipgui::add_param -name {S_AXI_USR_4_PROTOCOL} -component [ipx::current_core] -show_label {true} -show_range {true} -widget {}
ipgui::add_param -name {S_AXI_USR_4_ADDR_WIDTH} -component [ipx::current_core] -show_label {true} -show_range {true} -widget {}
ipgui::add_param -name {S_AXI_USR_4_DATA_WIDTH} -component [ipx::current_core] -show_label {true} -show_range {true} -widget {}
ipgui::add_param -name {S_AXI_USR_4_ID_WIDTH} -component [ipx::current_core] -show_label {true} -show_range {true} -widget {}
ipgui::add_param -name {S_AXI_USR_4_AWUSER_WIDTH} -component [ipx::current_core] -show_label {true} -show_range {true} -widget {}
ipgui::add_param -name {S_AXI_USR_4_ARUSER_WIDTH} -component [ipx::current_core] -show_label {true} -show_range {true} -widget {}
ipgui::add_param -name {S_AXI_USR_4_WUSER_WIDTH} -component [ipx::current_core] -show_label {true} -show_range {true} -widget {}
ipgui::add_param -name {S_AXI_USR_4_BUSER_WIDTH} -component [ipx::current_core] -show_label {true} -show_range {true} -widget {}
ipgui::add_param -name {S_AXI_USR_4_RUSER_WIDTH} -component [ipx::current_core] -show_label {true} -show_range {true} -widget {}
set_property widget {comboBox} [ipgui::get_guiparamspec -name "S_AXI_USR_4_PROTOCOL" -component [ipx::current_core] ]
set_property widget {comboBox} [ipgui::get_guiparamspec -name "S_AXI_USR_4_DATA_WIDTH" -component [ipx::current_core] ]
set_property value_validation_type pairs [ipx::get_user_parameters S_AXI_USR_4_PROTOCOL -of_objects [ipx::current_core]]
set_property value_validation_pairs {AXI4 AXI4 AXI4LITE AXI4LITE} [ipx::get_user_parameters S_AXI_USR_4_PROTOCOL -of_objects [ipx::current_core]]
set_property widget {textEdit} [ipgui::get_guiparamspec -name "S_AXI_USR_4_ADDR_WIDTH" -component [ipx::current_core] ]
set_property value_validation_range_minimum 4 [ipx::get_user_parameters S_AXI_USR_4_ADDR_WIDTH -of_objects [ipx::current_core]]
set_property value_validation_range_maximum 64 [ipx::get_user_parameters S_AXI_USR_4_ADDR_WIDTH -of_objects [ipx::current_core]]
set_property value_validation_list {32:32 64:64 128:128} [::ipx::get_user_parameters -of_objects  $::core S_AXI_USR_4_DATA_WIDTH]
set_property value_validation_list {32:32 64:64 128:128} [::ipx::get_hdl_parameters -of_objects  $::core S_AXI_USR_4_DATA_WIDTH]
set_property value_validation_type list [ipx::get_user_parameters S_AXI_USR_4_DATA_WIDTH -of_objects [ipx::current_core]]
set_property widget {textEdit} [ipgui::get_guiparamspec -name "S_AXI_USR_4_ID_WIDTH" -component [ipx::current_core] ]
set_property value_validation_range_minimum 1 [ipx::get_user_parameters S_AXI_USR_4_ID_WIDTH -of_objects [ipx::current_core]]
set_property value_validation_range_maximum 16 [ipx::get_user_parameters S_AXI_USR_4_ID_WIDTH -of_objects [ipx::current_core]]
set_property widget {textEdit} [ipgui::get_guiparamspec -name "S_AXI_USR_4_AWUSER_WIDTH" -component [ipx::current_core] ]
set_property value_validation_range_minimum 1 [ipx::get_user_parameters S_AXI_USR_4_AWUSER_WIDTH -of_objects [ipx::current_core]]
set_property value_validation_range_maximum 32 [ipx::get_user_parameters S_AXI_USR_4_AWUSER_WIDTH -of_objects [ipx::current_core]]
set_property widget {textEdit} [ipgui::get_guiparamspec -name "S_AXI_USR_4_ARUSER_WIDTH" -component [ipx::current_core] ]
set_property value_validation_range_minimum 1 [ipx::get_user_parameters S_AXI_USR_4_ARUSER_WIDTH -of_objects [ipx::current_core]]
set_property value_validation_range_maximum 32 [ipx::get_user_parameters S_AXI_USR_4_ARUSER_WIDTH -of_objects [ipx::current_core]]
set_property widget {textEdit} [ipgui::get_guiparamspec -name "S_AXI_USR_4_WUSER_WIDTH" -component [ipx::current_core] ]
set_property value_validation_range_minimum 1 [ipx::get_user_parameters S_AXI_USR_4_WUSER_WIDTH -of_objects [ipx::current_core]]
set_property value_validation_range_maximum 32 [ipx::get_user_parameters S_AXI_USR_4_WUSER_WIDTH -of_objects [ipx::current_core]]
set_property widget {textEdit} [ipgui::get_guiparamspec -name "S_AXI_USR_4_BUSER_WIDTH" -component [ipx::current_core] ]
set_property value_validation_range_minimum 1 [ipx::get_user_parameters S_AXI_USR_4_BUSER_WIDTH -of_objects [ipx::current_core]]
set_property value_validation_range_maximum 32 [ipx::get_user_parameters S_AXI_USR_4_BUSER_WIDTH -of_objects [ipx::current_core]]
set_property widget {textEdit} [ipgui::get_guiparamspec -name "S_AXI_USR_4_RUSER_WIDTH" -component [ipx::current_core] ]
set_property value_validation_range_minimum 1 [ipx::get_user_parameters S_AXI_USR_4_RUSER_WIDTH -of_objects [ipx::current_core]]
set_property value_validation_range_maximum 32 [ipx::get_user_parameters S_AXI_USR_4_RUSER_WIDTH -of_objects [ipx::current_core]]
ipgui::add_page -name {Slave_Usr_4} -component [ipx::current_core] -display_name {Slave_Usr_4}
ipgui::move_param -component [ipx::current_core] -order 0 [ipgui::get_guiparamspec -name "S_AXI_USR_4_PROTOCOL" -component [ipx::current_core]] -parent [ipgui::get_pagespec -name "Slave_Usr_4" -component [ipx::current_core]]
ipgui::move_param -component [ipx::current_core] -order 1 [ipgui::get_guiparamspec -name "S_AXI_USR_4_ADDR_WIDTH" -component [ipx::current_core]] -parent [ipgui::get_pagespec -name "Slave_Usr_4" -component [ipx::current_core]]
ipgui::move_param -component [ipx::current_core] -order 2 [ipgui::get_guiparamspec -name "S_AXI_USR_4_DATA_WIDTH" -component [ipx::current_core]] -parent [ipgui::get_pagespec -name "Slave_Usr_4" -component [ipx::current_core]]
ipgui::move_param -component [ipx::current_core] -order 3 [ipgui::get_guiparamspec -name "S_AXI_USR_4_ID_WIDTH" -component [ipx::current_core]] -parent [ipgui::get_pagespec -name "Slave_Usr_4" -component [ipx::current_core]]
ipgui::move_param -component [ipx::current_core] -order 4 [ipgui::get_guiparamspec -name "S_AXI_USR_4_AWUSER_WIDTH" -component [ipx::current_core]] -parent [ipgui::get_pagespec -name "Slave_Usr_4" -component [ipx::current_core]]
ipgui::move_param -component [ipx::current_core] -order 5 [ipgui::get_guiparamspec -name "S_AXI_USR_4_WUSER_WIDTH" -component [ipx::current_core]] -parent [ipgui::get_pagespec -name "Slave_Usr_4" -component [ipx::current_core]]
ipgui::move_param -component [ipx::current_core] -order 6 [ipgui::get_guiparamspec -name "S_AXI_USR_4_BUSER_WIDTH" -component [ipx::current_core]] -parent [ipgui::get_pagespec -name "Slave_Usr_4" -component [ipx::current_core]]
ipgui::move_param -component [ipx::current_core] -order 7 [ipgui::get_guiparamspec -name "S_AXI_USR_4_ARUSER_WIDTH" -component [ipx::current_core]] -parent [ipgui::get_pagespec -name "Slave_Usr_4" -component [ipx::current_core]]
ipgui::move_param -component [ipx::current_core] -order 8 [ipgui::get_guiparamspec -name "S_AXI_USR_4_RUSER_WIDTH" -component [ipx::current_core]] -parent [ipgui::get_pagespec -name "Slave_Usr_4" -component [ipx::current_core]]
set_property enablement_tcl_expr {$NUM_SLAVE_BRIDGE >= 5} [ipx::get_user_parameters S_AXI_USR_4_PROTOCOL     -of_objects [ipx::current_core]]
set_property enablement_tcl_expr {$NUM_SLAVE_BRIDGE >= 5} [ipx::get_user_parameters S_AXI_USR_4_ADDR_WIDTH   -of_objects [ipx::current_core]]
set_property enablement_tcl_expr {$NUM_SLAVE_BRIDGE >= 5} [ipx::get_user_parameters S_AXI_USR_4_DATA_WIDTH   -of_objects [ipx::current_core]]
set_property enablement_tcl_expr {$NUM_SLAVE_BRIDGE >= 5} [ipx::get_user_parameters S_AXI_USR_4_ID_WIDTH     -of_objects [ipx::current_core]]
set_property enablement_tcl_expr {$NUM_SLAVE_BRIDGE >= 5} [ipx::get_user_parameters S_AXI_USR_4_AWUSER_WIDTH -of_objects [ipx::current_core]]
set_property enablement_tcl_expr {$NUM_SLAVE_BRIDGE >= 5} [ipx::get_user_parameters S_AXI_USR_4_WUSER_WIDTH  -of_objects [ipx::current_core]]
set_property enablement_tcl_expr {$NUM_SLAVE_BRIDGE >= 5} [ipx::get_user_parameters S_AXI_USR_4_BUSER_WIDTH  -of_objects [ipx::current_core]]
set_property enablement_tcl_expr {$NUM_SLAVE_BRIDGE >= 5} [ipx::get_user_parameters S_AXI_USR_4_ARUSER_WIDTH -of_objects [ipx::current_core]]
set_property enablement_tcl_expr {$NUM_SLAVE_BRIDGE >= 5} [ipx::get_user_parameters S_AXI_USR_4_RUSER_WIDTH  -of_objects [ipx::current_core]]


add_param S_AXI_USR_5_PROTOCOL              AXI4   "Usr Slave-5 AXI Protocol"                "S_5" STRING                        
add_param S_AXI_USR_5_ADDR_WIDTH            64     "Usr Slave-5 AXI address width"           "" LONG                             
add_param S_AXI_USR_5_DATA_WIDTH            128    "Usr Slave-5 AXI data idth"               "" LONG                         
add_param S_AXI_USR_5_ID_WIDTH              16     "Usr Slave-5 AXI ID width"                "" LONG                        
add_param S_AXI_USR_5_AWUSER_WIDTH          32     "Usr Slave-5 AXI AWuser width"            "" LONG                            
add_param S_AXI_USR_5_WUSER_WIDTH           32     "Usr Slave-5 AXI Wuser width"             "" LONG                           
add_param S_AXI_USR_5_BUSER_WIDTH           32     "Usr Slave-5 AXI Buser width"             "" LONG                           
add_param S_AXI_USR_5_ARUSER_WIDTH          32     "Usr Slave-5 AXI ARuser width"            "" LONG                            
add_param S_AXI_USR_5_RUSER_WIDTH           32     "Usr Slave-5 AXI Ruser width"             "" LONG                           

ipgui::add_param -name {S_AXI_USR_5_PROTOCOL} -component [ipx::current_core] -show_label {true} -show_range {true} -widget {}
ipgui::add_param -name {S_AXI_USR_5_ADDR_WIDTH} -component [ipx::current_core] -show_label {true} -show_range {true} -widget {}
ipgui::add_param -name {S_AXI_USR_5_DATA_WIDTH} -component [ipx::current_core] -show_label {true} -show_range {true} -widget {}
ipgui::add_param -name {S_AXI_USR_5_ID_WIDTH} -component [ipx::current_core] -show_label {true} -show_range {true} -widget {}
ipgui::add_param -name {S_AXI_USR_5_AWUSER_WIDTH} -component [ipx::current_core] -show_label {true} -show_range {true} -widget {}
ipgui::add_param -name {S_AXI_USR_5_ARUSER_WIDTH} -component [ipx::current_core] -show_label {true} -show_range {true} -widget {}
ipgui::add_param -name {S_AXI_USR_5_WUSER_WIDTH} -component [ipx::current_core] -show_label {true} -show_range {true} -widget {}
ipgui::add_param -name {S_AXI_USR_5_BUSER_WIDTH} -component [ipx::current_core] -show_label {true} -show_range {true} -widget {}
ipgui::add_param -name {S_AXI_USR_5_RUSER_WIDTH} -component [ipx::current_core] -show_label {true} -show_range {true} -widget {}
set_property widget {comboBox} [ipgui::get_guiparamspec -name "S_AXI_USR_5_PROTOCOL" -component [ipx::current_core] ]
set_property widget {comboBox} [ipgui::get_guiparamspec -name "S_AXI_USR_5_DATA_WIDTH" -component [ipx::current_core] ]
set_property value_validation_type pairs [ipx::get_user_parameters S_AXI_USR_5_PROTOCOL -of_objects [ipx::current_core]]
set_property value_validation_pairs {AXI4 AXI4 AXI4LITE AXI4LITE} [ipx::get_user_parameters S_AXI_USR_5_PROTOCOL -of_objects [ipx::current_core]]
set_property widget {textEdit} [ipgui::get_guiparamspec -name "S_AXI_USR_5_ADDR_WIDTH" -component [ipx::current_core] ]
set_property value_validation_range_minimum 4 [ipx::get_user_parameters S_AXI_USR_5_ADDR_WIDTH -of_objects [ipx::current_core]]
set_property value_validation_range_maximum 64 [ipx::get_user_parameters S_AXI_USR_5_ADDR_WIDTH -of_objects [ipx::current_core]]
set_property value_validation_list {32:32 64:64 128:128} [::ipx::get_user_parameters -of_objects  $::core S_AXI_USR_5_DATA_WIDTH]
set_property value_validation_list {32:32 64:64 128:128} [::ipx::get_hdl_parameters -of_objects  $::core S_AXI_USR_5_DATA_WIDTH]
set_property value_validation_type list [ipx::get_user_parameters S_AXI_USR_5_DATA_WIDTH -of_objects [ipx::current_core]]
set_property widget {textEdit} [ipgui::get_guiparamspec -name "S_AXI_USR_5_ID_WIDTH" -component [ipx::current_core] ]
set_property value_validation_range_minimum 1 [ipx::get_user_parameters S_AXI_USR_5_ID_WIDTH -of_objects [ipx::current_core]]
set_property value_validation_range_maximum 16 [ipx::get_user_parameters S_AXI_USR_5_ID_WIDTH -of_objects [ipx::current_core]]
set_property widget {textEdit} [ipgui::get_guiparamspec -name "S_AXI_USR_5_AWUSER_WIDTH" -component [ipx::current_core] ]
set_property value_validation_range_minimum 1 [ipx::get_user_parameters S_AXI_USR_5_AWUSER_WIDTH -of_objects [ipx::current_core]]
set_property value_validation_range_maximum 32 [ipx::get_user_parameters S_AXI_USR_5_AWUSER_WIDTH -of_objects [ipx::current_core]]
set_property widget {textEdit} [ipgui::get_guiparamspec -name "S_AXI_USR_5_ARUSER_WIDTH" -component [ipx::current_core] ]
set_property value_validation_range_minimum 1 [ipx::get_user_parameters S_AXI_USR_5_ARUSER_WIDTH -of_objects [ipx::current_core]]
set_property value_validation_range_maximum 32 [ipx::get_user_parameters S_AXI_USR_5_ARUSER_WIDTH -of_objects [ipx::current_core]]
set_property widget {textEdit} [ipgui::get_guiparamspec -name "S_AXI_USR_5_WUSER_WIDTH" -component [ipx::current_core] ]
set_property value_validation_range_minimum 1 [ipx::get_user_parameters S_AXI_USR_5_WUSER_WIDTH -of_objects [ipx::current_core]]
set_property value_validation_range_maximum 32 [ipx::get_user_parameters S_AXI_USR_5_WUSER_WIDTH -of_objects [ipx::current_core]]
set_property widget {textEdit} [ipgui::get_guiparamspec -name "S_AXI_USR_5_BUSER_WIDTH" -component [ipx::current_core] ]
set_property value_validation_range_minimum 1 [ipx::get_user_parameters S_AXI_USR_5_BUSER_WIDTH -of_objects [ipx::current_core]]
set_property value_validation_range_maximum 32 [ipx::get_user_parameters S_AXI_USR_5_BUSER_WIDTH -of_objects [ipx::current_core]]
set_property widget {textEdit} [ipgui::get_guiparamspec -name "S_AXI_USR_5_RUSER_WIDTH" -component [ipx::current_core] ]
set_property value_validation_range_minimum 1 [ipx::get_user_parameters S_AXI_USR_5_RUSER_WIDTH -of_objects [ipx::current_core]]
set_property value_validation_range_maximum 32 [ipx::get_user_parameters S_AXI_USR_5_RUSER_WIDTH -of_objects [ipx::current_core]]
ipgui::add_page -name {Slave_Usr_5} -component [ipx::current_core] -display_name {Slave_Usr_5}
ipgui::move_param -component [ipx::current_core] -order 0 [ipgui::get_guiparamspec -name "S_AXI_USR_5_PROTOCOL" -component [ipx::current_core]] -parent [ipgui::get_pagespec -name "Slave_Usr_5" -component [ipx::current_core]]
ipgui::move_param -component [ipx::current_core] -order 1 [ipgui::get_guiparamspec -name "S_AXI_USR_5_ADDR_WIDTH" -component [ipx::current_core]] -parent [ipgui::get_pagespec -name "Slave_Usr_5" -component [ipx::current_core]]
ipgui::move_param -component [ipx::current_core] -order 2 [ipgui::get_guiparamspec -name "S_AXI_USR_5_DATA_WIDTH" -component [ipx::current_core]] -parent [ipgui::get_pagespec -name "Slave_Usr_5" -component [ipx::current_core]]
ipgui::move_param -component [ipx::current_core] -order 3 [ipgui::get_guiparamspec -name "S_AXI_USR_5_ID_WIDTH" -component [ipx::current_core]] -parent [ipgui::get_pagespec -name "Slave_Usr_5" -component [ipx::current_core]]
ipgui::move_param -component [ipx::current_core] -order 4 [ipgui::get_guiparamspec -name "S_AXI_USR_5_AWUSER_WIDTH" -component [ipx::current_core]] -parent [ipgui::get_pagespec -name "Slave_Usr_5" -component [ipx::current_core]]
ipgui::move_param -component [ipx::current_core] -order 5 [ipgui::get_guiparamspec -name "S_AXI_USR_5_WUSER_WIDTH" -component [ipx::current_core]] -parent [ipgui::get_pagespec -name "Slave_Usr_5" -component [ipx::current_core]]
ipgui::move_param -component [ipx::current_core] -order 6 [ipgui::get_guiparamspec -name "S_AXI_USR_5_BUSER_WIDTH" -component [ipx::current_core]] -parent [ipgui::get_pagespec -name "Slave_Usr_5" -component [ipx::current_core]]
ipgui::move_param -component [ipx::current_core] -order 7 [ipgui::get_guiparamspec -name "S_AXI_USR_5_ARUSER_WIDTH" -component [ipx::current_core]] -parent [ipgui::get_pagespec -name "Slave_Usr_5" -component [ipx::current_core]]
ipgui::move_param -component [ipx::current_core] -order 8 [ipgui::get_guiparamspec -name "S_AXI_USR_5_RUSER_WIDTH" -component [ipx::current_core]] -parent [ipgui::get_pagespec -name "Slave_Usr_5" -component [ipx::current_core]]
set_property enablement_tcl_expr {$NUM_SLAVE_BRIDGE >= 6} [ipx::get_user_parameters S_AXI_USR_5_PROTOCOL     -of_objects [ipx::current_core]]
set_property enablement_tcl_expr {$NUM_SLAVE_BRIDGE >= 6} [ipx::get_user_parameters S_AXI_USR_5_ADDR_WIDTH   -of_objects [ipx::current_core]]
set_property enablement_tcl_expr {$NUM_SLAVE_BRIDGE >= 6} [ipx::get_user_parameters S_AXI_USR_5_DATA_WIDTH   -of_objects [ipx::current_core]]
set_property enablement_tcl_expr {$NUM_SLAVE_BRIDGE >= 6} [ipx::get_user_parameters S_AXI_USR_5_ID_WIDTH     -of_objects [ipx::current_core]]
set_property enablement_tcl_expr {$NUM_SLAVE_BRIDGE >= 6} [ipx::get_user_parameters S_AXI_USR_5_AWUSER_WIDTH -of_objects [ipx::current_core]]
set_property enablement_tcl_expr {$NUM_SLAVE_BRIDGE >= 6} [ipx::get_user_parameters S_AXI_USR_5_WUSER_WIDTH  -of_objects [ipx::current_core]]
set_property enablement_tcl_expr {$NUM_SLAVE_BRIDGE >= 6} [ipx::get_user_parameters S_AXI_USR_5_BUSER_WIDTH  -of_objects [ipx::current_core]]
set_property enablement_tcl_expr {$NUM_SLAVE_BRIDGE >= 6} [ipx::get_user_parameters S_AXI_USR_5_ARUSER_WIDTH -of_objects [ipx::current_core]]
set_property enablement_tcl_expr {$NUM_SLAVE_BRIDGE >= 6} [ipx::get_user_parameters S_AXI_USR_5_RUSER_WIDTH  -of_objects [ipx::current_core]]






set_property widget {textEdit} [ipgui::get_guiparamspec -name "PCIE_EP_LAST_BRIDGE" -component [ipx::current_core] ]
set_property value_validation_range_minimum 0 [ipx::get_user_parameters PCIE_EP_LAST_BRIDGE -of_objects [ipx::current_core]]
set_property value_validation_range_maximum 1 [ipx::get_user_parameters PCIE_EP_LAST_BRIDGE -of_objects [ipx::current_core]]


set_property widget {textEdit} [ipgui::get_guiparamspec -name "USR_RST_NUM" -component [ipx::current_core] ]
set_property value_validation_range_minimum 1 [ipx::get_user_parameters USR_RST_NUM -of_objects [ipx::current_core]]
set_property value_validation_range_maximum 31 [ipx::get_user_parameters USR_RST_NUM -of_objects [ipx::current_core]]

set_property widget {textEdit} [ipgui::get_guiparamspec -name "NUM_MASTER_BRIDGE" -component [ipx::current_core] ]
set_property value_validation_range_minimum 1 [ipx::get_user_parameters NUM_MASTER_BRIDGE -of_objects [ipx::current_core]]
set_property value_validation_range_maximum 6 [ipx::get_user_parameters NUM_MASTER_BRIDGE -of_objects [ipx::current_core]]

set_property widget {textEdit} [ipgui::get_guiparamspec -name "NUM_SLAVE_BRIDGE" -component [ipx::current_core] ]
set_property value_validation_range_minimum 0 [ipx::get_user_parameters NUM_SLAVE_BRIDGE -of_objects [ipx::current_core]]
set_property value_validation_range_maximum 6 [ipx::get_user_parameters NUM_SLAVE_BRIDGE -of_objects [ipx::current_core]]

set_property widget {textEdit} [ipgui::get_guiparamspec -name "M_AXI_ADDR_WIDTH" -component [ipx::current_core] ]
set_property value_validation_range_minimum 4 [ipx::get_user_parameters M_AXI_ADDR_WIDTH -of_objects [ipx::current_core]]
set_property value_validation_range_maximum 64 [ipx::get_user_parameters M_AXI_ADDR_WIDTH -of_objects [ipx::current_core]]

#Disable editing
set_property enablement_value false [ipx::get_user_parameters NUM_MASTER_BRIDGE -of_objects [ipx::current_core]]
set_property enablement_value false [ipx::get_user_parameters NUM_SLAVE_BRIDGE -of_objects [ipx::current_core]]

ipgui::remove_page -component [ipx::current_core] [ipgui::get_pagespec -name "Page 0" -component [ipx::current_core]]



# Ports
::ipx::remove_all_port $::core
::ipx::add_ports_from_hdl -top_level_hdl_file hdl/verilog/pcie_ep.v -top_module_name pcie_ep $::core

::ipx::add_bus_interface CLK.ACLK $::core
set_property bus_type_vlnv xilinx.com:signal:clock:1.0 [::ipx::get_bus_interfaces -of_objects $::core CLK.ACLK]
set_property abstraction_type_vlnv xilinx.com:signal:clock_rtl:1.0 [::ipx::get_bus_interfaces -of_objects $::core CLK.ACLK]
set_property interface_mode slave [::ipx::get_bus_interfaces -of_objects $::core CLK.ACLK]
set_property display_name clk [::ipx::get_bus_interfaces -of_objects $::core CLK.ACLK]
set_property description {Clock input} [::ipx::get_bus_interfaces -of_objects $::core CLK.ACLK]
::ipx::add_port_map CLK [::ipx::get_bus_interfaces -of_objects $::core CLK.ACLK]
set_property PHYSICAL_NAME clk [::ipx::get_port_maps -of_objects [::ipx::get_bus_interfaces -of_objects $::core CLK.ACLK] CLK]
add_bus_param CLK.ACLK ASSOCIATED_BUSIF "S_AXI_PCIE_M0:M_AXI_PCIE_M0:S_AXI_PCIE_M1:M_AXI_PCIE_M1:S_AXI_PCIE_M2:M_AXI_PCIE_M2:S_AXI_PCIE_M3:M_AXI_PCIE_M3:S_AXI_PCIE_M4:M_AXI_PCIE_M4:S_AXI_PCIE_M5:M_AXI_PCIE_M5:S_AXI_PCIE_S0:M_AXI_PCIE_S0:S_AXI_PCIE_S1:M_AXI_PCIE_S1:S_AXI_PCIE_S2:M_AXI_PCIE_S2:S_AXI_PCIE_S3:M_AXI_PCIE_S3:S_AXI_PCIE_S4:M_AXI_PCIE_S4:S_AXI_PCIE_S5:M_AXI_PCIE_S5:M_AXI4_USR_0:M_AXI4LITE_USR_0:M_AXI3_USR_0:M_AXI4_USR_1:M_AXI4LITE_USR_1:M_AXI3_USR_1:M_AXI4_USR_2:M_AXI4LITE_USR_2:M_AXI3_USR_2:M_AXI4_USR_3:M_AXI4LITE_USR_3:M_AXI3_USR_3:M_AXI4_USR_4:M_AXI4LITE_USR_4:M_AXI3_USR_4:M_AXI4_USR_5:M_AXI4LITE_USR_5:M_AXI3_USR_5:S_AXI4_USR_0:S_AXI4LITE_USR_0:S_AXI3_USR_0:S_AXI4_USR_1:S_AXI4LITE_USR_1:S_AXI3_USR_1:S_AXI4_USR_2:S_AXI4LITE_USR_2:S_AXI3_USR_2:S_AXI4_USR_3:S_AXI4LITE_USR_3:S_AXI3_USR_3:S_AXI4_USR_4:S_AXI4LITE_USR_4:S_AXI3_USR_4:S_AXI4_USR_5:S_AXI4LITE_USR_5:S_AXI3_USR_5" string



 
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

::ipx::add_bus_interface S_AXI_PCIE_M0 $::core
set_property bus_type_vlnv xilinx.com:interface:aximm:1.0 [::ipx::get_bus_interfaces -of_objects $::core S_AXI_PCIE_M0]
set_property abstraction_type_vlnv xilinx.com:interface:aximm_rtl:1.0 [::ipx::get_bus_interfaces -of_objects $::core S_AXI_PCIE_M0]
set_property interface_mode slave [::ipx::get_bus_interfaces -of_objects $::core S_AXI_PCIE_M0]
set_property display_name S_AXI_PCIE_M0 [::ipx::get_bus_interfaces -of_objects $::core S_AXI_PCIE_M0]
set_property description {Slave AXI4 Interface} [::ipx::get_bus_interfaces -of_objects $::core S_AXI_PCIE_M0]
::ipx::add_bus_interface M_AXI_PCIE_M0 $::core
set_property bus_type_vlnv xilinx.com:interface:aximm:1.0 [::ipx::get_bus_interfaces -of_objects $::core M_AXI_PCIE_M0]
set_property abstraction_type_vlnv xilinx.com:interface:aximm_rtl:1.0 [::ipx::get_bus_interfaces -of_objects $::core M_AXI_PCIE_M0]
set_property interface_mode master [::ipx::get_bus_interfaces -of_objects $::core M_AXI_PCIE_M0]
set_property display_name M_AXI_PCIE_M0 [::ipx::get_bus_interfaces -of_objects $::core M_AXI_PCIE_M0]
set_property description {Master AXI4 Interface} [::ipx::get_bus_interfaces -of_objects $::core M_AXI_PCIE_M0]
set_property enablement_presence "optional" [::ipx::get_bus_interfaces -of_objects $::core S_AXI_PCIE_M0]
set_property enablement_value "false" [::ipx::get_bus_interfaces -of_objects $::core S_AXI_PCIE_M0]
set_property enablement_resolve_type "dependent" [::ipx::get_bus_interfaces -of_objects $::core S_AXI_PCIE_M0]
set_property enablement_dependency {$NUM_MASTER_BRIDGE >= 1} [::ipx::get_bus_interfaces -of_objects $::core S_AXI_PCIE_M0]
set_property enablement_presence "optional" [::ipx::get_bus_interfaces -of_objects $::core M_AXI_PCIE_M0]
set_property enablement_value "false" [::ipx::get_bus_interfaces -of_objects $::core M_AXI_PCIE_M0]
set_property enablement_resolve_type "dependent" [::ipx::get_bus_interfaces -of_objects $::core M_AXI_PCIE_M0]
set_property enablement_dependency {$NUM_MASTER_BRIDGE >= 1} [::ipx::get_bus_interfaces -of_objects $::core M_AXI_PCIE_M0]


::ipx::add_bus_interface S_AXI_PCIE_M1 $::core
set_property bus_type_vlnv xilinx.com:interface:aximm:1.0 [::ipx::get_bus_interfaces -of_objects $::core S_AXI_PCIE_M1]
set_property abstraction_type_vlnv xilinx.com:interface:aximm_rtl:1.0 [::ipx::get_bus_interfaces -of_objects $::core S_AXI_PCIE_M1]
set_property interface_mode slave [::ipx::get_bus_interfaces -of_objects $::core S_AXI_PCIE_M1]
set_property display_name S_AXI_PCIE_M1 [::ipx::get_bus_interfaces -of_objects $::core S_AXI_PCIE_M1]
set_property description {Slave AXI4 Interface} [::ipx::get_bus_interfaces -of_objects $::core S_AXI_PCIE_M1]
::ipx::add_bus_interface M_AXI_PCIE_M1 $::core
set_property bus_type_vlnv xilinx.com:interface:aximm:1.0 [::ipx::get_bus_interfaces -of_objects $::core M_AXI_PCIE_M1]
set_property abstraction_type_vlnv xilinx.com:interface:aximm_rtl:1.0 [::ipx::get_bus_interfaces -of_objects $::core M_AXI_PCIE_M1]
set_property interface_mode master [::ipx::get_bus_interfaces -of_objects $::core M_AXI_PCIE_M1]
set_property display_name M_AXI_PCIE_M1 [::ipx::get_bus_interfaces -of_objects $::core M_AXI_PCIE_M1]
set_property description {Master AXI4 Interface} [::ipx::get_bus_interfaces -of_objects $::core M_AXI_PCIE_M1]
set_property enablement_presence "optional" [::ipx::get_bus_interfaces -of_objects $::core S_AXI_PCIE_M1]
set_property enablement_value "false" [::ipx::get_bus_interfaces -of_objects $::core S_AXI_PCIE_M1]
set_property enablement_resolve_type "dependent" [::ipx::get_bus_interfaces -of_objects $::core S_AXI_PCIE_M1]
set_property enablement_dependency {$NUM_MASTER_BRIDGE >= 2} [::ipx::get_bus_interfaces -of_objects $::core S_AXI_PCIE_M1]
set_property enablement_presence "optional" [::ipx::get_bus_interfaces -of_objects $::core M_AXI_PCIE_M1]
set_property enablement_value "false" [::ipx::get_bus_interfaces -of_objects $::core M_AXI_PCIE_M1]
set_property enablement_resolve_type "dependent" [::ipx::get_bus_interfaces -of_objects $::core M_AXI_PCIE_M1]
set_property enablement_dependency {$NUM_MASTER_BRIDGE >= 2} [::ipx::get_bus_interfaces -of_objects $::core M_AXI_PCIE_M1]


::ipx::add_bus_interface S_AXI_PCIE_M2 $::core
set_property bus_type_vlnv xilinx.com:interface:aximm:1.0 [::ipx::get_bus_interfaces -of_objects $::core S_AXI_PCIE_M2]
set_property abstraction_type_vlnv xilinx.com:interface:aximm_rtl:1.0 [::ipx::get_bus_interfaces -of_objects $::core S_AXI_PCIE_M2]
set_property interface_mode slave [::ipx::get_bus_interfaces -of_objects $::core S_AXI_PCIE_M2]
set_property display_name S_AXI_PCIE_M2 [::ipx::get_bus_interfaces -of_objects $::core S_AXI_PCIE_M2]
set_property description {Slave AXI4 Interface} [::ipx::get_bus_interfaces -of_objects $::core S_AXI_PCIE_M2]
::ipx::add_bus_interface M_AXI_PCIE_M2 $::core
set_property bus_type_vlnv xilinx.com:interface:aximm:1.0 [::ipx::get_bus_interfaces -of_objects $::core M_AXI_PCIE_M2]
set_property abstraction_type_vlnv xilinx.com:interface:aximm_rtl:1.0 [::ipx::get_bus_interfaces -of_objects $::core M_AXI_PCIE_M2]
set_property interface_mode master [::ipx::get_bus_interfaces -of_objects $::core M_AXI_PCIE_M2]
set_property display_name M_AXI_PCIE_M2 [::ipx::get_bus_interfaces -of_objects $::core M_AXI_PCIE_M2]
set_property description {Master AXI4 Interface} [::ipx::get_bus_interfaces -of_objects $::core M_AXI_PCIE_M2]
set_property enablement_presence "optional" [::ipx::get_bus_interfaces -of_objects $::core S_AXI_PCIE_M2]
set_property enablement_value "false" [::ipx::get_bus_interfaces -of_objects $::core S_AXI_PCIE_M2]
set_property enablement_resolve_type "dependent" [::ipx::get_bus_interfaces -of_objects $::core S_AXI_PCIE_M2]
set_property enablement_dependency {$NUM_MASTER_BRIDGE >= 3} [::ipx::get_bus_interfaces -of_objects $::core S_AXI_PCIE_M2]
set_property enablement_presence "optional" [::ipx::get_bus_interfaces -of_objects $::core M_AXI_PCIE_M2]
set_property enablement_value "false" [::ipx::get_bus_interfaces -of_objects $::core M_AXI_PCIE_M2]
set_property enablement_resolve_type "dependent" [::ipx::get_bus_interfaces -of_objects $::core M_AXI_PCIE_M2]
set_property enablement_dependency {$NUM_MASTER_BRIDGE >= 3} [::ipx::get_bus_interfaces -of_objects $::core M_AXI_PCIE_M2]


::ipx::add_bus_interface S_AXI_PCIE_M3 $::core
set_property bus_type_vlnv xilinx.com:interface:aximm:1.0 [::ipx::get_bus_interfaces -of_objects $::core S_AXI_PCIE_M3]
set_property abstraction_type_vlnv xilinx.com:interface:aximm_rtl:1.0 [::ipx::get_bus_interfaces -of_objects $::core S_AXI_PCIE_M3]
set_property interface_mode slave [::ipx::get_bus_interfaces -of_objects $::core S_AXI_PCIE_M3]
set_property display_name S_AXI_PCIE_M3 [::ipx::get_bus_interfaces -of_objects $::core S_AXI_PCIE_M3]
set_property description {Slave AXI4 Interface} [::ipx::get_bus_interfaces -of_objects $::core S_AXI_PCIE_M3]
::ipx::add_bus_interface M_AXI_PCIE_M3 $::core
set_property bus_type_vlnv xilinx.com:interface:aximm:1.0 [::ipx::get_bus_interfaces -of_objects $::core M_AXI_PCIE_M3]
set_property abstraction_type_vlnv xilinx.com:interface:aximm_rtl:1.0 [::ipx::get_bus_interfaces -of_objects $::core M_AXI_PCIE_M3]
set_property interface_mode master [::ipx::get_bus_interfaces -of_objects $::core M_AXI_PCIE_M3]
set_property display_name M_AXI_PCIE_M3 [::ipx::get_bus_interfaces -of_objects $::core M_AXI_PCIE_M3]
set_property description {Master AXI4 Interface} [::ipx::get_bus_interfaces -of_objects $::core M_AXI_PCIE_M3]
set_property enablement_presence "optional" [::ipx::get_bus_interfaces -of_objects $::core S_AXI_PCIE_M3]
set_property enablement_value "false" [::ipx::get_bus_interfaces -of_objects $::core S_AXI_PCIE_M3]
set_property enablement_resolve_type "dependent" [::ipx::get_bus_interfaces -of_objects $::core S_AXI_PCIE_M3]
set_property enablement_dependency {$NUM_MASTER_BRIDGE >= 4} [::ipx::get_bus_interfaces -of_objects $::core S_AXI_PCIE_M3]
set_property enablement_presence "optional" [::ipx::get_bus_interfaces -of_objects $::core M_AXI_PCIE_M3]
set_property enablement_value "false" [::ipx::get_bus_interfaces -of_objects $::core M_AXI_PCIE_M3]
set_property enablement_resolve_type "dependent" [::ipx::get_bus_interfaces -of_objects $::core M_AXI_PCIE_M3]
set_property enablement_dependency {$NUM_MASTER_BRIDGE >= 4} [::ipx::get_bus_interfaces -of_objects $::core M_AXI_PCIE_M3]


::ipx::add_bus_interface S_AXI_PCIE_M4 $::core
set_property bus_type_vlnv xilinx.com:interface:aximm:1.0 [::ipx::get_bus_interfaces -of_objects $::core S_AXI_PCIE_M4]
set_property abstraction_type_vlnv xilinx.com:interface:aximm_rtl:1.0 [::ipx::get_bus_interfaces -of_objects $::core S_AXI_PCIE_M4]
set_property interface_mode slave [::ipx::get_bus_interfaces -of_objects $::core S_AXI_PCIE_M4]
set_property display_name S_AXI_PCIE_M4 [::ipx::get_bus_interfaces -of_objects $::core S_AXI_PCIE_M4]
set_property description {Slave AXI4 Interface} [::ipx::get_bus_interfaces -of_objects $::core S_AXI_PCIE_M4]
::ipx::add_bus_interface M_AXI_PCIE_M4 $::core
set_property bus_type_vlnv xilinx.com:interface:aximm:1.0 [::ipx::get_bus_interfaces -of_objects $::core M_AXI_PCIE_M4]
set_property abstraction_type_vlnv xilinx.com:interface:aximm_rtl:1.0 [::ipx::get_bus_interfaces -of_objects $::core M_AXI_PCIE_M4]
set_property interface_mode master [::ipx::get_bus_interfaces -of_objects $::core M_AXI_PCIE_M4]
set_property display_name M_AXI_PCIE_M4 [::ipx::get_bus_interfaces -of_objects $::core M_AXI_PCIE_M4]
set_property description {Master AXI4 Interface} [::ipx::get_bus_interfaces -of_objects $::core M_AXI_PCIE_M4]
set_property enablement_presence "optional" [::ipx::get_bus_interfaces -of_objects $::core S_AXI_PCIE_M4]
set_property enablement_value "false" [::ipx::get_bus_interfaces -of_objects $::core S_AXI_PCIE_M4]
set_property enablement_resolve_type "dependent" [::ipx::get_bus_interfaces -of_objects $::core S_AXI_PCIE_M4]
set_property enablement_dependency {$NUM_MASTER_BRIDGE >= 5} [::ipx::get_bus_interfaces -of_objects $::core S_AXI_PCIE_M4]
set_property enablement_presence "optional" [::ipx::get_bus_interfaces -of_objects $::core M_AXI_PCIE_M4]
set_property enablement_value "false" [::ipx::get_bus_interfaces -of_objects $::core M_AXI_PCIE_M4]
set_property enablement_resolve_type "dependent" [::ipx::get_bus_interfaces -of_objects $::core M_AXI_PCIE_M4]
set_property enablement_dependency {$NUM_MASTER_BRIDGE >= 5} [::ipx::get_bus_interfaces -of_objects $::core M_AXI_PCIE_M4]


::ipx::add_bus_interface S_AXI_PCIE_M5 $::core
set_property bus_type_vlnv xilinx.com:interface:aximm:1.0 [::ipx::get_bus_interfaces -of_objects $::core S_AXI_PCIE_M5]
set_property abstraction_type_vlnv xilinx.com:interface:aximm_rtl:1.0 [::ipx::get_bus_interfaces -of_objects $::core S_AXI_PCIE_M5]
set_property interface_mode slave [::ipx::get_bus_interfaces -of_objects $::core S_AXI_PCIE_M5]
set_property display_name S_AXI_PCIE_M5 [::ipx::get_bus_interfaces -of_objects $::core S_AXI_PCIE_M5]
set_property description {Slave AXI4 Interface} [::ipx::get_bus_interfaces -of_objects $::core S_AXI_PCIE_M5]
::ipx::add_bus_interface M_AXI_PCIE_M5 $::core
set_property bus_type_vlnv xilinx.com:interface:aximm:1.0 [::ipx::get_bus_interfaces -of_objects $::core M_AXI_PCIE_M5]
set_property abstraction_type_vlnv xilinx.com:interface:aximm_rtl:1.0 [::ipx::get_bus_interfaces -of_objects $::core M_AXI_PCIE_M5]
set_property interface_mode master [::ipx::get_bus_interfaces -of_objects $::core M_AXI_PCIE_M5]
set_property display_name M_AXI_PCIE_M5 [::ipx::get_bus_interfaces -of_objects $::core M_AXI_PCIE_M5]
set_property description {Master AXI4 Interface} [::ipx::get_bus_interfaces -of_objects $::core M_AXI_PCIE_M5]
set_property enablement_presence "optional" [::ipx::get_bus_interfaces -of_objects $::core S_AXI_PCIE_M5]
set_property enablement_value "false" [::ipx::get_bus_interfaces -of_objects $::core S_AXI_PCIE_M5]
set_property enablement_resolve_type "dependent" [::ipx::get_bus_interfaces -of_objects $::core S_AXI_PCIE_M5]
set_property enablement_dependency {$NUM_MASTER_BRIDGE >= 6} [::ipx::get_bus_interfaces -of_objects $::core S_AXI_PCIE_M5]
set_property enablement_presence "optional" [::ipx::get_bus_interfaces -of_objects $::core M_AXI_PCIE_M5]
set_property enablement_value "false" [::ipx::get_bus_interfaces -of_objects $::core M_AXI_PCIE_M5]
set_property enablement_resolve_type "dependent" [::ipx::get_bus_interfaces -of_objects $::core M_AXI_PCIE_M5]
set_property enablement_dependency {$NUM_MASTER_BRIDGE >= 6} [::ipx::get_bus_interfaces -of_objects $::core M_AXI_PCIE_M5]


::ipx::add_bus_interface S_AXI_PCIE_S0 $::core
set_property bus_type_vlnv xilinx.com:interface:aximm:1.0 [::ipx::get_bus_interfaces -of_objects $::core S_AXI_PCIE_S0]
set_property abstraction_type_vlnv xilinx.com:interface:aximm_rtl:1.0 [::ipx::get_bus_interfaces -of_objects $::core S_AXI_PCIE_S0]
set_property interface_mode slave [::ipx::get_bus_interfaces -of_objects $::core S_AXI_PCIE_S0]
set_property display_name S_AXI_PCIE_S0 [::ipx::get_bus_interfaces -of_objects $::core S_AXI_PCIE_S0]
set_property description {Slave AXI4 Interface} [::ipx::get_bus_interfaces -of_objects $::core S_AXI_PCIE_S0]
::ipx::add_bus_interface M_AXI_PCIE_S0 $::core
set_property bus_type_vlnv xilinx.com:interface:aximm:1.0 [::ipx::get_bus_interfaces -of_objects $::core M_AXI_PCIE_S0]
set_property abstraction_type_vlnv xilinx.com:interface:aximm_rtl:1.0 [::ipx::get_bus_interfaces -of_objects $::core M_AXI_PCIE_S0]
set_property interface_mode master [::ipx::get_bus_interfaces -of_objects $::core M_AXI_PCIE_S0]
set_property display_name M_AXI_PCIE_S0 [::ipx::get_bus_interfaces -of_objects $::core M_AXI_PCIE_S0]
set_property description {Master AXI4 Interface} [::ipx::get_bus_interfaces -of_objects $::core M_AXI_PCIE_S0]
set_property enablement_presence "optional" [::ipx::get_bus_interfaces -of_objects $::core S_AXI_PCIE_S0]
set_property enablement_value "false" [::ipx::get_bus_interfaces -of_objects $::core S_AXI_PCIE_S0]
set_property enablement_resolve_type "dependent" [::ipx::get_bus_interfaces -of_objects $::core S_AXI_PCIE_S0]
set_property enablement_dependency {$NUM_SLAVE_BRIDGE >= 1} [::ipx::get_bus_interfaces -of_objects $::core S_AXI_PCIE_S0]
set_property enablement_presence "optional" [::ipx::get_bus_interfaces -of_objects $::core M_AXI_PCIE_S0]
set_property enablement_value "false" [::ipx::get_bus_interfaces -of_objects $::core M_AXI_PCIE_S0]
set_property enablement_resolve_type "dependent" [::ipx::get_bus_interfaces -of_objects $::core M_AXI_PCIE_S0]
set_property enablement_dependency {$NUM_SLAVE_BRIDGE >= 1} [::ipx::get_bus_interfaces -of_objects $::core M_AXI_PCIE_S0]


::ipx::add_bus_interface S_AXI_PCIE_S1 $::core
set_property bus_type_vlnv xilinx.com:interface:aximm:1.0 [::ipx::get_bus_interfaces -of_objects $::core S_AXI_PCIE_S1]
set_property abstraction_type_vlnv xilinx.com:interface:aximm_rtl:1.0 [::ipx::get_bus_interfaces -of_objects $::core S_AXI_PCIE_S1]
set_property interface_mode slave [::ipx::get_bus_interfaces -of_objects $::core S_AXI_PCIE_S1]
set_property display_name S_AXI_PCIE_S1 [::ipx::get_bus_interfaces -of_objects $::core S_AXI_PCIE_S1]
set_property description {Slave AXI4 Interface} [::ipx::get_bus_interfaces -of_objects $::core S_AXI_PCIE_S1]
::ipx::add_bus_interface M_AXI_PCIE_S1 $::core
set_property bus_type_vlnv xilinx.com:interface:aximm:1.0 [::ipx::get_bus_interfaces -of_objects $::core M_AXI_PCIE_S1]
set_property abstraction_type_vlnv xilinx.com:interface:aximm_rtl:1.0 [::ipx::get_bus_interfaces -of_objects $::core M_AXI_PCIE_S1]
set_property interface_mode master [::ipx::get_bus_interfaces -of_objects $::core M_AXI_PCIE_S1]
set_property display_name M_AXI_PCIE_S1 [::ipx::get_bus_interfaces -of_objects $::core M_AXI_PCIE_S1]
set_property description {Master AXI4 Interface} [::ipx::get_bus_interfaces -of_objects $::core M_AXI_PCIE_S1]
set_property enablement_presence "optional" [::ipx::get_bus_interfaces -of_objects $::core S_AXI_PCIE_S1]
set_property enablement_value "false" [::ipx::get_bus_interfaces -of_objects $::core S_AXI_PCIE_S1]
set_property enablement_resolve_type "dependent" [::ipx::get_bus_interfaces -of_objects $::core S_AXI_PCIE_S1]
set_property enablement_dependency {$NUM_SLAVE_BRIDGE >= 2} [::ipx::get_bus_interfaces -of_objects $::core S_AXI_PCIE_S1]
set_property enablement_presence "optional" [::ipx::get_bus_interfaces -of_objects $::core M_AXI_PCIE_S1]
set_property enablement_value "false" [::ipx::get_bus_interfaces -of_objects $::core M_AXI_PCIE_S1]
set_property enablement_resolve_type "dependent" [::ipx::get_bus_interfaces -of_objects $::core M_AXI_PCIE_S1]
set_property enablement_dependency {$NUM_SLAVE_BRIDGE >= 2} [::ipx::get_bus_interfaces -of_objects $::core M_AXI_PCIE_S1]

::ipx::add_bus_interface S_AXI_PCIE_S2 $::core
set_property bus_type_vlnv xilinx.com:interface:aximm:1.0 [::ipx::get_bus_interfaces -of_objects $::core S_AXI_PCIE_S2]
set_property abstraction_type_vlnv xilinx.com:interface:aximm_rtl:1.0 [::ipx::get_bus_interfaces -of_objects $::core S_AXI_PCIE_S2]
set_property interface_mode slave [::ipx::get_bus_interfaces -of_objects $::core S_AXI_PCIE_S2]
set_property display_name S_AXI_PCIE_S2 [::ipx::get_bus_interfaces -of_objects $::core S_AXI_PCIE_S2]
set_property description {Slave AXI4 Interface} [::ipx::get_bus_interfaces -of_objects $::core S_AXI_PCIE_S2]
::ipx::add_bus_interface M_AXI_PCIE_S2 $::core
set_property bus_type_vlnv xilinx.com:interface:aximm:1.0 [::ipx::get_bus_interfaces -of_objects $::core M_AXI_PCIE_S2]
set_property abstraction_type_vlnv xilinx.com:interface:aximm_rtl:1.0 [::ipx::get_bus_interfaces -of_objects $::core M_AXI_PCIE_S2]
set_property interface_mode master [::ipx::get_bus_interfaces -of_objects $::core M_AXI_PCIE_S2]
set_property display_name M_AXI_PCIE_S2 [::ipx::get_bus_interfaces -of_objects $::core M_AXI_PCIE_S2]
set_property description {Master AXI4 Interface} [::ipx::get_bus_interfaces -of_objects $::core M_AXI_PCIE_S2]
set_property enablement_presence "optional" [::ipx::get_bus_interfaces -of_objects $::core S_AXI_PCIE_S2]
set_property enablement_value "false" [::ipx::get_bus_interfaces -of_objects $::core S_AXI_PCIE_S2]
set_property enablement_resolve_type "dependent" [::ipx::get_bus_interfaces -of_objects $::core S_AXI_PCIE_S2]
set_property enablement_dependency {$NUM_SLAVE_BRIDGE >= 3} [::ipx::get_bus_interfaces -of_objects $::core S_AXI_PCIE_S2]
set_property enablement_presence "optional" [::ipx::get_bus_interfaces -of_objects $::core M_AXI_PCIE_S2]
set_property enablement_value "false" [::ipx::get_bus_interfaces -of_objects $::core M_AXI_PCIE_S2]
set_property enablement_resolve_type "dependent" [::ipx::get_bus_interfaces -of_objects $::core M_AXI_PCIE_S2]
set_property enablement_dependency {$NUM_SLAVE_BRIDGE >= 3} [::ipx::get_bus_interfaces -of_objects $::core M_AXI_PCIE_S2]

::ipx::add_bus_interface S_AXI_PCIE_S3 $::core
set_property bus_type_vlnv xilinx.com:interface:aximm:1.0 [::ipx::get_bus_interfaces -of_objects $::core S_AXI_PCIE_S3]
set_property abstraction_type_vlnv xilinx.com:interface:aximm_rtl:1.0 [::ipx::get_bus_interfaces -of_objects $::core S_AXI_PCIE_S3]
set_property interface_mode slave [::ipx::get_bus_interfaces -of_objects $::core S_AXI_PCIE_S3]
set_property display_name S_AXI_PCIE_S3 [::ipx::get_bus_interfaces -of_objects $::core S_AXI_PCIE_S3]
set_property description {Slave AXI4 Interface} [::ipx::get_bus_interfaces -of_objects $::core S_AXI_PCIE_S3]
::ipx::add_bus_interface M_AXI_PCIE_S3 $::core
set_property bus_type_vlnv xilinx.com:interface:aximm:1.0 [::ipx::get_bus_interfaces -of_objects $::core M_AXI_PCIE_S3]
set_property abstraction_type_vlnv xilinx.com:interface:aximm_rtl:1.0 [::ipx::get_bus_interfaces -of_objects $::core M_AXI_PCIE_S3]
set_property interface_mode master [::ipx::get_bus_interfaces -of_objects $::core M_AXI_PCIE_S3]
set_property display_name M_AXI_PCIE_S3 [::ipx::get_bus_interfaces -of_objects $::core M_AXI_PCIE_S3]
set_property description {Master AXI4 Interface} [::ipx::get_bus_interfaces -of_objects $::core M_AXI_PCIE_S3]
set_property enablement_presence "optional" [::ipx::get_bus_interfaces -of_objects $::core S_AXI_PCIE_S3]
set_property enablement_value "false" [::ipx::get_bus_interfaces -of_objects $::core S_AXI_PCIE_S3]
set_property enablement_resolve_type "dependent" [::ipx::get_bus_interfaces -of_objects $::core S_AXI_PCIE_S3]
set_property enablement_dependency {$NUM_SLAVE_BRIDGE >= 4} [::ipx::get_bus_interfaces -of_objects $::core S_AXI_PCIE_S3]
set_property enablement_presence "optional" [::ipx::get_bus_interfaces -of_objects $::core M_AXI_PCIE_S3]
set_property enablement_value "false" [::ipx::get_bus_interfaces -of_objects $::core M_AXI_PCIE_S3]
set_property enablement_resolve_type "dependent" [::ipx::get_bus_interfaces -of_objects $::core M_AXI_PCIE_S3]
set_property enablement_dependency {$NUM_SLAVE_BRIDGE >= 4} [::ipx::get_bus_interfaces -of_objects $::core M_AXI_PCIE_S3]


::ipx::add_bus_interface S_AXI_PCIE_S4 $::core
set_property bus_type_vlnv xilinx.com:interface:aximm:1.0 [::ipx::get_bus_interfaces -of_objects $::core S_AXI_PCIE_S4]
set_property abstraction_type_vlnv xilinx.com:interface:aximm_rtl:1.0 [::ipx::get_bus_interfaces -of_objects $::core S_AXI_PCIE_S4]
set_property interface_mode slave [::ipx::get_bus_interfaces -of_objects $::core S_AXI_PCIE_S4]
set_property display_name S_AXI_PCIE_S4 [::ipx::get_bus_interfaces -of_objects $::core S_AXI_PCIE_S4]
set_property description {Slave AXI4 Interface} [::ipx::get_bus_interfaces -of_objects $::core S_AXI_PCIE_S4]
::ipx::add_bus_interface M_AXI_PCIE_S4 $::core
set_property bus_type_vlnv xilinx.com:interface:aximm:1.0 [::ipx::get_bus_interfaces -of_objects $::core M_AXI_PCIE_S4]
set_property abstraction_type_vlnv xilinx.com:interface:aximm_rtl:1.0 [::ipx::get_bus_interfaces -of_objects $::core M_AXI_PCIE_S4]
set_property interface_mode master [::ipx::get_bus_interfaces -of_objects $::core M_AXI_PCIE_S4]
set_property display_name M_AXI_PCIE_S4 [::ipx::get_bus_interfaces -of_objects $::core M_AXI_PCIE_S4]
set_property description {Master AXI4 Interface} [::ipx::get_bus_interfaces -of_objects $::core M_AXI_PCIE_S4]
set_property enablement_presence "optional" [::ipx::get_bus_interfaces -of_objects $::core S_AXI_PCIE_S4]
set_property enablement_value "false" [::ipx::get_bus_interfaces -of_objects $::core S_AXI_PCIE_S4]
set_property enablement_resolve_type "dependent" [::ipx::get_bus_interfaces -of_objects $::core S_AXI_PCIE_S4]
set_property enablement_dependency {$NUM_SLAVE_BRIDGE >= 5} [::ipx::get_bus_interfaces -of_objects $::core S_AXI_PCIE_S4]
set_property enablement_presence "optional" [::ipx::get_bus_interfaces -of_objects $::core M_AXI_PCIE_S4]
set_property enablement_value "false" [::ipx::get_bus_interfaces -of_objects $::core M_AXI_PCIE_S4]
set_property enablement_resolve_type "dependent" [::ipx::get_bus_interfaces -of_objects $::core M_AXI_PCIE_S4]
set_property enablement_dependency {$NUM_SLAVE_BRIDGE >= 5} [::ipx::get_bus_interfaces -of_objects $::core M_AXI_PCIE_S4]

::ipx::add_bus_interface S_AXI_PCIE_S5 $::core
set_property bus_type_vlnv xilinx.com:interface:aximm:1.0 [::ipx::get_bus_interfaces -of_objects $::core S_AXI_PCIE_S5]
set_property abstraction_type_vlnv xilinx.com:interface:aximm_rtl:1.0 [::ipx::get_bus_interfaces -of_objects $::core S_AXI_PCIE_S5]
set_property interface_mode slave [::ipx::get_bus_interfaces -of_objects $::core S_AXI_PCIE_S5]
set_property display_name S_AXI_PCIE_S5 [::ipx::get_bus_interfaces -of_objects $::core S_AXI_PCIE_S5]
set_property description {Slave AXI4 Interface} [::ipx::get_bus_interfaces -of_objects $::core S_AXI_PCIE_S5]
::ipx::add_bus_interface M_AXI_PCIE_S5 $::core
set_property bus_type_vlnv xilinx.com:interface:aximm:1.0 [::ipx::get_bus_interfaces -of_objects $::core M_AXI_PCIE_S5]
set_property abstraction_type_vlnv xilinx.com:interface:aximm_rtl:1.0 [::ipx::get_bus_interfaces -of_objects $::core M_AXI_PCIE_S5]
set_property interface_mode master [::ipx::get_bus_interfaces -of_objects $::core M_AXI_PCIE_S5]
set_property display_name M_AXI_PCIE_S5 [::ipx::get_bus_interfaces -of_objects $::core M_AXI_PCIE_S5]
set_property description {Master AXI4 Interface} [::ipx::get_bus_interfaces -of_objects $::core M_AXI_PCIE_S5]
set_property enablement_presence "optional" [::ipx::get_bus_interfaces -of_objects $::core S_AXI_PCIE_S5]
set_property enablement_value "false" [::ipx::get_bus_interfaces -of_objects $::core S_AXI_PCIE_S5]
set_property enablement_resolve_type "dependent" [::ipx::get_bus_interfaces -of_objects $::core S_AXI_PCIE_S5]
set_property enablement_dependency {$NUM_SLAVE_BRIDGE >= 6} [::ipx::get_bus_interfaces -of_objects $::core S_AXI_PCIE_S5]
set_property enablement_presence "optional" [::ipx::get_bus_interfaces -of_objects $::core M_AXI_PCIE_S5]
set_property enablement_value "false" [::ipx::get_bus_interfaces -of_objects $::core M_AXI_PCIE_S5]
set_property enablement_resolve_type "dependent" [::ipx::get_bus_interfaces -of_objects $::core M_AXI_PCIE_S5]
set_property enablement_dependency {$NUM_SLAVE_BRIDGE >= 6} [::ipx::get_bus_interfaces -of_objects $::core M_AXI_PCIE_S5]

::ipx::add_bus_interface M_AXI4_USR_0 $::core
set_property bus_type_vlnv xilinx.com:interface:aximm:1.0 [::ipx::get_bus_interfaces -of_objects $::core M_AXI4_USR_0]
set_property abstraction_type_vlnv xilinx.com:interface:aximm_rtl:1.0 [::ipx::get_bus_interfaces -of_objects $::core M_AXI4_USR_0]
set_property interface_mode master [::ipx::get_bus_interfaces -of_objects $::core M_AXI4_USR_0]
set_property display_name M_AXI4_USR_0 [::ipx::get_bus_interfaces -of_objects $::core M_AXI4_USR_0]
set_property description {Master User AXI Interface} [::ipx::get_bus_interfaces -of_objects $::core M_AXI4_USR_0]
set_property enablement_presence "optional" [::ipx::get_bus_interfaces -of_objects $::core M_AXI4_USR_0]
set_property enablement_value "false" [::ipx::get_bus_interfaces -of_objects $::core M_AXI4_USR_0]
set_property enablement_resolve_type "dependent" [::ipx::get_bus_interfaces -of_objects $::core M_AXI4_USR_0]
set_property enablement_dependency {$M_AXI_USR_0_PROTOCOL == "AXI4" and $NUM_MASTER_BRIDGE >= 1} [::ipx::get_bus_interfaces -of_objects $::core M_AXI4_USR_0]

::ipx::add_bus_interface M_AXI4LITE_USR_0 $::core
set_property bus_type_vlnv xilinx.com:interface:aximm:1.0 [::ipx::get_bus_interfaces -of_objects $::core M_AXI4LITE_USR_0]
set_property abstraction_type_vlnv xilinx.com:interface:aximm_rtl:1.0 [::ipx::get_bus_interfaces -of_objects $::core M_AXI4LITE_USR_0]
set_property interface_mode master [::ipx::get_bus_interfaces -of_objects $::core M_AXI4LITE_USR_0]
set_property display_name M_AXI4LITE_USR_0 [::ipx::get_bus_interfaces -of_objects $::core M_AXI4LITE_USR_0]
set_property description {Master User AXI Interface} [::ipx::get_bus_interfaces -of_objects $::core M_AXI4LITE_USR_0]
set_property enablement_presence "optional" [::ipx::get_bus_interfaces -of_objects $::core M_AXI4LITE_USR_0]
set_property enablement_value "false" [::ipx::get_bus_interfaces -of_objects $::core M_AXI4LITE_USR_0]
set_property enablement_resolve_type "dependent" [::ipx::get_bus_interfaces -of_objects $::core M_AXI4LITE_USR_0]
set_property enablement_dependency {$M_AXI_USR_0_PROTOCOL == "AXI4LITE" and $NUM_MASTER_BRIDGE >= 1} [::ipx::get_bus_interfaces -of_objects $::core M_AXI4LITE_USR_0]

::ipx::add_bus_interface M_AXI3_USR_0 $::core
set_property bus_type_vlnv xilinx.com:interface:aximm:1.0 [::ipx::get_bus_interfaces -of_objects $::core M_AXI3_USR_0]
set_property abstraction_type_vlnv xilinx.com:interface:aximm_rtl:1.0 [::ipx::get_bus_interfaces -of_objects $::core M_AXI3_USR_0]
set_property interface_mode master [::ipx::get_bus_interfaces -of_objects $::core M_AXI3_USR_0]
set_property display_name M_AXI3_USR_0 [::ipx::get_bus_interfaces -of_objects $::core M_AXI3_USR_0]
set_property description {Master User AXI Interface} [::ipx::get_bus_interfaces -of_objects $::core M_AXI3_USR_0]
set_property enablement_presence "optional" [::ipx::get_bus_interfaces -of_objects $::core M_AXI3_USR_0]
set_property enablement_value "false" [::ipx::get_bus_interfaces -of_objects $::core M_AXI3_USR_0]
set_property enablement_resolve_type "dependent" [::ipx::get_bus_interfaces -of_objects $::core M_AXI3_USR_0]
set_property enablement_dependency {$M_AXI_USR_0_PROTOCOL == "AXI3" and $NUM_MASTER_BRIDGE >= 1} [::ipx::get_bus_interfaces -of_objects $::core M_AXI3_USR_0]


::ipx::add_bus_interface M_AXI4_USR_1 $::core
set_property bus_type_vlnv xilinx.com:interface:aximm:1.0 [::ipx::get_bus_interfaces -of_objects $::core M_AXI4_USR_1]
set_property abstraction_type_vlnv xilinx.com:interface:aximm_rtl:1.0 [::ipx::get_bus_interfaces -of_objects $::core M_AXI4_USR_1]
set_property interface_mode master [::ipx::get_bus_interfaces -of_objects $::core M_AXI4_USR_1]
set_property display_name M_AXI4_USR_1 [::ipx::get_bus_interfaces -of_objects $::core M_AXI4_USR_1]
set_property description {Master User AXI Interface} [::ipx::get_bus_interfaces -of_objects $::core M_AXI4_USR_1]
set_property enablement_presence "optional" [::ipx::get_bus_interfaces -of_objects $::core M_AXI4_USR_1]
set_property enablement_value "false" [::ipx::get_bus_interfaces -of_objects $::core M_AXI4_USR_1]
set_property enablement_resolve_type "dependent" [::ipx::get_bus_interfaces -of_objects $::core M_AXI4_USR_1]
set_property enablement_dependency {$M_AXI_USR_1_PROTOCOL == "AXI4" and $NUM_MASTER_BRIDGE >= 2} [::ipx::get_bus_interfaces -of_objects $::core M_AXI4_USR_1]

::ipx::add_bus_interface M_AXI4LITE_USR_1 $::core
set_property bus_type_vlnv xilinx.com:interface:aximm:1.0 [::ipx::get_bus_interfaces -of_objects $::core M_AXI4LITE_USR_1]
set_property abstraction_type_vlnv xilinx.com:interface:aximm_rtl:1.0 [::ipx::get_bus_interfaces -of_objects $::core M_AXI4LITE_USR_1]
set_property interface_mode master [::ipx::get_bus_interfaces -of_objects $::core M_AXI4LITE_USR_1]
set_property display_name M_AXI4LITE_USR_1 [::ipx::get_bus_interfaces -of_objects $::core M_AXI4LITE_USR_1]
set_property description {Master User AXI Interface} [::ipx::get_bus_interfaces -of_objects $::core M_AXI4LITE_USR_1]
set_property enablement_presence "optional" [::ipx::get_bus_interfaces -of_objects $::core M_AXI4LITE_USR_1]
set_property enablement_value "false" [::ipx::get_bus_interfaces -of_objects $::core M_AXI4LITE_USR_1]
set_property enablement_resolve_type "dependent" [::ipx::get_bus_interfaces -of_objects $::core M_AXI4LITE_USR_1]
set_property enablement_dependency {$M_AXI_USR_1_PROTOCOL == "AXI4LITE" and $NUM_MASTER_BRIDGE >= 2} [::ipx::get_bus_interfaces -of_objects $::core M_AXI4LITE_USR_1]

::ipx::add_bus_interface M_AXI3_USR_1 $::core
set_property bus_type_vlnv xilinx.com:interface:aximm:1.0 [::ipx::get_bus_interfaces -of_objects $::core M_AXI3_USR_1]
set_property abstraction_type_vlnv xilinx.com:interface:aximm_rtl:1.0 [::ipx::get_bus_interfaces -of_objects $::core M_AXI3_USR_1]
set_property interface_mode master [::ipx::get_bus_interfaces -of_objects $::core M_AXI3_USR_1]
set_property display_name M_AXI3_USR_1 [::ipx::get_bus_interfaces -of_objects $::core M_AXI3_USR_1]
set_property description {Master User AXI Interface} [::ipx::get_bus_interfaces -of_objects $::core M_AXI3_USR_1]
set_property enablement_presence "optional" [::ipx::get_bus_interfaces -of_objects $::core M_AXI3_USR_1]
set_property enablement_value "false" [::ipx::get_bus_interfaces -of_objects $::core M_AXI3_USR_1]
set_property enablement_resolve_type "dependent" [::ipx::get_bus_interfaces -of_objects $::core M_AXI3_USR_1]
set_property enablement_dependency {$M_AXI_USR_1_PROTOCOL == "AXI3" and $NUM_MASTER_BRIDGE >= 2} [::ipx::get_bus_interfaces -of_objects $::core M_AXI3_USR_1]


::ipx::add_bus_interface M_AXI4_USR_2 $::core
set_property bus_type_vlnv xilinx.com:interface:aximm:1.0 [::ipx::get_bus_interfaces -of_objects $::core M_AXI4_USR_2]
set_property abstraction_type_vlnv xilinx.com:interface:aximm_rtl:1.0 [::ipx::get_bus_interfaces -of_objects $::core M_AXI4_USR_2]
set_property interface_mode master [::ipx::get_bus_interfaces -of_objects $::core M_AXI4_USR_2]
set_property display_name M_AXI4_USR_2 [::ipx::get_bus_interfaces -of_objects $::core M_AXI4_USR_2]
set_property description {Master User AXI Interface} [::ipx::get_bus_interfaces -of_objects $::core M_AXI4_USR_2]
set_property enablement_presence "optional" [::ipx::get_bus_interfaces -of_objects $::core M_AXI4_USR_2]
set_property enablement_value "false" [::ipx::get_bus_interfaces -of_objects $::core M_AXI4_USR_2]
set_property enablement_resolve_type "dependent" [::ipx::get_bus_interfaces -of_objects $::core M_AXI4_USR_2]
set_property enablement_dependency {$M_AXI_USR_2_PROTOCOL == "AXI4" and $NUM_MASTER_BRIDGE >= 3} [::ipx::get_bus_interfaces -of_objects $::core M_AXI4_USR_2]

::ipx::add_bus_interface M_AXI4LITE_USR_2 $::core
set_property bus_type_vlnv xilinx.com:interface:aximm:1.0 [::ipx::get_bus_interfaces -of_objects $::core M_AXI4LITE_USR_2]
set_property abstraction_type_vlnv xilinx.com:interface:aximm_rtl:1.0 [::ipx::get_bus_interfaces -of_objects $::core M_AXI4LITE_USR_2]
set_property interface_mode master [::ipx::get_bus_interfaces -of_objects $::core M_AXI4LITE_USR_2]
set_property display_name M_AXI4LITE_USR_2 [::ipx::get_bus_interfaces -of_objects $::core M_AXI4LITE_USR_2]
set_property description {Master User AXI Interface} [::ipx::get_bus_interfaces -of_objects $::core M_AXI4LITE_USR_2]
set_property enablement_presence "optional" [::ipx::get_bus_interfaces -of_objects $::core M_AXI4LITE_USR_2]
set_property enablement_value "false" [::ipx::get_bus_interfaces -of_objects $::core M_AXI4LITE_USR_2]
set_property enablement_resolve_type "dependent" [::ipx::get_bus_interfaces -of_objects $::core M_AXI4LITE_USR_2]
set_property enablement_dependency {$M_AXI_USR_2_PROTOCOL == "AXI4LITE" and $NUM_MASTER_BRIDGE >= 3} [::ipx::get_bus_interfaces -of_objects $::core M_AXI4LITE_USR_2]

::ipx::add_bus_interface M_AXI3_USR_2 $::core
set_property bus_type_vlnv xilinx.com:interface:aximm:1.0 [::ipx::get_bus_interfaces -of_objects $::core M_AXI3_USR_2]
set_property abstraction_type_vlnv xilinx.com:interface:aximm_rtl:1.0 [::ipx::get_bus_interfaces -of_objects $::core M_AXI3_USR_2]
set_property interface_mode master [::ipx::get_bus_interfaces -of_objects $::core M_AXI3_USR_2]
set_property display_name M_AXI3_USR_2 [::ipx::get_bus_interfaces -of_objects $::core M_AXI3_USR_2]
set_property description {Master User AXI Interface} [::ipx::get_bus_interfaces -of_objects $::core M_AXI3_USR_2]
set_property enablement_presence "optional" [::ipx::get_bus_interfaces -of_objects $::core M_AXI3_USR_2]
set_property enablement_value "false" [::ipx::get_bus_interfaces -of_objects $::core M_AXI3_USR_2]
set_property enablement_resolve_type "dependent" [::ipx::get_bus_interfaces -of_objects $::core M_AXI3_USR_2]
set_property enablement_dependency {$M_AXI_USR_2_PROTOCOL == "AXI3" and $NUM_MASTER_BRIDGE >= 3} [::ipx::get_bus_interfaces -of_objects $::core M_AXI3_USR_2]


::ipx::add_bus_interface M_AXI4_USR_3 $::core
set_property bus_type_vlnv xilinx.com:interface:aximm:1.0 [::ipx::get_bus_interfaces -of_objects $::core M_AXI4_USR_3]
set_property abstraction_type_vlnv xilinx.com:interface:aximm_rtl:1.0 [::ipx::get_bus_interfaces -of_objects $::core M_AXI4_USR_3]
set_property interface_mode master [::ipx::get_bus_interfaces -of_objects $::core M_AXI4_USR_3]
set_property display_name M_AXI4_USR_3 [::ipx::get_bus_interfaces -of_objects $::core M_AXI4_USR_3]
set_property description {Master User AXI Interface} [::ipx::get_bus_interfaces -of_objects $::core M_AXI4_USR_3]
set_property enablement_presence "optional" [::ipx::get_bus_interfaces -of_objects $::core M_AXI4_USR_3]
set_property enablement_value "false" [::ipx::get_bus_interfaces -of_objects $::core M_AXI4_USR_3]
set_property enablement_resolve_type "dependent" [::ipx::get_bus_interfaces -of_objects $::core M_AXI4_USR_3]
set_property enablement_dependency {$M_AXI_USR_3_PROTOCOL == "AXI4" and $NUM_MASTER_BRIDGE >= 4} [::ipx::get_bus_interfaces -of_objects $::core M_AXI4_USR_3]

::ipx::add_bus_interface M_AXI4LITE_USR_3 $::core
set_property bus_type_vlnv xilinx.com:interface:aximm:1.0 [::ipx::get_bus_interfaces -of_objects $::core M_AXI4LITE_USR_3]
set_property abstraction_type_vlnv xilinx.com:interface:aximm_rtl:1.0 [::ipx::get_bus_interfaces -of_objects $::core M_AXI4LITE_USR_3]
set_property interface_mode master [::ipx::get_bus_interfaces -of_objects $::core M_AXI4LITE_USR_3]
set_property display_name M_AXI4LITE_USR_3 [::ipx::get_bus_interfaces -of_objects $::core M_AXI4LITE_USR_3]
set_property description {Master User AXI Interface} [::ipx::get_bus_interfaces -of_objects $::core M_AXI4LITE_USR_3]
set_property enablement_presence "optional" [::ipx::get_bus_interfaces -of_objects $::core M_AXI4LITE_USR_3]
set_property enablement_value "false" [::ipx::get_bus_interfaces -of_objects $::core M_AXI4LITE_USR_3]
set_property enablement_resolve_type "dependent" [::ipx::get_bus_interfaces -of_objects $::core M_AXI4LITE_USR_3]
set_property enablement_dependency {$M_AXI_USR_3_PROTOCOL == "AXI4LITE" and $NUM_MASTER_BRIDGE >= 4} [::ipx::get_bus_interfaces -of_objects $::core M_AXI4LITE_USR_3]

::ipx::add_bus_interface M_AXI3_USR_3 $::core
set_property bus_type_vlnv xilinx.com:interface:aximm:1.0 [::ipx::get_bus_interfaces -of_objects $::core M_AXI3_USR_3]
set_property abstraction_type_vlnv xilinx.com:interface:aximm_rtl:1.0 [::ipx::get_bus_interfaces -of_objects $::core M_AXI3_USR_3]
set_property interface_mode master [::ipx::get_bus_interfaces -of_objects $::core M_AXI3_USR_3]
set_property display_name M_AXI3_USR_3 [::ipx::get_bus_interfaces -of_objects $::core M_AXI3_USR_3]
set_property description {Master User AXI Interface} [::ipx::get_bus_interfaces -of_objects $::core M_AXI3_USR_3]
set_property enablement_presence "optional" [::ipx::get_bus_interfaces -of_objects $::core M_AXI3_USR_3]
set_property enablement_value "false" [::ipx::get_bus_interfaces -of_objects $::core M_AXI3_USR_3]
set_property enablement_resolve_type "dependent" [::ipx::get_bus_interfaces -of_objects $::core M_AXI3_USR_3]
set_property enablement_dependency {$M_AXI_USR_3_PROTOCOL == "AXI3" and $NUM_MASTER_BRIDGE >= 4} [::ipx::get_bus_interfaces -of_objects $::core M_AXI3_USR_3]


::ipx::add_bus_interface M_AXI4_USR_4 $::core
set_property bus_type_vlnv xilinx.com:interface:aximm:1.0 [::ipx::get_bus_interfaces -of_objects $::core M_AXI4_USR_4]
set_property abstraction_type_vlnv xilinx.com:interface:aximm_rtl:1.0 [::ipx::get_bus_interfaces -of_objects $::core M_AXI4_USR_4]
set_property interface_mode master [::ipx::get_bus_interfaces -of_objects $::core M_AXI4_USR_4]
set_property display_name M_AXI4_USR_4 [::ipx::get_bus_interfaces -of_objects $::core M_AXI4_USR_4]
set_property description {Master User AXI Interface} [::ipx::get_bus_interfaces -of_objects $::core M_AXI4_USR_4]
set_property enablement_presence "optional" [::ipx::get_bus_interfaces -of_objects $::core M_AXI4_USR_4]
set_property enablement_value "false" [::ipx::get_bus_interfaces -of_objects $::core M_AXI4_USR_4]
set_property enablement_resolve_type "dependent" [::ipx::get_bus_interfaces -of_objects $::core M_AXI4_USR_4]
set_property enablement_dependency {$M_AXI_USR_4_PROTOCOL == "AXI4" and $NUM_MASTER_BRIDGE >= 5} [::ipx::get_bus_interfaces -of_objects $::core M_AXI4_USR_4]

::ipx::add_bus_interface M_AXI4LITE_USR_4 $::core
set_property bus_type_vlnv xilinx.com:interface:aximm:1.0 [::ipx::get_bus_interfaces -of_objects $::core M_AXI4LITE_USR_4]
set_property abstraction_type_vlnv xilinx.com:interface:aximm_rtl:1.0 [::ipx::get_bus_interfaces -of_objects $::core M_AXI4LITE_USR_4]
set_property interface_mode master [::ipx::get_bus_interfaces -of_objects $::core M_AXI4LITE_USR_4]
set_property display_name M_AXI4LITE_USR_4 [::ipx::get_bus_interfaces -of_objects $::core M_AXI4LITE_USR_4]
set_property description {Master User AXI Interface} [::ipx::get_bus_interfaces -of_objects $::core M_AXI4LITE_USR_4]
set_property enablement_presence "optional" [::ipx::get_bus_interfaces -of_objects $::core M_AXI4LITE_USR_4]
set_property enablement_value "false" [::ipx::get_bus_interfaces -of_objects $::core M_AXI4LITE_USR_4]
set_property enablement_resolve_type "dependent" [::ipx::get_bus_interfaces -of_objects $::core M_AXI4LITE_USR_4]
set_property enablement_dependency {$M_AXI_USR_4_PROTOCOL == "AXI4LITE" and $NUM_MASTER_BRIDGE >= 5} [::ipx::get_bus_interfaces -of_objects $::core M_AXI4LITE_USR_4]

::ipx::add_bus_interface M_AXI3_USR_4 $::core
set_property bus_type_vlnv xilinx.com:interface:aximm:1.0 [::ipx::get_bus_interfaces -of_objects $::core M_AXI3_USR_4]
set_property abstraction_type_vlnv xilinx.com:interface:aximm_rtl:1.0 [::ipx::get_bus_interfaces -of_objects $::core M_AXI3_USR_4]
set_property interface_mode master [::ipx::get_bus_interfaces -of_objects $::core M_AXI3_USR_4]
set_property display_name M_AXI3_USR_4 [::ipx::get_bus_interfaces -of_objects $::core M_AXI3_USR_4]
set_property description {Master User AXI Interface} [::ipx::get_bus_interfaces -of_objects $::core M_AXI3_USR_4]
set_property enablement_presence "optional" [::ipx::get_bus_interfaces -of_objects $::core M_AXI3_USR_4]
set_property enablement_value "false" [::ipx::get_bus_interfaces -of_objects $::core M_AXI3_USR_4]
set_property enablement_resolve_type "dependent" [::ipx::get_bus_interfaces -of_objects $::core M_AXI3_USR_4]
set_property enablement_dependency {$M_AXI_USR_4_PROTOCOL == "AXI3" and $NUM_MASTER_BRIDGE >= 5} [::ipx::get_bus_interfaces -of_objects $::core M_AXI3_USR_4]


::ipx::add_bus_interface M_AXI4_USR_5 $::core
set_property bus_type_vlnv xilinx.com:interface:aximm:1.0 [::ipx::get_bus_interfaces -of_objects $::core M_AXI4_USR_5]
set_property abstraction_type_vlnv xilinx.com:interface:aximm_rtl:1.0 [::ipx::get_bus_interfaces -of_objects $::core M_AXI4_USR_5]
set_property interface_mode master [::ipx::get_bus_interfaces -of_objects $::core M_AXI4_USR_5]
set_property display_name M_AXI4_USR_5 [::ipx::get_bus_interfaces -of_objects $::core M_AXI4_USR_5]
set_property description {Master User AXI Interface} [::ipx::get_bus_interfaces -of_objects $::core M_AXI4_USR_5]
set_property enablement_presence "optional" [::ipx::get_bus_interfaces -of_objects $::core M_AXI4_USR_5]
set_property enablement_value "false" [::ipx::get_bus_interfaces -of_objects $::core M_AXI4_USR_5]
set_property enablement_resolve_type "dependent" [::ipx::get_bus_interfaces -of_objects $::core M_AXI4_USR_5]
set_property enablement_dependency {$M_AXI_USR_5_PROTOCOL == "AXI4" and $NUM_MASTER_BRIDGE >= 6} [::ipx::get_bus_interfaces -of_objects $::core M_AXI4_USR_5]

::ipx::add_bus_interface M_AXI4LITE_USR_5 $::core
set_property bus_type_vlnv xilinx.com:interface:aximm:1.0 [::ipx::get_bus_interfaces -of_objects $::core M_AXI4LITE_USR_5]
set_property abstraction_type_vlnv xilinx.com:interface:aximm_rtl:1.0 [::ipx::get_bus_interfaces -of_objects $::core M_AXI4LITE_USR_5]
set_property interface_mode master [::ipx::get_bus_interfaces -of_objects $::core M_AXI4LITE_USR_5]
set_property display_name M_AXI4LITE_USR_5 [::ipx::get_bus_interfaces -of_objects $::core M_AXI4LITE_USR_5]
set_property description {Master User AXI Interface} [::ipx::get_bus_interfaces -of_objects $::core M_AXI4LITE_USR_5]
set_property enablement_presence "optional" [::ipx::get_bus_interfaces -of_objects $::core M_AXI4LITE_USR_5]
set_property enablement_value "false" [::ipx::get_bus_interfaces -of_objects $::core M_AXI4LITE_USR_5]
set_property enablement_resolve_type "dependent" [::ipx::get_bus_interfaces -of_objects $::core M_AXI4LITE_USR_5]
set_property enablement_dependency {$M_AXI_USR_5_PROTOCOL == "AXI4LITE" and $NUM_MASTER_BRIDGE >= 6} [::ipx::get_bus_interfaces -of_objects $::core M_AXI4LITE_USR_5]

::ipx::add_bus_interface M_AXI3_USR_5 $::core
set_property bus_type_vlnv xilinx.com:interface:aximm:1.0 [::ipx::get_bus_interfaces -of_objects $::core M_AXI3_USR_5]
set_property abstraction_type_vlnv xilinx.com:interface:aximm_rtl:1.0 [::ipx::get_bus_interfaces -of_objects $::core M_AXI3_USR_5]
set_property interface_mode master [::ipx::get_bus_interfaces -of_objects $::core M_AXI3_USR_5]
set_property display_name M_AXI3_USR_5 [::ipx::get_bus_interfaces -of_objects $::core M_AXI3_USR_5]
set_property description {Master User AXI Interface} [::ipx::get_bus_interfaces -of_objects $::core M_AXI3_USR_5]
set_property enablement_presence "optional" [::ipx::get_bus_interfaces -of_objects $::core M_AXI3_USR_5]
set_property enablement_value "false" [::ipx::get_bus_interfaces -of_objects $::core M_AXI3_USR_5]
set_property enablement_resolve_type "dependent" [::ipx::get_bus_interfaces -of_objects $::core M_AXI3_USR_5]
set_property enablement_dependency {$M_AXI_USR_5_PROTOCOL == "AXI3" and $NUM_MASTER_BRIDGE >= 6} [::ipx::get_bus_interfaces -of_objects $::core M_AXI3_USR_5]

::ipx::add_bus_interface S_AXI4_USR_0 $::core
set_property bus_type_vlnv xilinx.com:interface:aximm:1.0 [::ipx::get_bus_interfaces -of_objects $::core S_AXI4_USR_0]
set_property abstraction_type_vlnv xilinx.com:interface:aximm_rtl:1.0 [::ipx::get_bus_interfaces -of_objects $::core S_AXI4_USR_0]
set_property interface_mode slave [::ipx::get_bus_interfaces -of_objects $::core S_AXI4_USR_0]
set_property display_name S_AXI4_USR_0 [::ipx::get_bus_interfaces -of_objects $::core S_AXI4_USR_0]
set_property description {Slave User AXI Interface} [::ipx::get_bus_interfaces -of_objects $::core S_AXI4_USR_0]
set_property enablement_presence "optional" [::ipx::get_bus_interfaces -of_objects $::core S_AXI4_USR_0]
set_property enablement_value "false" [::ipx::get_bus_interfaces -of_objects $::core S_AXI4_USR_0]
set_property enablement_resolve_type "dependent" [::ipx::get_bus_interfaces -of_objects $::core S_AXI4_USR_0]
set_property enablement_dependency {$S_AXI_USR_0_PROTOCOL == "AXI4" and $NUM_SLAVE_BRIDGE >= 1} [::ipx::get_bus_interfaces -of_objects $::core S_AXI4_USR_0]

::ipx::add_bus_interface S_AXI4LITE_USR_0 $::core
set_property bus_type_vlnv xilinx.com:interface:aximm:1.0 [::ipx::get_bus_interfaces -of_objects $::core S_AXI4LITE_USR_0]
set_property abstraction_type_vlnv xilinx.com:interface:aximm_rtl:1.0 [::ipx::get_bus_interfaces -of_objects $::core S_AXI4LITE_USR_0]
set_property interface_mode slave [::ipx::get_bus_interfaces -of_objects $::core S_AXI4LITE_USR_0]
set_property display_name S_AXI4LITE_USR_0 [::ipx::get_bus_interfaces -of_objects $::core S_AXI4LITE_USR_0]
set_property description {Slave User AXI Interface} [::ipx::get_bus_interfaces -of_objects $::core S_AXI4LITE_USR_0]
set_property enablement_presence "optional" [::ipx::get_bus_interfaces -of_objects $::core S_AXI4LITE_USR_0]
set_property enablement_value "false" [::ipx::get_bus_interfaces -of_objects $::core S_AXI4LITE_USR_0]
set_property enablement_resolve_type "dependent" [::ipx::get_bus_interfaces -of_objects $::core S_AXI4LITE_USR_0]
set_property enablement_dependency {$S_AXI_USR_0_PROTOCOL == "AXI4LITE" and $NUM_SLAVE_BRIDGE >= 1} [::ipx::get_bus_interfaces -of_objects $::core S_AXI4LITE_USR_0]

::ipx::add_bus_interface S_AXI3_USR_0 $::core
set_property bus_type_vlnv xilinx.com:interface:aximm:1.0 [::ipx::get_bus_interfaces -of_objects $::core S_AXI3_USR_0]
set_property abstraction_type_vlnv xilinx.com:interface:aximm_rtl:1.0 [::ipx::get_bus_interfaces -of_objects $::core S_AXI3_USR_0]
set_property interface_mode slave [::ipx::get_bus_interfaces -of_objects $::core S_AXI3_USR_0]
set_property display_name S_AXI3_USR_0 [::ipx::get_bus_interfaces -of_objects $::core S_AXI3_USR_0]
set_property description {Slave User AXI Interface} [::ipx::get_bus_interfaces -of_objects $::core S_AXI3_USR_0]
set_property enablement_presence "optional" [::ipx::get_bus_interfaces -of_objects $::core S_AXI3_USR_0]
set_property enablement_value "false" [::ipx::get_bus_interfaces -of_objects $::core S_AXI3_USR_0]
set_property enablement_resolve_type "dependent" [::ipx::get_bus_interfaces -of_objects $::core S_AXI3_USR_0]
set_property enablement_dependency {$S_AXI_USR_0_PROTOCOL == "AXI3" and $NUM_SLAVE_BRIDGE >= 1} [::ipx::get_bus_interfaces -of_objects $::core S_AXI3_USR_0]

::ipx::add_bus_interface S_AXI4_USR_1 $::core
set_property bus_type_vlnv xilinx.com:interface:aximm:1.0 [::ipx::get_bus_interfaces -of_objects $::core S_AXI4_USR_1]
set_property abstraction_type_vlnv xilinx.com:interface:aximm_rtl:1.0 [::ipx::get_bus_interfaces -of_objects $::core S_AXI4_USR_1]
set_property interface_mode slave [::ipx::get_bus_interfaces -of_objects $::core S_AXI4_USR_1]
set_property display_name S_AXI4_USR_1 [::ipx::get_bus_interfaces -of_objects $::core S_AXI4_USR_1]
set_property description {Slave User AXI Interface} [::ipx::get_bus_interfaces -of_objects $::core S_AXI4_USR_1]
set_property enablement_presence "optional" [::ipx::get_bus_interfaces -of_objects $::core S_AXI4_USR_1]
set_property enablement_value "false" [::ipx::get_bus_interfaces -of_objects $::core S_AXI4_USR_1]
set_property enablement_resolve_type "dependent" [::ipx::get_bus_interfaces -of_objects $::core S_AXI4_USR_1]
set_property enablement_dependency {$S_AXI_USR_1_PROTOCOL == "AXI4" and $NUM_SLAVE_BRIDGE >= 2} [::ipx::get_bus_interfaces -of_objects $::core S_AXI4_USR_1]

::ipx::add_bus_interface S_AXI4LITE_USR_1 $::core
set_property bus_type_vlnv xilinx.com:interface:aximm:1.0 [::ipx::get_bus_interfaces -of_objects $::core S_AXI4LITE_USR_1]
set_property abstraction_type_vlnv xilinx.com:interface:aximm_rtl:1.0 [::ipx::get_bus_interfaces -of_objects $::core S_AXI4LITE_USR_1]
set_property interface_mode slave [::ipx::get_bus_interfaces -of_objects $::core S_AXI4LITE_USR_1]
set_property display_name S_AXI4LITE_USR_1 [::ipx::get_bus_interfaces -of_objects $::core S_AXI4LITE_USR_1]
set_property description {Slave User AXI Interface} [::ipx::get_bus_interfaces -of_objects $::core S_AXI4LITE_USR_1]
set_property enablement_presence "optional" [::ipx::get_bus_interfaces -of_objects $::core S_AXI4LITE_USR_1]
set_property enablement_value "false" [::ipx::get_bus_interfaces -of_objects $::core S_AXI4LITE_USR_1]
set_property enablement_resolve_type "dependent" [::ipx::get_bus_interfaces -of_objects $::core S_AXI4LITE_USR_1]
set_property enablement_dependency {$S_AXI_USR_1_PROTOCOL == "AXI4LITE" and $NUM_SLAVE_BRIDGE >= 2} [::ipx::get_bus_interfaces -of_objects $::core S_AXI4LITE_USR_1]

::ipx::add_bus_interface S_AXI3_USR_1 $::core
set_property bus_type_vlnv xilinx.com:interface:aximm:1.0 [::ipx::get_bus_interfaces -of_objects $::core S_AXI3_USR_1]
set_property abstraction_type_vlnv xilinx.com:interface:aximm_rtl:1.0 [::ipx::get_bus_interfaces -of_objects $::core S_AXI3_USR_1]
set_property interface_mode slave [::ipx::get_bus_interfaces -of_objects $::core S_AXI3_USR_1]
set_property display_name S_AXI3_USR_1 [::ipx::get_bus_interfaces -of_objects $::core S_AXI3_USR_1]
set_property description {Slave User AXI Interface} [::ipx::get_bus_interfaces -of_objects $::core S_AXI3_USR_1]
set_property enablement_presence "optional" [::ipx::get_bus_interfaces -of_objects $::core S_AXI3_USR_1]
set_property enablement_value "false" [::ipx::get_bus_interfaces -of_objects $::core S_AXI3_USR_1]
set_property enablement_resolve_type "dependent" [::ipx::get_bus_interfaces -of_objects $::core S_AXI3_USR_1]
set_property enablement_dependency {$S_AXI_USR_1_PROTOCOL == "AXI3" and $NUM_SLAVE_BRIDGE >= 2} [::ipx::get_bus_interfaces -of_objects $::core S_AXI3_USR_1]

::ipx::add_bus_interface S_AXI4_USR_2 $::core
set_property bus_type_vlnv xilinx.com:interface:aximm:1.0 [::ipx::get_bus_interfaces -of_objects $::core S_AXI4_USR_2]
set_property abstraction_type_vlnv xilinx.com:interface:aximm_rtl:1.0 [::ipx::get_bus_interfaces -of_objects $::core S_AXI4_USR_2]
set_property interface_mode slave [::ipx::get_bus_interfaces -of_objects $::core S_AXI4_USR_2]
set_property display_name S_AXI4_USR_2 [::ipx::get_bus_interfaces -of_objects $::core S_AXI4_USR_2]
set_property description {Slave User AXI Interface} [::ipx::get_bus_interfaces -of_objects $::core S_AXI4_USR_2]
set_property enablement_presence "optional" [::ipx::get_bus_interfaces -of_objects $::core S_AXI4_USR_2]
set_property enablement_value "false" [::ipx::get_bus_interfaces -of_objects $::core S_AXI4_USR_2]
set_property enablement_resolve_type "dependent" [::ipx::get_bus_interfaces -of_objects $::core S_AXI4_USR_2]
set_property enablement_dependency {$S_AXI_USR_2_PROTOCOL == "AXI4" and $NUM_SLAVE_BRIDGE >= 3} [::ipx::get_bus_interfaces -of_objects $::core S_AXI4_USR_2]

::ipx::add_bus_interface S_AXI4LITE_USR_2 $::core
set_property bus_type_vlnv xilinx.com:interface:aximm:1.0 [::ipx::get_bus_interfaces -of_objects $::core S_AXI4LITE_USR_2]
set_property abstraction_type_vlnv xilinx.com:interface:aximm_rtl:1.0 [::ipx::get_bus_interfaces -of_objects $::core S_AXI4LITE_USR_2]
set_property interface_mode slave [::ipx::get_bus_interfaces -of_objects $::core S_AXI4LITE_USR_2]
set_property display_name S_AXI4LITE_USR_2 [::ipx::get_bus_interfaces -of_objects $::core S_AXI4LITE_USR_2]
set_property description {Slave User AXI Interface} [::ipx::get_bus_interfaces -of_objects $::core S_AXI4LITE_USR_2]
set_property enablement_presence "optional" [::ipx::get_bus_interfaces -of_objects $::core S_AXI4LITE_USR_2]
set_property enablement_value "false" [::ipx::get_bus_interfaces -of_objects $::core S_AXI4LITE_USR_2]
set_property enablement_resolve_type "dependent" [::ipx::get_bus_interfaces -of_objects $::core S_AXI4LITE_USR_2]
set_property enablement_dependency {$S_AXI_USR_2_PROTOCOL == "AXI4LITE" and $NUM_SLAVE_BRIDGE >= 3} [::ipx::get_bus_interfaces -of_objects $::core S_AXI4LITE_USR_2]

::ipx::add_bus_interface S_AXI3_USR_2 $::core
set_property bus_type_vlnv xilinx.com:interface:aximm:1.0 [::ipx::get_bus_interfaces -of_objects $::core S_AXI3_USR_2]
set_property abstraction_type_vlnv xilinx.com:interface:aximm_rtl:1.0 [::ipx::get_bus_interfaces -of_objects $::core S_AXI3_USR_2]
set_property interface_mode slave [::ipx::get_bus_interfaces -of_objects $::core S_AXI3_USR_2]
set_property display_name S_AXI3_USR_2 [::ipx::get_bus_interfaces -of_objects $::core S_AXI3_USR_2]
set_property description {Slave User AXI Interface} [::ipx::get_bus_interfaces -of_objects $::core S_AXI3_USR_2]
set_property enablement_presence "optional" [::ipx::get_bus_interfaces -of_objects $::core S_AXI3_USR_2]
set_property enablement_value "false" [::ipx::get_bus_interfaces -of_objects $::core S_AXI3_USR_2]
set_property enablement_resolve_type "dependent" [::ipx::get_bus_interfaces -of_objects $::core S_AXI3_USR_2]
set_property enablement_dependency {$S_AXI_USR_2_PROTOCOL == "AXI3" and $NUM_SLAVE_BRIDGE >= 3} [::ipx::get_bus_interfaces -of_objects $::core S_AXI3_USR_2]

::ipx::add_bus_interface S_AXI4_USR_3 $::core
set_property bus_type_vlnv xilinx.com:interface:aximm:1.0 [::ipx::get_bus_interfaces -of_objects $::core S_AXI4_USR_3]
set_property abstraction_type_vlnv xilinx.com:interface:aximm_rtl:1.0 [::ipx::get_bus_interfaces -of_objects $::core S_AXI4_USR_3]
set_property interface_mode slave [::ipx::get_bus_interfaces -of_objects $::core S_AXI4_USR_3]
set_property display_name S_AXI4_USR_3 [::ipx::get_bus_interfaces -of_objects $::core S_AXI4_USR_3]
set_property description {Slave User AXI Interface} [::ipx::get_bus_interfaces -of_objects $::core S_AXI4_USR_3]
set_property enablement_presence "optional" [::ipx::get_bus_interfaces -of_objects $::core S_AXI4_USR_3]
set_property enablement_value "false" [::ipx::get_bus_interfaces -of_objects $::core S_AXI4_USR_3]
set_property enablement_resolve_type "dependent" [::ipx::get_bus_interfaces -of_objects $::core S_AXI4_USR_3]
set_property enablement_dependency {$S_AXI_USR_3_PROTOCOL == "AXI4" and $NUM_SLAVE_BRIDGE >= 4} [::ipx::get_bus_interfaces -of_objects $::core S_AXI4_USR_3]

::ipx::add_bus_interface S_AXI4LITE_USR_3 $::core
set_property bus_type_vlnv xilinx.com:interface:aximm:1.0 [::ipx::get_bus_interfaces -of_objects $::core S_AXI4LITE_USR_3]
set_property abstraction_type_vlnv xilinx.com:interface:aximm_rtl:1.0 [::ipx::get_bus_interfaces -of_objects $::core S_AXI4LITE_USR_3]
set_property interface_mode slave [::ipx::get_bus_interfaces -of_objects $::core S_AXI4LITE_USR_3]
set_property display_name S_AXI4LITE_USR_3 [::ipx::get_bus_interfaces -of_objects $::core S_AXI4LITE_USR_3]
set_property description {Slave User AXI Interface} [::ipx::get_bus_interfaces -of_objects $::core S_AXI4LITE_USR_3]
set_property enablement_presence "optional" [::ipx::get_bus_interfaces -of_objects $::core S_AXI4LITE_USR_3]
set_property enablement_value "false" [::ipx::get_bus_interfaces -of_objects $::core S_AXI4LITE_USR_3]
set_property enablement_resolve_type "dependent" [::ipx::get_bus_interfaces -of_objects $::core S_AXI4LITE_USR_3]
set_property enablement_dependency {$S_AXI_USR_3_PROTOCOL == "AXI4LITE" and $NUM_SLAVE_BRIDGE >= 4} [::ipx::get_bus_interfaces -of_objects $::core S_AXI4LITE_USR_3]

::ipx::add_bus_interface S_AXI3_USR_3 $::core
set_property bus_type_vlnv xilinx.com:interface:aximm:1.0 [::ipx::get_bus_interfaces -of_objects $::core S_AXI3_USR_3]
set_property abstraction_type_vlnv xilinx.com:interface:aximm_rtl:1.0 [::ipx::get_bus_interfaces -of_objects $::core S_AXI3_USR_3]
set_property interface_mode slave [::ipx::get_bus_interfaces -of_objects $::core S_AXI3_USR_3]
set_property display_name S_AXI3_USR_3 [::ipx::get_bus_interfaces -of_objects $::core S_AXI3_USR_3]
set_property description {Slave User AXI Interface} [::ipx::get_bus_interfaces -of_objects $::core S_AXI3_USR_3]
set_property enablement_presence "optional" [::ipx::get_bus_interfaces -of_objects $::core S_AXI3_USR_3]
set_property enablement_value "false" [::ipx::get_bus_interfaces -of_objects $::core S_AXI3_USR_3]
set_property enablement_resolve_type "dependent" [::ipx::get_bus_interfaces -of_objects $::core S_AXI3_USR_3]
set_property enablement_dependency {$S_AXI_USR_3_PROTOCOL == "AXI3" and $NUM_SLAVE_BRIDGE >= 4} [::ipx::get_bus_interfaces -of_objects $::core S_AXI3_USR_3]

::ipx::add_bus_interface S_AXI4_USR_4 $::core
set_property bus_type_vlnv xilinx.com:interface:aximm:1.0 [::ipx::get_bus_interfaces -of_objects $::core S_AXI4_USR_4]
set_property abstraction_type_vlnv xilinx.com:interface:aximm_rtl:1.0 [::ipx::get_bus_interfaces -of_objects $::core S_AXI4_USR_4]
set_property interface_mode slave [::ipx::get_bus_interfaces -of_objects $::core S_AXI4_USR_4]
set_property display_name S_AXI4_USR_4 [::ipx::get_bus_interfaces -of_objects $::core S_AXI4_USR_4]
set_property description {Slave User AXI Interface} [::ipx::get_bus_interfaces -of_objects $::core S_AXI4_USR_4]
set_property enablement_presence "optional" [::ipx::get_bus_interfaces -of_objects $::core S_AXI4_USR_4]
set_property enablement_value "false" [::ipx::get_bus_interfaces -of_objects $::core S_AXI4_USR_4]
set_property enablement_resolve_type "dependent" [::ipx::get_bus_interfaces -of_objects $::core S_AXI4_USR_4]
set_property enablement_dependency {$S_AXI_USR_4_PROTOCOL == "AXI4" and $NUM_SLAVE_BRIDGE >= 5} [::ipx::get_bus_interfaces -of_objects $::core S_AXI4_USR_4]

::ipx::add_bus_interface S_AXI4LITE_USR_4 $::core
set_property bus_type_vlnv xilinx.com:interface:aximm:1.0 [::ipx::get_bus_interfaces -of_objects $::core S_AXI4LITE_USR_4]
set_property abstraction_type_vlnv xilinx.com:interface:aximm_rtl:1.0 [::ipx::get_bus_interfaces -of_objects $::core S_AXI4LITE_USR_4]
set_property interface_mode slave [::ipx::get_bus_interfaces -of_objects $::core S_AXI4LITE_USR_4]
set_property display_name S_AXI4LITE_USR_4 [::ipx::get_bus_interfaces -of_objects $::core S_AXI4LITE_USR_4]
set_property description {Slave User AXI Interface} [::ipx::get_bus_interfaces -of_objects $::core S_AXI4LITE_USR_4]
set_property enablement_presence "optional" [::ipx::get_bus_interfaces -of_objects $::core S_AXI4LITE_USR_4]
set_property enablement_value "false" [::ipx::get_bus_interfaces -of_objects $::core S_AXI4LITE_USR_4]
set_property enablement_resolve_type "dependent" [::ipx::get_bus_interfaces -of_objects $::core S_AXI4LITE_USR_4]
set_property enablement_dependency {$S_AXI_USR_4_PROTOCOL == "AXI4LITE" and $NUM_SLAVE_BRIDGE >= 5} [::ipx::get_bus_interfaces -of_objects $::core S_AXI4LITE_USR_4]

::ipx::add_bus_interface S_AXI3_USR_4 $::core
set_property bus_type_vlnv xilinx.com:interface:aximm:1.0 [::ipx::get_bus_interfaces -of_objects $::core S_AXI3_USR_4]
set_property abstraction_type_vlnv xilinx.com:interface:aximm_rtl:1.0 [::ipx::get_bus_interfaces -of_objects $::core S_AXI3_USR_4]
set_property interface_mode slave [::ipx::get_bus_interfaces -of_objects $::core S_AXI3_USR_4]
set_property display_name S_AXI3_USR_4 [::ipx::get_bus_interfaces -of_objects $::core S_AXI3_USR_4]
set_property description {Slave User AXI Interface} [::ipx::get_bus_interfaces -of_objects $::core S_AXI3_USR_4]
set_property enablement_presence "optional" [::ipx::get_bus_interfaces -of_objects $::core S_AXI3_USR_4]
set_property enablement_value "false" [::ipx::get_bus_interfaces -of_objects $::core S_AXI3_USR_4]
set_property enablement_resolve_type "dependent" [::ipx::get_bus_interfaces -of_objects $::core S_AXI3_USR_4]
set_property enablement_dependency {$S_AXI_USR_4_PROTOCOL == "AXI3" and $NUM_SLAVE_BRIDGE >= 5} [::ipx::get_bus_interfaces -of_objects $::core S_AXI3_USR_4]

::ipx::add_bus_interface S_AXI4_USR_5 $::core
set_property bus_type_vlnv xilinx.com:interface:aximm:1.0 [::ipx::get_bus_interfaces -of_objects $::core S_AXI4_USR_5]
set_property abstraction_type_vlnv xilinx.com:interface:aximm_rtl:1.0 [::ipx::get_bus_interfaces -of_objects $::core S_AXI4_USR_5]
set_property interface_mode slave [::ipx::get_bus_interfaces -of_objects $::core S_AXI4_USR_5]
set_property display_name S_AXI4_USR_5 [::ipx::get_bus_interfaces -of_objects $::core S_AXI4_USR_5]
set_property description {Slave User AXI Interface} [::ipx::get_bus_interfaces -of_objects $::core S_AXI4_USR_5]
set_property enablement_presence "optional" [::ipx::get_bus_interfaces -of_objects $::core S_AXI4_USR_5]
set_property enablement_value "false" [::ipx::get_bus_interfaces -of_objects $::core S_AXI4_USR_5]
set_property enablement_resolve_type "dependent" [::ipx::get_bus_interfaces -of_objects $::core S_AXI4_USR_5]
set_property enablement_dependency {$S_AXI_USR_5_PROTOCOL == "AXI4" and $NUM_SLAVE_BRIDGE >= 6} [::ipx::get_bus_interfaces -of_objects $::core S_AXI4_USR_5]

::ipx::add_bus_interface S_AXI4LITE_USR_5 $::core
set_property bus_type_vlnv xilinx.com:interface:aximm:1.0 [::ipx::get_bus_interfaces -of_objects $::core S_AXI4LITE_USR_5]
set_property abstraction_type_vlnv xilinx.com:interface:aximm_rtl:1.0 [::ipx::get_bus_interfaces -of_objects $::core S_AXI4LITE_USR_5]
set_property interface_mode slave [::ipx::get_bus_interfaces -of_objects $::core S_AXI4LITE_USR_5]
set_property display_name S_AXI4LITE_USR_5 [::ipx::get_bus_interfaces -of_objects $::core S_AXI4LITE_USR_5]
set_property description {Slave User AXI Interface} [::ipx::get_bus_interfaces -of_objects $::core S_AXI4LITE_USR_5]
set_property enablement_presence "optional" [::ipx::get_bus_interfaces -of_objects $::core S_AXI4LITE_USR_5]
set_property enablement_value "false" [::ipx::get_bus_interfaces -of_objects $::core S_AXI4LITE_USR_5]
set_property enablement_resolve_type "dependent" [::ipx::get_bus_interfaces -of_objects $::core S_AXI4LITE_USR_5]
set_property enablement_dependency {$S_AXI_USR_5_PROTOCOL == "AXI4LITE" and $NUM_SLAVE_BRIDGE >= 6} [::ipx::get_bus_interfaces -of_objects $::core S_AXI4LITE_USR_5]

::ipx::add_bus_interface S_AXI3_USR_5 $::core
set_property bus_type_vlnv xilinx.com:interface:aximm:1.0 [::ipx::get_bus_interfaces -of_objects $::core S_AXI3_USR_5]
set_property abstraction_type_vlnv xilinx.com:interface:aximm_rtl:1.0 [::ipx::get_bus_interfaces -of_objects $::core S_AXI3_USR_5]
set_property interface_mode slave [::ipx::get_bus_interfaces -of_objects $::core S_AXI3_USR_5]
set_property display_name S_AXI3_USR_5 [::ipx::get_bus_interfaces -of_objects $::core S_AXI3_USR_5]
set_property description {Slave User AXI Interface} [::ipx::get_bus_interfaces -of_objects $::core S_AXI3_USR_5]
set_property enablement_presence "optional" [::ipx::get_bus_interfaces -of_objects $::core S_AXI3_USR_5]
set_property enablement_value "false" [::ipx::get_bus_interfaces -of_objects $::core S_AXI3_USR_5]
set_property enablement_resolve_type "dependent" [::ipx::get_bus_interfaces -of_objects $::core S_AXI3_USR_5]
set_property enablement_dependency {$S_AXI_USR_5_PROTOCOL == "AXI3" and $NUM_SLAVE_BRIDGE >= 6} [::ipx::get_bus_interfaces -of_objects $::core S_AXI3_USR_5]


add_port_map_axi AWADDR    s_axi_pcie_m0_awaddr    S_AXI_PCIE_M0 1
add_port_map_axi AWPROT    s_axi_pcie_m0_awprot    S_AXI_PCIE_M0 1
add_port_map_axi AWVALID   s_axi_pcie_m0_awvalid   S_AXI_PCIE_M0 1
add_port_map_axi AWREADY   s_axi_pcie_m0_awready   S_AXI_PCIE_M0 1
add_port_map_axi WDATA     s_axi_pcie_m0_wdata     S_AXI_PCIE_M0 1
add_port_map_axi WSTRB     s_axi_pcie_m0_wstrb     S_AXI_PCIE_M0 1
add_port_map_axi WVALID    s_axi_pcie_m0_wvalid    S_AXI_PCIE_M0 1
add_port_map_axi WREADY    s_axi_pcie_m0_wready    S_AXI_PCIE_M0 1
add_port_map_axi BRESP     s_axi_pcie_m0_bresp     S_AXI_PCIE_M0 1
add_port_map_axi BVALID    s_axi_pcie_m0_bvalid    S_AXI_PCIE_M0 1
add_port_map_axi BREADY    s_axi_pcie_m0_bready    S_AXI_PCIE_M0 1
add_port_map_axi ARADDR    s_axi_pcie_m0_araddr    S_AXI_PCIE_M0 1
add_port_map_axi ARPROT    s_axi_pcie_m0_arprot    S_AXI_PCIE_M0 1
add_port_map_axi ARVALID   s_axi_pcie_m0_arvalid   S_AXI_PCIE_M0 1
add_port_map_axi ARREADY   s_axi_pcie_m0_arready   S_AXI_PCIE_M0 1
add_port_map_axi RDATA     s_axi_pcie_m0_rdata     S_AXI_PCIE_M0 1
add_port_map_axi RRESP     s_axi_pcie_m0_rresp     S_AXI_PCIE_M0 1
add_port_map_axi RVALID    s_axi_pcie_m0_rvalid    S_AXI_PCIE_M0 1
add_port_map_axi RREADY    s_axi_pcie_m0_rready    S_AXI_PCIE_M0 1
add_port_map_axi  AWID         m_axi_pcie_m0_awid       M_AXI_PCIE_M0 1    
add_port_map_axi  AWADDR       m_axi_pcie_m0_awaddr     M_AXI_PCIE_M0 1      
add_port_map_axi  AWLEN        m_axi_pcie_m0_awlen      M_AXI_PCIE_M0 1     
add_port_map_axi  AWSIZE       m_axi_pcie_m0_awsize     M_AXI_PCIE_M0 1      
add_port_map_axi  AWBURST      m_axi_pcie_m0_awburst    M_AXI_PCIE_M0 1       
add_port_map_axi  AWLOCK       m_axi_pcie_m0_awlock     M_AXI_PCIE_M0 1      
add_port_map_axi  AWCACHE      m_axi_pcie_m0_awcache    M_AXI_PCIE_M0 1       
add_port_map_axi  AWPROT       m_axi_pcie_m0_awprot     M_AXI_PCIE_M0 1      
add_port_map_axi  AWQOS        m_axi_pcie_m0_awqos      M_AXI_PCIE_M0 1     
add_port_map_axi  AWREGION     m_axi_pcie_m0_awregion   M_AXI_PCIE_M0 1         
add_port_map_axi  AWUSER       m_axi_pcie_m0_awuser     M_AXI_PCIE_M0 1      
add_port_map_axi  AWVALID      m_axi_pcie_m0_awvalid    M_AXI_PCIE_M0 1       
add_port_map_axi  AWREADY      m_axi_pcie_m0_awready    M_AXI_PCIE_M0 1       
add_port_map_axi  WDATA        m_axi_pcie_m0_wdata      M_AXI_PCIE_M0 1     
add_port_map_axi  WSTRB        m_axi_pcie_m0_wstrb      M_AXI_PCIE_M0 1     
add_port_map_axi  WLAST        m_axi_pcie_m0_wlast      M_AXI_PCIE_M0 1     
add_port_map_axi  WUSER        m_axi_pcie_m0_wuser      M_AXI_PCIE_M0 1     
add_port_map_axi  WVALID       m_axi_pcie_m0_wvalid     M_AXI_PCIE_M0 1      
add_port_map_axi  WREADY       m_axi_pcie_m0_wready     M_AXI_PCIE_M0 1      
add_port_map_axi  BID          m_axi_pcie_m0_bid        M_AXI_PCIE_M0 1   
add_port_map_axi  BRESP        m_axi_pcie_m0_bresp      M_AXI_PCIE_M0 1     
add_port_map_axi  BUSER        m_axi_pcie_m0_buser      M_AXI_PCIE_M0 1     
add_port_map_axi  BVALID       m_axi_pcie_m0_bvalid     M_AXI_PCIE_M0 1      
add_port_map_axi  BREADY       m_axi_pcie_m0_bready     M_AXI_PCIE_M0 1      
add_port_map_axi  ARID         m_axi_pcie_m0_arid       M_AXI_PCIE_M0 1    
add_port_map_axi  ARADDR       m_axi_pcie_m0_araddr     M_AXI_PCIE_M0 1      
add_port_map_axi  ARLEN        m_axi_pcie_m0_arlen      M_AXI_PCIE_M0 1     
add_port_map_axi  ARSIZE       m_axi_pcie_m0_arsize     M_AXI_PCIE_M0 1      
add_port_map_axi  ARBURST      m_axi_pcie_m0_arburst    M_AXI_PCIE_M0 1       
add_port_map_axi  ARLOCK       m_axi_pcie_m0_arlock     M_AXI_PCIE_M0 1      
add_port_map_axi  ARCACHE      m_axi_pcie_m0_arcache    M_AXI_PCIE_M0 1       
add_port_map_axi  ARPROT       m_axi_pcie_m0_arprot     M_AXI_PCIE_M0 1      
add_port_map_axi  ARQOS        m_axi_pcie_m0_arqos      M_AXI_PCIE_M0 1     
add_port_map_axi  ARREGION     m_axi_pcie_m0_arregion   M_AXI_PCIE_M0 1        
add_port_map_axi  ARUSER       m_axi_pcie_m0_aruser     M_AXI_PCIE_M0 1      
add_port_map_axi  ARVALID      m_axi_pcie_m0_arvalid    M_AXI_PCIE_M0 1       
add_port_map_axi  ARREADY      m_axi_pcie_m0_arready    M_AXI_PCIE_M0 1       
add_port_map_axi  RID          m_axi_pcie_m0_rid        M_AXI_PCIE_M0 1   
add_port_map_axi  RDATA        m_axi_pcie_m0_rdata      M_AXI_PCIE_M0 1     
add_port_map_axi  RRESP        m_axi_pcie_m0_rresp      M_AXI_PCIE_M0 1     
add_port_map_axi  RLAST        m_axi_pcie_m0_rlast      M_AXI_PCIE_M0 1     
add_port_map_axi  RUSER        m_axi_pcie_m0_ruser      M_AXI_PCIE_M0 1     
add_port_map_axi  RVALID       m_axi_pcie_m0_rvalid     M_AXI_PCIE_M0 1      
add_port_map_axi  RREADY       m_axi_pcie_m0_rready     M_AXI_PCIE_M0 1      


add_port_map_axi AWADDR    s_axi_pcie_m1_awaddr    S_AXI_PCIE_M1 1
add_port_map_axi AWPROT    s_axi_pcie_m1_awprot    S_AXI_PCIE_M1 1
add_port_map_axi AWVALID   s_axi_pcie_m1_awvalid   S_AXI_PCIE_M1 1
add_port_map_axi AWREADY   s_axi_pcie_m1_awready   S_AXI_PCIE_M1 1
add_port_map_axi WDATA     s_axi_pcie_m1_wdata     S_AXI_PCIE_M1 1
add_port_map_axi WSTRB     s_axi_pcie_m1_wstrb     S_AXI_PCIE_M1 1
add_port_map_axi WVALID    s_axi_pcie_m1_wvalid    S_AXI_PCIE_M1 1
add_port_map_axi WREADY    s_axi_pcie_m1_wready    S_AXI_PCIE_M1 1
add_port_map_axi BRESP     s_axi_pcie_m1_bresp     S_AXI_PCIE_M1 1
add_port_map_axi BVALID    s_axi_pcie_m1_bvalid    S_AXI_PCIE_M1 1
add_port_map_axi BREADY    s_axi_pcie_m1_bready    S_AXI_PCIE_M1 1
add_port_map_axi ARADDR    s_axi_pcie_m1_araddr    S_AXI_PCIE_M1 1
add_port_map_axi ARPROT    s_axi_pcie_m1_arprot    S_AXI_PCIE_M1 1
add_port_map_axi ARVALID   s_axi_pcie_m1_arvalid   S_AXI_PCIE_M1 1
add_port_map_axi ARREADY   s_axi_pcie_m1_arready   S_AXI_PCIE_M1 1
add_port_map_axi RDATA     s_axi_pcie_m1_rdata     S_AXI_PCIE_M1 1
add_port_map_axi RRESP     s_axi_pcie_m1_rresp     S_AXI_PCIE_M1 1
add_port_map_axi RVALID    s_axi_pcie_m1_rvalid    S_AXI_PCIE_M1 1
add_port_map_axi RREADY    s_axi_pcie_m1_rready    S_AXI_PCIE_M1 1
add_port_map_axi  AWID         m_axi_pcie_m1_awid       M_AXI_PCIE_M1 1    
add_port_map_axi  AWADDR       m_axi_pcie_m1_awaddr     M_AXI_PCIE_M1 1      
add_port_map_axi  AWLEN        m_axi_pcie_m1_awlen      M_AXI_PCIE_M1 1     
add_port_map_axi  AWSIZE       m_axi_pcie_m1_awsize     M_AXI_PCIE_M1 1      
add_port_map_axi  AWBURST      m_axi_pcie_m1_awburst    M_AXI_PCIE_M1 1       
add_port_map_axi  AWLOCK       m_axi_pcie_m1_awlock     M_AXI_PCIE_M1 1      
add_port_map_axi  AWCACHE      m_axi_pcie_m1_awcache    M_AXI_PCIE_M1 1       
add_port_map_axi  AWPROT       m_axi_pcie_m1_awprot     M_AXI_PCIE_M1 1      
add_port_map_axi  AWQOS        m_axi_pcie_m1_awqos      M_AXI_PCIE_M1 1     
add_port_map_axi  AWREGION     m_axi_pcie_m1_awregion   M_AXI_PCIE_M1 1         
add_port_map_axi  AWUSER       m_axi_pcie_m1_awuser     M_AXI_PCIE_M1 1      
add_port_map_axi  AWVALID      m_axi_pcie_m1_awvalid    M_AXI_PCIE_M1 1       
add_port_map_axi  AWREADY      m_axi_pcie_m1_awready    M_AXI_PCIE_M1 1       
add_port_map_axi  WDATA        m_axi_pcie_m1_wdata      M_AXI_PCIE_M1 1     
add_port_map_axi  WSTRB        m_axi_pcie_m1_wstrb      M_AXI_PCIE_M1 1     
add_port_map_axi  WLAST        m_axi_pcie_m1_wlast      M_AXI_PCIE_M1 1     
add_port_map_axi  WUSER        m_axi_pcie_m1_wuser      M_AXI_PCIE_M1 1     
add_port_map_axi  WVALID       m_axi_pcie_m1_wvalid     M_AXI_PCIE_M1 1      
add_port_map_axi  WREADY       m_axi_pcie_m1_wready     M_AXI_PCIE_M1 1      
add_port_map_axi  BID          m_axi_pcie_m1_bid        M_AXI_PCIE_M1 1   
add_port_map_axi  BRESP        m_axi_pcie_m1_bresp      M_AXI_PCIE_M1 1     
add_port_map_axi  BUSER        m_axi_pcie_m1_buser      M_AXI_PCIE_M1 1     
add_port_map_axi  BVALID       m_axi_pcie_m1_bvalid     M_AXI_PCIE_M1 1      
add_port_map_axi  BREADY       m_axi_pcie_m1_bready     M_AXI_PCIE_M1 1      
add_port_map_axi  ARID         m_axi_pcie_m1_arid       M_AXI_PCIE_M1 1    
add_port_map_axi  ARADDR       m_axi_pcie_m1_araddr     M_AXI_PCIE_M1 1      
add_port_map_axi  ARLEN        m_axi_pcie_m1_arlen      M_AXI_PCIE_M1 1     
add_port_map_axi  ARSIZE       m_axi_pcie_m1_arsize     M_AXI_PCIE_M1 1      
add_port_map_axi  ARBURST      m_axi_pcie_m1_arburst    M_AXI_PCIE_M1 1       
add_port_map_axi  ARLOCK       m_axi_pcie_m1_arlock     M_AXI_PCIE_M1 1      
add_port_map_axi  ARCACHE      m_axi_pcie_m1_arcache    M_AXI_PCIE_M1 1       
add_port_map_axi  ARPROT       m_axi_pcie_m1_arprot     M_AXI_PCIE_M1 1      
add_port_map_axi  ARQOS        m_axi_pcie_m1_arqos      M_AXI_PCIE_M1 1     
add_port_map_axi  ARREGION     m_axi_pcie_m1_arregion   M_AXI_PCIE_M1 1        
add_port_map_axi  ARUSER       m_axi_pcie_m1_aruser     M_AXI_PCIE_M1 1      
add_port_map_axi  ARVALID      m_axi_pcie_m1_arvalid    M_AXI_PCIE_M1 1       
add_port_map_axi  ARREADY      m_axi_pcie_m1_arready    M_AXI_PCIE_M1 1       
add_port_map_axi  RID          m_axi_pcie_m1_rid        M_AXI_PCIE_M1 1   
add_port_map_axi  RDATA        m_axi_pcie_m1_rdata      M_AXI_PCIE_M1 1     
add_port_map_axi  RRESP        m_axi_pcie_m1_rresp      M_AXI_PCIE_M1 1     
add_port_map_axi  RLAST        m_axi_pcie_m1_rlast      M_AXI_PCIE_M1 1     
add_port_map_axi  RUSER        m_axi_pcie_m1_ruser      M_AXI_PCIE_M1 1     
add_port_map_axi  RVALID       m_axi_pcie_m1_rvalid     M_AXI_PCIE_M1 1      
add_port_map_axi  RREADY       m_axi_pcie_m1_rready     M_AXI_PCIE_M1 1      


add_port_map_axi AWADDR    s_axi_pcie_m2_awaddr    S_AXI_PCIE_M2 1
add_port_map_axi AWPROT    s_axi_pcie_m2_awprot    S_AXI_PCIE_M2 1
add_port_map_axi AWVALID   s_axi_pcie_m2_awvalid   S_AXI_PCIE_M2 1
add_port_map_axi AWREADY   s_axi_pcie_m2_awready   S_AXI_PCIE_M2 1
add_port_map_axi WDATA     s_axi_pcie_m2_wdata     S_AXI_PCIE_M2 1
add_port_map_axi WSTRB     s_axi_pcie_m2_wstrb     S_AXI_PCIE_M2 1
add_port_map_axi WVALID    s_axi_pcie_m2_wvalid    S_AXI_PCIE_M2 1
add_port_map_axi WREADY    s_axi_pcie_m2_wready    S_AXI_PCIE_M2 1
add_port_map_axi BRESP     s_axi_pcie_m2_bresp     S_AXI_PCIE_M2 1
add_port_map_axi BVALID    s_axi_pcie_m2_bvalid    S_AXI_PCIE_M2 1
add_port_map_axi BREADY    s_axi_pcie_m2_bready    S_AXI_PCIE_M2 1
add_port_map_axi ARADDR    s_axi_pcie_m2_araddr    S_AXI_PCIE_M2 1
add_port_map_axi ARPROT    s_axi_pcie_m2_arprot    S_AXI_PCIE_M2 1
add_port_map_axi ARVALID   s_axi_pcie_m2_arvalid   S_AXI_PCIE_M2 1
add_port_map_axi ARREADY   s_axi_pcie_m2_arready   S_AXI_PCIE_M2 1
add_port_map_axi RDATA     s_axi_pcie_m2_rdata     S_AXI_PCIE_M2 1
add_port_map_axi RRESP     s_axi_pcie_m2_rresp     S_AXI_PCIE_M2 1
add_port_map_axi RVALID    s_axi_pcie_m2_rvalid    S_AXI_PCIE_M2 1
add_port_map_axi RREADY    s_axi_pcie_m2_rready    S_AXI_PCIE_M2 1
add_port_map_axi  AWID         m_axi_pcie_m2_awid       M_AXI_PCIE_M2 1    
add_port_map_axi  AWADDR       m_axi_pcie_m2_awaddr     M_AXI_PCIE_M2 1      
add_port_map_axi  AWLEN        m_axi_pcie_m2_awlen      M_AXI_PCIE_M2 1     
add_port_map_axi  AWSIZE       m_axi_pcie_m2_awsize     M_AXI_PCIE_M2 1      
add_port_map_axi  AWBURST      m_axi_pcie_m2_awburst    M_AXI_PCIE_M2 1       
add_port_map_axi  AWLOCK       m_axi_pcie_m2_awlock     M_AXI_PCIE_M2 1      
add_port_map_axi  AWCACHE      m_axi_pcie_m2_awcache    M_AXI_PCIE_M2 1       
add_port_map_axi  AWPROT       m_axi_pcie_m2_awprot     M_AXI_PCIE_M2 1      
add_port_map_axi  AWQOS        m_axi_pcie_m2_awqos      M_AXI_PCIE_M2 1     
add_port_map_axi  AWREGION     m_axi_pcie_m2_awregion   M_AXI_PCIE_M2 1         
add_port_map_axi  AWUSER       m_axi_pcie_m2_awuser     M_AXI_PCIE_M2 1      
add_port_map_axi  AWVALID      m_axi_pcie_m2_awvalid    M_AXI_PCIE_M2 1       
add_port_map_axi  AWREADY      m_axi_pcie_m2_awready    M_AXI_PCIE_M2 1       
add_port_map_axi  WDATA        m_axi_pcie_m2_wdata      M_AXI_PCIE_M2 1     
add_port_map_axi  WSTRB        m_axi_pcie_m2_wstrb      M_AXI_PCIE_M2 1     
add_port_map_axi  WLAST        m_axi_pcie_m2_wlast      M_AXI_PCIE_M2 1     
add_port_map_axi  WUSER        m_axi_pcie_m2_wuser      M_AXI_PCIE_M2 1     
add_port_map_axi  WVALID       m_axi_pcie_m2_wvalid     M_AXI_PCIE_M2 1      
add_port_map_axi  WREADY       m_axi_pcie_m2_wready     M_AXI_PCIE_M2 1      
add_port_map_axi  BID          m_axi_pcie_m2_bid        M_AXI_PCIE_M2 1   
add_port_map_axi  BRESP        m_axi_pcie_m2_bresp      M_AXI_PCIE_M2 1     
add_port_map_axi  BUSER        m_axi_pcie_m2_buser      M_AXI_PCIE_M2 1     
add_port_map_axi  BVALID       m_axi_pcie_m2_bvalid     M_AXI_PCIE_M2 1      
add_port_map_axi  BREADY       m_axi_pcie_m2_bready     M_AXI_PCIE_M2 1      
add_port_map_axi  ARID         m_axi_pcie_m2_arid       M_AXI_PCIE_M2 1    
add_port_map_axi  ARADDR       m_axi_pcie_m2_araddr     M_AXI_PCIE_M2 1      
add_port_map_axi  ARLEN        m_axi_pcie_m2_arlen      M_AXI_PCIE_M2 1     
add_port_map_axi  ARSIZE       m_axi_pcie_m2_arsize     M_AXI_PCIE_M2 1      
add_port_map_axi  ARBURST      m_axi_pcie_m2_arburst    M_AXI_PCIE_M2 1       
add_port_map_axi  ARLOCK       m_axi_pcie_m2_arlock     M_AXI_PCIE_M2 1      
add_port_map_axi  ARCACHE      m_axi_pcie_m2_arcache    M_AXI_PCIE_M2 1       
add_port_map_axi  ARPROT       m_axi_pcie_m2_arprot     M_AXI_PCIE_M2 1      
add_port_map_axi  ARQOS        m_axi_pcie_m2_arqos      M_AXI_PCIE_M2 1     
add_port_map_axi  ARREGION     m_axi_pcie_m2_arregion   M_AXI_PCIE_M2 1        
add_port_map_axi  ARUSER       m_axi_pcie_m2_aruser     M_AXI_PCIE_M2 1      
add_port_map_axi  ARVALID      m_axi_pcie_m2_arvalid    M_AXI_PCIE_M2 1       
add_port_map_axi  ARREADY      m_axi_pcie_m2_arready    M_AXI_PCIE_M2 1       
add_port_map_axi  RID          m_axi_pcie_m2_rid        M_AXI_PCIE_M2 1   
add_port_map_axi  RDATA        m_axi_pcie_m2_rdata      M_AXI_PCIE_M2 1     
add_port_map_axi  RRESP        m_axi_pcie_m2_rresp      M_AXI_PCIE_M2 1     
add_port_map_axi  RLAST        m_axi_pcie_m2_rlast      M_AXI_PCIE_M2 1     
add_port_map_axi  RUSER        m_axi_pcie_m2_ruser      M_AXI_PCIE_M2 1     
add_port_map_axi  RVALID       m_axi_pcie_m2_rvalid     M_AXI_PCIE_M2 1      
add_port_map_axi  RREADY       m_axi_pcie_m2_rready     M_AXI_PCIE_M2 1      


add_port_map_axi AWADDR    s_axi_pcie_m3_awaddr    S_AXI_PCIE_M3 1
add_port_map_axi AWPROT    s_axi_pcie_m3_awprot    S_AXI_PCIE_M3 1
add_port_map_axi AWVALID   s_axi_pcie_m3_awvalid   S_AXI_PCIE_M3 1
add_port_map_axi AWREADY   s_axi_pcie_m3_awready   S_AXI_PCIE_M3 1
add_port_map_axi WDATA     s_axi_pcie_m3_wdata     S_AXI_PCIE_M3 1
add_port_map_axi WSTRB     s_axi_pcie_m3_wstrb     S_AXI_PCIE_M3 1
add_port_map_axi WVALID    s_axi_pcie_m3_wvalid    S_AXI_PCIE_M3 1
add_port_map_axi WREADY    s_axi_pcie_m3_wready    S_AXI_PCIE_M3 1
add_port_map_axi BRESP     s_axi_pcie_m3_bresp     S_AXI_PCIE_M3 1
add_port_map_axi BVALID    s_axi_pcie_m3_bvalid    S_AXI_PCIE_M3 1
add_port_map_axi BREADY    s_axi_pcie_m3_bready    S_AXI_PCIE_M3 1
add_port_map_axi ARADDR    s_axi_pcie_m3_araddr    S_AXI_PCIE_M3 1
add_port_map_axi ARPROT    s_axi_pcie_m3_arprot    S_AXI_PCIE_M3 1
add_port_map_axi ARVALID   s_axi_pcie_m3_arvalid   S_AXI_PCIE_M3 1
add_port_map_axi ARREADY   s_axi_pcie_m3_arready   S_AXI_PCIE_M3 1
add_port_map_axi RDATA     s_axi_pcie_m3_rdata     S_AXI_PCIE_M3 1
add_port_map_axi RRESP     s_axi_pcie_m3_rresp     S_AXI_PCIE_M3 1
add_port_map_axi RVALID    s_axi_pcie_m3_rvalid    S_AXI_PCIE_M3 1
add_port_map_axi RREADY    s_axi_pcie_m3_rready    S_AXI_PCIE_M3 1
add_port_map_axi  AWID         m_axi_pcie_m3_awid       M_AXI_PCIE_M3 1    
add_port_map_axi  AWADDR       m_axi_pcie_m3_awaddr     M_AXI_PCIE_M3 1      
add_port_map_axi  AWLEN        m_axi_pcie_m3_awlen      M_AXI_PCIE_M3 1     
add_port_map_axi  AWSIZE       m_axi_pcie_m3_awsize     M_AXI_PCIE_M3 1      
add_port_map_axi  AWBURST      m_axi_pcie_m3_awburst    M_AXI_PCIE_M3 1       
add_port_map_axi  AWLOCK       m_axi_pcie_m3_awlock     M_AXI_PCIE_M3 1      
add_port_map_axi  AWCACHE      m_axi_pcie_m3_awcache    M_AXI_PCIE_M3 1       
add_port_map_axi  AWPROT       m_axi_pcie_m3_awprot     M_AXI_PCIE_M3 1      
add_port_map_axi  AWQOS        m_axi_pcie_m3_awqos      M_AXI_PCIE_M3 1     
add_port_map_axi  AWREGION     m_axi_pcie_m3_awregion   M_AXI_PCIE_M3 1         
add_port_map_axi  AWUSER       m_axi_pcie_m3_awuser     M_AXI_PCIE_M3 1      
add_port_map_axi  AWVALID      m_axi_pcie_m3_awvalid    M_AXI_PCIE_M3 1       
add_port_map_axi  AWREADY      m_axi_pcie_m3_awready    M_AXI_PCIE_M3 1       
add_port_map_axi  WDATA        m_axi_pcie_m3_wdata      M_AXI_PCIE_M3 1     
add_port_map_axi  WSTRB        m_axi_pcie_m3_wstrb      M_AXI_PCIE_M3 1     
add_port_map_axi  WLAST        m_axi_pcie_m3_wlast      M_AXI_PCIE_M3 1     
add_port_map_axi  WUSER        m_axi_pcie_m3_wuser      M_AXI_PCIE_M3 1     
add_port_map_axi  WVALID       m_axi_pcie_m3_wvalid     M_AXI_PCIE_M3 1      
add_port_map_axi  WREADY       m_axi_pcie_m3_wready     M_AXI_PCIE_M3 1      
add_port_map_axi  BID          m_axi_pcie_m3_bid        M_AXI_PCIE_M3 1   
add_port_map_axi  BRESP        m_axi_pcie_m3_bresp      M_AXI_PCIE_M3 1     
add_port_map_axi  BUSER        m_axi_pcie_m3_buser      M_AXI_PCIE_M3 1     
add_port_map_axi  BVALID       m_axi_pcie_m3_bvalid     M_AXI_PCIE_M3 1      
add_port_map_axi  BREADY       m_axi_pcie_m3_bready     M_AXI_PCIE_M3 1      
add_port_map_axi  ARID         m_axi_pcie_m3_arid       M_AXI_PCIE_M3 1    
add_port_map_axi  ARADDR       m_axi_pcie_m3_araddr     M_AXI_PCIE_M3 1      
add_port_map_axi  ARLEN        m_axi_pcie_m3_arlen      M_AXI_PCIE_M3 1     
add_port_map_axi  ARSIZE       m_axi_pcie_m3_arsize     M_AXI_PCIE_M3 1      
add_port_map_axi  ARBURST      m_axi_pcie_m3_arburst    M_AXI_PCIE_M3 1       
add_port_map_axi  ARLOCK       m_axi_pcie_m3_arlock     M_AXI_PCIE_M3 1      
add_port_map_axi  ARCACHE      m_axi_pcie_m3_arcache    M_AXI_PCIE_M3 1       
add_port_map_axi  ARPROT       m_axi_pcie_m3_arprot     M_AXI_PCIE_M3 1      
add_port_map_axi  ARQOS        m_axi_pcie_m3_arqos      M_AXI_PCIE_M3 1     
add_port_map_axi  ARREGION     m_axi_pcie_m3_arregion   M_AXI_PCIE_M3 1        
add_port_map_axi  ARUSER       m_axi_pcie_m3_aruser     M_AXI_PCIE_M3 1      
add_port_map_axi  ARVALID      m_axi_pcie_m3_arvalid    M_AXI_PCIE_M3 1       
add_port_map_axi  ARREADY      m_axi_pcie_m3_arready    M_AXI_PCIE_M3 1       
add_port_map_axi  RID          m_axi_pcie_m3_rid        M_AXI_PCIE_M3 1   
add_port_map_axi  RDATA        m_axi_pcie_m3_rdata      M_AXI_PCIE_M3 1     
add_port_map_axi  RRESP        m_axi_pcie_m3_rresp      M_AXI_PCIE_M3 1     
add_port_map_axi  RLAST        m_axi_pcie_m3_rlast      M_AXI_PCIE_M3 1     
add_port_map_axi  RUSER        m_axi_pcie_m3_ruser      M_AXI_PCIE_M3 1     
add_port_map_axi  RVALID       m_axi_pcie_m3_rvalid     M_AXI_PCIE_M3 1      
add_port_map_axi  RREADY       m_axi_pcie_m3_rready     M_AXI_PCIE_M3 1      


add_port_map_axi AWADDR    s_axi_pcie_m4_awaddr    S_AXI_PCIE_M4 1
add_port_map_axi AWPROT    s_axi_pcie_m4_awprot    S_AXI_PCIE_M4 1
add_port_map_axi AWVALID   s_axi_pcie_m4_awvalid   S_AXI_PCIE_M4 1
add_port_map_axi AWREADY   s_axi_pcie_m4_awready   S_AXI_PCIE_M4 1
add_port_map_axi WDATA     s_axi_pcie_m4_wdata     S_AXI_PCIE_M4 1
add_port_map_axi WSTRB     s_axi_pcie_m4_wstrb     S_AXI_PCIE_M4 1
add_port_map_axi WVALID    s_axi_pcie_m4_wvalid    S_AXI_PCIE_M4 1
add_port_map_axi WREADY    s_axi_pcie_m4_wready    S_AXI_PCIE_M4 1
add_port_map_axi BRESP     s_axi_pcie_m4_bresp     S_AXI_PCIE_M4 1
add_port_map_axi BVALID    s_axi_pcie_m4_bvalid    S_AXI_PCIE_M4 1
add_port_map_axi BREADY    s_axi_pcie_m4_bready    S_AXI_PCIE_M4 1
add_port_map_axi ARADDR    s_axi_pcie_m4_araddr    S_AXI_PCIE_M4 1
add_port_map_axi ARPROT    s_axi_pcie_m4_arprot    S_AXI_PCIE_M4 1
add_port_map_axi ARVALID   s_axi_pcie_m4_arvalid   S_AXI_PCIE_M4 1
add_port_map_axi ARREADY   s_axi_pcie_m4_arready   S_AXI_PCIE_M4 1
add_port_map_axi RDATA     s_axi_pcie_m4_rdata     S_AXI_PCIE_M4 1
add_port_map_axi RRESP     s_axi_pcie_m4_rresp     S_AXI_PCIE_M4 1
add_port_map_axi RVALID    s_axi_pcie_m4_rvalid    S_AXI_PCIE_M4 1
add_port_map_axi RREADY    s_axi_pcie_m4_rready    S_AXI_PCIE_M4 1
add_port_map_axi  AWID         m_axi_pcie_m4_awid       M_AXI_PCIE_M4 1    
add_port_map_axi  AWADDR       m_axi_pcie_m4_awaddr     M_AXI_PCIE_M4 1      
add_port_map_axi  AWLEN        m_axi_pcie_m4_awlen      M_AXI_PCIE_M4 1     
add_port_map_axi  AWSIZE       m_axi_pcie_m4_awsize     M_AXI_PCIE_M4 1      
add_port_map_axi  AWBURST      m_axi_pcie_m4_awburst    M_AXI_PCIE_M4 1       
add_port_map_axi  AWLOCK       m_axi_pcie_m4_awlock     M_AXI_PCIE_M4 1      
add_port_map_axi  AWCACHE      m_axi_pcie_m4_awcache    M_AXI_PCIE_M4 1       
add_port_map_axi  AWPROT       m_axi_pcie_m4_awprot     M_AXI_PCIE_M4 1      
add_port_map_axi  AWQOS        m_axi_pcie_m4_awqos      M_AXI_PCIE_M4 1     
add_port_map_axi  AWREGION     m_axi_pcie_m4_awregion   M_AXI_PCIE_M4 1         
add_port_map_axi  AWUSER       m_axi_pcie_m4_awuser     M_AXI_PCIE_M4 1      
add_port_map_axi  AWVALID      m_axi_pcie_m4_awvalid    M_AXI_PCIE_M4 1       
add_port_map_axi  AWREADY      m_axi_pcie_m4_awready    M_AXI_PCIE_M4 1       
add_port_map_axi  WDATA        m_axi_pcie_m4_wdata      M_AXI_PCIE_M4 1     
add_port_map_axi  WSTRB        m_axi_pcie_m4_wstrb      M_AXI_PCIE_M4 1     
add_port_map_axi  WLAST        m_axi_pcie_m4_wlast      M_AXI_PCIE_M4 1     
add_port_map_axi  WUSER        m_axi_pcie_m4_wuser      M_AXI_PCIE_M4 1     
add_port_map_axi  WVALID       m_axi_pcie_m4_wvalid     M_AXI_PCIE_M4 1      
add_port_map_axi  WREADY       m_axi_pcie_m4_wready     M_AXI_PCIE_M4 1      
add_port_map_axi  BID          m_axi_pcie_m4_bid        M_AXI_PCIE_M4 1   
add_port_map_axi  BRESP        m_axi_pcie_m4_bresp      M_AXI_PCIE_M4 1     
add_port_map_axi  BUSER        m_axi_pcie_m4_buser      M_AXI_PCIE_M4 1     
add_port_map_axi  BVALID       m_axi_pcie_m4_bvalid     M_AXI_PCIE_M4 1      
add_port_map_axi  BREADY       m_axi_pcie_m4_bready     M_AXI_PCIE_M4 1      
add_port_map_axi  ARID         m_axi_pcie_m4_arid       M_AXI_PCIE_M4 1    
add_port_map_axi  ARADDR       m_axi_pcie_m4_araddr     M_AXI_PCIE_M4 1      
add_port_map_axi  ARLEN        m_axi_pcie_m4_arlen      M_AXI_PCIE_M4 1     
add_port_map_axi  ARSIZE       m_axi_pcie_m4_arsize     M_AXI_PCIE_M4 1      
add_port_map_axi  ARBURST      m_axi_pcie_m4_arburst    M_AXI_PCIE_M4 1       
add_port_map_axi  ARLOCK       m_axi_pcie_m4_arlock     M_AXI_PCIE_M4 1      
add_port_map_axi  ARCACHE      m_axi_pcie_m4_arcache    M_AXI_PCIE_M4 1       
add_port_map_axi  ARPROT       m_axi_pcie_m4_arprot     M_AXI_PCIE_M4 1      
add_port_map_axi  ARQOS        m_axi_pcie_m4_arqos      M_AXI_PCIE_M4 1     
add_port_map_axi  ARREGION     m_axi_pcie_m4_arregion   M_AXI_PCIE_M4 1        
add_port_map_axi  ARUSER       m_axi_pcie_m4_aruser     M_AXI_PCIE_M4 1      
add_port_map_axi  ARVALID      m_axi_pcie_m4_arvalid    M_AXI_PCIE_M4 1       
add_port_map_axi  ARREADY      m_axi_pcie_m4_arready    M_AXI_PCIE_M4 1       
add_port_map_axi  RID          m_axi_pcie_m4_rid        M_AXI_PCIE_M4 1   
add_port_map_axi  RDATA        m_axi_pcie_m4_rdata      M_AXI_PCIE_M4 1     
add_port_map_axi  RRESP        m_axi_pcie_m4_rresp      M_AXI_PCIE_M4 1     
add_port_map_axi  RLAST        m_axi_pcie_m4_rlast      M_AXI_PCIE_M4 1     
add_port_map_axi  RUSER        m_axi_pcie_m4_ruser      M_AXI_PCIE_M4 1     
add_port_map_axi  RVALID       m_axi_pcie_m4_rvalid     M_AXI_PCIE_M4 1      
add_port_map_axi  RREADY       m_axi_pcie_m4_rready     M_AXI_PCIE_M4 1      

add_port_map_axi AWADDR    s_axi_pcie_m5_awaddr    S_AXI_PCIE_M5 1
add_port_map_axi AWPROT    s_axi_pcie_m5_awprot    S_AXI_PCIE_M5 1
add_port_map_axi AWVALID   s_axi_pcie_m5_awvalid   S_AXI_PCIE_M5 1
add_port_map_axi AWREADY   s_axi_pcie_m5_awready   S_AXI_PCIE_M5 1
add_port_map_axi WDATA     s_axi_pcie_m5_wdata     S_AXI_PCIE_M5 1
add_port_map_axi WSTRB     s_axi_pcie_m5_wstrb     S_AXI_PCIE_M5 1
add_port_map_axi WVALID    s_axi_pcie_m5_wvalid    S_AXI_PCIE_M5 1
add_port_map_axi WREADY    s_axi_pcie_m5_wready    S_AXI_PCIE_M5 1
add_port_map_axi BRESP     s_axi_pcie_m5_bresp     S_AXI_PCIE_M5 1
add_port_map_axi BVALID    s_axi_pcie_m5_bvalid    S_AXI_PCIE_M5 1
add_port_map_axi BREADY    s_axi_pcie_m5_bready    S_AXI_PCIE_M5 1
add_port_map_axi ARADDR    s_axi_pcie_m5_araddr    S_AXI_PCIE_M5 1
add_port_map_axi ARPROT    s_axi_pcie_m5_arprot    S_AXI_PCIE_M5 1
add_port_map_axi ARVALID   s_axi_pcie_m5_arvalid   S_AXI_PCIE_M5 1
add_port_map_axi ARREADY   s_axi_pcie_m5_arready   S_AXI_PCIE_M5 1
add_port_map_axi RDATA     s_axi_pcie_m5_rdata     S_AXI_PCIE_M5 1
add_port_map_axi RRESP     s_axi_pcie_m5_rresp     S_AXI_PCIE_M5 1
add_port_map_axi RVALID    s_axi_pcie_m5_rvalid    S_AXI_PCIE_M5 1
add_port_map_axi RREADY    s_axi_pcie_m5_rready    S_AXI_PCIE_M5 1
add_port_map_axi  AWID         m_axi_pcie_m5_awid       M_AXI_PCIE_M5 1    
add_port_map_axi  AWADDR       m_axi_pcie_m5_awaddr     M_AXI_PCIE_M5 1      
add_port_map_axi  AWLEN        m_axi_pcie_m5_awlen      M_AXI_PCIE_M5 1     
add_port_map_axi  AWSIZE       m_axi_pcie_m5_awsize     M_AXI_PCIE_M5 1      
add_port_map_axi  AWBURST      m_axi_pcie_m5_awburst    M_AXI_PCIE_M5 1       
add_port_map_axi  AWLOCK       m_axi_pcie_m5_awlock     M_AXI_PCIE_M5 1      
add_port_map_axi  AWCACHE      m_axi_pcie_m5_awcache    M_AXI_PCIE_M5 1       
add_port_map_axi  AWPROT       m_axi_pcie_m5_awprot     M_AXI_PCIE_M5 1      
add_port_map_axi  AWQOS        m_axi_pcie_m5_awqos      M_AXI_PCIE_M5 1     
add_port_map_axi  AWREGION     m_axi_pcie_m5_awregion   M_AXI_PCIE_M5 1         
add_port_map_axi  AWUSER       m_axi_pcie_m5_awuser     M_AXI_PCIE_M5 1      
add_port_map_axi  AWVALID      m_axi_pcie_m5_awvalid    M_AXI_PCIE_M5 1       
add_port_map_axi  AWREADY      m_axi_pcie_m5_awready    M_AXI_PCIE_M5 1       
add_port_map_axi  WDATA        m_axi_pcie_m5_wdata      M_AXI_PCIE_M5 1     
add_port_map_axi  WSTRB        m_axi_pcie_m5_wstrb      M_AXI_PCIE_M5 1     
add_port_map_axi  WLAST        m_axi_pcie_m5_wlast      M_AXI_PCIE_M5 1     
add_port_map_axi  WUSER        m_axi_pcie_m5_wuser      M_AXI_PCIE_M5 1     
add_port_map_axi  WVALID       m_axi_pcie_m5_wvalid     M_AXI_PCIE_M5 1      
add_port_map_axi  WREADY       m_axi_pcie_m5_wready     M_AXI_PCIE_M5 1      
add_port_map_axi  BID          m_axi_pcie_m5_bid        M_AXI_PCIE_M5 1   
add_port_map_axi  BRESP        m_axi_pcie_m5_bresp      M_AXI_PCIE_M5 1     
add_port_map_axi  BUSER        m_axi_pcie_m5_buser      M_AXI_PCIE_M5 1     
add_port_map_axi  BVALID       m_axi_pcie_m5_bvalid     M_AXI_PCIE_M5 1      
add_port_map_axi  BREADY       m_axi_pcie_m5_bready     M_AXI_PCIE_M5 1      
add_port_map_axi  ARID         m_axi_pcie_m5_arid       M_AXI_PCIE_M5 1    
add_port_map_axi  ARADDR       m_axi_pcie_m5_araddr     M_AXI_PCIE_M5 1      
add_port_map_axi  ARLEN        m_axi_pcie_m5_arlen      M_AXI_PCIE_M5 1     
add_port_map_axi  ARSIZE       m_axi_pcie_m5_arsize     M_AXI_PCIE_M5 1      
add_port_map_axi  ARBURST      m_axi_pcie_m5_arburst    M_AXI_PCIE_M5 1       
add_port_map_axi  ARLOCK       m_axi_pcie_m5_arlock     M_AXI_PCIE_M5 1      
add_port_map_axi  ARCACHE      m_axi_pcie_m5_arcache    M_AXI_PCIE_M5 1       
add_port_map_axi  ARPROT       m_axi_pcie_m5_arprot     M_AXI_PCIE_M5 1      
add_port_map_axi  ARQOS        m_axi_pcie_m5_arqos      M_AXI_PCIE_M5 1     
add_port_map_axi  ARREGION     m_axi_pcie_m5_arregion   M_AXI_PCIE_M5 1        
add_port_map_axi  ARUSER       m_axi_pcie_m5_aruser     M_AXI_PCIE_M5 1      
add_port_map_axi  ARVALID      m_axi_pcie_m5_arvalid    M_AXI_PCIE_M5 1       
add_port_map_axi  ARREADY      m_axi_pcie_m5_arready    M_AXI_PCIE_M5 1       
add_port_map_axi  RID          m_axi_pcie_m5_rid        M_AXI_PCIE_M5 1   
add_port_map_axi  RDATA        m_axi_pcie_m5_rdata      M_AXI_PCIE_M5 1     
add_port_map_axi  RRESP        m_axi_pcie_m5_rresp      M_AXI_PCIE_M5 1     
add_port_map_axi  RLAST        m_axi_pcie_m5_rlast      M_AXI_PCIE_M5 1     
add_port_map_axi  RUSER        m_axi_pcie_m5_ruser      M_AXI_PCIE_M5 1     
add_port_map_axi  RVALID       m_axi_pcie_m5_rvalid     M_AXI_PCIE_M5 1      
add_port_map_axi  RREADY       m_axi_pcie_m5_rready     M_AXI_PCIE_M5 1      


add_port_map_axi AWADDR    s_axi_pcie_s0_awaddr    S_AXI_PCIE_S0 1
add_port_map_axi AWPROT    s_axi_pcie_s0_awprot    S_AXI_PCIE_S0 1
add_port_map_axi AWVALID   s_axi_pcie_s0_awvalid   S_AXI_PCIE_S0 1
add_port_map_axi AWREADY   s_axi_pcie_s0_awready   S_AXI_PCIE_S0 1
add_port_map_axi WDATA     s_axi_pcie_s0_wdata     S_AXI_PCIE_S0 1
add_port_map_axi WSTRB     s_axi_pcie_s0_wstrb     S_AXI_PCIE_S0 1
add_port_map_axi WVALID    s_axi_pcie_s0_wvalid    S_AXI_PCIE_S0 1
add_port_map_axi WREADY    s_axi_pcie_s0_wready    S_AXI_PCIE_S0 1
add_port_map_axi BRESP     s_axi_pcie_s0_bresp     S_AXI_PCIE_S0 1
add_port_map_axi BVALID    s_axi_pcie_s0_bvalid    S_AXI_PCIE_S0 1
add_port_map_axi BREADY    s_axi_pcie_s0_bready    S_AXI_PCIE_S0 1
add_port_map_axi ARADDR    s_axi_pcie_s0_araddr    S_AXI_PCIE_S0 1
add_port_map_axi ARPROT    s_axi_pcie_s0_arprot    S_AXI_PCIE_S0 1
add_port_map_axi ARVALID   s_axi_pcie_s0_arvalid   S_AXI_PCIE_S0 1
add_port_map_axi ARREADY   s_axi_pcie_s0_arready   S_AXI_PCIE_S0 1
add_port_map_axi RDATA     s_axi_pcie_s0_rdata     S_AXI_PCIE_S0 1
add_port_map_axi RRESP     s_axi_pcie_s0_rresp     S_AXI_PCIE_S0 1
add_port_map_axi RVALID    s_axi_pcie_s0_rvalid    S_AXI_PCIE_S0 1
add_port_map_axi RREADY    s_axi_pcie_s0_rready    S_AXI_PCIE_S0 1
add_port_map_axi  AWID         m_axi_pcie_s0_awid       M_AXI_PCIE_S0 1    
add_port_map_axi  AWADDR       m_axi_pcie_s0_awaddr     M_AXI_PCIE_S0 1      
add_port_map_axi  AWLEN        m_axi_pcie_s0_awlen      M_AXI_PCIE_S0 1     
add_port_map_axi  AWSIZE       m_axi_pcie_s0_awsize     M_AXI_PCIE_S0 1      
add_port_map_axi  AWBURST      m_axi_pcie_s0_awburst    M_AXI_PCIE_S0 1       
add_port_map_axi  AWLOCK       m_axi_pcie_s0_awlock     M_AXI_PCIE_S0 1      
add_port_map_axi  AWCACHE      m_axi_pcie_s0_awcache    M_AXI_PCIE_S0 1       
add_port_map_axi  AWPROT       m_axi_pcie_s0_awprot     M_AXI_PCIE_S0 1      
add_port_map_axi  AWQOS        m_axi_pcie_s0_awqos      M_AXI_PCIE_S0 1     
add_port_map_axi  AWREGION     m_axi_pcie_s0_awregion   M_AXI_PCIE_S0 1         
add_port_map_axi  AWUSER       m_axi_pcie_s0_awuser     M_AXI_PCIE_S0 1      
add_port_map_axi  AWVALID      m_axi_pcie_s0_awvalid    M_AXI_PCIE_S0 1       
add_port_map_axi  AWREADY      m_axi_pcie_s0_awready    M_AXI_PCIE_S0 1       
add_port_map_axi  WDATA        m_axi_pcie_s0_wdata      M_AXI_PCIE_S0 1     
add_port_map_axi  WSTRB        m_axi_pcie_s0_wstrb      M_AXI_PCIE_S0 1     
add_port_map_axi  WLAST        m_axi_pcie_s0_wlast      M_AXI_PCIE_S0 1     
add_port_map_axi  WUSER        m_axi_pcie_s0_wuser      M_AXI_PCIE_S0 1     
add_port_map_axi  WVALID       m_axi_pcie_s0_wvalid     M_AXI_PCIE_S0 1      
add_port_map_axi  WREADY       m_axi_pcie_s0_wready     M_AXI_PCIE_S0 1      
add_port_map_axi  BID          m_axi_pcie_s0_bid        M_AXI_PCIE_S0 1   
add_port_map_axi  BRESP        m_axi_pcie_s0_bresp      M_AXI_PCIE_S0 1     
add_port_map_axi  BUSER        m_axi_pcie_s0_buser      M_AXI_PCIE_S0 1     
add_port_map_axi  BVALID       m_axi_pcie_s0_bvalid     M_AXI_PCIE_S0 1      
add_port_map_axi  BREADY       m_axi_pcie_s0_bready     M_AXI_PCIE_S0 1      
add_port_map_axi  ARID         m_axi_pcie_s0_arid       M_AXI_PCIE_S0 1    
add_port_map_axi  ARADDR       m_axi_pcie_s0_araddr     M_AXI_PCIE_S0 1      
add_port_map_axi  ARLEN        m_axi_pcie_s0_arlen      M_AXI_PCIE_S0 1     
add_port_map_axi  ARSIZE       m_axi_pcie_s0_arsize     M_AXI_PCIE_S0 1      
add_port_map_axi  ARBURST      m_axi_pcie_s0_arburst    M_AXI_PCIE_S0 1       
add_port_map_axi  ARLOCK       m_axi_pcie_s0_arlock     M_AXI_PCIE_S0 1      
add_port_map_axi  ARCACHE      m_axi_pcie_s0_arcache    M_AXI_PCIE_S0 1       
add_port_map_axi  ARPROT       m_axi_pcie_s0_arprot     M_AXI_PCIE_S0 1      
add_port_map_axi  ARQOS        m_axi_pcie_s0_arqos      M_AXI_PCIE_S0 1     
add_port_map_axi  ARREGION     m_axi_pcie_s0_arregion   M_AXI_PCIE_S0 1        
add_port_map_axi  ARUSER       m_axi_pcie_s0_aruser     M_AXI_PCIE_S0 1      
add_port_map_axi  ARVALID      m_axi_pcie_s0_arvalid    M_AXI_PCIE_S0 1       
add_port_map_axi  ARREADY      m_axi_pcie_s0_arready    M_AXI_PCIE_S0 1       
add_port_map_axi  RID          m_axi_pcie_s0_rid        M_AXI_PCIE_S0 1   
add_port_map_axi  RDATA        m_axi_pcie_s0_rdata      M_AXI_PCIE_S0 1     
add_port_map_axi  RRESP        m_axi_pcie_s0_rresp      M_AXI_PCIE_S0 1     
add_port_map_axi  RLAST        m_axi_pcie_s0_rlast      M_AXI_PCIE_S0 1     
add_port_map_axi  RUSER        m_axi_pcie_s0_ruser      M_AXI_PCIE_S0 1     
add_port_map_axi  RVALID       m_axi_pcie_s0_rvalid     M_AXI_PCIE_S0 1      
add_port_map_axi  RREADY       m_axi_pcie_s0_rready     M_AXI_PCIE_S0 1      


add_port_map_axi AWADDR    s_axi_pcie_s1_awaddr    S_AXI_PCIE_S1 1
add_port_map_axi AWPROT    s_axi_pcie_s1_awprot    S_AXI_PCIE_S1 1
add_port_map_axi AWVALID   s_axi_pcie_s1_awvalid   S_AXI_PCIE_S1 1
add_port_map_axi AWREADY   s_axi_pcie_s1_awready   S_AXI_PCIE_S1 1
add_port_map_axi WDATA     s_axi_pcie_s1_wdata     S_AXI_PCIE_S1 1
add_port_map_axi WSTRB     s_axi_pcie_s1_wstrb     S_AXI_PCIE_S1 1
add_port_map_axi WVALID    s_axi_pcie_s1_wvalid    S_AXI_PCIE_S1 1
add_port_map_axi WREADY    s_axi_pcie_s1_wready    S_AXI_PCIE_S1 1
add_port_map_axi BRESP     s_axi_pcie_s1_bresp     S_AXI_PCIE_S1 1
add_port_map_axi BVALID    s_axi_pcie_s1_bvalid    S_AXI_PCIE_S1 1
add_port_map_axi BREADY    s_axi_pcie_s1_bready    S_AXI_PCIE_S1 1
add_port_map_axi ARADDR    s_axi_pcie_s1_araddr    S_AXI_PCIE_S1 1
add_port_map_axi ARPROT    s_axi_pcie_s1_arprot    S_AXI_PCIE_S1 1
add_port_map_axi ARVALID   s_axi_pcie_s1_arvalid   S_AXI_PCIE_S1 1
add_port_map_axi ARREADY   s_axi_pcie_s1_arready   S_AXI_PCIE_S1 1
add_port_map_axi RDATA     s_axi_pcie_s1_rdata     S_AXI_PCIE_S1 1
add_port_map_axi RRESP     s_axi_pcie_s1_rresp     S_AXI_PCIE_S1 1
add_port_map_axi RVALID    s_axi_pcie_s1_rvalid    S_AXI_PCIE_S1 1
add_port_map_axi RREADY    s_axi_pcie_s1_rready    S_AXI_PCIE_S1 1
add_port_map_axi  AWID         m_axi_pcie_s1_awid       M_AXI_PCIE_S1 1    
add_port_map_axi  AWADDR       m_axi_pcie_s1_awaddr     M_AXI_PCIE_S1 1      
add_port_map_axi  AWLEN        m_axi_pcie_s1_awlen      M_AXI_PCIE_S1 1     
add_port_map_axi  AWSIZE       m_axi_pcie_s1_awsize     M_AXI_PCIE_S1 1      
add_port_map_axi  AWBURST      m_axi_pcie_s1_awburst    M_AXI_PCIE_S1 1       
add_port_map_axi  AWLOCK       m_axi_pcie_s1_awlock     M_AXI_PCIE_S1 1      
add_port_map_axi  AWCACHE      m_axi_pcie_s1_awcache    M_AXI_PCIE_S1 1       
add_port_map_axi  AWPROT       m_axi_pcie_s1_awprot     M_AXI_PCIE_S1 1      
add_port_map_axi  AWQOS        m_axi_pcie_s1_awqos      M_AXI_PCIE_S1 1     
add_port_map_axi  AWREGION     m_axi_pcie_s1_awregion   M_AXI_PCIE_S1 1         
add_port_map_axi  AWUSER       m_axi_pcie_s1_awuser     M_AXI_PCIE_S1 1      
add_port_map_axi  AWVALID      m_axi_pcie_s1_awvalid    M_AXI_PCIE_S1 1       
add_port_map_axi  AWREADY      m_axi_pcie_s1_awready    M_AXI_PCIE_S1 1       
add_port_map_axi  WDATA        m_axi_pcie_s1_wdata      M_AXI_PCIE_S1 1     
add_port_map_axi  WSTRB        m_axi_pcie_s1_wstrb      M_AXI_PCIE_S1 1     
add_port_map_axi  WLAST        m_axi_pcie_s1_wlast      M_AXI_PCIE_S1 1     
add_port_map_axi  WUSER        m_axi_pcie_s1_wuser      M_AXI_PCIE_S1 1     
add_port_map_axi  WVALID       m_axi_pcie_s1_wvalid     M_AXI_PCIE_S1 1      
add_port_map_axi  WREADY       m_axi_pcie_s1_wready     M_AXI_PCIE_S1 1      
add_port_map_axi  BID          m_axi_pcie_s1_bid        M_AXI_PCIE_S1 1   
add_port_map_axi  BRESP        m_axi_pcie_s1_bresp      M_AXI_PCIE_S1 1     
add_port_map_axi  BUSER        m_axi_pcie_s1_buser      M_AXI_PCIE_S1 1     
add_port_map_axi  BVALID       m_axi_pcie_s1_bvalid     M_AXI_PCIE_S1 1      
add_port_map_axi  BREADY       m_axi_pcie_s1_bready     M_AXI_PCIE_S1 1      
add_port_map_axi  ARID         m_axi_pcie_s1_arid       M_AXI_PCIE_S1 1    
add_port_map_axi  ARADDR       m_axi_pcie_s1_araddr     M_AXI_PCIE_S1 1      
add_port_map_axi  ARLEN        m_axi_pcie_s1_arlen      M_AXI_PCIE_S1 1     
add_port_map_axi  ARSIZE       m_axi_pcie_s1_arsize     M_AXI_PCIE_S1 1      
add_port_map_axi  ARBURST      m_axi_pcie_s1_arburst    M_AXI_PCIE_S1 1       
add_port_map_axi  ARLOCK       m_axi_pcie_s1_arlock     M_AXI_PCIE_S1 1      
add_port_map_axi  ARCACHE      m_axi_pcie_s1_arcache    M_AXI_PCIE_S1 1       
add_port_map_axi  ARPROT       m_axi_pcie_s1_arprot     M_AXI_PCIE_S1 1      
add_port_map_axi  ARQOS        m_axi_pcie_s1_arqos      M_AXI_PCIE_S1 1     
add_port_map_axi  ARREGION     m_axi_pcie_s1_arregion   M_AXI_PCIE_S1 1        
add_port_map_axi  ARUSER       m_axi_pcie_s1_aruser     M_AXI_PCIE_S1 1      
add_port_map_axi  ARVALID      m_axi_pcie_s1_arvalid    M_AXI_PCIE_S1 1       
add_port_map_axi  ARREADY      m_axi_pcie_s1_arready    M_AXI_PCIE_S1 1       
add_port_map_axi  RID          m_axi_pcie_s1_rid        M_AXI_PCIE_S1 1   
add_port_map_axi  RDATA        m_axi_pcie_s1_rdata      M_AXI_PCIE_S1 1     
add_port_map_axi  RRESP        m_axi_pcie_s1_rresp      M_AXI_PCIE_S1 1     
add_port_map_axi  RLAST        m_axi_pcie_s1_rlast      M_AXI_PCIE_S1 1     
add_port_map_axi  RUSER        m_axi_pcie_s1_ruser      M_AXI_PCIE_S1 1     
add_port_map_axi  RVALID       m_axi_pcie_s1_rvalid     M_AXI_PCIE_S1 1      
add_port_map_axi  RREADY       m_axi_pcie_s1_rready     M_AXI_PCIE_S1 1      

add_port_map_axi AWADDR    s_axi_pcie_s2_awaddr    S_AXI_PCIE_S2 1
add_port_map_axi AWPROT    s_axi_pcie_s2_awprot    S_AXI_PCIE_S2 1
add_port_map_axi AWVALID   s_axi_pcie_s2_awvalid   S_AXI_PCIE_S2 1
add_port_map_axi AWREADY   s_axi_pcie_s2_awready   S_AXI_PCIE_S2 1
add_port_map_axi WDATA     s_axi_pcie_s2_wdata     S_AXI_PCIE_S2 1
add_port_map_axi WSTRB     s_axi_pcie_s2_wstrb     S_AXI_PCIE_S2 1
add_port_map_axi WVALID    s_axi_pcie_s2_wvalid    S_AXI_PCIE_S2 1
add_port_map_axi WREADY    s_axi_pcie_s2_wready    S_AXI_PCIE_S2 1
add_port_map_axi BRESP     s_axi_pcie_s2_bresp     S_AXI_PCIE_S2 1
add_port_map_axi BVALID    s_axi_pcie_s2_bvalid    S_AXI_PCIE_S2 1
add_port_map_axi BREADY    s_axi_pcie_s2_bready    S_AXI_PCIE_S2 1
add_port_map_axi ARADDR    s_axi_pcie_s2_araddr    S_AXI_PCIE_S2 1
add_port_map_axi ARPROT    s_axi_pcie_s2_arprot    S_AXI_PCIE_S2 1
add_port_map_axi ARVALID   s_axi_pcie_s2_arvalid   S_AXI_PCIE_S2 1
add_port_map_axi ARREADY   s_axi_pcie_s2_arready   S_AXI_PCIE_S2 1
add_port_map_axi RDATA     s_axi_pcie_s2_rdata     S_AXI_PCIE_S2 1
add_port_map_axi RRESP     s_axi_pcie_s2_rresp     S_AXI_PCIE_S2 1
add_port_map_axi RVALID    s_axi_pcie_s2_rvalid    S_AXI_PCIE_S2 1
add_port_map_axi RREADY    s_axi_pcie_s2_rready    S_AXI_PCIE_S2 1
add_port_map_axi  AWID         m_axi_pcie_s2_awid       M_AXI_PCIE_S2 1    
add_port_map_axi  AWADDR       m_axi_pcie_s2_awaddr     M_AXI_PCIE_S2 1      
add_port_map_axi  AWLEN        m_axi_pcie_s2_awlen      M_AXI_PCIE_S2 1     
add_port_map_axi  AWSIZE       m_axi_pcie_s2_awsize     M_AXI_PCIE_S2 1      
add_port_map_axi  AWBURST      m_axi_pcie_s2_awburst    M_AXI_PCIE_S2 1       
add_port_map_axi  AWLOCK       m_axi_pcie_s2_awlock     M_AXI_PCIE_S2 1      
add_port_map_axi  AWCACHE      m_axi_pcie_s2_awcache    M_AXI_PCIE_S2 1       
add_port_map_axi  AWPROT       m_axi_pcie_s2_awprot     M_AXI_PCIE_S2 1      
add_port_map_axi  AWQOS        m_axi_pcie_s2_awqos      M_AXI_PCIE_S2 1     
add_port_map_axi  AWREGION     m_axi_pcie_s2_awregion   M_AXI_PCIE_S2 1         
add_port_map_axi  AWUSER       m_axi_pcie_s2_awuser     M_AXI_PCIE_S2 1      
add_port_map_axi  AWVALID      m_axi_pcie_s2_awvalid    M_AXI_PCIE_S2 1       
add_port_map_axi  AWREADY      m_axi_pcie_s2_awready    M_AXI_PCIE_S2 1       
add_port_map_axi  WDATA        m_axi_pcie_s2_wdata      M_AXI_PCIE_S2 1     
add_port_map_axi  WSTRB        m_axi_pcie_s2_wstrb      M_AXI_PCIE_S2 1     
add_port_map_axi  WLAST        m_axi_pcie_s2_wlast      M_AXI_PCIE_S2 1     
add_port_map_axi  WUSER        m_axi_pcie_s2_wuser      M_AXI_PCIE_S2 1     
add_port_map_axi  WVALID       m_axi_pcie_s2_wvalid     M_AXI_PCIE_S2 1      
add_port_map_axi  WREADY       m_axi_pcie_s2_wready     M_AXI_PCIE_S2 1      
add_port_map_axi  BID          m_axi_pcie_s2_bid        M_AXI_PCIE_S2 1   
add_port_map_axi  BRESP        m_axi_pcie_s2_bresp      M_AXI_PCIE_S2 1     
add_port_map_axi  BUSER        m_axi_pcie_s2_buser      M_AXI_PCIE_S2 1     
add_port_map_axi  BVALID       m_axi_pcie_s2_bvalid     M_AXI_PCIE_S2 1      
add_port_map_axi  BREADY       m_axi_pcie_s2_bready     M_AXI_PCIE_S2 1      
add_port_map_axi  ARID         m_axi_pcie_s2_arid       M_AXI_PCIE_S2 1    
add_port_map_axi  ARADDR       m_axi_pcie_s2_araddr     M_AXI_PCIE_S2 1      
add_port_map_axi  ARLEN        m_axi_pcie_s2_arlen      M_AXI_PCIE_S2 1     
add_port_map_axi  ARSIZE       m_axi_pcie_s2_arsize     M_AXI_PCIE_S2 1      
add_port_map_axi  ARBURST      m_axi_pcie_s2_arburst    M_AXI_PCIE_S2 1       
add_port_map_axi  ARLOCK       m_axi_pcie_s2_arlock     M_AXI_PCIE_S2 1      
add_port_map_axi  ARCACHE      m_axi_pcie_s2_arcache    M_AXI_PCIE_S2 1       
add_port_map_axi  ARPROT       m_axi_pcie_s2_arprot     M_AXI_PCIE_S2 1      
add_port_map_axi  ARQOS        m_axi_pcie_s2_arqos      M_AXI_PCIE_S2 1     
add_port_map_axi  ARREGION     m_axi_pcie_s2_arregion   M_AXI_PCIE_S2 1        
add_port_map_axi  ARUSER       m_axi_pcie_s2_aruser     M_AXI_PCIE_S2 1      
add_port_map_axi  ARVALID      m_axi_pcie_s2_arvalid    M_AXI_PCIE_S2 1       
add_port_map_axi  ARREADY      m_axi_pcie_s2_arready    M_AXI_PCIE_S2 1       
add_port_map_axi  RID          m_axi_pcie_s2_rid        M_AXI_PCIE_S2 1   
add_port_map_axi  RDATA        m_axi_pcie_s2_rdata      M_AXI_PCIE_S2 1     
add_port_map_axi  RRESP        m_axi_pcie_s2_rresp      M_AXI_PCIE_S2 1     
add_port_map_axi  RLAST        m_axi_pcie_s2_rlast      M_AXI_PCIE_S2 1     
add_port_map_axi  RUSER        m_axi_pcie_s2_ruser      M_AXI_PCIE_S2 1     
add_port_map_axi  RVALID       m_axi_pcie_s2_rvalid     M_AXI_PCIE_S2 1      
add_port_map_axi  RREADY       m_axi_pcie_s2_rready     M_AXI_PCIE_S2 1      

add_port_map_axi AWADDR    s_axi_pcie_s3_awaddr    S_AXI_PCIE_S3 1
add_port_map_axi AWPROT    s_axi_pcie_s3_awprot    S_AXI_PCIE_S3 1
add_port_map_axi AWVALID   s_axi_pcie_s3_awvalid   S_AXI_PCIE_S3 1
add_port_map_axi AWREADY   s_axi_pcie_s3_awready   S_AXI_PCIE_S3 1
add_port_map_axi WDATA     s_axi_pcie_s3_wdata     S_AXI_PCIE_S3 1
add_port_map_axi WSTRB     s_axi_pcie_s3_wstrb     S_AXI_PCIE_S3 1
add_port_map_axi WVALID    s_axi_pcie_s3_wvalid    S_AXI_PCIE_S3 1
add_port_map_axi WREADY    s_axi_pcie_s3_wready    S_AXI_PCIE_S3 1
add_port_map_axi BRESP     s_axi_pcie_s3_bresp     S_AXI_PCIE_S3 1
add_port_map_axi BVALID    s_axi_pcie_s3_bvalid    S_AXI_PCIE_S3 1
add_port_map_axi BREADY    s_axi_pcie_s3_bready    S_AXI_PCIE_S3 1
add_port_map_axi ARADDR    s_axi_pcie_s3_araddr    S_AXI_PCIE_S3 1
add_port_map_axi ARPROT    s_axi_pcie_s3_arprot    S_AXI_PCIE_S3 1
add_port_map_axi ARVALID   s_axi_pcie_s3_arvalid   S_AXI_PCIE_S3 1
add_port_map_axi ARREADY   s_axi_pcie_s3_arready   S_AXI_PCIE_S3 1
add_port_map_axi RDATA     s_axi_pcie_s3_rdata     S_AXI_PCIE_S3 1
add_port_map_axi RRESP     s_axi_pcie_s3_rresp     S_AXI_PCIE_S3 1
add_port_map_axi RVALID    s_axi_pcie_s3_rvalid    S_AXI_PCIE_S3 1
add_port_map_axi RREADY    s_axi_pcie_s3_rready    S_AXI_PCIE_S3 1
add_port_map_axi  AWID         m_axi_pcie_s3_awid       M_AXI_PCIE_S3 1    
add_port_map_axi  AWADDR       m_axi_pcie_s3_awaddr     M_AXI_PCIE_S3 1      
add_port_map_axi  AWLEN        m_axi_pcie_s3_awlen      M_AXI_PCIE_S3 1     
add_port_map_axi  AWSIZE       m_axi_pcie_s3_awsize     M_AXI_PCIE_S3 1      
add_port_map_axi  AWBURST      m_axi_pcie_s3_awburst    M_AXI_PCIE_S3 1       
add_port_map_axi  AWLOCK       m_axi_pcie_s3_awlock     M_AXI_PCIE_S3 1      
add_port_map_axi  AWCACHE      m_axi_pcie_s3_awcache    M_AXI_PCIE_S3 1       
add_port_map_axi  AWPROT       m_axi_pcie_s3_awprot     M_AXI_PCIE_S3 1      
add_port_map_axi  AWQOS        m_axi_pcie_s3_awqos      M_AXI_PCIE_S3 1     
add_port_map_axi  AWREGION     m_axi_pcie_s3_awregion   M_AXI_PCIE_S3 1         
add_port_map_axi  AWUSER       m_axi_pcie_s3_awuser     M_AXI_PCIE_S3 1      
add_port_map_axi  AWVALID      m_axi_pcie_s3_awvalid    M_AXI_PCIE_S3 1       
add_port_map_axi  AWREADY      m_axi_pcie_s3_awready    M_AXI_PCIE_S3 1       
add_port_map_axi  WDATA        m_axi_pcie_s3_wdata      M_AXI_PCIE_S3 1     
add_port_map_axi  WSTRB        m_axi_pcie_s3_wstrb      M_AXI_PCIE_S3 1     
add_port_map_axi  WLAST        m_axi_pcie_s3_wlast      M_AXI_PCIE_S3 1     
add_port_map_axi  WUSER        m_axi_pcie_s3_wuser      M_AXI_PCIE_S3 1     
add_port_map_axi  WVALID       m_axi_pcie_s3_wvalid     M_AXI_PCIE_S3 1      
add_port_map_axi  WREADY       m_axi_pcie_s3_wready     M_AXI_PCIE_S3 1      
add_port_map_axi  BID          m_axi_pcie_s3_bid        M_AXI_PCIE_S3 1   
add_port_map_axi  BRESP        m_axi_pcie_s3_bresp      M_AXI_PCIE_S3 1     
add_port_map_axi  BUSER        m_axi_pcie_s3_buser      M_AXI_PCIE_S3 1     
add_port_map_axi  BVALID       m_axi_pcie_s3_bvalid     M_AXI_PCIE_S3 1      
add_port_map_axi  BREADY       m_axi_pcie_s3_bready     M_AXI_PCIE_S3 1      
add_port_map_axi  ARID         m_axi_pcie_s3_arid       M_AXI_PCIE_S3 1    
add_port_map_axi  ARADDR       m_axi_pcie_s3_araddr     M_AXI_PCIE_S3 1      
add_port_map_axi  ARLEN        m_axi_pcie_s3_arlen      M_AXI_PCIE_S3 1     
add_port_map_axi  ARSIZE       m_axi_pcie_s3_arsize     M_AXI_PCIE_S3 1      
add_port_map_axi  ARBURST      m_axi_pcie_s3_arburst    M_AXI_PCIE_S3 1       
add_port_map_axi  ARLOCK       m_axi_pcie_s3_arlock     M_AXI_PCIE_S3 1      
add_port_map_axi  ARCACHE      m_axi_pcie_s3_arcache    M_AXI_PCIE_S3 1       
add_port_map_axi  ARPROT       m_axi_pcie_s3_arprot     M_AXI_PCIE_S3 1      
add_port_map_axi  ARQOS        m_axi_pcie_s3_arqos      M_AXI_PCIE_S3 1     
add_port_map_axi  ARREGION     m_axi_pcie_s3_arregion   M_AXI_PCIE_S3 1        
add_port_map_axi  ARUSER       m_axi_pcie_s3_aruser     M_AXI_PCIE_S3 1      
add_port_map_axi  ARVALID      m_axi_pcie_s3_arvalid    M_AXI_PCIE_S3 1       
add_port_map_axi  ARREADY      m_axi_pcie_s3_arready    M_AXI_PCIE_S3 1       
add_port_map_axi  RID          m_axi_pcie_s3_rid        M_AXI_PCIE_S3 1   
add_port_map_axi  RDATA        m_axi_pcie_s3_rdata      M_AXI_PCIE_S3 1     
add_port_map_axi  RRESP        m_axi_pcie_s3_rresp      M_AXI_PCIE_S3 1     
add_port_map_axi  RLAST        m_axi_pcie_s3_rlast      M_AXI_PCIE_S3 1     
add_port_map_axi  RUSER        m_axi_pcie_s3_ruser      M_AXI_PCIE_S3 1     
add_port_map_axi  RVALID       m_axi_pcie_s3_rvalid     M_AXI_PCIE_S3 1      
add_port_map_axi  RREADY       m_axi_pcie_s3_rready     M_AXI_PCIE_S3 1      


add_port_map_axi AWADDR    s_axi_pcie_s4_awaddr    S_AXI_PCIE_S4 1
add_port_map_axi AWPROT    s_axi_pcie_s4_awprot    S_AXI_PCIE_S4 1
add_port_map_axi AWVALID   s_axi_pcie_s4_awvalid   S_AXI_PCIE_S4 1
add_port_map_axi AWREADY   s_axi_pcie_s4_awready   S_AXI_PCIE_S4 1
add_port_map_axi WDATA     s_axi_pcie_s4_wdata     S_AXI_PCIE_S4 1
add_port_map_axi WSTRB     s_axi_pcie_s4_wstrb     S_AXI_PCIE_S4 1
add_port_map_axi WVALID    s_axi_pcie_s4_wvalid    S_AXI_PCIE_S4 1
add_port_map_axi WREADY    s_axi_pcie_s4_wready    S_AXI_PCIE_S4 1
add_port_map_axi BRESP     s_axi_pcie_s4_bresp     S_AXI_PCIE_S4 1
add_port_map_axi BVALID    s_axi_pcie_s4_bvalid    S_AXI_PCIE_S4 1
add_port_map_axi BREADY    s_axi_pcie_s4_bready    S_AXI_PCIE_S4 1
add_port_map_axi ARADDR    s_axi_pcie_s4_araddr    S_AXI_PCIE_S4 1
add_port_map_axi ARPROT    s_axi_pcie_s4_arprot    S_AXI_PCIE_S4 1
add_port_map_axi ARVALID   s_axi_pcie_s4_arvalid   S_AXI_PCIE_S4 1
add_port_map_axi ARREADY   s_axi_pcie_s4_arready   S_AXI_PCIE_S4 1
add_port_map_axi RDATA     s_axi_pcie_s4_rdata     S_AXI_PCIE_S4 1
add_port_map_axi RRESP     s_axi_pcie_s4_rresp     S_AXI_PCIE_S4 1
add_port_map_axi RVALID    s_axi_pcie_s4_rvalid    S_AXI_PCIE_S4 1
add_port_map_axi RREADY    s_axi_pcie_s4_rready    S_AXI_PCIE_S4 1
add_port_map_axi  AWID         m_axi_pcie_s4_awid       M_AXI_PCIE_S4 1    
add_port_map_axi  AWADDR       m_axi_pcie_s4_awaddr     M_AXI_PCIE_S4 1      
add_port_map_axi  AWLEN        m_axi_pcie_s4_awlen      M_AXI_PCIE_S4 1     
add_port_map_axi  AWSIZE       m_axi_pcie_s4_awsize     M_AXI_PCIE_S4 1      
add_port_map_axi  AWBURST      m_axi_pcie_s4_awburst    M_AXI_PCIE_S4 1       
add_port_map_axi  AWLOCK       m_axi_pcie_s4_awlock     M_AXI_PCIE_S4 1      
add_port_map_axi  AWCACHE      m_axi_pcie_s4_awcache    M_AXI_PCIE_S4 1       
add_port_map_axi  AWPROT       m_axi_pcie_s4_awprot     M_AXI_PCIE_S4 1      
add_port_map_axi  AWQOS        m_axi_pcie_s4_awqos      M_AXI_PCIE_S4 1     
add_port_map_axi  AWREGION     m_axi_pcie_s4_awregion   M_AXI_PCIE_S4 1         
add_port_map_axi  AWUSER       m_axi_pcie_s4_awuser     M_AXI_PCIE_S4 1      
add_port_map_axi  AWVALID      m_axi_pcie_s4_awvalid    M_AXI_PCIE_S4 1       
add_port_map_axi  AWREADY      m_axi_pcie_s4_awready    M_AXI_PCIE_S4 1       
add_port_map_axi  WDATA        m_axi_pcie_s4_wdata      M_AXI_PCIE_S4 1     
add_port_map_axi  WSTRB        m_axi_pcie_s4_wstrb      M_AXI_PCIE_S4 1     
add_port_map_axi  WLAST        m_axi_pcie_s4_wlast      M_AXI_PCIE_S4 1     
add_port_map_axi  WUSER        m_axi_pcie_s4_wuser      M_AXI_PCIE_S4 1     
add_port_map_axi  WVALID       m_axi_pcie_s4_wvalid     M_AXI_PCIE_S4 1      
add_port_map_axi  WREADY       m_axi_pcie_s4_wready     M_AXI_PCIE_S4 1      
add_port_map_axi  BID          m_axi_pcie_s4_bid        M_AXI_PCIE_S4 1   
add_port_map_axi  BRESP        m_axi_pcie_s4_bresp      M_AXI_PCIE_S4 1     
add_port_map_axi  BUSER        m_axi_pcie_s4_buser      M_AXI_PCIE_S4 1     
add_port_map_axi  BVALID       m_axi_pcie_s4_bvalid     M_AXI_PCIE_S4 1      
add_port_map_axi  BREADY       m_axi_pcie_s4_bready     M_AXI_PCIE_S4 1      
add_port_map_axi  ARID         m_axi_pcie_s4_arid       M_AXI_PCIE_S4 1    
add_port_map_axi  ARADDR       m_axi_pcie_s4_araddr     M_AXI_PCIE_S4 1      
add_port_map_axi  ARLEN        m_axi_pcie_s4_arlen      M_AXI_PCIE_S4 1     
add_port_map_axi  ARSIZE       m_axi_pcie_s4_arsize     M_AXI_PCIE_S4 1      
add_port_map_axi  ARBURST      m_axi_pcie_s4_arburst    M_AXI_PCIE_S4 1       
add_port_map_axi  ARLOCK       m_axi_pcie_s4_arlock     M_AXI_PCIE_S4 1      
add_port_map_axi  ARCACHE      m_axi_pcie_s4_arcache    M_AXI_PCIE_S4 1       
add_port_map_axi  ARPROT       m_axi_pcie_s4_arprot     M_AXI_PCIE_S4 1      
add_port_map_axi  ARQOS        m_axi_pcie_s4_arqos      M_AXI_PCIE_S4 1     
add_port_map_axi  ARREGION     m_axi_pcie_s4_arregion   M_AXI_PCIE_S4 1        
add_port_map_axi  ARUSER       m_axi_pcie_s4_aruser     M_AXI_PCIE_S4 1      
add_port_map_axi  ARVALID      m_axi_pcie_s4_arvalid    M_AXI_PCIE_S4 1       
add_port_map_axi  ARREADY      m_axi_pcie_s4_arready    M_AXI_PCIE_S4 1       
add_port_map_axi  RID          m_axi_pcie_s4_rid        M_AXI_PCIE_S4 1   
add_port_map_axi  RDATA        m_axi_pcie_s4_rdata      M_AXI_PCIE_S4 1     
add_port_map_axi  RRESP        m_axi_pcie_s4_rresp      M_AXI_PCIE_S4 1     
add_port_map_axi  RLAST        m_axi_pcie_s4_rlast      M_AXI_PCIE_S4 1     
add_port_map_axi  RUSER        m_axi_pcie_s4_ruser      M_AXI_PCIE_S4 1     
add_port_map_axi  RVALID       m_axi_pcie_s4_rvalid     M_AXI_PCIE_S4 1      
add_port_map_axi  RREADY       m_axi_pcie_s4_rready     M_AXI_PCIE_S4 1      

add_port_map_axi AWADDR    s_axi_pcie_s5_awaddr    S_AXI_PCIE_S5 1
add_port_map_axi AWPROT    s_axi_pcie_s5_awprot    S_AXI_PCIE_S5 1
add_port_map_axi AWVALID   s_axi_pcie_s5_awvalid   S_AXI_PCIE_S5 1
add_port_map_axi AWREADY   s_axi_pcie_s5_awready   S_AXI_PCIE_S5 1
add_port_map_axi WDATA     s_axi_pcie_s5_wdata     S_AXI_PCIE_S5 1
add_port_map_axi WSTRB     s_axi_pcie_s5_wstrb     S_AXI_PCIE_S5 1
add_port_map_axi WVALID    s_axi_pcie_s5_wvalid    S_AXI_PCIE_S5 1
add_port_map_axi WREADY    s_axi_pcie_s5_wready    S_AXI_PCIE_S5 1
add_port_map_axi BRESP     s_axi_pcie_s5_bresp     S_AXI_PCIE_S5 1
add_port_map_axi BVALID    s_axi_pcie_s5_bvalid    S_AXI_PCIE_S5 1
add_port_map_axi BREADY    s_axi_pcie_s5_bready    S_AXI_PCIE_S5 1
add_port_map_axi ARADDR    s_axi_pcie_s5_araddr    S_AXI_PCIE_S5 1
add_port_map_axi ARPROT    s_axi_pcie_s5_arprot    S_AXI_PCIE_S5 1
add_port_map_axi ARVALID   s_axi_pcie_s5_arvalid   S_AXI_PCIE_S5 1
add_port_map_axi ARREADY   s_axi_pcie_s5_arready   S_AXI_PCIE_S5 1
add_port_map_axi RDATA     s_axi_pcie_s5_rdata     S_AXI_PCIE_S5 1
add_port_map_axi RRESP     s_axi_pcie_s5_rresp     S_AXI_PCIE_S5 1
add_port_map_axi RVALID    s_axi_pcie_s5_rvalid    S_AXI_PCIE_S5 1
add_port_map_axi RREADY    s_axi_pcie_s5_rready    S_AXI_PCIE_S5 1
add_port_map_axi  AWID         m_axi_pcie_s5_awid       M_AXI_PCIE_S5 1    
add_port_map_axi  AWADDR       m_axi_pcie_s5_awaddr     M_AXI_PCIE_S5 1      
add_port_map_axi  AWLEN        m_axi_pcie_s5_awlen      M_AXI_PCIE_S5 1     
add_port_map_axi  AWSIZE       m_axi_pcie_s5_awsize     M_AXI_PCIE_S5 1      
add_port_map_axi  AWBURST      m_axi_pcie_s5_awburst    M_AXI_PCIE_S5 1       
add_port_map_axi  AWLOCK       m_axi_pcie_s5_awlock     M_AXI_PCIE_S5 1      
add_port_map_axi  AWCACHE      m_axi_pcie_s5_awcache    M_AXI_PCIE_S5 1       
add_port_map_axi  AWPROT       m_axi_pcie_s5_awprot     M_AXI_PCIE_S5 1      
add_port_map_axi  AWQOS        m_axi_pcie_s5_awqos      M_AXI_PCIE_S5 1     
add_port_map_axi  AWREGION     m_axi_pcie_s5_awregion   M_AXI_PCIE_S5 1         
add_port_map_axi  AWUSER       m_axi_pcie_s5_awuser     M_AXI_PCIE_S5 1      
add_port_map_axi  AWVALID      m_axi_pcie_s5_awvalid    M_AXI_PCIE_S5 1       
add_port_map_axi  AWREADY      m_axi_pcie_s5_awready    M_AXI_PCIE_S5 1       
add_port_map_axi  WDATA        m_axi_pcie_s5_wdata      M_AXI_PCIE_S5 1     
add_port_map_axi  WSTRB        m_axi_pcie_s5_wstrb      M_AXI_PCIE_S5 1     
add_port_map_axi  WLAST        m_axi_pcie_s5_wlast      M_AXI_PCIE_S5 1     
add_port_map_axi  WUSER        m_axi_pcie_s5_wuser      M_AXI_PCIE_S5 1     
add_port_map_axi  WVALID       m_axi_pcie_s5_wvalid     M_AXI_PCIE_S5 1      
add_port_map_axi  WREADY       m_axi_pcie_s5_wready     M_AXI_PCIE_S5 1      
add_port_map_axi  BID          m_axi_pcie_s5_bid        M_AXI_PCIE_S5 1   
add_port_map_axi  BRESP        m_axi_pcie_s5_bresp      M_AXI_PCIE_S5 1     
add_port_map_axi  BUSER        m_axi_pcie_s5_buser      M_AXI_PCIE_S5 1     
add_port_map_axi  BVALID       m_axi_pcie_s5_bvalid     M_AXI_PCIE_S5 1      
add_port_map_axi  BREADY       m_axi_pcie_s5_bready     M_AXI_PCIE_S5 1      
add_port_map_axi  ARID         m_axi_pcie_s5_arid       M_AXI_PCIE_S5 1    
add_port_map_axi  ARADDR       m_axi_pcie_s5_araddr     M_AXI_PCIE_S5 1      
add_port_map_axi  ARLEN        m_axi_pcie_s5_arlen      M_AXI_PCIE_S5 1     
add_port_map_axi  ARSIZE       m_axi_pcie_s5_arsize     M_AXI_PCIE_S5 1      
add_port_map_axi  ARBURST      m_axi_pcie_s5_arburst    M_AXI_PCIE_S5 1       
add_port_map_axi  ARLOCK       m_axi_pcie_s5_arlock     M_AXI_PCIE_S5 1      
add_port_map_axi  ARCACHE      m_axi_pcie_s5_arcache    M_AXI_PCIE_S5 1       
add_port_map_axi  ARPROT       m_axi_pcie_s5_arprot     M_AXI_PCIE_S5 1      
add_port_map_axi  ARQOS        m_axi_pcie_s5_arqos      M_AXI_PCIE_S5 1     
add_port_map_axi  ARREGION     m_axi_pcie_s5_arregion   M_AXI_PCIE_S5 1        
add_port_map_axi  ARUSER       m_axi_pcie_s5_aruser     M_AXI_PCIE_S5 1      
add_port_map_axi  ARVALID      m_axi_pcie_s5_arvalid    M_AXI_PCIE_S5 1       
add_port_map_axi  ARREADY      m_axi_pcie_s5_arready    M_AXI_PCIE_S5 1       
add_port_map_axi  RID          m_axi_pcie_s5_rid        M_AXI_PCIE_S5 1   
add_port_map_axi  RDATA        m_axi_pcie_s5_rdata      M_AXI_PCIE_S5 1     
add_port_map_axi  RRESP        m_axi_pcie_s5_rresp      M_AXI_PCIE_S5 1     
add_port_map_axi  RLAST        m_axi_pcie_s5_rlast      M_AXI_PCIE_S5 1     
add_port_map_axi  RUSER        m_axi_pcie_s5_ruser      M_AXI_PCIE_S5 1     
add_port_map_axi  RVALID       m_axi_pcie_s5_rvalid     M_AXI_PCIE_S5 1      
add_port_map_axi  RREADY       m_axi_pcie_s5_rready     M_AXI_PCIE_S5 1      

add_port_map_axi  AWID         m_axi_usr_0_awid            M_AXI4_USR_0     AXI4  
add_port_map_axi  AWADDR       m_axi_usr_0_awaddr          M_AXI4_USR_0     1    
add_port_map_axi  AWLEN        m_axi_usr_0_awlen      M_AXI4_USR_0     AXI4   
add_port_map_axi  AWSIZE       m_axi_usr_0_awsize          M_AXI4_USR_0     AXI4    
add_port_map_axi  AWBURST      m_axi_usr_0_awburst         M_AXI4_USR_0     AXI4     
add_port_map_axi  AWLOCK       m_axi_usr_0_awlock     M_AXI4_USR_0     AXI4    
add_port_map_axi  AWCACHE      m_axi_usr_0_awcache         M_AXI4_USR_0     AXI4     
add_port_map_axi  AWPROT       m_axi_usr_0_awprot          M_AXI4_USR_0     1    
add_port_map_axi  AWQOS        m_axi_usr_0_awqos           M_AXI4_USR_0     AXI4   
add_port_map_axi  AWREGION     m_axi_usr_0_awregion        M_AXI4_USR_0     AXI4      
add_port_map_axi  AWUSER       m_axi_usr_0_awuser          M_AXI4_USR_0     AXI4    
add_port_map_axi  AWVALID      m_axi_usr_0_awvalid         M_AXI4_USR_0     1     
add_port_map_axi  AWREADY      m_axi_usr_0_awready         M_AXI4_USR_0     1     
add_port_map_axi  WDATA        m_axi_usr_0_wdata           M_AXI4_USR_0     1   
add_port_map_axi  WSTRB        m_axi_usr_0_wstrb           M_AXI4_USR_0     1  
add_port_map_axi  WID          m_axi_usr_0_wid             M_AXI4_USR_0     AXI3   
add_port_map_axi  WLAST        m_axi_usr_0_wlast           M_AXI4_USR_0     AXI4   
add_port_map_axi  WUSER        m_axi_usr_0_wuser           M_AXI4_USR_0     AXI4   
add_port_map_axi  WVALID       m_axi_usr_0_wvalid          M_AXI4_USR_0     1    
add_port_map_axi  WREADY       m_axi_usr_0_wready          M_AXI4_USR_0     1    
add_port_map_axi  BID          m_axi_usr_0_bid             M_AXI4_USR_0     AXI4 
add_port_map_axi  BRESP        m_axi_usr_0_bresp           M_AXI4_USR_0     1   
add_port_map_axi  BUSER        m_axi_usr_0_buser           M_AXI4_USR_0     AXI4   
add_port_map_axi  BVALID       m_axi_usr_0_bvalid          M_AXI4_USR_0     1    
add_port_map_axi  BREADY       m_axi_usr_0_bready          M_AXI4_USR_0     1    
add_port_map_axi  ARID         m_axi_usr_0_arid            M_AXI4_USR_0     AXI4  
add_port_map_axi  ARADDR       m_axi_usr_0_araddr          M_AXI4_USR_0     1    
add_port_map_axi  ARLEN        m_axi_usr_0_arlen      M_AXI4_USR_0     AXI4   
add_port_map_axi  ARSIZE       m_axi_usr_0_arsize          M_AXI4_USR_0     AXI4    
add_port_map_axi  ARBURST      m_axi_usr_0_arburst         M_AXI4_USR_0     AXI4     
add_port_map_axi  ARLOCK       m_axi_usr_0_arlock     M_AXI4_USR_0     AXI4    
add_port_map_axi  ARCACHE      m_axi_usr_0_arcache         M_AXI4_USR_0     AXI4     
add_port_map_axi  ARPROT       m_axi_usr_0_arprot          M_AXI4_USR_0     1    
add_port_map_axi  ARQOS        m_axi_usr_0_arqos           M_AXI4_USR_0     AXI4   
add_port_map_axi  ARREGION     m_axi_usr_0_arregion        M_AXI4_USR_0     AXI4      
add_port_map_axi  ARUSER       m_axi_usr_0_aruser          M_AXI4_USR_0     AXI4    
add_port_map_axi  ARVALID      m_axi_usr_0_arvalid         M_AXI4_USR_0     1     
add_port_map_axi  ARREADY      m_axi_usr_0_arready         M_AXI4_USR_0     1     
add_port_map_axi  RID          m_axi_usr_0_rid             M_AXI4_USR_0     AXI4 
add_port_map_axi  RDATA        m_axi_usr_0_rdata           M_AXI4_USR_0     1   
add_port_map_axi  RRESP        m_axi_usr_0_rresp           M_AXI4_USR_0     1   
add_port_map_axi  RLAST        m_axi_usr_0_rlast           M_AXI4_USR_0     AXI4   
add_port_map_axi  RUSER        m_axi_usr_0_ruser           M_AXI4_USR_0     AXI4   
add_port_map_axi  RVALID       m_axi_usr_0_rvalid          M_AXI4_USR_0     1    
add_port_map_axi  RREADY       m_axi_usr_0_rready          M_AXI4_USR_0     1    

add_port_map_axi  AWID         m_axi_usr_0_awid            M_AXI4LITE_USR_0 AXI4  
add_port_map_axi  AWADDR       m_axi_usr_0_awaddr          M_AXI4LITE_USR_0 1    
add_port_map_axi  AWLEN        m_axi_usr_0_awlen      M_AXI4LITE_USR_0 AXI4   
add_port_map_axi  AWSIZE       m_axi_usr_0_awsize          M_AXI4LITE_USR_0 AXI4    
add_port_map_axi  AWBURST      m_axi_usr_0_awburst         M_AXI4LITE_USR_0 AXI4     
add_port_map_axi  AWLOCK       m_axi_usr_0_awlock     M_AXI4LITE_USR_0 AXI4    
add_port_map_axi  AWCACHE      m_axi_usr_0_awcache         M_AXI4LITE_USR_0 AXI4     
add_port_map_axi  AWPROT       m_axi_usr_0_awprot          M_AXI4LITE_USR_0 1    
add_port_map_axi  AWQOS        m_axi_usr_0_awqos           M_AXI4LITE_USR_0 AXI4   
add_port_map_axi  AWREGION     m_axi_usr_0_awregion        M_AXI4LITE_USR_0 AXI4      
add_port_map_axi  AWUSER       m_axi_usr_0_awuser          M_AXI4LITE_USR_0 AXI4    
add_port_map_axi  AWVALID      m_axi_usr_0_awvalid         M_AXI4LITE_USR_0 1     
add_port_map_axi  AWREADY      m_axi_usr_0_awready         M_AXI4LITE_USR_0 1     
add_port_map_axi  WDATA        m_axi_usr_0_wdata           M_AXI4LITE_USR_0 1   
add_port_map_axi  WSTRB        m_axi_usr_0_wstrb           M_AXI4LITE_USR_0 1  
add_port_map_axi  WID          m_axi_usr_0_wid             M_AXI4LITE_USR_0 AXI3   
add_port_map_axi  WLAST        m_axi_usr_0_wlast           M_AXI4LITE_USR_0 AXI4   
add_port_map_axi  WUSER        m_axi_usr_0_wuser           M_AXI4LITE_USR_0 AXI4   
add_port_map_axi  WVALID       m_axi_usr_0_wvalid          M_AXI4LITE_USR_0 1    
add_port_map_axi  WREADY       m_axi_usr_0_wready          M_AXI4LITE_USR_0 1    
add_port_map_axi  BID          m_axi_usr_0_bid             M_AXI4LITE_USR_0 AXI4 
add_port_map_axi  BRESP        m_axi_usr_0_bresp           M_AXI4LITE_USR_0 1   
add_port_map_axi  BUSER        m_axi_usr_0_buser           M_AXI4LITE_USR_0 AXI4   
add_port_map_axi  BVALID       m_axi_usr_0_bvalid          M_AXI4LITE_USR_0 1    
add_port_map_axi  BREADY       m_axi_usr_0_bready          M_AXI4LITE_USR_0 1    
add_port_map_axi  ARID         m_axi_usr_0_arid            M_AXI4LITE_USR_0 AXI4  
add_port_map_axi  ARADDR       m_axi_usr_0_araddr          M_AXI4LITE_USR_0 1    
add_port_map_axi  ARLEN        m_axi_usr_0_arlen      M_AXI4LITE_USR_0 AXI4   
add_port_map_axi  ARSIZE       m_axi_usr_0_arsize          M_AXI4LITE_USR_0 AXI4    
add_port_map_axi  ARBURST      m_axi_usr_0_arburst         M_AXI4LITE_USR_0 AXI4     
add_port_map_axi  ARLOCK       m_axi_usr_0_arlock     M_AXI4LITE_USR_0 AXI4    
add_port_map_axi  ARCACHE      m_axi_usr_0_arcache         M_AXI4LITE_USR_0 AXI4     
add_port_map_axi  ARPROT       m_axi_usr_0_arprot          M_AXI4LITE_USR_0 1    
add_port_map_axi  ARQOS        m_axi_usr_0_arqos           M_AXI4LITE_USR_0 AXI4   
add_port_map_axi  ARREGION     m_axi_usr_0_arregion        M_AXI4LITE_USR_0 AXI4      
add_port_map_axi  ARUSER       m_axi_usr_0_aruser          M_AXI4LITE_USR_0 AXI4    
add_port_map_axi  ARVALID      m_axi_usr_0_arvalid         M_AXI4LITE_USR_0 1     
add_port_map_axi  ARREADY      m_axi_usr_0_arready         M_AXI4LITE_USR_0 1     
add_port_map_axi  RID          m_axi_usr_0_rid             M_AXI4LITE_USR_0 AXI4 
add_port_map_axi  RDATA        m_axi_usr_0_rdata           M_AXI4LITE_USR_0 1   
add_port_map_axi  RRESP        m_axi_usr_0_rresp           M_AXI4LITE_USR_0 1   
add_port_map_axi  RLAST        m_axi_usr_0_rlast           M_AXI4LITE_USR_0 AXI4   
add_port_map_axi  RUSER        m_axi_usr_0_ruser           M_AXI4LITE_USR_0 AXI4   
add_port_map_axi  RVALID       m_axi_usr_0_rvalid          M_AXI4LITE_USR_0 1    
add_port_map_axi  RREADY       m_axi_usr_0_rready          M_AXI4LITE_USR_0 1    

add_port_map_axi  AWID         m_axi_usr_0_awid            M_AXI3_USR_0     AXI4  
add_port_map_axi  AWADDR       m_axi_usr_0_awaddr          M_AXI3_USR_0     1    
add_port_map_axi  AWLEN        m_axi_usr_0_awlen      M_AXI3_USR_0     AXI4   
add_port_map_axi  AWSIZE       m_axi_usr_0_awsize          M_AXI3_USR_0     AXI4    
add_port_map_axi  AWBURST      m_axi_usr_0_awburst         M_AXI3_USR_0     AXI4     
add_port_map_axi  AWLOCK       m_axi_usr_0_awlock     M_AXI3_USR_0     AXI4    
add_port_map_axi  AWCACHE      m_axi_usr_0_awcache         M_AXI3_USR_0     AXI4     
add_port_map_axi  AWPROT       m_axi_usr_0_awprot          M_AXI3_USR_0     1    
add_port_map_axi  AWQOS        m_axi_usr_0_awqos           M_AXI3_USR_0     AXI4   
add_port_map_axi  AWREGION     m_axi_usr_0_awregion        M_AXI3_USR_0     AXI4      
add_port_map_axi  AWUSER       m_axi_usr_0_awuser          M_AXI3_USR_0     AXI4    
add_port_map_axi  AWVALID      m_axi_usr_0_awvalid         M_AXI3_USR_0     1     
add_port_map_axi  AWREADY      m_axi_usr_0_awready         M_AXI3_USR_0     1     
add_port_map_axi  WDATA        m_axi_usr_0_wdata           M_AXI3_USR_0     1   
add_port_map_axi  WSTRB        m_axi_usr_0_wstrb           M_AXI3_USR_0     1  
add_port_map_axi  WID          m_axi_usr_0_wid             M_AXI3_USR_0     AXI3   
add_port_map_axi  WLAST        m_axi_usr_0_wlast           M_AXI3_USR_0     AXI4   
add_port_map_axi  WUSER        m_axi_usr_0_wuser           M_AXI3_USR_0     AXI4   
add_port_map_axi  WVALID       m_axi_usr_0_wvalid          M_AXI3_USR_0     1    
add_port_map_axi  WREADY       m_axi_usr_0_wready          M_AXI3_USR_0     1    
add_port_map_axi  BID          m_axi_usr_0_bid             M_AXI3_USR_0     AXI4 
add_port_map_axi  BRESP        m_axi_usr_0_bresp           M_AXI3_USR_0     1   
add_port_map_axi  BUSER        m_axi_usr_0_buser           M_AXI3_USR_0     AXI4   
add_port_map_axi  BVALID       m_axi_usr_0_bvalid          M_AXI3_USR_0     1    
add_port_map_axi  BREADY       m_axi_usr_0_bready          M_AXI3_USR_0     1    
add_port_map_axi  ARID         m_axi_usr_0_arid            M_AXI3_USR_0     AXI4  
add_port_map_axi  ARADDR       m_axi_usr_0_araddr          M_AXI3_USR_0     1    
add_port_map_axi  ARLEN        m_axi_usr_0_arlen      M_AXI3_USR_0     AXI4   
add_port_map_axi  ARSIZE       m_axi_usr_0_arsize          M_AXI3_USR_0     AXI4    
add_port_map_axi  ARBURST      m_axi_usr_0_arburst         M_AXI3_USR_0     AXI4     
add_port_map_axi  ARLOCK       m_axi_usr_0_arlock     M_AXI3_USR_0     AXI4    
add_port_map_axi  ARCACHE      m_axi_usr_0_arcache         M_AXI3_USR_0     AXI4     
add_port_map_axi  ARPROT       m_axi_usr_0_arprot          M_AXI3_USR_0     1    
add_port_map_axi  ARQOS        m_axi_usr_0_arqos           M_AXI3_USR_0     AXI4   
add_port_map_axi  ARREGION     m_axi_usr_0_arregion        M_AXI3_USR_0     AXI4      
add_port_map_axi  ARUSER       m_axi_usr_0_aruser          M_AXI3_USR_0     AXI4    
add_port_map_axi  ARVALID      m_axi_usr_0_arvalid         M_AXI3_USR_0     1     
add_port_map_axi  ARREADY      m_axi_usr_0_arready         M_AXI3_USR_0     1     
add_port_map_axi  RID          m_axi_usr_0_rid             M_AXI3_USR_0     AXI4 
add_port_map_axi  RDATA        m_axi_usr_0_rdata           M_AXI3_USR_0     1   
add_port_map_axi  RRESP        m_axi_usr_0_rresp           M_AXI3_USR_0     1   
add_port_map_axi  RLAST        m_axi_usr_0_rlast           M_AXI3_USR_0     AXI4   
add_port_map_axi  RUSER        m_axi_usr_0_ruser           M_AXI3_USR_0     AXI4   
add_port_map_axi  RVALID       m_axi_usr_0_rvalid          M_AXI3_USR_0     1    
add_port_map_axi  RREADY       m_axi_usr_0_rready          M_AXI3_USR_0     1    

add_port_map_axi  AWID         m_axi_usr_1_awid            M_AXI4_USR_1     AXI4  
add_port_map_axi  AWADDR       m_axi_usr_1_awaddr          M_AXI4_USR_1     1    
add_port_map_axi  AWLEN        m_axi_usr_1_awlen      M_AXI4_USR_1     AXI4   
add_port_map_axi  AWSIZE       m_axi_usr_1_awsize          M_AXI4_USR_1     AXI4    
add_port_map_axi  AWBURST      m_axi_usr_1_awburst         M_AXI4_USR_1     AXI4     
add_port_map_axi  AWLOCK       m_axi_usr_1_awlock     M_AXI4_USR_1     AXI4    
add_port_map_axi  AWCACHE      m_axi_usr_1_awcache         M_AXI4_USR_1     AXI4     
add_port_map_axi  AWPROT       m_axi_usr_1_awprot          M_AXI4_USR_1     1    
add_port_map_axi  AWQOS        m_axi_usr_1_awqos           M_AXI4_USR_1     AXI4   
add_port_map_axi  AWREGION     m_axi_usr_1_awregion        M_AXI4_USR_1     AXI4      
add_port_map_axi  AWUSER       m_axi_usr_1_awuser          M_AXI4_USR_1     AXI4    
add_port_map_axi  AWVALID      m_axi_usr_1_awvalid         M_AXI4_USR_1     1     
add_port_map_axi  AWREADY      m_axi_usr_1_awready         M_AXI4_USR_1     1     
add_port_map_axi  WDATA        m_axi_usr_1_wdata           M_AXI4_USR_1     1   
add_port_map_axi  WSTRB        m_axi_usr_1_wstrb           M_AXI4_USR_1     1  
add_port_map_axi  WID          m_axi_usr_1_wid             M_AXI4_USR_1     AXI3   
add_port_map_axi  WLAST        m_axi_usr_1_wlast           M_AXI4_USR_1     AXI4   
add_port_map_axi  WUSER        m_axi_usr_1_wuser           M_AXI4_USR_1     AXI4   
add_port_map_axi  WVALID       m_axi_usr_1_wvalid          M_AXI4_USR_1     1    
add_port_map_axi  WREADY       m_axi_usr_1_wready          M_AXI4_USR_1     1    
add_port_map_axi  BID          m_axi_usr_1_bid             M_AXI4_USR_1     AXI4 
add_port_map_axi  BRESP        m_axi_usr_1_bresp           M_AXI4_USR_1     1   
add_port_map_axi  BUSER        m_axi_usr_1_buser           M_AXI4_USR_1     AXI4   
add_port_map_axi  BVALID       m_axi_usr_1_bvalid          M_AXI4_USR_1     1    
add_port_map_axi  BREADY       m_axi_usr_1_bready          M_AXI4_USR_1     1    
add_port_map_axi  ARID         m_axi_usr_1_arid            M_AXI4_USR_1     AXI4  
add_port_map_axi  ARADDR       m_axi_usr_1_araddr          M_AXI4_USR_1     1    
add_port_map_axi  ARLEN        m_axi_usr_1_arlen      M_AXI4_USR_1     AXI4   
add_port_map_axi  ARSIZE       m_axi_usr_1_arsize          M_AXI4_USR_1     AXI4    
add_port_map_axi  ARBURST      m_axi_usr_1_arburst         M_AXI4_USR_1     AXI4     
add_port_map_axi  ARLOCK       m_axi_usr_1_arlock     M_AXI4_USR_1     AXI4    
add_port_map_axi  ARCACHE      m_axi_usr_1_arcache         M_AXI4_USR_1     AXI4     
add_port_map_axi  ARPROT       m_axi_usr_1_arprot          M_AXI4_USR_1     1    
add_port_map_axi  ARQOS        m_axi_usr_1_arqos           M_AXI4_USR_1     AXI4   
add_port_map_axi  ARREGION     m_axi_usr_1_arregion        M_AXI4_USR_1     AXI4      
add_port_map_axi  ARUSER       m_axi_usr_1_aruser          M_AXI4_USR_1     AXI4    
add_port_map_axi  ARVALID      m_axi_usr_1_arvalid         M_AXI4_USR_1     1     
add_port_map_axi  ARREADY      m_axi_usr_1_arready         M_AXI4_USR_1     1     
add_port_map_axi  RID          m_axi_usr_1_rid             M_AXI4_USR_1     AXI4 
add_port_map_axi  RDATA        m_axi_usr_1_rdata           M_AXI4_USR_1     1   
add_port_map_axi  RRESP        m_axi_usr_1_rresp           M_AXI4_USR_1     1   
add_port_map_axi  RLAST        m_axi_usr_1_rlast           M_AXI4_USR_1     AXI4   
add_port_map_axi  RUSER        m_axi_usr_1_ruser           M_AXI4_USR_1     AXI4   
add_port_map_axi  RVALID       m_axi_usr_1_rvalid          M_AXI4_USR_1     1    
add_port_map_axi  RREADY       m_axi_usr_1_rready          M_AXI4_USR_1     1    

add_port_map_axi  AWID         m_axi_usr_1_awid            M_AXI4LITE_USR_1 AXI4  
add_port_map_axi  AWADDR       m_axi_usr_1_awaddr          M_AXI4LITE_USR_1 1    
add_port_map_axi  AWLEN        m_axi_usr_1_awlen      M_AXI4LITE_USR_1 AXI4   
add_port_map_axi  AWSIZE       m_axi_usr_1_awsize          M_AXI4LITE_USR_1 AXI4    
add_port_map_axi  AWBURST      m_axi_usr_1_awburst         M_AXI4LITE_USR_1 AXI4     
add_port_map_axi  AWLOCK       m_axi_usr_1_awlock     M_AXI4LITE_USR_1 AXI4    
add_port_map_axi  AWCACHE      m_axi_usr_1_awcache         M_AXI4LITE_USR_1 AXI4     
add_port_map_axi  AWPROT       m_axi_usr_1_awprot          M_AXI4LITE_USR_1 1    
add_port_map_axi  AWQOS        m_axi_usr_1_awqos           M_AXI4LITE_USR_1 AXI4   
add_port_map_axi  AWREGION     m_axi_usr_1_awregion        M_AXI4LITE_USR_1 AXI4      
add_port_map_axi  AWUSER       m_axi_usr_1_awuser          M_AXI4LITE_USR_1 AXI4    
add_port_map_axi  AWVALID      m_axi_usr_1_awvalid         M_AXI4LITE_USR_1 1     
add_port_map_axi  AWREADY      m_axi_usr_1_awready         M_AXI4LITE_USR_1 1     
add_port_map_axi  WDATA        m_axi_usr_1_wdata           M_AXI4LITE_USR_1 1   
add_port_map_axi  WSTRB        m_axi_usr_1_wstrb           M_AXI4LITE_USR_1 1  
add_port_map_axi  WID          m_axi_usr_1_wid             M_AXI4LITE_USR_1 AXI3   
add_port_map_axi  WLAST        m_axi_usr_1_wlast           M_AXI4LITE_USR_1 AXI4   
add_port_map_axi  WUSER        m_axi_usr_1_wuser           M_AXI4LITE_USR_1 AXI4   
add_port_map_axi  WVALID       m_axi_usr_1_wvalid          M_AXI4LITE_USR_1 1    
add_port_map_axi  WREADY       m_axi_usr_1_wready          M_AXI4LITE_USR_1 1    
add_port_map_axi  BID          m_axi_usr_1_bid             M_AXI4LITE_USR_1 AXI4 
add_port_map_axi  BRESP        m_axi_usr_1_bresp           M_AXI4LITE_USR_1 1   
add_port_map_axi  BUSER        m_axi_usr_1_buser           M_AXI4LITE_USR_1 AXI4   
add_port_map_axi  BVALID       m_axi_usr_1_bvalid          M_AXI4LITE_USR_1 1    
add_port_map_axi  BREADY       m_axi_usr_1_bready          M_AXI4LITE_USR_1 1    
add_port_map_axi  ARID         m_axi_usr_1_arid            M_AXI4LITE_USR_1 AXI4  
add_port_map_axi  ARADDR       m_axi_usr_1_araddr          M_AXI4LITE_USR_1 1    
add_port_map_axi  ARLEN        m_axi_usr_1_arlen      M_AXI4LITE_USR_1 AXI4   
add_port_map_axi  ARSIZE       m_axi_usr_1_arsize          M_AXI4LITE_USR_1 AXI4    
add_port_map_axi  ARBURST      m_axi_usr_1_arburst         M_AXI4LITE_USR_1 AXI4     
add_port_map_axi  ARLOCK       m_axi_usr_1_arlock     M_AXI4LITE_USR_1 AXI4    
add_port_map_axi  ARCACHE      m_axi_usr_1_arcache         M_AXI4LITE_USR_1 AXI4     
add_port_map_axi  ARPROT       m_axi_usr_1_arprot          M_AXI4LITE_USR_1 1    
add_port_map_axi  ARQOS        m_axi_usr_1_arqos           M_AXI4LITE_USR_1 AXI4   
add_port_map_axi  ARREGION     m_axi_usr_1_arregion        M_AXI4LITE_USR_1 AXI4      
add_port_map_axi  ARUSER       m_axi_usr_1_aruser          M_AXI4LITE_USR_1 AXI4    
add_port_map_axi  ARVALID      m_axi_usr_1_arvalid         M_AXI4LITE_USR_1 1     
add_port_map_axi  ARREADY      m_axi_usr_1_arready         M_AXI4LITE_USR_1 1     
add_port_map_axi  RID          m_axi_usr_1_rid             M_AXI4LITE_USR_1 AXI4 
add_port_map_axi  RDATA        m_axi_usr_1_rdata           M_AXI4LITE_USR_1 1   
add_port_map_axi  RRESP        m_axi_usr_1_rresp           M_AXI4LITE_USR_1 1   
add_port_map_axi  RLAST        m_axi_usr_1_rlast           M_AXI4LITE_USR_1 AXI4   
add_port_map_axi  RUSER        m_axi_usr_1_ruser           M_AXI4LITE_USR_1 AXI4   
add_port_map_axi  RVALID       m_axi_usr_1_rvalid          M_AXI4LITE_USR_1 1    
add_port_map_axi  RREADY       m_axi_usr_1_rready          M_AXI4LITE_USR_1 1    

add_port_map_axi  AWID         m_axi_usr_1_awid            M_AXI3_USR_1     AXI4  
add_port_map_axi  AWADDR       m_axi_usr_1_awaddr          M_AXI3_USR_1     1    
add_port_map_axi  AWLEN        m_axi_usr_1_awlen      M_AXI3_USR_1     AXI4   
add_port_map_axi  AWSIZE       m_axi_usr_1_awsize          M_AXI3_USR_1     AXI4    
add_port_map_axi  AWBURST      m_axi_usr_1_awburst         M_AXI3_USR_1     AXI4     
add_port_map_axi  AWLOCK       m_axi_usr_1_awlock     M_AXI3_USR_1     AXI4    
add_port_map_axi  AWCACHE      m_axi_usr_1_awcache         M_AXI3_USR_1     AXI4     
add_port_map_axi  AWPROT       m_axi_usr_1_awprot          M_AXI3_USR_1     1    
add_port_map_axi  AWQOS        m_axi_usr_1_awqos           M_AXI3_USR_1     AXI4   
add_port_map_axi  AWREGION     m_axi_usr_1_awregion        M_AXI3_USR_1     AXI4      
add_port_map_axi  AWUSER       m_axi_usr_1_awuser          M_AXI3_USR_1     AXI4    
add_port_map_axi  AWVALID      m_axi_usr_1_awvalid         M_AXI3_USR_1     1     
add_port_map_axi  AWREADY      m_axi_usr_1_awready         M_AXI3_USR_1     1     
add_port_map_axi  WDATA        m_axi_usr_1_wdata           M_AXI3_USR_1     1   
add_port_map_axi  WSTRB        m_axi_usr_1_wstrb           M_AXI3_USR_1     1  
add_port_map_axi  WID          m_axi_usr_1_wid             M_AXI3_USR_1     AXI3   
add_port_map_axi  WLAST        m_axi_usr_1_wlast           M_AXI3_USR_1     AXI4   
add_port_map_axi  WUSER        m_axi_usr_1_wuser           M_AXI3_USR_1     AXI4   
add_port_map_axi  WVALID       m_axi_usr_1_wvalid          M_AXI3_USR_1     1    
add_port_map_axi  WREADY       m_axi_usr_1_wready          M_AXI3_USR_1     1    
add_port_map_axi  BID          m_axi_usr_1_bid             M_AXI3_USR_1     AXI4 
add_port_map_axi  BRESP        m_axi_usr_1_bresp           M_AXI3_USR_1     1   
add_port_map_axi  BUSER        m_axi_usr_1_buser           M_AXI3_USR_1     AXI4   
add_port_map_axi  BVALID       m_axi_usr_1_bvalid          M_AXI3_USR_1     1    
add_port_map_axi  BREADY       m_axi_usr_1_bready          M_AXI3_USR_1     1    
add_port_map_axi  ARID         m_axi_usr_1_arid            M_AXI3_USR_1     AXI4  
add_port_map_axi  ARADDR       m_axi_usr_1_araddr          M_AXI3_USR_1     1    
add_port_map_axi  ARLEN        m_axi_usr_1_arlen      M_AXI3_USR_1     AXI4   
add_port_map_axi  ARSIZE       m_axi_usr_1_arsize          M_AXI3_USR_1     AXI4    
add_port_map_axi  ARBURST      m_axi_usr_1_arburst         M_AXI3_USR_1     AXI4     
add_port_map_axi  ARLOCK       m_axi_usr_1_arlock     M_AXI3_USR_1     AXI4    
add_port_map_axi  ARCACHE      m_axi_usr_1_arcache         M_AXI3_USR_1     AXI4     
add_port_map_axi  ARPROT       m_axi_usr_1_arprot          M_AXI3_USR_1     1    
add_port_map_axi  ARQOS        m_axi_usr_1_arqos           M_AXI3_USR_1     AXI4   
add_port_map_axi  ARREGION     m_axi_usr_1_arregion        M_AXI3_USR_1     AXI4      
add_port_map_axi  ARUSER       m_axi_usr_1_aruser          M_AXI3_USR_1     AXI4    
add_port_map_axi  ARVALID      m_axi_usr_1_arvalid         M_AXI3_USR_1     1     
add_port_map_axi  ARREADY      m_axi_usr_1_arready         M_AXI3_USR_1     1     
add_port_map_axi  RID          m_axi_usr_1_rid             M_AXI3_USR_1     AXI4 
add_port_map_axi  RDATA        m_axi_usr_1_rdata           M_AXI3_USR_1     1   
add_port_map_axi  RRESP        m_axi_usr_1_rresp           M_AXI3_USR_1     1   
add_port_map_axi  RLAST        m_axi_usr_1_rlast           M_AXI3_USR_1     AXI4   
add_port_map_axi  RUSER        m_axi_usr_1_ruser           M_AXI3_USR_1     AXI4   
add_port_map_axi  RVALID       m_axi_usr_1_rvalid          M_AXI3_USR_1     1    
add_port_map_axi  RREADY       m_axi_usr_1_rready          M_AXI3_USR_1     1    


add_port_map_axi  AWID         m_axi_usr_2_awid            M_AXI4_USR_2     AXI4  
add_port_map_axi  AWADDR       m_axi_usr_2_awaddr          M_AXI4_USR_2     1    
add_port_map_axi  AWLEN        m_axi_usr_2_awlen      M_AXI4_USR_2     AXI4   
add_port_map_axi  AWSIZE       m_axi_usr_2_awsize          M_AXI4_USR_2     AXI4    
add_port_map_axi  AWBURST      m_axi_usr_2_awburst         M_AXI4_USR_2     AXI4     
add_port_map_axi  AWLOCK       m_axi_usr_2_awlock     M_AXI4_USR_2     AXI4    
add_port_map_axi  AWCACHE      m_axi_usr_2_awcache         M_AXI4_USR_2     AXI4     
add_port_map_axi  AWPROT       m_axi_usr_2_awprot          M_AXI4_USR_2     1    
add_port_map_axi  AWQOS        m_axi_usr_2_awqos           M_AXI4_USR_2     AXI4   
add_port_map_axi  AWREGION     m_axi_usr_2_awregion        M_AXI4_USR_2     AXI4      
add_port_map_axi  AWUSER       m_axi_usr_2_awuser          M_AXI4_USR_2     AXI4    
add_port_map_axi  AWVALID      m_axi_usr_2_awvalid         M_AXI4_USR_2     1     
add_port_map_axi  AWREADY      m_axi_usr_2_awready         M_AXI4_USR_2     1     
add_port_map_axi  WDATA        m_axi_usr_2_wdata           M_AXI4_USR_2     1   
add_port_map_axi  WSTRB        m_axi_usr_2_wstrb           M_AXI4_USR_2     1  
add_port_map_axi  WID          m_axi_usr_2_wid             M_AXI4_USR_2     AXI3   
add_port_map_axi  WLAST        m_axi_usr_2_wlast           M_AXI4_USR_2     AXI4   
add_port_map_axi  WUSER        m_axi_usr_2_wuser           M_AXI4_USR_2     AXI4   
add_port_map_axi  WVALID       m_axi_usr_2_wvalid          M_AXI4_USR_2     1    
add_port_map_axi  WREADY       m_axi_usr_2_wready          M_AXI4_USR_2     1    
add_port_map_axi  BID          m_axi_usr_2_bid             M_AXI4_USR_2     AXI4 
add_port_map_axi  BRESP        m_axi_usr_2_bresp           M_AXI4_USR_2     1   
add_port_map_axi  BUSER        m_axi_usr_2_buser           M_AXI4_USR_2     AXI4   
add_port_map_axi  BVALID       m_axi_usr_2_bvalid          M_AXI4_USR_2     1    
add_port_map_axi  BREADY       m_axi_usr_2_bready          M_AXI4_USR_2     1    
add_port_map_axi  ARID         m_axi_usr_2_arid            M_AXI4_USR_2     AXI4  
add_port_map_axi  ARADDR       m_axi_usr_2_araddr          M_AXI4_USR_2     1    
add_port_map_axi  ARLEN        m_axi_usr_2_arlen      M_AXI4_USR_2     AXI4   
add_port_map_axi  ARSIZE       m_axi_usr_2_arsize          M_AXI4_USR_2     AXI4    
add_port_map_axi  ARBURST      m_axi_usr_2_arburst         M_AXI4_USR_2     AXI4     
add_port_map_axi  ARLOCK       m_axi_usr_2_arlock     M_AXI4_USR_2     AXI4    
add_port_map_axi  ARCACHE      m_axi_usr_2_arcache         M_AXI4_USR_2     AXI4     
add_port_map_axi  ARPROT       m_axi_usr_2_arprot          M_AXI4_USR_2     1    
add_port_map_axi  ARQOS        m_axi_usr_2_arqos           M_AXI4_USR_2     AXI4   
add_port_map_axi  ARREGION     m_axi_usr_2_arregion        M_AXI4_USR_2     AXI4      
add_port_map_axi  ARUSER       m_axi_usr_2_aruser          M_AXI4_USR_2     AXI4    
add_port_map_axi  ARVALID      m_axi_usr_2_arvalid         M_AXI4_USR_2     1     
add_port_map_axi  ARREADY      m_axi_usr_2_arready         M_AXI4_USR_2     1     
add_port_map_axi  RID          m_axi_usr_2_rid             M_AXI4_USR_2     AXI4 
add_port_map_axi  RDATA        m_axi_usr_2_rdata           M_AXI4_USR_2     1   
add_port_map_axi  RRESP        m_axi_usr_2_rresp           M_AXI4_USR_2     1   
add_port_map_axi  RLAST        m_axi_usr_2_rlast           M_AXI4_USR_2     AXI4   
add_port_map_axi  RUSER        m_axi_usr_2_ruser           M_AXI4_USR_2     AXI4   
add_port_map_axi  RVALID       m_axi_usr_2_rvalid          M_AXI4_USR_2     1    
add_port_map_axi  RREADY       m_axi_usr_2_rready          M_AXI4_USR_2     1    

add_port_map_axi  AWID         m_axi_usr_2_awid            M_AXI4LITE_USR_2 AXI4  
add_port_map_axi  AWADDR       m_axi_usr_2_awaddr          M_AXI4LITE_USR_2 1    
add_port_map_axi  AWLEN        m_axi_usr_2_awlen      M_AXI4LITE_USR_2 AXI4   
add_port_map_axi  AWSIZE       m_axi_usr_2_awsize          M_AXI4LITE_USR_2 AXI4    
add_port_map_axi  AWBURST      m_axi_usr_2_awburst         M_AXI4LITE_USR_2 AXI4     
add_port_map_axi  AWLOCK       m_axi_usr_2_awlock     M_AXI4LITE_USR_2 AXI4    
add_port_map_axi  AWCACHE      m_axi_usr_2_awcache         M_AXI4LITE_USR_2 AXI4     
add_port_map_axi  AWPROT       m_axi_usr_2_awprot          M_AXI4LITE_USR_2 1    
add_port_map_axi  AWQOS        m_axi_usr_2_awqos           M_AXI4LITE_USR_2 AXI4   
add_port_map_axi  AWREGION     m_axi_usr_2_awregion        M_AXI4LITE_USR_2 AXI4      
add_port_map_axi  AWUSER       m_axi_usr_2_awuser          M_AXI4LITE_USR_2 AXI4    
add_port_map_axi  AWVALID      m_axi_usr_2_awvalid         M_AXI4LITE_USR_2 1     
add_port_map_axi  AWREADY      m_axi_usr_2_awready         M_AXI4LITE_USR_2 1     
add_port_map_axi  WDATA        m_axi_usr_2_wdata           M_AXI4LITE_USR_2 1   
add_port_map_axi  WSTRB        m_axi_usr_2_wstrb           M_AXI4LITE_USR_2 1  
add_port_map_axi  WID          m_axi_usr_2_wid             M_AXI4LITE_USR_2 AXI3   
add_port_map_axi  WLAST        m_axi_usr_2_wlast           M_AXI4LITE_USR_2 AXI4   
add_port_map_axi  WUSER        m_axi_usr_2_wuser           M_AXI4LITE_USR_2 AXI4   
add_port_map_axi  WVALID       m_axi_usr_2_wvalid          M_AXI4LITE_USR_2 1    
add_port_map_axi  WREADY       m_axi_usr_2_wready          M_AXI4LITE_USR_2 1    
add_port_map_axi  BID          m_axi_usr_2_bid             M_AXI4LITE_USR_2 AXI4 
add_port_map_axi  BRESP        m_axi_usr_2_bresp           M_AXI4LITE_USR_2 1   
add_port_map_axi  BUSER        m_axi_usr_2_buser           M_AXI4LITE_USR_2 AXI4   
add_port_map_axi  BVALID       m_axi_usr_2_bvalid          M_AXI4LITE_USR_2 1    
add_port_map_axi  BREADY       m_axi_usr_2_bready          M_AXI4LITE_USR_2 1    
add_port_map_axi  ARID         m_axi_usr_2_arid            M_AXI4LITE_USR_2 AXI4  
add_port_map_axi  ARADDR       m_axi_usr_2_araddr          M_AXI4LITE_USR_2 1    
add_port_map_axi  ARLEN        m_axi_usr_2_arlen      M_AXI4LITE_USR_2 AXI4   
add_port_map_axi  ARSIZE       m_axi_usr_2_arsize          M_AXI4LITE_USR_2 AXI4    
add_port_map_axi  ARBURST      m_axi_usr_2_arburst         M_AXI4LITE_USR_2 AXI4     
add_port_map_axi  ARLOCK       m_axi_usr_2_arlock     M_AXI4LITE_USR_2 AXI4    
add_port_map_axi  ARCACHE      m_axi_usr_2_arcache         M_AXI4LITE_USR_2 AXI4     
add_port_map_axi  ARPROT       m_axi_usr_2_arprot          M_AXI4LITE_USR_2 1    
add_port_map_axi  ARQOS        m_axi_usr_2_arqos           M_AXI4LITE_USR_2 AXI4   
add_port_map_axi  ARREGION     m_axi_usr_2_arregion        M_AXI4LITE_USR_2 AXI4      
add_port_map_axi  ARUSER       m_axi_usr_2_aruser          M_AXI4LITE_USR_2 AXI4    
add_port_map_axi  ARVALID      m_axi_usr_2_arvalid         M_AXI4LITE_USR_2 1     
add_port_map_axi  ARREADY      m_axi_usr_2_arready         M_AXI4LITE_USR_2 1     
add_port_map_axi  RID          m_axi_usr_2_rid             M_AXI4LITE_USR_2 AXI4 
add_port_map_axi  RDATA        m_axi_usr_2_rdata           M_AXI4LITE_USR_2 1   
add_port_map_axi  RRESP        m_axi_usr_2_rresp           M_AXI4LITE_USR_2 1   
add_port_map_axi  RLAST        m_axi_usr_2_rlast           M_AXI4LITE_USR_2 AXI4   
add_port_map_axi  RUSER        m_axi_usr_2_ruser           M_AXI4LITE_USR_2 AXI4   
add_port_map_axi  RVALID       m_axi_usr_2_rvalid          M_AXI4LITE_USR_2 1    
add_port_map_axi  RREADY       m_axi_usr_2_rready          M_AXI4LITE_USR_2 1    

add_port_map_axi  AWID         m_axi_usr_2_awid            M_AXI3_USR_2     AXI4  
add_port_map_axi  AWADDR       m_axi_usr_2_awaddr          M_AXI3_USR_2     1    
add_port_map_axi  AWLEN        m_axi_usr_2_awlen      M_AXI3_USR_2     AXI4   
add_port_map_axi  AWSIZE       m_axi_usr_2_awsize          M_AXI3_USR_2     AXI4    
add_port_map_axi  AWBURST      m_axi_usr_2_awburst         M_AXI3_USR_2     AXI4     
add_port_map_axi  AWLOCK       m_axi_usr_2_awlock     M_AXI3_USR_2     AXI4    
add_port_map_axi  AWCACHE      m_axi_usr_2_awcache         M_AXI3_USR_2     AXI4     
add_port_map_axi  AWPROT       m_axi_usr_2_awprot          M_AXI3_USR_2     1    
add_port_map_axi  AWQOS        m_axi_usr_2_awqos           M_AXI3_USR_2     AXI4   
add_port_map_axi  AWREGION     m_axi_usr_2_awregion        M_AXI3_USR_2     AXI4      
add_port_map_axi  AWUSER       m_axi_usr_2_awuser          M_AXI3_USR_2     AXI4    
add_port_map_axi  AWVALID      m_axi_usr_2_awvalid         M_AXI3_USR_2     1     
add_port_map_axi  AWREADY      m_axi_usr_2_awready         M_AXI3_USR_2     1     
add_port_map_axi  WDATA        m_axi_usr_2_wdata           M_AXI3_USR_2     1   
add_port_map_axi  WSTRB        m_axi_usr_2_wstrb           M_AXI3_USR_2     1  
add_port_map_axi  WID          m_axi_usr_2_wid             M_AXI3_USR_2     AXI3   
add_port_map_axi  WLAST        m_axi_usr_2_wlast           M_AXI3_USR_2     AXI4   
add_port_map_axi  WUSER        m_axi_usr_2_wuser           M_AXI3_USR_2     AXI4   
add_port_map_axi  WVALID       m_axi_usr_2_wvalid          M_AXI3_USR_2     1    
add_port_map_axi  WREADY       m_axi_usr_2_wready          M_AXI3_USR_2     1    
add_port_map_axi  BID          m_axi_usr_2_bid             M_AXI3_USR_2     AXI4 
add_port_map_axi  BRESP        m_axi_usr_2_bresp           M_AXI3_USR_2     1   
add_port_map_axi  BUSER        m_axi_usr_2_buser           M_AXI3_USR_2     AXI4   
add_port_map_axi  BVALID       m_axi_usr_2_bvalid          M_AXI3_USR_2     1    
add_port_map_axi  BREADY       m_axi_usr_2_bready          M_AXI3_USR_2     1    
add_port_map_axi  ARID         m_axi_usr_2_arid            M_AXI3_USR_2     AXI4  
add_port_map_axi  ARADDR       m_axi_usr_2_araddr          M_AXI3_USR_2     1    
add_port_map_axi  ARLEN        m_axi_usr_2_arlen      M_AXI3_USR_2     AXI4   
add_port_map_axi  ARSIZE       m_axi_usr_2_arsize          M_AXI3_USR_2     AXI4    
add_port_map_axi  ARBURST      m_axi_usr_2_arburst         M_AXI3_USR_2     AXI4     
add_port_map_axi  ARLOCK       m_axi_usr_2_arlock     M_AXI3_USR_2     AXI4    
add_port_map_axi  ARCACHE      m_axi_usr_2_arcache         M_AXI3_USR_2     AXI4     
add_port_map_axi  ARPROT       m_axi_usr_2_arprot          M_AXI3_USR_2     1    
add_port_map_axi  ARQOS        m_axi_usr_2_arqos           M_AXI3_USR_2     AXI4   
add_port_map_axi  ARREGION     m_axi_usr_2_arregion        M_AXI3_USR_2     AXI4      
add_port_map_axi  ARUSER       m_axi_usr_2_aruser          M_AXI3_USR_2     AXI4    
add_port_map_axi  ARVALID      m_axi_usr_2_arvalid         M_AXI3_USR_2     1     
add_port_map_axi  ARREADY      m_axi_usr_2_arready         M_AXI3_USR_2     1     
add_port_map_axi  RID          m_axi_usr_2_rid             M_AXI3_USR_2     AXI4 
add_port_map_axi  RDATA        m_axi_usr_2_rdata           M_AXI3_USR_2     1   
add_port_map_axi  RRESP        m_axi_usr_2_rresp           M_AXI3_USR_2     1   
add_port_map_axi  RLAST        m_axi_usr_2_rlast           M_AXI3_USR_2     AXI4   
add_port_map_axi  RUSER        m_axi_usr_2_ruser           M_AXI3_USR_2     AXI4   
add_port_map_axi  RVALID       m_axi_usr_2_rvalid          M_AXI3_USR_2     1    
add_port_map_axi  RREADY       m_axi_usr_2_rready          M_AXI3_USR_2     1    


add_port_map_axi  AWID         m_axi_usr_3_awid            M_AXI4_USR_3     AXI4  
add_port_map_axi  AWADDR       m_axi_usr_3_awaddr          M_AXI4_USR_3     1    
add_port_map_axi  AWLEN        m_axi_usr_3_awlen      M_AXI4_USR_3     AXI4   
add_port_map_axi  AWSIZE       m_axi_usr_3_awsize          M_AXI4_USR_3     AXI4    
add_port_map_axi  AWBURST      m_axi_usr_3_awburst         M_AXI4_USR_3     AXI4     
add_port_map_axi  AWLOCK       m_axi_usr_3_awlock     M_AXI4_USR_3     AXI4    
add_port_map_axi  AWCACHE      m_axi_usr_3_awcache         M_AXI4_USR_3     AXI4     
add_port_map_axi  AWPROT       m_axi_usr_3_awprot          M_AXI4_USR_3     1    
add_port_map_axi  AWQOS        m_axi_usr_3_awqos           M_AXI4_USR_3     AXI4   
add_port_map_axi  AWREGION     m_axi_usr_3_awregion        M_AXI4_USR_3     AXI4      
add_port_map_axi  AWUSER       m_axi_usr_3_awuser          M_AXI4_USR_3     AXI4    
add_port_map_axi  AWVALID      m_axi_usr_3_awvalid         M_AXI4_USR_3     1     
add_port_map_axi  AWREADY      m_axi_usr_3_awready         M_AXI4_USR_3     1     
add_port_map_axi  WDATA        m_axi_usr_3_wdata           M_AXI4_USR_3     1   
add_port_map_axi  WSTRB        m_axi_usr_3_wstrb           M_AXI4_USR_3     1  
add_port_map_axi  WID          m_axi_usr_3_wid             M_AXI4_USR_3     AXI3   
add_port_map_axi  WLAST        m_axi_usr_3_wlast           M_AXI4_USR_3     AXI4   
add_port_map_axi  WUSER        m_axi_usr_3_wuser           M_AXI4_USR_3     AXI4   
add_port_map_axi  WVALID       m_axi_usr_3_wvalid          M_AXI4_USR_3     1    
add_port_map_axi  WREADY       m_axi_usr_3_wready          M_AXI4_USR_3     1    
add_port_map_axi  BID          m_axi_usr_3_bid             M_AXI4_USR_3     AXI4 
add_port_map_axi  BRESP        m_axi_usr_3_bresp           M_AXI4_USR_3     1   
add_port_map_axi  BUSER        m_axi_usr_3_buser           M_AXI4_USR_3     AXI4   
add_port_map_axi  BVALID       m_axi_usr_3_bvalid          M_AXI4_USR_3     1    
add_port_map_axi  BREADY       m_axi_usr_3_bready          M_AXI4_USR_3     1    
add_port_map_axi  ARID         m_axi_usr_3_arid            M_AXI4_USR_3     AXI4  
add_port_map_axi  ARADDR       m_axi_usr_3_araddr          M_AXI4_USR_3     1    
add_port_map_axi  ARLEN        m_axi_usr_3_arlen      M_AXI4_USR_3     AXI4   
add_port_map_axi  ARSIZE       m_axi_usr_3_arsize          M_AXI4_USR_3     AXI4    
add_port_map_axi  ARBURST      m_axi_usr_3_arburst         M_AXI4_USR_3     AXI4     
add_port_map_axi  ARLOCK       m_axi_usr_3_arlock     M_AXI4_USR_3     AXI4    
add_port_map_axi  ARCACHE      m_axi_usr_3_arcache         M_AXI4_USR_3     AXI4     
add_port_map_axi  ARPROT       m_axi_usr_3_arprot          M_AXI4_USR_3     1    
add_port_map_axi  ARQOS        m_axi_usr_3_arqos           M_AXI4_USR_3     AXI4   
add_port_map_axi  ARREGION     m_axi_usr_3_arregion        M_AXI4_USR_3     AXI4      
add_port_map_axi  ARUSER       m_axi_usr_3_aruser          M_AXI4_USR_3     AXI4    
add_port_map_axi  ARVALID      m_axi_usr_3_arvalid         M_AXI4_USR_3     1     
add_port_map_axi  ARREADY      m_axi_usr_3_arready         M_AXI4_USR_3     1     
add_port_map_axi  RID          m_axi_usr_3_rid             M_AXI4_USR_3     AXI4 
add_port_map_axi  RDATA        m_axi_usr_3_rdata           M_AXI4_USR_3     1   
add_port_map_axi  RRESP        m_axi_usr_3_rresp           M_AXI4_USR_3     1   
add_port_map_axi  RLAST        m_axi_usr_3_rlast           M_AXI4_USR_3     AXI4   
add_port_map_axi  RUSER        m_axi_usr_3_ruser           M_AXI4_USR_3     AXI4   
add_port_map_axi  RVALID       m_axi_usr_3_rvalid          M_AXI4_USR_3     1    
add_port_map_axi  RREADY       m_axi_usr_3_rready          M_AXI4_USR_3     1    

add_port_map_axi  AWID         m_axi_usr_3_awid            M_AXI4LITE_USR_3 AXI4  
add_port_map_axi  AWADDR       m_axi_usr_3_awaddr          M_AXI4LITE_USR_3 1    
add_port_map_axi  AWLEN        m_axi_usr_3_awlen      M_AXI4LITE_USR_3 AXI4   
add_port_map_axi  AWSIZE       m_axi_usr_3_awsize          M_AXI4LITE_USR_3 AXI4    
add_port_map_axi  AWBURST      m_axi_usr_3_awburst         M_AXI4LITE_USR_3 AXI4     
add_port_map_axi  AWLOCK       m_axi_usr_3_awlock     M_AXI4LITE_USR_3 AXI4    
add_port_map_axi  AWCACHE      m_axi_usr_3_awcache         M_AXI4LITE_USR_3 AXI4     
add_port_map_axi  AWPROT       m_axi_usr_3_awprot          M_AXI4LITE_USR_3 1    
add_port_map_axi  AWQOS        m_axi_usr_3_awqos           M_AXI4LITE_USR_3 AXI4   
add_port_map_axi  AWREGION     m_axi_usr_3_awregion        M_AXI4LITE_USR_3 AXI4      
add_port_map_axi  AWUSER       m_axi_usr_3_awuser          M_AXI4LITE_USR_3 AXI4    
add_port_map_axi  AWVALID      m_axi_usr_3_awvalid         M_AXI4LITE_USR_3 1     
add_port_map_axi  AWREADY      m_axi_usr_3_awready         M_AXI4LITE_USR_3 1     
add_port_map_axi  WDATA        m_axi_usr_3_wdata           M_AXI4LITE_USR_3 1   
add_port_map_axi  WSTRB        m_axi_usr_3_wstrb           M_AXI4LITE_USR_3 1  
add_port_map_axi  WID          m_axi_usr_3_wid             M_AXI4LITE_USR_3 AXI3   
add_port_map_axi  WLAST        m_axi_usr_3_wlast           M_AXI4LITE_USR_3 AXI4   
add_port_map_axi  WUSER        m_axi_usr_3_wuser           M_AXI4LITE_USR_3 AXI4   
add_port_map_axi  WVALID       m_axi_usr_3_wvalid          M_AXI4LITE_USR_3 1    
add_port_map_axi  WREADY       m_axi_usr_3_wready          M_AXI4LITE_USR_3 1    
add_port_map_axi  BID          m_axi_usr_3_bid             M_AXI4LITE_USR_3 AXI4 
add_port_map_axi  BRESP        m_axi_usr_3_bresp           M_AXI4LITE_USR_3 1   
add_port_map_axi  BUSER        m_axi_usr_3_buser           M_AXI4LITE_USR_3 AXI4   
add_port_map_axi  BVALID       m_axi_usr_3_bvalid          M_AXI4LITE_USR_3 1    
add_port_map_axi  BREADY       m_axi_usr_3_bready          M_AXI4LITE_USR_3 1    
add_port_map_axi  ARID         m_axi_usr_3_arid            M_AXI4LITE_USR_3 AXI4  
add_port_map_axi  ARADDR       m_axi_usr_3_araddr          M_AXI4LITE_USR_3 1    
add_port_map_axi  ARLEN        m_axi_usr_3_arlen      M_AXI4LITE_USR_3 AXI4   
add_port_map_axi  ARSIZE       m_axi_usr_3_arsize          M_AXI4LITE_USR_3 AXI4    
add_port_map_axi  ARBURST      m_axi_usr_3_arburst         M_AXI4LITE_USR_3 AXI4     
add_port_map_axi  ARLOCK       m_axi_usr_3_arlock     M_AXI4LITE_USR_3 AXI4    
add_port_map_axi  ARCACHE      m_axi_usr_3_arcache         M_AXI4LITE_USR_3 AXI4     
add_port_map_axi  ARPROT       m_axi_usr_3_arprot          M_AXI4LITE_USR_3 1    
add_port_map_axi  ARQOS        m_axi_usr_3_arqos           M_AXI4LITE_USR_3 AXI4   
add_port_map_axi  ARREGION     m_axi_usr_3_arregion        M_AXI4LITE_USR_3 AXI4      
add_port_map_axi  ARUSER       m_axi_usr_3_aruser          M_AXI4LITE_USR_3 AXI4    
add_port_map_axi  ARVALID      m_axi_usr_3_arvalid         M_AXI4LITE_USR_3 1     
add_port_map_axi  ARREADY      m_axi_usr_3_arready         M_AXI4LITE_USR_3 1     
add_port_map_axi  RID          m_axi_usr_3_rid             M_AXI4LITE_USR_3 AXI4 
add_port_map_axi  RDATA        m_axi_usr_3_rdata           M_AXI4LITE_USR_3 1   
add_port_map_axi  RRESP        m_axi_usr_3_rresp           M_AXI4LITE_USR_3 1   
add_port_map_axi  RLAST        m_axi_usr_3_rlast           M_AXI4LITE_USR_3 AXI4   
add_port_map_axi  RUSER        m_axi_usr_3_ruser           M_AXI4LITE_USR_3 AXI4   
add_port_map_axi  RVALID       m_axi_usr_3_rvalid          M_AXI4LITE_USR_3 1    
add_port_map_axi  RREADY       m_axi_usr_3_rready          M_AXI4LITE_USR_3 1    

add_port_map_axi  AWID         m_axi_usr_3_awid            M_AXI3_USR_3     AXI4  
add_port_map_axi  AWADDR       m_axi_usr_3_awaddr          M_AXI3_USR_3     1    
add_port_map_axi  AWLEN        m_axi_usr_3_awlen      M_AXI3_USR_3     AXI4   
add_port_map_axi  AWSIZE       m_axi_usr_3_awsize          M_AXI3_USR_3     AXI4    
add_port_map_axi  AWBURST      m_axi_usr_3_awburst         M_AXI3_USR_3     AXI4     
add_port_map_axi  AWLOCK       m_axi_usr_3_awlock     M_AXI3_USR_3     AXI4    
add_port_map_axi  AWCACHE      m_axi_usr_3_awcache         M_AXI3_USR_3     AXI4     
add_port_map_axi  AWPROT       m_axi_usr_3_awprot          M_AXI3_USR_3     1    
add_port_map_axi  AWQOS        m_axi_usr_3_awqos           M_AXI3_USR_3     AXI4   
add_port_map_axi  AWREGION     m_axi_usr_3_awregion        M_AXI3_USR_3     AXI4      
add_port_map_axi  AWUSER       m_axi_usr_3_awuser          M_AXI3_USR_3     AXI4    
add_port_map_axi  AWVALID      m_axi_usr_3_awvalid         M_AXI3_USR_3     1     
add_port_map_axi  AWREADY      m_axi_usr_3_awready         M_AXI3_USR_3     1     
add_port_map_axi  WDATA        m_axi_usr_3_wdata           M_AXI3_USR_3     1   
add_port_map_axi  WSTRB        m_axi_usr_3_wstrb           M_AXI3_USR_3     1  
add_port_map_axi  WID          m_axi_usr_3_wid             M_AXI3_USR_3     AXI3   
add_port_map_axi  WLAST        m_axi_usr_3_wlast           M_AXI3_USR_3     AXI4   
add_port_map_axi  WUSER        m_axi_usr_3_wuser           M_AXI3_USR_3     AXI4   
add_port_map_axi  WVALID       m_axi_usr_3_wvalid          M_AXI3_USR_3     1    
add_port_map_axi  WREADY       m_axi_usr_3_wready          M_AXI3_USR_3     1    
add_port_map_axi  BID          m_axi_usr_3_bid             M_AXI3_USR_3     AXI4 
add_port_map_axi  BRESP        m_axi_usr_3_bresp           M_AXI3_USR_3     1   
add_port_map_axi  BUSER        m_axi_usr_3_buser           M_AXI3_USR_3     AXI4   
add_port_map_axi  BVALID       m_axi_usr_3_bvalid          M_AXI3_USR_3     1    
add_port_map_axi  BREADY       m_axi_usr_3_bready          M_AXI3_USR_3     1    
add_port_map_axi  ARID         m_axi_usr_3_arid            M_AXI3_USR_3     AXI4  
add_port_map_axi  ARADDR       m_axi_usr_3_araddr          M_AXI3_USR_3     1    
add_port_map_axi  ARLEN        m_axi_usr_3_arlen      M_AXI3_USR_3     AXI4   
add_port_map_axi  ARSIZE       m_axi_usr_3_arsize          M_AXI3_USR_3     AXI4    
add_port_map_axi  ARBURST      m_axi_usr_3_arburst         M_AXI3_USR_3     AXI4     
add_port_map_axi  ARLOCK       m_axi_usr_3_arlock     M_AXI3_USR_3     AXI4    
add_port_map_axi  ARCACHE      m_axi_usr_3_arcache         M_AXI3_USR_3     AXI4     
add_port_map_axi  ARPROT       m_axi_usr_3_arprot          M_AXI3_USR_3     1    
add_port_map_axi  ARQOS        m_axi_usr_3_arqos           M_AXI3_USR_3     AXI4   
add_port_map_axi  ARREGION     m_axi_usr_3_arregion        M_AXI3_USR_3     AXI4      
add_port_map_axi  ARUSER       m_axi_usr_3_aruser          M_AXI3_USR_3     AXI4    
add_port_map_axi  ARVALID      m_axi_usr_3_arvalid         M_AXI3_USR_3     1     
add_port_map_axi  ARREADY      m_axi_usr_3_arready         M_AXI3_USR_3     1     
add_port_map_axi  RID          m_axi_usr_3_rid             M_AXI3_USR_3     AXI4 
add_port_map_axi  RDATA        m_axi_usr_3_rdata           M_AXI3_USR_3     1   
add_port_map_axi  RRESP        m_axi_usr_3_rresp           M_AXI3_USR_3     1   
add_port_map_axi  RLAST        m_axi_usr_3_rlast           M_AXI3_USR_3     AXI4   
add_port_map_axi  RUSER        m_axi_usr_3_ruser           M_AXI3_USR_3     AXI4   
add_port_map_axi  RVALID       m_axi_usr_3_rvalid          M_AXI3_USR_3     1    
add_port_map_axi  RREADY       m_axi_usr_3_rready          M_AXI3_USR_3     1    


add_port_map_axi  AWID         m_axi_usr_4_awid            M_AXI4_USR_4     AXI4  
add_port_map_axi  AWADDR       m_axi_usr_4_awaddr          M_AXI4_USR_4     1    
add_port_map_axi  AWLEN        m_axi_usr_4_awlen      M_AXI4_USR_4     AXI4   
add_port_map_axi  AWSIZE       m_axi_usr_4_awsize          M_AXI4_USR_4     AXI4    
add_port_map_axi  AWBURST      m_axi_usr_4_awburst         M_AXI4_USR_4     AXI4     
add_port_map_axi  AWLOCK       m_axi_usr_4_awlock     M_AXI4_USR_4     AXI4    
add_port_map_axi  AWCACHE      m_axi_usr_4_awcache         M_AXI4_USR_4     AXI4     
add_port_map_axi  AWPROT       m_axi_usr_4_awprot          M_AXI4_USR_4     1    
add_port_map_axi  AWQOS        m_axi_usr_4_awqos           M_AXI4_USR_4     AXI4   
add_port_map_axi  AWREGION     m_axi_usr_4_awregion        M_AXI4_USR_4     AXI4      
add_port_map_axi  AWUSER       m_axi_usr_4_awuser          M_AXI4_USR_4     AXI4    
add_port_map_axi  AWVALID      m_axi_usr_4_awvalid         M_AXI4_USR_4     1     
add_port_map_axi  AWREADY      m_axi_usr_4_awready         M_AXI4_USR_4     1     
add_port_map_axi  WDATA        m_axi_usr_4_wdata           M_AXI4_USR_4     1   
add_port_map_axi  WSTRB        m_axi_usr_4_wstrb           M_AXI4_USR_4     1  
add_port_map_axi  WID          m_axi_usr_4_wid             M_AXI4_USR_4     AXI3   
add_port_map_axi  WLAST        m_axi_usr_4_wlast           M_AXI4_USR_4     AXI4   
add_port_map_axi  WUSER        m_axi_usr_4_wuser           M_AXI4_USR_4     AXI4   
add_port_map_axi  WVALID       m_axi_usr_4_wvalid          M_AXI4_USR_4     1    
add_port_map_axi  WREADY       m_axi_usr_4_wready          M_AXI4_USR_4     1    
add_port_map_axi  BID          m_axi_usr_4_bid             M_AXI4_USR_4     AXI4 
add_port_map_axi  BRESP        m_axi_usr_4_bresp           M_AXI4_USR_4     1   
add_port_map_axi  BUSER        m_axi_usr_4_buser           M_AXI4_USR_4     AXI4   
add_port_map_axi  BVALID       m_axi_usr_4_bvalid          M_AXI4_USR_4     1    
add_port_map_axi  BREADY       m_axi_usr_4_bready          M_AXI4_USR_4     1    
add_port_map_axi  ARID         m_axi_usr_4_arid            M_AXI4_USR_4     AXI4  
add_port_map_axi  ARADDR       m_axi_usr_4_araddr          M_AXI4_USR_4     1    
add_port_map_axi  ARLEN        m_axi_usr_4_arlen      M_AXI4_USR_4     AXI4   
add_port_map_axi  ARSIZE       m_axi_usr_4_arsize          M_AXI4_USR_4     AXI4    
add_port_map_axi  ARBURST      m_axi_usr_4_arburst         M_AXI4_USR_4     AXI4     
add_port_map_axi  ARLOCK       m_axi_usr_4_arlock     M_AXI4_USR_4     AXI4    
add_port_map_axi  ARCACHE      m_axi_usr_4_arcache         M_AXI4_USR_4     AXI4     
add_port_map_axi  ARPROT       m_axi_usr_4_arprot          M_AXI4_USR_4     1    
add_port_map_axi  ARQOS        m_axi_usr_4_arqos           M_AXI4_USR_4     AXI4   
add_port_map_axi  ARREGION     m_axi_usr_4_arregion        M_AXI4_USR_4     AXI4      
add_port_map_axi  ARUSER       m_axi_usr_4_aruser          M_AXI4_USR_4     AXI4    
add_port_map_axi  ARVALID      m_axi_usr_4_arvalid         M_AXI4_USR_4     1     
add_port_map_axi  ARREADY      m_axi_usr_4_arready         M_AXI4_USR_4     1     
add_port_map_axi  RID          m_axi_usr_4_rid             M_AXI4_USR_4     AXI4 
add_port_map_axi  RDATA        m_axi_usr_4_rdata           M_AXI4_USR_4     1   
add_port_map_axi  RRESP        m_axi_usr_4_rresp           M_AXI4_USR_4     1   
add_port_map_axi  RLAST        m_axi_usr_4_rlast           M_AXI4_USR_4     AXI4   
add_port_map_axi  RUSER        m_axi_usr_4_ruser           M_AXI4_USR_4     AXI4   
add_port_map_axi  RVALID       m_axi_usr_4_rvalid          M_AXI4_USR_4     1    
add_port_map_axi  RREADY       m_axi_usr_4_rready          M_AXI4_USR_4     1    

add_port_map_axi  AWID         m_axi_usr_4_awid            M_AXI4LITE_USR_4 AXI4  
add_port_map_axi  AWADDR       m_axi_usr_4_awaddr          M_AXI4LITE_USR_4 1    
add_port_map_axi  AWLEN        m_axi_usr_4_awlen      M_AXI4LITE_USR_4 AXI4   
add_port_map_axi  AWSIZE       m_axi_usr_4_awsize          M_AXI4LITE_USR_4 AXI4    
add_port_map_axi  AWBURST      m_axi_usr_4_awburst         M_AXI4LITE_USR_4 AXI4     
add_port_map_axi  AWLOCK       m_axi_usr_4_awlock     M_AXI4LITE_USR_4 AXI4    
add_port_map_axi  AWCACHE      m_axi_usr_4_awcache         M_AXI4LITE_USR_4 AXI4     
add_port_map_axi  AWPROT       m_axi_usr_4_awprot          M_AXI4LITE_USR_4 1    
add_port_map_axi  AWQOS        m_axi_usr_4_awqos           M_AXI4LITE_USR_4 AXI4   
add_port_map_axi  AWREGION     m_axi_usr_4_awregion        M_AXI4LITE_USR_4 AXI4      
add_port_map_axi  AWUSER       m_axi_usr_4_awuser          M_AXI4LITE_USR_4 AXI4    
add_port_map_axi  AWVALID      m_axi_usr_4_awvalid         M_AXI4LITE_USR_4 1     
add_port_map_axi  AWREADY      m_axi_usr_4_awready         M_AXI4LITE_USR_4 1     
add_port_map_axi  WDATA        m_axi_usr_4_wdata           M_AXI4LITE_USR_4 1   
add_port_map_axi  WSTRB        m_axi_usr_4_wstrb           M_AXI4LITE_USR_4 1  
add_port_map_axi  WID          m_axi_usr_4_wid             M_AXI4LITE_USR_4 AXI3   
add_port_map_axi  WLAST        m_axi_usr_4_wlast           M_AXI4LITE_USR_4 AXI4   
add_port_map_axi  WUSER        m_axi_usr_4_wuser           M_AXI4LITE_USR_4 AXI4   
add_port_map_axi  WVALID       m_axi_usr_4_wvalid          M_AXI4LITE_USR_4 1    
add_port_map_axi  WREADY       m_axi_usr_4_wready          M_AXI4LITE_USR_4 1    
add_port_map_axi  BID          m_axi_usr_4_bid             M_AXI4LITE_USR_4 AXI4 
add_port_map_axi  BRESP        m_axi_usr_4_bresp           M_AXI4LITE_USR_4 1   
add_port_map_axi  BUSER        m_axi_usr_4_buser           M_AXI4LITE_USR_4 AXI4   
add_port_map_axi  BVALID       m_axi_usr_4_bvalid          M_AXI4LITE_USR_4 1    
add_port_map_axi  BREADY       m_axi_usr_4_bready          M_AXI4LITE_USR_4 1    
add_port_map_axi  ARID         m_axi_usr_4_arid            M_AXI4LITE_USR_4 AXI4  
add_port_map_axi  ARADDR       m_axi_usr_4_araddr          M_AXI4LITE_USR_4 1    
add_port_map_axi  ARLEN        m_axi_usr_4_arlen      M_AXI4LITE_USR_4 AXI4   
add_port_map_axi  ARSIZE       m_axi_usr_4_arsize          M_AXI4LITE_USR_4 AXI4    
add_port_map_axi  ARBURST      m_axi_usr_4_arburst         M_AXI4LITE_USR_4 AXI4     
add_port_map_axi  ARLOCK       m_axi_usr_4_arlock     M_AXI4LITE_USR_4 AXI4    
add_port_map_axi  ARCACHE      m_axi_usr_4_arcache         M_AXI4LITE_USR_4 AXI4     
add_port_map_axi  ARPROT       m_axi_usr_4_arprot          M_AXI4LITE_USR_4 1    
add_port_map_axi  ARQOS        m_axi_usr_4_arqos           M_AXI4LITE_USR_4 AXI4   
add_port_map_axi  ARREGION     m_axi_usr_4_arregion        M_AXI4LITE_USR_4 AXI4      
add_port_map_axi  ARUSER       m_axi_usr_4_aruser          M_AXI4LITE_USR_4 AXI4    
add_port_map_axi  ARVALID      m_axi_usr_4_arvalid         M_AXI4LITE_USR_4 1     
add_port_map_axi  ARREADY      m_axi_usr_4_arready         M_AXI4LITE_USR_4 1     
add_port_map_axi  RID          m_axi_usr_4_rid             M_AXI4LITE_USR_4 AXI4 
add_port_map_axi  RDATA        m_axi_usr_4_rdata           M_AXI4LITE_USR_4 1   
add_port_map_axi  RRESP        m_axi_usr_4_rresp           M_AXI4LITE_USR_4 1   
add_port_map_axi  RLAST        m_axi_usr_4_rlast           M_AXI4LITE_USR_4 AXI4   
add_port_map_axi  RUSER        m_axi_usr_4_ruser           M_AXI4LITE_USR_4 AXI4   
add_port_map_axi  RVALID       m_axi_usr_4_rvalid          M_AXI4LITE_USR_4 1    
add_port_map_axi  RREADY       m_axi_usr_4_rready          M_AXI4LITE_USR_4 1    

add_port_map_axi  AWID         m_axi_usr_4_awid            M_AXI3_USR_4     AXI4  
add_port_map_axi  AWADDR       m_axi_usr_4_awaddr          M_AXI3_USR_4     1    
add_port_map_axi  AWLEN        m_axi_usr_4_awlen      M_AXI3_USR_4     AXI4   
add_port_map_axi  AWSIZE       m_axi_usr_4_awsize          M_AXI3_USR_4     AXI4    
add_port_map_axi  AWBURST      m_axi_usr_4_awburst         M_AXI3_USR_4     AXI4     
add_port_map_axi  AWLOCK       m_axi_usr_4_awlock     M_AXI3_USR_4     AXI4    
add_port_map_axi  AWCACHE      m_axi_usr_4_awcache         M_AXI3_USR_4     AXI4     
add_port_map_axi  AWPROT       m_axi_usr_4_awprot          M_AXI3_USR_4     1    
add_port_map_axi  AWQOS        m_axi_usr_4_awqos           M_AXI3_USR_4     AXI4   
add_port_map_axi  AWREGION     m_axi_usr_4_awregion        M_AXI3_USR_4     AXI4      
add_port_map_axi  AWUSER       m_axi_usr_4_awuser          M_AXI3_USR_4     AXI4    
add_port_map_axi  AWVALID      m_axi_usr_4_awvalid         M_AXI3_USR_4     1     
add_port_map_axi  AWREADY      m_axi_usr_4_awready         M_AXI3_USR_4     1     
add_port_map_axi  WDATA        m_axi_usr_4_wdata           M_AXI3_USR_4     1   
add_port_map_axi  WSTRB        m_axi_usr_4_wstrb           M_AXI3_USR_4     1  
add_port_map_axi  WID          m_axi_usr_4_wid             M_AXI3_USR_4     AXI3   
add_port_map_axi  WLAST        m_axi_usr_4_wlast           M_AXI3_USR_4     AXI4   
add_port_map_axi  WUSER        m_axi_usr_4_wuser           M_AXI3_USR_4     AXI4   
add_port_map_axi  WVALID       m_axi_usr_4_wvalid          M_AXI3_USR_4     1    
add_port_map_axi  WREADY       m_axi_usr_4_wready          M_AXI3_USR_4     1    
add_port_map_axi  BID          m_axi_usr_4_bid             M_AXI3_USR_4     AXI4 
add_port_map_axi  BRESP        m_axi_usr_4_bresp           M_AXI3_USR_4     1   
add_port_map_axi  BUSER        m_axi_usr_4_buser           M_AXI3_USR_4     AXI4   
add_port_map_axi  BVALID       m_axi_usr_4_bvalid          M_AXI3_USR_4     1    
add_port_map_axi  BREADY       m_axi_usr_4_bready          M_AXI3_USR_4     1    
add_port_map_axi  ARID         m_axi_usr_4_arid            M_AXI3_USR_4     AXI4  
add_port_map_axi  ARADDR       m_axi_usr_4_araddr          M_AXI3_USR_4     1    
add_port_map_axi  ARLEN        m_axi_usr_4_arlen      M_AXI3_USR_4     AXI4   
add_port_map_axi  ARSIZE       m_axi_usr_4_arsize          M_AXI3_USR_4     AXI4    
add_port_map_axi  ARBURST      m_axi_usr_4_arburst         M_AXI3_USR_4     AXI4     
add_port_map_axi  ARLOCK       m_axi_usr_4_arlock     M_AXI3_USR_4     AXI4    
add_port_map_axi  ARCACHE      m_axi_usr_4_arcache         M_AXI3_USR_4     AXI4     
add_port_map_axi  ARPROT       m_axi_usr_4_arprot          M_AXI3_USR_4     1    
add_port_map_axi  ARQOS        m_axi_usr_4_arqos           M_AXI3_USR_4     AXI4   
add_port_map_axi  ARREGION     m_axi_usr_4_arregion        M_AXI3_USR_4     AXI4      
add_port_map_axi  ARUSER       m_axi_usr_4_aruser          M_AXI3_USR_4     AXI4    
add_port_map_axi  ARVALID      m_axi_usr_4_arvalid         M_AXI3_USR_4     1     
add_port_map_axi  ARREADY      m_axi_usr_4_arready         M_AXI3_USR_4     1     
add_port_map_axi  RID          m_axi_usr_4_rid             M_AXI3_USR_4     AXI4 
add_port_map_axi  RDATA        m_axi_usr_4_rdata           M_AXI3_USR_4     1   
add_port_map_axi  RRESP        m_axi_usr_4_rresp           M_AXI3_USR_4     1   
add_port_map_axi  RLAST        m_axi_usr_4_rlast           M_AXI3_USR_4     AXI4   
add_port_map_axi  RUSER        m_axi_usr_4_ruser           M_AXI3_USR_4     AXI4   
add_port_map_axi  RVALID       m_axi_usr_4_rvalid          M_AXI3_USR_4     1    
add_port_map_axi  RREADY       m_axi_usr_4_rready          M_AXI3_USR_4     1    




add_port_map_axi  AWID         m_axi_usr_5_awid            M_AXI4_USR_5     AXI4  
add_port_map_axi  AWADDR       m_axi_usr_5_awaddr          M_AXI4_USR_5     1    
add_port_map_axi  AWLEN        m_axi_usr_5_awlen      M_AXI4_USR_5     AXI4   
add_port_map_axi  AWSIZE       m_axi_usr_5_awsize          M_AXI4_USR_5     AXI4    
add_port_map_axi  AWBURST      m_axi_usr_5_awburst         M_AXI4_USR_5     AXI4     
add_port_map_axi  AWLOCK       m_axi_usr_5_awlock     M_AXI4_USR_5     AXI4    
add_port_map_axi  AWCACHE      m_axi_usr_5_awcache         M_AXI4_USR_5     AXI4     
add_port_map_axi  AWPROT       m_axi_usr_5_awprot          M_AXI4_USR_5     1    
add_port_map_axi  AWQOS        m_axi_usr_5_awqos           M_AXI4_USR_5     AXI4   
add_port_map_axi  AWREGION     m_axi_usr_5_awregion        M_AXI4_USR_5     AXI4      
add_port_map_axi  AWUSER       m_axi_usr_5_awuser          M_AXI4_USR_5     AXI4    
add_port_map_axi  AWVALID      m_axi_usr_5_awvalid         M_AXI4_USR_5     1     
add_port_map_axi  AWREADY      m_axi_usr_5_awready         M_AXI4_USR_5     1     
add_port_map_axi  WDATA        m_axi_usr_5_wdata           M_AXI4_USR_5     1   
add_port_map_axi  WSTRB        m_axi_usr_5_wstrb           M_AXI4_USR_5     1  
add_port_map_axi  WID          m_axi_usr_5_wid             M_AXI4_USR_5     AXI3   
add_port_map_axi  WLAST        m_axi_usr_5_wlast           M_AXI4_USR_5     AXI4   
add_port_map_axi  WUSER        m_axi_usr_5_wuser           M_AXI4_USR_5     AXI4   
add_port_map_axi  WVALID       m_axi_usr_5_wvalid          M_AXI4_USR_5     1    
add_port_map_axi  WREADY       m_axi_usr_5_wready          M_AXI4_USR_5     1    
add_port_map_axi  BID          m_axi_usr_5_bid             M_AXI4_USR_5     AXI4 
add_port_map_axi  BRESP        m_axi_usr_5_bresp           M_AXI4_USR_5     1   
add_port_map_axi  BUSER        m_axi_usr_5_buser           M_AXI4_USR_5     AXI4   
add_port_map_axi  BVALID       m_axi_usr_5_bvalid          M_AXI4_USR_5     1    
add_port_map_axi  BREADY       m_axi_usr_5_bready          M_AXI4_USR_5     1    
add_port_map_axi  ARID         m_axi_usr_5_arid            M_AXI4_USR_5     AXI4  
add_port_map_axi  ARADDR       m_axi_usr_5_araddr          M_AXI4_USR_5     1    
add_port_map_axi  ARLEN        m_axi_usr_5_arlen      M_AXI4_USR_5     AXI4   
add_port_map_axi  ARSIZE       m_axi_usr_5_arsize          M_AXI4_USR_5     AXI4    
add_port_map_axi  ARBURST      m_axi_usr_5_arburst         M_AXI4_USR_5     AXI4     
add_port_map_axi  ARLOCK       m_axi_usr_5_arlock     M_AXI4_USR_5     AXI4    
add_port_map_axi  ARCACHE      m_axi_usr_5_arcache         M_AXI4_USR_5     AXI4     
add_port_map_axi  ARPROT       m_axi_usr_5_arprot          M_AXI4_USR_5     1    
add_port_map_axi  ARQOS        m_axi_usr_5_arqos           M_AXI4_USR_5     AXI4   
add_port_map_axi  ARREGION     m_axi_usr_5_arregion        M_AXI4_USR_5     AXI4      
add_port_map_axi  ARUSER       m_axi_usr_5_aruser          M_AXI4_USR_5     AXI4    
add_port_map_axi  ARVALID      m_axi_usr_5_arvalid         M_AXI4_USR_5     1     
add_port_map_axi  ARREADY      m_axi_usr_5_arready         M_AXI4_USR_5     1     
add_port_map_axi  RID          m_axi_usr_5_rid             M_AXI4_USR_5     AXI4 
add_port_map_axi  RDATA        m_axi_usr_5_rdata           M_AXI4_USR_5     1   
add_port_map_axi  RRESP        m_axi_usr_5_rresp           M_AXI4_USR_5     1   
add_port_map_axi  RLAST        m_axi_usr_5_rlast           M_AXI4_USR_5     AXI4   
add_port_map_axi  RUSER        m_axi_usr_5_ruser           M_AXI4_USR_5     AXI4   
add_port_map_axi  RVALID       m_axi_usr_5_rvalid          M_AXI4_USR_5     1    
add_port_map_axi  RREADY       m_axi_usr_5_rready          M_AXI4_USR_5     1    

add_port_map_axi  AWID         m_axi_usr_5_awid            M_AXI4LITE_USR_5 AXI4  
add_port_map_axi  AWADDR       m_axi_usr_5_awaddr          M_AXI4LITE_USR_5 1    
add_port_map_axi  AWLEN        m_axi_usr_5_awlen      M_AXI4LITE_USR_5 AXI4   
add_port_map_axi  AWSIZE       m_axi_usr_5_awsize          M_AXI4LITE_USR_5 AXI4    
add_port_map_axi  AWBURST      m_axi_usr_5_awburst         M_AXI4LITE_USR_5 AXI4     
add_port_map_axi  AWLOCK       m_axi_usr_5_awlock     M_AXI4LITE_USR_5 AXI4    
add_port_map_axi  AWCACHE      m_axi_usr_5_awcache         M_AXI4LITE_USR_5 AXI4     
add_port_map_axi  AWPROT       m_axi_usr_5_awprot          M_AXI4LITE_USR_5 1    
add_port_map_axi  AWQOS        m_axi_usr_5_awqos           M_AXI4LITE_USR_5 AXI4   
add_port_map_axi  AWREGION     m_axi_usr_5_awregion        M_AXI4LITE_USR_5 AXI4      
add_port_map_axi  AWUSER       m_axi_usr_5_awuser          M_AXI4LITE_USR_5 AXI4    
add_port_map_axi  AWVALID      m_axi_usr_5_awvalid         M_AXI4LITE_USR_5 1     
add_port_map_axi  AWREADY      m_axi_usr_5_awready         M_AXI4LITE_USR_5 1     
add_port_map_axi  WDATA        m_axi_usr_5_wdata           M_AXI4LITE_USR_5 1   
add_port_map_axi  WSTRB        m_axi_usr_5_wstrb           M_AXI4LITE_USR_5 1  
add_port_map_axi  WID          m_axi_usr_5_wid             M_AXI4LITE_USR_5 AXI3   
add_port_map_axi  WLAST        m_axi_usr_5_wlast           M_AXI4LITE_USR_5 AXI4   
add_port_map_axi  WUSER        m_axi_usr_5_wuser           M_AXI4LITE_USR_5 AXI4   
add_port_map_axi  WVALID       m_axi_usr_5_wvalid          M_AXI4LITE_USR_5 1    
add_port_map_axi  WREADY       m_axi_usr_5_wready          M_AXI4LITE_USR_5 1    
add_port_map_axi  BID          m_axi_usr_5_bid             M_AXI4LITE_USR_5 AXI4 
add_port_map_axi  BRESP        m_axi_usr_5_bresp           M_AXI4LITE_USR_5 1   
add_port_map_axi  BUSER        m_axi_usr_5_buser           M_AXI4LITE_USR_5 AXI4   
add_port_map_axi  BVALID       m_axi_usr_5_bvalid          M_AXI4LITE_USR_5 1    
add_port_map_axi  BREADY       m_axi_usr_5_bready          M_AXI4LITE_USR_5 1    
add_port_map_axi  ARID         m_axi_usr_5_arid            M_AXI4LITE_USR_5 AXI4  
add_port_map_axi  ARADDR       m_axi_usr_5_araddr          M_AXI4LITE_USR_5 1    
add_port_map_axi  ARLEN        m_axi_usr_5_arlen      M_AXI4LITE_USR_5 AXI4   
add_port_map_axi  ARSIZE       m_axi_usr_5_arsize          M_AXI4LITE_USR_5 AXI4    
add_port_map_axi  ARBURST      m_axi_usr_5_arburst         M_AXI4LITE_USR_5 AXI4     
add_port_map_axi  ARLOCK       m_axi_usr_5_arlock     M_AXI4LITE_USR_5 AXI4    
add_port_map_axi  ARCACHE      m_axi_usr_5_arcache         M_AXI4LITE_USR_5 AXI4     
add_port_map_axi  ARPROT       m_axi_usr_5_arprot          M_AXI4LITE_USR_5 1    
add_port_map_axi  ARQOS        m_axi_usr_5_arqos           M_AXI4LITE_USR_5 AXI4   
add_port_map_axi  ARREGION     m_axi_usr_5_arregion        M_AXI4LITE_USR_5 AXI4      
add_port_map_axi  ARUSER       m_axi_usr_5_aruser          M_AXI4LITE_USR_5 AXI4    
add_port_map_axi  ARVALID      m_axi_usr_5_arvalid         M_AXI4LITE_USR_5 1     
add_port_map_axi  ARREADY      m_axi_usr_5_arready         M_AXI4LITE_USR_5 1     
add_port_map_axi  RID          m_axi_usr_5_rid             M_AXI4LITE_USR_5 AXI4 
add_port_map_axi  RDATA        m_axi_usr_5_rdata           M_AXI4LITE_USR_5 1   
add_port_map_axi  RRESP        m_axi_usr_5_rresp           M_AXI4LITE_USR_5 1   
add_port_map_axi  RLAST        m_axi_usr_5_rlast           M_AXI4LITE_USR_5 AXI4   
add_port_map_axi  RUSER        m_axi_usr_5_ruser           M_AXI4LITE_USR_5 AXI4   
add_port_map_axi  RVALID       m_axi_usr_5_rvalid          M_AXI4LITE_USR_5 1    
add_port_map_axi  RREADY       m_axi_usr_5_rready          M_AXI4LITE_USR_5 1    

add_port_map_axi  AWID         m_axi_usr_5_awid            M_AXI3_USR_5     AXI4  
add_port_map_axi  AWADDR       m_axi_usr_5_awaddr          M_AXI3_USR_5     1    
add_port_map_axi  AWLEN        m_axi_usr_5_awlen      M_AXI3_USR_5     AXI4   
add_port_map_axi  AWSIZE       m_axi_usr_5_awsize          M_AXI3_USR_5     AXI4    
add_port_map_axi  AWBURST      m_axi_usr_5_awburst         M_AXI3_USR_5     AXI4     
add_port_map_axi  AWLOCK       m_axi_usr_5_awlock     M_AXI3_USR_5     AXI4    
add_port_map_axi  AWCACHE      m_axi_usr_5_awcache         M_AXI3_USR_5     AXI4     
add_port_map_axi  AWPROT       m_axi_usr_5_awprot          M_AXI3_USR_5     1    
add_port_map_axi  AWQOS        m_axi_usr_5_awqos           M_AXI3_USR_5     AXI4   
add_port_map_axi  AWREGION     m_axi_usr_5_awregion        M_AXI3_USR_5     AXI4      
add_port_map_axi  AWUSER       m_axi_usr_5_awuser          M_AXI3_USR_5     AXI4    
add_port_map_axi  AWVALID      m_axi_usr_5_awvalid         M_AXI3_USR_5     1     
add_port_map_axi  AWREADY      m_axi_usr_5_awready         M_AXI3_USR_5     1     
add_port_map_axi  WDATA        m_axi_usr_5_wdata           M_AXI3_USR_5     1   
add_port_map_axi  WSTRB        m_axi_usr_5_wstrb           M_AXI3_USR_5     1  
add_port_map_axi  WID          m_axi_usr_5_wid             M_AXI3_USR_5     AXI3   
add_port_map_axi  WLAST        m_axi_usr_5_wlast           M_AXI3_USR_5     AXI4   
add_port_map_axi  WUSER        m_axi_usr_5_wuser           M_AXI3_USR_5     AXI4   
add_port_map_axi  WVALID       m_axi_usr_5_wvalid          M_AXI3_USR_5     1    
add_port_map_axi  WREADY       m_axi_usr_5_wready          M_AXI3_USR_5     1    
add_port_map_axi  BID          m_axi_usr_5_bid             M_AXI3_USR_5     AXI4 
add_port_map_axi  BRESP        m_axi_usr_5_bresp           M_AXI3_USR_5     1   
add_port_map_axi  BUSER        m_axi_usr_5_buser           M_AXI3_USR_5     AXI4   
add_port_map_axi  BVALID       m_axi_usr_5_bvalid          M_AXI3_USR_5     1    
add_port_map_axi  BREADY       m_axi_usr_5_bready          M_AXI3_USR_5     1    
add_port_map_axi  ARID         m_axi_usr_5_arid            M_AXI3_USR_5     AXI4  
add_port_map_axi  ARADDR       m_axi_usr_5_araddr          M_AXI3_USR_5     1    
add_port_map_axi  ARLEN        m_axi_usr_5_arlen      M_AXI3_USR_5     AXI4   
add_port_map_axi  ARSIZE       m_axi_usr_5_arsize          M_AXI3_USR_5     AXI4    
add_port_map_axi  ARBURST      m_axi_usr_5_arburst         M_AXI3_USR_5     AXI4     
add_port_map_axi  ARLOCK       m_axi_usr_5_arlock     M_AXI3_USR_5     AXI4    
add_port_map_axi  ARCACHE      m_axi_usr_5_arcache         M_AXI3_USR_5     AXI4     
add_port_map_axi  ARPROT       m_axi_usr_5_arprot          M_AXI3_USR_5     1    
add_port_map_axi  ARQOS        m_axi_usr_5_arqos           M_AXI3_USR_5     AXI4   
add_port_map_axi  ARREGION     m_axi_usr_5_arregion        M_AXI3_USR_5     AXI4      
add_port_map_axi  ARUSER       m_axi_usr_5_aruser          M_AXI3_USR_5     AXI4    
add_port_map_axi  ARVALID      m_axi_usr_5_arvalid         M_AXI3_USR_5     1     
add_port_map_axi  ARREADY      m_axi_usr_5_arready         M_AXI3_USR_5     1     
add_port_map_axi  RID          m_axi_usr_5_rid             M_AXI3_USR_5     AXI4 
add_port_map_axi  RDATA        m_axi_usr_5_rdata           M_AXI3_USR_5     1   
add_port_map_axi  RRESP        m_axi_usr_5_rresp           M_AXI3_USR_5     1   
add_port_map_axi  RLAST        m_axi_usr_5_rlast           M_AXI3_USR_5     AXI4   
add_port_map_axi  RUSER        m_axi_usr_5_ruser           M_AXI3_USR_5     AXI4   
add_port_map_axi  RVALID       m_axi_usr_5_rvalid          M_AXI3_USR_5     1    
add_port_map_axi  RREADY       m_axi_usr_5_rready          M_AXI3_USR_5     1    










add_port_map_axi  AWID         s_axi_usr_0_awid            S_AXI4_USR_0     AXI4  
add_port_map_axi  AWADDR       s_axi_usr_0_awaddr          S_AXI4_USR_0     1    
add_port_map_axi  AWLEN        s_axi_usr_0_awlen           S_AXI4_USR_0     AXI4   
add_port_map_axi  AWSIZE       s_axi_usr_0_awsize          S_AXI4_USR_0     AXI4    
add_port_map_axi  AWBURST      s_axi_usr_0_awburst         S_AXI4_USR_0     AXI4     
add_port_map_axi  AWLOCK       s_axi_usr_0_awlock          S_AXI4_USR_0     AXI4    
add_port_map_axi  AWCACHE      s_axi_usr_0_awcache         S_AXI4_USR_0     AXI4     
add_port_map_axi  AWPROT       s_axi_usr_0_awprot          S_AXI4_USR_0     1    
add_port_map_axi  AWQOS        s_axi_usr_0_awqos           S_AXI4_USR_0     AXI4   
add_port_map_axi  AWREGION     s_axi_usr_0_awregion        S_AXI4_USR_0     AXI4      
add_port_map_axi  AWUSER       s_axi_usr_0_awuser          S_AXI4_USR_0     AXI4    
add_port_map_axi  AWVALID      s_axi_usr_0_awvalid         S_AXI4_USR_0     1     
add_port_map_axi  AWREADY      s_axi_usr_0_awready         S_AXI4_USR_0     1     
add_port_map_axi  WDATA        s_axi_usr_0_wdata           S_AXI4_USR_0     1   
add_port_map_axi  WSTRB        s_axi_usr_0_wstrb           S_AXI4_USR_0     1  
add_port_map_axi  WID          s_axi_usr_0_wid             S_AXI4_USR_0     AXI3   
add_port_map_axi  WLAST        s_axi_usr_0_wlast           S_AXI4_USR_0     AXI4   
add_port_map_axi  WUSER        s_axi_usr_0_wuser           S_AXI4_USR_0     AXI4   
add_port_map_axi  WVALID       s_axi_usr_0_wvalid          S_AXI4_USR_0     1    
add_port_map_axi  WREADY       s_axi_usr_0_wready          S_AXI4_USR_0     1    
add_port_map_axi  BID          s_axi_usr_0_bid             S_AXI4_USR_0     AXI4 
add_port_map_axi  BRESP        s_axi_usr_0_bresp           S_AXI4_USR_0     1   
add_port_map_axi  BUSER        s_axi_usr_0_buser           S_AXI4_USR_0     AXI4   
add_port_map_axi  BVALID       s_axi_usr_0_bvalid          S_AXI4_USR_0     1    
add_port_map_axi  BREADY       s_axi_usr_0_bready          S_AXI4_USR_0     1    
add_port_map_axi  ARID         s_axi_usr_0_arid            S_AXI4_USR_0     AXI4  
add_port_map_axi  ARADDR       s_axi_usr_0_araddr          S_AXI4_USR_0     1    
add_port_map_axi  ARLEN        s_axi_usr_0_arlen           S_AXI4_USR_0     AXI4   
add_port_map_axi  ARSIZE       s_axi_usr_0_arsize          S_AXI4_USR_0     AXI4    
add_port_map_axi  ARBURST      s_axi_usr_0_arburst         S_AXI4_USR_0     AXI4     
add_port_map_axi  ARLOCK       s_axi_usr_0_arlock          S_AXI4_USR_0     AXI4    
add_port_map_axi  ARCACHE      s_axi_usr_0_arcache         S_AXI4_USR_0     AXI4     
add_port_map_axi  ARPROT       s_axi_usr_0_arprot          S_AXI4_USR_0     1    
add_port_map_axi  ARQOS        s_axi_usr_0_arqos           S_AXI4_USR_0     AXI4   
add_port_map_axi  ARREGION     s_axi_usr_0_arregion        S_AXI4_USR_0     AXI4      
add_port_map_axi  ARUSER       s_axi_usr_0_aruser          S_AXI4_USR_0     AXI4    
add_port_map_axi  ARVALID      s_axi_usr_0_arvalid         S_AXI4_USR_0     1     
add_port_map_axi  ARREADY      s_axi_usr_0_arready         S_AXI4_USR_0     1     
add_port_map_axi  RID          s_axi_usr_0_rid             S_AXI4_USR_0     AXI4 
add_port_map_axi  RDATA        s_axi_usr_0_rdata           S_AXI4_USR_0     1   
add_port_map_axi  RRESP        s_axi_usr_0_rresp           S_AXI4_USR_0     1   
add_port_map_axi  RLAST        s_axi_usr_0_rlast           S_AXI4_USR_0     AXI4   
add_port_map_axi  RUSER        s_axi_usr_0_ruser           S_AXI4_USR_0     AXI4   
add_port_map_axi  RVALID       s_axi_usr_0_rvalid          S_AXI4_USR_0     1    
add_port_map_axi  RREADY       s_axi_usr_0_rready          S_AXI4_USR_0     1    

add_port_map_axi  AWID         s_axi_usr_0_awid            S_AXI4LITE_USR_0 AXI4  
add_port_map_axi  AWADDR       s_axi_usr_0_awaddr          S_AXI4LITE_USR_0 1    
add_port_map_axi  AWLEN        s_axi_usr_0_awlen           S_AXI4LITE_USR_0 AXI4   
add_port_map_axi  AWSIZE       s_axi_usr_0_awsize          S_AXI4LITE_USR_0 AXI4    
add_port_map_axi  AWBURST      s_axi_usr_0_awburst         S_AXI4LITE_USR_0 AXI4     
add_port_map_axi  AWLOCK       s_axi_usr_0_awlock          S_AXI4LITE_USR_0 AXI4    
add_port_map_axi  AWCACHE      s_axi_usr_0_awcache         S_AXI4LITE_USR_0 AXI4     
add_port_map_axi  AWPROT       s_axi_usr_0_awprot          S_AXI4LITE_USR_0 1    
add_port_map_axi  AWQOS        s_axi_usr_0_awqos           S_AXI4LITE_USR_0 AXI4   
add_port_map_axi  AWREGION     s_axi_usr_0_awregion        S_AXI4LITE_USR_0 AXI4      
add_port_map_axi  AWUSER       s_axi_usr_0_awuser          S_AXI4LITE_USR_0 AXI4    
add_port_map_axi  AWVALID      s_axi_usr_0_awvalid         S_AXI4LITE_USR_0 1     
add_port_map_axi  AWREADY      s_axi_usr_0_awready         S_AXI4LITE_USR_0 1     
add_port_map_axi  WDATA        s_axi_usr_0_wdata           S_AXI4LITE_USR_0 1   
add_port_map_axi  WSTRB        s_axi_usr_0_wstrb           S_AXI4LITE_USR_0 1  
add_port_map_axi  WID          s_axi_usr_0_wid             S_AXI4LITE_USR_0 AXI3   
add_port_map_axi  WLAST        s_axi_usr_0_wlast           S_AXI4LITE_USR_0 AXI4   
add_port_map_axi  WUSER        s_axi_usr_0_wuser           S_AXI4LITE_USR_0 AXI4   
add_port_map_axi  WVALID       s_axi_usr_0_wvalid          S_AXI4LITE_USR_0 1    
add_port_map_axi  WREADY       s_axi_usr_0_wready          S_AXI4LITE_USR_0 1    
add_port_map_axi  BID          s_axi_usr_0_bid             S_AXI4LITE_USR_0 AXI4 
add_port_map_axi  BRESP        s_axi_usr_0_bresp           S_AXI4LITE_USR_0 1   
add_port_map_axi  BUSER        s_axi_usr_0_buser           S_AXI4LITE_USR_0 AXI4   
add_port_map_axi  BVALID       s_axi_usr_0_bvalid          S_AXI4LITE_USR_0 1    
add_port_map_axi  BREADY       s_axi_usr_0_bready          S_AXI4LITE_USR_0 1    
add_port_map_axi  ARID         s_axi_usr_0_arid            S_AXI4LITE_USR_0 AXI4  
add_port_map_axi  ARADDR       s_axi_usr_0_araddr          S_AXI4LITE_USR_0 1    
add_port_map_axi  ARLEN        s_axi_usr_0_arlen           S_AXI4LITE_USR_0 AXI4   
add_port_map_axi  ARSIZE       s_axi_usr_0_arsize          S_AXI4LITE_USR_0 AXI4    
add_port_map_axi  ARBURST      s_axi_usr_0_arburst         S_AXI4LITE_USR_0 AXI4     
add_port_map_axi  ARLOCK       s_axi_usr_0_arlock          S_AXI4LITE_USR_0 AXI4    
add_port_map_axi  ARCACHE      s_axi_usr_0_arcache         S_AXI4LITE_USR_0 AXI4     
add_port_map_axi  ARPROT       s_axi_usr_0_arprot          S_AXI4LITE_USR_0 1    
add_port_map_axi  ARQOS        s_axi_usr_0_arqos           S_AXI4LITE_USR_0 AXI4   
add_port_map_axi  ARREGION     s_axi_usr_0_arregion        S_AXI4LITE_USR_0 AXI4      
add_port_map_axi  ARUSER       s_axi_usr_0_aruser          S_AXI4LITE_USR_0 AXI4    
add_port_map_axi  ARVALID      s_axi_usr_0_arvalid         S_AXI4LITE_USR_0 1     
add_port_map_axi  ARREADY      s_axi_usr_0_arready         S_AXI4LITE_USR_0 1     
add_port_map_axi  RID          s_axi_usr_0_rid             S_AXI4LITE_USR_0 AXI4 
add_port_map_axi  RDATA        s_axi_usr_0_rdata           S_AXI4LITE_USR_0 1   
add_port_map_axi  RRESP        s_axi_usr_0_rresp           S_AXI4LITE_USR_0 1   
add_port_map_axi  RLAST        s_axi_usr_0_rlast           S_AXI4LITE_USR_0 AXI4   
add_port_map_axi  RUSER        s_axi_usr_0_ruser           S_AXI4LITE_USR_0 AXI4   
add_port_map_axi  RVALID       s_axi_usr_0_rvalid          S_AXI4LITE_USR_0 1    
add_port_map_axi  RREADY       s_axi_usr_0_rready          S_AXI4LITE_USR_0 1    

add_port_map_axi  AWID         s_axi_usr_0_awid            S_AXI3_USR_0     AXI4  
add_port_map_axi  AWADDR       s_axi_usr_0_awaddr          S_AXI3_USR_0     1    
add_port_map_axi  AWLEN        s_axi_usr_0_awlen           S_AXI3_USR_0     AXI4   
add_port_map_axi  AWSIZE       s_axi_usr_0_awsize          S_AXI3_USR_0     AXI4    
add_port_map_axi  AWBURST      s_axi_usr_0_awburst         S_AXI3_USR_0     AXI4     
add_port_map_axi  AWLOCK       s_axi_usr_0_awlock          S_AXI3_USR_0     AXI4    
add_port_map_axi  AWCACHE      s_axi_usr_0_awcache         S_AXI3_USR_0     AXI4     
add_port_map_axi  AWPROT       s_axi_usr_0_awprot          S_AXI3_USR_0     1    
add_port_map_axi  AWQOS        s_axi_usr_0_awqos           S_AXI3_USR_0     AXI4   
add_port_map_axi  AWREGION     s_axi_usr_0_awregion        S_AXI3_USR_0     AXI4      
add_port_map_axi  AWUSER       s_axi_usr_0_awuser          S_AXI3_USR_0     AXI4    
add_port_map_axi  AWVALID      s_axi_usr_0_awvalid         S_AXI3_USR_0     1     
add_port_map_axi  AWREADY      s_axi_usr_0_awready         S_AXI3_USR_0     1     
add_port_map_axi  WDATA        s_axi_usr_0_wdata           S_AXI3_USR_0     1   
add_port_map_axi  WSTRB        s_axi_usr_0_wstrb           S_AXI3_USR_0     1  
add_port_map_axi  WID          s_axi_usr_0_wid             S_AXI3_USR_0     AXI3   
add_port_map_axi  WLAST        s_axi_usr_0_wlast           S_AXI3_USR_0     AXI4   
add_port_map_axi  WUSER        s_axi_usr_0_wuser           S_AXI3_USR_0     AXI4   
add_port_map_axi  WVALID       s_axi_usr_0_wvalid          S_AXI3_USR_0     1    
add_port_map_axi  WREADY       s_axi_usr_0_wready          S_AXI3_USR_0     1    
add_port_map_axi  BID          s_axi_usr_0_bid             S_AXI3_USR_0     AXI4 
add_port_map_axi  BRESP        s_axi_usr_0_bresp           S_AXI3_USR_0     1   
add_port_map_axi  BUSER        s_axi_usr_0_buser           S_AXI3_USR_0     AXI4   
add_port_map_axi  BVALID       s_axi_usr_0_bvalid          S_AXI3_USR_0     1    
add_port_map_axi  BREADY       s_axi_usr_0_bready          S_AXI3_USR_0     1    
add_port_map_axi  ARID         s_axi_usr_0_arid            S_AXI3_USR_0     AXI4  
add_port_map_axi  ARADDR       s_axi_usr_0_araddr          S_AXI3_USR_0     1    
add_port_map_axi  ARLEN        s_axi_usr_0_arlen           S_AXI3_USR_0     AXI4   
add_port_map_axi  ARSIZE       s_axi_usr_0_arsize          S_AXI3_USR_0     AXI4    
add_port_map_axi  ARBURST      s_axi_usr_0_arburst         S_AXI3_USR_0     AXI4     
add_port_map_axi  ARLOCK       s_axi_usr_0_arlock          S_AXI3_USR_0     AXI4    
add_port_map_axi  ARCACHE      s_axi_usr_0_arcache         S_AXI3_USR_0     AXI4     
add_port_map_axi  ARPROT       s_axi_usr_0_arprot          S_AXI3_USR_0     1    
add_port_map_axi  ARQOS        s_axi_usr_0_arqos           S_AXI3_USR_0     AXI4   
add_port_map_axi  ARREGION     s_axi_usr_0_arregion        S_AXI3_USR_0     AXI4      
add_port_map_axi  ARUSER       s_axi_usr_0_aruser          S_AXI3_USR_0     AXI4    
add_port_map_axi  ARVALID      s_axi_usr_0_arvalid         S_AXI3_USR_0     1     
add_port_map_axi  ARREADY      s_axi_usr_0_arready         S_AXI3_USR_0     1     
add_port_map_axi  RID          s_axi_usr_0_rid             S_AXI3_USR_0     AXI4 
add_port_map_axi  RDATA        s_axi_usr_0_rdata           S_AXI3_USR_0     1   
add_port_map_axi  RRESP        s_axi_usr_0_rresp           S_AXI3_USR_0     1   
add_port_map_axi  RLAST        s_axi_usr_0_rlast           S_AXI3_USR_0     AXI4   
add_port_map_axi  RUSER        s_axi_usr_0_ruser           S_AXI3_USR_0     AXI4   
add_port_map_axi  RVALID       s_axi_usr_0_rvalid          S_AXI3_USR_0     1    
add_port_map_axi  RREADY       s_axi_usr_0_rready          S_AXI3_USR_0     1    

add_port_map_axi  AWID         s_axi_usr_1_awid            S_AXI4_USR_1     AXI4  
add_port_map_axi  AWADDR       s_axi_usr_1_awaddr          S_AXI4_USR_1     1    
add_port_map_axi  AWLEN        s_axi_usr_1_awlen           S_AXI4_USR_1     AXI4   
add_port_map_axi  AWSIZE       s_axi_usr_1_awsize          S_AXI4_USR_1     AXI4    
add_port_map_axi  AWBURST      s_axi_usr_1_awburst         S_AXI4_USR_1     AXI4     
add_port_map_axi  AWLOCK       s_axi_usr_1_awlock          S_AXI4_USR_1     AXI4    
add_port_map_axi  AWCACHE      s_axi_usr_1_awcache         S_AXI4_USR_1     AXI4     
add_port_map_axi  AWPROT       s_axi_usr_1_awprot          S_AXI4_USR_1     1    
add_port_map_axi  AWQOS        s_axi_usr_1_awqos           S_AXI4_USR_1     AXI4   
add_port_map_axi  AWREGION     s_axi_usr_1_awregion        S_AXI4_USR_1     AXI4      
add_port_map_axi  AWUSER       s_axi_usr_1_awuser          S_AXI4_USR_1     AXI4    
add_port_map_axi  AWVALID      s_axi_usr_1_awvalid         S_AXI4_USR_1     1     
add_port_map_axi  AWREADY      s_axi_usr_1_awready         S_AXI4_USR_1     1     
add_port_map_axi  WDATA        s_axi_usr_1_wdata           S_AXI4_USR_1     1   
add_port_map_axi  WSTRB        s_axi_usr_1_wstrb           S_AXI4_USR_1     1  
add_port_map_axi  WID          s_axi_usr_1_wid             S_AXI4_USR_1     AXI3   
add_port_map_axi  WLAST        s_axi_usr_1_wlast           S_AXI4_USR_1     AXI4   
add_port_map_axi  WUSER        s_axi_usr_1_wuser           S_AXI4_USR_1     AXI4   
add_port_map_axi  WVALID       s_axi_usr_1_wvalid          S_AXI4_USR_1     1    
add_port_map_axi  WREADY       s_axi_usr_1_wready          S_AXI4_USR_1     1    
add_port_map_axi  BID          s_axi_usr_1_bid             S_AXI4_USR_1     AXI4 
add_port_map_axi  BRESP        s_axi_usr_1_bresp           S_AXI4_USR_1     1   
add_port_map_axi  BUSER        s_axi_usr_1_buser           S_AXI4_USR_1     AXI4   
add_port_map_axi  BVALID       s_axi_usr_1_bvalid          S_AXI4_USR_1     1    
add_port_map_axi  BREADY       s_axi_usr_1_bready          S_AXI4_USR_1     1    
add_port_map_axi  ARID         s_axi_usr_1_arid            S_AXI4_USR_1     AXI4  
add_port_map_axi  ARADDR       s_axi_usr_1_araddr          S_AXI4_USR_1     1    
add_port_map_axi  ARLEN        s_axi_usr_1_arlen           S_AXI4_USR_1     AXI4   
add_port_map_axi  ARSIZE       s_axi_usr_1_arsize          S_AXI4_USR_1     AXI4    
add_port_map_axi  ARBURST      s_axi_usr_1_arburst         S_AXI4_USR_1     AXI4     
add_port_map_axi  ARLOCK       s_axi_usr_1_arlock          S_AXI4_USR_1     AXI4    
add_port_map_axi  ARCACHE      s_axi_usr_1_arcache         S_AXI4_USR_1     AXI4     
add_port_map_axi  ARPROT       s_axi_usr_1_arprot          S_AXI4_USR_1     1    
add_port_map_axi  ARQOS        s_axi_usr_1_arqos           S_AXI4_USR_1     AXI4   
add_port_map_axi  ARREGION     s_axi_usr_1_arregion        S_AXI4_USR_1     AXI4      
add_port_map_axi  ARUSER       s_axi_usr_1_aruser          S_AXI4_USR_1     AXI4    
add_port_map_axi  ARVALID      s_axi_usr_1_arvalid         S_AXI4_USR_1     1     
add_port_map_axi  ARREADY      s_axi_usr_1_arready         S_AXI4_USR_1     1     
add_port_map_axi  RID          s_axi_usr_1_rid             S_AXI4_USR_1     AXI4 
add_port_map_axi  RDATA        s_axi_usr_1_rdata           S_AXI4_USR_1     1   
add_port_map_axi  RRESP        s_axi_usr_1_rresp           S_AXI4_USR_1     1   
add_port_map_axi  RLAST        s_axi_usr_1_rlast           S_AXI4_USR_1     AXI4   
add_port_map_axi  RUSER        s_axi_usr_1_ruser           S_AXI4_USR_1     AXI4   
add_port_map_axi  RVALID       s_axi_usr_1_rvalid          S_AXI4_USR_1     1    
add_port_map_axi  RREADY       s_axi_usr_1_rready          S_AXI4_USR_1     1    

add_port_map_axi  AWID         s_axi_usr_1_awid            S_AXI4LITE_USR_1 AXI4  
add_port_map_axi  AWADDR       s_axi_usr_1_awaddr          S_AXI4LITE_USR_1 1    
add_port_map_axi  AWLEN        s_axi_usr_1_awlen           S_AXI4LITE_USR_1 AXI4   
add_port_map_axi  AWSIZE       s_axi_usr_1_awsize          S_AXI4LITE_USR_1 AXI4    
add_port_map_axi  AWBURST      s_axi_usr_1_awburst         S_AXI4LITE_USR_1 AXI4     
add_port_map_axi  AWLOCK       s_axi_usr_1_awlock          S_AXI4LITE_USR_1 AXI4    
add_port_map_axi  AWCACHE      s_axi_usr_1_awcache         S_AXI4LITE_USR_1 AXI4     
add_port_map_axi  AWPROT       s_axi_usr_1_awprot          S_AXI4LITE_USR_1 1    
add_port_map_axi  AWQOS        s_axi_usr_1_awqos           S_AXI4LITE_USR_1 AXI4   
add_port_map_axi  AWREGION     s_axi_usr_1_awregion        S_AXI4LITE_USR_1 AXI4      
add_port_map_axi  AWUSER       s_axi_usr_1_awuser          S_AXI4LITE_USR_1 AXI4    
add_port_map_axi  AWVALID      s_axi_usr_1_awvalid         S_AXI4LITE_USR_1 1     
add_port_map_axi  AWREADY      s_axi_usr_1_awready         S_AXI4LITE_USR_1 1     
add_port_map_axi  WDATA        s_axi_usr_1_wdata           S_AXI4LITE_USR_1 1   
add_port_map_axi  WSTRB        s_axi_usr_1_wstrb           S_AXI4LITE_USR_1 1  
add_port_map_axi  WID          s_axi_usr_1_wid             S_AXI4LITE_USR_1 AXI3   
add_port_map_axi  WLAST        s_axi_usr_1_wlast           S_AXI4LITE_USR_1 AXI4   
add_port_map_axi  WUSER        s_axi_usr_1_wuser           S_AXI4LITE_USR_1 AXI4   
add_port_map_axi  WVALID       s_axi_usr_1_wvalid          S_AXI4LITE_USR_1 1    
add_port_map_axi  WREADY       s_axi_usr_1_wready          S_AXI4LITE_USR_1 1    
add_port_map_axi  BID          s_axi_usr_1_bid             S_AXI4LITE_USR_1 AXI4 
add_port_map_axi  BRESP        s_axi_usr_1_bresp           S_AXI4LITE_USR_1 1   
add_port_map_axi  BUSER        s_axi_usr_1_buser           S_AXI4LITE_USR_1 AXI4   
add_port_map_axi  BVALID       s_axi_usr_1_bvalid          S_AXI4LITE_USR_1 1    
add_port_map_axi  BREADY       s_axi_usr_1_bready          S_AXI4LITE_USR_1 1    
add_port_map_axi  ARID         s_axi_usr_1_arid            S_AXI4LITE_USR_1 AXI4  
add_port_map_axi  ARADDR       s_axi_usr_1_araddr          S_AXI4LITE_USR_1 1    
add_port_map_axi  ARLEN        s_axi_usr_1_arlen           S_AXI4LITE_USR_1 AXI4   
add_port_map_axi  ARSIZE       s_axi_usr_1_arsize          S_AXI4LITE_USR_1 AXI4    
add_port_map_axi  ARBURST      s_axi_usr_1_arburst         S_AXI4LITE_USR_1 AXI4     
add_port_map_axi  ARLOCK       s_axi_usr_1_arlock          S_AXI4LITE_USR_1 AXI4    
add_port_map_axi  ARCACHE      s_axi_usr_1_arcache         S_AXI4LITE_USR_1 AXI4     
add_port_map_axi  ARPROT       s_axi_usr_1_arprot          S_AXI4LITE_USR_1 1    
add_port_map_axi  ARQOS        s_axi_usr_1_arqos           S_AXI4LITE_USR_1 AXI4   
add_port_map_axi  ARREGION     s_axi_usr_1_arregion        S_AXI4LITE_USR_1 AXI4      
add_port_map_axi  ARUSER       s_axi_usr_1_aruser          S_AXI4LITE_USR_1 AXI4    
add_port_map_axi  ARVALID      s_axi_usr_1_arvalid         S_AXI4LITE_USR_1 1     
add_port_map_axi  ARREADY      s_axi_usr_1_arready         S_AXI4LITE_USR_1 1     
add_port_map_axi  RID          s_axi_usr_1_rid             S_AXI4LITE_USR_1 AXI4 
add_port_map_axi  RDATA        s_axi_usr_1_rdata           S_AXI4LITE_USR_1 1   
add_port_map_axi  RRESP        s_axi_usr_1_rresp           S_AXI4LITE_USR_1 1   
add_port_map_axi  RLAST        s_axi_usr_1_rlast           S_AXI4LITE_USR_1 AXI4   
add_port_map_axi  RUSER        s_axi_usr_1_ruser           S_AXI4LITE_USR_1 AXI4   
add_port_map_axi  RVALID       s_axi_usr_1_rvalid          S_AXI4LITE_USR_1 1    
add_port_map_axi  RREADY       s_axi_usr_1_rready          S_AXI4LITE_USR_1 1    

add_port_map_axi  AWID         s_axi_usr_1_awid            S_AXI3_USR_1     AXI4  
add_port_map_axi  AWADDR       s_axi_usr_1_awaddr          S_AXI3_USR_1     1    
add_port_map_axi  AWLEN        s_axi_usr_1_awlen           S_AXI3_USR_1     AXI4   
add_port_map_axi  AWSIZE       s_axi_usr_1_awsize          S_AXI3_USR_1     AXI4    
add_port_map_axi  AWBURST      s_axi_usr_1_awburst         S_AXI3_USR_1     AXI4     
add_port_map_axi  AWLOCK       s_axi_usr_1_awlock          S_AXI3_USR_1     AXI4    
add_port_map_axi  AWCACHE      s_axi_usr_1_awcache         S_AXI3_USR_1     AXI4     
add_port_map_axi  AWPROT       s_axi_usr_1_awprot          S_AXI3_USR_1     1    
add_port_map_axi  AWQOS        s_axi_usr_1_awqos           S_AXI3_USR_1     AXI4   
add_port_map_axi  AWREGION     s_axi_usr_1_awregion        S_AXI3_USR_1     AXI4      
add_port_map_axi  AWUSER       s_axi_usr_1_awuser          S_AXI3_USR_1     AXI4    
add_port_map_axi  AWVALID      s_axi_usr_1_awvalid         S_AXI3_USR_1     1     
add_port_map_axi  AWREADY      s_axi_usr_1_awready         S_AXI3_USR_1     1     
add_port_map_axi  WDATA        s_axi_usr_1_wdata           S_AXI3_USR_1     1   
add_port_map_axi  WSTRB        s_axi_usr_1_wstrb           S_AXI3_USR_1     1  
add_port_map_axi  WID          s_axi_usr_1_wid             S_AXI3_USR_1     AXI3   
add_port_map_axi  WLAST        s_axi_usr_1_wlast           S_AXI3_USR_1     AXI4   
add_port_map_axi  WUSER        s_axi_usr_1_wuser           S_AXI3_USR_1     AXI4   
add_port_map_axi  WVALID       s_axi_usr_1_wvalid          S_AXI3_USR_1     1    
add_port_map_axi  WREADY       s_axi_usr_1_wready          S_AXI3_USR_1     1    
add_port_map_axi  BID          s_axi_usr_1_bid             S_AXI3_USR_1     AXI4 
add_port_map_axi  BRESP        s_axi_usr_1_bresp           S_AXI3_USR_1     1   
add_port_map_axi  BUSER        s_axi_usr_1_buser           S_AXI3_USR_1     AXI4   
add_port_map_axi  BVALID       s_axi_usr_1_bvalid          S_AXI3_USR_1     1    
add_port_map_axi  BREADY       s_axi_usr_1_bready          S_AXI3_USR_1     1    
add_port_map_axi  ARID         s_axi_usr_1_arid            S_AXI3_USR_1     AXI4  
add_port_map_axi  ARADDR       s_axi_usr_1_araddr          S_AXI3_USR_1     1    
add_port_map_axi  ARLEN        s_axi_usr_1_arlen           S_AXI3_USR_1     AXI4   
add_port_map_axi  ARSIZE       s_axi_usr_1_arsize          S_AXI3_USR_1     AXI4    
add_port_map_axi  ARBURST      s_axi_usr_1_arburst         S_AXI3_USR_1     AXI4     
add_port_map_axi  ARLOCK       s_axi_usr_1_arlock          S_AXI3_USR_1     AXI4    
add_port_map_axi  ARCACHE      s_axi_usr_1_arcache         S_AXI3_USR_1     AXI4     
add_port_map_axi  ARPROT       s_axi_usr_1_arprot          S_AXI3_USR_1     1    
add_port_map_axi  ARQOS        s_axi_usr_1_arqos           S_AXI3_USR_1     AXI4   
add_port_map_axi  ARREGION     s_axi_usr_1_arregion        S_AXI3_USR_1     AXI4      
add_port_map_axi  ARUSER       s_axi_usr_1_aruser          S_AXI3_USR_1     AXI4    
add_port_map_axi  ARVALID      s_axi_usr_1_arvalid         S_AXI3_USR_1     1     
add_port_map_axi  ARREADY      s_axi_usr_1_arready         S_AXI3_USR_1     1     
add_port_map_axi  RID          s_axi_usr_1_rid             S_AXI3_USR_1     AXI4 
add_port_map_axi  RDATA        s_axi_usr_1_rdata           S_AXI3_USR_1     1   
add_port_map_axi  RRESP        s_axi_usr_1_rresp           S_AXI3_USR_1     1   
add_port_map_axi  RLAST        s_axi_usr_1_rlast           S_AXI3_USR_1     AXI4   
add_port_map_axi  RUSER        s_axi_usr_1_ruser           S_AXI3_USR_1     AXI4   
add_port_map_axi  RVALID       s_axi_usr_1_rvalid          S_AXI3_USR_1     1    
add_port_map_axi  RREADY       s_axi_usr_1_rready          S_AXI3_USR_1     1    


add_port_map_axi  AWID         s_axi_usr_2_awid            S_AXI4_USR_2     AXI4  
add_port_map_axi  AWADDR       s_axi_usr_2_awaddr          S_AXI4_USR_2     1    
add_port_map_axi  AWLEN        s_axi_usr_2_awlen           S_AXI4_USR_2     AXI4   
add_port_map_axi  AWSIZE       s_axi_usr_2_awsize          S_AXI4_USR_2     AXI4    
add_port_map_axi  AWBURST      s_axi_usr_2_awburst         S_AXI4_USR_2     AXI4     
add_port_map_axi  AWLOCK       s_axi_usr_2_awlock          S_AXI4_USR_2     AXI4    
add_port_map_axi  AWCACHE      s_axi_usr_2_awcache         S_AXI4_USR_2     AXI4     
add_port_map_axi  AWPROT       s_axi_usr_2_awprot          S_AXI4_USR_2     1    
add_port_map_axi  AWQOS        s_axi_usr_2_awqos           S_AXI4_USR_2     AXI4   
add_port_map_axi  AWREGION     s_axi_usr_2_awregion        S_AXI4_USR_2     AXI4      
add_port_map_axi  AWUSER       s_axi_usr_2_awuser          S_AXI4_USR_2     AXI4    
add_port_map_axi  AWVALID      s_axi_usr_2_awvalid         S_AXI4_USR_2     1     
add_port_map_axi  AWREADY      s_axi_usr_2_awready         S_AXI4_USR_2     1     
add_port_map_axi  WDATA        s_axi_usr_2_wdata           S_AXI4_USR_2     1   
add_port_map_axi  WSTRB        s_axi_usr_2_wstrb           S_AXI4_USR_2     1  
add_port_map_axi  WID          s_axi_usr_2_wid             S_AXI4_USR_2     AXI3   
add_port_map_axi  WLAST        s_axi_usr_2_wlast           S_AXI4_USR_2     AXI4   
add_port_map_axi  WUSER        s_axi_usr_2_wuser           S_AXI4_USR_2     AXI4   
add_port_map_axi  WVALID       s_axi_usr_2_wvalid          S_AXI4_USR_2     1    
add_port_map_axi  WREADY       s_axi_usr_2_wready          S_AXI4_USR_2     1    
add_port_map_axi  BID          s_axi_usr_2_bid             S_AXI4_USR_2     AXI4 
add_port_map_axi  BRESP        s_axi_usr_2_bresp           S_AXI4_USR_2     1   
add_port_map_axi  BUSER        s_axi_usr_2_buser           S_AXI4_USR_2     AXI4   
add_port_map_axi  BVALID       s_axi_usr_2_bvalid          S_AXI4_USR_2     1    
add_port_map_axi  BREADY       s_axi_usr_2_bready          S_AXI4_USR_2     1    
add_port_map_axi  ARID         s_axi_usr_2_arid            S_AXI4_USR_2     AXI4  
add_port_map_axi  ARADDR       s_axi_usr_2_araddr          S_AXI4_USR_2     1    
add_port_map_axi  ARLEN        s_axi_usr_2_arlen           S_AXI4_USR_2     AXI4   
add_port_map_axi  ARSIZE       s_axi_usr_2_arsize          S_AXI4_USR_2     AXI4    
add_port_map_axi  ARBURST      s_axi_usr_2_arburst         S_AXI4_USR_2     AXI4     
add_port_map_axi  ARLOCK       s_axi_usr_2_arlock          S_AXI4_USR_2     AXI4    
add_port_map_axi  ARCACHE      s_axi_usr_2_arcache         S_AXI4_USR_2     AXI4     
add_port_map_axi  ARPROT       s_axi_usr_2_arprot          S_AXI4_USR_2     1    
add_port_map_axi  ARQOS        s_axi_usr_2_arqos           S_AXI4_USR_2     AXI4   
add_port_map_axi  ARREGION     s_axi_usr_2_arregion        S_AXI4_USR_2     AXI4      
add_port_map_axi  ARUSER       s_axi_usr_2_aruser          S_AXI4_USR_2     AXI4    
add_port_map_axi  ARVALID      s_axi_usr_2_arvalid         S_AXI4_USR_2     1     
add_port_map_axi  ARREADY      s_axi_usr_2_arready         S_AXI4_USR_2     1     
add_port_map_axi  RID          s_axi_usr_2_rid             S_AXI4_USR_2     AXI4 
add_port_map_axi  RDATA        s_axi_usr_2_rdata           S_AXI4_USR_2     1   
add_port_map_axi  RRESP        s_axi_usr_2_rresp           S_AXI4_USR_2     1   
add_port_map_axi  RLAST        s_axi_usr_2_rlast           S_AXI4_USR_2     AXI4   
add_port_map_axi  RUSER        s_axi_usr_2_ruser           S_AXI4_USR_2     AXI4   
add_port_map_axi  RVALID       s_axi_usr_2_rvalid          S_AXI4_USR_2     1    
add_port_map_axi  RREADY       s_axi_usr_2_rready          S_AXI4_USR_2     1    

add_port_map_axi  AWID         s_axi_usr_2_awid            S_AXI4LITE_USR_2 AXI4  
add_port_map_axi  AWADDR       s_axi_usr_2_awaddr          S_AXI4LITE_USR_2 1    
add_port_map_axi  AWLEN        s_axi_usr_2_awlen           S_AXI4LITE_USR_2 AXI4   
add_port_map_axi  AWSIZE       s_axi_usr_2_awsize          S_AXI4LITE_USR_2 AXI4    
add_port_map_axi  AWBURST      s_axi_usr_2_awburst         S_AXI4LITE_USR_2 AXI4     
add_port_map_axi  AWLOCK       s_axi_usr_2_awlock          S_AXI4LITE_USR_2 AXI4    
add_port_map_axi  AWCACHE      s_axi_usr_2_awcache         S_AXI4LITE_USR_2 AXI4     
add_port_map_axi  AWPROT       s_axi_usr_2_awprot          S_AXI4LITE_USR_2 1    
add_port_map_axi  AWQOS        s_axi_usr_2_awqos           S_AXI4LITE_USR_2 AXI4   
add_port_map_axi  AWREGION     s_axi_usr_2_awregion        S_AXI4LITE_USR_2 AXI4      
add_port_map_axi  AWUSER       s_axi_usr_2_awuser          S_AXI4LITE_USR_2 AXI4    
add_port_map_axi  AWVALID      s_axi_usr_2_awvalid         S_AXI4LITE_USR_2 1     
add_port_map_axi  AWREADY      s_axi_usr_2_awready         S_AXI4LITE_USR_2 1     
add_port_map_axi  WDATA        s_axi_usr_2_wdata           S_AXI4LITE_USR_2 1   
add_port_map_axi  WSTRB        s_axi_usr_2_wstrb           S_AXI4LITE_USR_2 1  
add_port_map_axi  WID          s_axi_usr_2_wid             S_AXI4LITE_USR_2 AXI3   
add_port_map_axi  WLAST        s_axi_usr_2_wlast           S_AXI4LITE_USR_2 AXI4   
add_port_map_axi  WUSER        s_axi_usr_2_wuser           S_AXI4LITE_USR_2 AXI4   
add_port_map_axi  WVALID       s_axi_usr_2_wvalid          S_AXI4LITE_USR_2 1    
add_port_map_axi  WREADY       s_axi_usr_2_wready          S_AXI4LITE_USR_2 1    
add_port_map_axi  BID          s_axi_usr_2_bid             S_AXI4LITE_USR_2 AXI4 
add_port_map_axi  BRESP        s_axi_usr_2_bresp           S_AXI4LITE_USR_2 1   
add_port_map_axi  BUSER        s_axi_usr_2_buser           S_AXI4LITE_USR_2 AXI4   
add_port_map_axi  BVALID       s_axi_usr_2_bvalid          S_AXI4LITE_USR_2 1    
add_port_map_axi  BREADY       s_axi_usr_2_bready          S_AXI4LITE_USR_2 1    
add_port_map_axi  ARID         s_axi_usr_2_arid            S_AXI4LITE_USR_2 AXI4  
add_port_map_axi  ARADDR       s_axi_usr_2_araddr          S_AXI4LITE_USR_2 1    
add_port_map_axi  ARLEN        s_axi_usr_2_arlen           S_AXI4LITE_USR_2 AXI4   
add_port_map_axi  ARSIZE       s_axi_usr_2_arsize          S_AXI4LITE_USR_2 AXI4    
add_port_map_axi  ARBURST      s_axi_usr_2_arburst         S_AXI4LITE_USR_2 AXI4     
add_port_map_axi  ARLOCK       s_axi_usr_2_arlock          S_AXI4LITE_USR_2 AXI4    
add_port_map_axi  ARCACHE      s_axi_usr_2_arcache         S_AXI4LITE_USR_2 AXI4     
add_port_map_axi  ARPROT       s_axi_usr_2_arprot          S_AXI4LITE_USR_2 1    
add_port_map_axi  ARQOS        s_axi_usr_2_arqos           S_AXI4LITE_USR_2 AXI4   
add_port_map_axi  ARREGION     s_axi_usr_2_arregion        S_AXI4LITE_USR_2 AXI4      
add_port_map_axi  ARUSER       s_axi_usr_2_aruser          S_AXI4LITE_USR_2 AXI4    
add_port_map_axi  ARVALID      s_axi_usr_2_arvalid         S_AXI4LITE_USR_2 1     
add_port_map_axi  ARREADY      s_axi_usr_2_arready         S_AXI4LITE_USR_2 1     
add_port_map_axi  RID          s_axi_usr_2_rid             S_AXI4LITE_USR_2 AXI4 
add_port_map_axi  RDATA        s_axi_usr_2_rdata           S_AXI4LITE_USR_2 1   
add_port_map_axi  RRESP        s_axi_usr_2_rresp           S_AXI4LITE_USR_2 1   
add_port_map_axi  RLAST        s_axi_usr_2_rlast           S_AXI4LITE_USR_2 AXI4   
add_port_map_axi  RUSER        s_axi_usr_2_ruser           S_AXI4LITE_USR_2 AXI4   
add_port_map_axi  RVALID       s_axi_usr_2_rvalid          S_AXI4LITE_USR_2 1    
add_port_map_axi  RREADY       s_axi_usr_2_rready          S_AXI4LITE_USR_2 1    

add_port_map_axi  AWID         s_axi_usr_2_awid            S_AXI3_USR_2     AXI4  
add_port_map_axi  AWADDR       s_axi_usr_2_awaddr          S_AXI3_USR_2     1    
add_port_map_axi  AWLEN        s_axi_usr_2_awlen           S_AXI3_USR_2     AXI4   
add_port_map_axi  AWSIZE       s_axi_usr_2_awsize          S_AXI3_USR_2     AXI4    
add_port_map_axi  AWBURST      s_axi_usr_2_awburst         S_AXI3_USR_2     AXI4     
add_port_map_axi  AWLOCK       s_axi_usr_2_awlock          S_AXI3_USR_2     AXI4    
add_port_map_axi  AWCACHE      s_axi_usr_2_awcache         S_AXI3_USR_2     AXI4     
add_port_map_axi  AWPROT       s_axi_usr_2_awprot          S_AXI3_USR_2     1    
add_port_map_axi  AWQOS        s_axi_usr_2_awqos           S_AXI3_USR_2     AXI4   
add_port_map_axi  AWREGION     s_axi_usr_2_awregion        S_AXI3_USR_2     AXI4      
add_port_map_axi  AWUSER       s_axi_usr_2_awuser          S_AXI3_USR_2     AXI4    
add_port_map_axi  AWVALID      s_axi_usr_2_awvalid         S_AXI3_USR_2     1     
add_port_map_axi  AWREADY      s_axi_usr_2_awready         S_AXI3_USR_2     1     
add_port_map_axi  WDATA        s_axi_usr_2_wdata           S_AXI3_USR_2     1   
add_port_map_axi  WSTRB        s_axi_usr_2_wstrb           S_AXI3_USR_2     1  
add_port_map_axi  WID          s_axi_usr_2_wid             S_AXI3_USR_2     AXI3   
add_port_map_axi  WLAST        s_axi_usr_2_wlast           S_AXI3_USR_2     AXI4   
add_port_map_axi  WUSER        s_axi_usr_2_wuser           S_AXI3_USR_2     AXI4   
add_port_map_axi  WVALID       s_axi_usr_2_wvalid          S_AXI3_USR_2     1    
add_port_map_axi  WREADY       s_axi_usr_2_wready          S_AXI3_USR_2     1    
add_port_map_axi  BID          s_axi_usr_2_bid             S_AXI3_USR_2     AXI4 
add_port_map_axi  BRESP        s_axi_usr_2_bresp           S_AXI3_USR_2     1   
add_port_map_axi  BUSER        s_axi_usr_2_buser           S_AXI3_USR_2     AXI4   
add_port_map_axi  BVALID       s_axi_usr_2_bvalid          S_AXI3_USR_2     1    
add_port_map_axi  BREADY       s_axi_usr_2_bready          S_AXI3_USR_2     1    
add_port_map_axi  ARID         s_axi_usr_2_arid            S_AXI3_USR_2     AXI4  
add_port_map_axi  ARADDR       s_axi_usr_2_araddr          S_AXI3_USR_2     1    
add_port_map_axi  ARLEN        s_axi_usr_2_arlen           S_AXI3_USR_2     AXI4   
add_port_map_axi  ARSIZE       s_axi_usr_2_arsize          S_AXI3_USR_2     AXI4    
add_port_map_axi  ARBURST      s_axi_usr_2_arburst         S_AXI3_USR_2     AXI4     
add_port_map_axi  ARLOCK       s_axi_usr_2_arlock          S_AXI3_USR_2     AXI4    
add_port_map_axi  ARCACHE      s_axi_usr_2_arcache         S_AXI3_USR_2     AXI4     
add_port_map_axi  ARPROT       s_axi_usr_2_arprot          S_AXI3_USR_2     1    
add_port_map_axi  ARQOS        s_axi_usr_2_arqos           S_AXI3_USR_2     AXI4   
add_port_map_axi  ARREGION     s_axi_usr_2_arregion        S_AXI3_USR_2     AXI4      
add_port_map_axi  ARUSER       s_axi_usr_2_aruser          S_AXI3_USR_2     AXI4    
add_port_map_axi  ARVALID      s_axi_usr_2_arvalid         S_AXI3_USR_2     1     
add_port_map_axi  ARREADY      s_axi_usr_2_arready         S_AXI3_USR_2     1     
add_port_map_axi  RID          s_axi_usr_2_rid             S_AXI3_USR_2     AXI4 
add_port_map_axi  RDATA        s_axi_usr_2_rdata           S_AXI3_USR_2     1   
add_port_map_axi  RRESP        s_axi_usr_2_rresp           S_AXI3_USR_2     1   
add_port_map_axi  RLAST        s_axi_usr_2_rlast           S_AXI3_USR_2     AXI4   
add_port_map_axi  RUSER        s_axi_usr_2_ruser           S_AXI3_USR_2     AXI4   
add_port_map_axi  RVALID       s_axi_usr_2_rvalid          S_AXI3_USR_2     1    
add_port_map_axi  RREADY       s_axi_usr_2_rready          S_AXI3_USR_2     1    



add_port_map_axi  AWID         s_axi_usr_3_awid            S_AXI4_USR_3     AXI4  
add_port_map_axi  AWADDR       s_axi_usr_3_awaddr          S_AXI4_USR_3     1    
add_port_map_axi  AWLEN        s_axi_usr_3_awlen           S_AXI4_USR_3     AXI4   
add_port_map_axi  AWSIZE       s_axi_usr_3_awsize          S_AXI4_USR_3     AXI4    
add_port_map_axi  AWBURST      s_axi_usr_3_awburst         S_AXI4_USR_3     AXI4     
add_port_map_axi  AWLOCK       s_axi_usr_3_awlock          S_AXI4_USR_3     AXI4    
add_port_map_axi  AWCACHE      s_axi_usr_3_awcache         S_AXI4_USR_3     AXI4     
add_port_map_axi  AWPROT       s_axi_usr_3_awprot          S_AXI4_USR_3     1    
add_port_map_axi  AWQOS        s_axi_usr_3_awqos           S_AXI4_USR_3     AXI4   
add_port_map_axi  AWREGION     s_axi_usr_3_awregion        S_AXI4_USR_3     AXI4      
add_port_map_axi  AWUSER       s_axi_usr_3_awuser          S_AXI4_USR_3     AXI4    
add_port_map_axi  AWVALID      s_axi_usr_3_awvalid         S_AXI4_USR_3     1     
add_port_map_axi  AWREADY      s_axi_usr_3_awready         S_AXI4_USR_3     1     
add_port_map_axi  WDATA        s_axi_usr_3_wdata           S_AXI4_USR_3     1   
add_port_map_axi  WSTRB        s_axi_usr_3_wstrb           S_AXI4_USR_3     1  
add_port_map_axi  WID          s_axi_usr_3_wid             S_AXI4_USR_3     AXI3   
add_port_map_axi  WLAST        s_axi_usr_3_wlast           S_AXI4_USR_3     AXI4   
add_port_map_axi  WUSER        s_axi_usr_3_wuser           S_AXI4_USR_3     AXI4   
add_port_map_axi  WVALID       s_axi_usr_3_wvalid          S_AXI4_USR_3     1    
add_port_map_axi  WREADY       s_axi_usr_3_wready          S_AXI4_USR_3     1    
add_port_map_axi  BID          s_axi_usr_3_bid             S_AXI4_USR_3     AXI4 
add_port_map_axi  BRESP        s_axi_usr_3_bresp           S_AXI4_USR_3     1   
add_port_map_axi  BUSER        s_axi_usr_3_buser           S_AXI4_USR_3     AXI4   
add_port_map_axi  BVALID       s_axi_usr_3_bvalid          S_AXI4_USR_3     1    
add_port_map_axi  BREADY       s_axi_usr_3_bready          S_AXI4_USR_3     1    
add_port_map_axi  ARID         s_axi_usr_3_arid            S_AXI4_USR_3     AXI4  
add_port_map_axi  ARADDR       s_axi_usr_3_araddr          S_AXI4_USR_3     1    
add_port_map_axi  ARLEN        s_axi_usr_3_arlen           S_AXI4_USR_3     AXI4   
add_port_map_axi  ARSIZE       s_axi_usr_3_arsize          S_AXI4_USR_3     AXI4    
add_port_map_axi  ARBURST      s_axi_usr_3_arburst         S_AXI4_USR_3     AXI4     
add_port_map_axi  ARLOCK       s_axi_usr_3_arlock          S_AXI4_USR_3     AXI4    
add_port_map_axi  ARCACHE      s_axi_usr_3_arcache         S_AXI4_USR_3     AXI4     
add_port_map_axi  ARPROT       s_axi_usr_3_arprot          S_AXI4_USR_3     1    
add_port_map_axi  ARQOS        s_axi_usr_3_arqos           S_AXI4_USR_3     AXI4   
add_port_map_axi  ARREGION     s_axi_usr_3_arregion        S_AXI4_USR_3     AXI4      
add_port_map_axi  ARUSER       s_axi_usr_3_aruser          S_AXI4_USR_3     AXI4    
add_port_map_axi  ARVALID      s_axi_usr_3_arvalid         S_AXI4_USR_3     1     
add_port_map_axi  ARREADY      s_axi_usr_3_arready         S_AXI4_USR_3     1     
add_port_map_axi  RID          s_axi_usr_3_rid             S_AXI4_USR_3     AXI4 
add_port_map_axi  RDATA        s_axi_usr_3_rdata           S_AXI4_USR_3     1   
add_port_map_axi  RRESP        s_axi_usr_3_rresp           S_AXI4_USR_3     1   
add_port_map_axi  RLAST        s_axi_usr_3_rlast           S_AXI4_USR_3     AXI4   
add_port_map_axi  RUSER        s_axi_usr_3_ruser           S_AXI4_USR_3     AXI4   
add_port_map_axi  RVALID       s_axi_usr_3_rvalid          S_AXI4_USR_3     1    
add_port_map_axi  RREADY       s_axi_usr_3_rready          S_AXI4_USR_3     1    

add_port_map_axi  AWID         s_axi_usr_3_awid            S_AXI4LITE_USR_3 AXI4  
add_port_map_axi  AWADDR       s_axi_usr_3_awaddr          S_AXI4LITE_USR_3 1    
add_port_map_axi  AWLEN        s_axi_usr_3_awlen           S_AXI4LITE_USR_3 AXI4   
add_port_map_axi  AWSIZE       s_axi_usr_3_awsize          S_AXI4LITE_USR_3 AXI4    
add_port_map_axi  AWBURST      s_axi_usr_3_awburst         S_AXI4LITE_USR_3 AXI4     
add_port_map_axi  AWLOCK       s_axi_usr_3_awlock          S_AXI4LITE_USR_3 AXI4    
add_port_map_axi  AWCACHE      s_axi_usr_3_awcache         S_AXI4LITE_USR_3 AXI4     
add_port_map_axi  AWPROT       s_axi_usr_3_awprot          S_AXI4LITE_USR_3 1    
add_port_map_axi  AWQOS        s_axi_usr_3_awqos           S_AXI4LITE_USR_3 AXI4   
add_port_map_axi  AWREGION     s_axi_usr_3_awregion        S_AXI4LITE_USR_3 AXI4      
add_port_map_axi  AWUSER       s_axi_usr_3_awuser          S_AXI4LITE_USR_3 AXI4    
add_port_map_axi  AWVALID      s_axi_usr_3_awvalid         S_AXI4LITE_USR_3 1     
add_port_map_axi  AWREADY      s_axi_usr_3_awready         S_AXI4LITE_USR_3 1     
add_port_map_axi  WDATA        s_axi_usr_3_wdata           S_AXI4LITE_USR_3 1   
add_port_map_axi  WSTRB        s_axi_usr_3_wstrb           S_AXI4LITE_USR_3 1  
add_port_map_axi  WID          s_axi_usr_3_wid             S_AXI4LITE_USR_3 AXI3   
add_port_map_axi  WLAST        s_axi_usr_3_wlast           S_AXI4LITE_USR_3 AXI4   
add_port_map_axi  WUSER        s_axi_usr_3_wuser           S_AXI4LITE_USR_3 AXI4   
add_port_map_axi  WVALID       s_axi_usr_3_wvalid          S_AXI4LITE_USR_3 1    
add_port_map_axi  WREADY       s_axi_usr_3_wready          S_AXI4LITE_USR_3 1    
add_port_map_axi  BID          s_axi_usr_3_bid             S_AXI4LITE_USR_3 AXI4 
add_port_map_axi  BRESP        s_axi_usr_3_bresp           S_AXI4LITE_USR_3 1   
add_port_map_axi  BUSER        s_axi_usr_3_buser           S_AXI4LITE_USR_3 AXI4   
add_port_map_axi  BVALID       s_axi_usr_3_bvalid          S_AXI4LITE_USR_3 1    
add_port_map_axi  BREADY       s_axi_usr_3_bready          S_AXI4LITE_USR_3 1    
add_port_map_axi  ARID         s_axi_usr_3_arid            S_AXI4LITE_USR_3 AXI4  
add_port_map_axi  ARADDR       s_axi_usr_3_araddr          S_AXI4LITE_USR_3 1    
add_port_map_axi  ARLEN        s_axi_usr_3_arlen           S_AXI4LITE_USR_3 AXI4   
add_port_map_axi  ARSIZE       s_axi_usr_3_arsize          S_AXI4LITE_USR_3 AXI4    
add_port_map_axi  ARBURST      s_axi_usr_3_arburst         S_AXI4LITE_USR_3 AXI4     
add_port_map_axi  ARLOCK       s_axi_usr_3_arlock          S_AXI4LITE_USR_3 AXI4    
add_port_map_axi  ARCACHE      s_axi_usr_3_arcache         S_AXI4LITE_USR_3 AXI4     
add_port_map_axi  ARPROT       s_axi_usr_3_arprot          S_AXI4LITE_USR_3 1    
add_port_map_axi  ARQOS        s_axi_usr_3_arqos           S_AXI4LITE_USR_3 AXI4   
add_port_map_axi  ARREGION     s_axi_usr_3_arregion        S_AXI4LITE_USR_3 AXI4      
add_port_map_axi  ARUSER       s_axi_usr_3_aruser          S_AXI4LITE_USR_3 AXI4    
add_port_map_axi  ARVALID      s_axi_usr_3_arvalid         S_AXI4LITE_USR_3 1     
add_port_map_axi  ARREADY      s_axi_usr_3_arready         S_AXI4LITE_USR_3 1     
add_port_map_axi  RID          s_axi_usr_3_rid             S_AXI4LITE_USR_3 AXI4 
add_port_map_axi  RDATA        s_axi_usr_3_rdata           S_AXI4LITE_USR_3 1   
add_port_map_axi  RRESP        s_axi_usr_3_rresp           S_AXI4LITE_USR_3 1   
add_port_map_axi  RLAST        s_axi_usr_3_rlast           S_AXI4LITE_USR_3 AXI4   
add_port_map_axi  RUSER        s_axi_usr_3_ruser           S_AXI4LITE_USR_3 AXI4   
add_port_map_axi  RVALID       s_axi_usr_3_rvalid          S_AXI4LITE_USR_3 1    
add_port_map_axi  RREADY       s_axi_usr_3_rready          S_AXI4LITE_USR_3 1    

add_port_map_axi  AWID         s_axi_usr_3_awid            S_AXI3_USR_3     AXI4  
add_port_map_axi  AWADDR       s_axi_usr_3_awaddr          S_AXI3_USR_3     1    
add_port_map_axi  AWLEN        s_axi_usr_3_awlen           S_AXI3_USR_3     AXI4   
add_port_map_axi  AWSIZE       s_axi_usr_3_awsize          S_AXI3_USR_3     AXI4    
add_port_map_axi  AWBURST      s_axi_usr_3_awburst         S_AXI3_USR_3     AXI4     
add_port_map_axi  AWLOCK       s_axi_usr_3_awlock          S_AXI3_USR_3     AXI4    
add_port_map_axi  AWCACHE      s_axi_usr_3_awcache         S_AXI3_USR_3     AXI4     
add_port_map_axi  AWPROT       s_axi_usr_3_awprot          S_AXI3_USR_3     1    
add_port_map_axi  AWQOS        s_axi_usr_3_awqos           S_AXI3_USR_3     AXI4   
add_port_map_axi  AWREGION     s_axi_usr_3_awregion        S_AXI3_USR_3     AXI4      
add_port_map_axi  AWUSER       s_axi_usr_3_awuser          S_AXI3_USR_3     AXI4    
add_port_map_axi  AWVALID      s_axi_usr_3_awvalid         S_AXI3_USR_3     1     
add_port_map_axi  AWREADY      s_axi_usr_3_awready         S_AXI3_USR_3     1     
add_port_map_axi  WDATA        s_axi_usr_3_wdata           S_AXI3_USR_3     1   
add_port_map_axi  WSTRB        s_axi_usr_3_wstrb           S_AXI3_USR_3     1  
add_port_map_axi  WID          s_axi_usr_3_wid             S_AXI3_USR_3     AXI3   
add_port_map_axi  WLAST        s_axi_usr_3_wlast           S_AXI3_USR_3     AXI4   
add_port_map_axi  WUSER        s_axi_usr_3_wuser           S_AXI3_USR_3     AXI4   
add_port_map_axi  WVALID       s_axi_usr_3_wvalid          S_AXI3_USR_3     1    
add_port_map_axi  WREADY       s_axi_usr_3_wready          S_AXI3_USR_3     1    
add_port_map_axi  BID          s_axi_usr_3_bid             S_AXI3_USR_3     AXI4 
add_port_map_axi  BRESP        s_axi_usr_3_bresp           S_AXI3_USR_3     1   
add_port_map_axi  BUSER        s_axi_usr_3_buser           S_AXI3_USR_3     AXI4   
add_port_map_axi  BVALID       s_axi_usr_3_bvalid          S_AXI3_USR_3     1    
add_port_map_axi  BREADY       s_axi_usr_3_bready          S_AXI3_USR_3     1    
add_port_map_axi  ARID         s_axi_usr_3_arid            S_AXI3_USR_3     AXI4  
add_port_map_axi  ARADDR       s_axi_usr_3_araddr          S_AXI3_USR_3     1    
add_port_map_axi  ARLEN        s_axi_usr_3_arlen           S_AXI3_USR_3     AXI4   
add_port_map_axi  ARSIZE       s_axi_usr_3_arsize          S_AXI3_USR_3     AXI4    
add_port_map_axi  ARBURST      s_axi_usr_3_arburst         S_AXI3_USR_3     AXI4     
add_port_map_axi  ARLOCK       s_axi_usr_3_arlock          S_AXI3_USR_3     AXI4    
add_port_map_axi  ARCACHE      s_axi_usr_3_arcache         S_AXI3_USR_3     AXI4     
add_port_map_axi  ARPROT       s_axi_usr_3_arprot          S_AXI3_USR_3     1    
add_port_map_axi  ARQOS        s_axi_usr_3_arqos           S_AXI3_USR_3     AXI4   
add_port_map_axi  ARREGION     s_axi_usr_3_arregion        S_AXI3_USR_3     AXI4      
add_port_map_axi  ARUSER       s_axi_usr_3_aruser          S_AXI3_USR_3     AXI4    
add_port_map_axi  ARVALID      s_axi_usr_3_arvalid         S_AXI3_USR_3     1     
add_port_map_axi  ARREADY      s_axi_usr_3_arready         S_AXI3_USR_3     1     
add_port_map_axi  RID          s_axi_usr_3_rid             S_AXI3_USR_3     AXI4 
add_port_map_axi  RDATA        s_axi_usr_3_rdata           S_AXI3_USR_3     1   
add_port_map_axi  RRESP        s_axi_usr_3_rresp           S_AXI3_USR_3     1   
add_port_map_axi  RLAST        s_axi_usr_3_rlast           S_AXI3_USR_3     AXI4   
add_port_map_axi  RUSER        s_axi_usr_3_ruser           S_AXI3_USR_3     AXI4   
add_port_map_axi  RVALID       s_axi_usr_3_rvalid          S_AXI3_USR_3     1    
add_port_map_axi  RREADY       s_axi_usr_3_rready          S_AXI3_USR_3     1    

add_port_map_axi  AWID         s_axi_usr_4_awid            S_AXI4_USR_4     AXI4  
add_port_map_axi  AWADDR       s_axi_usr_4_awaddr          S_AXI4_USR_4     1    
add_port_map_axi  AWLEN        s_axi_usr_4_awlen           S_AXI4_USR_4     AXI4   
add_port_map_axi  AWSIZE       s_axi_usr_4_awsize          S_AXI4_USR_4     AXI4    
add_port_map_axi  AWBURST      s_axi_usr_4_awburst         S_AXI4_USR_4     AXI4     
add_port_map_axi  AWLOCK       s_axi_usr_4_awlock          S_AXI4_USR_4     AXI4    
add_port_map_axi  AWCACHE      s_axi_usr_4_awcache         S_AXI4_USR_4     AXI4     
add_port_map_axi  AWPROT       s_axi_usr_4_awprot          S_AXI4_USR_4     1    
add_port_map_axi  AWQOS        s_axi_usr_4_awqos           S_AXI4_USR_4     AXI4   
add_port_map_axi  AWREGION     s_axi_usr_4_awregion        S_AXI4_USR_4     AXI4      
add_port_map_axi  AWUSER       s_axi_usr_4_awuser          S_AXI4_USR_4     AXI4    
add_port_map_axi  AWVALID      s_axi_usr_4_awvalid         S_AXI4_USR_4     1     
add_port_map_axi  AWREADY      s_axi_usr_4_awready         S_AXI4_USR_4     1     
add_port_map_axi  WDATA        s_axi_usr_4_wdata           S_AXI4_USR_4     1   
add_port_map_axi  WSTRB        s_axi_usr_4_wstrb           S_AXI4_USR_4     1  
add_port_map_axi  WID          s_axi_usr_4_wid             S_AXI4_USR_4     AXI3   
add_port_map_axi  WLAST        s_axi_usr_4_wlast           S_AXI4_USR_4     AXI4   
add_port_map_axi  WUSER        s_axi_usr_4_wuser           S_AXI4_USR_4     AXI4   
add_port_map_axi  WVALID       s_axi_usr_4_wvalid          S_AXI4_USR_4     1    
add_port_map_axi  WREADY       s_axi_usr_4_wready          S_AXI4_USR_4     1    
add_port_map_axi  BID          s_axi_usr_4_bid             S_AXI4_USR_4     AXI4 
add_port_map_axi  BRESP        s_axi_usr_4_bresp           S_AXI4_USR_4     1   
add_port_map_axi  BUSER        s_axi_usr_4_buser           S_AXI4_USR_4     AXI4   
add_port_map_axi  BVALID       s_axi_usr_4_bvalid          S_AXI4_USR_4     1    
add_port_map_axi  BREADY       s_axi_usr_4_bready          S_AXI4_USR_4     1    
add_port_map_axi  ARID         s_axi_usr_4_arid            S_AXI4_USR_4     AXI4  
add_port_map_axi  ARADDR       s_axi_usr_4_araddr          S_AXI4_USR_4     1    
add_port_map_axi  ARLEN        s_axi_usr_4_arlen           S_AXI4_USR_4     AXI4   
add_port_map_axi  ARSIZE       s_axi_usr_4_arsize          S_AXI4_USR_4     AXI4    
add_port_map_axi  ARBURST      s_axi_usr_4_arburst         S_AXI4_USR_4     AXI4     
add_port_map_axi  ARLOCK       s_axi_usr_4_arlock          S_AXI4_USR_4     AXI4    
add_port_map_axi  ARCACHE      s_axi_usr_4_arcache         S_AXI4_USR_4     AXI4     
add_port_map_axi  ARPROT       s_axi_usr_4_arprot          S_AXI4_USR_4     1    
add_port_map_axi  ARQOS        s_axi_usr_4_arqos           S_AXI4_USR_4     AXI4   
add_port_map_axi  ARREGION     s_axi_usr_4_arregion        S_AXI4_USR_4     AXI4      
add_port_map_axi  ARUSER       s_axi_usr_4_aruser          S_AXI4_USR_4     AXI4    
add_port_map_axi  ARVALID      s_axi_usr_4_arvalid         S_AXI4_USR_4     1     
add_port_map_axi  ARREADY      s_axi_usr_4_arready         S_AXI4_USR_4     1     
add_port_map_axi  RID          s_axi_usr_4_rid             S_AXI4_USR_4     AXI4 
add_port_map_axi  RDATA        s_axi_usr_4_rdata           S_AXI4_USR_4     1   
add_port_map_axi  RRESP        s_axi_usr_4_rresp           S_AXI4_USR_4     1   
add_port_map_axi  RLAST        s_axi_usr_4_rlast           S_AXI4_USR_4     AXI4   
add_port_map_axi  RUSER        s_axi_usr_4_ruser           S_AXI4_USR_4     AXI4   
add_port_map_axi  RVALID       s_axi_usr_4_rvalid          S_AXI4_USR_4     1    
add_port_map_axi  RREADY       s_axi_usr_4_rready          S_AXI4_USR_4     1    

add_port_map_axi  AWID         s_axi_usr_4_awid            S_AXI4LITE_USR_4 AXI4  
add_port_map_axi  AWADDR       s_axi_usr_4_awaddr          S_AXI4LITE_USR_4 1    
add_port_map_axi  AWLEN        s_axi_usr_4_awlen           S_AXI4LITE_USR_4 AXI4   
add_port_map_axi  AWSIZE       s_axi_usr_4_awsize          S_AXI4LITE_USR_4 AXI4    
add_port_map_axi  AWBURST      s_axi_usr_4_awburst         S_AXI4LITE_USR_4 AXI4     
add_port_map_axi  AWLOCK       s_axi_usr_4_awlock          S_AXI4LITE_USR_4 AXI4    
add_port_map_axi  AWCACHE      s_axi_usr_4_awcache         S_AXI4LITE_USR_4 AXI4     
add_port_map_axi  AWPROT       s_axi_usr_4_awprot          S_AXI4LITE_USR_4 1    
add_port_map_axi  AWQOS        s_axi_usr_4_awqos           S_AXI4LITE_USR_4 AXI4   
add_port_map_axi  AWREGION     s_axi_usr_4_awregion        S_AXI4LITE_USR_4 AXI4      
add_port_map_axi  AWUSER       s_axi_usr_4_awuser          S_AXI4LITE_USR_4 AXI4    
add_port_map_axi  AWVALID      s_axi_usr_4_awvalid         S_AXI4LITE_USR_4 1     
add_port_map_axi  AWREADY      s_axi_usr_4_awready         S_AXI4LITE_USR_4 1     
add_port_map_axi  WDATA        s_axi_usr_4_wdata           S_AXI4LITE_USR_4 1   
add_port_map_axi  WSTRB        s_axi_usr_4_wstrb           S_AXI4LITE_USR_4 1  
add_port_map_axi  WID          s_axi_usr_4_wid             S_AXI4LITE_USR_4 AXI3   
add_port_map_axi  WLAST        s_axi_usr_4_wlast           S_AXI4LITE_USR_4 AXI4   
add_port_map_axi  WUSER        s_axi_usr_4_wuser           S_AXI4LITE_USR_4 AXI4   
add_port_map_axi  WVALID       s_axi_usr_4_wvalid          S_AXI4LITE_USR_4 1    
add_port_map_axi  WREADY       s_axi_usr_4_wready          S_AXI4LITE_USR_4 1    
add_port_map_axi  BID          s_axi_usr_4_bid             S_AXI4LITE_USR_4 AXI4 
add_port_map_axi  BRESP        s_axi_usr_4_bresp           S_AXI4LITE_USR_4 1   
add_port_map_axi  BUSER        s_axi_usr_4_buser           S_AXI4LITE_USR_4 AXI4   
add_port_map_axi  BVALID       s_axi_usr_4_bvalid          S_AXI4LITE_USR_4 1    
add_port_map_axi  BREADY       s_axi_usr_4_bready          S_AXI4LITE_USR_4 1    
add_port_map_axi  ARID         s_axi_usr_4_arid            S_AXI4LITE_USR_4 AXI4  
add_port_map_axi  ARADDR       s_axi_usr_4_araddr          S_AXI4LITE_USR_4 1    
add_port_map_axi  ARLEN        s_axi_usr_4_arlen           S_AXI4LITE_USR_4 AXI4   
add_port_map_axi  ARSIZE       s_axi_usr_4_arsize          S_AXI4LITE_USR_4 AXI4    
add_port_map_axi  ARBURST      s_axi_usr_4_arburst         S_AXI4LITE_USR_4 AXI4     
add_port_map_axi  ARLOCK       s_axi_usr_4_arlock          S_AXI4LITE_USR_4 AXI4    
add_port_map_axi  ARCACHE      s_axi_usr_4_arcache         S_AXI4LITE_USR_4 AXI4     
add_port_map_axi  ARPROT       s_axi_usr_4_arprot          S_AXI4LITE_USR_4 1    
add_port_map_axi  ARQOS        s_axi_usr_4_arqos           S_AXI4LITE_USR_4 AXI4   
add_port_map_axi  ARREGION     s_axi_usr_4_arregion        S_AXI4LITE_USR_4 AXI4      
add_port_map_axi  ARUSER       s_axi_usr_4_aruser          S_AXI4LITE_USR_4 AXI4    
add_port_map_axi  ARVALID      s_axi_usr_4_arvalid         S_AXI4LITE_USR_4 1     
add_port_map_axi  ARREADY      s_axi_usr_4_arready         S_AXI4LITE_USR_4 1     
add_port_map_axi  RID          s_axi_usr_4_rid             S_AXI4LITE_USR_4 AXI4 
add_port_map_axi  RDATA        s_axi_usr_4_rdata           S_AXI4LITE_USR_4 1   
add_port_map_axi  RRESP        s_axi_usr_4_rresp           S_AXI4LITE_USR_4 1   
add_port_map_axi  RLAST        s_axi_usr_4_rlast           S_AXI4LITE_USR_4 AXI4   
add_port_map_axi  RUSER        s_axi_usr_4_ruser           S_AXI4LITE_USR_4 AXI4   
add_port_map_axi  RVALID       s_axi_usr_4_rvalid          S_AXI4LITE_USR_4 1    
add_port_map_axi  RREADY       s_axi_usr_4_rready          S_AXI4LITE_USR_4 1    

add_port_map_axi  AWID         s_axi_usr_4_awid            S_AXI3_USR_4     AXI4  
add_port_map_axi  AWADDR       s_axi_usr_4_awaddr          S_AXI3_USR_4     1    
add_port_map_axi  AWLEN        s_axi_usr_4_awlen           S_AXI3_USR_4     AXI4   
add_port_map_axi  AWSIZE       s_axi_usr_4_awsize          S_AXI3_USR_4     AXI4    
add_port_map_axi  AWBURST      s_axi_usr_4_awburst         S_AXI3_USR_4     AXI4     
add_port_map_axi  AWLOCK       s_axi_usr_4_awlock          S_AXI3_USR_4     AXI4    
add_port_map_axi  AWCACHE      s_axi_usr_4_awcache         S_AXI3_USR_4     AXI4     
add_port_map_axi  AWPROT       s_axi_usr_4_awprot          S_AXI3_USR_4     1    
add_port_map_axi  AWQOS        s_axi_usr_4_awqos           S_AXI3_USR_4     AXI4   
add_port_map_axi  AWREGION     s_axi_usr_4_awregion        S_AXI3_USR_4     AXI4      
add_port_map_axi  AWUSER       s_axi_usr_4_awuser          S_AXI3_USR_4     AXI4    
add_port_map_axi  AWVALID      s_axi_usr_4_awvalid         S_AXI3_USR_4     1     
add_port_map_axi  AWREADY      s_axi_usr_4_awready         S_AXI3_USR_4     1     
add_port_map_axi  WDATA        s_axi_usr_4_wdata           S_AXI3_USR_4     1   
add_port_map_axi  WSTRB        s_axi_usr_4_wstrb           S_AXI3_USR_4     1  
add_port_map_axi  WID          s_axi_usr_4_wid             S_AXI3_USR_4     AXI3   
add_port_map_axi  WLAST        s_axi_usr_4_wlast           S_AXI3_USR_4     AXI4   
add_port_map_axi  WUSER        s_axi_usr_4_wuser           S_AXI3_USR_4     AXI4   
add_port_map_axi  WVALID       s_axi_usr_4_wvalid          S_AXI3_USR_4     1    
add_port_map_axi  WREADY       s_axi_usr_4_wready          S_AXI3_USR_4     1    
add_port_map_axi  BID          s_axi_usr_4_bid             S_AXI3_USR_4     AXI4 
add_port_map_axi  BRESP        s_axi_usr_4_bresp           S_AXI3_USR_4     1   
add_port_map_axi  BUSER        s_axi_usr_4_buser           S_AXI3_USR_4     AXI4   
add_port_map_axi  BVALID       s_axi_usr_4_bvalid          S_AXI3_USR_4     1    
add_port_map_axi  BREADY       s_axi_usr_4_bready          S_AXI3_USR_4     1    
add_port_map_axi  ARID         s_axi_usr_4_arid            S_AXI3_USR_4     AXI4  
add_port_map_axi  ARADDR       s_axi_usr_4_araddr          S_AXI3_USR_4     1    
add_port_map_axi  ARLEN        s_axi_usr_4_arlen           S_AXI3_USR_4     AXI4   
add_port_map_axi  ARSIZE       s_axi_usr_4_arsize          S_AXI3_USR_4     AXI4    
add_port_map_axi  ARBURST      s_axi_usr_4_arburst         S_AXI3_USR_4     AXI4     
add_port_map_axi  ARLOCK       s_axi_usr_4_arlock          S_AXI3_USR_4     AXI4    
add_port_map_axi  ARCACHE      s_axi_usr_4_arcache         S_AXI3_USR_4     AXI4     
add_port_map_axi  ARPROT       s_axi_usr_4_arprot          S_AXI3_USR_4     1    
add_port_map_axi  ARQOS        s_axi_usr_4_arqos           S_AXI3_USR_4     AXI4   
add_port_map_axi  ARREGION     s_axi_usr_4_arregion        S_AXI3_USR_4     AXI4      
add_port_map_axi  ARUSER       s_axi_usr_4_aruser          S_AXI3_USR_4     AXI4    
add_port_map_axi  ARVALID      s_axi_usr_4_arvalid         S_AXI3_USR_4     1     
add_port_map_axi  ARREADY      s_axi_usr_4_arready         S_AXI3_USR_4     1     
add_port_map_axi  RID          s_axi_usr_4_rid             S_AXI3_USR_4     AXI4 
add_port_map_axi  RDATA        s_axi_usr_4_rdata           S_AXI3_USR_4     1   
add_port_map_axi  RRESP        s_axi_usr_4_rresp           S_AXI3_USR_4     1   
add_port_map_axi  RLAST        s_axi_usr_4_rlast           S_AXI3_USR_4     AXI4   
add_port_map_axi  RUSER        s_axi_usr_4_ruser           S_AXI3_USR_4     AXI4   
add_port_map_axi  RVALID       s_axi_usr_4_rvalid          S_AXI3_USR_4     1    
add_port_map_axi  RREADY       s_axi_usr_4_rready          S_AXI3_USR_4     1    


add_port_map_axi  AWID         s_axi_usr_5_awid            S_AXI4_USR_5     AXI4  
add_port_map_axi  AWADDR       s_axi_usr_5_awaddr          S_AXI4_USR_5     1    
add_port_map_axi  AWLEN        s_axi_usr_5_awlen           S_AXI4_USR_5     AXI4   
add_port_map_axi  AWSIZE       s_axi_usr_5_awsize          S_AXI4_USR_5     AXI4    
add_port_map_axi  AWBURST      s_axi_usr_5_awburst         S_AXI4_USR_5     AXI4     
add_port_map_axi  AWLOCK       s_axi_usr_5_awlock          S_AXI4_USR_5     AXI4    
add_port_map_axi  AWCACHE      s_axi_usr_5_awcache         S_AXI4_USR_5     AXI4     
add_port_map_axi  AWPROT       s_axi_usr_5_awprot          S_AXI4_USR_5     1    
add_port_map_axi  AWQOS        s_axi_usr_5_awqos           S_AXI4_USR_5     AXI4   
add_port_map_axi  AWREGION     s_axi_usr_5_awregion        S_AXI4_USR_5     AXI4      
add_port_map_axi  AWUSER       s_axi_usr_5_awuser          S_AXI4_USR_5     AXI4    
add_port_map_axi  AWVALID      s_axi_usr_5_awvalid         S_AXI4_USR_5     1     
add_port_map_axi  AWREADY      s_axi_usr_5_awready         S_AXI4_USR_5     1     
add_port_map_axi  WDATA        s_axi_usr_5_wdata           S_AXI4_USR_5     1   
add_port_map_axi  WSTRB        s_axi_usr_5_wstrb           S_AXI4_USR_5     1  
add_port_map_axi  WID          s_axi_usr_5_wid             S_AXI4_USR_5     AXI3   
add_port_map_axi  WLAST        s_axi_usr_5_wlast           S_AXI4_USR_5     AXI4   
add_port_map_axi  WUSER        s_axi_usr_5_wuser           S_AXI4_USR_5     AXI4   
add_port_map_axi  WVALID       s_axi_usr_5_wvalid          S_AXI4_USR_5     1    
add_port_map_axi  WREADY       s_axi_usr_5_wready          S_AXI4_USR_5     1    
add_port_map_axi  BID          s_axi_usr_5_bid             S_AXI4_USR_5     AXI4 
add_port_map_axi  BRESP        s_axi_usr_5_bresp           S_AXI4_USR_5     1   
add_port_map_axi  BUSER        s_axi_usr_5_buser           S_AXI4_USR_5     AXI4   
add_port_map_axi  BVALID       s_axi_usr_5_bvalid          S_AXI4_USR_5     1    
add_port_map_axi  BREADY       s_axi_usr_5_bready          S_AXI4_USR_5     1    
add_port_map_axi  ARID         s_axi_usr_5_arid            S_AXI4_USR_5     AXI4  
add_port_map_axi  ARADDR       s_axi_usr_5_araddr          S_AXI4_USR_5     1    
add_port_map_axi  ARLEN        s_axi_usr_5_arlen           S_AXI4_USR_5     AXI4   
add_port_map_axi  ARSIZE       s_axi_usr_5_arsize          S_AXI4_USR_5     AXI4    
add_port_map_axi  ARBURST      s_axi_usr_5_arburst         S_AXI4_USR_5     AXI4     
add_port_map_axi  ARLOCK       s_axi_usr_5_arlock          S_AXI4_USR_5     AXI4    
add_port_map_axi  ARCACHE      s_axi_usr_5_arcache         S_AXI4_USR_5     AXI4     
add_port_map_axi  ARPROT       s_axi_usr_5_arprot          S_AXI4_USR_5     1    
add_port_map_axi  ARQOS        s_axi_usr_5_arqos           S_AXI4_USR_5     AXI4   
add_port_map_axi  ARREGION     s_axi_usr_5_arregion        S_AXI4_USR_5     AXI4      
add_port_map_axi  ARUSER       s_axi_usr_5_aruser          S_AXI4_USR_5     AXI4    
add_port_map_axi  ARVALID      s_axi_usr_5_arvalid         S_AXI4_USR_5     1     
add_port_map_axi  ARREADY      s_axi_usr_5_arready         S_AXI4_USR_5     1     
add_port_map_axi  RID          s_axi_usr_5_rid             S_AXI4_USR_5     AXI4 
add_port_map_axi  RDATA        s_axi_usr_5_rdata           S_AXI4_USR_5     1   
add_port_map_axi  RRESP        s_axi_usr_5_rresp           S_AXI4_USR_5     1   
add_port_map_axi  RLAST        s_axi_usr_5_rlast           S_AXI4_USR_5     AXI4   
add_port_map_axi  RUSER        s_axi_usr_5_ruser           S_AXI4_USR_5     AXI4   
add_port_map_axi  RVALID       s_axi_usr_5_rvalid          S_AXI4_USR_5     1    
add_port_map_axi  RREADY       s_axi_usr_5_rready          S_AXI4_USR_5     1    

add_port_map_axi  AWID         s_axi_usr_5_awid            S_AXI4LITE_USR_5 AXI4  
add_port_map_axi  AWADDR       s_axi_usr_5_awaddr          S_AXI4LITE_USR_5 1    
add_port_map_axi  AWLEN        s_axi_usr_5_awlen           S_AXI4LITE_USR_5 AXI4   
add_port_map_axi  AWSIZE       s_axi_usr_5_awsize          S_AXI4LITE_USR_5 AXI4    
add_port_map_axi  AWBURST      s_axi_usr_5_awburst         S_AXI4LITE_USR_5 AXI4     
add_port_map_axi  AWLOCK       s_axi_usr_5_awlock          S_AXI4LITE_USR_5 AXI4    
add_port_map_axi  AWCACHE      s_axi_usr_5_awcache         S_AXI4LITE_USR_5 AXI4     
add_port_map_axi  AWPROT       s_axi_usr_5_awprot          S_AXI4LITE_USR_5 1    
add_port_map_axi  AWQOS        s_axi_usr_5_awqos           S_AXI4LITE_USR_5 AXI4   
add_port_map_axi  AWREGION     s_axi_usr_5_awregion        S_AXI4LITE_USR_5 AXI4      
add_port_map_axi  AWUSER       s_axi_usr_5_awuser          S_AXI4LITE_USR_5 AXI4    
add_port_map_axi  AWVALID      s_axi_usr_5_awvalid         S_AXI4LITE_USR_5 1     
add_port_map_axi  AWREADY      s_axi_usr_5_awready         S_AXI4LITE_USR_5 1     
add_port_map_axi  WDATA        s_axi_usr_5_wdata           S_AXI4LITE_USR_5 1   
add_port_map_axi  WSTRB        s_axi_usr_5_wstrb           S_AXI4LITE_USR_5 1  
add_port_map_axi  WID          s_axi_usr_5_wid             S_AXI4LITE_USR_5 AXI3   
add_port_map_axi  WLAST        s_axi_usr_5_wlast           S_AXI4LITE_USR_5 AXI4   
add_port_map_axi  WUSER        s_axi_usr_5_wuser           S_AXI4LITE_USR_5 AXI4   
add_port_map_axi  WVALID       s_axi_usr_5_wvalid          S_AXI4LITE_USR_5 1    
add_port_map_axi  WREADY       s_axi_usr_5_wready          S_AXI4LITE_USR_5 1    
add_port_map_axi  BID          s_axi_usr_5_bid             S_AXI4LITE_USR_5 AXI4 
add_port_map_axi  BRESP        s_axi_usr_5_bresp           S_AXI4LITE_USR_5 1   
add_port_map_axi  BUSER        s_axi_usr_5_buser           S_AXI4LITE_USR_5 AXI4   
add_port_map_axi  BVALID       s_axi_usr_5_bvalid          S_AXI4LITE_USR_5 1    
add_port_map_axi  BREADY       s_axi_usr_5_bready          S_AXI4LITE_USR_5 1    
add_port_map_axi  ARID         s_axi_usr_5_arid            S_AXI4LITE_USR_5 AXI4  
add_port_map_axi  ARADDR       s_axi_usr_5_araddr          S_AXI4LITE_USR_5 1    
add_port_map_axi  ARLEN        s_axi_usr_5_arlen           S_AXI4LITE_USR_5 AXI4   
add_port_map_axi  ARSIZE       s_axi_usr_5_arsize          S_AXI4LITE_USR_5 AXI4    
add_port_map_axi  ARBURST      s_axi_usr_5_arburst         S_AXI4LITE_USR_5 AXI4     
add_port_map_axi  ARLOCK       s_axi_usr_5_arlock          S_AXI4LITE_USR_5 AXI4    
add_port_map_axi  ARCACHE      s_axi_usr_5_arcache         S_AXI4LITE_USR_5 AXI4     
add_port_map_axi  ARPROT       s_axi_usr_5_arprot          S_AXI4LITE_USR_5 1    
add_port_map_axi  ARQOS        s_axi_usr_5_arqos           S_AXI4LITE_USR_5 AXI4   
add_port_map_axi  ARREGION     s_axi_usr_5_arregion        S_AXI4LITE_USR_5 AXI4      
add_port_map_axi  ARUSER       s_axi_usr_5_aruser          S_AXI4LITE_USR_5 AXI4    
add_port_map_axi  ARVALID      s_axi_usr_5_arvalid         S_AXI4LITE_USR_5 1     
add_port_map_axi  ARREADY      s_axi_usr_5_arready         S_AXI4LITE_USR_5 1     
add_port_map_axi  RID          s_axi_usr_5_rid             S_AXI4LITE_USR_5 AXI4 
add_port_map_axi  RDATA        s_axi_usr_5_rdata           S_AXI4LITE_USR_5 1   
add_port_map_axi  RRESP        s_axi_usr_5_rresp           S_AXI4LITE_USR_5 1   
add_port_map_axi  RLAST        s_axi_usr_5_rlast           S_AXI4LITE_USR_5 AXI4   
add_port_map_axi  RUSER        s_axi_usr_5_ruser           S_AXI4LITE_USR_5 AXI4   
add_port_map_axi  RVALID       s_axi_usr_5_rvalid          S_AXI4LITE_USR_5 1    
add_port_map_axi  RREADY       s_axi_usr_5_rready          S_AXI4LITE_USR_5 1    

add_port_map_axi  AWID         s_axi_usr_5_awid            S_AXI3_USR_5     AXI4  
add_port_map_axi  AWADDR       s_axi_usr_5_awaddr          S_AXI3_USR_5     1    
add_port_map_axi  AWLEN        s_axi_usr_5_awlen           S_AXI3_USR_5     AXI4   
add_port_map_axi  AWSIZE       s_axi_usr_5_awsize          S_AXI3_USR_5     AXI4    
add_port_map_axi  AWBURST      s_axi_usr_5_awburst         S_AXI3_USR_5     AXI4     
add_port_map_axi  AWLOCK       s_axi_usr_5_awlock          S_AXI3_USR_5     AXI4    
add_port_map_axi  AWCACHE      s_axi_usr_5_awcache         S_AXI3_USR_5     AXI4     
add_port_map_axi  AWPROT       s_axi_usr_5_awprot          S_AXI3_USR_5     1    
add_port_map_axi  AWQOS        s_axi_usr_5_awqos           S_AXI3_USR_5     AXI4   
add_port_map_axi  AWREGION     s_axi_usr_5_awregion        S_AXI3_USR_5     AXI4      
add_port_map_axi  AWUSER       s_axi_usr_5_awuser          S_AXI3_USR_5     AXI4    
add_port_map_axi  AWVALID      s_axi_usr_5_awvalid         S_AXI3_USR_5     1     
add_port_map_axi  AWREADY      s_axi_usr_5_awready         S_AXI3_USR_5     1     
add_port_map_axi  WDATA        s_axi_usr_5_wdata           S_AXI3_USR_5     1   
add_port_map_axi  WSTRB        s_axi_usr_5_wstrb           S_AXI3_USR_5     1  
add_port_map_axi  WID          s_axi_usr_5_wid             S_AXI3_USR_5     AXI3   
add_port_map_axi  WLAST        s_axi_usr_5_wlast           S_AXI3_USR_5     AXI4   
add_port_map_axi  WUSER        s_axi_usr_5_wuser           S_AXI3_USR_5     AXI4   
add_port_map_axi  WVALID       s_axi_usr_5_wvalid          S_AXI3_USR_5     1    
add_port_map_axi  WREADY       s_axi_usr_5_wready          S_AXI3_USR_5     1    
add_port_map_axi  BID          s_axi_usr_5_bid             S_AXI3_USR_5     AXI4 
add_port_map_axi  BRESP        s_axi_usr_5_bresp           S_AXI3_USR_5     1   
add_port_map_axi  BUSER        s_axi_usr_5_buser           S_AXI3_USR_5     AXI4   
add_port_map_axi  BVALID       s_axi_usr_5_bvalid          S_AXI3_USR_5     1    
add_port_map_axi  BREADY       s_axi_usr_5_bready          S_AXI3_USR_5     1    
add_port_map_axi  ARID         s_axi_usr_5_arid            S_AXI3_USR_5     AXI4  
add_port_map_axi  ARADDR       s_axi_usr_5_araddr          S_AXI3_USR_5     1    
add_port_map_axi  ARLEN        s_axi_usr_5_arlen           S_AXI3_USR_5     AXI4   
add_port_map_axi  ARSIZE       s_axi_usr_5_arsize          S_AXI3_USR_5     AXI4    
add_port_map_axi  ARBURST      s_axi_usr_5_arburst         S_AXI3_USR_5     AXI4     
add_port_map_axi  ARLOCK       s_axi_usr_5_arlock          S_AXI3_USR_5     AXI4    
add_port_map_axi  ARCACHE      s_axi_usr_5_arcache         S_AXI3_USR_5     AXI4     
add_port_map_axi  ARPROT       s_axi_usr_5_arprot          S_AXI3_USR_5     1    
add_port_map_axi  ARQOS        s_axi_usr_5_arqos           S_AXI3_USR_5     AXI4   
add_port_map_axi  ARREGION     s_axi_usr_5_arregion        S_AXI3_USR_5     AXI4      
add_port_map_axi  ARUSER       s_axi_usr_5_aruser          S_AXI3_USR_5     AXI4    
add_port_map_axi  ARVALID      s_axi_usr_5_arvalid         S_AXI3_USR_5     1     
add_port_map_axi  ARREADY      s_axi_usr_5_arready         S_AXI3_USR_5     1     
add_port_map_axi  RID          s_axi_usr_5_rid             S_AXI3_USR_5     AXI4 
add_port_map_axi  RDATA        s_axi_usr_5_rdata           S_AXI3_USR_5     1   
add_port_map_axi  RRESP        s_axi_usr_5_rresp           S_AXI3_USR_5     1   
add_port_map_axi  RLAST        s_axi_usr_5_rlast           S_AXI3_USR_5     AXI4   
add_port_map_axi  RUSER        s_axi_usr_5_ruser           S_AXI3_USR_5     AXI4   
add_port_map_axi  RVALID       s_axi_usr_5_rvalid          S_AXI3_USR_5     1    
add_port_map_axi  RREADY       s_axi_usr_5_rready          S_AXI3_USR_5     1    




# Memory maps
set slaveifs {S_AXI_PCIE_M0}
lappend slaveifs S_AXI_PCIE_M1
lappend slaveifs S_AXI_PCIE_M2
lappend slaveifs S_AXI_PCIE_M3
lappend slaveifs S_AXI_PCIE_M4
lappend slaveifs S_AXI_PCIE_M5
lappend slaveifs S_AXI_PCIE_S0
lappend slaveifs S_AXI_PCIE_S1
lappend slaveifs S_AXI_PCIE_S2
lappend slaveifs S_AXI_PCIE_S3
lappend slaveifs S_AXI_PCIE_S4
lappend slaveifs S_AXI_PCIE_S5
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


set masterifs {M_AXI_PCIE_M0}
lappend masterifs M_AXI_PCIE_M1
lappend masterifs M_AXI_PCIE_M2
lappend masterifs M_AXI_PCIE_M3
lappend masterifs M_AXI_PCIE_M4
lappend masterifs M_AXI_PCIE_M5
lappend masterifs M_AXI_PCIE_S0
lappend masterifs M_AXI_PCIE_S1
lappend masterifs M_AXI_PCIE_S2
lappend masterifs M_AXI_PCIE_S3
lappend masterifs M_AXI_PCIE_S4
lappend masterifs M_AXI_PCIE_S5
foreach masterif $masterifs {
  set current_addrspace [::ipx::add_address_space $masterif $::core]
  set_property range {16E} $current_addrspace
  set_property range_format {long} $current_addrspace
  set_property range_resolve_type {dependent} $current_addrspace
  set_property width 32 $current_addrspace
  set_property width_format {long} $current_addrspace
  set_property master_address_space_ref $masterif [::ipx::get_bus_interfaces -of_objects $::core $masterif]
}


set masterifs {M_AXI4_USR_0}
lappend masterifs M_AXI4LITE_USR_0
lappend masterifs M_AXI3_USR_0
lappend masterifs M_AXI4_USR_1
lappend masterifs M_AXI4LITE_USR_1
lappend masterifs M_AXI3_USR_1
lappend masterifs M_AXI4_USR_2
lappend masterifs M_AXI4LITE_USR_2
lappend masterifs M_AXI3_USR_2
lappend masterifs M_AXI4_USR_3
lappend masterifs M_AXI4LITE_USR_3
lappend masterifs M_AXI3_USR_3
lappend masterifs M_AXI4_USR_4
lappend masterifs M_AXI4LITE_USR_4
lappend masterifs M_AXI3_USR_4
lappend masterifs M_AXI4_USR_5
lappend masterifs M_AXI4LITE_USR_5
lappend masterifs M_AXI3_USR_5
foreach masterif $masterifs {
  set current_addrspace [::ipx::add_address_space $masterif $::core]
  set_property range {16E} $current_addrspace
  set_property range_format {long} $current_addrspace
  set_property range_resolve_type {dependent} $current_addrspace
  set_property width 64 $current_addrspace
  set_property width_format {long} $current_addrspace
  set_property master_address_space_ref $masterif [::ipx::get_bus_interfaces -of_objects $::core $masterif]
}


set slaveifs {S_AXI4_USR_0}
lappend slaveifs S_AXI4LITE_USR_0
lappend slaveifs S_AXI3_USR_0
lappend slaveifs S_AXI4_USR_1
lappend slaveifs S_AXI4LITE_USR_1
lappend slaveifs S_AXI3_USR_1
lappend slaveifs S_AXI4_USR_2
lappend slaveifs S_AXI4LITE_USR_2
lappend slaveifs S_AXI3_USR_2
lappend slaveifs S_AXI4_USR_3
lappend slaveifs S_AXI4LITE_USR_3
lappend slaveifs S_AXI3_USR_3
lappend slaveifs S_AXI4_USR_4
lappend slaveifs S_AXI4LITE_USR_4
lappend slaveifs S_AXI3_USR_4
lappend slaveifs S_AXI4_USR_5
lappend slaveifs S_AXI4LITE_USR_5
lappend slaveifs S_AXI3_USR_5
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

::ipx::save_core $::core
