/******************************************************************************
 * (C) Copyright 2022 AMIQ All Rights Reserved
 *
 * MODULE:    amiq_dvcon_tb_env_cfg
 * DEVICE:
 * PROJECT:
 * AUTHOR:    andvin
 * DATE:      2022 8:17:12 PM
 *
 * ABSTRACT:  You can customize the file content from Window -> Preferences -> DVT -> Code Templates -> "verilog File"
 *
 *******************************************************************************/

`ifndef __amiq_dvcon_tb_env_cfg
`define __amiq_dvcon_tb_env_cfg

//------------------------------------------------------------------------------
//
// CLASS: uvc_company_uvc_name_object
//
//------------------------------------------------------------------------------

class amiq_dvcon_tb_env_cfg extends amiq_ectb_object;

    // Note: We created it with the maximum number of agents we can use.
    // This can be made dynamic as well, but you'll need to know the number 
    // of agents during register_all_vars() call (additional variable interrogated)
    // Minimizing the number of variables results in too small of a gain

    // Active/passive for all vips
    uvm_active_passive_enum red_vip_is_active[5];
    uvm_active_passive_enum blue_vip_is_active[5];
    uvm_active_passive_enum purple_vip_is_active[5];

    // Enable/disable checks for all vips
    bit red_vip_has_checks[5];
    bit red_vip_has_coverage[5];
    bit blue_vip_has_checks[5];
    bit blue_vip_has_coverage[5];
    bit purple_vip_has_checks[5];
    bit purple_vip_has_coverage[5];

    `uvm_object_utils(amiq_dvcon_tb_env_cfg)

    function new (string name = "amiq_dvcon_tb_env_cfg");
        super.new(name);
    endfunction : new

    virtual function void register_all_vars();
        
        // Active/Passive
        red_vip_is_active[0] = uvm_active_passive_enum'(bit_reg("red_vip0_is_active", UVM_ACTIVE));
        red_vip_is_active[1] = uvm_active_passive_enum'(bit_reg("red_vip1_is_active", UVM_ACTIVE));
        red_vip_is_active[2] = uvm_active_passive_enum'(bit_reg("red_vip2_is_active", UVM_ACTIVE));
        red_vip_is_active[3] = uvm_active_passive_enum'(bit_reg("red_vip3_is_active", UVM_ACTIVE));
        red_vip_is_active[4] = uvm_active_passive_enum'(bit_reg("red_vip4_is_active", UVM_ACTIVE));
        red_vip_is_active[5] = uvm_active_passive_enum'(bit_reg("red_vip5_is_active", UVM_ACTIVE));
        
        blue_vip_is_active[0] = uvm_active_passive_enum'(bit_reg("blue_vip0_is_active", UVM_ACTIVE));
        blue_vip_is_active[1] = uvm_active_passive_enum'(bit_reg("blue_vip1_is_active", UVM_ACTIVE));
        blue_vip_is_active[2] = uvm_active_passive_enum'(bit_reg("blue_vip2_is_active", UVM_ACTIVE));
        blue_vip_is_active[3] = uvm_active_passive_enum'(bit_reg("blue_vip3_is_active", UVM_ACTIVE));
        blue_vip_is_active[4] = uvm_active_passive_enum'(bit_reg("blue_vip4_is_active", UVM_ACTIVE));
        blue_vip_is_active[5] = uvm_active_passive_enum'(bit_reg("blue_vip5_is_active", UVM_ACTIVE));
        
        purple_vip_is_active[0] = uvm_active_passive_enum'(bit_reg("purple_vip0_is_active", UVM_ACTIVE));
        purple_vip_is_active[1] = uvm_active_passive_enum'(bit_reg("purple_vip1_is_active", UVM_ACTIVE));
        purple_vip_is_active[2] = uvm_active_passive_enum'(bit_reg("purple_vip2_is_active", UVM_ACTIVE));
        purple_vip_is_active[3] = uvm_active_passive_enum'(bit_reg("purple_vip3_is_active", UVM_ACTIVE));
        purple_vip_is_active[4] = uvm_active_passive_enum'(bit_reg("purple_vip4_is_active", UVM_ACTIVE));
        purple_vip_is_active[5] = uvm_active_passive_enum'(bit_reg("purple_vip5_is_active", UVM_ACTIVE));


        // Has checks/coverage
        red_vip_has_checks[0]   = bit_reg("red_vip0_has_checks", 1);
        red_vip_has_coverage[0] = bit_reg("red_vip0_has_coverage", 1);
        red_vip_has_checks[1]   = bit_reg("red_vip1_has_checks", 1);
        red_vip_has_coverage[1] = bit_reg("red_vip1_has_coverage", 1);
        red_vip_has_checks[2]   = bit_reg("red_vip2_has_checks", 1);
        red_vip_has_coverage[2] = bit_reg("red_vip2_has_coverage", 1);
        red_vip_has_checks[3]   = bit_reg("red_vip3_has_checks", 1);
        red_vip_has_coverage[3] = bit_reg("red_vip3_has_coverage", 1);
        red_vip_has_checks[4]   = bit_reg("red_vip4_has_checks", 1);
        red_vip_has_coverage[4] = bit_reg("red_vip4_has_coverage", 1);
        red_vip_has_checks[5]   = bit_reg("red_vip5_has_checks", 1);
        red_vip_has_coverage[5] = bit_reg("red_vip5_has_coverage", 1);
        
        blue_vip_has_checks[0]   = bit_reg("blue_vip0_has_checks", 1);
        blue_vip_has_coverage[0] = bit_reg("blue_vip0_has_coverage", 1);
        blue_vip_has_checks[1]   = bit_reg("blue_vip1_has_checks", 1);
        blue_vip_has_coverage[1] = bit_reg("blue_vip1_has_coverage", 1);
        blue_vip_has_checks[2]   = bit_reg("blue_vip2_has_checks", 1);
        blue_vip_has_coverage[2] = bit_reg("blue_vip2_has_coverage", 1);
        blue_vip_has_checks[3]   = bit_reg("blue_vip3_has_checks", 1);
        blue_vip_has_coverage[3] = bit_reg("blue_vip3_has_coverage", 1);
        blue_vip_has_checks[4]   = bit_reg("blue_vip4_has_checks", 1);
        blue_vip_has_coverage[4] = bit_reg("blue_vip4_has_coverage", 1);
        blue_vip_has_checks[5]   = bit_reg("blue_vip5_has_checks", 1);
        blue_vip_has_coverage[5] = bit_reg("blue_vip5_has_coverage", 1);
        
        purple_vip_has_checks[0]   = bit_reg("purple_vip0_has_checks", 1);
        purple_vip_has_coverage[0] = bit_reg("purple_vip0_has_coverage", 1);
        purple_vip_has_checks[1]   = bit_reg("purple_vip1_has_checks", 1);
        purple_vip_has_coverage[1] = bit_reg("purple_vip1_has_coverage", 1);
        purple_vip_has_checks[2]   = bit_reg("purple_vip2_has_checks", 1);
        purple_vip_has_coverage[2] = bit_reg("purple_vip2_has_coverage", 1);
        purple_vip_has_checks[3]   = bit_reg("purple_vip3_has_checks", 1);
        purple_vip_has_coverage[3] = bit_reg("purple_vip3_has_coverage", 1);
        purple_vip_has_checks[4]   = bit_reg("purple_vip4_has_checks", 1);
        purple_vip_has_coverage[4] = bit_reg("purple_vip4_has_coverage", 1);
        purple_vip_has_checks[5]   = bit_reg("purple_vip5_has_checks", 1);
        purple_vip_has_coverage[5] = bit_reg("purple_vip5_has_coverage", 1);
    endfunction

endclass : amiq_dvcon_tb_env_cfg

`endif // __amiq_dvcon_tb_env_cfg