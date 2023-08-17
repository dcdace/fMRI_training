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
JOB_DIR="$PROJECT_PATH"/data/work/mriqc/jobs
mkdir -p "$JOB_DIR"
cd "$JOB_DIR" || exit

#-----------------------------------------------------------
# Get the list of subject for this project
#----------------------------------------------------------- 
SUBJECT_DIRS=("$PROJECT_PATH"/data/bids/sub-*)
SUBJECT_LIST=("${SUBJECT_DIRS[@]##*/}") 

#-----------------------------------------------------------
# Submit to the _mriqc_run script as a job array on SLURM
#-----------------------------------------------------------
sbatch --array=0-$((${#SUBJECT_LIST[@]} - 1)) "$PROJECT_PATH"/code/preprocessing/step05_mriqc_run.sh "${PROJECT_PATH}" "${SUBJECT_LIST[*]}"
