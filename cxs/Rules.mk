# 
# Copyright (c) 2019 Xilinx Inc.
# Written by Heramb Aligave.
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
#   Some Rules to generate design and ips
# 

RM = rm -rf
RUNS_DIR = runs
SCRIPTS_DIR = scripts

####################### #################
####### Directory structure #############
#########################################

COMMON_CXS_DIR = $(POSH_REPO)/cxs/common/


################ RTL Related variables ##################

CXS_TOP = cxs_bridge_top


RTL_BRIDGE_CXS_DIR = $(POSH_REPO)/libsystemctlm-soc/rtl-bridges/pcie-host/cxs/rtl
RTL_CXS_COMMON_DIR = common
RTL_CXS_DIR = cxs

RTL_CXS_FILELIST= files-bridge-cxs.mk
RTL_CXS_FILELIST_COMMON = files-bridge-cxs-common.mk


CXS_PCORE_DIR = $(POSH_REPO)/cxs/cxs/pcore

VIVADO = vivado

V_MODE = tcl
RUN_TCL = create_project.tcl
IP_PKG_TCL = pkg/cxs_pkg.tcl
