
################################################################
# This is a generated script based on design: u250_pcie_ep
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
# source u250_pcie_ep_script.tcl

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
set design_name u250_pcie_ep

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
xilinx.com:ip:pcie_ep:1.00\
xilinx.com:ip:axi_cdma:4.1\
xilinx.com:ip:blk_mem_gen:8.4\
xilinx.com:ip:axi_bram_ctrl:4.1\
xilinx.com:ip:axi_gpio:2.0\
xilinx.com:ip:xlconcat:2.1\
xilinx.com:ip:xlslice:1.0\
xilinx.com:ip:proc_sys_reset:5.0\
xilinx.com:ip:util_ds_buf:2.1\
xilinx.com:ip:xdma:4.1\
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
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI_B
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI_LITE
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:pcie_7x_mgt_rtl:1.0 pci_express_x16
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:diff_clock_rtl:1.0 pcie_refclk

  # Create pins
  create_bd_pin -dir O -type clk axi_aclk
  create_bd_pin -dir O -type rst axi_aresetn
  create_bd_pin -dir I -type rst pcie_perstn
  create_bd_pin -dir O -from 1 -to 0 usr_irq_ack
  create_bd_pin -dir I -from 1 -to 0 usr_irq_req

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
   CONFIG.en_axi_slave_if {true} \
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

  # Create interface connections
  connect_bd_intf_net -intf_net XDMA_S_AXI_M02_AXI [get_bd_intf_pins S_AXI_LITE] [get_bd_intf_pins xdma_0/S_AXI_LITE]
  connect_bd_intf_net -intf_net axi_interconnect_0_M00_AXI [get_bd_intf_pins S_AXI_B] [get_bd_intf_pins xdma_0/S_AXI_B]
  connect_bd_intf_net -intf_net pcie_refclk_1 [get_bd_intf_pins pcie_refclk] [get_bd_intf_pins util_ds_buf/CLK_IN_D]
  connect_bd_intf_net -intf_net xdma_0_M_AXI_B [get_bd_intf_pins M_AXI_B] [get_bd_intf_pins xdma_0/M_AXI_B]
  connect_bd_intf_net -intf_net xdma_0_pcie_mgt [get_bd_intf_pins pci_express_x16] [get_bd_intf_pins xdma_0/pcie_mgt]

  # Create port connections
  connect_bd_net -net M00_ACLK_1 [get_bd_pins axi_aclk] [get_bd_pins xdma_0/axi_aclk]
  connect_bd_net -net clk_wiz_1_locked [get_bd_pins axi_aresetn] [get_bd_pins xdma_0/axi_aresetn]
  connect_bd_net -net pcie_perstn_1 [get_bd_pins pcie_perstn] [get_bd_pins xdma_0/sys_rst_n]
  connect_bd_net -net usr_irq_req_1 [get_bd_pins usr_irq_req] [get_bd_pins xdma_0/usr_irq_req]
  connect_bd_net -net util_ds_buf_IBUF_DS_ODIV2 [get_bd_pins util_ds_buf/IBUF_DS_ODIV2] [get_bd_pins xdma_0/sys_clk]
  connect_bd_net -net util_ds_buf_IBUF_OUT [get_bd_pins util_ds_buf/IBUF_OUT] [get_bd_pins xdma_0/sys_clk_gt]
  connect_bd_net -net xdma_0_usr_irq_ack1 [get_bd_pins usr_irq_ack] [get_bd_pins xdma_0/usr_irq_ack]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: Fabric_Interconnect
