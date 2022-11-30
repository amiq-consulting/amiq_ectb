/******************************************************************************
 * (C) Copyright 2022 AMIQ All Rights Reserved
 *
 * MODULE:    amiq_dvcon_tb_vip_item
 * DEVICE:
 * PROJECT:
 * AUTHOR:    andvin
 * DATE:      2022 8:15:08 PM
 *
 * ABSTRACT:  You can customize the file content from Window -> Preferences -> DVT -> Code Templates -> "verilog File"
 *
 *******************************************************************************/

`ifndef __amiq_dvcon_tb_vip_item
`define __amiq_dvcon_tb_vip_item


class amiq_dvcon_tb_vip_red_item extends uvm_sequence_item;

    rand int delay;
    rand int field0;
    rand int field1;
    rand int field2;

    constraint c_default_values_data {
        delay inside {[1:10]};
    }

    `uvm_object_utils_begin(amiq_dvcon_tb_vip_red_item)
        `uvm_field_int(field0, UVM_DEFAULT)
        `uvm_field_int(field1, UVM_DEFAULT)
        `uvm_field_int(field2, UVM_DEFAULT)
        `uvm_field_int(delay, UVM_DEFAULT)
    `uvm_object_utils_end

    function new (string name = "amiq_dvcon_tb_vip_item");
        super.new(name);
    endfunction : new

endclass :  amiq_dvcon_tb_vip_red_item

`endif // __amiq_dvcon_tb_vip_item