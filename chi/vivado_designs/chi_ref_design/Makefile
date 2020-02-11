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
#   Makefile to generate chi_ref_design.
# 

include ../../Rules.mk
POSH_REPO = ./../../..

.PHONY: $(TARGETS) $(RN_F_PCORE_DIR) $(HN_F_PCORE_DIR)

CHI_REF_DESIGN = chi_ref_design

all: $(CHI_REF_DESIGN)

clean:	mostlyclean
	$(RM) $(RUNS_DIR)_*

mostlyclean:
	$(RM) *.log *.jou *.str *.*~
	$(RM) $(SCRIPTS_DIR)/*.log $(SCRIPTS_DIR)/*.jou $(SCRIPTS_DIR)/*.str $(SCRIPTS_DIR)/*.*~

$(CHI_REF_DESIGN): $(RN_F_PCORE_DIR) $(HN_F_PCORE_DIR)
	cd ./$(SCRIPTS_DIR);\
	$(VIVADO) -mode $(V_MODE) -source $(RUN_TCL)	

$(RN_F_PCORE_DIR):
	$(MAKE) -C $@

$(HN_F_PCORE_DIR):
	$(MAKE) -C $@

