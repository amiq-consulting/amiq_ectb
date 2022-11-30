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

	parameter nof_intervals = 10;

	int red_pkt_nr;
	int red_agent_id;
	int red_field0_start[nof_intervals];
	int red_field0_end[nof_intervals];
	int red_field0_weight[nof_intervals];
	int red_field1_start[nof_intervals];
	int red_field1_end[nof_intervals];
	int red_field1_weight[nof_intervals];
	int red_field2_start[nof_intervals];
	int red_field2_end[nof_intervals];
	int red_field2_weight[nof_intervals];

	int blue_pkt_nr;
	int blue_agent_id;
	int blue_field0_start[nof_intervals];
	int blue_field0_end[nof_intervals];
	int blue_field0_weight[nof_intervals];
	int blue_field1_start[nof_intervals];
	int blue_field1_end[nof_intervals];
	int blue_field1_weight[nof_intervals];
	int blue_field2_start[nof_intervals];
	int blue_field2_end[nof_intervals];
	int blue_field2_weight[nof_intervals];


	int purple_pkt_nr;
	int purple_agent_id;
	int purple_field0_start[nof_intervals];
	int purple_field0_end[nof_intervals];
	int purple_field0_weight[nof_intervals];
	int purple_field1_start[nof_intervals];
	int purple_field1_end[nof_intervals];
	int purple_field1_weight[nof_intervals];
	int purple_field2_start[nof_intervals];
	int purple_field2_end[nof_intervals];
	int purple_field2_weight[nof_intervals];


	static int red_item_cnt;
	static int blue_item_cnt;
	static int purple_item_cnt;

	localparam int max_int = 2**31-1;

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
		red_pkt_nr = int_reg("red_pkt_nr");
		red_agent_id = int_reg("red_agent_id");

		blue_pkt_nr = int_reg("blue_pkt_nr");
		blue_agent_id = int_reg("blue_agent_id");

		purple_pkt_nr = int_reg("purple_pkt_nr");
		purple_agent_id = int_reg("purple_agent_id");

		foreach(red_field0_start[i])
			red_field0_start[i] = int_reg($sformatf("red_field0_start_%0d", i),  i * (max_int / nof_intervals));
		foreach(red_field0_end[i])
			red_field0_end[i] = int_reg($sformatf("red_field0_end_%0d", i),  (i + 1) * (max_int / nof_intervals)  -1);
		foreach(red_field0_weight[i])
			red_field0_weight[i] = int_reg($sformatf("red_field0_weight_%0d", i), (100 / nof_intervals));

		foreach(red_field1_start[i])
			red_field1_start[i] = int_reg($sformatf("red_field1_start_%0d", i),  i * (max_int / nof_intervals));
		foreach(red_field1_end[i])
			red_field1_end[i] = int_reg($sformatf("red_field1_end_%0d", i),  (i + 1) * (max_int / nof_intervals)  -1);
		foreach(red_field1_weight[i])
			red_field1_weight[i] = int_reg($sformatf("red_field1_weight_%0d", i), ( 100 / nof_intervals));

		foreach(red_field2_start[i])
			red_field2_start[i] = int_reg($sformatf("red_field2_start_%0d", i),  i * (max_int / nof_intervals));
		foreach(red_field2_end[i])
			red_field2_end[i] = int_reg($sformatf("red_field2_end_%0d", i),  (i + 1) * (max_int / nof_intervals)  -1);
		foreach(red_field2_weight[i])
			red_field2_weight[i] = int_reg($sformatf("red_field2_weight_%0d", i), ( 100 / nof_intervals));


		foreach(blue_field0_start[i])
			blue_field0_start[i] = int_reg($sformatf("blue_field0_start_%0d", i),  i * (max_int / nof_intervals));
		foreach(blue_field0_end[i])
			blue_field0_end[i] = int_reg($sformatf("blue_field0_end_%0d", i),  (i + 1) * (max_int / nof_intervals)  -1);
		foreach(blue_field0_weight[i])
			blue_field0_weight[i] = int_reg($sformatf("blue_field0_weight_%0d", i), ( 100 / nof_intervals));

		foreach(blue_field1_start[i])
			blue_field1_start[i] = int_reg($sformatf("blue_field1_start_%0d", i),  i * (max_int / nof_intervals));
		foreach(blue_field1_end[i])
			blue_field1_end[i] = int_reg($sformatf("blue_field1_end_%0d", i),  (i + 1) * (max_int / nof_intervals)  -1);
		foreach(blue_field1_weight[i])
			blue_field1_weight[i] = int_reg($sformatf("blue_field1_weight_%0d", i), ( 100 / nof_intervals));

		foreach(blue_field2_start[i])
			blue_field2_start[i] = int_reg($sformatf("blue_field2_start_%0d", i),  i * (max_int / nof_intervals));
		foreach(blue_field2_end[i])
			blue_field2_end[i] = int_reg($sformatf("blue_field2_end_%0d", i),  (i + 1) * (max_int / nof_intervals)  -1);
		foreach(blue_field2_weight[i])
			blue_field2_weight[i] = int_reg($sformatf("blue_field2_weight_%0d", i), ( 100 / nof_intervals));


		foreach(purple_field0_start[i])
			purple_field0_start[i] = int_reg($sformatf("purple_field0_start_%0d", i),  i * (max_int / nof_intervals));
		foreach(purple_field0_end[i])
			purple_field0_end[i] = int_reg($sformatf("purple_field0_end_%0d", i),  (i + 1) * (max_int / nof_intervals)  -1);
		foreach(purple_field0_weight[i])
			purple_field0_weight[i] = int_reg($sformatf("purple_field0_weight_%0d", i), ( 100 / nof_intervals));

		foreach(purple_field1_start[i])
			purple_field1_start[i] = int_reg($sformatf("purple_field1_start_%0d", i),  i * (max_int / nof_intervals));
		foreach(purple_field1_end[i])
			purple_field1_end[i] = int_reg($sformatf("purple_field1_end_%0d", i),  (i + 1) * (max_int / nof_intervals)  -1);
		foreach(purple_field1_weight[i])
			purple_field1_weight[i] = int_reg($sformatf("purple_field1_weight_%0d", i), ( 100 / nof_intervals));

		foreach(purple_field2_start[i])
			purple_field2_start[i] = int_reg($sformatf("purple_field2_start_%0d", i),  i * (max_int / nof_intervals));
		foreach(purple_field2_end[i])
			purple_field2_end[i] = int_reg($sformatf("purple_field2_end_%0d", i),  (i + 1) * (max_int / nof_intervals)  -1);
		foreach(purple_field2_weight[i])
			purple_field2_weight[i] = int_reg($sformatf("purple_field2_weight_%0d", i), ( 100 / nof_intervals));

	endfunction : register_all_vars

	task drive_red_packet();
		amiq_dvcon_tb_vip_red_item red_item;

		red_item = amiq_dvcon_tb_vip_red_item::type_id::create($sformatf("red_item%0d", red_item_cnt));
		`uvm_do_on_with(red_item, p_sequencer.red_agent_sequencer[red_agent_id], {
				field0 dist {
					[red_field0_start[0] : red_field0_end[0]] :/ red_field0_weight[0],
					[red_field0_start[1] : red_field0_end[1]] :/ red_field0_weight[1],
					[red_field0_start[2] : red_field0_end[2]] :/ red_field0_weight[2],
					[red_field0_start[3] : red_field0_end[3]] :/ red_field0_weight[3],
					[red_field0_start[4] : red_field0_end[4]] :/ red_field0_weight[4],
					[red_field0_start[5] : red_field0_end[5]] :/ red_field0_weight[5],
					[red_field0_start[6] : red_field0_end[6]] :/ red_field0_weight[6],
					[red_field0_start[7] : red_field0_end[7]] :/ red_field0_weight[7],
					[red_field0_start[8] : red_field0_end[8]] :/ red_field0_weight[8],
					[red_field0_start[9] : red_field0_end[9]] :/ red_field0_weight[9]
				};

				field1 dist {
					[red_field1_start[0] : red_field1_end[0]] :/ red_field1_weight[0],
					[red_field1_start[1] : red_field1_end[1]] :/ red_field1_weight[1],
					[red_field1_start[2] : red_field1_end[2]] :/ red_field1_weight[2],
					[red_field1_start[3] : red_field1_end[3]] :/ red_field1_weight[3],
					[red_field1_start[4] : red_field1_end[4]] :/ red_field1_weight[4],
					[red_field1_start[5] : red_field1_end[5]] :/ red_field1_weight[5],
					[red_field1_start[6] : red_field1_end[6]] :/ red_field1_weight[6],
					[red_field1_start[7] : red_field1_end[7]] :/ red_field1_weight[7],
					[red_field1_start[8] : red_field1_end[8]] :/ red_field1_weight[8],
					[red_field1_start[9] : red_field1_end[9]] :/ red_field1_weight[9]
				};

				field2 dist {
					[red_field2_start[0] : red_field2_end[0]] :/ red_field2_weight[0],
					[red_field2_start[1] : red_field2_end[1]] :/ red_field2_weight[1],
					[red_field2_start[2] : red_field2_end[2]] :/ red_field2_weight[2],
					[red_field2_start[3] : red_field2_end[3]] :/ red_field2_weight[3],
					[red_field2_start[4] : red_field2_end[4]] :/ red_field2_weight[4],
					[red_field2_start[5] : red_field2_end[5]] :/ red_field2_weight[5],
					[red_field2_start[6] : red_field2_end[6]] :/ red_field2_weight[6],
					[red_field2_start[7] : red_field2_end[7]] :/ red_field2_weight[7],
					[red_field2_start[8] : red_field2_end[8]] :/ red_field2_weight[8],
					[red_field2_start[9] : red_field2_end[9]] :/ red_field2_weight[9]
				};
			})

		red_item_cnt++;
	endtask

	task drive_blue_packet();
		amiq_dvcon_tb_vip_blue_item blue_item;

		blue_item = amiq_dvcon_tb_vip_blue_item::type_id::create($sformatf("blue_item%0d", blue_item_cnt));
		`uvm_do_on_with(blue_item, p_sequencer.blue_agent_sequencer[blue_agent_id], {
				field0 dist {
					[blue_field0_start[0] : blue_field0_end[0]] :/ blue_field0_weight[0],
					[blue_field0_start[1] : blue_field0_end[1]] :/ blue_field0_weight[1],
					[blue_field0_start[2] : blue_field0_end[2]] :/ blue_field0_weight[2],
					[blue_field0_start[3] : blue_field0_end[3]] :/ blue_field0_weight[3],
					[blue_field0_start[4] : blue_field0_end[4]] :/ blue_field0_weight[4],
					[blue_field0_start[5] : blue_field0_end[5]] :/ blue_field0_weight[5],
					[blue_field0_start[6] : blue_field0_end[6]] :/ blue_field0_weight[6],
					[blue_field0_start[7] : blue_field0_end[7]] :/ blue_field0_weight[7],
					[blue_field0_start[8] : blue_field0_end[8]] :/ blue_field0_weight[8],
					[blue_field0_start[9] : blue_field0_end[9]] :/ blue_field0_weight[9]
				};

				field1 dist {
					[blue_field1_start[0] : blue_field1_end[0]] :/ blue_field1_weight[0],
					[blue_field1_start[1] : blue_field1_end[1]] :/ blue_field1_weight[1],
					[blue_field1_start[2] : blue_field1_end[2]] :/ blue_field1_weight[2],
					[blue_field1_start[3] : blue_field1_end[3]] :/ blue_field1_weight[3],
					[blue_field1_start[4] : blue_field1_end[4]] :/ blue_field1_weight[4],
					[blue_field1_start[5] : blue_field1_end[5]] :/ blue_field1_weight[5],
					[blue_field1_start[6] : blue_field1_end[6]] :/ blue_field1_weight[6],
					[blue_field1_start[7] : blue_field1_end[7]] :/ blue_field1_weight[7],
					[blue_field1_start[8] : blue_field1_end[8]] :/ blue_field1_weight[8],
					[blue_field1_start[9] : blue_field1_end[9]] :/ blue_field1_weight[9]
				};

				field2 dist {
					[blue_field2_start[0] : blue_field2_end[0]] :/ blue_field2_weight[0],
					[blue_field2_start[1] : blue_field2_end[1]] :/ blue_field2_weight[1],
					[blue_field2_start[2] : blue_field2_end[2]] :/ blue_field2_weight[2],
					[blue_field2_start[3] : blue_field2_end[3]] :/ blue_field2_weight[3],
					[blue_field2_start[4] : blue_field2_end[4]] :/ blue_field2_weight[4],
					[blue_field2_start[5] : blue_field2_end[5]] :/ blue_field2_weight[5],
					[blue_field2_start[6] : blue_field2_end[6]] :/ blue_field2_weight[6],
					[blue_field2_start[7] : blue_field2_end[7]] :/ blue_field2_weight[7],
					[blue_field2_start[8] : blue_field2_end[8]] :/ blue_field2_weight[8],
					[blue_field2_start[9] : blue_field2_end[9]] :/ blue_field2_weight[9]
				};
			})

		blue_item_cnt++;
	endtask

	task drive_purple_packet();
		amiq_dvcon_tb_vip_purple_item purple_item;

		purple_item = amiq_dvcon_tb_vip_purple_item::type_id::create($sformatf("purple_item%0d", purple_item_cnt));
		`uvm_do_on_with(purple_item, p_sequencer.purple_agent_sequencer[purple_agent_id], {
				field0 dist {
					[purple_field0_start[0] : purple_field0_end[0]] :/ purple_field0_weight[0],
					[purple_field0_start[1] : purple_field0_end[1]] :/ purple_field0_weight[1],
					[purple_field0_start[2] : purple_field0_end[2]] :/ purple_field0_weight[2],
					[purple_field0_start[3] : purple_field0_end[3]] :/ purple_field0_weight[3],
					[purple_field0_start[4] : purple_field0_end[4]] :/ purple_field0_weight[4],
					[purple_field0_start[5] : purple_field0_end[5]] :/ purple_field0_weight[5],
					[purple_field0_start[6] : purple_field0_end[6]] :/ purple_field0_weight[6],
					[purple_field0_start[7] : purple_field0_end[7]] :/ purple_field0_weight[7],
					[purple_field0_start[8] : purple_field0_end[8]] :/ purple_field0_weight[8],
					[purple_field0_start[9] : purple_field0_end[9]] :/ purple_field0_weight[9]
				};

				field1 dist {
					[purple_field1_start[0] : purple_field1_end[0]] :/ purple_field1_weight[0],
					[purple_field1_start[1] : purple_field1_end[1]] :/ purple_field1_weight[1],
					[purple_field1_start[2] : purple_field1_end[2]] :/ purple_field1_weight[2],
					[purple_field1_start[3] : purple_field1_end[3]] :/ purple_field1_weight[3],
					[purple_field1_start[4] : purple_field1_end[4]] :/ purple_field1_weight[4],
					[purple_field1_start[5] : purple_field1_end[5]] :/ purple_field1_weight[5],
					[purple_field1_start[6] : purple_field1_end[6]] :/ purple_field1_weight[6],
					[purple_field1_start[7] : purple_field1_end[7]] :/ purple_field1_weight[7],
					[purple_field1_start[8] : purple_field1_end[8]] :/ purple_field1_weight[8],
					[purple_field1_start[9] : purple_field1_end[9]] :/ purple_field1_weight[9]
				};

				field2 dist {
					[purple_field2_start[0] : purple_field2_end[0]] :/ purple_field2_weight[0],
					[purple_field2_start[1] : purple_field2_end[1]] :/ purple_field2_weight[1],
					[purple_field2_start[2] : purple_field2_end[2]] :/ purple_field2_weight[2],
					[purple_field2_start[3] : purple_field2_end[3]] :/ purple_field2_weight[3],
					[purple_field2_start[4] : purple_field2_end[4]] :/ purple_field2_weight[4],
					[purple_field2_start[5] : purple_field2_end[5]] :/ purple_field2_weight[5],
					[purple_field2_start[6] : purple_field2_end[6]] :/ purple_field2_weight[6],
					[purple_field2_start[7] : purple_field2_end[7]] :/ purple_field2_weight[7],
					[purple_field2_start[8] : purple_field2_end[8]] :/ purple_field2_weight[8],
					[purple_field2_start[9] : purple_field2_end[9]] :/ purple_field2_weight[9]
				};
			})

		purple_item_cnt++;
	endtask

endclass : amiq_dvcon_tb_seq0

`endif // __amiq_dvcon_tb_seq0



