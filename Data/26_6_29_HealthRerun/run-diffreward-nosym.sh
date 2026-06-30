#!/bin/bash --login

## This file runs one experimental condition (i.e. a group of jobs
## that are the same except for their random seed)

## Email settings (they don't work for our setup)
#SBATCH --mail-type=ALL
#SBATCH --mail-user=does_not_work@carleton.edu

## Job name settings (These do matter, so UPDATE THEM)
#SBATCH --job-name=hm
#SBATCH -o hm%A_%a.out

## Memory requirement in megabytes. You might need to make this bigger.
#SBATCH --mem-per-cpu=2000M

## Launch an array of jobs. This determines your random seeds
#SBATCH --array=100-129

#SBATCH --nodes=1

cd /Accounts/vostinar/FrameworkData/Data/26_6_29_HealthRerun
mkdir MutualistsDiff
cd MutualistsDiff

mkdir ${SLURM_ARRAY_TASK_ID}
cd ${SLURM_ARRAY_TASK_ID}

cp /Accounts/vostinar/FrameworkData/Data/26_6_29_HealthRerun/SymSettings.cfg .
cp /Accounts/vostinar/FrameworkData/Data/26_6_29_HealthRerun/diff-reward-env.json .
cp /Accounts/vostinar/FrameworkData/SymbulationEmp/symbulation_sgp .

args=" -START_MOI 1 -ENABLE_HEALTH true -HEALTH_TYPE mutualist -TASK_ENV_CFG_PATH diff-reward-env.json -HOST_REPRO_RES 256 -SYM_HORIZ_TRANS_RES 128"
./symbulation_sgp $args -SEED ${SLURM_ARRAY_TASK_ID} > run.log

## Run with sbatch -p facultynode --nodelist=edmonstone2024,margulis2024,carver,lederberg run-mutualist-replicate.sh