/******************************************************************************
 * (C) Copyright 2022 AMIQ All Rights Reserved
 *
 * MODULE:    amiq_dvcon_tb_env_pkg
 * DEVICE:
 * PROJECT:
 * AUTHOR:    andvin
 * DATE:      2022 5:45:33 PM
 *
 * ABSTRACT:  You can customize the file content from Window -> Preferences -> DVT -> Code Templates -> "verilog File"
 *
 *******************************************************************************/

package amiq_dvcon_tb_env_pkg;
    
    import uvm_pkg::*;
    `include "uvm_macros.svh"

    import amiq_ectb_pkg::*;
    import amiq_dvcon_tb_vip_red_pkg::*;
    import amiq_dvcon_tb_vip_blue_pkg::*;
    import amiq_dvcon_tb_vip_purple_pkg::*;
    
    `include "amiq_dvcon_tb_env_cfg.svh"
    `include "amiq_dvcon_tb_sqr.svh"
    `include "amiq_dvcon_tb_coverage_collector.svh"
    `include "amiq_dvcon_tb_env.svh"
endpackage
