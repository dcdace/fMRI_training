#!/bin/bash
# ======================================================================
# Dace Apšvalka (MRC CBU 2023)
# ======================================================================
# set -eu

# Project path needs to be specified when submitting the function
PROJECT_PATH=${1}
# get the absolute path 
PROJECT_PATH=("$(cd "$(dirname "$1")" && pwd)")

#-----------------------------------------------------------
# Where to output jobs
#-----------------------------------------------------------
JOB_DIR="$PROJECT_PATH"/data/work/fmriprep/jobs
mkdir -p "$JOB_DIR"
cd "$JOB_DIR" || exit

#-----------------------------------------------------------
# Submit to the _fmriprep_run script as a job array on SLURM
#-----------------------------------------------------------
for d in "$PROJECT_PATH"/data/bids/sub-*/; do
    sid=$(basename "$d")    
    sbatch --time=7-00:00 --cpus-per-task=16 "$PROJECT_PATH"/code/preprocessing/step07_fmriprep_run.sh "${PROJECT_PATH}" "${sid}"
    sleep 1m   # Fmriprep: Workaround for running subjects in parallel https://neurostars.org/t/updated-fmriprep-workaround-for-running-subjects-in-parallel/6677
done