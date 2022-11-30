/******************************************************************************
 * (C) Copyright 2022 AMIQ All Rights Reserved
 *
 * MODULE:    amiq_dvcon_tb_env
 * DEVICE:
 * PROJECT:
 * AUTHOR:    andvin
 * DATE:      2022 8:21:56 PM
 *
 * ABSTRACT:  You can customize the file content from Window -> Preferences -> DVT -> Code Templates -> "verilog File"
 *
 *******************************************************************************/


`ifndef __amiq_dvcon_tb_env
`define __amiq_dvcon_tb_env


class amiq_dvcon_tb_env extends amiq_ectb_environment;

    // Components of the environment
    amiq_dvcon_tb_env_cfg env_cfg;

    amiq_dvcon_tb_vip_red_agent my_red_agent0;
    amiq_dvcon_tb_vip_red_cfg_obj my_red_agent0_cfg;
    amiq_dvcon_tb_vip_red_agent my_red_agent1;
    amiq_dvcon_tb_vip_red_cfg_obj my_red_agent1_cfg;

    amiq_dvcon_tb_vip_blue_agent my_blue_agent;
    amiq_dvcon_tb_vip_blue_cfg_obj my_blue_agent_cfg;

    amiq_dvcon_tb_vip_purple_agent my_purple_agent0;
    amiq_dvcon_tb_vip_purple_cfg_obj my_purple_agent0_cfg;
    amiq_dvcon_tb_vip_purple_agent my_purple_agent1;
    amiq_dvcon_tb_vip_purple_cfg_obj my_purple_agent1_cfg;
    amiq_dvcon_tb_vip_purple_agent my_purple_agent2;
    amiq_dvcon_tb_vip_purple_cfg_obj my_purple_agent2_cfg;

    amiq_dvcon_tb_coverage_collector cov_collector;

    amiq_dvcon_tb_sqr virtual_sequencer;

    `uvm_component_utils(amiq_dvcon_tb_env)

    function new(string name = "amiq_dvcon_tb_env", uvm_component parent);
        super.new(name, parent);
    endfunction : new

    /**
     * @see amiq_dvcon_pkg::amiq_dvcon_environment.post_create_components
     */
    virtual function void post_create_components();
        super.post_create_components();
        configure_agents();
        virtual_sequencer = amiq_dvcon_tb_sqr::type_id::create("virtual_sequencer", this);
    endfunction : post_create_components

    // function_description
    function void configure_agents();
        // Cast the handles for each agent
        $cast(my_red_agent0, components[0]);
        $cast(my_red_agent1, components[1]);
        $cast(my_blue_agent, components[2]);
        $cast(my_purple_agent0, components[3]);
        $cast(my_purple_agent1, components[4]);
        $cast(my_purple_agent2, components[5]);
        $cast(cov_collector, components[6]);

        my_red_agent0_cfg = new("my_red_agent0_cfg");
        my_red_agent0_cfg.m_is_active = env_cfg.vip0_is_active;
        my_red_agent0_cfg.m_checks_enable = env_cfg.vip0_has_checks;
        my_red_agent0_cfg.m_coverage_enable = env_cfg.vip0_has_coverage;
        uvm_config_db#(amiq_dvcon_tb_vip_red_cfg_obj)::set(this, "red_agent_0", "m_config_obj", my_red_agent0_cfg);
        my_red_agent1_cfg = new("my_red_agent1_cfg");
        my_red_agent1_cfg.m_is_active = env_cfg.vip1_is_active;
        my_red_agent1_cfg.m_checks_enable = env_cfg.vip1_has_checks;
        my_red_agent1_cfg.m_coverage_enable = env_cfg.vip1_has_coverage;
        uvm_config_db#(amiq_dvcon_tb_vip_red_cfg_obj)::set(this, "red_agent_1", "m_config_obj", my_red_agent1_cfg);
        my_blue_agent_cfg = new("my_blue_agent_cfg");
        my_blue_agent_cfg.m_is_active = env_cfg.vip2_is_active;
        my_blue_agent_cfg.m_checks_enable = env_cfg.vip2_has_checks;
        my_blue_agent_cfg.m_coverage_enable = env_cfg.vip2_has_coverage;
        uvm_config_db#(amiq_dvcon_tb_vip_blue_cfg_obj)::set(this, "blue_agent", "m_config_obj", my_blue_agent_cfg);
        my_purple_agent0_cfg = new("my_purple_agent0_cfg");
        my_purple_agent0_cfg.m_is_active = env_cfg.vip3_is_active;
        my_purple_agent0_cfg.m_checks_enable = env_cfg.vip3_has_checks;
        my_purple_agent0_cfg.m_coverage_enable = env_cfg.vip3_has_coverage;
        uvm_config_db#(amiq_dvcon_tb_vip_purple_cfg_obj)::set(this, "purple_agent_0", "m_config_obj", my_purple_agent0_cfg);
        my_purple_agent1_cfg = new("my_purple_agent1_cfg");
        my_purple_agent1_cfg.m_is_active = env_cfg.vip4_is_active;
        my_purple_agent1_cfg.m_checks_enable = env_cfg.vip4_has_checks;
        my_purple_agent1_cfg.m_coverage_enable = env_cfg.vip4_has_coverage;
        uvm_config_db#(amiq_dvcon_tb_vip_purple_cfg_obj)::set(this, "purple_agent_1", "m_config_obj", my_purple_agent1_cfg);
        my_purple_agent2_cfg = new("my_purple_agent2_cfg");
        my_purple_agent2_cfg.m_is_active = env_cfg.vip5_is_active;
        my_purple_agent2_cfg.m_checks_enable = env_cfg.vip5_has_checks;
        my_purple_agent2_cfg.m_coverage_enable = env_cfg.vip5_has_coverage;
        uvm_config_db#(amiq_dvcon_tb_vip_purple_cfg_obj)::set(this, "purple_agent_2", "m_config_obj", my_purple_agent2_cfg);
    endfunction : configure_agents

    /**
     * @see uvm_pkg::uvm_component.connect_phase
     * @param phase -
     */
    virtual function void connect_phase(uvm_phase phase);
        if(my_red_agent0!=null) begin
            my_red_agent0.m_monitor.m_collected_item_port.connect(cov_collector.m_red_monitor_port);
            virtual_sequencer.red_agent_sequencer[0] = my_red_agent0.m_sequencer;
        end
        if(my_red_agent1!=null) begin
            my_red_agent1.m_monitor.m_collected_item_port.connect(cov_collector.m_red_monitor_port);
            virtual_sequencer.red_agent_sequencer[1] = my_red_agent1.m_sequencer;
        end
        if(my_blue_agent!=null) begin
            my_blue_agent.m_monitor.m_collected_item_port.connect(cov_collector.m_blue_monitor_port);
            virtual_sequencer.blue_agent_sequencer[0] = my_blue_agent.m_sequencer;
        end
        if(my_purple_agent0!=null) begin
            my_purple_agent0.m_monitor.m_collected_item_port.connect(cov_collector.m_purple_monitor_port);
            virtual_sequencer.purple_agent_sequencer[0] = my_purple_agent0.m_sequencer;
        end
        if(my_purple_agent1!=null) begin
            my_purple_agent1.m_monitor.m_collected_item_port.connect(cov_collector.m_purple_monitor_port);
            virtual_sequencer.purple_agent_sequencer[1] = my_purple_agent1.m_sequencer;
        end
        if(my_purple_agent2!=null) begin
            my_purple_agent2.m_monitor.m_collected_item_port.connect(cov_collector.m_purple_monitor_port);
            virtual_sequencer.purple_agent_sequencer[2] = my_purple_agent2.m_sequencer;
        end


    endfunction : connect_phase

endclass : amiq_dvcon_tb_env

`endif // __amiq_dvcon_tb_env