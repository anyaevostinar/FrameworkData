#!/bin/bash --login

## This file runs one experimental condition (i.e. a group of jobs
## that are the same except for their random seed)

## Email settings (they don't work for our setup)
#SBATCH --mail-type=ALL
#SBATCH --mail-user=does_not_work@carleton.edu

## Job name settings (These do matter, so UPDATE THEM)
#SBATCH --job-name=nm
#SBATCH -o nm%A_%a.out

## Memory requirement in megabytes. You might need to make this bigger.
#SBATCH --mem-per-cpu=2000M

## Launch an array of jobs. This determines your random seeds
#SBATCH --array=100-129

#SBATCH --nodes=1

cd /Accounts/hillmane/FrameworkData/Data/26_7_20_NutrientSameSett
mkdir MutualistsDiff
cd MutualistsDiff

mkdir ${SLURM_ARRAY_TASK_ID}
cd ${SLURM_ARRAY_TASK_ID}

cp /Accounts/hillmane/FrameworkData/Data/26_7_20_NutrientSameSett/SymSettings.cfg .
cp /Accounts/hillmane/FrameworkData/Data/26_7_20_NutrientSameSett/diff-reward-env.json .
cp /Accounts/hillmane/FrameworkData/SymbulationEmp/symbulation_sgp .

args=" -START_MOI 1 -VERTICAL_TRANSMISSION 1 -NUTRIENT_TYPE mutualist -TASK_ENV_CFG_PATH diff-reward-env.json -HOST_REPRO_RES 256 -SYM_HORIZ_TRANS_RES 128 -HOST_MIN_CYCLES_BEFORE_REPRO 0 -SYM_MIN_CYCLES_BEFORE_REPRO 0 -HOST_ONLY_FIRST_TASK_CREDIT 1"
./symbulation_sgp $args -SEED ${SLURM_ARRAY_TASK_ID} > run.log

## Run with sbatch -p facultynode --nodelist=edmonstone2024,margulis2024,carver,lederberg run-mutualist-replicate.sh
