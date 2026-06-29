//Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
//Copyright 2022-2023 Advanced Micro Devices, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2023.2 (lin64) Build 4029153 Fri Oct 13 20:13:54 MDT 2023
//Date        : Wed Jun 17 13:42:50 2026
//Host        : finn_dev_e2405238 running 64-bit Ubuntu 22.04.1 LTS
//Command     : generate_target finn_design.bd
//Design      : finn_design
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module MVAU_hls_0_imp_7OH4JA
   (ap_clk,
    ap_rst_n,
    in0_V_tdata,
    in0_V_tready,
    in0_V_tvalid,
    out_V_tdata,
    out_V_tready,
    out_V_tvalid,
    s_axilite_araddr,
    s_axilite_arprot,
    s_axilite_arready,
    s_axilite_arvalid,
    s_axilite_awaddr,
    s_axilite_awprot,
    s_axilite_awready,
    s_axilite_awvalid,
    s_axilite_bready,
    s_axilite_bresp,
    s_axilite_bvalid,
    s_axilite_rdata,
    s_axilite_rready,
    s_axilite_rresp,
    s_axilite_rvalid,
    s_axilite_wdata,
    s_axilite_wready,
    s_axilite_wstrb,
    s_axilite_wvalid);
  input ap_clk;
  input ap_rst_n;
  input [7:0]in0_V_tdata;
  output in0_V_tready;
  input in0_V_tvalid;
  output [7:0]out_V_tdata;
  input out_V_tready;
  output out_V_tvalid;
  input [11:0]s_axilite_araddr;
  input [2:0]s_axilite_arprot;
  output s_axilite_arready;
  input s_axilite_arvalid;
  input [11:0]s_axilite_awaddr;
  input [2:0]s_axilite_awprot;
  output s_axilite_awready;
  input s_axilite_awvalid;
  input s_axilite_bready;
  output [1:0]s_axilite_bresp;
  output s_axilite_bvalid;
  output [31:0]s_axilite_rdata;
  input s_axilite_rready;
  output [1:0]s_axilite_rresp;
  output s_axilite_rvalid;
  input [31:0]s_axilite_wdata;
  output s_axilite_wready;
  input [3:0]s_axilite_wstrb;
  input s_axilite_wvalid;

  wire [7:0]MVAU_hls_0_out_V_TDATA;
  wire MVAU_hls_0_out_V_TREADY;
  wire MVAU_hls_0_out_V_TVALID;
  wire [15:0]MVAU_hls_0_wstrm_m_axis_0_TDATA;
  wire MVAU_hls_0_wstrm_m_axis_0_TREADY;
  wire MVAU_hls_0_wstrm_m_axis_0_TVALID;
  wire ap_clk_1;
  wire ap_rst_n_1;
  wire [7:0]in0_V_1_TDATA;
  wire in0_V_1_TREADY;
  wire in0_V_1_TVALID;
  wire [11:0]s_axilite_1_ARADDR;
  wire [2:0]s_axilite_1_ARPROT;
  wire s_axilite_1_ARREADY;
  wire s_axilite_1_ARVALID;
  wire [11:0]s_axilite_1_AWADDR;
  wire [2:0]s_axilite_1_AWPROT;
  wire s_axilite_1_AWREADY;
  wire s_axilite_1_AWVALID;
  wire s_axilite_1_BREADY;
  wire [1:0]s_axilite_1_BRESP;
  wire s_axilite_1_BVALID;
  wire [31:0]s_axilite_1_RDATA;
  wire s_axilite_1_RREADY;
  wire [1:0]s_axilite_1_RRESP;
  wire s_axilite_1_RVALID;
  wire [31:0]s_axilite_1_WDATA;
  wire s_axilite_1_WREADY;
  wire [3:0]s_axilite_1_WSTRB;
  wire s_axilite_1_WVALID;

  assign MVAU_hls_0_out_V_TREADY = out_V_tready;
  assign ap_clk_1 = ap_clk;
  assign ap_rst_n_1 = ap_rst_n;
  assign in0_V_1_TDATA = in0_V_tdata[7:0];
  assign in0_V_1_TVALID = in0_V_tvalid;
  assign in0_V_tready = in0_V_1_TREADY;
  assign out_V_tdata[7:0] = MVAU_hls_0_out_V_TDATA;
  assign out_V_tvalid = MVAU_hls_0_out_V_TVALID;
  assign s_axilite_1_ARADDR = s_axilite_araddr[11:0];
  assign s_axilite_1_ARPROT = s_axilite_arprot[2:0];
  assign s_axilite_1_ARVALID = s_axilite_arvalid;
  assign s_axilite_1_AWADDR = s_axilite_awaddr[11:0];
  assign s_axilite_1_AWPROT = s_axilite_awprot[2:0];
  assign s_axilite_1_AWVALID = s_axilite_awvalid;
  assign s_axilite_1_BREADY = s_axilite_bready;
  assign s_axilite_1_RREADY = s_axilite_rready;
  assign s_axilite_1_WDATA = s_axilite_wdata[31:0];
  assign s_axilite_1_WSTRB = s_axilite_wstrb[3:0];
  assign s_axilite_1_WVALID = s_axilite_wvalid;
  assign s_axilite_arready = s_axilite_1_ARREADY;
  assign s_axilite_awready = s_axilite_1_AWREADY;
  assign s_axilite_bresp[1:0] = s_axilite_1_BRESP;
  assign s_axilite_bvalid = s_axilite_1_BVALID;
  assign s_axilite_rdata[31:0] = s_axilite_1_RDATA;
  assign s_axilite_rresp[1:0] = s_axilite_1_RRESP;
  assign s_axilite_rvalid = s_axilite_1_RVALID;
  assign s_axilite_wready = s_axilite_1_WREADY;
  finn_design_MVAU_hls_0_0 MVAU_hls_0
       (.ap_clk(ap_clk_1),
        .ap_rst_n(ap_rst_n_1),
        .in0_V_TDATA(in0_V_1_TDATA),
        .in0_V_TREADY(in0_V_1_TREADY),
        .in0_V_TVALID(in0_V_1_TVALID),
        .out_V_TDATA(MVAU_hls_0_out_V_TDATA),
        .out_V_TREADY(MVAU_hls_0_out_V_TREADY),
        .out_V_TVALID(MVAU_hls_0_out_V_TVALID),
        .weights_V_TDATA(MVAU_hls_0_wstrm_m_axis_0_TDATA),
        .weights_V_TREADY(MVAU_hls_0_wstrm_m_axis_0_TREADY),
        .weights_V_TVALID(MVAU_hls_0_wstrm_m_axis_0_TVALID));
  finn_design_MVAU_hls_0_wstrm_0 MVAU_hls_0_wstrm
       (.ap_clk(ap_clk_1),
        .ap_rst_n(ap_rst_n_1),
        .araddr(s_axilite_1_ARADDR),
        .arprot(s_axilite_1_ARPROT),
        .arready(s_axilite_1_ARREADY),
        .arvalid(s_axilite_1_ARVALID),
        .awaddr(s_axilite_1_AWADDR),
        .awprot(s_axilite_1_AWPROT),
        .awready(s_axilite_1_AWREADY),
        .awvalid(s_axilite_1_AWVALID),
        .bready(s_axilite_1_BREADY),
        .bresp(s_axilite_1_BRESP),
        .bvalid(s_axilite_1_BVALID),
        .m_axis_0_tdata(MVAU_hls_0_wstrm_m_axis_0_TDATA),
        .m_axis_0_tready(MVAU_hls_0_wstrm_m_axis_0_TREADY),
        .m_axis_0_tvalid(MVAU_hls_0_wstrm_m_axis_0_TVALID),
        .rdata(s_axilite_1_RDATA),
        .rready(s_axilite_1_RREADY),
        .rresp(s_axilite_1_RRESP),
        .rvalid(s_axilite_1_RVALID),
        .wdata(s_axilite_1_WDATA),
        .wready(s_axilite_1_WREADY),
        .wstrb(s_axilite_1_WSTRB),
        .wvalid(s_axilite_1_WVALID));
endmodule

