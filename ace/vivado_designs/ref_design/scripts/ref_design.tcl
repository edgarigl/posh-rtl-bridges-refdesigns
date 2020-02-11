
################################################################
# This is a generated script based on design: ref_design
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
# source ref_design_script.tcl

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
set design_name ref_design

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
xilinx.com:ip:proc_sys_reset:5.0\
xilinx.com:ip:util_ds_buf:2.1\
xilinx.com:ip:xdma:4.1\
xilinx.com:ip:ace_mst:1.00\
xilinx.com:ip:ace_slv:1.00\
xilinx.com:ip:system_cache:4.0\
xilinx.com:ip:axi_traffic_gen:3.0\
xilinx.com:ip:xlconcat:2.1\
xilinx.com:ip:xlslice:1.0\
xilinx.com:ip:axi_gpio:2.0\
xilinx.com:ip:xlconstant:1.1\
xilinx.com:ip:axi_bram_ctrl:4.1\
xilinx.com:ip:blk_mem_gen:8.4\
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


# Hierarchical cell: Memory
proc create_hier_cell_Memory { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_msg_id "BD_TCL-102" "ERROR" "create_hier_cell_Memory() - Empty argument(s)!"}
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

  # Create pins
  create_bd_pin -dir I -type clk s_axi_aclk
  create_bd_pin -dir I -type rst s_axi_aresetn

  # Create instance: axi_bram_ctrl_0, and set properties
  set axi_bram_ctrl_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_bram_ctrl:4.1 axi_bram_ctrl_0 ]
  set_property -dict [ list \
   CONFIG.SINGLE_PORT_BRAM {1} \
 ] $axi_bram_ctrl_0

  # Create instance: blk_mem_gen_0, and set properties
  set blk_mem_gen_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.4 blk_mem_gen_0 ]

  # Create interface connections
  connect_bd_intf_net -intf_net XDMA_M_AXI_IC_M02_AXI [get_bd_intf_pins S_AXI] [get_bd_intf_pins axi_bram_ctrl_0/S_AXI]
  connect_bd_intf_net -intf_net axi_bram_ctrl_0_BRAM_PORTA1 [get_bd_intf_pins axi_bram_ctrl_0/BRAM_PORTA] [get_bd_intf_pins blk_mem_gen_0/BRAM_PORTA]

  # Create port connections
  connect_bd_net -net S00_ARESETN_1 [get_bd_pins s_axi_aresetn] [get_bd_pins axi_bram_ctrl_0/s_axi_aresetn]
  connect_bd_net -net xdma_0_axi_aclk [get_bd_pins s_axi_aclk] [get_bd_pins axi_bram_ctrl_0/s_axi_aclk]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: INTR_GPIO
