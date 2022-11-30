#!/bin/bash

touch run_args
cat /home/andvin/git/dvcon_2022/sim/sim_args > run_args
echo $1 >> run_args
xrun -f run_args
rm -f run_args