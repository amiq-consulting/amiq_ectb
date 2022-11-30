/******************************************************************************
 * (C) Copyright 2022 AMIQ All Rights Reserved
 *
 * MODULE:    amiq_ectb_component
 * DEVICE:
 * PROJECT:
 * AUTHOR:    andvin
 * DATE:      2022 7:09:14 PM
 *
 * ABSTRACT:  You can customize the file content from Window -> Preferences -> DVT -> Code Templates -> "verilog File"
 *
 *******************************************************************************/


`ifndef __amiq_ectb_component
`define __amiq_ectb_component

class amiq_ectb_component extends uvm_component;

	`uvm_component_utils(amiq_ectb_component)

	function new (string name  = "amiq_ectb_component", uvm_component parent);
		super.new(name, parent);
	endfunction : new

	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		pre_create_objects();
		push_all_objs();
		create_objects();
		post_create_objects();


		pre_create_components();
		push_all_comps();
		create_components();
		post_create_components();

	endfunction : build_phase

	virtual function void pre_create_objects();
	endfunction

	virtual function void post_create_objects();
	endfunction

	virtual function void pre_create_components();
	endfunction

	virtual function void post_create_components();
	endfunction

	`include "amiq_ectb_comp_create_functions.svh"
	`include "amiq_ectb_obj_create_functions.svh"

	`include "amiq_ectb_reg_functions.svh"

endclass : amiq_ectb_component

`endif // __amiq_ectb_component