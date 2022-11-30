virtual function void register_all_vars();
endfunction

function int int_reg(string my_var_name, int default_value=0);
    `uvm_info(get_name(), $sformatf("Registering field"), UVM_NONE)
    my_var_name = {get_name(), "_", my_var_name};
    `uvm_info(get_name(), $sformatf("Looking for var:%s", my_var_name),UVM_NONE)
    if(!$value$plusargs({my_var_name, "=%0d"}, int_reg)) begin
        `uvm_info(get_name(), $sformatf("Didn't find the plusarg"),UVM_NONE)
        int_reg = default_value;
    end else begin
        `uvm_info(get_name(), $sformatf("Found the plusarg"),UVM_NONE)
    end
endfunction

function bit bit_reg(string my_var_name, bit default_value=0);
    `uvm_info(get_name(), $sformatf("Registering field"), UVM_NONE)
    my_var_name = {get_name(), "_", my_var_name};
    `uvm_info(get_name(), $sformatf("Looking for var:%s", my_var_name),UVM_NONE)
    if(!$value$plusargs({my_var_name, "=%0b"}, bit_reg)) begin
        `uvm_info(get_name(), $sformatf("Didn't find the plusarg"),UVM_NONE)
        bit_reg = default_value;
    end else begin
        `uvm_info(get_name(), $sformatf("Found the plusarg"),UVM_NONE)
    end
endfunction

function string string_reg(string my_var_name, string default_value="");
    `uvm_info(get_name(), $sformatf("Registering field"), UVM_NONE)
    my_var_name = {get_name(), "_", my_var_name};
    `uvm_info(get_name(), $sformatf("Looking for var:%s", my_var_name),UVM_NONE)
    if(!$value$plusargs({my_var_name, "=%0s"}, string_reg)) begin
        `uvm_info(get_name(), $sformatf("Didn't find the plusarg"),UVM_NONE)
        string_reg = default_value;
    end else begin
        `uvm_info(get_name(), $sformatf("Found the plusarg"),UVM_NONE)
    end
endfunction