# this library provides functions that facilitate the work with paths
from pathlib import Path
import os
import subprocess
import re
import json
import csv
import time

import subprocess
import shlex

from operator import attrgetter

from update_plusargs import *

CL_path = os.environ['PROJ_HOME'] + "/scripts/CL/"
path_to_run_txt = os.environ['PROJ_HOME'] + '/sim/run_no.txt' 
path_to_config_file =  os.environ['PROJ_HOME'] + '/scripts/post_session/post_session.config' 
path_to_args_file = os.environ['PROJ_HOME'] + "/tb/tc/amiq_dvcon_tb_seq_args"

regression_dir = os.getcwd()

coverage_dict = {}
stored_coverage_dict = {}


#### Configurable knobs from post_session.config. 
#### Setting default values
max_iteration = 5;
path_to_vsif = os.environ['PROJ_HOME'] + "/sim/simple_reg.vsif"
path_to_coverage_db =  os.environ['PROJ_HOME'] + '/cov_json/coverage_db.json'


def run_cl_command(ucd):
    cl_command = "cd " +  str(CL_path) + "; " + str(CL_path) + "coverage_lens.sh" +  " -d " + ucd + " -g nof_cvgs > cl_output; cd -; mv  " + str(CL_path) + "cl_output . ; sed -i \'1,2d\' cl_output ;"
    print(cl_command)
    os.system(cl_command)
    
def create_coverage_dict():
    global coverage_dict
    coverage_dict.clear()
    with open('cl_output') as csv_file:
        csv_reader = csv.reader(csv_file, delimiter='|')        
        for row in csv_reader:
            coverage_dict[row[0]] = row[1]

def store_coverage_dict():
    with open(path_to_coverage_db, "w") as cvg_db_f:
        json.dump(coverage_dict,cvg_db_f) 

def load_stored_coverage_dict():
    global stored_coverage_dict
    with open(path_to_coverage_db) as stored_cvg_db_f:
        stored_coverage_dict = json.load(stored_cvg_db_f)
  

def update_coverage_dict():
    global coverage_dict
    for key in coverage_dict:
        coverage_dict[key] = int(coverage_dict[key]) + int(stored_coverage_dict[key])

def update_configurable_fields():
    config_dict = {}
    global max_iteration
    global path_to_vsif
    global path_to_coverage_db
    
    with open(path_to_config_file) as config_f:
        config_dict = json.load(config_f)
    
    max_iteration           = config_dict["max_iteration"]
    path_to_coverage_db     = config_dict["path_to_coverage_db"]
    path_to_vsif            = config_dict["path_to_vsif"]
    

update_configurable_fields()

path = regression_dir + "/dvon_simple_tests/run_*/cov_work/scope/test_sv*/icc_*.ucd"
os.system("ls " + path + " > path_tmp")

with open("path_tmp", "r") as path_tmp:
    for ucd_path in path_tmp:
        ucd_path = str(ucd_path).replace("\n", " ")
        run_cl_command(ucd_path)
        create_coverage_dict()
        if (os.path.isfile(path_to_coverage_db)):
            with open(path_to_coverage_db) as stored_cvg_db_f:
                stored_coverage_dict = json.load(stored_cvg_db_f)
            update_coverage_dict()

        store_coverage_dict()


stored_coverage_dict = {}


load_stored_coverage_dict()

update_seq_plusargs(stored_coverage_dict, path_to_args_file)


#####################################################################################################################
#####################################################################################################################
#####################################################################################################################

if (os.path.isfile(path_to_run_txt) == 0):
    os.system('echo 0 > ' + path_to_run_txt)

with open(path_to_run_txt, "r") as run_no_f:
    run_no = int(run_no_f.read())
    run_no = run_no + 1
    os.system('echo ' + str(run_no) + " >  " + path_to_run_txt)
    if(run_no < max_iteration):
        command = shlex.split("vmanager -launch " + path_to_vsif+ " -batch ")
        subprocess.Popen(command)
    else:
        os.system('rm -f ' + path_to_run_txt)




