/******************************************************************************
 * (C) Copyright 2022 AMIQ All Rights Reserved
 *
 * MODULE:    amiq_dvcon_tb_tc_pkg
 * DEVICE:
 * PROJECT:
 * AUTHOR:    andvin
 * DATE:      2022 5:33:58 PM
 *
 * ABSTRACT:  You can customize the file content from Window -> Preferences -> DVT -> Code Templates -> "verilog File"
 *
 *******************************************************************************/

/******************************************************************************
 * DVT CODE TEMPLATE: testbench top module
 * Created by andvin on Jul 8, 2022
 * uvc_company = uvc_company, uvc_name = uvc_name
 *******************************************************************************/

package amiq_dvcon_tb_tc_pkg;

    import uvm_pkg::*;
    `include "uvm_macros.svh"

    import amiq_ectb_pkg::*;
    import amiq_dvcon_tb_env_pkg::*;
    import amiq_dvcon_tb_seq_pkg::*;

    `include "amiq_dvcon_tb_tc.svh"

endpackage