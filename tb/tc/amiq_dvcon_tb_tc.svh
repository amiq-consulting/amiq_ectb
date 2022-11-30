/******************************************************************************
 * (C) Copyright 2022 AMIQ All Rights Reserved
 *
 * MODULE:    amiq_dvcon_base_tc
 * DEVICE:
 * PROJECT:
 * AUTHOR:    andvin
 * DATE:      2022 5:34:51 PM
 *
 * ABSTRACT:  You can customize the file content from Window -> Preferences -> DVT -> Code Templates -> "verilog File"
 *
 *******************************************************************************/

`ifndef ___amiq_dvcon_tb_tc
`define ___amiq_dvcon_tb_tc

class amiq_dvcon_tb_tc extends amiq_ectb_test;

    `uvm_component_utils(amiq_dvcon_tb_tc)
    
    amiq_dvcon_tb_env my_env;
    amiq_dvcon_tb_env_cfg env_cfg;
    
    realtime system_time_history[$];

    function new(string name = "amiq_dvcon_tb_tc", uvm_component parent=null);
        super.new(name,parent);
    endfunction : new

    virtual function void build_phase(uvm_phase phase);
        set_type_override_by_type(amiq_ectb_environment::get_type(), amiq_dvcon_tb_env::get_type());
        super.build_phase(phase);
        
        env_cfg = new("env_cfg");
        my_env = amiq_dvcon_tb_env::type_id::create("amiq_dvcon_tb_env", this);
        my_env.env_cfg = env_cfg;
        
        collect_current_system_time_in_s();
    endfunction : build_phase

    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        virtual_sequencer = my_env.virtual_sequencer;
    endfunction : connect_phase

    task run_phase(uvm_phase phase);
        phase.raise_objection(this);
        super.run_phase(phase);
        phase.drop_objection(this);
        collect_current_system_time_in_s();
    endtask : run_phase
    
    /**
     * @see uvm_pkg::uvm_component.extract_phase
     * @param phase - 
     */
    virtual function void extract_phase(uvm_phase phase);
        super.extract_phase(phase);
        `uvm_info(get_name(), $sformatf("Elapsed simulation time in seconds: %0d", system_time_history[1]-system_time_history[0]), UVM_NONE)
    endfunction : extract_phase
    
    function void collect_current_system_time_in_s();
        realtime system_time;
        int fd;
        $system("date +%s > perf_trace");
        fd = $fopen("./perf_trace", "r");
        if(!$fscanf(fd, "%0f", system_time))
            `uvm_fatal("", "Could not retrieve start time of build phase")
            $fclose(fd);
        system_time_history.push_back(system_time);
    endfunction

endclass : amiq_dvcon_tb_tc

`endif // ___amiq_dvcon_tb_tc