proc create_hier_cell_INTR_GPIO { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_msg_id "BD_TCL-102" "ERROR" "create_hier_cell_INTR_GPIO() - Empty argument(s)!"}
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
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S00_AXI

  # Create pins
  create_bd_pin -dir I -type clk ACLK
  create_bd_pin -dir I -type rst ARESETN
  create_bd_pin -dir I -from 127 -to 0 Din
  create_bd_pin -dir I -from 127 -to 0 Din1
  create_bd_pin -dir O -from 63 -to 0 dout
  create_bd_pin -dir O -from 63 -to 0 dout1
  create_bd_pin -dir O -from 63 -to 0 dout2
  create_bd_pin -dir O -from 255 -to 0 dout3
  create_bd_pin -dir O -from 0 -to 0 dout4

  # Create instance: AXI_GPIO_ICN, and set properties
  set AXI_GPIO_ICN [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 AXI_GPIO_ICN ]
  set_property -dict [ list \
   CONFIG.M00_HAS_REGSLICE {1} \
   CONFIG.M01_HAS_REGSLICE {1} \
   CONFIG.M02_HAS_REGSLICE {1} \
   CONFIG.M03_HAS_REGSLICE {1} \
   CONFIG.M04_HAS_REGSLICE {1} \
   CONFIG.M05_HAS_REGSLICE {1} \
   CONFIG.M06_HAS_REGSLICE {1} \
   CONFIG.M07_HAS_REGSLICE {1} \
   CONFIG.M08_HAS_REGSLICE {1} \
   CONFIG.M09_HAS_REGSLICE {1} \
   CONFIG.NUM_MI {6} \
   CONFIG.S00_HAS_REGSLICE {1} \
 ] $AXI_GPIO_ICN

  # Create instance: mst_axi_gpio_c2h, and set properties
  set mst_axi_gpio_c2h [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 mst_axi_gpio_c2h ]
  set_property -dict [ list \
   CONFIG.C_ALL_OUTPUTS {1} \
   CONFIG.C_ALL_OUTPUTS_2 {1} \
   CONFIG.C_GPIO_WIDTH {32} \
   CONFIG.C_IS_DUAL {1} \
 ] $mst_axi_gpio_c2h

  # Create instance: mst_axi_gpio_h2c0, and set properties
  set mst_axi_gpio_h2c0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 mst_axi_gpio_h2c0 ]
  set_property -dict [ list \
   CONFIG.C_ALL_INPUTS {1} \
   CONFIG.C_ALL_INPUTS_2 {1} \
   CONFIG.C_IS_DUAL {1} \
 ] $mst_axi_gpio_h2c0

  # Create instance: mst_axi_gpio_h2c1, and set properties
  set mst_axi_gpio_h2c1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 mst_axi_gpio_h2c1 ]
  set_property -dict [ list \
   CONFIG.C_ALL_INPUTS {1} \
   CONFIG.C_ALL_INPUTS_2 {1} \
   CONFIG.C_IS_DUAL {1} \
 ] $mst_axi_gpio_h2c1

  # Create instance: slv_axi_gpio_c2h, and set properties
  set slv_axi_gpio_c2h [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 slv_axi_gpio_c2h ]
  set_property -dict [ list \
   CONFIG.C_ALL_OUTPUTS {1} \
   CONFIG.C_ALL_OUTPUTS_2 {1} \
   CONFIG.C_GPIO_WIDTH {32} \
   CONFIG.C_IS_DUAL {1} \
 ] $slv_axi_gpio_c2h

  # Create instance: slv_axi_gpio_h2c0, and set properties
  set slv_axi_gpio_h2c0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 slv_axi_gpio_h2c0 ]
  set_property -dict [ list \
   CONFIG.C_ALL_INPUTS {1} \
   CONFIG.C_ALL_INPUTS_2 {1} \
   CONFIG.C_IS_DUAL {1} \
 ] $slv_axi_gpio_h2c0

  # Create instance: slv_axi_gpio_h2c1, and set properties
  set slv_axi_gpio_h2c1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 slv_axi_gpio_h2c1 ]
  set_property -dict [ list \
   CONFIG.C_ALL_INPUTS {1} \
   CONFIG.C_ALL_INPUTS_2 {1} \
   CONFIG.C_IS_DUAL {1} \
 ] $slv_axi_gpio_h2c1

  # Create instance: xlconcat_1, and set properties
  set xlconcat_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 xlconcat_1 ]
  set_property -dict [ list \
   CONFIG.IN0_WIDTH {32} \
   CONFIG.IN1_WIDTH {32} \
   CONFIG.IN2_WIDTH {1} \
   CONFIG.IN3_WIDTH {1} \
   CONFIG.NUM_PORTS {2} \
 ] $xlconcat_1

  # Create instance: xlconcat_2, and set properties
  set xlconcat_2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 xlconcat_2 ]
  set_property -dict [ list \
   CONFIG.IN0_WIDTH {32} \
   CONFIG.IN1_WIDTH {32} \
   CONFIG.IN2_WIDTH {1} \
   CONFIG.IN3_WIDTH {1} \
   CONFIG.NUM_PORTS {2} \
 ] $xlconcat_2

  # Create instance: xlconstant_0, and set properties
  set xlconstant_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_0 ]
  set_property -dict [ list \
   CONFIG.CONST_VAL {0} \
   CONFIG.CONST_WIDTH {64} \
 ] $xlconstant_0

  # Create instance: xlconstant_1, and set properties
  set xlconstant_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_1 ]
  set_property -dict [ list \
   CONFIG.CONST_VAL {0} \
   CONFIG.CONST_WIDTH {256} \
 ] $xlconstant_1

  # Create instance: xlconstant_2, and set properties
  set xlconstant_2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_2 ]
  set_property -dict [ list \
   CONFIG.CONST_VAL {0} \
   CONFIG.CONST_WIDTH {1} \
 ] $xlconstant_2

  # Create instance: xlslice_4, and set properties
  set xlslice_4 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 xlslice_4 ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {31} \
   CONFIG.DIN_TO {0} \
   CONFIG.DIN_WIDTH {128} \
   CONFIG.DOUT_WIDTH {32} \
 ] $xlslice_4

  # Create instance: xlslice_5, and set properties
  set xlslice_5 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 xlslice_5 ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {63} \
   CONFIG.DIN_TO {32} \
   CONFIG.DIN_WIDTH {128} \
   CONFIG.DOUT_WIDTH {1} \
 ] $xlslice_5

  # Create instance: xlslice_6, and set properties
  set xlslice_6 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 xlslice_6 ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {95} \
   CONFIG.DIN_TO {64} \
   CONFIG.DIN_WIDTH {128} \
   CONFIG.DOUT_WIDTH {1} \
 ] $xlslice_6

  # Create instance: xlslice_7, and set properties
  set xlslice_7 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 xlslice_7 ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {127} \
   CONFIG.DIN_TO {96} \
   CONFIG.DIN_WIDTH {128} \
   CONFIG.DOUT_WIDTH {1} \
 ] $xlslice_7

  # Create instance: xlslice_8, and set properties
  set xlslice_8 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 xlslice_8 ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {31} \
   CONFIG.DIN_TO {0} \
   CONFIG.DIN_WIDTH {128} \
   CONFIG.DOUT_WIDTH {32} \
 ] $xlslice_8

  # Create instance: xlslice_9, and set properties
  set xlslice_9 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 xlslice_9 ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {63} \
   CONFIG.DIN_TO {32} \
   CONFIG.DIN_WIDTH {128} \
   CONFIG.DOUT_WIDTH {1} \
 ] $xlslice_9

  # Create instance: xlslice_10, and set properties
  set xlslice_10 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 xlslice_10 ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {95} \
   CONFIG.DIN_TO {64} \
   CONFIG.DIN_WIDTH {128} \
   CONFIG.DOUT_WIDTH {1} \
 ] $xlslice_10

  # Create instance: xlslice_11, and set properties
  set xlslice_11 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 xlslice_11 ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {127} \
   CONFIG.DIN_TO {96} \
   CONFIG.DIN_WIDTH {128} \
   CONFIG.DOUT_WIDTH {1} \
 ] $xlslice_11

  # Create interface connections
  connect_bd_intf_net -intf_net AXI4_128_Config_M00_AXI [get_bd_intf_pins AXI_GPIO_ICN/M00_AXI] [get_bd_intf_pins mst_axi_gpio_h2c1/S_AXI]
  connect_bd_intf_net -intf_net AXI4_128_Config_M01_AXI [get_bd_intf_pins AXI_GPIO_ICN/M01_AXI] [get_bd_intf_pins slv_axi_gpio_h2c0/S_AXI]
  connect_bd_intf_net -intf_net AXI4_128_Config_M02_AXI [get_bd_intf_pins AXI_GPIO_ICN/M02_AXI] [get_bd_intf_pins mst_axi_gpio_h2c0/S_AXI]
  connect_bd_intf_net -intf_net AXI4_128_Config_M03_AXI [get_bd_intf_pins AXI_GPIO_ICN/M03_AXI] [get_bd_intf_pins slv_axi_gpio_h2c1/S_AXI]
  connect_bd_intf_net -intf_net AXI4_128_Config_M04_AXI [get_bd_intf_pins AXI_GPIO_ICN/M04_AXI] [get_bd_intf_pins slv_axi_gpio_c2h/S_AXI]
  connect_bd_intf_net -intf_net AXI_GPIO_ICN_M05_AXI [get_bd_intf_pins AXI_GPIO_ICN/M05_AXI] [get_bd_intf_pins mst_axi_gpio_c2h/S_AXI]
  connect_bd_intf_net -intf_net S00_AXI_2 [get_bd_intf_pins S00_AXI] [get_bd_intf_pins AXI_GPIO_ICN/S00_AXI]

  # Create port connections
  connect_bd_net -net Net1 [get_bd_pins Din] [get_bd_pins xlslice_10/Din] [get_bd_pins xlslice_11/Din] [get_bd_pins xlslice_8/Din] [get_bd_pins xlslice_9/Din]
  connect_bd_net -net S00_ARESETN_1 [get_bd_pins ARESETN] [get_bd_pins AXI_GPIO_ICN/ARESETN] [get_bd_pins AXI_GPIO_ICN/M00_ARESETN] [get_bd_pins AXI_GPIO_ICN/M01_ARESETN] [get_bd_pins AXI_GPIO_ICN/M02_ARESETN] [get_bd_pins AXI_GPIO_ICN/M03_ARESETN] [get_bd_pins AXI_GPIO_ICN/M04_ARESETN] [get_bd_pins AXI_GPIO_ICN/M05_ARESETN] [get_bd_pins AXI_GPIO_ICN/S00_ARESETN] [get_bd_pins mst_axi_gpio_c2h/s_axi_aresetn] [get_bd_pins mst_axi_gpio_h2c0/s_axi_aresetn] [get_bd_pins mst_axi_gpio_h2c1/s_axi_aresetn] [get_bd_pins slv_axi_gpio_c2h/s_axi_aresetn] [get_bd_pins slv_axi_gpio_h2c0/s_axi_aresetn] [get_bd_pins slv_axi_gpio_h2c1/s_axi_aresetn]
  connect_bd_net -net axi4_128_master_0_h2c_intr_out [get_bd_pins Din1] [get_bd_pins xlslice_4/Din] [get_bd_pins xlslice_5/Din] [get_bd_pins xlslice_6/Din] [get_bd_pins xlslice_7/Din]
  connect_bd_net -net axi_gpio_0_gpio2_io_o [get_bd_pins dout1] [get_bd_pins xlconcat_1/dout]
  connect_bd_net -net axi_gpio_0_gpio2_io_o1 [get_bd_pins slv_axi_gpio_c2h/gpio2_io_o] [get_bd_pins xlconcat_1/In1]
  connect_bd_net -net axi_gpio_0_gpio_io_o1 [get_bd_pins slv_axi_gpio_c2h/gpio_io_o] [get_bd_pins xlconcat_1/In0]
  connect_bd_net -net mst_axi_gpio_c2h_gpio2_io_o [get_bd_pins mst_axi_gpio_c2h/gpio2_io_o] [get_bd_pins xlconcat_2/In1]
  connect_bd_net -net mst_axi_gpio_c2h_gpio_io_o [get_bd_pins mst_axi_gpio_c2h/gpio_io_o] [get_bd_pins xlconcat_2/In0]
  connect_bd_net -net xdma_0_axi_aclk [get_bd_pins ACLK] [get_bd_pins AXI_GPIO_ICN/ACLK] [get_bd_pins AXI_GPIO_ICN/M00_ACLK] [get_bd_pins AXI_GPIO_ICN/M01_ACLK] [get_bd_pins AXI_GPIO_ICN/M02_ACLK] [get_bd_pins AXI_GPIO_ICN/M03_ACLK] [get_bd_pins AXI_GPIO_ICN/M04_ACLK] [get_bd_pins AXI_GPIO_ICN/M05_ACLK] [get_bd_pins AXI_GPIO_ICN/S00_ACLK] [get_bd_pins mst_axi_gpio_c2h/s_axi_aclk] [get_bd_pins mst_axi_gpio_h2c0/s_axi_aclk] [get_bd_pins mst_axi_gpio_h2c1/s_axi_aclk] [get_bd_pins slv_axi_gpio_c2h/s_axi_aclk] [get_bd_pins slv_axi_gpio_h2c0/s_axi_aclk] [get_bd_pins slv_axi_gpio_h2c1/s_axi_aclk]
  connect_bd_net -net xlconcat_2_dout [get_bd_pins dout] [get_bd_pins xlconcat_2/dout]
  connect_bd_net -net xlconstant_0_dout [get_bd_pins dout2] [get_bd_pins xlconstant_0/dout]
  connect_bd_net -net xlconstant_1_dout [get_bd_pins dout3] [get_bd_pins xlconstant_1/dout]
  connect_bd_net -net xlconstant_2_dout [get_bd_pins dout4] [get_bd_pins xlconstant_2/dout]
  connect_bd_net -net xlslice_10_Dout [get_bd_pins mst_axi_gpio_h2c1/gpio_io_i] [get_bd_pins xlslice_10/Dout]
  connect_bd_net -net xlslice_11_Dout [get_bd_pins mst_axi_gpio_h2c1/gpio2_io_i] [get_bd_pins xlslice_11/Dout]
  connect_bd_net -net xlslice_4_Dout [get_bd_pins slv_axi_gpio_h2c0/gpio_io_i] [get_bd_pins xlslice_4/Dout]
  connect_bd_net -net xlslice_5_Dout [get_bd_pins slv_axi_gpio_h2c0/gpio2_io_i] [get_bd_pins xlslice_5/Dout]
  connect_bd_net -net xlslice_6_Dout [get_bd_pins slv_axi_gpio_h2c1/gpio_io_i] [get_bd_pins xlslice_6/Dout]
  connect_bd_net -net xlslice_7_Dout [get_bd_pins slv_axi_gpio_h2c1/gpio2_io_i] [get_bd_pins xlslice_7/Dout]
  connect_bd_net -net xlslice_8_Dout [get_bd_pins mst_axi_gpio_h2c0/gpio_io_i] [get_bd_pins xlslice_8/Dout]
  connect_bd_net -net xlslice_9_Dout [get_bd_pins mst_axi_gpio_h2c0/gpio2_io_i] [get_bd_pins xlslice_9/Dout]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: Bridge_DUT
