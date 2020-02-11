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
#   Makefile to create Vivado Designs & IP Cores
# 


ACE_TOP = master

RTL_BRIDGE_ACE_DIR = ../libsystemctlm-soc/rtl-bridges/pcie-host/ace/rtl/
export PCORE_DIR := ${PWD}/$(ACE_TOP)/pcore
export RTL_DIR := $(RTL_BRIDGE_ACE_DIR)/$(ACE_TOP)
export COMMON_RTL_DIR := $(RTL_BRIDGE_ACE_DIR)/common
export COMMON_DIR := ${PWD}/$(ACE_TOP)/common

ACE_DESIGNS = ref_design


include	../libsystemctlm-soc/rtl-bridges/pcie-host/ace/rtl/common/files-bridge-ace-common.mk
include	../libsystemctlm-soc/rtl-bridges/pcie-host/ace/rtl/master/files-bridge-ace.mk
include	../libsystemctlm-soc/rtl-bridges/pcie-host/ace/rtl/slave/files-bridge-ace.mk

HARD_COPY = cp -f
SOFT_LINK = ln -s
COPY = $(HARD_COPY)

all : clean gen_filelist gen_all_cores ref_design

clean:
	rm -rf vivado_designs/$(ACE_DESIGNS)/runs;\
	rm -f vivado_designs/$(ACE_DESIGNS)/scripts/vivado*.log
	rm -f vivado_designs/$(ACE_DESIGNS)/scripts/vivado*.jou
	rm -f vivado*.log vivado*.jou
	rm -rf master/pcore slave/pcore
	rm -rf master/common/filelist
	rm -rf slave/common/filelist

gen_filelist:
	rm -f ./$(ACE_TOP)/common/filelist ;\
	mkdir ./$(ACE_TOP)/common/filelist ;\
	ls -1 $(RTL_BRIDGE_ACE_DIR)/$(ACE_TOP)/*.v | tr '\n' '\0' | xargs -0 -n 1 basename >   ./$(ACE_TOP)/common/filelist/filelist_rtl.f
	ls -1 $(RTL_BRIDGE_ACE_DIR)/$(ACE_TOP)/*.vh | tr '\n' '\0' | xargs -0 -n 1 basename >> ./$(ACE_TOP)/common/filelist/filelist_rtl.f
	ls -1 $(RTL_BRIDGE_ACE_DIR)/common/*.v | tr '\n' '\0' | xargs -0 -n 1 basename >>  ./$(ACE_TOP)/common/filelist/filelist_rtl.f
	ls -1 $(RTL_BRIDGE_ACE_DIR)/common/*.vh | tr '\n' '\0' | xargs -0 -n 1 basename >> ./$(ACE_TOP)/common/filelist/filelist_rtl.f

gen_pcore:
	make gen_filelist ;\
	rm -fr ${PCORE_DIR}; \
	mkdir ${PCORE_DIR}; \
	mkdir ${PCORE_DIR}/hdl; \
	mkdir ${PCORE_DIR}/hdl/verilog; \
	$(COPY) ${PWD}/${RTL_DIR}/*.v ${PCORE_DIR}/hdl/verilog/.; \
	$(COPY) ${PWD}/${RTL_DIR}/*.vh ${PCORE_DIR}/hdl/verilog/.; \
	$(COPY) ${PWD}/${COMMON_RTL_DIR}/*.v ${PCORE_DIR}/hdl/verilog/.; \
	$(COPY) ${PWD}/${COMMON_RTL_DIR}/*.vh ${PCORE_DIR}/hdl/verilog/.; \
	cp -f ${COMMON_DIR}/script/ace_$(ACE_TOP)_package.tcl ${PCORE_DIR}/; \
	chmod 755 ${PCORE_DIR}/ace_$(ACE_TOP)_package.tcl; \
	cp -f ${COMMON_DIR}/script/ace_$(ACE_TOP)_package.csh ${PCORE_DIR}/; \
	chmod 755 ${PCORE_DIR}/ace_$(ACE_TOP)_package.csh; \
	cp -f ${COMMON_DIR}/filelist/filelist_rtl.f ${PCORE_DIR}/; \
	cd ${PCORE_DIR}; \
	./ace_$(ACE_TOP)_package.csh; \
	vivado -mode batch -source ./ace_$(ACE_TOP)_package.tcl


gen_all_cores: 
	make gen_pcore ACE_TOP=master;\
	make gen_pcore ACE_TOP=slave

design:
	if [ -d "./master/pcore" ]; then echo "Master IP Found"; else make gen_pcore ACE_TOP=master; fi; 
	if [ -d "./slave/pcore" ]; then echo "Slave IP Found"; else make gen_pcore ACE_TOP=slave; fi; 
	cd vivado_designs/$(TARGET);\
	cd ./scripts;\
	vivado -mode tcl -source create_project.tcl;\
	
ref_design:
	make design TARGET=ref_design

