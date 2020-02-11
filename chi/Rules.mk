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
#   Some Rules to generate design and ips
# 

RM = rm -rf
RUNS_DIR = runs
SCRIPTS_DIR = scripts

####################### #################
####### Directory structure #############
#########################################

COMMON_CHI_DIR = $(POSH_REPO)/chi/common/


################ RTL Related variables ##################

HN_F_TOP = chi_bridge_hn_top
RN_F_TOP = chi_bridge_rn_top


RTL_BRIDGE_CHI_DIR = $(POSH_REPO)/libsystemctlm-soc/rtl-bridges/pcie-host/chi/rtl
RTL_CHI_COMMON_DIR = common
RTL_CHI_HN_F_DIR = hn-f
RTL_CHI_RN_F_DIR = rn-f

RTL_CHI_FILELIST_HN_F = files-bridge-chi-hn-f.mk
RTL_CHI_FILELIST_RN_F = files-bridge-chi-rn-f.mk
RTL_CHI_FILELIST_COMMON = files-bridge-chi-common.mk


HN_F_PCORE_DIR = $(POSH_REPO)/chi/hn-f/pcore
RN_F_PCORE_DIR = $(POSH_REPO)/chi/rn-f/pcore

VIVADO = vivado

V_MODE = tcl
RUN_TCL = create_project.tcl
IP_PKG_TCL = pkg/chi_pkg.tcl
