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

    // Active/passive for all vips
    uvm_active_passive_enum vip0_is_active = UVM_ACTIVE;
    uvm_active_passive_enum vip1_is_active = UVM_ACTIVE;
    uvm_active_passive_enum vip2_is_active = UVM_ACTIVE;
    uvm_active_passive_enum vip3_is_active = UVM_ACTIVE;
    uvm_active_passive_enum vip4_is_active = UVM_ACTIVE;
    uvm_active_passive_enum vip5_is_active = UVM_ACTIVE;

    // Enable/disable checks for all vips
    bit vip0_has_checks;
    bit vip0_has_coverage;

    // Enable/disable coverage for all vips
    bit vip1_has_checks;
    bit vip1_has_coverage;
    
    // Enable/disable coverage for all vips
    bit vip2_has_checks;
    bit vip2_has_coverage;

    // Enable/disable coverage for all vips
    bit vip3_has_checks;
    bit vip3_has_coverage;
    
    // Enable/disable coverage for all vips
    bit vip4_has_checks;
    bit vip4_has_coverage;
    
    // Enable/disable coverage for all vips
    bit vip5_has_checks;
    bit vip5_has_coverage;
    
    `uvm_object_utils(amiq_dvcon_tb_env_cfg)

    function new (string name = "amiq_dvcon_tb_env_cfg");
        super.new(name);
    endfunction : new

    virtual function void register_all_vars();
        vip0_is_active = uvm_active_passive_enum'(bit_reg("vip0_is_active"));
        vip1_is_active = uvm_active_passive_enum'(bit_reg("vip1_is_active"));
        
        vip0_has_checks = bit_reg("vip0_has_checks");
        vip0_has_coverage = bit_reg("vip0_has_coverage");

        vip1_has_checks = bit_reg("vip1_has_checks");
        vip1_has_coverage = bit_reg("vip1_has_coverage");
        
        vip2_has_checks = bit_reg("vip2_has_checks");
        vip2_has_coverage = bit_reg("vip2_has_coverage");
    endfunction

endclass : amiq_dvcon_tb_env_cfg

`endif // __amiq_dvcon_tb_env_cfg