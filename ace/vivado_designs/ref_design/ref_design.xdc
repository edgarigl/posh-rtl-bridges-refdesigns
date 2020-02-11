set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design]

create_pblock pblock_xdma_0
add_cells_to_pblock [get_pblocks pblock_xdma_0] [get_cells -quiet [list xdma_app_i/xdma_0]]
resize_pblock [get_pblocks pblock_xdma_0] -add {SLICE_X2Y240:SLICE_X232Y478}
resize_pblock [get_pblocks pblock_xdma_0] -add {DSP48E2_X0Y96:DSP48E2_X31Y189}
resize_pblock [get_pblocks pblock_xdma_0] -add {RAMB18_X0Y96:RAMB18_X13Y189}
resize_pblock [get_pblocks pblock_xdma_0] -add {RAMB36_X0Y48:RAMB36_X13Y94}
resize_pblock [get_pblocks pblock_xdma_0] -add {URAM288_X0Y64:URAM288_X4Y123}
set_property C_CLK_INPUT_FREQ_HZ 300000000 [get_debug_cores dbg_hub]
set_property C_ENABLE_CLK_DIVIDER false [get_debug_cores dbg_hub]
set_property C_USER_SCAN_CHAIN 1 [get_debug_cores dbg_hub]
connect_debug_port dbg_hub/clk [get_nets clk]



