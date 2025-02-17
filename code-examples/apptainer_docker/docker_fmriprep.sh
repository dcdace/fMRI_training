#!/bin/bash

# ============================================================
# fMRIPrep with Docker
#
# Pull the Docker image
# docker pull nipreps/fmriprep
#
# ============================================================

PROJECT_PATH="/mnt/c/FaceRecognition"
sid="04"

docker run --rm -it \
    -v $PROJECT_PATH:/MyProject \
    nipreps/fmriprep \
    /MyProject/data \
    /MyProject/data/derivatives/fmriprep/ \
    participant \
    --fs-license-file /MyProject/freesurfer_license.txt \
    --work-dir /MyProject/scratch/fmriprep \
    --participant-label $sid \
    --output-spaces MNI152NLin6Asym:res-2 \
    --dummy-scans 2 \
    --fs-no-reconall \
    --nthreads 16 --omp-nthreads 8 \
    --skip-bids-validation \
    --stop-on-first-crash