/******************************************************************************
 * (C) Copyright 2022 AMIQ All Rights Reserved
 *
 * MODULE:    amiq_ectb_sequence
 * DEVICE:
 * PROJECT:
 * AUTHOR:    andvin
 * DATE:      2022 6:08:06 PM
 *
 * ABSTRACT:  You can customize the file content from Window -> Preferences -> DVT -> Code Templates -> "verilog File"
 *
 *******************************************************************************/

`ifndef __amiq_ectb_sequence
`define __amiq_ectb_sequence

//------------------------------------------------------------------------------
//
// CLASS: amiq_ectb_sequence
//
//------------------------------------------------------------------------------


class amiq_ectb_sequence extends uvm_sequence;

    `uvm_object_utils(amiq_ectb_sequence)
    
    // new - constructor
    function new(string name = "amiq_ectb_sequence");
        super.new(name);
    endfunction : new

    virtual task pre_body();
        super.pre_body();
        register_all_vars();
    endtask : pre_body

    `include "amiq_ectb_reg_functions.svh"

endclass : amiq_ectb_sequence

`endif // __amiq_ectb_sequence