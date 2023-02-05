#!/bin/bash
set -eu
#-----------------------------------------------------------
# The passed subject list from _mriqc_batch
#-----------------------------------------------------------
SUBJECT_LIST=($2)
subject=${SUBJECT_LIST[${SLURM_ARRAY_TASK_ID}]}

#-----------------------------------------------------------
# Add some info to the job output at the start
#-----------------------------------------------------------
# processing start time
start=$(date +%s)
date
echo Submitted subject: "${subject}"

# ======================================================================
# MRIQC with Singularity
# ======================================================================
singularity run --cleanenv -B "${1}":/"${1}" \
    /imaging/local/software/singularity_images/mriqc/mriqc-22.0.1.simg \
    "${1}"/data/bids \
    "${1}"/data/bids/derivatives/mriqc/ \
    --work-dir "${1}"/data/work/mriqc/"$subject" \
    participant \
    --participant-label "${subject#sub-}" \
    --float32 \
    --n_procs 16 --mem_gb 24 --ants-nthreads 16 \
    --modalities T1w bold \
    --no-sub
# EACH LINE EXPLINED:
# attaching our project directory to the Singularity
# the Singularity file
# our BIDS data directory
# output directory
# --work-dir: path where intermediate results should be stored
# analysis_level (participant or group)
# --participant-label: a list of participant identifiers
# --float32: cast the input data to float32 if it’s represented in higher precision (saves space and improves perfomance)
# --n_procs 16 --mem_gb 24 --ants-nthreads 16: options to handle performance
# --modalities: filter input dataset by MRI type
# --no-sub: turn off submission of anonymized quality metrics to MRIQC’s metrics repository
# ======================================================================

#-----------------------------------------------------------
# Add some info to the job output at the end
#-----------------------------------------------------------
# procesing end time
end=$(date +%s)
echo Time elapsed: "$(TZ=UTC0 printf '%(%H:%M:%S)T\n' $((end - start)))"