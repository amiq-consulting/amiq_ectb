/******************************************************************************
 * (C) Copyright 2022 AMIQ All Rights Reserved
 *
 * MODULE:    amiq_dvcon_tb_vip_monitor
 * DEVICE:
 * PROJECT:
 * AUTHOR:    andvin
 * DATE:      2022 8:15:14 PM
 *
 * ABSTRACT:  You can customize the file content from Window -> Preferences -> DVT -> Code Templates -> "verilog File"
 *
 *******************************************************************************/


`ifndef __amiq_dvcon_tb_vip_blue_monitor
`define __amiq_dvcon_tb_vip_blue_monitor


class amiq_dvcon_tb_vip_blue_monitor extends uvm_monitor;

    // The virtual interface to HDL signals.
    protected virtual amiq_dvcon_tb_vip_blue_if my_vif;

    // Configuration object
    protected amiq_dvcon_tb_vip_blue_cfg_obj m_config_obj;

    // Collected item
    protected amiq_dvcon_tb_vip_blue_item m_collected_item;

    // Collected item is broadcast on this port
    uvm_analysis_port #(amiq_dvcon_tb_vip_blue_item) m_collected_item_port;

    `uvm_component_utils(amiq_dvcon_tb_vip_blue_monitor)

    function new (string name="amiq_dvcon_tb_vip_monitor", uvm_component parent);
        super.new(name, parent);

        // Allocate collected_item.
        m_collected_item = amiq_dvcon_tb_vip_blue_item::type_id::create("m_collected_item", this);

        // Allocate collected_item_port.
        m_collected_item_port = new("m_collected_item_port", this);
    endfunction : new

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        // Get the interface
        if(!uvm_config_db#(virtual amiq_dvcon_tb_vip_blue_if)::get(this, "", "m_vif", my_vif))
            `uvm_fatal("NOVIF", {"virtual interface must be set for: ", get_full_name(), ".m_vif"})

        // Get the configuration object
        if(!uvm_config_db#(amiq_dvcon_tb_vip_blue_cfg_obj)::get(this, "", "m_config_obj", m_config_obj))
            `uvm_fatal("NOCONFIG",{"Config object must be set for: ",get_full_name(),".m_config_obj"})
    endfunction: build_phase

    virtual task run_phase(uvm_phase phase);
        process main_thread; // main thread
        process rst_mon_thread; // rst monitor thread

        // Start monitoring only after an initial rst pulse
        @(negedge my_vif.rst)
            do @(posedge my_vif.clk);
            while(my_vif.rst!==1);

        // Start monitoring
        forever begin
            fork
                // Start the monitoring thread
                begin
                    main_thread=process::self();
                    collect_items();
                end
                // Monitor the rst signal
                begin
                    rst_mon_thread = process::self();
                    @(negedge my_vif.rst) begin
                        // Interrupt current item at rst
                        if(main_thread) main_thread.kill();
                        // Do rst
                        rst_monitor();
                    end
                end
            join_any

            if (rst_mon_thread) rst_mon_thread.kill();
        end
    endtask : run_phase

    virtual protected task collect_items();
        forever begin
            @(posedge my_vif.clk);
            if(my_vif.valid === 1) begin
                m_collected_item = amiq_dvcon_tb_vip_blue_item::type_id::create("m_collected_item", this);
                m_collected_item.field0 = my_vif.field0;
                m_collected_item.field1 = my_vif.field1;
                m_collected_item.field2 = my_vif.field2;

                `uvm_info(get_full_name(), $sformatf("Item collected :\n%s", m_collected_item.sprint()), UVM_MEDIUM)
                m_collected_item_port.write(m_collected_item);

                if (m_config_obj.m_checks_enable)
                    perform_item_checks();

            end
        end
    endtask : collect_items

    virtual protected function void perform_item_checks();
    // TODO Perform item checks here
    endfunction : perform_item_checks

    virtual protected function void rst_monitor();
    // TODO rst monitor specific state variables (e.g. counters, flags, buffers, queues, etc.)
    endfunction : rst_monitor

endclass : amiq_dvcon_tb_vip_blue_monitor

`endif // __amiq_dvcon_tb_vip_blue_monitor