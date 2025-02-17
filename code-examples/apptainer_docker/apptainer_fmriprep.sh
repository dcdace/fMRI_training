#!/bin/sh

# ============================================================
# fMRIPrep with Apptainer
#
# Pull the Apptainer image
# apptainer pull docker://nipreps/fmriprep
#
# ============================================================

PROJECT_PATH="/mnt/c/FaceRecognition"
sid="04"

apptainer run \
    -B "$PROJECT_PATH":/MyProject \
    /mnt/c/apptainer_images/fmriprep_v24.1.0.sif \
    /MyProject/data \
    /MyProject/data/derivatives/fmriprep\
    participant \
    --fs-license-file /MyProject/freesurfer_license.txt \
    --work-dir /MyProject/scratch/fmriprep \
    --participant-label "$sid" \
    --output-spaces MNI152NLin6Asym:res-2 \
    --dummy-scans 2 \
    --fs-no-reconall \
    --nthreads 16 --omp-nthreads 8 \
    --skip-bids-validation \
    --stop-on-first-crash