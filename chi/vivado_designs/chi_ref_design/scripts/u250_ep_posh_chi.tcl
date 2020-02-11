
################################################################
# This is a generated script based on design: u250_ep_posh_chi
#
# Though there are limitations about the generated script,
# the main purpose of this utility is to make learning
# IP Integrator Tcl commands easier.
################################################################

namespace eval _tcl {
proc get_script_folder {} {
   set script_path [file normalize [info script]]
   set script_folder [file dirname $script_path]
   return $script_folder
}
}
variable script_folder
set script_folder [_tcl::get_script_folder]

################################################################
# Check if script is running in correct Vivado version.
################################################################
set scripts_vivado_version 2018.3
set current_vivado_version [version -short]

if { [string first $scripts_vivado_version $current_vivado_version] == -1 } {
   puts ""
   catch {common::send_msg_id "BD_TCL-109" "ERROR" "This script was generated using Vivado <$scripts_vivado_version> and is being run in <$current_vivado_version> of Vivado. Please run the script in Vivado <$scripts_vivado_version> then open the design in Vivado <$current_vivado_version>. Upgrade the design by running \"Tools => Report => Report IP Status...\", then run write_bd_tcl to create an updated script."}

   return 1
}

################################################################
# START
################################################################

# To test this script, run the following commands from Vivado Tcl console:
# source u250_ep_posh_chi_script.tcl

# If there is no project opened, this script will create a
# project, but make sure you do not have an existing project
# <./myproj/project_1.xpr> in the current working folder.

set list_projs [get_projects -quiet]
if { $list_projs eq "" } {
   create_project project_1 myproj -part xcu250-figd2104-2L-e
   set_property BOARD_PART xilinx.com:au250:part0:1.0 [current_project]
}


# CHANGE DESIGN NAME HERE
variable design_name
set design_name u250_ep_posh_chi

# If you do not already have an existing IP Integrator design open,
# you can create a design using the following command:
#    create_bd_design $design_name

# Creating design if needed
set errMsg ""
set nRet 0

set cur_design [current_bd_design -quiet]
set list_cells [get_bd_cells -quiet]

if { ${design_name} eq "" } {
   # USE CASES:
   #    1) Design_name not set

   set errMsg "Please set the variable <design_name> to a non-empty value."
   set nRet 1

} elseif { ${cur_design} ne "" && ${list_cells} eq "" } {
   # USE CASES:
   #    2): Current design opened AND is empty AND names same.
   #    3): Current design opened AND is empty AND names diff; design_name NOT in project.
   #    4): Current design opened AND is empty AND names diff; design_name exists in project.

   if { $cur_design ne $design_name } {
      common::send_msg_id "BD_TCL-001" "INFO" "Changing value of <design_name> from <$design_name> to <$cur_design> since current design is empty."
      set design_name [get_property NAME $cur_design]
   }
   common::send_msg_id "BD_TCL-002" "INFO" "Constructing design in IPI design <$cur_design>..."

} elseif { ${cur_design} ne "" && $list_cells ne "" && $cur_design eq $design_name } {
   # USE CASES:
   #    5) Current design opened AND has components AND same names.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 1
} elseif { [get_files -quiet ${design_name}.bd] ne "" } {
   # USE CASES: 
   #    6) Current opened design, has components, but diff names, design_name exists in project.
   #    7) No opened design, design_name exists in project.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 2

} else {
   # USE CASES:
   #    8) No opened design, design_name not in project.
   #    9) Current opened design, has components, but diff names, design_name not in project.

   common::send_msg_id "BD_TCL-003" "INFO" "Currently there is no design <$design_name> in project, so creating one..."

   create_bd_design $design_name

   common::send_msg_id "BD_TCL-004" "INFO" "Making design <$design_name> as current_bd_design."
   current_bd_design $design_name

}

common::send_msg_id "BD_TCL-005" "INFO" "Currently the variable <design_name> is equal to \"$design_name\"."

if { $nRet != 0 } {
   catch {common::send_msg_id "BD_TCL-114" "ERROR" $errMsg}
   return $nRet
}

set bCheckIPsPassed 1
##################################################################
# CHECK IPs
##################################################################
set bCheckIPs 1
if { $bCheckIPs == 1 } {
   set list_check_ips "\ 
xilinx.com:ip:chi_bridge_hn_top:1.00\
xilinx.com:ip:chi_bridge_rn_top:1.00\
xilinx.com:ip:xlslice:1.0\
xilinx.com:ip:util_ds_buf:2.1\
xilinx.com:ip:xdma:4.1\
xilinx.com:ip:xlconcat:2.1\
xilinx.com:ip:axi_gpio:2.0\
"

   set list_ips_missing ""
   common::send_msg_id "BD_TCL-006" "INFO" "Checking if the following IPs exist in the project's IP catalog: $list_check_ips ."

   foreach ip_vlnv $list_check_ips {
      set ip_obj [get_ipdefs -all $ip_vlnv]
      if { $ip_obj eq "" } {
         lappend list_ips_missing $ip_vlnv
      }
   }

   if { $list_ips_missing ne "" } {
      catch {common::send_msg_id "BD_TCL-115" "ERROR" "The following IPs are not found in the IP Catalog:\n  $list_ips_missing\n\nResolution: Please add the repository containing the IP(s) to the project." }
      set bCheckIPsPassed 0
   }

}

if { $bCheckIPsPassed != 1 } {
  common::send_msg_id "BD_TCL-1003" "WARNING" "Will not continue with creation of design due to the error(s) above."
  return 3
}

##################################################################
# DESIGN PROCs
##################################################################


