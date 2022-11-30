/******************************************************************************
 * (C) Copyright 2022 AMIQ All Rights Reserved
 *
 * MODULE:    amiq_dvcon_tb_vip_driver
 * DEVICE:
 * PROJECT:
 * AUTHOR:    andvin
 * DATE:      2022 8:15:02 PM
 *
 * ABSTRACT:  You can customize the file content from Window -> Preferences -> DVT -> Code Templates -> "verilog File"
 *
 *******************************************************************************/


`ifndef __amiq_dvcon_tb_vip_driver
`define __amiq_dvcon_tb_vip_driver


class amiq_dvcon_tb_vip_red_driver extends uvm_driver;

    // The virtual interface to HDL signals.
    protected virtual amiq_dvcon_tb_vip_red_if my_vif;

    // Configuration object
    protected amiq_dvcon_tb_vip_red_cfg_obj m_config_obj;

    `uvm_component_utils(amiq_dvcon_tb_vip_red_driver)

    function new (string name = "amiq_dvcon_tb_vip_driver", uvm_component parent);
        super.new(name, parent);
    endfunction : new

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        // Get the interface
        if(!uvm_config_db#(virtual amiq_dvcon_tb_vip_red_if)::get(this, "", "m_vif", my_vif))
            `uvm_fatal("NOVIF", {"virtual interface must be set for: ", get_full_name(), ".m_vif"})
            

        // Get the configuration object
        if(!uvm_config_db#(amiq_dvcon_tb_vip_red_cfg_obj)::get(this, "", "m_config_obj", m_config_obj))
            `uvm_fatal("NOCONFIG", {"Config object must be set for: ", get_full_name(), ".m_config_obj"})
        
    endfunction: build_phase

    virtual task run_phase(uvm_phase phase);
        // Driving should be triggered by an initial reset pulse
        @(negedge my_vif.rst)
            do @(posedge my_vif.clk);
            while(my_vif.rst!==1);

        // Start driving
        get_and_drive();
    endtask : run_phase

    virtual protected task get_and_drive();
        process main_thread; // main thread
        process rst_mon_thread; // reset monitor thread
        amiq_dvcon_tb_vip_red_item item; // item to be driven

        forever begin
            // Don't drive during reset
            while(my_vif.rst!==1) @(posedge my_vif.clk);

            // Get the next item from the sequencer
            seq_item_port.get_next_item(req);
            $cast(item, req.clone());
            item.set_id_info(req);

            // Drive current transaction
            fork
                // Drive the transaction
                begin
                    main_thread=process::self();
                    `uvm_info(get_type_name(), $sformatf("uvc_company_uvc_name_driver %0d start driving item :\n%s", m_config_obj.m_agent_id, item.sprint()), UVM_HIGH)
                    drive_item(item);
                    `uvm_info(get_type_name(), $sformatf("uvc_company_uvc_name_driver %0d done driving item :\n%s", m_config_obj.m_agent_id, item.sprint()), UVM_HIGH)

                    if (rst_mon_thread) rst_mon_thread.kill();
                end
                // Monitor the reset signal
                begin
                    rst_mon_thread = process::self();
                    @(negedge my_vif.rst) begin
                        // Interrupt current transaction at reset
                        if(main_thread) main_thread.kill();
                        // Do reset
                        reset_signals();
                        reset_driver();
                    end
                end
            join_any

            // Send item_done and a response to the sequencer
            seq_item_port.item_done();
        end
    endtask : get_and_drive

    virtual protected task reset_signals();
    // TODO Reset the signals to their default values
    endtask : reset_signals

    virtual protected task reset_driver();
    // TODO Reset driver specific state variables (e.g. counters, flags, buffers, queues, etc.)
    endtask : reset_driver

    virtual protected task drive_item(amiq_dvcon_tb_vip_red_item item);
        repeat(item.delay)
            @(posedge my_vif.clk);
        `uvm_info(get_name(), $sformatf("Driving the following item: \n%s", item.sprint()), UVM_HIGH)
        my_vif.field0 = item.field0;
        my_vif.field1 = item.field1;
        my_vif.field2 = item.field2;
        my_vif.valid = 1;
        @(posedge my_vif.clk);
        my_vif.valid = 0;
    endtask : drive_item

endclass : amiq_dvcon_tb_vip_red_driver

`endif // IFNDEF_GUARD_uvc_company_uvc_name_driver