module MVAU_hls_1_imp_ZIW0NT
   (ap_clk,
    ap_rst_n,
    in0_V_tdata,
    in0_V_tready,
    in0_V_tvalid,
    out_V_tdata,
    out_V_tready,
    out_V_tvalid,
    s_axilite_araddr,
    s_axilite_arprot,
    s_axilite_arready,
    s_axilite_arvalid,
    s_axilite_awaddr,
    s_axilite_awprot,
    s_axilite_awready,
    s_axilite_awvalid,
    s_axilite_bready,
    s_axilite_bresp,
    s_axilite_bvalid,
    s_axilite_rdata,
    s_axilite_rready,
    s_axilite_rresp,
    s_axilite_rvalid,
    s_axilite_wdata,
    s_axilite_wready,
    s_axilite_wstrb,
    s_axilite_wvalid);
  input ap_clk;
  input ap_rst_n;
  input [7:0]in0_V_tdata;
  output in0_V_tready;
  input in0_V_tvalid;
  output [7:0]out_V_tdata;
  input out_V_tready;
  output out_V_tvalid;
  input [18:0]s_axilite_araddr;
  input [2:0]s_axilite_arprot;
  output s_axilite_arready;
  input s_axilite_arvalid;
  input [18:0]s_axilite_awaddr;
  input [2:0]s_axilite_awprot;
  output s_axilite_awready;
  input s_axilite_awvalid;
  input s_axilite_bready;
  output [1:0]s_axilite_bresp;
  output s_axilite_bvalid;
  output [31:0]s_axilite_rdata;
  input s_axilite_rready;
  output [1:0]s_axilite_rresp;
  output s_axilite_rvalid;
  input [31:0]s_axilite_wdata;
  output s_axilite_wready;
  input [3:0]s_axilite_wstrb;
  input s_axilite_wvalid;

  wire [7:0]MVAU_hls_1_out_V_TDATA;
  wire MVAU_hls_1_out_V_TREADY;
  wire MVAU_hls_1_out_V_TVALID;
  wire [15:0]MVAU_hls_1_wstrm_m_axis_0_TDATA;
  wire MVAU_hls_1_wstrm_m_axis_0_TREADY;
  wire MVAU_hls_1_wstrm_m_axis_0_TVALID;
  wire ap_clk_1;
  wire ap_rst_n_1;
  wire [7:0]in0_V_1_TDATA;
  wire in0_V_1_TREADY;
  wire in0_V_1_TVALID;
  wire [18:0]s_axilite_1_ARADDR;
  wire [2:0]s_axilite_1_ARPROT;
  wire s_axilite_1_ARREADY;
  wire s_axilite_1_ARVALID;
  wire [18:0]s_axilite_1_AWADDR;
  wire [2:0]s_axilite_1_AWPROT;
  wire s_axilite_1_AWREADY;
  wire s_axilite_1_AWVALID;
  wire s_axilite_1_BREADY;
  wire [1:0]s_axilite_1_BRESP;
  wire s_axilite_1_BVALID;
  wire [31:0]s_axilite_1_RDATA;
  wire s_axilite_1_RREADY;
  wire [1:0]s_axilite_1_RRESP;
  wire s_axilite_1_RVALID;
  wire [31:0]s_axilite_1_WDATA;
  wire s_axilite_1_WREADY;
  wire [3:0]s_axilite_1_WSTRB;
  wire s_axilite_1_WVALID;

  assign MVAU_hls_1_out_V_TREADY = out_V_tready;
  assign ap_clk_1 = ap_clk;
  assign ap_rst_n_1 = ap_rst_n;
  assign in0_V_1_TDATA = in0_V_tdata[7:0];
  assign in0_V_1_TVALID = in0_V_tvalid;
  assign in0_V_tready = in0_V_1_TREADY;
  assign out_V_tdata[7:0] = MVAU_hls_1_out_V_TDATA;
  assign out_V_tvalid = MVAU_hls_1_out_V_TVALID;
  assign s_axilite_1_ARADDR = s_axilite_araddr[18:0];
  assign s_axilite_1_ARPROT = s_axilite_arprot[2:0];
  assign s_axilite_1_ARVALID = s_axilite_arvalid;
  assign s_axilite_1_AWADDR = s_axilite_awaddr[18:0];
  assign s_axilite_1_AWPROT = s_axilite_awprot[2:0];
  assign s_axilite_1_AWVALID = s_axilite_awvalid;
  assign s_axilite_1_BREADY = s_axilite_bready;
  assign s_axilite_1_RREADY = s_axilite_rready;
  assign s_axilite_1_WDATA = s_axilite_wdata[31:0];
  assign s_axilite_1_WSTRB = s_axilite_wstrb[3:0];
  assign s_axilite_1_WVALID = s_axilite_wvalid;
  assign s_axilite_arready = s_axilite_1_ARREADY;
  assign s_axilite_awready = s_axilite_1_AWREADY;
  assign s_axilite_bresp[1:0] = s_axilite_1_BRESP;
  assign s_axilite_bvalid = s_axilite_1_BVALID;
  assign s_axilite_rdata[31:0] = s_axilite_1_RDATA;
  assign s_axilite_rresp[1:0] = s_axilite_1_RRESP;
  assign s_axilite_rvalid = s_axilite_1_RVALID;
  assign s_axilite_wready = s_axilite_1_WREADY;
  finn_design_MVAU_hls_1_0 MVAU_hls_1
       (.ap_clk(ap_clk_1),
        .ap_rst_n(ap_rst_n_1),
        .in0_V_TDATA(in0_V_1_TDATA),
        .in0_V_TREADY(in0_V_1_TREADY),
        .in0_V_TVALID(in0_V_1_TVALID),
        .out_V_TDATA(MVAU_hls_1_out_V_TDATA),
        .out_V_TREADY(MVAU_hls_1_out_V_TREADY),
        .out_V_TVALID(MVAU_hls_1_out_V_TVALID),
        .weights_V_TDATA(MVAU_hls_1_wstrm_m_axis_0_TDATA),
        .weights_V_TREADY(MVAU_hls_1_wstrm_m_axis_0_TREADY),
        .weights_V_TVALID(MVAU_hls_1_wstrm_m_axis_0_TVALID));
  finn_design_MVAU_hls_1_wstrm_0 MVAU_hls_1_wstrm
       (.ap_clk(ap_clk_1),
        .ap_rst_n(ap_rst_n_1),
        .araddr(s_axilite_1_ARADDR),
        .arprot(s_axilite_1_ARPROT),
        .arready(s_axilite_1_ARREADY),
        .arvalid(s_axilite_1_ARVALID),
        .awaddr(s_axilite_1_AWADDR),
        .awprot(s_axilite_1_AWPROT),
        .awready(s_axilite_1_AWREADY),
        .awvalid(s_axilite_1_AWVALID),
        .bready(s_axilite_1_BREADY),
        .bresp(s_axilite_1_BRESP),
        .bvalid(s_axilite_1_BVALID),
        .m_axis_0_tdata(MVAU_hls_1_wstrm_m_axis_0_TDATA),
        .m_axis_0_tready(MVAU_hls_1_wstrm_m_axis_0_TREADY),
        .m_axis_0_tvalid(MVAU_hls_1_wstrm_m_axis_0_TVALID),
        .rdata(s_axilite_1_RDATA),
        .rready(s_axilite_1_RREADY),
        .rresp(s_axilite_1_RRESP),
        .rvalid(s_axilite_1_RVALID),
        .wdata(s_axilite_1_WDATA),
        .wready(s_axilite_1_WREADY),
        .wstrb(s_axilite_1_WSTRB),
        .wvalid(s_axilite_1_WVALID));
endmodule

module MVAU_hls_2_imp_1WP2WTL
   (ap_clk,
    ap_rst_n,
    in0_V_tdata,
    in0_V_tready,
    in0_V_tvalid,
    out_V_tdata,
    out_V_tready,
    out_V_tvalid,
    s_axilite_araddr,
    s_axilite_arprot,
    s_axilite_arready,
    s_axilite_arvalid,
    s_axilite_awaddr,
    s_axilite_awprot,
    s_axilite_awready,
    s_axilite_awvalid,
    s_axilite_bready,
    s_axilite_bresp,
    s_axilite_bvalid,
    s_axilite_rdata,
    s_axilite_rready,
    s_axilite_rresp,
    s_axilite_rvalid,
    s_axilite_wdata,
    s_axilite_wready,
    s_axilite_wstrb,
    s_axilite_wvalid);
  input ap_clk;
  input ap_rst_n;
  input [7:0]in0_V_tdata;
  output in0_V_tready;
  input in0_V_tvalid;
  output [7:0]out_V_tdata;
  input out_V_tready;
  output out_V_tvalid;
  input [19:0]s_axilite_araddr;
  input [2:0]s_axilite_arprot;
  output s_axilite_arready;
  input s_axilite_arvalid;
  input [19:0]s_axilite_awaddr;
  input [2:0]s_axilite_awprot;
  output s_axilite_awready;
  input s_axilite_awvalid;
  input s_axilite_bready;
  output [1:0]s_axilite_bresp;
  output s_axilite_bvalid;
  output [31:0]s_axilite_rdata;
  input s_axilite_rready;
  output [1:0]s_axilite_rresp;
  output s_axilite_rvalid;
  input [31:0]s_axilite_wdata;
  output s_axilite_wready;
  input [3:0]s_axilite_wstrb;
  input s_axilite_wvalid;

  wire [7:0]MVAU_hls_2_out_V_TDATA;
  wire MVAU_hls_2_out_V_TREADY;
  wire MVAU_hls_2_out_V_TVALID;
  wire [15:0]MVAU_hls_2_wstrm_m_axis_0_TDATA;
  wire MVAU_hls_2_wstrm_m_axis_0_TREADY;
  wire MVAU_hls_2_wstrm_m_axis_0_TVALID;
  wire ap_clk_1;
  wire ap_rst_n_1;
  wire [7:0]in0_V_1_TDATA;
  wire in0_V_1_TREADY;
  wire in0_V_1_TVALID;
  wire [19:0]s_axilite_1_ARADDR;
  wire [2:0]s_axilite_1_ARPROT;
  wire s_axilite_1_ARREADY;
  wire s_axilite_1_ARVALID;
  wire [19:0]s_axilite_1_AWADDR;
  wire [2:0]s_axilite_1_AWPROT;
  wire s_axilite_1_AWREADY;
  wire s_axilite_1_AWVALID;
  wire s_axilite_1_BREADY;
  wire [1:0]s_axilite_1_BRESP;
  wire s_axilite_1_BVALID;
  wire [31:0]s_axilite_1_RDATA;
  wire s_axilite_1_RREADY;
  wire [1:0]s_axilite_1_RRESP;
  wire s_axilite_1_RVALID;
  wire [31:0]s_axilite_1_WDATA;
  wire s_axilite_1_WREADY;
  wire [3:0]s_axilite_1_WSTRB;
  wire s_axilite_1_WVALID;

  assign MVAU_hls_2_out_V_TREADY = out_V_tready;
  assign ap_clk_1 = ap_clk;
  assign ap_rst_n_1 = ap_rst_n;
  assign in0_V_1_TDATA = in0_V_tdata[7:0];
  assign in0_V_1_TVALID = in0_V_tvalid;
  assign in0_V_tready = in0_V_1_TREADY;
  assign out_V_tdata[7:0] = MVAU_hls_2_out_V_TDATA;
  assign out_V_tvalid = MVAU_hls_2_out_V_TVALID;
  assign s_axilite_1_ARADDR = s_axilite_araddr[19:0];
  assign s_axilite_1_ARPROT = s_axilite_arprot[2:0];
  assign s_axilite_1_ARVALID = s_axilite_arvalid;
  assign s_axilite_1_AWADDR = s_axilite_awaddr[19:0];
  assign s_axilite_1_AWPROT = s_axilite_awprot[2:0];
  assign s_axilite_1_AWVALID = s_axilite_awvalid;
  assign s_axilite_1_BREADY = s_axilite_bready;
  assign s_axilite_1_RREADY = s_axilite_rready;
  assign s_axilite_1_WDATA = s_axilite_wdata[31:0];
  assign s_axilite_1_WSTRB = s_axilite_wstrb[3:0];
  assign s_axilite_1_WVALID = s_axilite_wvalid;
  assign s_axilite_arready = s_axilite_1_ARREADY;
  assign s_axilite_awready = s_axilite_1_AWREADY;
  assign s_axilite_bresp[1:0] = s_axilite_1_BRESP;
  assign s_axilite_bvalid = s_axilite_1_BVALID;
  assign s_axilite_rdata[31:0] = s_axilite_1_RDATA;
  assign s_axilite_rresp[1:0] = s_axilite_1_RRESP;
  assign s_axilite_rvalid = s_axilite_1_RVALID;
  assign s_axilite_wready = s_axilite_1_WREADY;
  finn_design_MVAU_hls_2_0 MVAU_hls_2
       (.ap_clk(ap_clk_1),
        .ap_rst_n(ap_rst_n_1),
        .in0_V_TDATA(in0_V_1_TDATA),
        .in0_V_TREADY(in0_V_1_TREADY),
        .in0_V_TVALID(in0_V_1_TVALID),
        .out_V_TDATA(MVAU_hls_2_out_V_TDATA),
        .out_V_TREADY(MVAU_hls_2_out_V_TREADY),
        .out_V_TVALID(MVAU_hls_2_out_V_TVALID),
        .weights_V_TDATA(MVAU_hls_2_wstrm_m_axis_0_TDATA),
        .weights_V_TREADY(MVAU_hls_2_wstrm_m_axis_0_TREADY),
        .weights_V_TVALID(MVAU_hls_2_wstrm_m_axis_0_TVALID));
  finn_design_MVAU_hls_2_wstrm_0 MVAU_hls_2_wstrm
       (.ap_clk(ap_clk_1),
        .ap_rst_n(ap_rst_n_1),
        .araddr(s_axilite_1_ARADDR),
        .arprot(s_axilite_1_ARPROT),
        .arready(s_axilite_1_ARREADY),
        .arvalid(s_axilite_1_ARVALID),
        .awaddr(s_axilite_1_AWADDR),
        .awprot(s_axilite_1_AWPROT),
        .awready(s_axilite_1_AWREADY),
        .awvalid(s_axilite_1_AWVALID),
        .bready(s_axilite_1_BREADY),
        .bresp(s_axilite_1_BRESP),
        .bvalid(s_axilite_1_BVALID),
        .m_axis_0_tdata(MVAU_hls_2_wstrm_m_axis_0_TDATA),
        .m_axis_0_tready(MVAU_hls_2_wstrm_m_axis_0_TREADY),
        .m_axis_0_tvalid(MVAU_hls_2_wstrm_m_axis_0_TVALID),
        .rdata(s_axilite_1_RDATA),
        .rready(s_axilite_1_RREADY),
        .rresp(s_axilite_1_RRESP),
        .rvalid(s_axilite_1_RVALID),
        .wdata(s_axilite_1_WDATA),
        .wready(s_axilite_1_WREADY),
        .wstrb(s_axilite_1_WSTRB),
        .wvalid(s_axilite_1_WVALID));