# Hierarchical cell: Gpio_intr_out_rn_f
proc create_hier_cell_Gpio_intr_out_rn_f { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_msg_id "BD_TCL-102" "ERROR" "create_hier_cell_Gpio_intr_out_rn_f() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_msg_id "BD_TCL-100" "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_msg_id "BD_TCL-101" "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI1

  # Create pins
  create_bd_pin -dir I -from 127 -to 0 Din
  create_bd_pin -dir I -type clk s_axi_aclk
  create_bd_pin -dir I -type rst s_axi_aresetn

  # Create instance: axi_gpio_2, and set properties
  set axi_gpio_2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 axi_gpio_2 ]
  set_property -dict [ list \
   CONFIG.C_ALL_INPUTS {1} \
   CONFIG.C_ALL_INPUTS_2 {1} \
   CONFIG.C_IS_DUAL {1} \
 ] $axi_gpio_2

  # Create instance: axi_gpio_3, and set properties
  set axi_gpio_3 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 axi_gpio_3 ]
  set_property -dict [ list \
   CONFIG.C_ALL_INPUTS {1} \
   CONFIG.C_ALL_INPUTS_2 {1} \
   CONFIG.C_IS_DUAL {1} \
 ] $axi_gpio_3

  # Create instance: xlslice_0, and set properties
  set xlslice_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 xlslice_0 ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {31} \
   CONFIG.DIN_TO {0} \
   CONFIG.DIN_WIDTH {128} \
   CONFIG.DOUT_WIDTH {32} \
 ] $xlslice_0

  # Create instance: xlslice_1, and set properties
  set xlslice_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 xlslice_1 ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {63} \
   CONFIG.DIN_TO {32} \
   CONFIG.DIN_WIDTH {128} \
   CONFIG.DOUT_WIDTH {1} \
 ] $xlslice_1

  # Create instance: xlslice_2, and set properties
  set xlslice_2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 xlslice_2 ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {95} \
   CONFIG.DIN_TO {64} \
   CONFIG.DIN_WIDTH {128} \
   CONFIG.DOUT_WIDTH {1} \
 ] $xlslice_2

  # Create instance: xlslice_3, and set properties
  set xlslice_3 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 xlslice_3 ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {127} \
   CONFIG.DIN_TO {96} \
   CONFIG.DIN_WIDTH {128} \
   CONFIG.DOUT_WIDTH {1} \
 ] $xlslice_3

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins S_AXI1] [get_bd_intf_pins axi_gpio_3/S_AXI]
  connect_bd_intf_net -intf_net MB_XDMA_COMMON_SLV_IC_M05_AXI [get_bd_intf_pins S_AXI] [get_bd_intf_pins axi_gpio_2/S_AXI]

  # Create port connections
  connect_bd_net -net Din_1 [get_bd_pins Din] [get_bd_pins xlslice_0/Din] [get_bd_pins xlslice_1/Din] [get_bd_pins xlslice_2/Din] [get_bd_pins xlslice_3/Din]
  connect_bd_net -net M06_ACLK_1 [get_bd_pins s_axi_aclk] [get_bd_pins axi_gpio_2/s_axi_aclk] [get_bd_pins axi_gpio_3/s_axi_aclk]
  connect_bd_net -net Xilinx_PCIe_Tunnel_axi_aresetn [get_bd_pins s_axi_aresetn] [get_bd_pins axi_gpio_2/s_axi_aresetn] [get_bd_pins axi_gpio_3/s_axi_aresetn]
  connect_bd_net -net xlslice_0_Dout [get_bd_pins axi_gpio_2/gpio_io_i] [get_bd_pins xlslice_0/Dout]
  connect_bd_net -net xlslice_1_Dout [get_bd_pins axi_gpio_2/gpio2_io_i] [get_bd_pins xlslice_1/Dout]
  connect_bd_net -net xlslice_2_Dout [get_bd_pins axi_gpio_3/gpio_io_i] [get_bd_pins xlslice_2/Dout]
  connect_bd_net -net xlslice_3_Dout [get_bd_pins axi_gpio_3/gpio2_io_i] [get_bd_pins xlslice_3/Dout]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: Gpio_intr_out_hn_f
proc create_hier_cell_Gpio_intr_out_hn_f { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_msg_id "BD_TCL-102" "ERROR" "create_hier_cell_Gpio_intr_out_hn_f() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_msg_id "BD_TCL-100" "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_msg_id "BD_TCL-101" "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI1

  # Create pins
  create_bd_pin -dir I -from 127 -to 0 Din
  create_bd_pin -dir I -type clk s_axi_aclk
  create_bd_pin -dir I -type rst s_axi_aresetn

  # Create instance: axi_gpio_2, and set properties
  set axi_gpio_2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 axi_gpio_2 ]
  set_property -dict [ list \
   CONFIG.C_ALL_INPUTS {1} \
   CONFIG.C_ALL_INPUTS_2 {1} \
   CONFIG.C_IS_DUAL {1} \
 ] $axi_gpio_2

  # Create instance: axi_gpio_3, and set properties
  set axi_gpio_3 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 axi_gpio_3 ]
  set_property -dict [ list \
   CONFIG.C_ALL_INPUTS {1} \
   CONFIG.C_ALL_INPUTS_2 {1} \
   CONFIG.C_IS_DUAL {1} \
 ] $axi_gpio_3

  # Create instance: xlslice_0, and set properties
  set xlslice_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 xlslice_0 ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {31} \
   CONFIG.DIN_TO {0} \
   CONFIG.DIN_WIDTH {128} \
   CONFIG.DOUT_WIDTH {32} \
 ] $xlslice_0

  # Create instance: xlslice_1, and set properties
  set xlslice_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 xlslice_1 ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {63} \
   CONFIG.DIN_TO {32} \
   CONFIG.DIN_WIDTH {128} \
   CONFIG.DOUT_WIDTH {1} \
 ] $xlslice_1

  # Create instance: xlslice_2, and set properties
  set xlslice_2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 xlslice_2 ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {95} \
   CONFIG.DIN_TO {64} \
   CONFIG.DIN_WIDTH {128} \
   CONFIG.DOUT_WIDTH {1} \
 ] $xlslice_2

  # Create instance: xlslice_3, and set properties
  set xlslice_3 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 xlslice_3 ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {127} \
   CONFIG.DIN_TO {96} \
   CONFIG.DIN_WIDTH {128} \
   CONFIG.DOUT_WIDTH {1} \
 ] $xlslice_3

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins S_AXI1] [get_bd_intf_pins axi_gpio_3/S_AXI]
  connect_bd_intf_net -intf_net MB_XDMA_COMMON_SLV_IC_M05_AXI [get_bd_intf_pins S_AXI] [get_bd_intf_pins axi_gpio_2/S_AXI]

  # Create port connections
  connect_bd_net -net Din_1 [get_bd_pins Din] [get_bd_pins xlslice_0/Din] [get_bd_pins xlslice_1/Din] [get_bd_pins xlslice_2/Din] [get_bd_pins xlslice_3/Din]
  connect_bd_net -net M06_ACLK_1 [get_bd_pins s_axi_aclk] [get_bd_pins axi_gpio_2/s_axi_aclk] [get_bd_pins axi_gpio_3/s_axi_aclk]
  connect_bd_net -net Xilinx_PCIe_Tunnel_axi_aresetn [get_bd_pins s_axi_aresetn] [get_bd_pins axi_gpio_2/s_axi_aresetn] [get_bd_pins axi_gpio_3/s_axi_aresetn]
  connect_bd_net -net xlslice_0_Dout [get_bd_pins axi_gpio_2/gpio_io_i] [get_bd_pins xlslice_0/Dout]
  connect_bd_net -net xlslice_1_Dout [get_bd_pins axi_gpio_2/gpio2_io_i] [get_bd_pins xlslice_1/Dout]
  connect_bd_net -net xlslice_2_Dout [get_bd_pins axi_gpio_3/gpio_io_i] [get_bd_pins xlslice_2/Dout]
  connect_bd_net -net xlslice_3_Dout [get_bd_pins axi_gpio_3/gpio2_io_i] [get_bd_pins xlslice_3/Dout]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: Gpio_intr_in
