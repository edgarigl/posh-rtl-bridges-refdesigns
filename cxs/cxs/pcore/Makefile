include ../../Rules.mk
POSH_REPO = ../../..


include $(RTL_BRIDGE_CXS_DIR)/$(RTL_CXS_COMMON_DIR)/$(RTL_CXS_FILELIST_COMMON)
include $(RTL_BRIDGE_CXS_DIR)/$(RTL_CXS_DIR)/$(RTL_CXS_FILELIST)
include $(RTL_BRIDGE_CXS_DIR)/$(RTL_CXS_DIR)/$(RTL_CXS_FILELIST)


V_IP_FILELIST = $(RTL_BRIDGE_CXS_COMMON_V)
V_IP_FILELIST += $(RTL_BRIDGE_CXS_V)

export V_IP_FILELIST
export V_IP_TOP := $(CXS_TOP)
export V_RTL_DIR := $(RTL_BRIDGE_CXS_DIR)/$(RTL_CXS_DIR)
export V_BRIDGE_TYPE := CXS


all:	component.xml
	
component.xml: $(V_IP_FILELIST) $(COMMON_CXS_DIR)/$(SCRIPTS_DIR)/$(IP_PKG_TCL)
	@echo $(V_IP_FILELIST)
	@echo $(V_IP_TOP)
	@echo $(V_RTL_DIR)
	$(SLSF_W6) $(VIVADO) -mode tcl -source $(COMMON_CXS_DIR)/$(SCRIPTS_DIR)/$(IP_PKG_TCL)

clean:
	$(RM) *.xml
	$(RM) xgui
	$(RM) *.log *.jou
