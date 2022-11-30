/******************************************************************************
 * (C) Copyright 2022 AMIQ All Rights Reserved
 *
 * MODULE:    amiq_dvcon_tb_vip_agent
 * DEVICE:
 * PROJECT:
 * AUTHOR:    andvin
 * DATE:      2022 8:14:55 PM
 *
 * ABSTRACT:  You can customize the file content from Window -> Preferences -> DVT -> Code Templates -> "verilog File"
 *
 *******************************************************************************/

`ifndef __amiq_dvcon_tb_vip_agent
`define __amiq_dvcon_tb_vip_agent


class amiq_dvcon_tb_vip_red_agent extends uvm_agent;

    // Configuration object
    protected amiq_dvcon_tb_vip_red_cfg_obj m_config_obj;

    amiq_dvcon_tb_vip_red_driver m_driver;
    uvm_sequencer m_sequencer;
    amiq_dvcon_tb_vip_red_monitor m_monitor;
//    uvc_company_uvc_name_coverage_collector m_coverage_collector;

    // TODO Add fields here
    

    `uvm_component_utils(amiq_dvcon_tb_vip_red_agent)

    function new (string name = "amiq_dvcon_tb_vip_agent", uvm_component parent);
        super.new(name, parent);
    endfunction : new

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        // Get the configuration object
        if(!uvm_config_db#(amiq_dvcon_tb_vip_red_cfg_obj)::get(this, "", "m_config_obj", m_config_obj))
            `uvm_fatal("NOCONFIG", {"Config object must be set for: ", get_full_name(), ".m_config_obj"})
        else
            `uvm_info(get_full_name(), $sformatf("Name of the config object %0s", m_config_obj.get_name()), UVM_NONE)

        // Propagate the configuration object to monitor
        uvm_config_db#(amiq_dvcon_tb_vip_red_cfg_obj)::set(this, "m_monitor", "m_config_obj", m_config_obj);
        // Create the monitor
        m_monitor = amiq_dvcon_tb_vip_red_monitor::type_id::create("m_monitor", this);

//        if(m_config_obj.m_coverage_enable) begin
//            m_coverage_collector = uvc_company_uvc_name_coverage_collector::type_id::create("m_coverage_collector", this);
//        end

        if(m_config_obj.m_is_active == UVM_ACTIVE) begin
            // Propagate the configuration object to driver
            uvm_config_db#(amiq_dvcon_tb_vip_red_cfg_obj)::set(this, "m_driver", "m_config_obj", m_config_obj);
            // Create the driver
            m_driver = amiq_dvcon_tb_vip_red_driver::type_id::create("m_driver", this);

            // Create the sequencer
            m_sequencer = new("sqr", this);
        end
    endfunction : build_phase

    virtual function void connect_phase(uvm_phase phase);
//        if(m_config_obj.m_coverage_enable) begin
//            m_monitor.m_collected_item_port.connect(m_coverage_collector.m_monitor_port);
//        end

        if(m_config_obj.m_is_active == UVM_ACTIVE) begin
            m_driver.seq_item_port.connect(m_sequencer.seq_item_export);
        end
    endfunction : connect_phase

endclass : amiq_dvcon_tb_vip_red_agent

`endif // __amiq_dvcon_tb_vip_agent