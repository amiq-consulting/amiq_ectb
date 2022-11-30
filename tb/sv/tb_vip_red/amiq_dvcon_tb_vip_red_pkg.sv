/******************************************************************************
 * (C) Copyright 2022 AMIQ All Rights Reserved
 *
 * MODULE:    amiq_dvcon_tb_vip_pkg
 * DEVICE:
 * PROJECT:
 * AUTHOR:    andvin
 * DATE:      2022 8:15:19 PM
 *
 * ABSTRACT:  You can customize the file content from Window -> Preferences -> DVT -> Code Templates -> "verilog File"
 *
 *******************************************************************************/

package amiq_dvcon_tb_vip_red_pkg;
    
    import uvm_pkg::*;
    `include "uvm_macros.svh"

//    import amiq_dvcon_pkg::*;
    
    
    `include "amiq_dvcon_tb_vip_red_cfg_obj.svh"
    `include "amiq_dvcon_tb_vip_red_item.svh"
    `include "amiq_dvcon_tb_vip_red_monitor.svh"
    `include "amiq_dvcon_tb_vip_red_driver.svh"
    `include "amiq_dvcon_tb_vip_red_agent.svh"
    
endpackage