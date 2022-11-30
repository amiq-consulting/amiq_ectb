/******************************************************************************
 * (C) Copyright 2022 AMIQ All Rights Reserved
 *
 * MODULE:    amiq_ectb_test
 * DEVICE:
 * PROJECT:
 * AUTHOR:    andvin
 * DATE:      2022 7:57:23 PM
 *
 * ABSTRACT:  You can customize the file content from Window -> Preferences -> DVT -> Code Templates -> "verilog File"
 *
 *******************************************************************************/


`ifndef __amiq_ectb_test
`define __amiq_ectb_test

class amiq_ectb_test extends uvm_test;

    // Sequence types
    string sequence_types[$];

    // Sequence names
    string sequence_names[$];

    // Sequence serial/parallel
    bit sequence_parallel[$];

    // Virtual sequencer
    uvm_sequencer virtual_sequencer;

    // Used to create components
    // Needs to be retrieved so it is instantiated globally to reduce performance hit
    uvm_factory factory;

    `uvm_component_utils(amiq_ectb_test)

    function new(string name = "amiq_ectb_test", uvm_component parent=null);
        super.new(name,parent);
    endfunction : new

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
    endfunction : build_phase

    task run_phase(uvm_phase phase);
        super.run_phase(phase);

        if(virtual_sequencer==null) `uvm_fatal(get_name(), $sformatf("A virtual sequence has to be set in the test on which all defined virtual sequences will be started."))

        // Retrieve the factory globally so it is available in all functions without having to "get" it multiple times
        factory = uvm_factory::get();

        // Read the plusargs for all the defined sequences and save their type together with the name and parallelism status, if defined
        retrieve_all_seq_type();

        // Based on the previous returned types, names and parallelism status create and start all sequences
        for(int i=0; i<sequence_types.size(); i++) begin
            schedule_sequence(i);
            wait_threads(i);
        end
    endtask : run_phase

    /**
     * @param index - Current index parsed in the type/name/parallel queues
     */
    task wait_threads(int index);
        if(sequence_parallel[index] && ~sequence_parallel[index+1])
            wait fork;
    endtask : wait_threads

    /**
     * @param index - Current index parsed in the type/name/parallel queues
     */
    task schedule_sequence(int index);
        if(~sequence_parallel[index])
            create_and_start_seq(sequence_types[index], sequence_names[index], index);
        else
            fork
                automatic int index_auto = index;
                create_and_start_seq(sequence_types[index_auto], sequence_names[index_auto], index_auto);
            join_none
    endtask : schedule_sequence

    function string retrieve_seq_type(int index);
        string seq_index = $sformatf("seq%0d", index);
        if(!$value$plusargs({seq_index, "=%0s"}, retrieve_seq_type)) retrieve_seq_type = "";
    endfunction

    function string retrieve_seq_name(int index);
        string seq_index = $sformatf("seq%0d_name", index);
        if(!$value$plusargs({seq_index, "=%0s"}, retrieve_seq_name)) retrieve_seq_name = "";
    endfunction

    function bit retrieve_seq_if_parallel(int index);
        string seq_index = $sformatf("seq%0d_p", index);
        if(!$value$plusargs({seq_index, "=%0b"}, retrieve_seq_if_parallel)) retrieve_seq_if_parallel = 0;
    endfunction

    function void retrieve_all_seq_type();
        string seq_type;
        string seq_name;
        bit seq_parallel;
        int index;

        forever begin
            // Retrieve the sequences passed as plusargs
            seq_type = retrieve_seq_type(index);
            // If no sequence name is retrieved, we break the loop
            if(seq_type == "") break;

            // If the sequence exists, retrieve its name, if that is defined
            seq_name = retrieve_seq_name(index);

            // If the name is not defined, create it based on the type and the index
            if(seq_name=="") seq_name = $sformatf("%0s_%0d", seq_type, index);

            // If the parallelism status is defined, retrieve it, otherwise it is serial
            seq_parallel = retrieve_seq_if_parallel(index);

            // Push the type, name and parallelism status
            sequence_types.push_back(seq_type);
            sequence_names.push_back(seq_name);
            sequence_parallel.push_back(seq_parallel);

            index++;
        end
    endfunction

    task create_and_start_seq(string type_name, string inst_name, int index);
        uvm_object m_object;
        amiq_ectb_sequence m_sequence;

        // Create
        m_object = factory.create_object_by_name(type_name, this.get_full_name(), inst_name);
        $cast(m_sequence, m_object);

        // If seq for this index is defined but the type is not defined, we throw a warning and continue to next index
        if(m_sequence == null) begin
            `uvm_fatal(get_name(), $sformatf("seq%0d is defined as a type that doesn't exist. Type defined: %0s", index, type_name))
        end

        // Register_all_vars
        m_sequence.register_all_vars();

        // Set the pointer to env and start sequence
        m_sequence.start(virtual_sequencer);

    endtask

endclass : amiq_ectb_test

`endif // __amiq_ectb_test