# 
# Copyright (c) 2019 Xilinx Inc.
# Written by Alok Mistry.
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
#   Makefile to generate IP Core.
# 

include ../../Rules.mk
POSH_REPO = ../../..


include $(RTL_BRIDGE_CHI_DIR)/$(RTL_CHI_COMMON_DIR)/$(RTL_CHI_FILELIST_COMMON)
include $(RTL_BRIDGE_CHI_DIR)/$(RTL_CHI_HN_F_DIR)/$(RTL_CHI_FILELIST_HN_F)
include $(RTL_BRIDGE_CHI_DIR)/$(RTL_CHI_RN_F_DIR)/$(RTL_CHI_FILELIST_RN_F)


V_IP_FILELIST = $(RTL_BRIDGE_CHI_COMMON_V)
V_IP_FILELIST += $(RTL_BRIDGE_CHI_RN_F_V)

export V_IP_FILELIST
export V_IP_TOP := $(RN_F_TOP)
export V_RTL_DIR := $(RTL_BRIDGE_CHI_DIR)/$(RTL_CHI_RN_F_DIR)
export V_BRIDGE_TYPE := RN_F


all:	component.xml
	
component.xml: $(V_IP_FILELIST) $(COMMON_CHI_DIR)/$(SCRIPTS_DIR)/$(IP_PKG_TCL)
	@echo $(V_IP_FILELIST)
	@echo $(V_IP_TOP)
	@echo $(V_RTL_DIR)
	$(VIVADO) -mode tcl -source $(COMMON_CHI_DIR)/$(SCRIPTS_DIR)/$(IP_PKG_TCL)

clean:
	$(RM) *.xml
	$(RM) xgui
	$(RM) *.log *.jou
