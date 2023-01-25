/******************************************************************************
 * (C) Copyright 2022 AMIQ All Rights Reserved
 *
 * MODULE:    amiq_dvcon_tb_seq_pkg
 * DEVICE:
 * PROJECT:
 * AUTHOR:    andvin
 * DATE:      2022 5:45:33 PM
 *
 * ABSTRACT:  You can customize the file content from Window -> Preferences -> DVT -> Code Templates -> "verilog File"
 *
 *******************************************************************************/

`ifndef __amiq_dvcon_tb_dynamic_constraint
`define __amiq_dvcon_tb_dynamic_constraint

class amiq_dvcon_tb_dynamic_constraint extends amiq_ectb_object;
	`uvm_object_utils(amiq_dvcon_tb_dynamic_constraint)

	int nof_intervals;
	int range_start[];
	int range_end[];
	int range_weight[];

	localparam int max_int = 2**31-1;

	// new - constructor
	function new(string name = "amiq_dvcon_tb_dynamic_constraint");
		super.new(name);
	endfunction : new

	virtual function void register_all_vars();
		super.register_all_vars();
		nof_intervals = int_reg("nof_intervals", 10);

		range_start = new[nof_intervals];
		range_end = new[nof_intervals];
		range_weight = new[nof_intervals];

		foreach(range_start[i])
			range_start[i] = int_reg($sformatf("range_start_%0d", i),  i * (max_int / nof_intervals));
		foreach(range_end[i])
			range_end[i] = int_reg($sformatf("range_end_%0d", i),  (i + 1) * (max_int / nof_intervals)  -1);
		foreach(range_weight[i])
			range_weight[i] = int_reg($sformatf("range_weight_%0d", i), (100 / nof_intervals));

	endfunction : register_all_vars

	virtual function int get_random_value();
		int value_in_weight_range;
		int weight_index;
		int random_value;

		value_in_weight_range = get_value_in_weight_range();
		weight_index = get_weight_index(value_in_weight_range);

		if(!std::randomize(random_value) with {random_value >= range_start[weight_index] && random_value <= range_end[weight_index];})
			`uvm_fatal("AMIQ_DVCON_DYNAMIC_CONTRAINT_RANDOMIZATION_FTL","Could not randomize random_value")

		return random_value;

	endfunction

	virtual function int get_value_in_weight_range();
		int sum_weights;
		int random_value_in_weight_range;
		sum_weights = range_weight.sum();

		if(!std::randomize(random_value_in_weight_range) with {random_value_in_weight_range >= 0 && random_value_in_weight_range < sum_weights;})
			`uvm_fatal("AMIQ_DVCON_DYNAMIC_CONTRAINT_RANDOMIZATION_FTL","Could not randomize random_value_in_weight_range")

		return random_value_in_weight_range;

	endfunction

	virtual function int get_weight_index(int val);
		int sum = 0;
		foreach(range_weight[i]) begin
			sum = sum + range_weight[i];
			if(sum > val)
				return i;
		end
	endfunction

endclass

`endif