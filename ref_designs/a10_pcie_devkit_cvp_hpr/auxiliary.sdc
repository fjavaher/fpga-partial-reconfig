# Copyright (c) 2001-2017 Intel Corporation
#  
# Permission is hereby granted, free of charge, to any person obtaining a
# copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#  
# The above copyright notice and this permission notice shall be included
# in all copies or substantial portions of the Software.
#  
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
# OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
# IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
# CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
# TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
# SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

# set asynchronous clock domains
set_false_path -from {u_top|design_core|ddr4_status_bus|u_synch_fail|d[0]} -to {u_top|design_core|ddr4_status_bus|u_synch_fail|c[0]}
set_false_path -from {u_top|design_core|ddr4_status_bus|u_synch_success|d[0]} -to {u_top|design_core|ddr4_status_bus|u_synch_success|c[0]}
set_clock_groups -asynchronous -group [get_clocks {u_top|ddr4_emif|ddr4_ctlr_emif_0_core_usr_clk}] -group [get_clocks {u_top|design_core|top_iopll|top_iopll_0|outclk_250mhz}]