proc create_hier_cell_Fabric_Interconnect { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_msg_id "BD_TCL-102" "ERROR" "create_hier_cell_Fabric_Interconnect() - Empty argument(s)!"}
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
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M00_AXI1
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M00_AXI2
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M00_AXI3
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M00_AXI4
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M01_AXI
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M01_AXI1
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M02_AXI1
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S00_AXI
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S00_AXI1
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S00_AXI2
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S00_AXI3
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S01_AXI

  # Create pins
  create_bd_pin -dir I -type clk ACLK
  create_bd_pin -dir I -type rst ARESETN
  create_bd_pin -dir I -type rst S00_ARESETN

  # Create instance: AXI4_128_Bridge_Config_IC, and set properties
  set AXI4_128_Bridge_Config_IC [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 AXI4_128_Bridge_Config_IC ]
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
   CONFIG.NUM_MI {11} \
   CONFIG.S00_HAS_REGSLICE {1} \
 ] $AXI4_128_Bridge_Config_IC

  # Create instance: BRAM_IC, and set properties
  set BRAM_IC [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 BRAM_IC ]
  set_property -dict [ list \
   CONFIG.NUM_MI {1} \
   CONFIG.NUM_SI {2} \
 ] $BRAM_IC

  # Create instance: BRIDGE_AXI4_128_XDMA_S_AXI_IC, and set properties
  set BRIDGE_AXI4_128_XDMA_S_AXI_IC [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 BRIDGE_AXI4_128_XDMA_S_AXI_IC ]
  set_property -dict [ list \
   CONFIG.NUM_MI {1} \
   CONFIG.NUM_SI {7} \
 ] $BRIDGE_AXI4_128_XDMA_S_AXI_IC

  # Create instance: CDMA_BRAM_IC, and set properties
  set CDMA_BRAM_IC [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 CDMA_BRAM_IC ]
  set_property -dict [ list \
   CONFIG.NUM_MI {2} \
   CONFIG.NUM_SI {6} \
 ] $CDMA_BRAM_IC

  # Create instance: SLAVE_AXI4_128_USR_BRAM_IC, and set properties
  set SLAVE_AXI4_128_USR_BRAM_IC [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 SLAVE_AXI4_128_USR_BRAM_IC ]
  set_property -dict [ list \
   CONFIG.NUM_MI {2} \
   CONFIG.NUM_SI {1} \
 ] $SLAVE_AXI4_128_USR_BRAM_IC

  # Create instance: XDMA_M_AXI_IC, and set properties
  set XDMA_M_AXI_IC [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 XDMA_M_AXI_IC ]
  set_property -dict [ list \
   CONFIG.NUM_MI {3} \
   CONFIG.NUM_SI {1} \
 ] $XDMA_M_AXI_IC

  # Create interface connections
  connect_bd_intf_net -intf_net ATG_DMA_IC_M00_AXI [get_bd_intf_pins M00_AXI2] [get_bd_intf_pins SLAVE_AXI4_128_USR_BRAM_IC/M00_AXI]
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins S00_AXI3] [get_bd_intf_pins BRIDGE_AXI4_128_XDMA_S_AXI_IC/S00_AXI]
  connect_bd_intf_net -intf_net Conn2 [get_bd_intf_pins S01_AXI] [get_bd_intf_pins BRIDGE_AXI4_128_XDMA_S_AXI_IC/S01_AXI]
  connect_bd_intf_net -intf_net Conn8 [get_bd_intf_pins M00_AXI1] [get_bd_intf_pins AXI4_128_Bridge_Config_IC/M00_AXI]
  connect_bd_intf_net -intf_net Conn9 [get_bd_intf_pins M01_AXI] [get_bd_intf_pins AXI4_128_Bridge_Config_IC/M01_AXI]
  connect_bd_intf_net -intf_net Conn15 [get_bd_intf_pins S00_AXI1] [get_bd_intf_pins CDMA_BRAM_IC/S00_AXI]
  connect_bd_intf_net -intf_net MASTER_AXI4_128_IC_M01_AXI [get_bd_intf_pins BRAM_IC/S01_AXI] [get_bd_intf_pins CDMA_BRAM_IC/M01_AXI]
  connect_bd_intf_net -intf_net MASTER_USR_IC_M00_AXI [get_bd_intf_pins M00_AXI3] [get_bd_intf_pins CDMA_BRAM_IC/M00_AXI]
  connect_bd_intf_net -intf_net Posh_Master_M01_AXI [get_bd_intf_pins M01_AXI1] [get_bd_intf_pins XDMA_M_AXI_IC/M01_AXI]
  connect_bd_intf_net -intf_net S00_AXI_1 [get_bd_intf_pins S00_AXI] [get_bd_intf_pins SLAVE_AXI4_128_USR_BRAM_IC/S00_AXI]
  connect_bd_intf_net -intf_net SLAVE_AXI4_128_USR_IC_M01_AXI [get_bd_intf_pins BRAM_IC/S00_AXI] [get_bd_intf_pins SLAVE_AXI4_128_USR_BRAM_IC/M01_AXI]
  connect_bd_intf_net -intf_net XDMA_S_AXI_M00_AXI [get_bd_intf_pins AXI4_128_Bridge_Config_IC/S00_AXI] [get_bd_intf_pins XDMA_M_AXI_IC/M00_AXI]
  connect_bd_intf_net -intf_net XDMA_S_AXI_M02_AXI [get_bd_intf_pins M02_AXI1] [get_bd_intf_pins XDMA_M_AXI_IC/M02_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_0_M00_AXI [get_bd_intf_pins M00_AXI4] [get_bd_intf_pins BRIDGE_AXI4_128_XDMA_S_AXI_IC/M00_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_0_M00_AXI_1 [get_bd_intf_pins M00_AXI] [get_bd_intf_pins BRAM_IC/M00_AXI]
  connect_bd_intf_net -intf_net xdma_0_M_AXI_B [get_bd_intf_pins S00_AXI2] [get_bd_intf_pins XDMA_M_AXI_IC/S00_AXI]

  # Create port connections
  connect_bd_net -net M00_ACLK_1 [get_bd_pins ACLK] [get_bd_pins AXI4_128_Bridge_Config_IC/ACLK] [get_bd_pins AXI4_128_Bridge_Config_IC/M00_ACLK] [get_bd_pins AXI4_128_Bridge_Config_IC/M01_ACLK] [get_bd_pins AXI4_128_Bridge_Config_IC/M02_ACLK] [get_bd_pins AXI4_128_Bridge_Config_IC/M03_ACLK] [get_bd_pins AXI4_128_Bridge_Config_IC/M04_ACLK] [get_bd_pins AXI4_128_Bridge_Config_IC/M05_ACLK] [get_bd_pins AXI4_128_Bridge_Config_IC/M06_ACLK] [get_bd_pins AXI4_128_Bridge_Config_IC/M07_ACLK] [get_bd_pins AXI4_128_Bridge_Config_IC/M08_ACLK] [get_bd_pins AXI4_128_Bridge_Config_IC/M09_ACLK] [get_bd_pins AXI4_128_Bridge_Config_IC/M10_ACLK] [get_bd_pins AXI4_128_Bridge_Config_IC/S00_ACLK] [get_bd_pins BRAM_IC/ACLK] [get_bd_pins BRAM_IC/M00_ACLK] [get_bd_pins BRAM_IC/S00_ACLK] [get_bd_pins BRAM_IC/S01_ACLK] [get_bd_pins BRIDGE_AXI4_128_XDMA_S_AXI_IC/ACLK] [get_bd_pins BRIDGE_AXI4_128_XDMA_S_AXI_IC/M00_ACLK] [get_bd_pins BRIDGE_AXI4_128_XDMA_S_AXI_IC/S00_ACLK] [get_bd_pins BRIDGE_AXI4_128_XDMA_S_AXI_IC/S01_ACLK] [get_bd_pins BRIDGE_AXI4_128_XDMA_S_AXI_IC/S02_ACLK] [get_bd_pins BRIDGE_AXI4_128_XDMA_S_AXI_IC/S03_ACLK] [get_bd_pins BRIDGE_AXI4_128_XDMA_S_AXI_IC/S04_ACLK] [get_bd_pins BRIDGE_AXI4_128_XDMA_S_AXI_IC/S05_ACLK] [get_bd_pins BRIDGE_AXI4_128_XDMA_S_AXI_IC/S06_ACLK] [get_bd_pins CDMA_BRAM_IC/ACLK] [get_bd_pins CDMA_BRAM_IC/M00_ACLK] [get_bd_pins CDMA_BRAM_IC/M01_ACLK] [get_bd_pins CDMA_BRAM_IC/S00_ACLK] [get_bd_pins CDMA_BRAM_IC/S01_ACLK] [get_bd_pins CDMA_BRAM_IC/S02_ACLK] [get_bd_pins CDMA_BRAM_IC/S03_ACLK] [get_bd_pins CDMA_BRAM_IC/S04_ACLK] [get_bd_pins CDMA_BRAM_IC/S05_ACLK] [get_bd_pins SLAVE_AXI4_128_USR_BRAM_IC/ACLK] [get_bd_pins SLAVE_AXI4_128_USR_BRAM_IC/M00_ACLK] [get_bd_pins SLAVE_AXI4_128_USR_BRAM_IC/M01_ACLK] [get_bd_pins SLAVE_AXI4_128_USR_BRAM_IC/S00_ACLK] [get_bd_pins XDMA_M_AXI_IC/ACLK] [get_bd_pins XDMA_M_AXI_IC/M00_ACLK] [get_bd_pins XDMA_M_AXI_IC/M01_ACLK] [get_bd_pins XDMA_M_AXI_IC/M02_ACLK] [get_bd_pins XDMA_M_AXI_IC/S00_ACLK]
  connect_bd_net -net S00_ARESETN_1 [get_bd_pins ARESETN] [get_bd_pins AXI4_128_Bridge_Config_IC/ARESETN] [get_bd_pins AXI4_128_Bridge_Config_IC/M00_ARESETN] [get_bd_pins AXI4_128_Bridge_Config_IC/M01_ARESETN] [get_bd_pins AXI4_128_Bridge_Config_IC/M02_ARESETN] [get_bd_pins AXI4_128_Bridge_Config_IC/M03_ARESETN] [get_bd_pins AXI4_128_Bridge_Config_IC/M04_ARESETN] [get_bd_pins AXI4_128_Bridge_Config_IC/M05_ARESETN] [get_bd_pins AXI4_128_Bridge_Config_IC/M06_ARESETN] [get_bd_pins AXI4_128_Bridge_Config_IC/M07_ARESETN] [get_bd_pins AXI4_128_Bridge_Config_IC/M08_ARESETN] [get_bd_pins AXI4_128_Bridge_Config_IC/M09_ARESETN] [get_bd_pins AXI4_128_Bridge_Config_IC/M10_ARESETN] [get_bd_pins AXI4_128_Bridge_Config_IC/S00_ARESETN] [get_bd_pins SLAVE_AXI4_128_USR_BRAM_IC/M00_ARESETN] [get_bd_pins XDMA_M_AXI_IC/ARESETN] [get_bd_pins XDMA_M_AXI_IC/M00_ARESETN] [get_bd_pins XDMA_M_AXI_IC/M01_ARESETN] [get_bd_pins XDMA_M_AXI_IC/M02_ARESETN] [get_bd_pins XDMA_M_AXI_IC/S00_ARESETN]
  connect_bd_net -net util_reduced_logic_0_Res [get_bd_pins S00_ARESETN] [get_bd_pins BRAM_IC/ARESETN] [get_bd_pins BRAM_IC/M00_ARESETN] [get_bd_pins BRAM_IC/S00_ARESETN] [get_bd_pins BRAM_IC/S01_ARESETN] [get_bd_pins BRIDGE_AXI4_128_XDMA_S_AXI_IC/ARESETN] [get_bd_pins BRIDGE_AXI4_128_XDMA_S_AXI_IC/M00_ARESETN] [get_bd_pins BRIDGE_AXI4_128_XDMA_S_AXI_IC/S00_ARESETN] [get_bd_pins BRIDGE_AXI4_128_XDMA_S_AXI_IC/S01_ARESETN] [get_bd_pins BRIDGE_AXI4_128_XDMA_S_AXI_IC/S02_ARESETN] [get_bd_pins BRIDGE_AXI4_128_XDMA_S_AXI_IC/S03_ARESETN] [get_bd_pins BRIDGE_AXI4_128_XDMA_S_AXI_IC/S04_ARESETN] [get_bd_pins BRIDGE_AXI4_128_XDMA_S_AXI_IC/S05_ARESETN] [get_bd_pins BRIDGE_AXI4_128_XDMA_S_AXI_IC/S06_ARESETN] [get_bd_pins CDMA_BRAM_IC/ARESETN] [get_bd_pins CDMA_BRAM_IC/M00_ARESETN] [get_bd_pins CDMA_BRAM_IC/M01_ARESETN] [get_bd_pins CDMA_BRAM_IC/S00_ARESETN] [get_bd_pins CDMA_BRAM_IC/S01_ARESETN] [get_bd_pins CDMA_BRAM_IC/S02_ARESETN] [get_bd_pins CDMA_BRAM_IC/S03_ARESETN] [get_bd_pins CDMA_BRAM_IC/S04_ARESETN] [get_bd_pins CDMA_BRAM_IC/S05_ARESETN] [get_bd_pins SLAVE_AXI4_128_USR_BRAM_IC/ARESETN] [get_bd_pins SLAVE_AXI4_128_USR_BRAM_IC/M01_ARESETN] [get_bd_pins SLAVE_AXI4_128_USR_BRAM_IC/S00_ARESETN]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: Clock_And_Reset
proc create_hier_cell_Clock_And_Reset { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_msg_id "BD_TCL-102" "ERROR" "create_hier_cell_Clock_And_Reset() - Empty argument(s)!"}
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

  # Create pins
  create_bd_pin -dir I -type rst aux_reset_in
  create_bd_pin -dir O -from 0 -to 0 -type rst peripheral_aresetn
  create_bd_pin -dir I -type clk slowest_sync_clk

  # Create instance: rst_clk_wiz, and set properties
  set rst_clk_wiz [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 rst_clk_wiz ]

  # Create port connections
  connect_bd_net -net M00_ACLK_1 [get_bd_pins slowest_sync_clk] [get_bd_pins rst_clk_wiz/slowest_sync_clk]
  connect_bd_net -net S00_ARESETN_1 [get_bd_pins peripheral_aresetn] [get_bd_pins rst_clk_wiz/peripheral_aresetn]
  connect_bd_net -net clk_wiz_1_locked [get_bd_pins aux_reset_in] [get_bd_pins rst_clk_wiz/aux_reset_in] [get_bd_pins rst_clk_wiz/dcm_locked] [get_bd_pins rst_clk_wiz/ext_reset_in]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: C2H_IRQ
proc create_hier_cell_C2H_IRQ { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_msg_id "BD_TCL-102" "ERROR" "create_hier_cell_C2H_IRQ() - Empty argument(s)!"}
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
  create_bd_pin -dir I -from 0 -to 0 In1
  create_bd_pin -dir O -from 63 -to 0 dout
  create_bd_pin -dir O -from 63 -to 0 dout1
  create_bd_pin -dir I -type clk s_axi_aclk
  create_bd_pin -dir I -type rst s_axi_aresetn

  # Create instance: c2h_axi_gpio, and set properties
  set c2h_axi_gpio [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 c2h_axi_gpio ]
  set_property -dict [ list \
   CONFIG.C_ALL_OUTPUTS {1} \
   CONFIG.C_ALL_OUTPUTS_2 {1} \
   CONFIG.C_GPIO_WIDTH {32} \
   CONFIG.C_IS_DUAL {1} \
 ] $c2h_axi_gpio

  # Create instance: c2h_irq_concat, and set properties
  set c2h_irq_concat [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 c2h_irq_concat ]
  set_property -dict [ list \
   CONFIG.IN0_WIDTH {63} \
   CONFIG.IN1_WIDTH {1} \
 ] $c2h_irq_concat

  # Create instance: c2h_irq_master_slice, and set properties
  set c2h_irq_master_slice [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 c2h_irq_master_slice ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {62} \
   CONFIG.DIN_TO {0} \
   CONFIG.DIN_WIDTH {64} \
   CONFIG.DOUT_WIDTH {1} \
 ] $c2h_irq_master_slice

  # Create instance: xlconcat_1, and set properties
  set xlconcat_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 xlconcat_1 ]
  set_property -dict [ list \
   CONFIG.IN0_WIDTH {32} \
   CONFIG.IN1_WIDTH {32} \
   CONFIG.IN2_WIDTH {1} \
   CONFIG.IN3_WIDTH {1} \
   CONFIG.NUM_PORTS {2} \
 ] $xlconcat_1

  # Create interface connections
  connect_bd_intf_net -intf_net Posh_Master_M01_AXI [get_bd_intf_pins S_AXI] [get_bd_intf_pins c2h_axi_gpio/S_AXI]

  # Create port connections
  connect_bd_net -net In1_1 [get_bd_pins In1] [get_bd_pins c2h_irq_concat/In1]
  connect_bd_net -net M00_ACLK_1 [get_bd_pins s_axi_aclk] [get_bd_pins c2h_axi_gpio/s_axi_aclk]
  connect_bd_net -net S00_ARESETN_1 [get_bd_pins s_axi_aresetn] [get_bd_pins c2h_axi_gpio/s_axi_aresetn]
  connect_bd_net -net axi_gpio_0_gpio2_io_o [get_bd_pins dout] [get_bd_pins c2h_irq_master_slice/Din] [get_bd_pins xlconcat_1/dout]
  connect_bd_net -net axi_gpio_0_gpio2_io_o1 [get_bd_pins c2h_axi_gpio/gpio2_io_o] [get_bd_pins xlconcat_1/In1]
  connect_bd_net -net axi_gpio_0_gpio_io_o1 [get_bd_pins c2h_axi_gpio/gpio_io_o] [get_bd_pins xlconcat_1/In0]
  connect_bd_net -net c2h_irq_concat_dout [get_bd_pins dout1] [get_bd_pins c2h_irq_concat/dout]
  connect_bd_net -net xlslice_2_Dout [get_bd_pins c2h_irq_concat/In0] [get_bd_pins c2h_irq_master_slice/Dout]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: AXI_SLAVE_DUT
proc create_hier_cell_AXI_SLAVE_DUT { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_msg_id "BD_TCL-102" "ERROR" "create_hier_cell_AXI_SLAVE_DUT() - Empty argument(s)!"}
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

  # Create instance: axi_bram_ctrl_0_bram, and set properties
  set axi_bram_ctrl_0_bram [ create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.4 axi_bram_ctrl_0_bram ]

  # Create instance: axi_bram_ctrl_128_0, and set properties
  set axi_bram_ctrl_128_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_bram_ctrl:4.1 axi_bram_ctrl_128_0 ]
  set_property -dict [ list \
   CONFIG.SINGLE_PORT_BRAM {1} \
 ] $axi_bram_ctrl_128_0

  # Create interface connections
  connect_bd_intf_net -intf_net axi_bram_ctrl_0_BRAM_PORTA [get_bd_intf_pins axi_bram_ctrl_0_bram/BRAM_PORTA] [get_bd_intf_pins axi_bram_ctrl_128_0/BRAM_PORTA]
  connect_bd_intf_net -intf_net axi_interconnect_0_M00_AXI_1 [get_bd_intf_pins S_AXI] [get_bd_intf_pins axi_bram_ctrl_128_0/S_AXI]

  # Create port connections
  connect_bd_net -net M00_ACLK_1 [get_bd_pins s_axi_aclk] [get_bd_pins axi_bram_ctrl_128_0/s_axi_aclk]
  connect_bd_net -net S00_ARESETN_1 [get_bd_pins s_axi_aresetn] [get_bd_pins axi_bram_ctrl_128_0/s_axi_aresetn]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: AXI_MASTER_DUT
