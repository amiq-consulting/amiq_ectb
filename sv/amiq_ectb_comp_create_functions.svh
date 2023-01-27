uvm_component components[$];
string component_types[$];
string component_names[$];

function void create_components();
    uvm_factory factory; // Handle to the UVM factory that allows the creation of any object via string
    // Variable used for creating multiple components of the same type
    int cnt;

    // Retrieve the factory
    factory = uvm_factory::get();

    // Creating all of the available components
    foreach(component_types[i]) begin
        uvm_component local_component; // Handle to the current uvm component that is going to be created this 'foreach' iteration

        // Create component
        local_component = factory.create_component_by_name(component_types[i], this.get_full_name(), component_names[i], this);
        components.push_back(local_component);
    end
endfunction

function void push_all_comps();
    int index;
    string comp_type;
    string comp_name;
    string comp_name_with_index;
    int comp_number;

    forever begin

        // Retrieve the components passed as plusargs
        comp_type = retrieve_comp_type(index);

        // If no component name is retrieved, we break the loop
        if(comp_type == "") break;

        // Retrieve the number of agents for the current comp type
        // and add them to the queue
        comp_number = retrieve_comp_number(index);
        
        // Add the component types to the queue according to the "number of" set
        repeat(comp_number)
            component_types.push_back(comp_type);

        // Retrieve the name of the agent
        comp_name = retrieve_comp_name(index);

        // If the component name is not defined, set it to the type name, otherwise use the component name given
        // If there are multiple instances defined on this comp index, then create all of them incrementally 
        // adding incremental "_*index*" at the end
        if(comp_name == "")
            for(int i=0; i<comp_number;i++)
                component_names.push_back(unique_name_check(comp_type, i, (comp_number==1)));
        else
            for(int i=0; i<comp_number;i++)
                component_names.push_back(unique_name_check(comp_name, i, (comp_number==1)));

        // Go to the next index
        index++;
    end
    
endfunction

function string retrieve_comp_type(int index);
    string name_comp_index = $sformatf("%0s_comp%0d", get_name(), index);
    `uvm_info(get_name(), $sformatf("Looking for comp %s", name_comp_index), UVM_DEBUG)
    if(!$value$plusargs({name_comp_index, "=%0s"}, retrieve_comp_type)) retrieve_comp_type = "";
endfunction

function int retrieve_comp_number(int index);
    string name_comp_index_no = $sformatf("%0s_comp%0d_no", get_name(), index);
    `uvm_info(get_name(), $sformatf("Looking for no %s", name_comp_index_no), UVM_DEBUG)
    if(!$value$plusargs({name_comp_index_no, "=%0d"}, retrieve_comp_number)) retrieve_comp_number = 1;
endfunction

function string retrieve_comp_name(int index);
    string name_comp_index_name = $sformatf("%0s_comp%0d_name", get_name(), index);
    `uvm_info(get_name(), $sformatf("Looking for name %s", name_comp_index_name), UVM_DEBUG)
    if(!$value$plusargs({name_comp_index_name, "=%0s"}, retrieve_comp_name)) retrieve_comp_name = "";
endfunction

/**
 * 
 * @param name - Base name of the component
 * @param index - Current index for the component name
 * @param unique_name - Checker if there are multiple components with this name
 * @return Name concatenated with the index if it is not unique, and the same name given as argument if it is unique
 */
function string unique_name_check(string name, int index, bit unique_name);
    if(unique_name)
        unique_name_check = name;
    else
        unique_name_check = $sformatf("%0s_%0d", name, index);
endfunction