proc create_hier_cell_Bridge_DUT { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_msg_id "BD_TCL-102" "ERROR" "create_hier_cell_Bridge_DUT() - Empty argument(s)!"}
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
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M_AXI
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M_AXI1
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M_AXI2
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI1
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI2
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI3
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI_CTRL

  # Create pins
  create_bd_pin -dir I -from 2 -to 0 Din
  create_bd_pin -dir I -from 255 -to 0 c2h_gpio_in
  create_bd_pin -dir I -from 63 -to 0 c2h_intr_in
  create_bd_pin -dir I -from 63 -to 0 c2h_intr_in1
  create_bd_pin -dir I -from 63 -to 0 c2h_intr_in2
  create_bd_pin -dir I -type clk clk
  create_bd_pin -dir O -from 2 -to 0 dout
  create_bd_pin -dir O -from 127 -to 0 h2c_intr_out
  create_bd_pin -dir O -from 127 -to 0 h2c_intr_out1
  create_bd_pin -dir I -type rst resetn
  create_bd_pin -dir I s_ace_usr_awunique
  create_bd_pin -dir O -from 0 -to 0 -type rst usr_resetn

  # Create instance: ACE_MST_BRIDGE_B2B, and set properties
  set ACE_MST_BRIDGE_B2B [ create_bd_cell -type ip -vlnv xilinx.com:ip:ace_mst:1.00 ACE_MST_BRIDGE_B2B ]
  set_property -dict [ list \
   CONFIG.USR_RST_NUM {1} \
 ] $ACE_MST_BRIDGE_B2B

  # Create instance: ACE_SLV_BRIDGE_0, and set properties
  set ACE_SLV_BRIDGE_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:ace_slv:1.00 ACE_SLV_BRIDGE_0 ]
  set_property -dict [ list \
   CONFIG.LAST_BRIDGE {1} \
   CONFIG.USR_RST_NUM {1} \
 ] $ACE_SLV_BRIDGE_0

  # Create instance: ACE_SLV_BRIDGE_B2B, and set properties
  set ACE_SLV_BRIDGE_B2B [ create_bd_cell -type ip -vlnv xilinx.com:ip:ace_slv:1.00 ACE_SLV_BRIDGE_B2B ]
  set_property -dict [ list \
   CONFIG.USR_RST_NUM {1} \
 ] $ACE_SLV_BRIDGE_B2B

  # Create instance: SC_as_ACE_Master, and set properties
  set SC_as_ACE_Master [ create_bd_cell -type ip -vlnv xilinx.com:ip:system_cache:4.0 SC_as_ACE_Master ]
  set_property -dict [ list \
   CONFIG.C_CACHE_DATA_WIDTH {128} \
   CONFIG.C_ENABLE_COHERENCY {2} \
   CONFIG.C_ENABLE_CTRL {1} \
   CONFIG.C_ENABLE_EXCLUSIVE {0} \
   CONFIG.C_ENABLE_NON_SECURE {1} \
   CONFIG.C_ENABLE_STATISTICS {2} \
   CONFIG.C_M0_AXI_DATA_WIDTH {128} \
   CONFIG.C_M0_AXI_THREAD_ID_WIDTH {16} \
   CONFIG.C_NUM_GENERIC_PORTS {1} \
   CONFIG.C_NUM_OPTIMIZED_PORTS {0} \
   CONFIG.C_S0_AXI_GEN_DATA_WIDTH {128} \
   CONFIG.C_S0_AXI_GEN_PROHIBIT_WRITE_ALLOCATE {0} \
 ] $SC_as_ACE_Master

  # Create instance: axi_traffic_gen_0, and set properties
  set axi_traffic_gen_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_traffic_gen:3.0 axi_traffic_gen_0 ]
  set_property -dict [ list \
   CONFIG.C_M_AXI_ARUSER_WIDTH {16} \
   CONFIG.C_M_AXI_AWUSER_WIDTH {16} \
   CONFIG.C_M_AXI_DATA_WIDTH {128} \
   CONFIG.C_M_AXI_THREAD_ID_WIDTH {4} \
 ] $axi_traffic_gen_0

  # Create instance: xlconcat_0, and set properties
  set xlconcat_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 xlconcat_0 ]
  set_property -dict [ list \
   CONFIG.NUM_PORTS {3} \
 ] $xlconcat_0

  # Create instance: xlslice_ace_icn_0, and set properties
  set xlslice_ace_icn_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 xlslice_ace_icn_0 ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {0} \
   CONFIG.DIN_TO {0} \
   CONFIG.DIN_WIDTH {3} \
 ] $xlslice_ace_icn_0

  # Create instance: xlslice_ace_icn_b2b, and set properties
  set xlslice_ace_icn_b2b [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 xlslice_ace_icn_b2b ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {1} \
   CONFIG.DIN_TO {1} \
   CONFIG.DIN_WIDTH {3} \
   CONFIG.DOUT_WIDTH {1} \
 ] $xlslice_ace_icn_b2b

  # Create instance: xlslice_ace_mst_b2b, and set properties
  set xlslice_ace_mst_b2b [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 xlslice_ace_mst_b2b ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {2} \
   CONFIG.DIN_TO {2} \
   CONFIG.DIN_WIDTH {3} \
   CONFIG.DOUT_WIDTH {1} \
 ] $xlslice_ace_mst_b2b

  # Create interface connections
  connect_bd_intf_net -intf_net ACE_MST_BRIDGE_2_M_ACE_USR [get_bd_intf_pins ACE_MST_BRIDGE_B2B/M_ACE_USR] [get_bd_intf_pins ACE_SLV_BRIDGE_B2B/S_ACE_USR]
  connect_bd_intf_net -intf_net ACE_MST_BRIDGE_B2B_M_AXI [get_bd_intf_pins M_AXI] [get_bd_intf_pins ACE_MST_BRIDGE_B2B/M_AXI]
  connect_bd_intf_net -intf_net ACE_SLV_BRIDGE_0_M_AXI [get_bd_intf_pins M_AXI2] [get_bd_intf_pins ACE_SLV_BRIDGE_0/M_AXI]
  connect_bd_intf_net -intf_net ACE_SLV_BRIDGE_B2B_M_AXI [get_bd_intf_pins M_AXI1] [get_bd_intf_pins ACE_SLV_BRIDGE_B2B/M_AXI]
  connect_bd_intf_net -intf_net MB_XDMA_COMMON_SLAVES_IC_M00_AXI [get_bd_intf_pins S_AXI3] [get_bd_intf_pins ACE_SLV_BRIDGE_0/S_AXI]
  connect_bd_intf_net -intf_net XDMA_COMMON_SLAVES_IC_M02_AXI [get_bd_intf_pins S_AXI1] [get_bd_intf_pins axi_traffic_gen_0/S_AXI]
  connect_bd_intf_net -intf_net XDMA_COMMON_SLAVES_IC_M03_AXI [get_bd_intf_pins S_AXI_CTRL] [get_bd_intf_pins SC_as_ACE_Master/S_AXI_CTRL]
  connect_bd_intf_net -intf_net XDMA_COMMON_SLAVES_IC_M04_AXI [get_bd_intf_pins S_AXI2] [get_bd_intf_pins ACE_SLV_BRIDGE_B2B/S_AXI]
  connect_bd_intf_net -intf_net XDMA_COMMON_SLAVES_IC_M05_AXI [get_bd_intf_pins S_AXI] [get_bd_intf_pins ACE_MST_BRIDGE_B2B/S_AXI]
  connect_bd_intf_net -intf_net axi_traffic_gen_0_M_AXI [get_bd_intf_pins SC_as_ACE_Master/S0_AXI_GEN] [get_bd_intf_pins axi_traffic_gen_0/M_AXI]
  connect_bd_intf_net -intf_net system_cache_0_M0_ACE [get_bd_intf_pins ACE_SLV_BRIDGE_0/S_ACE_USR] [get_bd_intf_pins SC_as_ACE_Master/M0_ACE]

  # Create port connections
  connect_bd_net -net ACE_MST_BRIDGE_B2B_h2c_gpio_out [get_bd_pins ACE_MST_BRIDGE_B2B/c2h_gpio_in] [get_bd_pins ACE_MST_BRIDGE_B2B/h2c_gpio_out]
  connect_bd_net -net ACE_MST_BRIDGE_B2B_m_ace_usr_awunique [get_bd_pins ACE_MST_BRIDGE_B2B/m_ace_usr_awunique] [get_bd_pins ACE_SLV_BRIDGE_B2B/s_ace_usr_awunique]
  connect_bd_net -net ACE_SLV_BRIDGE_0_irq_out [get_bd_pins ACE_SLV_BRIDGE_0/irq_out] [get_bd_pins xlconcat_0/In0]
  connect_bd_net -net ACE_SLV_BRIDGE_0_usr_resetn [get_bd_pins usr_resetn] [get_bd_pins ACE_SLV_BRIDGE_0/usr_resetn] [get_bd_pins SC_as_ACE_Master/ARESETN] [get_bd_pins axi_traffic_gen_0/s_axi_aresetn]
  connect_bd_net -net ACE_SLV_BRIDGE_B2B_h2c_gpio_out [get_bd_pins ACE_SLV_BRIDGE_B2B/c2h_gpio_in] [get_bd_pins ACE_SLV_BRIDGE_B2B/h2c_gpio_out]
  connect_bd_net -net Bridges_irq_out [get_bd_pins ACE_MST_BRIDGE_B2B/irq_out] [get_bd_pins xlconcat_0/In2]
  connect_bd_net -net Bridges_irq_out1 [get_bd_pins ACE_SLV_BRIDGE_B2B/irq_out] [get_bd_pins xlconcat_0/In1]
  connect_bd_net -net INTR_GPIO_dout2 [get_bd_pins c2h_intr_in2] [get_bd_pins ACE_SLV_BRIDGE_0/c2h_intr_in]
  connect_bd_net -net INTR_GPIO_dout3 [get_bd_pins c2h_gpio_in] [get_bd_pins ACE_SLV_BRIDGE_0/c2h_gpio_in]
  connect_bd_net -net INTR_GPIO_dout4 [get_bd_pins s_ace_usr_awunique] [get_bd_pins ACE_SLV_BRIDGE_0/s_ace_usr_awunique]
  connect_bd_net -net Net1 [get_bd_pins h2c_intr_out] [get_bd_pins ACE_MST_BRIDGE_B2B/h2c_intr_out]
  connect_bd_net -net S00_ARESETN_1 [get_bd_pins resetn] [get_bd_pins ACE_MST_BRIDGE_B2B/resetn] [get_bd_pins ACE_SLV_BRIDGE_0/resetn] [get_bd_pins ACE_SLV_BRIDGE_B2B/resetn]
  connect_bd_net -net axi4_128_master_0_h2c_intr_out [get_bd_pins h2c_intr_out1] [get_bd_pins ACE_SLV_BRIDGE_B2B/h2c_intr_out]
  connect_bd_net -net axi_gpio_0_gpio2_io_o [get_bd_pins c2h_intr_in1] [get_bd_pins ACE_SLV_BRIDGE_B2B/c2h_intr_in]
  connect_bd_net -net irq_ack_1 [get_bd_pins Din] [get_bd_pins xlslice_ace_icn_0/Din] [get_bd_pins xlslice_ace_icn_b2b/Din] [get_bd_pins xlslice_ace_mst_b2b/Din]
  connect_bd_net -net xdma_0_axi_aclk [get_bd_pins clk] [get_bd_pins ACE_MST_BRIDGE_B2B/clk] [get_bd_pins ACE_SLV_BRIDGE_0/clk] [get_bd_pins ACE_SLV_BRIDGE_B2B/clk] [get_bd_pins SC_as_ACE_Master/ACLK] [get_bd_pins axi_traffic_gen_0/s_axi_aclk]
  connect_bd_net -net xlconcat_0_dout [get_bd_pins dout] [get_bd_pins xlconcat_0/dout]
  connect_bd_net -net xlconcat_2_dout [get_bd_pins c2h_intr_in] [get_bd_pins ACE_MST_BRIDGE_B2B/c2h_intr_in]
  connect_bd_net -net xlslice_0_Dout [get_bd_pins ACE_SLV_BRIDGE_0/irq_ack] [get_bd_pins xlslice_ace_icn_0/Dout]
  connect_bd_net -net xlslice_12_Dout [get_bd_pins ACE_MST_BRIDGE_B2B/irq_ack] [get_bd_pins xlslice_ace_mst_b2b/Dout]
  connect_bd_net -net xlslice_3_Dout [get_bd_pins ACE_SLV_BRIDGE_B2B/irq_ack] [get_bd_pins xlslice_ace_icn_b2b/Dout]

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
  set pcie_mgt_0 [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:pcie_7x_mgt_rtl:1.0 pcie_mgt_0 ]
  set pcie_refclk [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_clock_rtl:1.0 pcie_refclk ]
  set_property -dict [ list \
   CONFIG.FREQ_HZ {100000000} \
   ] $pcie_refclk

  # Create ports
  set pcie_perstn [ create_bd_port -dir I -type rst pcie_perstn ]
  set_property -dict [ list \
   CONFIG.POLARITY {ACTIVE_LOW} \
 ] $pcie_perstn

  # Create instance: Bridge_DUT
  create_hier_cell_Bridge_DUT [current_bd_instance .] Bridge_DUT

  # Create instance: INTR_GPIO
  create_hier_cell_INTR_GPIO [current_bd_instance .] INTR_GPIO

  # Create instance: Memory
  create_hier_cell_Memory [current_bd_instance .] Memory

  # Create instance: XDMA_COMMON_SLAVES_IC, and set properties
  set XDMA_COMMON_SLAVES_IC [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 XDMA_COMMON_SLAVES_IC ]
  set_property -dict [ list \
   CONFIG.M00_HAS_REGSLICE {4} \
   CONFIG.M01_HAS_REGSLICE {4} \
   CONFIG.M02_HAS_REGSLICE {4} \
   CONFIG.M03_HAS_REGSLICE {4} \
   CONFIG.M04_HAS_REGSLICE {4} \
   CONFIG.M05_HAS_REGSLICE {4} \
   CONFIG.M06_HAS_REGSLICE {4} \
   CONFIG.M07_HAS_REGSLICE {4} \
   CONFIG.M08_HAS_REGSLICE {4} \
   CONFIG.M09_HAS_REGSLICE {4} \
   CONFIG.NUM_MI {6} \
   CONFIG.NUM_SI {1} \
   CONFIG.S00_HAS_REGSLICE {4} \
   CONFIG.S01_HAS_REGSLICE {4} \
 ] $XDMA_COMMON_SLAVES_IC

  # Create instance: XDMA_M_AXI_IC, and set properties
  set XDMA_M_AXI_IC [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 XDMA_M_AXI_IC ]
  set_property -dict [ list \
   CONFIG.NUM_MI {2} \
   CONFIG.NUM_SI {1} \
 ] $XDMA_M_AXI_IC

  # Create instance: XDMA_S_AXIB_IC, and set properties
  set XDMA_S_AXIB_IC [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 XDMA_S_AXIB_IC ]
  set_property -dict [ list \
   CONFIG.M00_HAS_REGSLICE {4} \
   CONFIG.NUM_MI {1} \
   CONFIG.NUM_SI {3} \
   CONFIG.S00_HAS_REGSLICE {4} \
   CONFIG.S01_HAS_REGSLICE {4} \
   CONFIG.S02_HAS_REGSLICE {4} \
   CONFIG.S03_HAS_REGSLICE {4} \
   CONFIG.S04_HAS_REGSLICE {4} \
 ] $XDMA_S_AXIB_IC

  # Create instance: rst_clk_wiz, and set properties
  set rst_clk_wiz [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 rst_clk_wiz ]

  # Create instance: util_ds_buf, and set properties
  set util_ds_buf [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_ds_buf:2.1 util_ds_buf ]
  set_property -dict [ list \
   CONFIG.C_BUF_TYPE {IBUFDSGTE} \
   CONFIG.DIFF_CLK_IN_BOARD_INTERFACE {pcie_refclk} \
   CONFIG.USE_BOARD_FLOW {true} \
 ] $util_ds_buf

  # Create instance: xdma_0, and set properties
  set xdma_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xdma:4.1 xdma_0 ]
  set_property -dict [ list \
   CONFIG.PCIE_BOARD_INTERFACE {pci_express_x1} \
   CONFIG.PF0_DEVICE_ID_mqdma {9011} \
   CONFIG.PF2_DEVICE_ID_mqdma {9011} \
   CONFIG.PF3_DEVICE_ID_mqdma {9011} \
   CONFIG.SYS_RST_N_BOARD_INTERFACE {pcie_perstn} \
   CONFIG.axi_addr_width {64} \
   CONFIG.axi_data_width {64_bit} \
   CONFIG.axisten_freq {125} \
   CONFIG.bar_indicator {BAR_1:0} \
   CONFIG.coreclk_freq {250} \
   CONFIG.en_axi_slave_if {true} \
   CONFIG.en_gt_selection {true} \
   CONFIG.functional_mode {AXI_Bridge} \
   CONFIG.mode_selection {Advanced} \
   CONFIG.pciebar2axibar_0 {0x00000000B0000000} \
   CONFIG.pciebar2axibar_1 {0x0000000000000000} \
   CONFIG.pciebar2axibar_2 {0x0000000020000000} \
   CONFIG.pciebar2axibar_4 {0x00000000C0000000} \
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
   CONFIG.pf0_device_id {9011} \
   CONFIG.pf0_msi_enabled {false} \
   CONFIG.pf0_msix_cap_pba_bir {BAR_1:0} \
   CONFIG.pf0_msix_cap_table_bir {BAR_1:0} \
   CONFIG.pf0_sub_class_interface_menu {Flash} \
   CONFIG.pl_link_cap_max_link_speed {2.5_GT/s} \
   CONFIG.pl_link_cap_max_link_width {X1} \
   CONFIG.plltype {CPLL} \
   CONFIG.xdma_axi_intf_mm {AXI_Memory_Mapped} \
   CONFIG.xdma_axilite_slave {true} \
   CONFIG.xdma_num_usr_irq {3} \
   CONFIG.xdma_rnum_chnl {4} \
   CONFIG.xdma_wnum_chnl {4} \
 ] $xdma_0

  # Create interface connections
  connect_bd_intf_net -intf_net ACE_MST_BRIDGE_B2B_M_AXI [get_bd_intf_pins Bridge_DUT/M_AXI] [get_bd_intf_pins XDMA_S_AXIB_IC/S02_AXI]
  connect_bd_intf_net -intf_net ACE_SLV_BRIDGE_0_M_AXI [get_bd_intf_pins Bridge_DUT/M_AXI2] [get_bd_intf_pins XDMA_S_AXIB_IC/S00_AXI]
  connect_bd_intf_net -intf_net ACE_SLV_BRIDGE_B2B_M_AXI [get_bd_intf_pins Bridge_DUT/M_AXI1] [get_bd_intf_pins XDMA_S_AXIB_IC/S01_AXI]
  connect_bd_intf_net -intf_net Bridges_M00_AXI [get_bd_intf_pins XDMA_S_AXIB_IC/M00_AXI] [get_bd_intf_pins xdma_0/S_AXI_B]
  connect_bd_intf_net -intf_net MB_XDMA_COMMON_SLAVES_IC_M00_AXI [get_bd_intf_pins Bridge_DUT/S_AXI3] [get_bd_intf_pins XDMA_COMMON_SLAVES_IC/M00_AXI]
  connect_bd_intf_net -intf_net XDMA_COMMON_SLAVES_IC_M01_AXI [get_bd_intf_pins INTR_GPIO/S00_AXI] [get_bd_intf_pins XDMA_COMMON_SLAVES_IC/M01_AXI]
  connect_bd_intf_net -intf_net XDMA_COMMON_SLAVES_IC_M02_AXI [get_bd_intf_pins Bridge_DUT/S_AXI1] [get_bd_intf_pins XDMA_COMMON_SLAVES_IC/M02_AXI]
  connect_bd_intf_net -intf_net XDMA_COMMON_SLAVES_IC_M03_AXI [get_bd_intf_pins Bridge_DUT/S_AXI_CTRL] [get_bd_intf_pins XDMA_COMMON_SLAVES_IC/M03_AXI]
  connect_bd_intf_net -intf_net XDMA_COMMON_SLAVES_IC_M04_AXI [get_bd_intf_pins Bridge_DUT/S_AXI2] [get_bd_intf_pins XDMA_COMMON_SLAVES_IC/M04_AXI]
  connect_bd_intf_net -intf_net XDMA_COMMON_SLAVES_IC_M05_AXI [get_bd_intf_pins Bridge_DUT/S_AXI] [get_bd_intf_pins XDMA_COMMON_SLAVES_IC/M05_AXI]
  connect_bd_intf_net -intf_net XDMA_M_AXI_IC_M00_AXI [get_bd_intf_pins Memory/S_AXI] [get_bd_intf_pins XDMA_M_AXI_IC/M00_AXI]
  connect_bd_intf_net -intf_net XDMA_M_AXI_IC_M01_AXI [get_bd_intf_pins XDMA_COMMON_SLAVES_IC/S00_AXI] [get_bd_intf_pins XDMA_M_AXI_IC/M01_AXI]
  connect_bd_intf_net -intf_net pcie_refclk_1 [get_bd_intf_ports pcie_refclk] [get_bd_intf_pins util_ds_buf/CLK_IN_D]
  connect_bd_intf_net -intf_net xdma_0_M_AXI_B [get_bd_intf_pins XDMA_M_AXI_IC/S00_AXI] [get_bd_intf_pins xdma_0/M_AXI_B]
  connect_bd_intf_net -intf_net xdma_0_pcie_mgt [get_bd_intf_ports pcie_mgt_0] [get_bd_intf_pins xdma_0/pcie_mgt]

  # Create port connections
  connect_bd_net -net ACE_SLV_BRIDGE_0_usr_resetn [get_bd_pins Bridge_DUT/usr_resetn] [get_bd_pins XDMA_COMMON_SLAVES_IC/M02_ARESETN] [get_bd_pins XDMA_COMMON_SLAVES_IC/M03_ARESETN]
  connect_bd_net -net INTR_GPIO_dout2 [get_bd_pins Bridge_DUT/c2h_intr_in2] [get_bd_pins INTR_GPIO/dout2]
  connect_bd_net -net INTR_GPIO_dout3 [get_bd_pins Bridge_DUT/c2h_gpio_in] [get_bd_pins INTR_GPIO/dout3]
  connect_bd_net -net INTR_GPIO_dout4 [get_bd_pins Bridge_DUT/s_ace_usr_awunique] [get_bd_pins INTR_GPIO/dout4]
  connect_bd_net -net M02_ARESETN_1 [get_bd_pins XDMA_COMMON_SLAVES_IC/S00_ARESETN] [get_bd_pins XDMA_M_AXI_IC/ARESETN] [get_bd_pins XDMA_M_AXI_IC/M00_ARESETN] [get_bd_pins XDMA_M_AXI_IC/M01_ARESETN] [get_bd_pins XDMA_M_AXI_IC/S00_ARESETN] [get_bd_pins XDMA_S_AXIB_IC/M00_ARESETN] [get_bd_pins rst_clk_wiz/interconnect_aresetn]
  connect_bd_net -net Net [get_bd_pins rst_clk_wiz/aux_reset_in] [get_bd_pins rst_clk_wiz/ext_reset_in] [get_bd_pins xdma_0/axi_aresetn]
  connect_bd_net -net Net1 [get_bd_pins Bridge_DUT/h2c_intr_out] [get_bd_pins INTR_GPIO/Din]
  connect_bd_net -net S00_ARESETN_1 [get_bd_pins Bridge_DUT/resetn] [get_bd_pins INTR_GPIO/ARESETN] [get_bd_pins Memory/s_axi_aresetn] [get_bd_pins XDMA_COMMON_SLAVES_IC/ARESETN] [get_bd_pins XDMA_COMMON_SLAVES_IC/M00_ARESETN] [get_bd_pins XDMA_COMMON_SLAVES_IC/M01_ARESETN] [get_bd_pins XDMA_COMMON_SLAVES_IC/M04_ARESETN] [get_bd_pins XDMA_COMMON_SLAVES_IC/M05_ARESETN] [get_bd_pins XDMA_S_AXIB_IC/ARESETN] [get_bd_pins XDMA_S_AXIB_IC/S00_ARESETN] [get_bd_pins XDMA_S_AXIB_IC/S01_ARESETN] [get_bd_pins XDMA_S_AXIB_IC/S02_ARESETN] [get_bd_pins rst_clk_wiz/peripheral_aresetn]
  connect_bd_net -net axi4_128_master_0_h2c_intr_out [get_bd_pins Bridge_DUT/h2c_intr_out1] [get_bd_pins INTR_GPIO/Din1]
  connect_bd_net -net axi_gpio_0_gpio2_io_o [get_bd_pins Bridge_DUT/c2h_intr_in1] [get_bd_pins INTR_GPIO/dout1]
  connect_bd_net -net irq_ack_1 [get_bd_pins Bridge_DUT/Din] [get_bd_pins xdma_0/usr_irq_ack]
  connect_bd_net -net pcie_perstn_1 [get_bd_ports pcie_perstn] [get_bd_pins xdma_0/sys_rst_n]
  connect_bd_net -net util_ds_buf_IBUF_DS_ODIV2 [get_bd_pins util_ds_buf/IBUF_DS_ODIV2] [get_bd_pins xdma_0/sys_clk]
  connect_bd_net -net util_ds_buf_IBUF_OUT [get_bd_pins util_ds_buf/IBUF_OUT] [get_bd_pins xdma_0/sys_clk_gt]
  connect_bd_net -net xdma_0_axi_aclk [get_bd_pins Bridge_DUT/clk] [get_bd_pins INTR_GPIO/ACLK] [get_bd_pins Memory/s_axi_aclk] [get_bd_pins XDMA_COMMON_SLAVES_IC/ACLK] [get_bd_pins XDMA_COMMON_SLAVES_IC/M00_ACLK] [get_bd_pins XDMA_COMMON_SLAVES_IC/M01_ACLK] [get_bd_pins XDMA_COMMON_SLAVES_IC/M02_ACLK] [get_bd_pins XDMA_COMMON_SLAVES_IC/M03_ACLK] [get_bd_pins XDMA_COMMON_SLAVES_IC/M04_ACLK] [get_bd_pins XDMA_COMMON_SLAVES_IC/M05_ACLK] [get_bd_pins XDMA_COMMON_SLAVES_IC/S00_ACLK] [get_bd_pins XDMA_M_AXI_IC/ACLK] [get_bd_pins XDMA_M_AXI_IC/M00_ACLK] [get_bd_pins XDMA_M_AXI_IC/M01_ACLK] [get_bd_pins XDMA_M_AXI_IC/S00_ACLK] [get_bd_pins XDMA_S_AXIB_IC/ACLK] [get_bd_pins XDMA_S_AXIB_IC/M00_ACLK] [get_bd_pins XDMA_S_AXIB_IC/S00_ACLK] [get_bd_pins XDMA_S_AXIB_IC/S01_ACLK] [get_bd_pins XDMA_S_AXIB_IC/S02_ACLK] [get_bd_pins rst_clk_wiz/slowest_sync_clk] [get_bd_pins xdma_0/axi_aclk]
  connect_bd_net -net xlconcat_0_dout [get_bd_pins Bridge_DUT/dout] [get_bd_pins xdma_0/usr_irq_req]
  connect_bd_net -net xlconcat_2_dout [get_bd_pins Bridge_DUT/c2h_intr_in] [get_bd_pins INTR_GPIO/dout]

  # Create address segments
  create_bd_addr_seg -range 0x00020000 -offset 0xB0000000 [get_bd_addr_spaces xdma_0/M_AXI_B] [get_bd_addr_segs Bridge_DUT/ACE_MST_BRIDGE_B2B/S_AXI/Mem] SEG_ACE_MST_BRIDGE_2_Mem
  create_bd_addr_seg -range 0x00020000 -offset 0xB0040000 [get_bd_addr_spaces xdma_0/M_AXI_B] [get_bd_addr_segs Bridge_DUT/ACE_SLV_BRIDGE_0/S_AXI/Mem] SEG_ACE_SLV_BRIDGE_0_Mem
  create_bd_addr_seg -range 0x00020000 -offset 0xB0020000 [get_bd_addr_spaces xdma_0/M_AXI_B] [get_bd_addr_segs Bridge_DUT/ACE_SLV_BRIDGE_B2B/S_AXI/Mem] SEG_ACE_SLV_BRIDGE_1_Mem
  create_bd_addr_seg -range 0x00020000 -offset 0x200E0000 [get_bd_addr_spaces xdma_0/M_AXI_B] [get_bd_addr_segs Bridge_DUT/SC_as_ACE_Master/S_AXI_CTRL/Reg] SEG_SC_as_ACE_Master_Reg
  create_bd_addr_seg -range 0x00080000 -offset 0x20000000 [get_bd_addr_spaces xdma_0/M_AXI_B] [get_bd_addr_segs Memory/axi_bram_ctrl_0/S_AXI/Mem0] SEG_axi_bram_ctrl_0_Mem0
  create_bd_addr_seg -range 0x00001000 -offset 0x20082000 [get_bd_addr_spaces xdma_0/M_AXI_B] [get_bd_addr_segs INTR_GPIO/slv_axi_gpio_h2c1/S_AXI/Reg] SEG_axi_gpio_0_1_Reg40
  create_bd_addr_seg -range 0x00001000 -offset 0x20080000 [get_bd_addr_spaces xdma_0/M_AXI_B] [get_bd_addr_segs INTR_GPIO/slv_axi_gpio_c2h/S_AXI/Reg] SEG_axi_gpio_0_Reg
  create_bd_addr_seg -range 0x00001000 -offset 0x20081000 [get_bd_addr_spaces xdma_0/M_AXI_B] [get_bd_addr_segs INTR_GPIO/slv_axi_gpio_h2c0/S_AXI/Reg] SEG_axi_gpio_0_Reg38
  create_bd_addr_seg -range 0x00001000 -offset 0x20084000 [get_bd_addr_spaces xdma_0/M_AXI_B] [get_bd_addr_segs INTR_GPIO/mst_axi_gpio_h2c0/S_AXI/Reg] SEG_axi_gpio_1_1_Reg44
  create_bd_addr_seg -range 0x00001000 -offset 0x20083000 [get_bd_addr_spaces xdma_0/M_AXI_B] [get_bd_addr_segs INTR_GPIO/mst_axi_gpio_h2c1/S_AXI/Reg] SEG_axi_gpio_1_Reg42
  create_bd_addr_seg -range 0x00010000 -offset 0x20120000 [get_bd_addr_spaces xdma_0/M_AXI_B] [get_bd_addr_segs Bridge_DUT/axi_traffic_gen_0/S_AXI/Reg0] SEG_axi_traffic_gen_0_Reg0
  create_bd_addr_seg -range 0x00001000 -offset 0x20085000 [get_bd_addr_spaces xdma_0/M_AXI_B] [get_bd_addr_segs INTR_GPIO/mst_axi_gpio_c2h/S_AXI/Reg] SEG_mst_axi_gpio_c2h_Reg
  create_bd_addr_seg -range 0x00010000000000000000 -offset 0x00000000 [get_bd_addr_spaces Bridge_DUT/ACE_MST_BRIDGE_B2B/M_ACE_USR] [get_bd_addr_segs Bridge_DUT/ACE_SLV_BRIDGE_B2B/S_ACE_USR/Mem] SEG_ACE_SLV_BRIDGE_1_Mem
  create_bd_addr_seg -range 0x00010000000000000000 -offset 0x00000000 [get_bd_addr_spaces Bridge_DUT/ACE_MST_BRIDGE_B2B/M_AXI] [get_bd_addr_segs xdma_0/S_AXI_B/BAR0] SEG_xdma_0_BAR0
  create_bd_addr_seg -range 0x00010000000000000000 -offset 0x00000000 [get_bd_addr_spaces Bridge_DUT/ACE_SLV_BRIDGE_0/M_AXI] [get_bd_addr_segs xdma_0/S_AXI_B/BAR0] SEG_xdma_0_BAR0
  create_bd_addr_seg -range 0x00010000000000000000 -offset 0x00000000 [get_bd_addr_spaces Bridge_DUT/ACE_SLV_BRIDGE_B2B/M_AXI] [get_bd_addr_segs xdma_0/S_AXI_B/BAR0] SEG_xdma_0_BAR0
  create_bd_addr_seg -range 0x000100000000 -offset 0x00000000 [get_bd_addr_spaces Bridge_DUT/axi_traffic_gen_0/Data] [get_bd_addr_segs Bridge_DUT/ACE_SLV_BRIDGE_0/S_ACE_USR/Mem] SEG_ACE_SLV_BRIDGE_0_Mem


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


