/******************************************************************************
 * (C) Copyright 2022 AMIQ All Rights Reserved
 *
 * MODULE:    amiq_ectb_object
 * DEVICE:
 * PROJECT:
 * AUTHOR:    andvin
 * DATE:      2022 5:30:25 PM
 *
 * ABSTRACT:  You can customize the file content from Window -> Preferences -> DVT -> Code Templates -> "verilog File"
 *
 *******************************************************************************/

class amiq_ectb_object extends uvm_object;

    `uvm_object_utils(amiq_ectb_object)

    function new(string name="");
        super.new(name);
        register_all_vars();
    endfunction
    
    `include "amiq_ectb_reg_functions.svh"

endclass
