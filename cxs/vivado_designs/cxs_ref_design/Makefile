include ../../Rules.mk
POSH_REPO = ./../../../

.PHONY: $(TARGETS) $(CXS_PCORE_DIR) 

CXS_REF_DESIGN = cxs_ref_design

all: $(CXS_REF_DESIGN)

clean:	mostlyclean
	$(RM) $(RUNS_DIR)_*

mostlyclean:
	$(RM) *.log *.jou *.str *.*~
	$(RM) $(SCRIPTS_DIR)/*.log $(SCRIPTS_DIR)/*.jou $(SCRIPTS_DIR)/*.str $(SCRIPTS_DIR)/*.*~

$(CXS_REF_DESIGN): $(CXS_PCORE_DIR)
	cd ./$(SCRIPTS_DIR);\
	$(LSF_W6) $(VIVADO) -mode $(V_MODE) -source $(RUN_TCL)

$(CXS_PCORE_DIR):
	$(MAKE) -C $@

