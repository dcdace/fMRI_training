#!/bin/bash
# ======================================================================
# Dace Apšvalka (MRC CBU 2023
# ======================================================================
set -eu

#-----------------------------------------------------------
# The passed variables from _heudiconv_batch
#-----------------------------------------------------------
# 1. Project path
PROJECT_PATH=${1}
# 2. DICOM path
DICOM_PATH=${2}
# 3. Subject ID list
SUBJECT_LIST=($3)

#-----------------------------------------------------------
# Were to output the data
OUTDIR="$PROJECT_PATH"/data/bids

#-----------------------------------------------------------
# Index each subject per job array
subject=${SUBJECT_LIST[${SLURM_ARRAY_TASK_ID}]}

#-----------------------------------------------------------
# Add some info to the job output at the start
#-----------------------------------------------------------
# Processing start time
start=$(date +%s)
# Write out the starting details
date
echo Submitted subject: "${subject}"
echo DICOM path: "$DICOM_PATH""${subject}"/
#-----------------------------------------------------------

#-----------------------------------------------------------
# Do the conversion using heudiconv
#-----------------------------------------------------------
heudiconv \
    -d "${DICOM_PATH}"{subject}/*/*/*.dcm \
    -o "${OUTDIR}" \
    -f "${PROJECT_PATH}"/code/preprocessing/heudiconv_heuristic.py \
    -s "${subject}" \
    -c dcm2niix \
    -b --overwrite

#-----------------------------------------------------------
# Add some info to the job output at the end
#-----------------------------------------------------------
# Procesing end time
end=$(date +%s)
# Write out the elapssed processing time
echo Time elapsed: "$(TZ=UTC0 printf '%(%H:%M:%S)T\n' $((end - start)))"