#!/bin/bash

# ============================================================
# This script is used to discover DICOM files using HeuDiConv.
#
# Usage: ./step01_dicom_discover.sh
#
# It is assumed that you have a conda environment called 'mri' available (check with 'conda env list').
# If not, create a conda environment with the heudiconv and dcm2niix packages installed.
# For example:
# ============================================================

# ------------------------------------------------------------
# Define your paths
# ------------------------------------------------------------

# Path to the raw DICOM files
DICOM_PATH='/imaging/correia/da05/workshops/2025-CBU/example_data/mridata/CBU090962_MR09029'

# Location of the output data (it will be created if it doesn't exist)
OUTPUT_PATH='/imaging/correia/da05/workshops/2025-CBU/example_data/FaceRecognition/scratch/dicom_discovery'

# Subject ID
SUBJECT_ID='15'

# ------------------------------------------------------------
# Activate the mri environment (or any other environment with heudiconv installed)
# ------------------------------------------------------------
#conda activate mri # This doesn't work on all systems. Then you need to activate the environment manually 
# (e.g., conda activate mri) and run the script again.

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

# Copy the dicominfo.tsv file from a hidden directory to the output directory
cp "${OUTPUT_PATH}"/.heudiconv/"${SUBJECT_ID}"/info/dicominfo.tsv "${OUTPUT_PATH}"
# ------------------------------------------------------------

# HeudiConv parameters:
# --files: Files or directories containing files to process
# --outdir: Output directory
# --heuristic: Name of a known heuristic or path to the Python script containing heuristic
# --subjects: Subject ID
# --converter : dicom to nii converter (dcm2niix or none)
# --bids: Flag for output into BIDS structure
# --overwrite: Flag to overwrite existing files
#
# For a full list of parameters, see: https://heudiconv.readthedocs.io/en/latest/usage.html