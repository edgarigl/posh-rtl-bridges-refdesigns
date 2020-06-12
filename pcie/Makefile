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
#   Makefile to create Vivado Designs & IP Cores
# 


AXI_TOP = master
PCIE_TOP = ep

RTL_BRIDGE_AXI_DIR = ../libsystemctlm-soc/rtl-bridges/pcie-host/axi/rtl/
RTL_BRIDGE_PCIE_DIR = ../libsystemctlm-soc/rtl-bridges/pcie-host/pcie/rtl/

export MASTER := master
export SLAVE := slave
export EP := ep

export PCORE_DIR := ${PWD}/$(PCIE_TOP)/pcore
export AXI_RTL_DIR := $(RTL_BRIDGE_AXI_DIR)
export PCIE_RTL_DIR := $(RTL_BRIDGE_PCIE_DIR)
export AXI_COMMON_RTL_DIR := $(RTL_BRIDGE_AXI_DIR)/common

export COMMON_DIR := ${PWD}/$(PCIE_TOP)/common

AXI_DESIGNS = axi_cdma_axi4_128


HARD_COPY = cp -f
SOFT_LINK = ln -s
COPY = $(HARD_COPY)

clean:
	rm -rf vivado_designs/$(AXI_DESIGNS)/runs;\
	rm -f vivado_designs/$(AXI_DESIGNS)/scripts/vivado*.log
	rm -f vivado_designs/$(AXI_DESIGNS)/scripts/vivado*.jou
	rm -f vivado*.log vivado*.jou
	rm -rf master/pcore slave/pcore
	rm -rf master/common/filelist
	rm -rf slave/common/filelist

gen_filelist:
	rm -f ./$(PCIE_TOP)/common/filelist ;\
	mkdir ./$(PCIE_TOP)/common/filelist ;\
	ls -1 $(RTL_BRIDGE_PCIE_DIR)/$(PCIE_TOP)/*.v | tr '\n' '\0' | xargs -0 -n 1 basename >   ./$(PCIE_TOP)/common/filelist/filelist_rtl.f
	ls -1 $(RTL_BRIDGE_PCIE_DIR)/$(PCIE_TOP)/*.vh | tr '\n' '\0' | xargs -0 -n 1 basename >> ./$(PCIE_TOP)/common/filelist/filelist_rtl.f
	ls -1 $(RTL_BRIDGE_AXI_DIR)/$(MASTER)/*.v | tr '\n' '\0' | xargs -0 -n 1 basename >>   ./$(PCIE_TOP)/common/filelist/filelist_rtl.f
	ls -1 $(RTL_BRIDGE_AXI_DIR)/$(MASTER)/*.vh | tr '\n' '\0' | xargs -0 -n 1 basename >> ./$(PCIE_TOP)/common/filelist/filelist_rtl.f
	ls -1 $(RTL_BRIDGE_AXI_DIR)/$(SLAVE)/*.v | tr '\n' '\0' | xargs -0 -n 1 basename >>   ./$(PCIE_TOP)/common/filelist/filelist_rtl.f
	ls -1 $(RTL_BRIDGE_AXI_DIR)/$(SLAVE)/*.vh | tr '\n' '\0' | xargs -0 -n 1 basename >> ./$(PCIE_TOP)/common/filelist/filelist_rtl.f
	ls -1 $(RTL_BRIDGE_AXI_DIR)/common/*.v | tr '\n' '\0' | xargs -0 -n 1 basename >>  ./$(PCIE_TOP)/common/filelist/filelist_rtl.f
	ls -1 $(RTL_BRIDGE_AXI_DIR)/common/*.vh | tr '\n' '\0' | xargs -0 -n 1 basename >> ./$(PCIE_TOP)/common/filelist/filelist_rtl.f

gen_pcore:
	make gen_filelist ;\
	rm -fr ${PCORE_DIR}; \
	mkdir ${PCORE_DIR}; \
	mkdir ${PCORE_DIR}/hdl; \
	mkdir ${PCORE_DIR}/hdl/verilog; \
	$(COPY) ${PWD}/${AXI_COMMON_RTL_DIR}/*.v ${PCORE_DIR}/hdl/verilog/.; \
	$(COPY) ${PWD}/${AXI_COMMON_RTL_DIR}/*.vh ${PCORE_DIR}/hdl/verilog/.; \
	$(COPY) ${PWD}/${AXI_RTL_DIR}/${MASTER}/*.v ${PCORE_DIR}/hdl/verilog/.; \
	$(COPY) ${PWD}/${AXI_RTL_DIR}/${MASTER}/*.vh ${PCORE_DIR}/hdl/verilog/.; \
	$(COPY) ${PWD}/${AXI_RTL_DIR}/${SLAVE}/*.v ${PCORE_DIR}/hdl/verilog/.; \
	$(COPY) ${PWD}/${AXI_RTL_DIR}/${SLAVE}/*.vh ${PCORE_DIR}/hdl/verilog/.; \
	$(COPY) ${PWD}/${PCIE_RTL_DIR}/${EP}/*.v ${PCORE_DIR}/hdl/verilog/.; \
	$(COPY) ${PWD}/${PCIE_RTL_DIR}/${EP}/*.vh ${PCORE_DIR}/hdl/verilog/.; \
	cp -f ${COMMON_DIR}/script/pcie_$(PCIE_TOP)_package.tcl ${PCORE_DIR}/; \
	chmod 755 ${PCORE_DIR}/pcie_$(PCIE_TOP)_package.tcl; \
	cp -f ${COMMON_DIR}/script/pcie_$(PCIE_TOP)_package.csh ${PCORE_DIR}/; \
	chmod 755 ${PCORE_DIR}/pcie_$(PCIE_TOP)_package.csh; \
	cp -f ${COMMON_DIR}/filelist/filelist_rtl.f ${PCORE_DIR}/; \
	cd ${PCORE_DIR}; \
	./pcie_$(PCIE_TOP)_package.csh; \
	vivado -mode batch -source ./pcie_$(PCIE_TOP)_package.tcl


gen_all_cores: 
	make gen_pcore PCIE_TOP=ep

design:
	if [ -d "./ep/pcore" ]; then echo "PCIe-EP IP Found"; else make gen_all_cores; fi; 
	cd vivado_designs/$(TARGET);\
	cd ./scripts;\
	vivado -mode tcl -source create_project.tcl;\
	
pcie_ep:
	make design TARGET=pcie_ep