endmodule

module MVAU_hls_3_imp_U0RWZQ
   (ap_clk,
    ap_rst_n,
    in0_V_tdata,
    in0_V_tready,
    in0_V_tvalid,
    out_V_tdata,
    out_V_tready,
    out_V_tvalid,
    s_axilite_araddr,
    s_axilite_arprot,
    s_axilite_arready,
    s_axilite_arvalid,
    s_axilite_awaddr,
    s_axilite_awprot,
    s_axilite_awready,
    s_axilite_awvalid,
    s_axilite_bready,
    s_axilite_bresp,
    s_axilite_bvalid,
    s_axilite_rdata,
    s_axilite_rready,
    s_axilite_rresp,
    s_axilite_rvalid,
    s_axilite_wdata,
    s_axilite_wready,
    s_axilite_wstrb,
    s_axilite_wvalid);
  input ap_clk;
  input ap_rst_n;
  input [7:0]in0_V_tdata;
  output in0_V_tready;
  input in0_V_tvalid;
  output [7:0]out_V_tdata;
  input out_V_tready;
  output out_V_tvalid;
  input [20:0]s_axilite_araddr;
  input [2:0]s_axilite_arprot;
  output s_axilite_arready;
  input s_axilite_arvalid;
  input [20:0]s_axilite_awaddr;
  input [2:0]s_axilite_awprot;
  output s_axilite_awready;
  input s_axilite_awvalid;
  input s_axilite_bready;
  output [1:0]s_axilite_bresp;
  output s_axilite_bvalid;
  output [31:0]s_axilite_rdata;
  input s_axilite_rready;
  output [1:0]s_axilite_rresp;
  output s_axilite_rvalid;
  input [31:0]s_axilite_wdata;
  output s_axilite_wready;
  input [3:0]s_axilite_wstrb;
  input s_axilite_wvalid;

  wire [7:0]MVAU_hls_3_out_V_TDATA;
  wire MVAU_hls_3_out_V_TREADY;
  wire MVAU_hls_3_out_V_TVALID;
  wire [15:0]MVAU_hls_3_wstrm_m_axis_0_TDATA;
  wire MVAU_hls_3_wstrm_m_axis_0_TREADY;
  wire MVAU_hls_3_wstrm_m_axis_0_TVALID;
  wire ap_clk_1;
  wire ap_rst_n_1;
  wire [7:0]in0_V_1_TDATA;
  wire in0_V_1_TREADY;
  wire in0_V_1_TVALID;
  wire [20:0]s_axilite_1_ARADDR;
  wire [2:0]s_axilite_1_ARPROT;
  wire s_axilite_1_ARREADY;
  wire s_axilite_1_ARVALID;
  wire [20:0]s_axilite_1_AWADDR;
  wire [2:0]s_axilite_1_AWPROT;
  wire s_axilite_1_AWREADY;
  wire s_axilite_1_AWVALID;
  wire s_axilite_1_BREADY;
  wire [1:0]s_axilite_1_BRESP;
  wire s_axilite_1_BVALID;
  wire [31:0]s_axilite_1_RDATA;
  wire s_axilite_1_RREADY;
  wire [1:0]s_axilite_1_RRESP;
  wire s_axilite_1_RVALID;
  wire [31:0]s_axilite_1_WDATA;
  wire s_axilite_1_WREADY;
  wire [3:0]s_axilite_1_WSTRB;
  wire s_axilite_1_WVALID;

  assign MVAU_hls_3_out_V_TREADY = out_V_tready;
  assign ap_clk_1 = ap_clk;
  assign ap_rst_n_1 = ap_rst_n;
  assign in0_V_1_TDATA = in0_V_tdata[7:0];
  assign in0_V_1_TVALID = in0_V_tvalid;
  assign in0_V_tready = in0_V_1_TREADY;
  assign out_V_tdata[7:0] = MVAU_hls_3_out_V_TDATA;
  assign out_V_tvalid = MVAU_hls_3_out_V_TVALID;
  assign s_axilite_1_ARADDR = s_axilite_araddr[20:0];
  assign s_axilite_1_ARPROT = s_axilite_arprot[2:0];
  assign s_axilite_1_ARVALID = s_axilite_arvalid;
  assign s_axilite_1_AWADDR = s_axilite_awaddr[20:0];
  assign s_axilite_1_AWPROT = s_axilite_awprot[2:0];
  assign s_axilite_1_AWVALID = s_axilite_awvalid;
  assign s_axilite_1_BREADY = s_axilite_bready;
  assign s_axilite_1_RREADY = s_axilite_rready;
  assign s_axilite_1_WDATA = s_axilite_wdata[31:0];
  assign s_axilite_1_WSTRB = s_axilite_wstrb[3:0];
  assign s_axilite_1_WVALID = s_axilite_wvalid;
  assign s_axilite_arready = s_axilite_1_ARREADY;
  assign s_axilite_awready = s_axilite_1_AWREADY;
  assign s_axilite_bresp[1:0] = s_axilite_1_BRESP;
  assign s_axilite_bvalid = s_axilite_1_BVALID;
  assign s_axilite_rdata[31:0] = s_axilite_1_RDATA;
  assign s_axilite_rresp[1:0] = s_axilite_1_RRESP;
  assign s_axilite_rvalid = s_axilite_1_RVALID;
  assign s_axilite_wready = s_axilite_1_WREADY;
  finn_design_MVAU_hls_3_0 MVAU_hls_3
       (.ap_clk(ap_clk_1),
        .ap_rst_n(ap_rst_n_1),
        .in0_V_TDATA(in0_V_1_TDATA),
        .in0_V_TREADY(in0_V_1_TREADY),
        .in0_V_TVALID(in0_V_1_TVALID),
        .out_V_TDATA(MVAU_hls_3_out_V_TDATA),
        .out_V_TREADY(MVAU_hls_3_out_V_TREADY),
        .out_V_TVALID(MVAU_hls_3_out_V_TVALID),
        .weights_V_TDATA(MVAU_hls_3_wstrm_m_axis_0_TDATA),
        .weights_V_TREADY(MVAU_hls_3_wstrm_m_axis_0_TREADY),
        .weights_V_TVALID(MVAU_hls_3_wstrm_m_axis_0_TVALID));
  finn_design_MVAU_hls_3_wstrm_0 MVAU_hls_3_wstrm
       (.ap_clk(ap_clk_1),
        .ap_rst_n(ap_rst_n_1),
        .araddr(s_axilite_1_ARADDR),
        .arprot(s_axilite_1_ARPROT),
        .arready(s_axilite_1_ARREADY),
        .arvalid(s_axilite_1_ARVALID),
        .awaddr(s_axilite_1_AWADDR),
        .awprot(s_axilite_1_AWPROT),
        .awready(s_axilite_1_AWREADY),
        .awvalid(s_axilite_1_AWVALID),
        .bready(s_axilite_1_BREADY),
        .bresp(s_axilite_1_BRESP),
        .bvalid(s_axilite_1_BVALID),
        .m_axis_0_tdata(MVAU_hls_3_wstrm_m_axis_0_TDATA),
        .m_axis_0_tready(MVAU_hls_3_wstrm_m_axis_0_TREADY),
        .m_axis_0_tvalid(MVAU_hls_3_wstrm_m_axis_0_TVALID),
        .rdata(s_axilite_1_RDATA),
        .rready(s_axilite_1_RREADY),
        .rresp(s_axilite_1_RRESP),
        .rvalid(s_axilite_1_RVALID),
        .wdata(s_axilite_1_WDATA),
        .wready(s_axilite_1_WREADY),
        .wstrb(s_axilite_1_WSTRB),
        .wvalid(s_axilite_1_WVALID));
endmodule

