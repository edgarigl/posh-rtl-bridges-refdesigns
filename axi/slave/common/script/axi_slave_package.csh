#!/bin/csh
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
#   Shell script to generate ip core.
# 


set INFILE = "filelist_rtl.f"
set INTYPEFILE = "filelist_local_type.f"
set TCLFILE = "axi_slave_package.tcl"


cp -f ${INFILE} ${INTYPEFILE}


sed -e '/\/\//d' -i  ${INFILE}
sed -e '/#/d' -i  ${INFILE}
sed -e 's/^/set_property library_name axi_slave [::ipx::add_file hdl\/verilog\//' -i ${INFILE}
sed -e 's/$/ $current_filegroup]/' -i  ${INFILE}


echo 'foreach fg {xilinx_vivadoverilogsynthesis xilinx_vivadoverilogbehavioralsimulation} {' >> ${TCLFILE}
echo 'set current_filegroup [::ipx::add_file_group $fg $::core]' >> ${TCLFILE}
cat ${INFILE} >> ${TCLFILE}


echo 'set_property model_name axi_slave $current_filegroup' >> ${TCLFILE}
echo '}' >> ${TCLFILE}


##Verilog Header
sed -e '/\/\//d' -i  ${INTYPEFILE}
sed -e '/#/d' -i  ${INTYPEFILE}
sed -e '/\.v$/d' -i  ${INTYPEFILE}
sed -e 's/^/set_property type verilogHeader [ipx::get_files hdl\/verilog\//' -i ${INTYPEFILE}
sed -e 's/$/ -of_objects [ipx::get_file_groups xilinx_vivadoverilogsynthesis -of_objects [ipx::current_core]]]/g' -i  ${INTYPEFILE}
cat ${INTYPEFILE} >> ${TCLFILE}


echo 'ipx::create_xgui_files [ipx::current_core]' >> ${TCLFILE}
echo 'ipx::update_checksums [ipx::current_core]' >> ${TCLFILE}
echo '::ipx::save_core $::core' >> ${TCLFILE}


