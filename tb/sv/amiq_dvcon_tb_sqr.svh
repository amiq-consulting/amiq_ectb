/******************************************************************************
 * DVT CODE TEMPLATE: sqr
 * Created by andvin on Aug 30, 2022
 * uvc_company = amiq, uvc_name = dvcon_tb
 *******************************************************************************/

`ifndef IFNDEF_GUARD_amiq_dvcon_tb_sqr
`define IFNDEF_GUARD_amiq_dvcon_tb_sqr

//------------------------------------------------------------------------------
//
// CLASS: amiq_dvcon_tb_sqr
//
//------------------------------------------------------------------------------

class amiq_dvcon_tb_sqr extends uvm_sequencer;
    
    `uvm_component_utils(amiq_dvcon_tb_sqr)
    
    // Red agents
    uvm_sequencer red_agent_sequencer[2];
    uvm_sequencer blue_agent_sequencer[1];
    uvm_sequencer purple_agent_sequencer[3];

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction : new

endclass : amiq_dvcon_tb_sqr

`endif // IFNDEF_GUARD_amiq_dvcon_tb_sqr
