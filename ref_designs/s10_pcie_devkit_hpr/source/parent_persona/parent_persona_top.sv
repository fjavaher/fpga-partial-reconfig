// Copyright (c) 2001-2018 Intel Corporation
//  
// Permission is hereby granted, free of charge, to any person obtaining a
// copy of this software and associated documentation files (the
// "Software"), to deal in the Software without restriction, including
// without limitation the rights to use, copy, modify, merge, publish,
// distribute, sublicense, and/or sell copies of the Software, and to
// permit persons to whom the Software is furnished to do so, subject to
// the following conditions:
//  
// The above copyright notice and this permission notice shall be included
// in all copies or substantial portions of the Software.
//  
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
// OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
// IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
// CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
// TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
// SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

`timescale 1 ps / 1 ps
`default_nettype none

module parent_persona_top
(
   input wire         pr_region_clk , 
   input wire         pr_logic_rst , 
   // Signaltap Interface
   input wire           tck ,
   input wire           tms ,
   input wire           tdi ,
   input wire           vir_tdi ,
   input wire           ena ,
   output wire          tdo ,

   input wire           pr_handshake_start_req ,
   output reg           pr_handshake_start_ack ,
   input wire           pr_handshake_stop_req ,
   output reg           pr_handshake_stop_ack ,
   output wire          freeze_pr_region_avmm ,

   // AVMM interface
   output reg           pr_region_avmm_waitrequest , 
   output reg [31:0]    pr_region_avmm_readdata , 
   output reg           pr_region_avmm_readdatavalid, 
   input wire [0:0]     pr_region_avmm_burstcount , 
   input wire [31:0]    pr_region_avmm_writedata , 
   input wire [15:0]    pr_region_avmm_address , 
   input wire           pr_region_avmm_write , 
   input wire           pr_region_avmm_read , 
   input wire [3:0]     pr_region_avmm_byteenable    
);

   wire [31:0] persona_id;

   assign persona_id       = 32'h68707261;
   
   always_ff @(posedge pr_region_clk) begin
      pr_handshake_start_ack <=1'b0;
      pr_handshake_stop_ack <=1'b0;
      if (  pr_handshake_start_req == 1'b0 ) begin
         pr_handshake_start_ack <= 1'b1;
      end
      // Active high SW reset
      if (  pr_handshake_stop_req == 1'b1 ) begin
         pr_handshake_stop_ack <=1'b1;
      end
   end

   assign freeze_pr_region_avmm = 1'b0;
   
   parent_pr_subsystem u0 
   (
        .clk_clk                                      (pr_region_clk),                                      //                            clk.clk
        .parent_pr_id_export                          (persona_id),
        
        .parent_pr_pcie_avmm_pbridge_s0_waitrequest   (pr_region_avmm_waitrequest),   // parent_pr_pcie_avmm_pbridge_s0.waitrequest
        .parent_pr_pcie_avmm_pbridge_s0_readdata      (pr_region_avmm_readdata),      //                               .readdata
        .parent_pr_pcie_avmm_pbridge_s0_readdatavalid (pr_region_avmm_readdatavalid), //                               .readdatavalid
        .parent_pr_pcie_avmm_pbridge_s0_burstcount    (pr_region_avmm_burstcount),    //                               .burstcount
        .parent_pr_pcie_avmm_pbridge_s0_writedata     (pr_region_avmm_writedata),     //                               .writedata
        .parent_pr_pcie_avmm_pbridge_s0_address       (pr_region_avmm_address),       //                               .address
        .parent_pr_pcie_avmm_pbridge_s0_write         (pr_region_avmm_write),         //                               .write
        .parent_pr_pcie_avmm_pbridge_s0_read          (pr_region_avmm_read),          //                               .read
        .parent_pr_pcie_avmm_pbridge_s0_byteenable    (pr_region_avmm_byteenable),    //                               .byteenable
        
        .reset_reset                                  (pr_logic_rst)                                   //                          reset.reset
    );

    sld_jtag_host u_sld_jtag_host 
    (
      .tck     ( tck ),
      .tms     ( tms ),
      .tdi     ( tdi ),
      .vir_tdi ( vir_tdi ),
      .ena     ( ena ),
      .tdo     ( tdo )
    );
endmodule
