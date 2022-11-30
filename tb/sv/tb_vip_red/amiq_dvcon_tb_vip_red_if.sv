/******************************************************************************
 * (C) Copyright 2022 AMIQ All Rights Reserved
 *
 * MODULE:    amiq_dvcon_tb_vip_if
 * DEVICE:
 * PROJECT:
 * AUTHOR:    andvin
 * DATE:      2022 8:35:14 PM
 *
 * ABSTRACT:  You can customize the file content from Window -> Preferences -> DVT -> Code Templates -> "verilog File"
 *
 *******************************************************************************/

interface amiq_dvcon_tb_vip_red_if;
    
    logic clk;
    logic rst;
    
    logic[31:0] field0;
    logic[31:0] field1;
    logic[31:0] field2;
    logic valid;
    
endinterface