proc create_hier_cell_Gpio_intr_in { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_msg_id "BD_TCL-102" "ERROR" "create_hier_cell_Gpio_intr_in() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_msg_id "BD_TCL-100" "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_msg_id "BD_TCL-101" "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI1

  # Create pins
  create_bd_pin -dir O -from 63 -to 0 dout
  create_bd_pin -dir I -type clk s_axi_aclk
  create_bd_pin -dir I -type rst s_axi_aresetn

  # Create instance: axi_gpio_0, and set properties
  set axi_gpio_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 axi_gpio_0 ]
  set_property -dict [ list \
   CONFIG.C_ALL_INPUTS_2 {0} \
   CONFIG.C_ALL_OUTPUTS {1} \
   CONFIG.C_ALL_OUTPUTS_2 {1} \
   CONFIG.C_IS_DUAL {1} \
 ] $axi_gpio_0

  # Create instance: xlconcat_0, and set properties
  set xlconcat_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 xlconcat_0 ]
  set_property -dict [ list \
   CONFIG.IN0_WIDTH {32} \
   CONFIG.IN1_WIDTH {32} \
   CONFIG.IN2_WIDTH {32} \
   CONFIG.IN3_WIDTH {32} \
   CONFIG.NUM_PORTS {2} \
 ] $xlconcat_0

  # Create interface connections
  connect_bd_intf_net -intf_net MB_XDMA_COMMON_SLV_IC_M03_AXI [get_bd_intf_pins S_AXI] [get_bd_intf_pins axi_gpio_0/S_AXI]

  # Create port connections
  connect_bd_net -net M06_ACLK_1 [get_bd_pins s_axi_aclk] [get_bd_pins axi_gpio_0/s_axi_aclk]
  connect_bd_net -net Xilinx_PCIe_Tunnel_axi_aresetn [get_bd_pins s_axi_aresetn] [get_bd_pins axi_gpio_0/s_axi_aresetn]
  connect_bd_net -net axi_gpio_0_gpio2_io_o [get_bd_pins axi_gpio_0/gpio2_io_o] [get_bd_pins xlconcat_0/In1]
  connect_bd_net -net axi_gpio_0_gpio_io_o [get_bd_pins axi_gpio_0/gpio_io_o] [get_bd_pins xlconcat_0/In0]
  connect_bd_net -net xlconcat_0_dout [get_bd_pins dout] [get_bd_pins xlconcat_0/dout]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: Xilinx_PCIe_Tunnel
proc create_hier_cell_Xilinx_PCIe_Tunnel { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_msg_id "BD_TCL-102" "ERROR" "create_hier_cell_Xilinx_PCIe_Tunnel() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_msg_id "BD_TCL-100" "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_msg_id "BD_TCL-101" "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M_AXI_B
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI_LITE
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:pcie_7x_mgt_rtl:1.0 pci_express_x16
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:diff_clock_rtl:1.0 pcie_refclk

  # Create pins
  create_bd_pin -dir O -type clk axi_aclk
  create_bd_pin -dir O -type rst axi_aresetn
  create_bd_pin -dir I -from 0 -to 0 intr_0
  create_bd_pin -dir I -from 0 -to 0 intr_1
  create_bd_pin -dir O -from 0 -to 0 intr_ack_0
  create_bd_pin -dir O -from 0 -to 0 intr_ack_1
  create_bd_pin -dir I -type rst pcie_perstn

  # Create instance: util_ds_buf, and set properties
  set util_ds_buf [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_ds_buf:2.1 util_ds_buf ]
  set_property -dict [ list \
   CONFIG.DIFF_CLK_IN_BOARD_INTERFACE {pcie_refclk} \
 ] $util_ds_buf

  # Create instance: xdma_0, and set properties
  set xdma_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xdma:4.1 xdma_0 ]
  set_property -dict [ list \
   CONFIG.PCIE_BOARD_INTERFACE {pci_express_x16} \
   CONFIG.PF0_DEVICE_ID_mqdma {903F} \
   CONFIG.PF2_DEVICE_ID_mqdma {903F} \
   CONFIG.PF3_DEVICE_ID_mqdma {903F} \
   CONFIG.SYS_RST_N_BOARD_INTERFACE {pcie_perstn} \
   CONFIG.axi_addr_width {64} \
   CONFIG.axi_data_width {512_bit} \
   CONFIG.axisten_freq {250} \
   CONFIG.bar_indicator {BAR_1:0} \
   CONFIG.coreclk_freq {500} \
   CONFIG.en_axi_slave_if {false} \
   CONFIG.en_gt_selection {true} \
   CONFIG.functional_mode {AXI_Bridge} \
   CONFIG.mode_selection {Advanced} \
   CONFIG.pciebar2axibar_0 {0x00000000C0000000} \
   CONFIG.pciebar2axibar_1 {0x0000000000000000} \
   CONFIG.pciebar2axibar_2 {0x0000000020000000} \
   CONFIG.pciebar2axibar_4 {0x00000000B0000000} \
   CONFIG.pf0_bar0_64bit {true} \
   CONFIG.pf0_bar0_scale {Megabytes} \
   CONFIG.pf0_bar0_size {64} \
   CONFIG.pf0_bar1_enabled {false} \
   CONFIG.pf0_bar1_scale {Kilobytes} \
   CONFIG.pf0_bar1_size {4} \
   CONFIG.pf0_bar2_64bit {true} \
   CONFIG.pf0_bar2_enabled {true} \
   CONFIG.pf0_bar2_scale {Megabytes} \
   CONFIG.pf0_bar2_size {64} \
   CONFIG.pf0_bar4_64bit {true} \
   CONFIG.pf0_bar4_enabled {true} \
   CONFIG.pf0_bar4_scale {Megabytes} \
   CONFIG.pf0_bar4_size {64} \
   CONFIG.pf0_base_class_menu {Memory_controller} \
   CONFIG.pf0_class_code {050100} \
   CONFIG.pf0_class_code_base {05} \
   CONFIG.pf0_class_code_interface {00} \
   CONFIG.pf0_class_code_sub {01} \
   CONFIG.pf0_device_id {903F} \
   CONFIG.pf0_msi_enabled {false} \
   CONFIG.pf0_msix_cap_pba_bir {BAR_1:0} \
   CONFIG.pf0_msix_cap_table_bir {BAR_1:0} \
   CONFIG.pf0_sub_class_interface_menu {Flash} \
   CONFIG.pl_link_cap_max_link_speed {8.0_GT/s} \
   CONFIG.pl_link_cap_max_link_width {X16} \
   CONFIG.plltype {QPLL1} \
   CONFIG.xdma_axi_intf_mm {AXI_Memory_Mapped} \
   CONFIG.xdma_axilite_slave {true} \
   CONFIG.xdma_num_usr_irq {2} \
   CONFIG.xdma_rnum_chnl {4} \
   CONFIG.xdma_wnum_chnl {4} \
 ] $xdma_0

  # Create instance: xlconcat_0, and set properties
  set xlconcat_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 xlconcat_0 ]
  set_property -dict [ list \
   CONFIG.NUM_PORTS {2} \
 ] $xlconcat_0

  # Create instance: xlslice_1, and set properties
  set xlslice_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 xlslice_1 ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {0} \
   CONFIG.DIN_TO {0} \
   CONFIG.DIN_WIDTH {2} \
   CONFIG.DOUT_WIDTH {1} \
 ] $xlslice_1

  # Create instance: xlslice_2, and set properties
  set xlslice_2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 xlslice_2 ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {1} \
   CONFIG.DIN_TO {1} \
   CONFIG.DIN_WIDTH {2} \
   CONFIG.DOUT_WIDTH {1} \
 ] $xlslice_2

  # Create interface connections
  connect_bd_intf_net -intf_net CLK_IN_D_0_1 [get_bd_intf_pins pcie_refclk] [get_bd_intf_pins util_ds_buf/CLK_IN_D]
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins pci_express_x16] [get_bd_intf_pins xdma_0/pcie_mgt]
  connect_bd_intf_net -intf_net axi_interconnect_0_M01_AXI [get_bd_intf_pins S_AXI_LITE] [get_bd_intf_pins xdma_0/S_AXI_LITE]
  connect_bd_intf_net -intf_net xdma_0_M_AXI_B [get_bd_intf_pins M_AXI_B] [get_bd_intf_pins xdma_0/M_AXI_B]

  # Create port connections
  connect_bd_net -net HN_F_Bridge_1_irq_out_0 [get_bd_pins intr_1] [get_bd_pins xlconcat_0/In1]
  connect_bd_net -net HN_F_Bridge_1_irq_out_1 [get_bd_pins intr_0] [get_bd_pins xlconcat_0/In0]
  connect_bd_net -net M00_ACLK_1 [get_bd_pins axi_aclk] [get_bd_pins xdma_0/axi_aclk]
  connect_bd_net -net S00_ARESETN_1 [get_bd_pins axi_aresetn] [get_bd_pins xdma_0/axi_aresetn]
  connect_bd_net -net pcie_perstn_1 [get_bd_pins pcie_perstn] [get_bd_pins xdma_0/sys_rst_n]
  connect_bd_net -net util_ds_buf_0_IBUF_DS_ODIV2 [get_bd_pins util_ds_buf/IBUF_DS_ODIV2] [get_bd_pins xdma_0/sys_clk]
  connect_bd_net -net util_ds_buf_0_IBUF_OUT [get_bd_pins util_ds_buf/IBUF_OUT] [get_bd_pins xdma_0/sys_clk_gt]
  connect_bd_net -net xdma_0_usr_irq_ack [get_bd_pins xdma_0/usr_irq_ack] [get_bd_pins xlslice_1/Din] [get_bd_pins xlslice_2/Din]
  connect_bd_net -net xlconcat_0_dout [get_bd_pins xdma_0/usr_irq_req] [get_bd_pins xlconcat_0/dout]
  connect_bd_net -net xlslice_1_Dout [get_bd_pins intr_ack_0] [get_bd_pins xlslice_1/Dout]
  connect_bd_net -net xlslice_2_Dout [get_bd_pins intr_ack_1] [get_bd_pins xlslice_2/Dout]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: Interconnect_fabric
