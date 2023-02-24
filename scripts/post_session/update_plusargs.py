from operator import attrgetter
import os



### Class to generate ranges for a cross between field0, field1 and field2
class amiq_dvcon_randomzition_ranges:
    def __init__(self, start, end, probability, idx, field):
        self.start = start
        self.end = end
        self.probability = probability
        self.field = field
        self.idx = idx
    def print_fields(self, args_file):
        args_file.write("\n+" +self.field + "_constraints_range_start_" + str(self.idx) + "=" + str(self.start))
        args_file.write("\n+" +self.field + "_constraints_range_end_" + str(self.idx) + "=" + str(self.end))
        args_file.write("\n+" +self.field + "_constraints_range_weight_" + str(self.idx) + "=" + str(self.probability))


### Generate the defaut constraints for field0, field1 and field2
### Other functions should use these as a baseline to update the constrains
### Based on the current coverage results
def generate_range_arrays(field_name, default = 1_00_00):
    range_list = []
    ### Generate range for LOW bins
    for i in range (0,5):
        current_range = amiq_dvcon_randomzition_ranges(i, i,  default, i, field_name)
        range_list.append(current_range)

    ### Generate ranges for MID bins
    for i in range (0,90):
        current_range = amiq_dvcon_randomzition_ranges( (5 + i * 23_860_929), (5 + i * 23_860_929 + 23_860_928),  default, i + 5, field_name)
        range_list.append(current_range)

    ### Generate range for HIGH bins

    for i in range (0,5):
        current_range = amiq_dvcon_randomzition_ranges(2_147_483_642 + i, 2_147_483_642 + i,  default, 95 + i, field_name)
        range_list.append(current_range)
    return  range_list


### Print the header for a new .vsif that will be started in the next iteration
def print_vsif_session_info():
    path_generated_vsif = os.environ['PROJ_HOME'] + "/sim/generated_reg.vsif"
    f = open(path_generated_vsif, "w")

    f.write("session generated_dvcon_simple_reg {\n")
    f.write("    top_dir: \"$PROJ_HOME/sim_dir\";\n")
    f.write("    pre_session_script: \"xrun -f $PROJ_HOME/sim/sim_args -c\";\n")
    f.write("    post_session_script: \"$PROJ_HOME/scripts/post_session/post_session.sh\";\n")
    f.write("    queuing_policy: round_robin;\n")
    f.write("};\n\n")

### Print the group header for the next iteration
def print_grp_info():
    path_generated_vsif = os.environ['PROJ_HOME'] + "/sim/generated_reg.vsif"
    f = open(path_generated_vsif, "a")

    f.write("    group dvon_simple_tests {\n")
    f.write("        scan_script : \"vm_scan.pl shell.flt ius.flt ovm_sv_lib.flt vm.flt\";\n")
    f.write("        run_script : \"xrun -f $PROJ_HOME/sim/sim_args $ATTR(top_files) -seed random -svseed random\";\n")
    f.write("        timeout: 600;\n\n")

### Our post-processing functions should generate a new seq_arg files that has the naming convention
### amiq_dvcon_tb_gen_seq_args_<idx>
### For each generated arg file, this function should be called to add the test to the generated .vsif
def print_test_info(idx):
    path_generated_vsif = os.environ['PROJ_HOME'] + "/sim/generated_reg.vsif"
    f = open(path_generated_vsif, "a")

    f.write("        test dvcon_simple_test {\n")
    f.write("            top_files: \"-f $PROJ_HOME/tb/tc/amiq_dvcon_tb_cfg_args \\\n")
    f.write("                        -f $PROJ_HOME/tb/tc/amiq_dvcon_tb_comp_args \\\n")
    f.write("                        -f $PROJ_HOME/tb/tc/amiq_dvcon_tb_gen_seq_args_" + str(idx)  + "\";\n")
    f.write("            count: 1;\n")
    f.write("        };\n\n")

### Add the } to properly end the group
def print_end_grup():
    path_generated_vsif = os.environ['PROJ_HOME'] + "/sim/generated_reg.vsif"
    f = open(path_generated_vsif, "a")

    f.write("};\n")


### Will return the index from the range_array, based on the name of the bin
def get_bin_idx(bin_string):
    offset = 0;

    tmp = bin_string.replace("]", "")
    tmp = tmp.replace("low[", "")
    tmp = tmp.replace("med[", "")
    tmp = tmp.replace("high[", "")

    if bin_string.find('low') != -1:
        offset = 0
    if bin_string.find('med') != -1:
        offset = 5
    if bin_string.find('high') != -1:
        offset = 95
    idx = int(tmp) + offset;
    return idx


### Returns the coverage percentage. It will be used to decide which function to call
### To update the plusargs. 
def get_coverage_percentage(coverage_dict, bin):
    nof_hits = 0
    nof_bins = 0
    for key in coverage_dict:
        if key.find(bin) != -1:
            nof_bins = nof_bins + 1
            if(coverage_dict[key] != 0):
                nof_hits = nof_hits + 1
    return nof_hits/nof_bins*100


