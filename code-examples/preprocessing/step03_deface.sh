#!/bin/bash
# ======================================================================
# Dace Apšvalka (MRC CBU 2023)
# ======================================================================
set -eu

# Project path needs to be specified when submitting the function
PROJECT_PATH=${1}

# Find all T1w files
T1w_LIST=($(eval echo "$PROJECT_PATH"/data/bids/sub-*/anat/*T1w.nii.gz))

# Deface, rewriting the original files
for file in "${T1w_LIST[@]}"
do
    pydeface "$file" --outfile "$file" --force &
done

wait