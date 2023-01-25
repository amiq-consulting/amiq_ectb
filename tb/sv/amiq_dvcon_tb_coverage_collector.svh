/******************************************************************************
 * DVT CODE TEMPLATE: coverage collector
 * Created by andvin on Aug 9, 2022
 * uvc_company = amiq_dvcon_tb, uvc_name =
 *******************************************************************************/

`ifndef IFNDEF_GUARD_amiq_dvcon_tb__coverage_collector
`define IFNDEF_GUARD_amiq_dvcon_tb__coverage_collector

//------------------------------------------------------------------------------
//
// CLASS: amiq_dvcon_tb__coverage_collector
//
//------------------------------------------------------------------------------

class amiq_dvcon_tb_coverage_collector extends uvm_component;

    // Item collected from the monitor
    protected amiq_dvcon_tb_vip_red_item m_collected_red_item;
    protected amiq_dvcon_tb_vip_blue_item m_collected_blue_item;
    protected amiq_dvcon_tb_vip_purple_item m_collected_purple_item;

    // Using suffix to handle more ports
    `uvm_analysis_imp_decl(_red_collected_item)
    `uvm_analysis_imp_decl(_blue_collected_item)
    `uvm_analysis_imp_decl(_purple_collected_item)

    // Connection to the monitor
    uvm_analysis_imp_red_collected_item#(amiq_dvcon_tb_vip_red_item, amiq_dvcon_tb_coverage_collector) m_red_monitor_port;
    uvm_analysis_imp_blue_collected_item#(amiq_dvcon_tb_vip_blue_item, amiq_dvcon_tb_coverage_collector) m_blue_monitor_port;
    uvm_analysis_imp_purple_collected_item#(amiq_dvcon_tb_vip_purple_item, amiq_dvcon_tb_coverage_collector) m_purple_monitor_port;

    localparam int max_int = 2**31-1;
    

    `uvm_component_utils(amiq_dvcon_tb_coverage_collector)
    
    covergroup red0_cg with function sample(amiq_dvcon_tb_vip_red_item red_item);
        option.auto_bin_max=2048;
	    option.per_instance = 1;
        
        red_field0 : coverpoint red_item.field0 
        {
            bins low[5] = {0, 1, 2, 3, 4};
            bins med[90] = {[5:max_int-6]};
            bins high[5] = {max_int-5, max_int-4, max_int-3, max_int-2, max_int-1};
        }
        
        red_field1 : coverpoint red_item.field1 
        {
            bins low[5] = {0, 1, 2, 3, 4};
            bins med[90] = {[5:max_int-6]};
            bins high[5] = {max_int-5, max_int-4, max_int-3, max_int-2, max_int-1};
        }
        
        red_field2 : coverpoint red_item.field2 
        {
            bins low[5] = {0, 1, 2, 3, 4};
            bins med[90] = {[5:max_int-6]};
            bins high[5] = {max_int-5, max_int-4, max_int-3, max_int-2, max_int-1};
        }
        
        red_cross : cross red_field0, red_field1, red_field2;
        
    endgroup : red0_cg
    
    covergroup blue0_cg with function sample(amiq_dvcon_tb_vip_blue_item blue_item);
        option.auto_bin_max=2048;
	    option.per_instance = 1;
        
        blue_field0 : coverpoint blue_item.field0 
        {
            bins low[5] = {0, 1, 2, 3, 4};
            bins med[10] = {[5:max_int-6]};
            bins high[5] = {max_int-5, max_int-4, max_int-3, max_int-2, max_int-1};
        }
        
        blue_field1 : coverpoint blue_item.field1 
        {
            bins low[5] = {0, 1, 2, 3, 4};
            bins med[10] = {[5:max_int-6]};
            bins high[5] = {max_int-5, max_int-4, max_int-3, max_int-2, max_int-1};
        }
        
        blue_field2 : coverpoint blue_item.field2 
        {
            bins low[5] = {0, 1, 2, 3, 4};
            bins med[10] = {[5:max_int-6]};
            bins high[5] = {max_int-5, max_int-4, max_int-3, max_int-2, max_int-1};
        }
        
        blue_cross : cross blue_field0, blue_field1, blue_field2;
        
    endgroup : blue0_cg
    
    covergroup purple0_cg with function sample(amiq_dvcon_tb_vip_purple_item purple_item);
        option.auto_bin_max=2048;
	    option.per_instance = 1;
        
        purple_field0 : coverpoint purple_item.field0 
        {
            bins low[5] = {0, 1, 2, 3, 4};
            bins med[10] = {[5:max_int-6]};
            bins high[5] = {max_int-5, max_int-4, max_int-3, max_int-2, max_int-1};
        }
        
        purple_field1 : coverpoint purple_item.field1 
        {
            bins low[5] = {0, 1, 2, 3, 4};
            bins med[10] = {[5:max_int-6]};
            bins high[5] = {max_int-5, max_int-4, max_int-3, max_int-2, max_int-1};
        }
        
        purple_field2 : coverpoint purple_item.field2 
        {
            bins low[5] = {0, 1, 2, 3, 4};
            bins med[10] = {[5:max_int-6]};
            bins high[5] = {max_int-5, max_int-4, max_int-3, max_int-2, max_int-1};
        }
        
        purple_cross : cross purple_field0, purple_field1, purple_field2;
        
    endgroup : purple0_cg

//    covergroup field_cross_cg with function sample(amiq_dvcon_tb_vip_red_item red_item, amiq_dvcon_tb_vip_blue_item blue_item, amiq_dvcon_tb_vip_purple_item purple_item);
//        option.per_instance = 1;
//        
//    endgroup : field_cross_cg

    function new(string name, uvm_component parent);
        super.new(name, parent);
        red0_cg=new;
        red0_cg.set_inst_name({get_full_name(), ".red0_cg"});
        blue0_cg=new;
        blue0_cg.set_inst_name({get_full_name(), ".blue0_cg"});
        purple0_cg=new;
        purple0_cg.set_inst_name({get_full_name(), ".purple0_cg"});
//        field_cross_cg=new;
//        field_cross_cg.set_inst_name({get_full_name(), ".field_cross_cg"});
    endfunction : new

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        m_red_monitor_port = new("m_red_monitor_port",this);
        m_blue_monitor_port = new("m_blue_monitor_port",this);
        m_purple_monitor_port = new("m_purple_monitor_port",this);

    endfunction : build_phase

    function void write_red_collected_item(amiq_dvcon_tb_vip_red_item item);
        m_collected_red_item = item;
        red0_cg.sample(m_collected_red_item);
    endfunction : write_red_collected_item
    
    function void write_blue_collected_item(amiq_dvcon_tb_vip_blue_item item);
        m_collected_blue_item = item;
        blue0_cg.sample(m_collected_blue_item);
    endfunction : write_blue_collected_item
    
    function void write_purple_collected_item(amiq_dvcon_tb_vip_purple_item item);
        m_collected_purple_item = item;
        purple0_cg.sample(m_collected_purple_item);
    endfunction : write_purple_collected_item
    
endclass : amiq_dvcon_tb_coverage_collector

`endif // IFNDEF_GUARD_amiq_dvcon_tb__coverage_collector
