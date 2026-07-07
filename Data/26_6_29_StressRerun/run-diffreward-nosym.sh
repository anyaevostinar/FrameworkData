#!/bin/bash --login

## This file runs one experimental condition (i.e. a group of jobs
## that are the same except for their random seed)

## Email settings (they don't work for our setup)
#SBATCH --mail-type=ALL
#SBATCH --mail-user=does_not_work@carleton.edu

## Job name settings (These do matter, so UPDATE THEM)
#SBATCH --job-name=sns-diff
#SBATCH -o sns-diff%A_%a.out

## Memory requirement in megabytes. You might need to make this bigger.
#SBATCH --mem-per-cpu=2000M

## Launch an array of jobs. This determines your random seeds
#SBATCH --array=100-129

#SBATCH --nodes=1

cd /Accounts/vostinar/FrameworkData/Data/26_6_29_StressRerun
mkdir NoSymsDiff
cd NoSymsDiff

mkdir ${SLURM_ARRAY_TASK_ID}
cd ${SLURM_ARRAY_TASK_ID}

cp /Accounts/vostinar/FrameworkData/Data/26_6_29_StressRerun/SymSettings.cfg .
cp /Accounts/vostinar/FrameworkData/Data/26_6_29_StressRerun/diff-reward-env.json .
cp /Accounts/vostinar/FrameworkData/SymbulationEmp/symbulation_sgp .

args=" -START_MOI 0 -STRESS_TYPE mutualist -VERTICAL_TRANSMISSION 1 -TASK_ENV_CFG_PATH diff-reward-env.json -HOST_REPRO_RES 100 -SYM_HORIZ_TRANS_RES 50 -HOST_MIN_CYCLES_BEFORE_REPRO 0 -SYM_MIN_CYCLES_BEFORE_REPRO 0"
./symbulation_sgp $args -SEED ${SLURM_ARRAY_TASK_ID} > run.log

## Run with sbatch -p facultynode --nodelist=edmonstone2024,margulis2024,carver,lederberg run-diffreward-nosym.sh