proc create_hier_cell_AXI_MASTER_DUT { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_msg_id "BD_TCL-102" "ERROR" "create_hier_cell_AXI_MASTER_DUT() - Empty argument(s)!"}
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
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI_LITE

  # Create pins
  create_bd_pin -dir O -type intr cdma_introut
  create_bd_pin -dir I -type clk s_axi_lite_aclk
  create_bd_pin -dir I -type rst s_axi_lite_aresetn

  # Create instance: axi_cdma_128, and set properties
  set axi_cdma_128 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_cdma:4.1 axi_cdma_128 ]
  set_property -dict [ list \
   CONFIG.C_ADDR_WIDTH {64} \
   CONFIG.C_INCLUDE_DRE {1} \
   CONFIG.C_INCLUDE_SF {1} \
   CONFIG.C_INCLUDE_SG {0} \
   CONFIG.C_M_AXI_DATA_WIDTH {128} \
   CONFIG.C_M_AXI_MAX_BURST_LEN {256} \
 ] $axi_cdma_128

  # Create interface connections
  connect_bd_intf_net -intf_net MASTER_USR_IC_M00_AXI [get_bd_intf_pins S_AXI_LITE] [get_bd_intf_pins axi_cdma_128/S_AXI_LITE]
  connect_bd_intf_net -intf_net S00_AXI_1 [get_bd_intf_pins M_AXI] [get_bd_intf_pins axi_cdma_128/M_AXI]

  # Create port connections
  connect_bd_net -net M00_ACLK_1 [get_bd_pins s_axi_lite_aclk] [get_bd_pins axi_cdma_128/m_axi_aclk] [get_bd_pins axi_cdma_128/s_axi_lite_aclk]
  connect_bd_net -net axi_cdma_128_cdma_introut [get_bd_pins cdma_introut] [get_bd_pins axi_cdma_128/cdma_introut]
  connect_bd_net -net util_reduced_logic_0_Res [get_bd_pins s_axi_lite_aresetn] [get_bd_pins axi_cdma_128/s_axi_lite_aresetn]

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
  set_property -dict [ list \
   CONFIG.FREQ_HZ {100000000} \
   ] $pcie_refclk

  # Create ports
  set pcie_perstn [ create_bd_port -dir I -type rst pcie_perstn ]
  set_property -dict [ list \
   CONFIG.POLARITY {ACTIVE_LOW} \
 ] $pcie_perstn

  # Create instance: AXI_MASTER_DUT
  create_hier_cell_AXI_MASTER_DUT [current_bd_instance .] AXI_MASTER_DUT

  # Create instance: AXI_SLAVE_DUT
  create_hier_cell_AXI_SLAVE_DUT [current_bd_instance .] AXI_SLAVE_DUT

  # Create instance: C2H_IRQ
  create_hier_cell_C2H_IRQ [current_bd_instance .] C2H_IRQ

  # Create instance: Clock_And_Reset
  create_hier_cell_Clock_And_Reset [current_bd_instance .] Clock_And_Reset

  # Create instance: Fabric_Interconnect
  create_hier_cell_Fabric_Interconnect [current_bd_instance .] Fabric_Interconnect

  # Create instance: Xilinx_PCIe_Tunnel
  create_hier_cell_Xilinx_PCIe_Tunnel [current_bd_instance .] Xilinx_PCIe_Tunnel

  # Create instance: pcie_ep_0, and set properties
  set pcie_ep_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:pcie_ep:1.00 pcie_ep_0 ]
  set_property -dict [ list \
   CONFIG.NUM_MASTER_BRIDGE {1} \
   CONFIG.PCIE_EP_LAST_BRIDGE {1} \
 ] $pcie_ep_0

  # Create interface connections
  connect_bd_intf_net -intf_net Fabric_Interconnect_M00_AXI1 [get_bd_intf_pins Fabric_Interconnect/M00_AXI1] [get_bd_intf_pins pcie_ep_0/S_AXI_PCIE_M0]
  connect_bd_intf_net -intf_net Fabric_Interconnect_M00_AXI2 [get_bd_intf_pins Fabric_Interconnect/M00_AXI2] [get_bd_intf_pins pcie_ep_0/S_AXI4_USR_0]
  connect_bd_intf_net -intf_net Fabric_Interconnect_M01_AXI [get_bd_intf_pins Fabric_Interconnect/M01_AXI] [get_bd_intf_pins pcie_ep_0/S_AXI_PCIE_S0]
  connect_bd_intf_net -intf_net MASTER_USR_IC_M00_AXI [get_bd_intf_pins AXI_MASTER_DUT/S_AXI_LITE] [get_bd_intf_pins Fabric_Interconnect/M00_AXI3]
  connect_bd_intf_net -intf_net Posh_Master_M01_AXI [get_bd_intf_pins C2H_IRQ/S_AXI] [get_bd_intf_pins Fabric_Interconnect/M01_AXI1]
  connect_bd_intf_net -intf_net S00_AXI_1 [get_bd_intf_pins AXI_MASTER_DUT/M_AXI] [get_bd_intf_pins Fabric_Interconnect/S00_AXI]
  connect_bd_intf_net -intf_net XDMA_S_AXI_M02_AXI [get_bd_intf_pins Fabric_Interconnect/M02_AXI1] [get_bd_intf_pins Xilinx_PCIe_Tunnel/S_AXI_LITE]
  connect_bd_intf_net -intf_net axi_interconnect_0_M00_AXI [get_bd_intf_pins Fabric_Interconnect/M00_AXI4] [get_bd_intf_pins Xilinx_PCIe_Tunnel/S_AXI_B]
  connect_bd_intf_net -intf_net axi_interconnect_0_M00_AXI_1 [get_bd_intf_pins AXI_SLAVE_DUT/S_AXI] [get_bd_intf_pins Fabric_Interconnect/M00_AXI]
  connect_bd_intf_net -intf_net pcie_ep_0_M_AXI4_USR_0 [get_bd_intf_pins Fabric_Interconnect/S00_AXI1] [get_bd_intf_pins pcie_ep_0/M_AXI4_USR_0]
  connect_bd_intf_net -intf_net pcie_ep_0_M_AXI_PCIE_M0 [get_bd_intf_pins Fabric_Interconnect/S00_AXI3] [get_bd_intf_pins pcie_ep_0/M_AXI_PCIE_M0]
  connect_bd_intf_net -intf_net pcie_ep_0_M_AXI_PCIE_S0 [get_bd_intf_pins Fabric_Interconnect/S01_AXI] [get_bd_intf_pins pcie_ep_0/M_AXI_PCIE_S0]
  connect_bd_intf_net -intf_net pcie_refclk_1 [get_bd_intf_ports pcie_refclk] [get_bd_intf_pins Xilinx_PCIe_Tunnel/pcie_refclk]
  connect_bd_intf_net -intf_net xdma_0_M_AXI_B [get_bd_intf_pins Fabric_Interconnect/S00_AXI2] [get_bd_intf_pins Xilinx_PCIe_Tunnel/M_AXI_B]
  connect_bd_intf_net -intf_net xdma_0_pcie_mgt [get_bd_intf_ports pci_express_x16] [get_bd_intf_pins Xilinx_PCIe_Tunnel/pci_express_x16]

  # Create port connections
  connect_bd_net -net C2H_IRQ_dout [get_bd_pins C2H_IRQ/dout] [get_bd_pins pcie_ep_0/usr_irq_req]
  connect_bd_net -net M00_ACLK_1 [get_bd_pins AXI_MASTER_DUT/s_axi_lite_aclk] [get_bd_pins AXI_SLAVE_DUT/s_axi_aclk] [get_bd_pins C2H_IRQ/s_axi_aclk] [get_bd_pins Clock_And_Reset/slowest_sync_clk] [get_bd_pins Fabric_Interconnect/ACLK] [get_bd_pins Xilinx_PCIe_Tunnel/axi_aclk] [get_bd_pins pcie_ep_0/clk]
  connect_bd_net -net S00_ARESETN_1 [get_bd_pins C2H_IRQ/s_axi_aresetn] [get_bd_pins Clock_And_Reset/peripheral_aresetn] [get_bd_pins Fabric_Interconnect/ARESETN] [get_bd_pins pcie_ep_0/resetn]
  connect_bd_net -net Xilinx_PCIe_Tunnel_usr_irq_ack [get_bd_pins Xilinx_PCIe_Tunnel/usr_irq_ack] [get_bd_pins pcie_ep_0/irq_ack]
  connect_bd_net -net axi_cdma_128_cdma_introut [get_bd_pins AXI_MASTER_DUT/cdma_introut] [get_bd_pins C2H_IRQ/In1]
  connect_bd_net -net clk_wiz_1_locked [get_bd_pins Clock_And_Reset/aux_reset_in] [get_bd_pins Xilinx_PCIe_Tunnel/axi_aresetn]
  connect_bd_net -net pcie_ep_0_h2c_gpio_out [get_bd_pins pcie_ep_0/c2h_gpio_in] [get_bd_pins pcie_ep_0/h2c_gpio_out]
  connect_bd_net -net pcie_ep_0_irq_out [get_bd_pins Xilinx_PCIe_Tunnel/usr_irq_req] [get_bd_pins pcie_ep_0/irq_req]
  connect_bd_net -net pcie_perstn_1 [get_bd_ports pcie_perstn] [get_bd_pins Xilinx_PCIe_Tunnel/pcie_perstn]
  connect_bd_net -net util_reduced_logic_0_Res [get_bd_pins AXI_MASTER_DUT/s_axi_lite_aresetn] [get_bd_pins AXI_SLAVE_DUT/s_axi_aresetn] [get_bd_pins Fabric_Interconnect/S00_ARESETN] [get_bd_pins pcie_ep_0/usr_resetn]

  # Create address segments
  create_bd_addr_seg -range 0x00004000 -offset 0xB0000000 [get_bd_addr_spaces pcie_ep_0/M_AXI4_USR_0] [get_bd_addr_segs AXI_SLAVE_DUT/axi_bram_ctrl_128_0/S_AXI/Mem0] SEG_axi_bram_ctrl_128_0_Mem0
  create_bd_addr_seg -range 0x00010000 -offset 0xB0100000 [get_bd_addr_spaces pcie_ep_0/M_AXI4_USR_0] [get_bd_addr_segs AXI_MASTER_DUT/axi_cdma_128/S_AXI_LITE/Reg] SEG_axi_cdma_128_Reg
  create_bd_addr_seg -range 0x00010000000000000000 -offset 0x00000000 [get_bd_addr_spaces pcie_ep_0/M_AXI_PCIE_M0] [get_bd_addr_segs Xilinx_PCIe_Tunnel/xdma_0/S_AXI_B/BAR0] SEG_xdma_0_BAR0
  create_bd_addr_seg -range 0x00010000000000000000 -offset 0x00000000 [get_bd_addr_spaces pcie_ep_0/M_AXI_PCIE_S0] [get_bd_addr_segs Xilinx_PCIe_Tunnel/xdma_0/S_AXI_B/BAR0] SEG_xdma_0_BAR0
  create_bd_addr_seg -range 0x00004000 -offset 0xB0000000 [get_bd_addr_spaces AXI_MASTER_DUT/axi_cdma_128/Data] [get_bd_addr_segs AXI_SLAVE_DUT/axi_bram_ctrl_128_0/S_AXI/Mem0] SEG_axi_bram_ctrl_128_0_Mem0
  create_bd_addr_seg -range 0x80000000 -offset 0x00000000 [get_bd_addr_spaces AXI_MASTER_DUT/axi_cdma_128/Data] [get_bd_addr_segs pcie_ep_0/S_AXI4_USR_0/Mem] SEG_pcie_ep_0_Mem
  create_bd_addr_seg -range 0x00001000 -offset 0x20080000 [get_bd_addr_spaces Xilinx_PCIe_Tunnel/xdma_0/M_AXI_B] [get_bd_addr_segs C2H_IRQ/c2h_axi_gpio/S_AXI/Reg] SEG_axi_gpio_0_Reg
  create_bd_addr_seg -range 0x00020000 -offset 0xC0000000 [get_bd_addr_spaces Xilinx_PCIe_Tunnel/xdma_0/M_AXI_B] [get_bd_addr_segs pcie_ep_0/S_AXI_PCIE_M0/Mem] SEG_pcie_ep_0_Mem
  create_bd_addr_seg -range 0x00020000 -offset 0xC0020000 [get_bd_addr_spaces Xilinx_PCIe_Tunnel/xdma_0/M_AXI_B] [get_bd_addr_segs pcie_ep_0/S_AXI_PCIE_S0/Mem] SEG_pcie_ep_0_Mem2
  create_bd_addr_seg -range 0x00100000 -offset 0x80000000 [get_bd_addr_spaces Xilinx_PCIe_Tunnel/xdma_0/M_AXI_B] [get_bd_addr_segs Xilinx_PCIe_Tunnel/xdma_0/S_AXI_LITE/CTL0] SEG_xdma_0_CTL0


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


