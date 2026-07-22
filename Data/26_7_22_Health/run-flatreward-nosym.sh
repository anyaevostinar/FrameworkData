#!/bin/bash --login

## This file runs one experimental condition (i.e. a group of jobs
## that are the same except for their random seed)

## Email settings (they don't work for our setup)
#SBATCH --mail-type=ALL
#SBATCH --mail-user=does_not_work@carleton.edu

## Job name settings (These do matter, so UPDATE THEM)
#SBATCH --job-name=hns
#SBATCH -o hns%A_%a.out

## Memory requirement in megabytes. You might need to make this bigger.
#SBATCH --mem-per-cpu=2000M

## Launch an array of jobs. This determines your random seeds
#SBATCH --array=100-129

#SBATCH --nodes=1

cd /Accounts/USERNAME/FrameworkData/Data/26_7_22_Health
mkdir NoSymsFlat
cd NoSymsFlat

mkdir ${SLURM_ARRAY_TASK_ID}
cd ${SLURM_ARRAY_TASK_ID}

cp /Accounts/USERNAME/FrameworkData/Data/26_7_22_Health/SymSettings.cfg .
cp /Accounts/USERNAME/FrameworkData/Data/26_7_22_Health/flat-reward-2-env.json .
cp /Accounts/USERNAME/SymbulationEmp/symbulation_sgp .

args=" -START_MOI 0 -HEALTH_TYPE parasite -TASK_ENV_CFG_PATH flat-reward-2-env.json -HOST_REPRO_RES 2 -SYM_HORIZ_TRANS_RES 1 -HOST_ONLY_FIRST_TASK_CREDIT 0"
./symbulation_sgp $args -SEED ${SLURM_ARRAY_TASK_ID} > run.log

## Run with sbatch -p facultynode --nodelist=edmonstone2024,margulis2024,carver,lederberg run-flatreward-nosym.sh
