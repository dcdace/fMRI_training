#!/bin/bash

# ============================================================
# This script is used to discover DICOM files using HeuDiConv.
#
# Usage: ./dicom_discover.sh
# 
# It is assumed that you have a conda environment called 'heudiconv' available (check with 'conda env list'). 
# If not, create a conda environment with the heudiconv and dcm2niix packages installed.
#
# ============================================================

# Your project's root directory
PROJECT_PATH='/imaging/correia/da05/workshops/2024-CBU'

# Path to the raw DICOM files
DICOM_PATH='/mridata/cbu/CBU090942_MR09029'

# Location of the output data (it will be created if it doesn't exist)
OUTPUT_PATH="${PROJECT_PATH}/work/dicom_discovery/"

# Subject ID
SUBJECT_ID='01'

# ------------------------------------------------------------
# Activate the heudiconv environment
# ------------------------------------------------------------
conda activate heudiconv

# ------------------------------------------------------------
# Run the heudiconv
# ------------------------------------------------------------
heudiconv \
    --files "${DICOM_PATH}"/*/*/*.dcm \
    --outdir "${OUTPUT_PATH}" \
    --heuristic convertall \
    --subjects "${SUBJECT_ID}" \
    --converter none \
    --bids \
    --overwrite
# ------------------------------------------------------------

# Deactivate the heudiconv environment
conda deactivate