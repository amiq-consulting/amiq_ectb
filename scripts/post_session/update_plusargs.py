from operator import attrgetter


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



def generate_range_arrays(field_name):
    range_list = []
    ### Generate range for LOW bins
    for i in range (0,5):
        current_range = amiq_dvcon_randomzition_ranges(i, i,  1_00_00, i, field_name)
        range_list.append(current_range)

    ### Generate ranges for MID bins
    for i in range (0,90):
        current_range = amiq_dvcon_randomzition_ranges( (5 + i * 23_860_929), (5 + i * 23_860_929 + 23_860_928),  1_00_00, i + 5, field_name)
        range_list.append(current_range)

    ### Generate range for HIGH bins

    for i in range (0,5):
        current_range = amiq_dvcon_randomzition_ranges(2_147_483_642 + i, 2_147_483_642 + i,  1_00_00, 95 + i, field_name)
        range_list.append(current_range)
    return  range_list

def update_seq_plusargs(coverage_dict, path_to_args):
    red_field_range_arrays = []
    blue_field_range_arrays = []
    purple_field_range_arrays = []

    range_array = generate_range_arrays("red_field0")
    red_field_range_arrays.append(range_array)
    range_array = generate_range_arrays("red_field1")
    red_field_range_arrays.append(range_array)
    range_array = generate_range_arrays("red_field2")
    red_field_range_arrays.append(range_array)

    '''
    range_array = generate_range_arrays("blue_field0")
    blue_field_range_arrays.append(range_array)
    range_array = generate_range_arrays("blue_field1")
    blue_field_range_arrays.append(range_array)
    range_array = generate_range_arrays("blue_field2")
    blue_field_range_arrays.append(range_array)

    range_array = generate_range_arrays("purple_field0")
    purple_field_range_arrays.append(range_array)
    range_array = generate_range_arrays("purple_field1")
    purple_field_range_arrays.append(range_array)
    range_array = generate_range_arrays("purple_field2")
    purple_field_range_arrays.append(range_array)
    '''

    f = open(path_to_args, "w")

    red_cross = "uvm_pkg/uvm_test_top/amiq_dvcon_tb_env/amiq_dvcon_tb_coverage_collector/red0_cg/red_cross/auto/"
    blue_cross = "uvm_pkg/uvm_test_top/amiq_dvcon_tb_env/amiq_dvcon_tb_coverage_collector/blue0_cg/blue_cross/auto/"
    purple_cross = "uvm_pkg/uvm_test_top/amiq_dvcon_tb_env/amiq_dvcon_tb_coverage_collector/purple0_cg/purple_cross/auto/"


    for key in coverage_dict:
        if(coverage_dict[key] != 0):
            if key.find('red_cross') != -1:
                tmp = key.replace(red_cross, "")
                cross_bins = tmp.split(",")     
                for i in range (0,3):
                    if cross_bins[i].find('low') != -1:
                        tmp = cross_bins[i].replace("low[", "")
                        tmp = tmp.replace("]", "")
                        idx = int(tmp);
            
                        red_field_range_arrays[i][int(idx)].probability = red_field_range_arrays[i][int(idx)].probability - 1

                    if cross_bins[i].find('high') != -1:
                        tmp = cross_bins[i].replace("high[", "")
                        tmp = tmp.replace("]", "")
                        idx = int(tmp);
            
                        red_field_range_arrays[i][int(idx) + 95].probability = red_field_range_arrays[i][int(idx) + 95].probability - 1

                    if cross_bins[i].find('med') != -1:
                        tmp = cross_bins[i].replace("med[", "")
                        tmp = tmp.replace("]", "")
                        idx = int(tmp);


    f.write("+seq0=amiq_dvcon_tb_seq0\n")
    f.write("+amiq_dvcon_tb_seq0_0_red_pkt_nr=10\n")
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

