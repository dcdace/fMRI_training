#!/bin/bash
set -eu

# Project path needs to be specified when submitting the function
PROJECT_PATH=${1}
# get the absolute path 
PROJECT_PATH=("$(cd "$(dirname "$1")" && pwd)")

# processing start time
start=$(date +%s)
date

singularity run --cleanenv -B "$PROJECT_PATH":/"$PROJECT_PATH" \
    /imaging/local/software/singularity_images/mriqc/mriqc-22.0.1.simg \
    "${1}"/data/bids "${1}"/data/bids/derivatives/mriqc/ \
    --work-dir "${1}"/data/work/mriqc/ \
    group \
    --no-sub \
    --float32 \
    --n_procs 16 --mem_gb 24 \
    --ants-nthreads 16 \
    --modalities T1w bold \
    --no-sub

# procesing end time
end=$(date +%s)
echo Time elapsed: "$(TZ=UTC0 printf '%(%H:%M:%S)T\n' $((end - start)))"