proc create_hier_cell_Interconnect_fabric { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_msg_id "BD_TCL-102" "ERROR" "create_hier_cell_Interconnect_fabric() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_msg_id "BD_TCL-100" "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_msg_id "BD_TCL-101" "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M00_AXI
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M01_AXI
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M02_AXI
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M03_AXI
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M04_AXI
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M05_AXI
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M06_AXI
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M07_AXI
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M08_AXI
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S00_AXI

  # Create pins
  create_bd_pin -dir I -type clk M00_ACLK
  create_bd_pin -dir I -from 0 -to 0 -type rst M01_ARESETN
  create_bd_pin -dir I -type rst M07_ARESETN

  # Create instance: MB_XDMA_COMMON_SLV_IC, and set properties
  set MB_XDMA_COMMON_SLV_IC [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 MB_XDMA_COMMON_SLV_IC ]
  set_property -dict [ list \
   CONFIG.NUM_MI {9} \
   CONFIG.NUM_SI {1} \
 ] $MB_XDMA_COMMON_SLV_IC

  # Create interface connections
  connect_bd_intf_net -intf_net S_AXI1_1 [get_bd_intf_pins M01_AXI] [get_bd_intf_pins MB_XDMA_COMMON_SLV_IC/M01_AXI]
  connect_bd_intf_net -intf_net S_AXI1_2 [get_bd_intf_pins M04_AXI] [get_bd_intf_pins MB_XDMA_COMMON_SLV_IC/M04_AXI]
  connect_bd_intf_net -intf_net S_AXI2_1 [get_bd_intf_pins M05_AXI] [get_bd_intf_pins MB_XDMA_COMMON_SLV_IC/M05_AXI]
  connect_bd_intf_net -intf_net S_AXI3_1 [get_bd_intf_pins M06_AXI] [get_bd_intf_pins MB_XDMA_COMMON_SLV_IC/M06_AXI]
  connect_bd_intf_net -intf_net S_AXI4_1 [get_bd_intf_pins M07_AXI] [get_bd_intf_pins MB_XDMA_COMMON_SLV_IC/M07_AXI]
  connect_bd_intf_net -intf_net S_AXI5_1 [get_bd_intf_pins M08_AXI] [get_bd_intf_pins MB_XDMA_COMMON_SLV_IC/M08_AXI]
  connect_bd_intf_net -intf_net S_AXI_1 [get_bd_intf_pins M00_AXI] [get_bd_intf_pins MB_XDMA_COMMON_SLV_IC/M00_AXI]
  connect_bd_intf_net -intf_net S_AXI_2 [get_bd_intf_pins M03_AXI] [get_bd_intf_pins MB_XDMA_COMMON_SLV_IC/M03_AXI]
  connect_bd_intf_net -intf_net S_AXI_LITE_1 [get_bd_intf_pins M02_AXI] [get_bd_intf_pins MB_XDMA_COMMON_SLV_IC/M02_AXI]
  connect_bd_intf_net -intf_net Xilinx_PCIe_Tunnel_M_AXI_B [get_bd_intf_pins S00_AXI] [get_bd_intf_pins MB_XDMA_COMMON_SLV_IC/S00_AXI]

  # Create port connections
  connect_bd_net -net M00_ACLK_1 [get_bd_pins M00_ACLK] [get_bd_pins MB_XDMA_COMMON_SLV_IC/ACLK] [get_bd_pins MB_XDMA_COMMON_SLV_IC/M00_ACLK] [get_bd_pins MB_XDMA_COMMON_SLV_IC/M01_ACLK] [get_bd_pins MB_XDMA_COMMON_SLV_IC/M02_ACLK] [get_bd_pins MB_XDMA_COMMON_SLV_IC/M03_ACLK] [get_bd_pins MB_XDMA_COMMON_SLV_IC/M04_ACLK] [get_bd_pins MB_XDMA_COMMON_SLV_IC/M05_ACLK] [get_bd_pins MB_XDMA_COMMON_SLV_IC/M06_ACLK] [get_bd_pins MB_XDMA_COMMON_SLV_IC/M07_ACLK] [get_bd_pins MB_XDMA_COMMON_SLV_IC/M08_ACLK] [get_bd_pins MB_XDMA_COMMON_SLV_IC/S00_ACLK]
  connect_bd_net -net M01_ARESETN_1 [get_bd_pins M01_ARESETN] [get_bd_pins MB_XDMA_COMMON_SLV_IC/M01_ARESETN] [get_bd_pins MB_XDMA_COMMON_SLV_IC/M03_ARESETN] [get_bd_pins MB_XDMA_COMMON_SLV_IC/M04_ARESETN] [get_bd_pins MB_XDMA_COMMON_SLV_IC/M05_ARESETN] [get_bd_pins MB_XDMA_COMMON_SLV_IC/M06_ARESETN] [get_bd_pins MB_XDMA_COMMON_SLV_IC/M07_ARESETN] [get_bd_pins MB_XDMA_COMMON_SLV_IC/M08_ARESETN]
  connect_bd_net -net Xilinx_PCIe_Tunnel_axi_aresetn [get_bd_pins M07_ARESETN] [get_bd_pins MB_XDMA_COMMON_SLV_IC/ARESETN] [get_bd_pins MB_XDMA_COMMON_SLV_IC/M00_ARESETN] [get_bd_pins MB_XDMA_COMMON_SLV_IC/M02_ARESETN] [get_bd_pins MB_XDMA_COMMON_SLV_IC/S00_ARESETN]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: GPIOs
proc create_hier_cell_GPIOs { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_msg_id "BD_TCL-102" "ERROR" "create_hier_cell_GPIOs() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_msg_id "BD_TCL-100" "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_msg_id "BD_TCL-101" "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI1
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI2
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI3
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI4
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI5

  # Create pins
  create_bd_pin -dir I -from 127 -to 0 Din
  create_bd_pin -dir I -from 127 -to 0 Din1
  create_bd_pin -dir O -from 63 -to 0 dout
  create_bd_pin -dir I -type clk s_axi_aclk
  create_bd_pin -dir I -type rst s_axi_aresetn

  # Create instance: Gpio_intr_in
  create_hier_cell_Gpio_intr_in $hier_obj Gpio_intr_in

  # Create instance: Gpio_intr_out_hn_f
  create_hier_cell_Gpio_intr_out_hn_f $hier_obj Gpio_intr_out_hn_f

  # Create instance: Gpio_intr_out_rn_f
  create_hier_cell_Gpio_intr_out_rn_f $hier_obj Gpio_intr_out_rn_f

  # Create interface connections
  connect_bd_intf_net -intf_net S_AXI1_2 [get_bd_intf_pins S_AXI3] [get_bd_intf_pins Gpio_intr_in/S_AXI1]
  connect_bd_intf_net -intf_net S_AXI2_1 [get_bd_intf_pins S_AXI4] [get_bd_intf_pins Gpio_intr_out_rn_f/S_AXI]
  connect_bd_intf_net -intf_net S_AXI3_1 [get_bd_intf_pins S_AXI5] [get_bd_intf_pins Gpio_intr_out_rn_f/S_AXI1]
  connect_bd_intf_net -intf_net S_AXI4_1 [get_bd_intf_pins S_AXI] [get_bd_intf_pins Gpio_intr_out_hn_f/S_AXI]
  connect_bd_intf_net -intf_net S_AXI5_1 [get_bd_intf_pins S_AXI1] [get_bd_intf_pins Gpio_intr_out_hn_f/S_AXI1]
  connect_bd_intf_net -intf_net S_AXI_2 [get_bd_intf_pins S_AXI2] [get_bd_intf_pins Gpio_intr_in/S_AXI]

  # Create port connections
  connect_bd_net -net CHI_Bridges_Dout [get_bd_pins s_axi_aresetn] [get_bd_pins Gpio_intr_in/s_axi_aresetn] [get_bd_pins Gpio_intr_out_hn_f/s_axi_aresetn] [get_bd_pins Gpio_intr_out_rn_f/s_axi_aresetn]
  connect_bd_net -net CHI_Bridges_h2c_intr_out [get_bd_pins Din1] [get_bd_pins Gpio_intr_out_rn_f/Din]
  connect_bd_net -net Din_1 [get_bd_pins Din] [get_bd_pins Gpio_intr_out_hn_f/Din]
  connect_bd_net -net M00_ACLK_1 [get_bd_pins s_axi_aclk] [get_bd_pins Gpio_intr_in/s_axi_aclk] [get_bd_pins Gpio_intr_out_hn_f/s_axi_aclk] [get_bd_pins Gpio_intr_out_rn_f/s_axi_aclk]
  connect_bd_net -net c2h_intr_in_1 [get_bd_pins dout] [get_bd_pins Gpio_intr_in/dout]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: CHI_Bridges
proc create_hier_cell_CHI_Bridges { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_msg_id "BD_TCL-102" "ERROR" "create_hier_cell_CHI_Bridges() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_msg_id "BD_TCL-100" "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_msg_id "BD_TCL-101" "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI1

  # Create pins
  create_bd_pin -dir O -from 0 -to 0 -type rst Dout
  create_bd_pin -dir I -type clk clk
  create_bd_pin -dir O -from 127 -to 0 hn_h2c_intr_out
  create_bd_pin -dir I hn_irq_ack
  create_bd_pin -dir O hn_irq_out
  create_bd_pin -dir I -type rst resetn
  create_bd_pin -dir I -from 63 -to 0 rn_c2h_intr_in
  create_bd_pin -dir O -from 127 -to 0 rn_h2c_intr_out
  create_bd_pin -dir I rn_irq_ack
  create_bd_pin -dir O rn_irq_out

  # Create instance: chi_bridge_hn_top_0, and set properties
  set chi_bridge_hn_top_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:chi_bridge_hn_top:1.00 chi_bridge_hn_top_0 ]
  set_property -dict [ list \
   CONFIG.CHI_FLIT_DATA_WIDTH {512} \
   CONFIG.LAST_BRIDGE {0} \
 ] $chi_bridge_hn_top_0

  # Create instance: chi_bridge_rn_top_0, and set properties
  set chi_bridge_rn_top_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:chi_bridge_rn_top:1.00 chi_bridge_rn_top_0 ]
  set_property -dict [ list \
   CONFIG.LAST_BRIDGE {1} \
 ] $chi_bridge_rn_top_0

  # Create instance: xlslice_0, and set properties
  set xlslice_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 xlslice_0 ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {0} \
   CONFIG.DIN_TO {0} \
   CONFIG.DIN_WIDTH {4} \
 ] $xlslice_0

  # Create interface connections
  connect_bd_intf_net -intf_net MB_XDMA_COMMON_SLV_IC_M01_AXI [get_bd_intf_pins S_AXI1] [get_bd_intf_pins chi_bridge_hn_top_0/S_AXI]
  connect_bd_intf_net -intf_net S00_AXI_1 [get_bd_intf_pins S_AXI] [get_bd_intf_pins chi_bridge_rn_top_0/S_AXI]

  # Create port connections
  connect_bd_net -net CHI_RN_RXDATFLIT [get_bd_pins chi_bridge_hn_top_0/CHI_TXDATFLIT] [get_bd_pins chi_bridge_rn_top_0/CHI_RXDATFLIT]
  connect_bd_net -net CHI_RN_RXDATFLITPEND [get_bd_pins chi_bridge_hn_top_0/CHI_TXDATFLITPEND] [get_bd_pins chi_bridge_rn_top_0/CHI_RXDATFLITPEND]
  connect_bd_net -net CHI_RN_RXDATFLITV [get_bd_pins chi_bridge_hn_top_0/CHI_TXDATFLITV] [get_bd_pins chi_bridge_rn_top_0/CHI_RXDATFLITV]
  connect_bd_net -net CHI_RN_RXDATLCRDV [get_bd_pins chi_bridge_hn_top_0/CHI_TXDATLCRDV] [get_bd_pins chi_bridge_rn_top_0/CHI_RXDATLCRDV]
  connect_bd_net -net CHI_RN_RXLINKACTIVEACK [get_bd_pins chi_bridge_hn_top_0/CHI_TXLINKACTIVEACK] [get_bd_pins chi_bridge_rn_top_0/CHI_RXLINKACTIVEACK]
  connect_bd_net -net CHI_RN_RXLINKACTIVEREQ [get_bd_pins chi_bridge_hn_top_0/CHI_TXLINKACTIVEREQ] [get_bd_pins chi_bridge_rn_top_0/CHI_RXLINKACTIVEREQ]
  connect_bd_net -net CHI_RN_RXRSPFLIT [get_bd_pins chi_bridge_hn_top_0/CHI_TXRSPFLIT] [get_bd_pins chi_bridge_rn_top_0/CHI_RXRSPFLIT]
  connect_bd_net -net CHI_RN_RXRSPFLITPEND [get_bd_pins chi_bridge_hn_top_0/CHI_TXRSPFLITPEND] [get_bd_pins chi_bridge_rn_top_0/CHI_RXRSPFLITPEND]
  connect_bd_net -net CHI_RN_RXRSPFLITV [get_bd_pins chi_bridge_hn_top_0/CHI_TXRSPFLITV] [get_bd_pins chi_bridge_rn_top_0/CHI_RXRSPFLITV]
  connect_bd_net -net CHI_RN_RXRSPLCRDV [get_bd_pins chi_bridge_hn_top_0/CHI_TXRSPLCRDV] [get_bd_pins chi_bridge_rn_top_0/CHI_RXRSPLCRDV]
  connect_bd_net -net CHI_RN_RXSACTIVE [get_bd_pins chi_bridge_hn_top_0/CHI_TXSACTIVE] [get_bd_pins chi_bridge_rn_top_0/CHI_RXSACTIVE]
  connect_bd_net -net CHI_RN_RXSNPFLIT [get_bd_pins chi_bridge_hn_top_0/CHI_TXSNPFLIT] [get_bd_pins chi_bridge_rn_top_0/CHI_RXSNPFLIT]
  connect_bd_net -net CHI_RN_RXSNPFLITPEND [get_bd_pins chi_bridge_hn_top_0/CHI_TXSNPFLITPEND] [get_bd_pins chi_bridge_rn_top_0/CHI_RXSNPFLITPEND]
  connect_bd_net -net CHI_RN_RXSNPFLITV [get_bd_pins chi_bridge_hn_top_0/CHI_TXSNPFLITV] [get_bd_pins chi_bridge_rn_top_0/CHI_RXSNPFLITV]
  connect_bd_net -net CHI_RN_RXSNPLCRDV [get_bd_pins chi_bridge_hn_top_0/CHI_TXSNPLCRDV] [get_bd_pins chi_bridge_rn_top_0/CHI_RXSNPLCRDV]
  connect_bd_net -net CHI_RN_SYSCOACK [get_bd_pins chi_bridge_hn_top_0/CHI_SYSCOACK] [get_bd_pins chi_bridge_rn_top_0/CHI_SYSCOACK]
  connect_bd_net -net CHI_RN_SYSCOREQ [get_bd_pins chi_bridge_hn_top_0/CHI_SYSCOREQ] [get_bd_pins chi_bridge_rn_top_0/CHI_SYSCOREQ]
  connect_bd_net -net CHI_RN_TXDATFLIT [get_bd_pins chi_bridge_hn_top_0/CHI_RXDATFLIT] [get_bd_pins chi_bridge_rn_top_0/CHI_TXDATFLIT]
  connect_bd_net -net CHI_RN_TXDATFLITPEND [get_bd_pins chi_bridge_hn_top_0/CHI_RXDATFLITPEND] [get_bd_pins chi_bridge_rn_top_0/CHI_TXDATFLITPEND]
  connect_bd_net -net CHI_RN_TXDATFLITV [get_bd_pins chi_bridge_hn_top_0/CHI_RXDATFLITV] [get_bd_pins chi_bridge_rn_top_0/CHI_TXDATFLITV]
  connect_bd_net -net CHI_RN_TXDATLCRDV [get_bd_pins chi_bridge_hn_top_0/CHI_RXDATLCRDV] [get_bd_pins chi_bridge_rn_top_0/CHI_TXDATLCRDV]
  connect_bd_net -net CHI_RN_TXLINKACTIVEACK [get_bd_pins chi_bridge_hn_top_0/CHI_RXLINKACTIVEACK] [get_bd_pins chi_bridge_rn_top_0/CHI_TXLINKACTIVEACK]
  connect_bd_net -net CHI_RN_TXLINKACTIVEREQ [get_bd_pins chi_bridge_hn_top_0/CHI_RXLINKACTIVEREQ] [get_bd_pins chi_bridge_rn_top_0/CHI_TXLINKACTIVEREQ]
  connect_bd_net -net CHI_RN_TXREQFLIT [get_bd_pins chi_bridge_hn_top_0/CHI_RXREQFLIT] [get_bd_pins chi_bridge_rn_top_0/CHI_TXREQFLIT]
  connect_bd_net -net CHI_RN_TXREQFLITPEND [get_bd_pins chi_bridge_hn_top_0/CHI_RXREQFLITPEND] [get_bd_pins chi_bridge_rn_top_0/CHI_TXREQFLITPEND]
  connect_bd_net -net CHI_RN_TXREQFLITV [get_bd_pins chi_bridge_hn_top_0/CHI_RXREQFLITV] [get_bd_pins chi_bridge_rn_top_0/CHI_TXREQFLITV]
  connect_bd_net -net CHI_RN_TXREQLCRDV [get_bd_pins chi_bridge_hn_top_0/CHI_RXREQLCRDV] [get_bd_pins chi_bridge_rn_top_0/CHI_TXREQLCRDV]
  connect_bd_net -net CHI_RN_TXRSPFLIT [get_bd_pins chi_bridge_hn_top_0/CHI_RXRSPFLIT] [get_bd_pins chi_bridge_rn_top_0/CHI_TXRSPFLIT]
  connect_bd_net -net CHI_RN_TXRSPFLITPEND [get_bd_pins chi_bridge_hn_top_0/CHI_RXRSPFLITPEND] [get_bd_pins chi_bridge_rn_top_0/CHI_TXRSPFLITPEND]
  connect_bd_net -net CHI_RN_TXRSPFLITV [get_bd_pins chi_bridge_hn_top_0/CHI_RXRSPFLITV] [get_bd_pins chi_bridge_rn_top_0/CHI_TXRSPFLITV]
  connect_bd_net -net CHI_RN_TXRSPLCRDV [get_bd_pins chi_bridge_hn_top_0/CHI_RXRSPLCRDV] [get_bd_pins chi_bridge_rn_top_0/CHI_TXRSPLCRDV]
  connect_bd_net -net CHI_RN_TXSACTIVE [get_bd_pins chi_bridge_hn_top_0/CHI_RXSACTIVE] [get_bd_pins chi_bridge_rn_top_0/CHI_TXSACTIVE]
  connect_bd_net -net HN_F_Bridge_1_irq_out_0 [get_bd_pins hn_irq_out] [get_bd_pins chi_bridge_hn_top_0/irq_out]
  connect_bd_net -net HN_F_Bridge_1_irq_out_1 [get_bd_pins rn_irq_out] [get_bd_pins chi_bridge_rn_top_0/irq_out]
  connect_bd_net -net M00_ACLK_1 [get_bd_pins clk] [get_bd_pins chi_bridge_hn_top_0/clk] [get_bd_pins chi_bridge_rn_top_0/clk]
  connect_bd_net -net S00_ARESETN_1 [get_bd_pins resetn] [get_bd_pins chi_bridge_hn_top_0/resetn] [get_bd_pins chi_bridge_rn_top_0/resetn]
  connect_bd_net -net c2h_intr_in_1 [get_bd_pins rn_c2h_intr_in] [get_bd_pins chi_bridge_hn_top_0/c2h_intr_in] [get_bd_pins chi_bridge_rn_top_0/c2h_intr_in]
  connect_bd_net -net chi_bridge_hn_top_0_h2c_gpio_out [get_bd_pins chi_bridge_hn_top_0/c2h_gpio_in] [get_bd_pins chi_bridge_hn_top_0/h2c_gpio_out]
  connect_bd_net -net chi_bridge_hn_top_0_h2c_intr_out [get_bd_pins hn_h2c_intr_out] [get_bd_pins chi_bridge_hn_top_0/h2c_intr_out]
  connect_bd_net -net chi_bridge_rn_top_0_h2c_gpio_out [get_bd_pins chi_bridge_rn_top_0/c2h_gpio_in] [get_bd_pins chi_bridge_rn_top_0/h2c_gpio_out]
  connect_bd_net -net chi_bridge_rn_top_0_h2c_intr_out [get_bd_pins rn_h2c_intr_out] [get_bd_pins chi_bridge_rn_top_0/h2c_intr_out]
  connect_bd_net -net chi_bridge_rn_top_0_usr_resetn [get_bd_pins chi_bridge_rn_top_0/usr_resetn] [get_bd_pins xlslice_0/Din]
  connect_bd_net -net xlslice_0_Dout [get_bd_pins Dout] [get_bd_pins xlslice_0/Dout]
  connect_bd_net -net xlslice_1_Dout [get_bd_pins rn_irq_ack] [get_bd_pins chi_bridge_rn_top_0/irq_ack]
  connect_bd_net -net xlslice_2_Dout [get_bd_pins hn_irq_ack] [get_bd_pins chi_bridge_hn_top_0/irq_ack]

  # Restore current instance
  current_bd_instance $oldCurInst
}