module MVAU_hls_4_imp_6UFUIX
   (ap_clk,
    ap_rst_n,
    in0_V_tdata,
    in0_V_tready,
    in0_V_tvalid,
    out_V_tdata,
    out_V_tready,
    out_V_tvalid,
    s_axilite_araddr,
    s_axilite_arprot,
    s_axilite_arready,
    s_axilite_arvalid,
    s_axilite_awaddr,
    s_axilite_awprot,
    s_axilite_awready,
    s_axilite_awvalid,
    s_axilite_bready,
    s_axilite_bresp,
    s_axilite_bvalid,
    s_axilite_rdata,
    s_axilite_rready,
    s_axilite_rresp,
    s_axilite_rvalid,
    s_axilite_wdata,
    s_axilite_wready,
    s_axilite_wstrb,
    s_axilite_wvalid);
  input ap_clk;
  input ap_rst_n;
  input [7:0]in0_V_tdata;
  output in0_V_tready;
  input in0_V_tvalid;
  output [39:0]out_V_tdata;
  input out_V_tready;
  output out_V_tvalid;
  input [16:0]s_axilite_araddr;
  input [2:0]s_axilite_arprot;
  output s_axilite_arready;
  input s_axilite_arvalid;
  input [16:0]s_axilite_awaddr;
  input [2:0]s_axilite_awprot;
  output s_axilite_awready;
  input s_axilite_awvalid;
  input s_axilite_bready;
  output [1:0]s_axilite_bresp;
  output s_axilite_bvalid;
  output [31:0]s_axilite_rdata;
  input s_axilite_rready;
  output [1:0]s_axilite_rresp;
  output s_axilite_rvalid;
  input [31:0]s_axilite_wdata;
  output s_axilite_wready;
  input [3:0]s_axilite_wstrb;
  input s_axilite_wvalid;

  wire [39:0]MVAU_hls_4_out_V_TDATA;
  wire MVAU_hls_4_out_V_TREADY;
  wire MVAU_hls_4_out_V_TVALID;
  wire [15:0]MVAU_hls_4_wstrm_m_axis_0_TDATA;
  wire MVAU_hls_4_wstrm_m_axis_0_TREADY;
  wire MVAU_hls_4_wstrm_m_axis_0_TVALID;
  wire ap_clk_1;
  wire ap_rst_n_1;
  wire [7:0]in0_V_1_TDATA;
  wire in0_V_1_TREADY;
  wire in0_V_1_TVALID;
  wire [16:0]s_axilite_1_ARADDR;
  wire [2:0]s_axilite_1_ARPROT;
  wire s_axilite_1_ARREADY;
  wire s_axilite_1_ARVALID;
  wire [16:0]s_axilite_1_AWADDR;
  wire [2:0]s_axilite_1_AWPROT;
  wire s_axilite_1_AWREADY;
  wire s_axilite_1_AWVALID;
  wire s_axilite_1_BREADY;
  wire [1:0]s_axilite_1_BRESP;
  wire s_axilite_1_BVALID;
  wire [31:0]s_axilite_1_RDATA;
  wire s_axilite_1_RREADY;
  wire [1:0]s_axilite_1_RRESP;
  wire s_axilite_1_RVALID;
  wire [31:0]s_axilite_1_WDATA;
  wire s_axilite_1_WREADY;
  wire [3:0]s_axilite_1_WSTRB;
  wire s_axilite_1_WVALID;

  assign MVAU_hls_4_out_V_TREADY = out_V_tready;
  assign ap_clk_1 = ap_clk;
  assign ap_rst_n_1 = ap_rst_n;
  assign in0_V_1_TDATA = in0_V_tdata[7:0];
  assign in0_V_1_TVALID = in0_V_tvalid;
  assign in0_V_tready = in0_V_1_TREADY;
  assign out_V_tdata[39:0] = MVAU_hls_4_out_V_TDATA;
  assign out_V_tvalid = MVAU_hls_4_out_V_TVALID;
  assign s_axilite_1_ARADDR = s_axilite_araddr[16:0];
  assign s_axilite_1_ARPROT = s_axilite_arprot[2:0];
  assign s_axilite_1_ARVALID = s_axilite_arvalid;
  assign s_axilite_1_AWADDR = s_axilite_awaddr[16:0];
  assign s_axilite_1_AWPROT = s_axilite_awprot[2:0];
  assign s_axilite_1_AWVALID = s_axilite_awvalid;
  assign s_axilite_1_BREADY = s_axilite_bready;
  assign s_axilite_1_RREADY = s_axilite_rready;
  assign s_axilite_1_WDATA = s_axilite_wdata[31:0];
  assign s_axilite_1_WSTRB = s_axilite_wstrb[3:0];
  assign s_axilite_1_WVALID = s_axilite_wvalid;
  assign s_axilite_arready = s_axilite_1_ARREADY;
  assign s_axilite_awready = s_axilite_1_AWREADY;
  assign s_axilite_bresp[1:0] = s_axilite_1_BRESP;
  assign s_axilite_bvalid = s_axilite_1_BVALID;
  assign s_axilite_rdata[31:0] = s_axilite_1_RDATA;
  assign s_axilite_rresp[1:0] = s_axilite_1_RRESP;
  assign s_axilite_rvalid = s_axilite_1_RVALID;
  assign s_axilite_wready = s_axilite_1_WREADY;
  finn_design_MVAU_hls_4_0 MVAU_hls_4
       (.ap_clk(ap_clk_1),
        .ap_rst_n(ap_rst_n_1),
        .in0_V_TDATA(in0_V_1_TDATA),
        .in0_V_TREADY(in0_V_1_TREADY),
        .in0_V_TVALID(in0_V_1_TVALID),
        .out_V_TDATA(MVAU_hls_4_out_V_TDATA),
        .out_V_TREADY(MVAU_hls_4_out_V_TREADY),
        .out_V_TVALID(MVAU_hls_4_out_V_TVALID),
        .weights_V_TDATA(MVAU_hls_4_wstrm_m_axis_0_TDATA),
        .weights_V_TREADY(MVAU_hls_4_wstrm_m_axis_0_TREADY),
        .weights_V_TVALID(MVAU_hls_4_wstrm_m_axis_0_TVALID));
  finn_design_MVAU_hls_4_wstrm_0 MVAU_hls_4_wstrm
       (.ap_clk(ap_clk_1),
        .ap_rst_n(ap_rst_n_1),
        .araddr(s_axilite_1_ARADDR),
        .arprot(s_axilite_1_ARPROT),
        .arready(s_axilite_1_ARREADY),
        .arvalid(s_axilite_1_ARVALID),
        .awaddr(s_axilite_1_AWADDR),
        .awprot(s_axilite_1_AWPROT),
        .awready(s_axilite_1_AWREADY),
        .awvalid(s_axilite_1_AWVALID),
        .bready(s_axilite_1_BREADY),
        .bresp(s_axilite_1_BRESP),
        .bvalid(s_axilite_1_BVALID),
        .m_axis_0_tdata(MVAU_hls_4_wstrm_m_axis_0_TDATA),
        .m_axis_0_tready(MVAU_hls_4_wstrm_m_axis_0_TREADY),
        .m_axis_0_tvalid(MVAU_hls_4_wstrm_m_axis_0_TVALID),
        .rdata(s_axilite_1_RDATA),
        .rready(s_axilite_1_RREADY),
        .rresp(s_axilite_1_RRESP),
        .rvalid(s_axilite_1_RVALID),
        .wdata(s_axilite_1_WDATA),
        .wready(s_axilite_1_WREADY),
        .wstrb(s_axilite_1_WSTRB),
        .wvalid(s_axilite_1_WVALID));
endmodule

module StreamingFIFO_rtl_2_imp_1FWKJ6V
   (ap_clk,
    ap_rst_n,
    in0_V_tdata,
    in0_V_tready,
    in0_V_tvalid,
    out_V_tdata,
    out_V_tready,
    out_V_tvalid);
  input ap_clk;
  input ap_rst_n;
  input [7:0]in0_V_tdata;
  output in0_V_tready;
  input in0_V_tvalid;
  output [7:0]out_V_tdata;
  input out_V_tready;
  output out_V_tvalid;

  wire ap_clk_1;
  wire ap_rst_n_1;
  wire [7:0]fifo_M_AXIS_TDATA;
  wire fifo_M_AXIS_TREADY;
  wire fifo_M_AXIS_TVALID;
  wire [7:0]in0_V_1_TDATA;
  wire in0_V_1_TREADY;
  wire in0_V_1_TVALID;

  assign ap_clk_1 = ap_clk;
  assign ap_rst_n_1 = ap_rst_n;
  assign fifo_M_AXIS_TREADY = out_V_tready;
  assign in0_V_1_TDATA = in0_V_tdata[7:0];
  assign in0_V_1_TVALID = in0_V_tvalid;
  assign in0_V_tready = in0_V_1_TREADY;
  assign out_V_tdata[7:0] = fifo_M_AXIS_TDATA;
  assign out_V_tvalid = fifo_M_AXIS_TVALID;
  finn_design_fifo_0 fifo
       (.m_axis_tdata(fifo_M_AXIS_TDATA),
        .m_axis_tready(fifo_M_AXIS_TREADY),
        .m_axis_tvalid(fifo_M_AXIS_TVALID),
        .s_axis_aclk(ap_clk_1),
        .s_axis_aresetn(ap_rst_n_1),
        .s_axis_tdata(in0_V_1_TDATA),
        .s_axis_tready(in0_V_1_TREADY),
        .s_axis_tvalid(in0_V_1_TVALID));
endmodule

module StreamingFIFO_rtl_3_imp_92O214
   (ap_clk,
    ap_rst_n,
    in0_V_tdata,
    in0_V_tready,
    in0_V_tvalid,
    out_V_tdata,
    out_V_tready,
    out_V_tvalid);
  input ap_clk;
  input ap_rst_n;
  input [7:0]in0_V_tdata;
  output in0_V_tready;
  input in0_V_tvalid;
  output [7:0]out_V_tdata;
  input out_V_tready;
  output out_V_tvalid;

  wire ap_clk_1;
  wire ap_rst_n_1;
  wire [7:0]fifo_M_AXIS_TDATA;
  wire fifo_M_AXIS_TREADY;
  wire fifo_M_AXIS_TVALID;
  wire [7:0]in0_V_1_TDATA;
  wire in0_V_1_TREADY;
  wire in0_V_1_TVALID;

  assign ap_clk_1 = ap_clk;
  assign ap_rst_n_1 = ap_rst_n;
  assign fifo_M_AXIS_TREADY = out_V_tready;
  assign in0_V_1_TDATA = in0_V_tdata[7:0];
  assign in0_V_1_TVALID = in0_V_tvalid;
  assign in0_V_tready = in0_V_1_TREADY;
  assign out_V_tdata[7:0] = fifo_M_AXIS_TDATA;
  assign out_V_tvalid = fifo_M_AXIS_TVALID;
  finn_design_fifo_1 fifo
       (.m_axis_tdata(fifo_M_AXIS_TDATA),
        .m_axis_tready(fifo_M_AXIS_TREADY),
        .m_axis_tvalid(fifo_M_AXIS_TVALID),
        .s_axis_aclk(ap_clk_1),
        .s_axis_aresetn(ap_rst_n_1),
        .s_axis_tdata(in0_V_1_TDATA),
        .s_axis_tready(in0_V_1_TREADY),
        .s_axis_tvalid(in0_V_1_TVALID));
endmodule