### Iterates through all the remaining coverage holes and generates a .vsif
### with all the tests needed to get 100%
def print_all_remaining_tests(coverage_dict):
    range_array = generate_range_arrays("red_cross_structure")

    path_to_args_file = os.environ['PROJ_HOME'] + "/tb/tc/amiq_dvcon_tb_gen_seq_args_" 
    test_id=0

    print_vsif_session_info()
    print_grp_info()


    red_cross = "uvm_pkg/uvm_test_top/amiq_dvcon_tb_env/amiq_dvcon_tb_coverage_collector/red0_cg/red_cross/auto/"
    
    for key in coverage_dict:
        if(coverage_dict[key] == 0):
            if key.find('red_cross') != -1:
                f = open(path_to_args_file + str(test_id), "w")
                print_test_info(test_id)
                test_id = test_id + 1
                
                f.write("+seq0=amiq_dvcon_tb_seq0\n")
                f.write("+amiq_dvcon_tb_seq0_0_red_pkt_nr=10\n")
                f.write("+red_field0_constraints_nof_intervals=1\n")
                f.write("+red_field1_constraints_nof_intervals=1\n")
                f.write("+red_field2_constraints_nof_intervals=1\n\n")


                tmp = key.replace(red_cross, "")
                cross_bins = tmp.split(",")

                for i in range (0,3):
                    bin_idx = get_bin_idx(cross_bins[i]);
                    f.write("+red_field"  + str(i)  +  "_constraints_range_start_0=" +str(range_array[bin_idx].start) + "\n")
                    f.write("+red_field"  + str(i)  + "_constraints_range_end_0=" +str(range_array[bin_idx].end) + "\n")
                    f.write("+red_field"  + str(i)  + "constraints_range_weight_0=100\n\n\n")

                f.close()

    print_end_grup()





### Updates all plusargs probability based on how many bins
### are not hit.
def update_plusargs_for_3xfields(coverage_dict):
    red_field_range_arrays = []
    blue_field_range_arrays = []
    purple_field_range_arrays = []

    range_array = generate_range_arrays("red_field0")
    red_field_range_arrays.append(range_array)
    range_array = generate_range_arrays("red_field1")
    red_field_range_arrays.append(range_array)
    range_array = generate_range_arrays("red_field2")
    red_field_range_arrays.append(range_array)

    os.system('cp -f /home/serdud/Desktop/aux/dvcon/dvcon2022/sim/simple_reg.vsif /home/serdud/Desktop/aux/dvcon/dvcon2022/sim/generated_reg.vsif' )


    path_to_args_file = os.environ['PROJ_HOME'] + "/tb/tc/amiq_dvcon_tb_seq_args" 
    f = open(path_to_args_file, "w")

    red_cross = "uvm_pkg/uvm_test_top/amiq_dvcon_tb_env/amiq_dvcon_tb_coverage_collector/red0_cg/red_cross/auto/"
    
    for key in coverage_dict:
        if(coverage_dict[key] != 0):
            if key.find('red_cross') != -1:
                tmp = key.replace(red_cross, "")
                cross_bins = tmp.split(",")     
                for i in range (0,3):
                    bin_idx = get_bin_idx(cross_bins[i]);
                    red_field_range_arrays[i][bin_idx].probability = red_field_range_arrays[i][bin_idx].probability - 1
                  


    f.write("+seq0=amiq_dvcon_tb_seq0\n")
    f.write("+amiq_dvcon_tb_seq0_0_red_pkt_nr=\n")
    f.write("+red_field0_constraints_nof_intervals=100\n")
    f.write("+red_field1_constraints_nof_intervals=100\n")
    f.write("+red_field2_constraints_nof_intervals=100\n")

    ### TODO for Blue and Purple

    f.write("\n\n\n")

    for i in range (0,3):
        sorted_array = sorted(red_field_range_arrays[i], key=attrgetter('probability'))
        for j in range(90,100):
            sorted_array[j].probability = sorted_array[j].probability * 5
        for ranges in sorted_array:
            ranges.print_fields(f)

        
    f.close()