# Procedure to create entire design; Provide argument to make
# procedure reusable. If parentCell is "", will use root.
proc create_root_design { parentCell } {

  variable script_folder
  variable design_name

  if { $parentCell eq "" } {
     set parentCell [get_bd_cells /]
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_msg_id "BD_TCL-100" "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_msg_id "BD_TCL-101" "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj


  # Create interface ports
  set pci_express_x16 [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:pcie_7x_mgt_rtl:1.0 pci_express_x16 ]
  set pcie_refclk [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_clock_rtl:1.0 pcie_refclk ]

  # Create ports
  set pcie_perstn [ create_bd_port -dir I -type rst pcie_perstn ]
  set_property -dict [ list \
   CONFIG.POLARITY {ACTIVE_LOW} \
 ] $pcie_perstn

  # Create instance: CHI_Bridges
  create_hier_cell_CHI_Bridges [current_bd_instance .] CHI_Bridges

  # Create instance: GPIOs
  create_hier_cell_GPIOs [current_bd_instance .] GPIOs

  # Create instance: Interconnect_fabric
  create_hier_cell_Interconnect_fabric [current_bd_instance .] Interconnect_fabric

  # Create instance: Xilinx_PCIe_Tunnel
  create_hier_cell_Xilinx_PCIe_Tunnel [current_bd_instance .] Xilinx_PCIe_Tunnel

  # Create interface connections
  connect_bd_intf_net -intf_net CLK_IN_D_0_1 [get_bd_intf_ports pcie_refclk] [get_bd_intf_pins Xilinx_PCIe_Tunnel/pcie_refclk]
  connect_bd_intf_net -intf_net S_AXI1_1 [get_bd_intf_pins CHI_Bridges/S_AXI1] [get_bd_intf_pins Interconnect_fabric/M01_AXI]
  connect_bd_intf_net -intf_net S_AXI1_2 [get_bd_intf_pins GPIOs/S_AXI3] [get_bd_intf_pins Interconnect_fabric/M04_AXI]
  connect_bd_intf_net -intf_net S_AXI2_1 [get_bd_intf_pins GPIOs/S_AXI4] [get_bd_intf_pins Interconnect_fabric/M05_AXI]
  connect_bd_intf_net -intf_net S_AXI3_1 [get_bd_intf_pins GPIOs/S_AXI5] [get_bd_intf_pins Interconnect_fabric/M06_AXI]
  connect_bd_intf_net -intf_net S_AXI4_1 [get_bd_intf_pins GPIOs/S_AXI] [get_bd_intf_pins Interconnect_fabric/M07_AXI]
  connect_bd_intf_net -intf_net S_AXI5_1 [get_bd_intf_pins GPIOs/S_AXI1] [get_bd_intf_pins Interconnect_fabric/M08_AXI]
  connect_bd_intf_net -intf_net S_AXI_1 [get_bd_intf_pins CHI_Bridges/S_AXI] [get_bd_intf_pins Interconnect_fabric/M00_AXI]
  connect_bd_intf_net -intf_net S_AXI_2 [get_bd_intf_pins GPIOs/S_AXI2] [get_bd_intf_pins Interconnect_fabric/M03_AXI]
  connect_bd_intf_net -intf_net S_AXI_LITE_1 [get_bd_intf_pins Interconnect_fabric/M02_AXI] [get_bd_intf_pins Xilinx_PCIe_Tunnel/S_AXI_LITE]
  connect_bd_intf_net -intf_net Xilinx_PCIe_Tunnel_M_AXI_B [get_bd_intf_pins Interconnect_fabric/S00_AXI] [get_bd_intf_pins Xilinx_PCIe_Tunnel/M_AXI_B]
  connect_bd_intf_net -intf_net Xilinx_PCIe_Tunnel_pci_express_x16 [get_bd_intf_ports pci_express_x16] [get_bd_intf_pins Xilinx_PCIe_Tunnel/pci_express_x16]

  # Create port connections
  connect_bd_net -net CHI_Bridges_Dout [get_bd_pins CHI_Bridges/Dout] [get_bd_pins GPIOs/s_axi_aresetn] [get_bd_pins Interconnect_fabric/M01_ARESETN]
  connect_bd_net -net CHI_Bridges_h2c_intr_out [get_bd_pins CHI_Bridges/rn_h2c_intr_out] [get_bd_pins GPIOs/Din1]
  connect_bd_net -net CHI_Bridges_irq_out [get_bd_pins CHI_Bridges/rn_irq_out] [get_bd_pins Xilinx_PCIe_Tunnel/intr_0]
  connect_bd_net -net Din_1 [get_bd_pins CHI_Bridges/hn_h2c_intr_out] [get_bd_pins GPIOs/Din]
  connect_bd_net -net HN_F_Bridge_1_irq_out_0 [get_bd_pins CHI_Bridges/hn_irq_out] [get_bd_pins Xilinx_PCIe_Tunnel/intr_1]
  connect_bd_net -net M00_ACLK_1 [get_bd_pins CHI_Bridges/clk] [get_bd_pins GPIOs/s_axi_aclk] [get_bd_pins Interconnect_fabric/M00_ACLK] [get_bd_pins Xilinx_PCIe_Tunnel/axi_aclk]
  connect_bd_net -net Xilinx_PCIe_Tunnel_axi_aresetn [get_bd_pins CHI_Bridges/resetn] [get_bd_pins Interconnect_fabric/M07_ARESETN] [get_bd_pins Xilinx_PCIe_Tunnel/axi_aresetn]
  connect_bd_net -net c2h_intr_in_1 [get_bd_pins CHI_Bridges/rn_c2h_intr_in] [get_bd_pins GPIOs/dout]
  connect_bd_net -net pcie_perstn_1 [get_bd_ports pcie_perstn] [get_bd_pins Xilinx_PCIe_Tunnel/pcie_perstn]
  connect_bd_net -net xlslice_1_Dout [get_bd_pins CHI_Bridges/rn_irq_ack] [get_bd_pins Xilinx_PCIe_Tunnel/intr_ack_0]
  connect_bd_net -net xlslice_2_Dout [get_bd_pins CHI_Bridges/hn_irq_ack] [get_bd_pins Xilinx_PCIe_Tunnel/intr_ack_1]

  # Create address segments
  create_bd_addr_seg -range 0x00001000 -offset 0x20000000 [get_bd_addr_spaces Xilinx_PCIe_Tunnel/xdma_0/M_AXI_B] [get_bd_addr_segs GPIOs/Gpio_intr_in/axi_gpio_0/S_AXI/Reg] SEG_axi_gpio_0_Reg
  create_bd_addr_seg -range 0x00001000 -offset 0x20002000 [get_bd_addr_spaces Xilinx_PCIe_Tunnel/xdma_0/M_AXI_B] [get_bd_addr_segs GPIOs/Gpio_intr_out_rn_f/axi_gpio_2/S_AXI/Reg] SEG_axi_gpio_2_Reg
  create_bd_addr_seg -range 0x00001000 -offset 0x20004000 [get_bd_addr_spaces Xilinx_PCIe_Tunnel/xdma_0/M_AXI_B] [get_bd_addr_segs GPIOs/Gpio_intr_out_hn_f/axi_gpio_2/S_AXI/Reg] SEG_axi_gpio_2_Reg1
  create_bd_addr_seg -range 0x00001000 -offset 0x20003000 [get_bd_addr_spaces Xilinx_PCIe_Tunnel/xdma_0/M_AXI_B] [get_bd_addr_segs GPIOs/Gpio_intr_out_rn_f/axi_gpio_3/S_AXI/Reg] SEG_axi_gpio_3_Reg
  create_bd_addr_seg -range 0x00001000 -offset 0x20005000 [get_bd_addr_spaces Xilinx_PCIe_Tunnel/xdma_0/M_AXI_B] [get_bd_addr_segs GPIOs/Gpio_intr_out_hn_f/axi_gpio_3/S_AXI/Reg] SEG_axi_gpio_3_Reg1
  create_bd_addr_seg -range 0x00020000 -offset 0xC0000000 [get_bd_addr_spaces Xilinx_PCIe_Tunnel/xdma_0/M_AXI_B] [get_bd_addr_segs CHI_Bridges/chi_bridge_hn_top_0/S_AXI/Mem] SEG_chi_bridge_hn_top_0_Mem
  create_bd_addr_seg -range 0x00020000 -offset 0xC0020000 [get_bd_addr_spaces Xilinx_PCIe_Tunnel/xdma_0/M_AXI_B] [get_bd_addr_segs CHI_Bridges/chi_bridge_rn_top_0/S_AXI/Mem] SEG_chi_bridge_rn_top_0_Mem
  create_bd_addr_seg -range 0x00001000 -offset 0x200A0000 [get_bd_addr_spaces Xilinx_PCIe_Tunnel/xdma_0/M_AXI_B] [get_bd_addr_segs Xilinx_PCIe_Tunnel/xdma_0/S_AXI_LITE/CTL0] SEG_xdma_0_CTL0


  # Restore current instance
  current_bd_instance $oldCurInst

  validate_bd_design
  save_bd_design
}
# End of create_root_design()


##################################################################
# MAIN FLOW
##################################################################

create_root_design ""