(* CORE_GENERATION_INFO = "finn_design,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=finn_design,x_ipVersion=1.00.a,x_ipLanguage=VERILOG,numBlks=23,numReposBlks=16,numNonXlnxBlks=5,numHierBlks=7,maxHierDepth=1,numSysgenBlks=0,numHlsBlks=5,numHdlrefBlks=4,numPkgbdBlks=0,bdsource=USER,synth_mode=Hierarchical}" *) (* HW_HANDOFF = "finn_design.hwdef" *) 
module finn_design
   (ap_clk,
    ap_rst_n,
    m_axis_0_tdata,
    m_axis_0_tready,
    m_axis_0_tvalid,
    s_axilite_0_araddr,
    s_axilite_0_arprot,
    s_axilite_0_arready,
    s_axilite_0_arvalid,
    s_axilite_0_awaddr,
    s_axilite_0_awprot,
    s_axilite_0_awready,
    s_axilite_0_awvalid,
    s_axilite_0_bready,
    s_axilite_0_bresp,
    s_axilite_0_bvalid,
    s_axilite_0_rdata,
    s_axilite_0_rready,
    s_axilite_0_rresp,
    s_axilite_0_rvalid,
    s_axilite_0_wdata,
    s_axilite_0_wready,
    s_axilite_0_wstrb,
    s_axilite_0_wvalid,
    s_axilite_1_araddr,
    s_axilite_1_arprot,
    s_axilite_1_arready,
    s_axilite_1_arvalid,
    s_axilite_1_awaddr,
    s_axilite_1_awprot,
    s_axilite_1_awready,
    s_axilite_1_awvalid,
    s_axilite_1_bready,
    s_axilite_1_bresp,
    s_axilite_1_bvalid,
    s_axilite_1_rdata,
    s_axilite_1_rready,
    s_axilite_1_rresp,
    s_axilite_1_rvalid,
    s_axilite_1_wdata,
    s_axilite_1_wready,
    s_axilite_1_wstrb,
    s_axilite_1_wvalid,
    s_axilite_2_araddr,
    s_axilite_2_arprot,
    s_axilite_2_arready,
    s_axilite_2_arvalid,
    s_axilite_2_awaddr,
    s_axilite_2_awprot,
    s_axilite_2_awready,
    s_axilite_2_awvalid,
    s_axilite_2_bready,
    s_axilite_2_bresp,
    s_axilite_2_bvalid,
    s_axilite_2_rdata,
    s_axilite_2_rready,
    s_axilite_2_rresp,
    s_axilite_2_rvalid,
    s_axilite_2_wdata,
    s_axilite_2_wready,
    s_axilite_2_wstrb,
    s_axilite_2_wvalid,
    s_axilite_3_araddr,
    s_axilite_3_arprot,
    s_axilite_3_arready,
    s_axilite_3_arvalid,
    s_axilite_3_awaddr,
    s_axilite_3_awprot,
    s_axilite_3_awready,
    s_axilite_3_awvalid,
    s_axilite_3_bready,
    s_axilite_3_bresp,
    s_axilite_3_bvalid,
    s_axilite_3_rdata,
    s_axilite_3_rready,
    s_axilite_3_rresp,
    s_axilite_3_rvalid,
    s_axilite_3_wdata,
    s_axilite_3_wready,
    s_axilite_3_wstrb,
    s_axilite_3_wvalid,
    s_axilite_4_araddr,
    s_axilite_4_arprot,
    s_axilite_4_arready,
    s_axilite_4_arvalid,
    s_axilite_4_awaddr,
    s_axilite_4_awprot,
    s_axilite_4_awready,
    s_axilite_4_awvalid,
    s_axilite_4_bready,
    s_axilite_4_bresp,
    s_axilite_4_bvalid,
    s_axilite_4_rdata,
    s_axilite_4_rready,
    s_axilite_4_rresp,
    s_axilite_4_rvalid,
    s_axilite_4_wdata,
    s_axilite_4_wready,
    s_axilite_4_wstrb,
    s_axilite_4_wvalid,
    s_axis_0_tdata,
    s_axis_0_tready,
    s_axis_0_tvalid);
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.AP_CLK CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.AP_CLK, ASSOCIATED_BUSIF s_axilite_0:s_axilite_1:s_axilite_2:s_axilite_3:s_axilite_4:s_axis_0:m_axis_0, ASSOCIATED_RESET ap_rst_n, CLK_DOMAIN finn_design_ap_clk_0, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, INSERT_VIP 0, PHASE 0.0" *) input ap_clk;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 RST.AP_RST_N RST" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME RST.AP_RST_N, INSERT_VIP 0, POLARITY ACTIVE_LOW" *) input ap_rst_n;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m_axis_0 " *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME m_axis_0, CLK_DOMAIN finn_design_ap_clk_0, FREQ_HZ 100000000, HAS_TKEEP 0, HAS_TLAST 0, HAS_TREADY 1, HAS_TSTRB 0, INSERT_VIP 0, LAYERED_METADATA undef, PHASE 0.0, TDATA_NUM_BYTES 5, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0" *) output [39:0]m_axis_0_tdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m_axis_0 " *) input m_axis_0_tready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m_axis_0 " *) output m_axis_0_tvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axilite_0 ARADDR" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME s_axilite_0, ADDR_WIDTH 12, ARUSER_WIDTH 0, AWUSER_WIDTH 0, BUSER_WIDTH 0, CLK_DOMAIN finn_design_ap_clk_0, DATA_WIDTH 32, FREQ_HZ 100000000, HAS_BRESP 1, HAS_BURST 0, HAS_CACHE 0, HAS_LOCK 0, HAS_PROT 1, HAS_QOS 0, HAS_REGION 0, HAS_RRESP 1, HAS_WSTRB 1, ID_WIDTH 0, INSERT_VIP 0, MAX_BURST_LENGTH 1, NUM_READ_OUTSTANDING 1, NUM_READ_THREADS 1, NUM_WRITE_OUTSTANDING 1, NUM_WRITE_THREADS 1, PHASE 0.0, PROTOCOL AXI4LITE, READ_WRITE_MODE READ_WRITE, RUSER_BITS_PER_BYTE 0, RUSER_WIDTH 0, SUPPORTS_NARROW_BURST 0, WUSER_BITS_PER_BYTE 0, WUSER_WIDTH 0" *) input [11:0]s_axilite_0_araddr;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axilite_0 ARPROT" *) input [2:0]s_axilite_0_arprot;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axilite_0 ARREADY" *) output s_axilite_0_arready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axilite_0 ARVALID" *) input s_axilite_0_arvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axilite_0 AWADDR" *) input [11:0]s_axilite_0_awaddr;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axilite_0 AWPROT" *) input [2:0]s_axilite_0_awprot;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axilite_0 AWREADY" *) output s_axilite_0_awready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axilite_0 AWVALID" *) input s_axilite_0_awvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axilite_0 BREADY" *) input s_axilite_0_bready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axilite_0 BRESP" *) output [1:0]s_axilite_0_bresp;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axilite_0 BVALID" *) output s_axilite_0_bvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axilite_0 RDATA" *) output [31:0]s_axilite_0_rdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axilite_0 RREADY" *) input s_axilite_0_rready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axilite_0 RRESP" *) output [1:0]s_axilite_0_rresp;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axilite_0 RVALID" *) output s_axilite_0_rvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axilite_0 WDATA" *) input [31:0]s_axilite_0_wdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axilite_0 WREADY" *) output s_axilite_0_wready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axilite_0 WSTRB" *) input [3:0]s_axilite_0_wstrb;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axilite_0 WVALID" *) input s_axilite_0_wvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axilite_1 ARADDR" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME s_axilite_1, ADDR_WIDTH 19, ARUSER_WIDTH 0, AWUSER_WIDTH 0, BUSER_WIDTH 0, CLK_DOMAIN finn_design_ap_clk_0, DATA_WIDTH 32, FREQ_HZ 100000000, HAS_BRESP 1, HAS_BURST 0, HAS_CACHE 0, HAS_LOCK 0, HAS_PROT 1, HAS_QOS 0, HAS_REGION 0, HAS_RRESP 1, HAS_WSTRB 1, ID_WIDTH 0, INSERT_VIP 0, MAX_BURST_LENGTH 1, NUM_READ_OUTSTANDING 1, NUM_READ_THREADS 1, NUM_WRITE_OUTSTANDING 1, NUM_WRITE_THREADS 1, PHASE 0.0, PROTOCOL AXI4LITE, READ_WRITE_MODE READ_WRITE, RUSER_BITS_PER_BYTE 0, RUSER_WIDTH 0, SUPPORTS_NARROW_BURST 0, WUSER_BITS_PER_BYTE 0, WUSER_WIDTH 0" *) input [18:0]s_axilite_1_araddr;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axilite_1 ARPROT" *) input [2:0]s_axilite_1_arprot;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axilite_1 ARREADY" *) output s_axilite_1_arready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axilite_1 ARVALID" *) input s_axilite_1_arvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axilite_1 AWADDR" *) input [18:0]s_axilite_1_awaddr;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axilite_1 AWPROT" *) input [2:0]s_axilite_1_awprot;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axilite_1 AWREADY" *) output s_axilite_1_awready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axilite_1 AWVALID" *) input s_axilite_1_awvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axilite_1 BREADY" *) input s_axilite_1_bready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axilite_1 BRESP" *) output [1:0]s_axilite_1_bresp;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axilite_1 BVALID" *) output s_axilite_1_bvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axilite_1 RDATA" *) output [31:0]s_axilite_1_rdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axilite_1 RREADY" *) input s_axilite_1_rready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axilite_1 RRESP" *) output [1:0]s_axilite_1_rresp;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axilite_1 RVALID" *) output s_axilite_1_rvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axilite_1 WDATA" *) input [31:0]s_axilite_1_wdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axilite_1 WREADY" *) output s_axilite_1_wready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axilite_1 WSTRB" *) input [3:0]s_axilite_1_wstrb;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axilite_1 WVALID" *) input s_axilite_1_wvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axilite_2 ARADDR" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME s_axilite_2, ADDR_WIDTH 20, ARUSER_WIDTH 0, AWUSER_WIDTH 0, BUSER_WIDTH 0, CLK_DOMAIN finn_design_ap_clk_0, DATA_WIDTH 32, FREQ_HZ 100000000, HAS_BRESP 1, HAS_BURST 0, HAS_CACHE 0, HAS_LOCK 0, HAS_PROT 1, HAS_QOS 0, HAS_REGION 0, HAS_RRESP 1, HAS_WSTRB 1, ID_WIDTH 0, INSERT_VIP 0, MAX_BURST_LENGTH 1, NUM_READ_OUTSTANDING 1, NUM_READ_THREADS 1, NUM_WRITE_OUTSTANDING 1, NUM_WRITE_THREADS 1, PHASE 0.0, PROTOCOL AXI4LITE, READ_WRITE_MODE READ_WRITE, RUSER_BITS_PER_BYTE 0, RUSER_WIDTH 0, SUPPORTS_NARROW_BURST 0, WUSER_BITS_PER_BYTE 0, WUSER_WIDTH 0" *) input [19:0]s_axilite_2_araddr;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axilite_2 ARPROT" *) input [2:0]s_axilite_2_arprot;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axilite_2 ARREADY" *) output s_axilite_2_arready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axilite_2 ARVALID" *) input s_axilite_2_arvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axilite_2 AWADDR" *) input [19:0]s_axilite_2_awaddr;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axilite_2 AWPROT" *) input [2:0]s_axilite_2_awprot;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axilite_2 AWREADY" *) output s_axilite_2_awready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axilite_2 AWVALID" *) input s_axilite_2_awvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axilite_2 BREADY" *) input s_axilite_2_bready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axilite_2 BRESP" *) output [1:0]s_axilite_2_bresp;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axilite_2 BVALID" *) output s_axilite_2_bvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axilite_2 RDATA" *) output [31:0]s_axilite_2_rdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axilite_2 RREADY" *) input s_axilite_2_rready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axilite_2 RRESP" *) output [1:0]s_axilite_2_rresp;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axilite_2 RVALID" *) output s_axilite_2_rvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axilite_2 WDATA" *) input [31:0]s_axilite_2_wdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axilite_2 WREADY" *) output s_axilite_2_wready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axilite_2 WSTRB" *) input [3:0]s_axilite_2_wstrb;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axilite_2 WVALID" *) input s_axilite_2_wvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axilite_3 ARADDR" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME s_axilite_3, ADDR_WIDTH 21, ARUSER_WIDTH 0, AWUSER_WIDTH 0, BUSER_WIDTH 0, CLK_DOMAIN finn_design_ap_clk_0, DATA_WIDTH 32, FREQ_HZ 100000000, HAS_BRESP 1, HAS_BURST 0, HAS_CACHE 0, HAS_LOCK 0, HAS_PROT 1, HAS_QOS 0, HAS_REGION 0, HAS_RRESP 1, HAS_WSTRB 1, ID_WIDTH 0, INSERT_VIP 0, MAX_BURST_LENGTH 1, NUM_READ_OUTSTANDING 1, NUM_READ_THREADS 1, NUM_WRITE_OUTSTANDING 1, NUM_WRITE_THREADS 1, PHASE 0.0, PROTOCOL AXI4LITE, READ_WRITE_MODE READ_WRITE, RUSER_BITS_PER_BYTE 0, RUSER_WIDTH 0, SUPPORTS_NARROW_BURST 0, WUSER_BITS_PER_BYTE 0, WUSER_WIDTH 0" *) input [20:0]s_axilite_3_araddr;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axilite_3 ARPROT" *) input [2:0]s_axilite_3_arprot;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axilite_3 ARREADY" *) output s_axilite_3_arready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axilite_3 ARVALID" *) input s_axilite_3_arvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axilite_3 AWADDR" *) input [20:0]s_axilite_3_awaddr;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axilite_3 AWPROT" *) input [2:0]s_axilite_3_awprot;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axilite_3 AWREADY" *) output s_axilite_3_awready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axilite_3 AWVALID" *) input s_axilite_3_awvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axilite_3 BREADY" *) input s_axilite_3_bready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axilite_3 BRESP" *) output [1:0]s_axilite_3_bresp;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axilite_3 BVALID" *) output s_axilite_3_bvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axilite_3 RDATA" *) output [31:0]s_axilite_3_rdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axilite_3 RREADY" *) input s_axilite_3_rready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axilite_3 RRESP" *) output [1:0]s_axilite_3_rresp;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axilite_3 RVALID" *) output s_axilite_3_rvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axilite_3 WDATA" *) input [31:0]s_axilite_3_wdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axilite_3 WREADY" *) output s_axilite_3_wready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axilite_3 WSTRB" *) input [3:0]s_axilite_3_wstrb;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axilite_3 WVALID" *) input s_axilite_3_wvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axilite_4 ARADDR" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME s_axilite_4, ADDR_WIDTH 17, ARUSER_WIDTH 0, AWUSER_WIDTH 0, BUSER_WIDTH 0, CLK_DOMAIN finn_design_ap_clk_0, DATA_WIDTH 32, FREQ_HZ 100000000, HAS_BRESP 1, HAS_BURST 0, HAS_CACHE 0, HAS_LOCK 0, HAS_PROT 1, HAS_QOS 0, HAS_REGION 0, HAS_RRESP 1, HAS_WSTRB 1, ID_WIDTH 0, INSERT_VIP 0, MAX_BURST_LENGTH 1, NUM_READ_OUTSTANDING 1, NUM_READ_THREADS 1, NUM_WRITE_OUTSTANDING 1, NUM_WRITE_THREADS 1, PHASE 0.0, PROTOCOL AXI4LITE, READ_WRITE_MODE READ_WRITE, RUSER_BITS_PER_BYTE 0, RUSER_WIDTH 0, SUPPORTS_NARROW_BURST 0, WUSER_BITS_PER_BYTE 0, WUSER_WIDTH 0" *) input [16:0]s_axilite_4_araddr;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axilite_4 ARPROT" *) input [2:0]s_axilite_4_arprot;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axilite_4 ARREADY" *) output s_axilite_4_arready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axilite_4 ARVALID" *) input s_axilite_4_arvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axilite_4 AWADDR" *) input [16:0]s_axilite_4_awaddr;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axilite_4 AWPROT" *) input [2:0]s_axilite_4_awprot;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axilite_4 AWREADY" *) output s_axilite_4_awready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axilite_4 AWVALID" *) input s_axilite_4_awvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axilite_4 BREADY" *) input s_axilite_4_bready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axilite_4 BRESP" *) output [1:0]s_axilite_4_bresp;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axilite_4 BVALID" *) output s_axilite_4_bvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axilite_4 RDATA" *) output [31:0]s_axilite_4_rdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axilite_4 RREADY" *) input s_axilite_4_rready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axilite_4 RRESP" *) output [1:0]s_axilite_4_rresp;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axilite_4 RVALID" *) output s_axilite_4_rvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axilite_4 WDATA" *) input [31:0]s_axilite_4_wdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axilite_4 WREADY" *) output s_axilite_4_wready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axilite_4 WSTRB" *) input [3:0]s_axilite_4_wstrb;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axilite_4 WVALID" *) input s_axilite_4_wvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_axis_0 " *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME s_axis_0, CLK_DOMAIN finn_design_ap_clk_0, FREQ_HZ 100000000, HAS_TKEEP 0, HAS_TLAST 0, HAS_TREADY 1, HAS_TSTRB 0, INSERT_VIP 0, LAYERED_METADATA undef, PHASE 0.0, TDATA_NUM_BYTES 1, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0" *) input [7:0]s_axis_0_tdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_axis_0 " *) output s_axis_0_tready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_axis_0 " *) input s_axis_0_tvalid;

  wire [7:0]MVAU_hls_0_out_V_TDATA;
  wire MVAU_hls_0_out_V_TREADY;
  wire MVAU_hls_0_out_V_TVALID;
  wire [7:0]MVAU_hls_1_out_V_TDATA;
  wire MVAU_hls_1_out_V_TREADY;
  wire MVAU_hls_1_out_V_TVALID;
  wire [7:0]MVAU_hls_2_out_V_TDATA;
  wire MVAU_hls_2_out_V_TREADY;
  wire MVAU_hls_2_out_V_TVALID;
  wire [7:0]MVAU_hls_3_out_V_TDATA;
  wire MVAU_hls_3_out_V_TREADY;
  wire MVAU_hls_3_out_V_TVALID;
  wire [39:0]MVAU_hls_4_out_V_TDATA;
  wire MVAU_hls_4_out_V_TREADY;
  wire MVAU_hls_4_out_V_TVALID;
  wire [7:0]StreamingFIFO_rtl_0_out_V_TDATA;
  wire StreamingFIFO_rtl_0_out_V_TREADY;
  wire StreamingFIFO_rtl_0_out_V_TVALID;
  wire [7:0]StreamingFIFO_rtl_1_out_V_TDATA;
  wire StreamingFIFO_rtl_1_out_V_TREADY;
  wire StreamingFIFO_rtl_1_out_V_TVALID;
  wire [7:0]StreamingFIFO_rtl_2_out_V_TDATA;
  wire StreamingFIFO_rtl_2_out_V_TREADY;
  wire StreamingFIFO_rtl_2_out_V_TVALID;
  wire [7:0]StreamingFIFO_rtl_3_out_V_TDATA;
  wire StreamingFIFO_rtl_3_out_V_TREADY;
  wire StreamingFIFO_rtl_3_out_V_TVALID;
  wire [7:0]StreamingFIFO_rtl_4_out_V_TDATA;
  wire StreamingFIFO_rtl_4_out_V_TREADY;
  wire StreamingFIFO_rtl_4_out_V_TVALID;
  wire [39:0]StreamingFIFO_rtl_5_out_V_TDATA;
  wire StreamingFIFO_rtl_5_out_V_TREADY;
  wire StreamingFIFO_rtl_5_out_V_TVALID;
  wire ap_clk_0_1;
  wire ap_rst_n_0_1;
  wire [7:0]in0_V_0_1_TDATA;
  wire in0_V_0_1_TREADY;
  wire in0_V_0_1_TVALID;
  wire [11:0]s_axilite_0_1_ARADDR;
  wire [2:0]s_axilite_0_1_ARPROT;
  wire s_axilite_0_1_ARREADY;
  wire s_axilite_0_1_ARVALID;
  wire [11:0]s_axilite_0_1_AWADDR;
  wire [2:0]s_axilite_0_1_AWPROT;
  wire s_axilite_0_1_AWREADY;
  wire s_axilite_0_1_AWVALID;
  wire s_axilite_0_1_BREADY;
  wire [1:0]s_axilite_0_1_BRESP;
  wire s_axilite_0_1_BVALID;
  wire [31:0]s_axilite_0_1_RDATA;
  wire s_axilite_0_1_RREADY;
  wire [1:0]s_axilite_0_1_RRESP;
  wire s_axilite_0_1_RVALID;
  wire [31:0]s_axilite_0_1_WDATA;
  wire s_axilite_0_1_WREADY;
  wire [3:0]s_axilite_0_1_WSTRB;
  wire s_axilite_0_1_WVALID;
  wire [18:0]s_axilite_1_1_ARADDR;
  wire [2:0]s_axilite_1_1_ARPROT;
  wire s_axilite_1_1_ARREADY;
  wire s_axilite_1_1_ARVALID;
  wire [18:0]s_axilite_1_1_AWADDR;
  wire [2:0]s_axilite_1_1_AWPROT;
  wire s_axilite_1_1_AWREADY;
  wire s_axilite_1_1_AWVALID;
  wire s_axilite_1_1_BREADY;
  wire [1:0]s_axilite_1_1_BRESP;
  wire s_axilite_1_1_BVALID;
  wire [31:0]s_axilite_1_1_RDATA;
  wire s_axilite_1_1_RREADY;
  wire [1:0]s_axilite_1_1_RRESP;
  wire s_axilite_1_1_RVALID;
  wire [31:0]s_axilite_1_1_WDATA;
  wire s_axilite_1_1_WREADY;
  wire [3:0]s_axilite_1_1_WSTRB;
  wire s_axilite_1_1_WVALID;
  wire [19:0]s_axilite_2_1_ARADDR;
  wire [2:0]s_axilite_2_1_ARPROT;
  wire s_axilite_2_1_ARREADY;
  wire s_axilite_2_1_ARVALID;
  wire [19:0]s_axilite_2_1_AWADDR;
  wire [2:0]s_axilite_2_1_AWPROT;
  wire s_axilite_2_1_AWREADY;
  wire s_axilite_2_1_AWVALID;
  wire s_axilite_2_1_BREADY;
  wire [1:0]s_axilite_2_1_BRESP;
  wire s_axilite_2_1_BVALID;
  wire [31:0]s_axilite_2_1_RDATA;
  wire s_axilite_2_1_RREADY;
  wire [1:0]s_axilite_2_1_RRESP;
  wire s_axilite_2_1_RVALID;
  wire [31:0]s_axilite_2_1_WDATA;
  wire s_axilite_2_1_WREADY;
  wire [3:0]s_axilite_2_1_WSTRB;
  wire s_axilite_2_1_WVALID;
  wire [20:0]s_axilite_3_1_ARADDR;
  wire [2:0]s_axilite_3_1_ARPROT;
  wire s_axilite_3_1_ARREADY;
  wire s_axilite_3_1_ARVALID;
  wire [20:0]s_axilite_3_1_AWADDR;
  wire [2:0]s_axilite_3_1_AWPROT;
  wire s_axilite_3_1_AWREADY;
  wire s_axilite_3_1_AWVALID;
  wire s_axilite_3_1_BREADY;
  wire [1:0]s_axilite_3_1_BRESP;
  wire s_axilite_3_1_BVALID;
  wire [31:0]s_axilite_3_1_RDATA;
  wire s_axilite_3_1_RREADY;
  wire [1:0]s_axilite_3_1_RRESP;
  wire s_axilite_3_1_RVALID;
  wire [31:0]s_axilite_3_1_WDATA;
  wire s_axilite_3_1_WREADY;
  wire [3:0]s_axilite_3_1_WSTRB;
  wire s_axilite_3_1_WVALID;
  wire [16:0]s_axilite_4_1_ARADDR;
  wire [2:0]s_axilite_4_1_ARPROT;
  wire s_axilite_4_1_ARREADY;
  wire s_axilite_4_1_ARVALID;
  wire [16:0]s_axilite_4_1_AWADDR;
  wire [2:0]s_axilite_4_1_AWPROT;
  wire s_axilite_4_1_AWREADY;
  wire s_axilite_4_1_AWVALID;
  wire s_axilite_4_1_BREADY;
  wire [1:0]s_axilite_4_1_BRESP;
  wire s_axilite_4_1_BVALID;
  wire [31:0]s_axilite_4_1_RDATA;
  wire s_axilite_4_1_RREADY;
  wire [1:0]s_axilite_4_1_RRESP;
  wire s_axilite_4_1_RVALID;
  wire [31:0]s_axilite_4_1_WDATA;
  wire s_axilite_4_1_WREADY;
  wire [3:0]s_axilite_4_1_WSTRB;
  wire s_axilite_4_1_WVALID;

  assign StreamingFIFO_rtl_5_out_V_TREADY = m_axis_0_tready;
  assign ap_clk_0_1 = ap_clk;
  assign ap_rst_n_0_1 = ap_rst_n;
  assign in0_V_0_1_TDATA = s_axis_0_tdata[7:0];
  assign in0_V_0_1_TVALID = s_axis_0_tvalid;
  assign m_axis_0_tdata[39:0] = StreamingFIFO_rtl_5_out_V_TDATA;
  assign m_axis_0_tvalid = StreamingFIFO_rtl_5_out_V_TVALID;
  assign s_axilite_0_1_ARADDR = s_axilite_0_araddr[11:0];
  assign s_axilite_0_1_ARPROT = s_axilite_0_arprot[2:0];
  assign s_axilite_0_1_ARVALID = s_axilite_0_arvalid;
  assign s_axilite_0_1_AWADDR = s_axilite_0_awaddr[11:0];
  assign s_axilite_0_1_AWPROT = s_axilite_0_awprot[2:0];
  assign s_axilite_0_1_AWVALID = s_axilite_0_awvalid;
  assign s_axilite_0_1_BREADY = s_axilite_0_bready;
  assign s_axilite_0_1_RREADY = s_axilite_0_rready;
  assign s_axilite_0_1_WDATA = s_axilite_0_wdata[31:0];
  assign s_axilite_0_1_WSTRB = s_axilite_0_wstrb[3:0];
  assign s_axilite_0_1_WVALID = s_axilite_0_wvalid;
  assign s_axilite_0_arready = s_axilite_0_1_ARREADY;
  assign s_axilite_0_awready = s_axilite_0_1_AWREADY;
  assign s_axilite_0_bresp[1:0] = s_axilite_0_1_BRESP;
  assign s_axilite_0_bvalid = s_axilite_0_1_BVALID;
  assign s_axilite_0_rdata[31:0] = s_axilite_0_1_RDATA;
  assign s_axilite_0_rresp[1:0] = s_axilite_0_1_RRESP;
  assign s_axilite_0_rvalid = s_axilite_0_1_RVALID;
  assign s_axilite_0_wready = s_axilite_0_1_WREADY;
  assign s_axilite_1_1_ARADDR = s_axilite_1_araddr[18:0];
  assign s_axilite_1_1_ARPROT = s_axilite_1_arprot[2:0];
  assign s_axilite_1_1_ARVALID = s_axilite_1_arvalid;
  assign s_axilite_1_1_AWADDR = s_axilite_1_awaddr[18:0];
  assign s_axilite_1_1_AWPROT = s_axilite_1_awprot[2:0];
  assign s_axilite_1_1_AWVALID = s_axilite_1_awvalid;
  assign s_axilite_1_1_BREADY = s_axilite_1_bready;
  assign s_axilite_1_1_RREADY = s_axilite_1_rready;
  assign s_axilite_1_1_WDATA = s_axilite_1_wdata[31:0];
  assign s_axilite_1_1_WSTRB = s_axilite_1_wstrb[3:0];
  assign s_axilite_1_1_WVALID = s_axilite_1_wvalid;
  assign s_axilite_1_arready = s_axilite_1_1_ARREADY;
  assign s_axilite_1_awready = s_axilite_1_1_AWREADY;
  assign s_axilite_1_bresp[1:0] = s_axilite_1_1_BRESP;
  assign s_axilite_1_bvalid = s_axilite_1_1_BVALID;
  assign s_axilite_1_rdata[31:0] = s_axilite_1_1_RDATA;
  assign s_axilite_1_rresp[1:0] = s_axilite_1_1_RRESP;
  assign s_axilite_1_rvalid = s_axilite_1_1_RVALID;
  assign s_axilite_1_wready = s_axilite_1_1_WREADY;
  assign s_axilite_2_1_ARADDR = s_axilite_2_araddr[19:0];
  assign s_axilite_2_1_ARPROT = s_axilite_2_arprot[2:0];
  assign s_axilite_2_1_ARVALID = s_axilite_2_arvalid;
  assign s_axilite_2_1_AWADDR = s_axilite_2_awaddr[19:0];
  assign s_axilite_2_1_AWPROT = s_axilite_2_awprot[2:0];
  assign s_axilite_2_1_AWVALID = s_axilite_2_awvalid;
  assign s_axilite_2_1_BREADY = s_axilite_2_bready;
  assign s_axilite_2_1_RREADY = s_axilite_2_rready;
  assign s_axilite_2_1_WDATA = s_axilite_2_wdata[31:0];
  assign s_axilite_2_1_WSTRB = s_axilite_2_wstrb[3:0];
  assign s_axilite_2_1_WVALID = s_axilite_2_wvalid;
  assign s_axilite_2_arready = s_axilite_2_1_ARREADY;
  assign s_axilite_2_awready = s_axilite_2_1_AWREADY;
  assign s_axilite_2_bresp[1:0] = s_axilite_2_1_BRESP;
  assign s_axilite_2_bvalid = s_axilite_2_1_BVALID;
  assign s_axilite_2_rdata[31:0] = s_axilite_2_1_RDATA;
  assign s_axilite_2_rresp[1:0] = s_axilite_2_1_RRESP;
  assign s_axilite_2_rvalid = s_axilite_2_1_RVALID;
  assign s_axilite_2_wready = s_axilite_2_1_WREADY;
  assign s_axilite_3_1_ARADDR = s_axilite_3_araddr[20:0];
  assign s_axilite_3_1_ARPROT = s_axilite_3_arprot[2:0];
  assign s_axilite_3_1_ARVALID = s_axilite_3_arvalid;
  assign s_axilite_3_1_AWADDR = s_axilite_3_awaddr[20:0];
  assign s_axilite_3_1_AWPROT = s_axilite_3_awprot[2:0];
  assign s_axilite_3_1_AWVALID = s_axilite_3_awvalid;
  assign s_axilite_3_1_BREADY = s_axilite_3_bready;
  assign s_axilite_3_1_RREADY = s_axilite_3_rready;
  assign s_axilite_3_1_WDATA = s_axilite_3_wdata[31:0];
  assign s_axilite_3_1_WSTRB = s_axilite_3_wstrb[3:0];
  assign s_axilite_3_1_WVALID = s_axilite_3_wvalid;
  assign s_axilite_3_arready = s_axilite_3_1_ARREADY;
  assign s_axilite_3_awready = s_axilite_3_1_AWREADY;
  assign s_axilite_3_bresp[1:0] = s_axilite_3_1_BRESP;
  assign s_axilite_3_bvalid = s_axilite_3_1_BVALID;
  assign s_axilite_3_rdata[31:0] = s_axilite_3_1_RDATA;
  assign s_axilite_3_rresp[1:0] = s_axilite_3_1_RRESP;
  assign s_axilite_3_rvalid = s_axilite_3_1_RVALID;
  assign s_axilite_3_wready = s_axilite_3_1_WREADY;
  assign s_axilite_4_1_ARADDR = s_axilite_4_araddr[16:0];
  assign s_axilite_4_1_ARPROT = s_axilite_4_arprot[2:0];
  assign s_axilite_4_1_ARVALID = s_axilite_4_arvalid;
  assign s_axilite_4_1_AWADDR = s_axilite_4_awaddr[16:0];
  assign s_axilite_4_1_AWPROT = s_axilite_4_awprot[2:0];
  assign s_axilite_4_1_AWVALID = s_axilite_4_awvalid;
  assign s_axilite_4_1_BREADY = s_axilite_4_bready;
  assign s_axilite_4_1_RREADY = s_axilite_4_rready;
  assign s_axilite_4_1_WDATA = s_axilite_4_wdata[31:0];
  assign s_axilite_4_1_WSTRB = s_axilite_4_wstrb[3:0];
  assign s_axilite_4_1_WVALID = s_axilite_4_wvalid;
  assign s_axilite_4_arready = s_axilite_4_1_ARREADY;
  assign s_axilite_4_awready = s_axilite_4_1_AWREADY;
  assign s_axilite_4_bresp[1:0] = s_axilite_4_1_BRESP;
  assign s_axilite_4_bvalid = s_axilite_4_1_BVALID;
  assign s_axilite_4_rdata[31:0] = s_axilite_4_1_RDATA;
  assign s_axilite_4_rresp[1:0] = s_axilite_4_1_RRESP;
  assign s_axilite_4_rvalid = s_axilite_4_1_RVALID;
  assign s_axilite_4_wready = s_axilite_4_1_WREADY;
  assign s_axis_0_tready = in0_V_0_1_TREADY;
  MVAU_hls_0_imp_7OH4JA MVAU_hls_0
       (.ap_clk(ap_clk_0_1),
        .ap_rst_n(ap_rst_n_0_1),
        .in0_V_tdata(StreamingFIFO_rtl_0_out_V_TDATA),
        .in0_V_tready(StreamingFIFO_rtl_0_out_V_TREADY),
        .in0_V_tvalid(StreamingFIFO_rtl_0_out_V_TVALID),
        .out_V_tdata(MVAU_hls_0_out_V_TDATA),
        .out_V_tready(MVAU_hls_0_out_V_TREADY),
        .out_V_tvalid(MVAU_hls_0_out_V_TVALID),
        .s_axilite_araddr(s_axilite_0_1_ARADDR),
        .s_axilite_arprot(s_axilite_0_1_ARPROT),
        .s_axilite_arready(s_axilite_0_1_ARREADY),
        .s_axilite_arvalid(s_axilite_0_1_ARVALID),
        .s_axilite_awaddr(s_axilite_0_1_AWADDR),
        .s_axilite_awprot(s_axilite_0_1_AWPROT),
        .s_axilite_awready(s_axilite_0_1_AWREADY),
        .s_axilite_awvalid(s_axilite_0_1_AWVALID),
        .s_axilite_bready(s_axilite_0_1_BREADY),
        .s_axilite_bresp(s_axilite_0_1_BRESP),
        .s_axilite_bvalid(s_axilite_0_1_BVALID),
        .s_axilite_rdata(s_axilite_0_1_RDATA),
        .s_axilite_rready(s_axilite_0_1_RREADY),
        .s_axilite_rresp(s_axilite_0_1_RRESP),
        .s_axilite_rvalid(s_axilite_0_1_RVALID),
        .s_axilite_wdata(s_axilite_0_1_WDATA),
        .s_axilite_wready(s_axilite_0_1_WREADY),
        .s_axilite_wstrb(s_axilite_0_1_WSTRB),
        .s_axilite_wvalid(s_axilite_0_1_WVALID));
  MVAU_hls_1_imp_ZIW0NT MVAU_hls_1
       (.ap_clk(ap_clk_0_1),
        .ap_rst_n(ap_rst_n_0_1),
        .in0_V_tdata(StreamingFIFO_rtl_1_out_V_TDATA),
        .in0_V_tready(StreamingFIFO_rtl_1_out_V_TREADY),
        .in0_V_tvalid(StreamingFIFO_rtl_1_out_V_TVALID),
        .out_V_tdata(MVAU_hls_1_out_V_TDATA),
        .out_V_tready(MVAU_hls_1_out_V_TREADY),
        .out_V_tvalid(MVAU_hls_1_out_V_TVALID),
        .s_axilite_araddr(s_axilite_1_1_ARADDR),
        .s_axilite_arprot(s_axilite_1_1_ARPROT),
        .s_axilite_arready(s_axilite_1_1_ARREADY),
        .s_axilite_arvalid(s_axilite_1_1_ARVALID),
        .s_axilite_awaddr(s_axilite_1_1_AWADDR),
        .s_axilite_awprot(s_axilite_1_1_AWPROT),
        .s_axilite_awready(s_axilite_1_1_AWREADY),
        .s_axilite_awvalid(s_axilite_1_1_AWVALID),
        .s_axilite_bready(s_axilite_1_1_BREADY),
        .s_axilite_bresp(s_axilite_1_1_BRESP),
        .s_axilite_bvalid(s_axilite_1_1_BVALID),
        .s_axilite_rdata(s_axilite_1_1_RDATA),
        .s_axilite_rready(s_axilite_1_1_RREADY),
        .s_axilite_rresp(s_axilite_1_1_RRESP),
        .s_axilite_rvalid(s_axilite_1_1_RVALID),
        .s_axilite_wdata(s_axilite_1_1_WDATA),
        .s_axilite_wready(s_axilite_1_1_WREADY),
        .s_axilite_wstrb(s_axilite_1_1_WSTRB),
        .s_axilite_wvalid(s_axilite_1_1_WVALID));
  MVAU_hls_2_imp_1WP2WTL MVAU_hls_2
       (.ap_clk(ap_clk_0_1),
        .ap_rst_n(ap_rst_n_0_1),
        .in0_V_tdata(StreamingFIFO_rtl_2_out_V_TDATA),
        .in0_V_tready(StreamingFIFO_rtl_2_out_V_TREADY),
        .in0_V_tvalid(StreamingFIFO_rtl_2_out_V_TVALID),
        .out_V_tdata(MVAU_hls_2_out_V_TDATA),
        .out_V_tready(MVAU_hls_2_out_V_TREADY),
        .out_V_tvalid(MVAU_hls_2_out_V_TVALID),
        .s_axilite_araddr(s_axilite_2_1_ARADDR),
        .s_axilite_arprot(s_axilite_2_1_ARPROT),
        .s_axilite_arready(s_axilite_2_1_ARREADY),
        .s_axilite_arvalid(s_axilite_2_1_ARVALID),
        .s_axilite_awaddr(s_axilite_2_1_AWADDR),
        .s_axilite_awprot(s_axilite_2_1_AWPROT),
        .s_axilite_awready(s_axilite_2_1_AWREADY),
        .s_axilite_awvalid(s_axilite_2_1_AWVALID),
        .s_axilite_bready(s_axilite_2_1_BREADY),
        .s_axilite_bresp(s_axilite_2_1_BRESP),
        .s_axilite_bvalid(s_axilite_2_1_BVALID),
        .s_axilite_rdata(s_axilite_2_1_RDATA),
        .s_axilite_rready(s_axilite_2_1_RREADY),
        .s_axilite_rresp(s_axilite_2_1_RRESP),
        .s_axilite_rvalid(s_axilite_2_1_RVALID),
        .s_axilite_wdata(s_axilite_2_1_WDATA),
        .s_axilite_wready(s_axilite_2_1_WREADY),
        .s_axilite_wstrb(s_axilite_2_1_WSTRB),
        .s_axilite_wvalid(s_axilite_2_1_WVALID));
  MVAU_hls_3_imp_U0RWZQ MVAU_hls_3
       (.ap_clk(ap_clk_0_1),
        .ap_rst_n(ap_rst_n_0_1),
        .in0_V_tdata(StreamingFIFO_rtl_3_out_V_TDATA),
        .in0_V_tready(StreamingFIFO_rtl_3_out_V_TREADY),
        .in0_V_tvalid(StreamingFIFO_rtl_3_out_V_TVALID),
        .out_V_tdata(MVAU_hls_3_out_V_TDATA),
        .out_V_tready(MVAU_hls_3_out_V_TREADY),
        .out_V_tvalid(MVAU_hls_3_out_V_TVALID),
        .s_axilite_araddr(s_axilite_3_1_ARADDR),
        .s_axilite_arprot(s_axilite_3_1_ARPROT),
        .s_axilite_arready(s_axilite_3_1_ARREADY),
        .s_axilite_arvalid(s_axilite_3_1_ARVALID),
        .s_axilite_awaddr(s_axilite_3_1_AWADDR),
        .s_axilite_awprot(s_axilite_3_1_AWPROT),
        .s_axilite_awready(s_axilite_3_1_AWREADY),
        .s_axilite_awvalid(s_axilite_3_1_AWVALID),
        .s_axilite_bready(s_axilite_3_1_BREADY),
        .s_axilite_bresp(s_axilite_3_1_BRESP),
        .s_axilite_bvalid(s_axilite_3_1_BVALID),
        .s_axilite_rdata(s_axilite_3_1_RDATA),
        .s_axilite_rready(s_axilite_3_1_RREADY),
        .s_axilite_rresp(s_axilite_3_1_RRESP),
        .s_axilite_rvalid(s_axilite_3_1_RVALID),
        .s_axilite_wdata(s_axilite_3_1_WDATA),
        .s_axilite_wready(s_axilite_3_1_WREADY),
        .s_axilite_wstrb(s_axilite_3_1_WSTRB),
        .s_axilite_wvalid(s_axilite_3_1_WVALID));
  MVAU_hls_4_imp_6UFUIX MVAU_hls_4
       (.ap_clk(ap_clk_0_1),
        .ap_rst_n(ap_rst_n_0_1),
        .in0_V_tdata(StreamingFIFO_rtl_4_out_V_TDATA),
        .in0_V_tready(StreamingFIFO_rtl_4_out_V_TREADY),
        .in0_V_tvalid(StreamingFIFO_rtl_4_out_V_TVALID),
        .out_V_tdata(MVAU_hls_4_out_V_TDATA),
        .out_V_tready(MVAU_hls_4_out_V_TREADY),
        .out_V_tvalid(MVAU_hls_4_out_V_TVALID),
        .s_axilite_araddr(s_axilite_4_1_ARADDR),
        .s_axilite_arprot(s_axilite_4_1_ARPROT),
        .s_axilite_arready(s_axilite_4_1_ARREADY),
        .s_axilite_arvalid(s_axilite_4_1_ARVALID),
        .s_axilite_awaddr(s_axilite_4_1_AWADDR),
        .s_axilite_awprot(s_axilite_4_1_AWPROT),
        .s_axilite_awready(s_axilite_4_1_AWREADY),
        .s_axilite_awvalid(s_axilite_4_1_AWVALID),
        .s_axilite_bready(s_axilite_4_1_BREADY),
        .s_axilite_bresp(s_axilite_4_1_BRESP),
        .s_axilite_bvalid(s_axilite_4_1_BVALID),
        .s_axilite_rdata(s_axilite_4_1_RDATA),
        .s_axilite_rready(s_axilite_4_1_RREADY),
        .s_axilite_rresp(s_axilite_4_1_RRESP),
        .s_axilite_rvalid(s_axilite_4_1_RVALID),
        .s_axilite_wdata(s_axilite_4_1_WDATA),
        .s_axilite_wready(s_axilite_4_1_WREADY),
        .s_axilite_wstrb(s_axilite_4_1_WSTRB),
        .s_axilite_wvalid(s_axilite_4_1_WVALID));
  finn_design_StreamingFIFO_rtl_0_0 StreamingFIFO_rtl_0
       (.ap_clk(ap_clk_0_1),
        .ap_rst_n(ap_rst_n_0_1),
        .in0_V_TDATA(in0_V_0_1_TDATA),
        .in0_V_TREADY(in0_V_0_1_TREADY),
        .in0_V_TVALID(in0_V_0_1_TVALID),
        .out_V_TDATA(StreamingFIFO_rtl_0_out_V_TDATA),
        .out_V_TREADY(StreamingFIFO_rtl_0_out_V_TREADY),
        .out_V_TVALID(StreamingFIFO_rtl_0_out_V_TVALID));
  finn_design_StreamingFIFO_rtl_1_0 StreamingFIFO_rtl_1
       (.ap_clk(ap_clk_0_1),
        .ap_rst_n(ap_rst_n_0_1),
        .in0_V_TDATA(MVAU_hls_0_out_V_TDATA),
        .in0_V_TREADY(MVAU_hls_0_out_V_TREADY),
        .in0_V_TVALID(MVAU_hls_0_out_V_TVALID),
        .out_V_TDATA(StreamingFIFO_rtl_1_out_V_TDATA),
        .out_V_TREADY(StreamingFIFO_rtl_1_out_V_TREADY),
        .out_V_TVALID(StreamingFIFO_rtl_1_out_V_TVALID));
  StreamingFIFO_rtl_2_imp_1FWKJ6V StreamingFIFO_rtl_2
       (.ap_clk(ap_clk_0_1),
        .ap_rst_n(ap_rst_n_0_1),
        .in0_V_tdata(MVAU_hls_1_out_V_TDATA),
        .in0_V_tready(MVAU_hls_1_out_V_TREADY),
        .in0_V_tvalid(MVAU_hls_1_out_V_TVALID),
        .out_V_tdata(StreamingFIFO_rtl_2_out_V_TDATA),
        .out_V_tready(StreamingFIFO_rtl_2_out_V_TREADY),
        .out_V_tvalid(StreamingFIFO_rtl_2_out_V_TVALID));
  StreamingFIFO_rtl_3_imp_92O214 StreamingFIFO_rtl_3
       (.ap_clk(ap_clk_0_1),
        .ap_rst_n(ap_rst_n_0_1),
        .in0_V_tdata(MVAU_hls_2_out_V_TDATA),
        .in0_V_tready(MVAU_hls_2_out_V_TREADY),
        .in0_V_tvalid(MVAU_hls_2_out_V_TVALID),
        .out_V_tdata(StreamingFIFO_rtl_3_out_V_TDATA),
        .out_V_tready(StreamingFIFO_rtl_3_out_V_TREADY),
        .out_V_tvalid(StreamingFIFO_rtl_3_out_V_TVALID));
  finn_design_StreamingFIFO_rtl_4_0 StreamingFIFO_rtl_4
       (.ap_clk(ap_clk_0_1),
        .ap_rst_n(ap_rst_n_0_1),
        .in0_V_TDATA(MVAU_hls_3_out_V_TDATA),
        .in0_V_TREADY(MVAU_hls_3_out_V_TREADY),
        .in0_V_TVALID(MVAU_hls_3_out_V_TVALID),
        .out_V_TDATA(StreamingFIFO_rtl_4_out_V_TDATA),
        .out_V_TREADY(StreamingFIFO_rtl_4_out_V_TREADY),
        .out_V_TVALID(StreamingFIFO_rtl_4_out_V_TVALID));
  finn_design_StreamingFIFO_rtl_5_0 StreamingFIFO_rtl_5
       (.ap_clk(ap_clk_0_1),
        .ap_rst_n(ap_rst_n_0_1),
        .in0_V_TDATA(MVAU_hls_4_out_V_TDATA),
        .in0_V_TREADY(MVAU_hls_4_out_V_TREADY),
        .in0_V_TVALID(MVAU_hls_4_out_V_TVALID),
        .out_V_TDATA(StreamingFIFO_rtl_5_out_V_TDATA),
        .out_V_TREADY(StreamingFIFO_rtl_5_out_V_TREADY),
        .out_V_TVALID(StreamingFIFO_rtl_5_out_V_TVALID));
endmodule
