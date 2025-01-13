virtual function void register_all_vars();
endfunction

function int int_reg(string my_var_name, int default_value=0);
    `uvm_info(get_name(), $sformatf("Registering field"), UVM_NONE)
    my_var_name = {get_name(), "_", my_var_name};
    `uvm_info(get_name(), $sformatf("Looking for var:%s", my_var_name),UVM_NONE)
    if(!$value$plusargs({my_var_name, "=%0d"}, int_reg)) begin
        int_reg = default_value;
    end
    `uvm_info(get_name(), $sformatf("+%s=%0d", my_var_name, int_reg),UVM_NONE)
endfunction

function bit bit_reg(string my_var_name, bit default_value=0);
    `uvm_info(get_name(), $sformatf("Registering field"), UVM_NONE)
    my_var_name = {get_name(), "_", my_var_name};
    `uvm_info(get_name(), $sformatf("Looking for var:%s", my_var_name),UVM_NONE)
    if(!$value$plusargs({my_var_name, "=%0b"}, bit_reg)) begin
        bit_reg = default_value;
    end
    `uvm_info(get_name(), $sformatf("+%s=%0b", my_var_name, bit_reg),UVM_NONE)
    
endfunction

function string string_reg(string my_var_name, string default_value="");
    `uvm_info(get_name(), $sformatf("Registering field"), UVM_NONE)
    my_var_name = {get_name(), "_", my_var_name};
    `uvm_info(get_name(), $sformatf("Looking for var:%s", my_var_name),UVM_NONE)
    if(!$value$plusargs({my_var_name, "=%0s"}, string_reg)) begin
        string_reg = default_value;
	end
    `uvm_info(get_name(), $sformatf("+%s=%s", my_var_name, string_reg),UVM_NONE)
endfunction