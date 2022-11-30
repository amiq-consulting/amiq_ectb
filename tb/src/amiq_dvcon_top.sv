/******************************************************************************
 * (C) Copyright 2022 AMIQ All Rights Reserved
 *
 * MODULE:    amiq_dvcon_top
 * DEVICE:
 * PROJECT:
 * AUTHOR:    andvin
 * DATE:      2022 5:28:25 PM
 *
 * ABSTRACT:  You can customize the file content from Window -> Preferences -> DVT -> Code Templates -> "verilog File"
 *
 *******************************************************************************/

// Top module of the Self-TB
module amiq_dvcon_top;

    // Import the UVM package
    import uvm_pkg::*;
    import amiq_dvcon_tb_tc_pkg::*;

    // Clock and reset signals
    reg clock;
    reg reset;

    amiq_dvcon_tb_vip_red_if red_agent0_if();
    amiq_dvcon_tb_vip_red_if red_agent1_if();
    amiq_dvcon_tb_vip_blue_if blue_agent_if();
    amiq_dvcon_tb_vip_purple_if purple_agent0_if();
    amiq_dvcon_tb_vip_purple_if purple_agent1_if();
    amiq_dvcon_tb_vip_purple_if purple_agent2_if();

    virtual interface amiq_dvcon_tb_vip_red_if red_agent0_vif = red_agent0_if;
    virtual interface amiq_dvcon_tb_vip_red_if red_agent1_vif = red_agent1_if;
    virtual interface amiq_dvcon_tb_vip_blue_if blue_agent_vif = blue_agent_if;
    virtual interface amiq_dvcon_tb_vip_purple_if purple_agent0_vif = purple_agent0_if;
    virtual interface amiq_dvcon_tb_vip_purple_if purple_agent1_vif = purple_agent1_if;
    virtual interface amiq_dvcon_tb_vip_purple_if purple_agent2_vif = purple_agent2_if;

    initial begin
        uvm_config_db#(virtual amiq_dvcon_tb_vip_red_if)::set(null,    "*red_agent_0*", "m_vif", red_agent0_vif);
        uvm_config_db#(virtual amiq_dvcon_tb_vip_red_if)::set(null,    "*red_agent_1*", "m_vif", red_agent1_vif);
        uvm_config_db#(virtual amiq_dvcon_tb_vip_blue_if)::set(null,   "*blue_agent*", "m_vif", blue_agent_vif);
        uvm_config_db#(virtual amiq_dvcon_tb_vip_purple_if)::set(null, "*purple_agent_0*", "m_vif", purple_agent0_vif);
        uvm_config_db#(virtual amiq_dvcon_tb_vip_purple_if)::set(null, "*purple_agent_1*", "m_vif", purple_agent1_vif);
        uvm_config_db#(virtual amiq_dvcon_tb_vip_purple_if)::set(null, "*purple_agent_2*", "m_vif", purple_agent2_vif);
    end

    initial begin
        run_test();
    end

    assign red_agent0_if.clk = clock;
    assign red_agent0_if.rst = reset;
    
    assign red_agent1_if.clk = clock;
    assign red_agent1_if.rst = reset;
    
    assign blue_agent_if.clk = clock;
    assign blue_agent_if.rst = reset;
    
    assign purple_agent0_if.clk = clock;
    assign purple_agent0_if.rst = reset;
    
    assign purple_agent1_if.clk = clock;
    assign purple_agent1_if.rst = reset;
    
    assign purple_agent2_if.clk = clock;
    assign purple_agent2_if.rst = reset;
    
    // Generate clock
    always
        #5 clock=~clock;

    // Generate reset
    initial begin
        reset <= 1'b1;
        clock <= 1'b1;
        #21 reset <= 1'b0;
        #51 reset <= 1'b1;
    end
endmodule
