#!/bin/bash
# ======================================================================
# Dace Apšvalka (MRC CBU 2023)
# ======================================================================
# set -eu

# Project path needs to be specified when submitting the function
PROJECT_PATH=${1}
# get the absolute path 
PROJECT_PATH=("$(cd "$(dirname "$1")" && pwd)")

# get the subject list 
SUBJECT_DIRS=("$PROJECT_PATH"/data/bids/sub-*)
SUBJECT_LIST=("${SUBJECT_DIRS[@]##*/}") 

# process in parallel
for sub in "${SUBJECT_LIST[@]}"
do
     srun "$PROJECT_PATH"/code/analysis/first_level.py "${PROJECT_PATH}" ${sub} &
done

wait