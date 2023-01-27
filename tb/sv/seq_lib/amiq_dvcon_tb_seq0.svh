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

`ifndef __amiq_dvcon_tb_seq0
`define __amiq_dvcon_tb_seq0

class amiq_dvcon_tb_seq0 extends amiq_ectb_sequence;

	`uvm_object_utils(amiq_dvcon_tb_seq0)
	`uvm_declare_p_sequencer(amiq_dvcon_tb_sqr)

	parameter nof_intervals = 11;

	int red_pkt_nr;
	int red_agent_id;
	amiq_dvcon_tb_dynamic_constraint red_field0_constraints;
	amiq_dvcon_tb_dynamic_constraint red_field1_constraints;
	amiq_dvcon_tb_dynamic_constraint red_field2_constraints;

	int blue_pkt_nr;
	int blue_agent_id;
	amiq_dvcon_tb_dynamic_constraint blue_field0_constraints;
	amiq_dvcon_tb_dynamic_constraint blue_field1_constraints;
	amiq_dvcon_tb_dynamic_constraint blue_field2_constraints;

	int purple_pkt_nr;
	int purple_agent_id;
	amiq_dvcon_tb_dynamic_constraint purple_field0_constraints;
	amiq_dvcon_tb_dynamic_constraint purple_field1_constraints;
	amiq_dvcon_tb_dynamic_constraint purple_field2_constraints;


	static int red_item_cnt;
	static int blue_item_cnt;
	static int purple_item_cnt;

	// new - constructor
	function new(string name = "amiq_dvcon_tb_seq0");
		super.new(name);
		
	endfunction : new

	// Sequence body
	virtual task body();

		fork
			repeat(red_pkt_nr) begin
				drive_red_packet();
			end

          repeat(blue_pkt_nr) begin
              drive_blue_packet();
          end

          repeat(purple_pkt_nr) begin
              drive_purple_packet();
          end
		join

	endtask

	virtual function void register_all_vars();
		super.register_all_vars();
		
		red_pkt_nr 		= int_reg("red_pkt_nr", 10000);
		red_agent_id 	= int_reg("red_agent_id", 0);

		red_field0_constraints = amiq_dvcon_tb_dynamic_constraint::type_id::create($sformatf("red_field0_constraints"));
		red_field1_constraints = amiq_dvcon_tb_dynamic_constraint::type_id::create($sformatf("red_field1_constraints"));
		red_field2_constraints = amiq_dvcon_tb_dynamic_constraint::type_id::create($sformatf("red_field2_constraints"));
		red_field0_constraints.register_all_vars();
		red_field1_constraints.register_all_vars();
		red_field2_constraints.register_all_vars();
		
		blue_pkt_nr 	= int_reg("blue_pkt_nr", 10000);
		blue_agent_id 	= int_reg("blue_agent_id", 0);

		blue_field0_constraints = amiq_dvcon_tb_dynamic_constraint::type_id::create($sformatf("blue_field0_constraints"));
		blue_field1_constraints = amiq_dvcon_tb_dynamic_constraint::type_id::create($sformatf("blue_field1_constraints"));
		blue_field2_constraints = amiq_dvcon_tb_dynamic_constraint::type_id::create($sformatf("blue_field2_constraints"));
		blue_field0_constraints.register_all_vars();
		blue_field1_constraints.register_all_vars();
		blue_field2_constraints.register_all_vars();
		
		purple_pkt_nr 		= int_reg("purple_pkt_nr", 10000);
		purple_agent_id 	= int_reg("purple_agent_id", 0);

		purple_field0_constraints = amiq_dvcon_tb_dynamic_constraint::type_id::create($sformatf("purple_field0_constraints"));
		purple_field1_constraints = amiq_dvcon_tb_dynamic_constraint::type_id::create($sformatf("purple_field1_constraints"));
		purple_field2_constraints = amiq_dvcon_tb_dynamic_constraint::type_id::create($sformatf("purple_field2_constraints"));
		purple_field0_constraints.register_all_vars();
		purple_field1_constraints.register_all_vars();
		purple_field2_constraints.register_all_vars();

	endfunction : register_all_vars

	task drive_red_packet();
		amiq_dvcon_tb_vip_red_item red_item;
		int random_red_field0;
		int random_red_field1;
		int random_red_field2;

		red_item = amiq_dvcon_tb_vip_red_item::type_id::create($sformatf("red_item%0d", red_item_cnt));

		random_red_field0 = red_field0_constraints.get_random_value();
		random_red_field1 = red_field1_constraints.get_random_value();
		random_red_field2 = red_field2_constraints.get_random_value();

		`uvm_do_on_with(red_item, p_sequencer.red_agent_sequencers[red_agent_id], {
				field0 == random_red_field0;
				field1 == random_red_field1;
				field2 == random_red_field2;
			})

		red_item_cnt++;
	endtask
	
	task drive_blue_packet();
		amiq_dvcon_tb_vip_blue_item blue_item;
		int random_blue_field0;
		int random_blue_field1;
		int random_blue_field2;

		blue_item = amiq_dvcon_tb_vip_blue_item::type_id::create($sformatf("blue_item%0d", blue_item_cnt));

		random_blue_field0 = blue_field0_constraints.get_random_value();
		random_blue_field1 = blue_field1_constraints.get_random_value();
		random_blue_field2 = blue_field2_constraints.get_random_value();

		`uvm_do_on_with(blue_item, p_sequencer.blue_agent_sequencers[blue_agent_id], {
				field0 == random_blue_field0;
				field1 == random_blue_field1;
				field2 == random_blue_field2;
			})

		blue_item_cnt++;
	endtask
	
	task drive_purple_packet();
		amiq_dvcon_tb_vip_purple_item purple_item;
		int random_purple_field0;
		int random_purple_field1;
		int random_purple_field2;

		purple_item = amiq_dvcon_tb_vip_purple_item::type_id::create($sformatf("purple_item%0d", purple_item_cnt));

		random_purple_field0 = purple_field0_constraints.get_random_value();
		random_purple_field1 = purple_field1_constraints.get_random_value();
		random_purple_field2 = purple_field2_constraints.get_random_value();

		`uvm_do_on_with(purple_item, p_sequencer.purple_agent_sequencers[purple_agent_id], {
				field0 == random_purple_field0;
				field1 == random_purple_field1;
				field2 == random_purple_field2;
			})

		purple_item_cnt++;
	endtask
	
endclass


`endif // __amiq_dvcon_tb_seq0



