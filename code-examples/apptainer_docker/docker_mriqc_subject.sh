#!/bin/bash

# ============================================================
# MRIQC with Docker
#
# Pull the Docker image
# docker pull nipreps/mriqc
#
# ============================================================

PROJECT_PATH="/mnt/c/FaceRecognition"
sid="04"

docker run --rm -it \
    -v $PROJECT_PATH:/MyProject \
    nipreps/mriqc \
    /MyProject/data \
    /MyProject/data/derivatives/mriqc/ \
    participant \
    --work-dir /MyProject/scratch/mriqc/ \
    --participant_label $sid \
    --float32 \
    --n_procs 16 --mem_gb 24 --ants-nthreads 16 \
    --modalities T1w bold \
    --no-sub