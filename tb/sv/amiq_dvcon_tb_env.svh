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

	// Automatic and scaling env example
	amiq_dvcon_tb_vip_red_agent my_red_agents[$];
	amiq_dvcon_tb_vip_red_cfg_obj my_red_agents_cfg[$];

	amiq_dvcon_tb_vip_blue_agent my_blue_agents[$];
	amiq_dvcon_tb_vip_red_cfg_obj my_blue_agents_cfg[$];

	amiq_dvcon_tb_vip_purple_agent my_purple_agents[$];
	amiq_dvcon_tb_vip_purple_cfg_obj my_purple_agents_cfg[$];

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
		cast_agents();
		configure_agents();

		// We cannot have a working TB without a sequencer, so we create it outside
		// of the plusarg dynamic scheme
		virtual_sequencer = amiq_dvcon_tb_sqr::type_id::create("virtual_sequencer", this);
	endfunction : post_create_components


	function void cast_agents();

		foreach(components[i]) begin
			case(components[i].get_type_name())
				"amiq_dvcon_tb_vip_red_agent": begin
					amiq_dvcon_tb_vip_red_agent proxy_agent;
					$cast(proxy_agent, components[i]);
					my_red_agents.push_back(proxy_agent);
				end
				"amiq_dvcon_tb_vip_blue_agent": begin
					amiq_dvcon_tb_vip_blue_agent proxy_agent;
					$cast(proxy_agent, components[i]);
					my_blue_agents.push_back(proxy_agent);
				end
				"amiq_dvcon_tb_vip_purple_agent": begin
					amiq_dvcon_tb_vip_purple_agent proxy_agent;
					$cast(proxy_agent, components[i]);
					my_purple_agents.push_back(proxy_agent);
				end
				// Keep in mind, that components that have to always exist, can be created separate
				// This serves as an example of an env that can be created without a coverage collector
				"amiq_dvcon_tb_coverage_collector": begin
					$cast(cov_collector, components[i]);
				end
				default: `uvm_error("AMIQ_DVCON_ENV_COMP_CASTING_ERR", $sformatf("Received unknown components %0s",components[i].get_type_name()))
			endcase
		end
	endfunction


	function void configure_agents();
		if(my_red_agents.size()>1)
			foreach(my_red_agents[i]) begin
				amiq_dvcon_tb_vip_red_cfg_obj proxy_red_agent_cfg;
				proxy_red_agent_cfg = red_cfg(i);
				uvm_config_db#(amiq_dvcon_tb_vip_red_cfg_obj)::set(this, $sformatf("*red_agent*%0d", i), "m_config_obj", proxy_red_agent_cfg);
			end
		else if(my_red_agents.size()==1) begin
			amiq_dvcon_tb_vip_red_cfg_obj proxy_red_agent_cfg;
			proxy_red_agent_cfg = red_cfg(0);
			uvm_config_db#(amiq_dvcon_tb_vip_red_cfg_obj)::set(this, $sformatf("*red_agent*"), "m_config_obj", proxy_red_agent_cfg);
		end
		if(my_blue_agents.size()>1)
			foreach(my_blue_agents[i]) begin
				amiq_dvcon_tb_vip_blue_cfg_obj proxy_blue_agent_cfg;
				proxy_blue_agent_cfg = blue_cfg(i);
				uvm_config_db#(amiq_dvcon_tb_vip_blue_cfg_obj)::set(this, $sformatf("*blue_agent*%0d", i), "m_config_obj", proxy_blue_agent_cfg);
			end
		else if(my_blue_agents.size()==1) begin
			amiq_dvcon_tb_vip_blue_cfg_obj proxy_blue_agent_cfg;
			proxy_blue_agent_cfg = blue_cfg(0);
			uvm_config_db#(amiq_dvcon_tb_vip_blue_cfg_obj)::set(this, $sformatf("*blue_agent*"), "m_config_obj", proxy_blue_agent_cfg);
		end
		if(my_purple_agents.size()>1)
			foreach(my_purple_agents[i]) begin
				amiq_dvcon_tb_vip_purple_cfg_obj proxy_purple_agent_cfg;
				proxy_purple_agent_cfg = purple_cfg(i);
				uvm_config_db#(amiq_dvcon_tb_vip_purple_cfg_obj)::set(this, $sformatf("*purple_agent*%0d", i), "m_config_obj", proxy_purple_agent_cfg);
			end
		else if(my_purple_agents.size()==1) begin
			amiq_dvcon_tb_vip_purple_cfg_obj proxy_purple_agent_cfg;
			proxy_purple_agent_cfg = purple_cfg(0);
			uvm_config_db#(amiq_dvcon_tb_vip_purple_cfg_obj)::set(this, $sformatf("*purple_agent*"), "m_config_obj", proxy_purple_agent_cfg);
		end
	endfunction : configure_agents

	function amiq_dvcon_tb_vip_red_cfg_obj red_cfg(int agent_id);
		amiq_dvcon_tb_vip_red_cfg_obj red_agent_cfg;
		red_agent_cfg = new("red_agent_cfg");
		red_agent_cfg.m_agent_id = agent_id;
		red_agent_cfg.m_checks_enable = env_cfg.red_vip_has_checks[agent_id];
		red_agent_cfg.m_coverage_enable = env_cfg.red_vip_has_coverage[agent_id];
		red_agent_cfg.m_is_active = env_cfg.red_vip_is_active[agent_id];
		return red_agent_cfg;
	endfunction

	function amiq_dvcon_tb_vip_blue_cfg_obj blue_cfg(int agent_id);
		amiq_dvcon_tb_vip_blue_cfg_obj blue_agent_cfg;
		blue_agent_cfg = new("blue_agent_cfg");
		blue_agent_cfg.m_agent_id = agent_id;
		blue_agent_cfg.m_checks_enable = env_cfg.blue_vip_has_checks[agent_id];
		blue_agent_cfg.m_coverage_enable = env_cfg.blue_vip_has_coverage[agent_id];
		blue_agent_cfg.m_is_active = env_cfg.blue_vip_is_active[agent_id];
		return blue_agent_cfg;
	endfunction

	function amiq_dvcon_tb_vip_purple_cfg_obj purple_cfg(int agent_id);
		amiq_dvcon_tb_vip_purple_cfg_obj purple_agent_cfg;
		purple_agent_cfg = new("purple_agent_cfg");
		purple_agent_cfg.m_agent_id = agent_id;
		purple_agent_cfg.m_checks_enable = env_cfg.purple_vip_has_checks[agent_id];
		purple_agent_cfg.m_coverage_enable = env_cfg.purple_vip_has_coverage[agent_id];
		purple_agent_cfg.m_is_active = env_cfg.purple_vip_is_active[agent_id];
		return purple_agent_cfg;
	endfunction

	/**
	 * @see uvm_pkg::uvm_component.connect_phase
	 * @param phase -
	 */
	virtual function void connect_phase(uvm_phase phase);
		if(cov_collector != null) begin

			foreach(my_red_agents[i]) begin
				my_red_agents[i].m_monitor.m_collected_item_port.connect(cov_collector.m_red_monitor_port);
				virtual_sequencer.red_agent_sequencers.push_back(my_red_agents[i].m_sequencer);
			end
			foreach(my_blue_agents[i]) begin
				my_blue_agents[i].m_monitor.m_collected_item_port.connect(cov_collector.m_blue_monitor_port);
				virtual_sequencer.blue_agent_sequencers.push_back(my_blue_agents[i].m_sequencer);
			end
			foreach(my_purple_agents[i]) begin
				my_purple_agents[i].m_monitor.m_collected_item_port.connect(cov_collector.m_purple_monitor_port);
				virtual_sequencer.purple_agent_sequencers.push_back(my_purple_agents[i].m_sequencer);
			end

		end
	endfunction : connect_phase


endclass : amiq_dvcon_tb_env

`endif // __amiq_dvcon_tb_env