/******************************************************************************
 * (C) Copyright 2022 AMIQ All Rights Reserved
 *
 * MODULE:    amiq_dvcon_tb_vip_cfg_obj
 * DEVICE:
 * PROJECT:
 * AUTHOR:    andvin
 * DATE:      2022 8:32:09 PM
 *
 * ABSTRACT:  You can customize the file content from Window -> Preferences -> DVT -> Code Templates -> "verilog File"
 *
 *******************************************************************************/

`ifndef __amiq_dvcon_tb_vip_blue_cfg_obj
`define __amiq_dvcon_tb_vip_blue_cfg_obj

//------------------------------------------------------------------------------
//
// CLASS: uvc_company_uvc_name_config_obj
//
//------------------------------------------------------------------------------

class amiq_dvcon_tb_vip_blue_cfg_obj extends uvm_object;

    // Agent id
    int unsigned m_agent_id = 0;

    // Active/passive
    uvm_active_passive_enum m_is_active = UVM_ACTIVE;

    // Enable/disable checks
    bit m_checks_enable = 1;

    // Enable/disable coverage
    bit m_coverage_enable = 1;

    // TODO Add other configuration parameters that you might need
    

    // TODO It's very important that you use these macros on all the configuration fields. If you miss any field it will not be propagated correctly.
    `uvm_object_utils_begin(amiq_dvcon_tb_vip_blue_cfg_obj)
        `uvm_field_int(m_agent_id, UVM_DEFAULT)
        `uvm_field_enum(uvm_active_passive_enum, m_is_active, UVM_DEFAULT)
        `uvm_field_int(m_checks_enable, UVM_DEFAULT)
        `uvm_field_int(m_coverage_enable, UVM_DEFAULT)
    `uvm_object_utils_end

    function new(string name = "amiq_dvcon_tb_vip_cfg_obj");
        super.new(name);
    endfunction: new

endclass : amiq_dvcon_tb_vip_blue_cfg_obj

`endif // __amiq_dvcon_tb_vip_blue_cfg_obj