### Similar to the previous function, but field0 will have a weighet probability
### where the least hit 5 values will have a 90% chance to be fit, while the rest
### Will have a smaller chance
def update_plusargs_for_2xfields(coverage_dict):
    red_field_range_arrays = []
    blue_field_range_arrays = []
    purple_field_range_arrays = []

    range_array = generate_range_arrays("red_field0")
    red_field_range_arrays.append(range_array)
    range_array = generate_range_arrays("red_field1")
    red_field_range_arrays.append(range_array)
    range_array = generate_range_arrays("red_field2")
    red_field_range_arrays.append(range_array)

    print_vsif_session_info()
    print_grp_info()
    

    red_cross = "uvm_pkg/uvm_test_top/amiq_dvcon_tb_env/amiq_dvcon_tb_coverage_collector/red0_cg/red_cross/auto/"
    
    for key in coverage_dict:
        if(coverage_dict[key] != 0):
            if key.find('red_cross') != -1:
                tmp = key.replace(red_cross, "")
                cross_bins = tmp.split(",")     

                for i in range (0,3):
                    bin_idx = get_bin_idx(cross_bins[i]);
                    red_field_range_arrays[i][bin_idx].probability = red_field_range_arrays[i][bin_idx].probability - 1
                    
    
    for test_no in range (0,5):
        print_test_info(test_no)
        path_to_args_file = os.environ['PROJ_HOME'] + "/tb/tc/amiq_dvcon_tb_gen_seq_args_" +str(test_no)
        f = open(path_to_args_file, "w")
        sorted_array = sorted(red_field_range_arrays[0], key=attrgetter('probability'))

        for i in range (0,100):
            red_field_range_arrays[0][i].probability = 1;
        red_field_range_arrays[0][99 - test_no].probability = 910;


        f.write("+seq0=amiq_dvcon_tb_seq0\n")
        f.write("+amiq_dvcon_tb_seq0_0_red_pkt_nr=20000\n")
        f.write("+red_field0_constraints_nof_intervals=100\n")
        f.write("+red_field1_constraints_nof_intervals=100\n")
        f.write("+red_field2_constraints_nof_intervals=100\n")

        f.write("\n\n\n")

        for i in range (0,3):
            for ranges in red_field_range_arrays[i]:
                ranges.print_fields(f)

        
        f.close()
    print_end_grup()

### Similar to the previous function, but field0 and field1 will have a weighet probability
### where the least hit 5 values wi
def update_plusargs_for_1xfields(coverage_dict):
    red_field_range_arrays = []
    blue_field_range_arrays = []
    purple_field_range_arrays = []

    range_array = generate_range_arrays("red_field0")
    red_field_range_arrays.append(range_array)
    range_array = generate_range_arrays("red_field1")
    red_field_range_arrays.append(range_array)
    range_array = generate_range_arrays("red_field2")
    red_field_range_arrays.append(range_array)

    print_vsif_session_info()
    print_grp_info()
    
    red_cross = "uvm_pkg/uvm_test_top/amiq_dvcon_tb_env/amiq_dvcon_tb_coverage_collector/red0_cg/red_cross/auto/"
    
    for key in coverage_dict:
        if(coverage_dict[key] != 0):
            if key.find('red_cross') != -1:
                tmp = key.replace(red_cross, "")
                cross_bins = tmp.split(",")     

                for i in range (0,3):
                    bin_idx = get_bin_idx(cross_bins[i]);
                    red_field_range_arrays[i][bin_idx].probability = red_field_range_arrays[i][bin_idx].probability - 1
                        

    for test_no in range (0,5):
        print_test_info(test_no)
        path_to_args_file = os.environ['PROJ_HOME'] + "/tb/tc/amiq_dvcon_tb_gen_seq_args_" +str(test_no)
        f = open(path_to_args_file, "w")


        sorted_array = sorted(red_field_range_arrays[0], key=attrgetter('probability'))

        for i in range (0,100):
            red_field_range_arrays[0][i].probability = 1;
        red_field_range_arrays[0][99 - test_no].probability = 910;

        sorted_array = sorted(red_field_range_arrays[1], key=attrgetter('probability'))

        for i in range (0,100):
            red_field_range_arrays[1][i].probability = 1;
        red_field_range_arrays[1][99 - test_no].probability = 910;


        f.write("+seq0=amiq_dvcon_tb_seq0\n")
        f.write("+amiq_dvcon_tb_seq0_0_red_pkt_nr=500\n")
        f.write("+red_field0_constraints_nof_intervals=100\n")
        f.write("+red_field1_constraints_nof_intervals=100\n")
        f.write("+red_field2_constraints_nof_intervals=100\n")

        f.write("\n\n\n")

        for i in range (0,3):
            for ranges in red_field_range_arrays[i]:
                ranges.print_fields(f)

        
        f.close()
    print_end_grup()


### Hook from the post_session script. This must be implemented by the user
### In this particular example we look at the coverage values and decide
### Which of the previously implemeted algorithm will apply
def update_seq_plusargs(coverage_dict, path_to_args):
    cov = get_coverage_percentage(coverage_dict, "red_cross")
    if(cov == 100):
        exit(0)
    if(cov < 80):
        update_plusargs_for_3xfields(coverage_dict)
    else:
        if(cov < 95):
            update_plusargs_for_2xfields(coverage_dict)
        else:
            if(cov < 99):
                update_plusargs_for_1xfields(coverage_dict)
            else:
                print_all_remaining_tests(coverage_dict)


'''    

def update_seq_plusargs(coverage_dict, path_to_args):
    print_all_tests(coverage_dict)

'''
