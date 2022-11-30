uvm_object objects[$];
string object_types[$];
string object_names[$];

function void create_objects();
	uvm_factory factory; // Handle to the UVM factory that allows the creation of any object via string
	// Variable used for creating multiple objects of the same type
	int cnt;

	// Retrieve the factory
	factory = uvm_factory::get();

	// Creating all of the available objects
	foreach(object_types[i]) begin
		uvm_object local_object; // Handle to the current uvm object that is going to be created this 'foreach' iteration
		amiq_ectb_object temp_object;

		// Create object
		local_object = factory.create_object_by_name(object_types[i], this.get_full_name(), object_names[i]);
		$cast(temp_object, local_object);
		temp_object.register_all_vars();
		
		objects.push_back(temp_object);
	end
endfunction

function void push_all_objs();
	int index;
	string obj_type;
	string obj_name;
	string obj_name_with_index;
	int obj_number;

	forever begin

		// Retrieve the objects passed as plusargs
		obj_type = retrieve_obj_type(index);

		// If no object name is retrieved, we break the loop
		if(obj_type == "") break;

		// Retrieve the number of agents for the current obj type
		// and add them to the queue
		obj_number = retrieve_obj_number(index);

		// Add the object types to the queue according to the "number of" set
		repeat(obj_number)
			object_types.push_back(obj_type);

		// Retrieve the name of the agent
		obj_name = retrieve_obj_name(index);

		// If the object name is not defined, set it to the type name, otherwise use the object name given
		// If there are multiple instances defined on this obj index, then create all of them incrementally
		// adding incremental "_*index*" at the end
		if(obj_name == "")
			for(int i=0; i<obj_number;i++)
				object_names.push_back(unique_name_check(obj_type, i, (obj_number==1)));
		else
			for(int i=0; i<obj_number;i++)
				object_names.push_back(unique_name_check(obj_name, i, (obj_number==1)));

		// Go to the next index
		index++;
	end

endfunction

function string retrieve_obj_type(int index);
	string name_obj_index = $sformatf("%0s_obj%0d", get_name(), index);
	`uvm_info(get_name(), $sformatf("Looking for obj %s", name_obj_index), UVM_NONE)
	if(!$value$plusargs({name_obj_index, "=%0s"}, retrieve_obj_type)) retrieve_obj_type = "";
endfunction

function int retrieve_obj_number(int index);
	string name_obj_index_no = $sformatf("%0s_obj%0d_no", get_name(), index);
	`uvm_info(get_name(), $sformatf("Looking for no %s", name_obj_index_no), UVM_NONE)
	if(!$value$plusargs({name_obj_index_no, "=%0d"}, retrieve_obj_number)) retrieve_obj_number = 1;
endfunction

function string retrieve_obj_name(int index);
	string name_obj_index_name = $sformatf("%0s_obj%0d_name", get_name(), index);
	`uvm_info(get_name(), $sformatf("Looking for name %s", name_obj_index_name), UVM_NONE)
	if(!$value$plusargs({name_obj_index_name, "=%0s"}, retrieve_obj_name)) retrieve_obj_name = "";
endfunction

