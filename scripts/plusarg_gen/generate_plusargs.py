import openpyxl
import sys
import re

argfile_dir = "./"

def process_excel(tb_structure):
	wb = openpyxl.load_workbook(tb_structure, data_only=True)
	sheets = wb.sheetnames

	for sheet_name in sheets: 
		generate_components = 0; 
		generate_sequences = 0;
		generate_objects = 0;

		sequence_type = ""
		sequence_name = ""

		object_type = ""
		object_name = ""

		print_new_line = 0;
	
		file_path = argfile_dir + re.sub(" ","_", sheet_name) + ".args"

		current_sheet = wb.get_sheet_by_name(sheet_name)
		for row in current_sheet.values:
			if row[1] == "Component Type":
				generate_components = 1
				comp_index = 0;
				file = open(file_path, "w")
				continue
			else:
				if row[0] == "Sequence type":
					generate_sequences = 1
					seq_index = 0;
					file = open(file_path, "w")
					continue
				else:
					if row[1] == "Object Type":
						generate_objects = 1
						obj_index = 0;
						file = open(file_path, "w")
						continue
			if row[0] :
				if(generate_components): 
					file.write("+%s_comp%s=%s\n" %(row[0], comp_index, row[1]))
					if (row[2] and row[3]):
						file.write("+%s_comp%s_name=%s\n" %(row[0], comp_index, row[2]))
						file.write("+%s_comp%s_no=%s\n" %(row[0], comp_index, row[3]))
					else:
						file.write("+%s_comp%s_name=%s\n" %(row[0], comp_index, row[1]))
						file.write("+%s_comp%s_no=1\n" %(row[0], comp_index))
					file.write("\n" )
					comp_index = comp_index + 1
			
			if(generate_sequences):
				if row[0]:
					if(print_new_line): 
						file.write("\n")	
					else: 
						print_new_line = 1
						
					sequence_type = row[0];
					if row[1]:
						sequence_name = row[1]
					#else : //TODO 
						# sequence_name = dict[sequence_type]
					file.write("+seq%d=%s\n" %(seq_index, sequence_type))	
					
					if row[1]:
						file.write("+seq%d_name=%s\n" %(seq_index, sequence_name))	
					if(row[4] == "YES"):
						file.write("+seq%d_p=1\n" %(seq_index))	

					seq_index = seq_index + 1; 
				if (row[2] and row[3]):
					file.write("+%s_%s=%s\n" %(sequence_name, row[2], row[3] ))

			if(generate_objects):
				if row[0]:
					if(print_new_line): 
						file.write("\n")	
					else: 
						print_new_line = 1					
					parent = row[0]
					object_type = row[1];
					if row[2]:
						object_name = row[2]
					file.write("+%s_obj%d=%s\n" %(parent, obj_index, object_type))	
					
					if row[2]:
						file.write("+%s_obj%d_name=%s\n" %(parent, obj_index, object_name))	
					
					obj_index = obj_index + 1; 
				if (row[3]!=None and row[4]!=None):
					file.write("+%s_%s=%s\n" %(object_name, row[3], row[4] ))						

		file.close()


def main(argv):
	for arg in argv:

		print (arg)
	
		process_excel(arg)

if __name__ == "__main__":
	main(sys.argv[1:])
