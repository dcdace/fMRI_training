#!/bin/sh

#-----------------------------------------------------------
# Add some info to the job output at the start
#-----------------------------------------------------------
# processing start time
start=$(date +%s)
date
echo Submitted subject: "${2}"

# ======================================================================
# FMRIPrep with Singularity
# ======================================================================
singularity run --cleanenv -B "${1}":/"${1}" \
    /imaging/local/software/singularity_images/fmriprep/fmriprep-21.0.1.simg \
    "${1}"/data/bids "${1}"/data/bids/derivatives/fmriprep \
    --work-dir "${1}"/data/work/fmriprep \
    participant \
    --participant-label "${2}" \
    --skip-bids-validation \
    --fs-license-file "${1}"/license.txt \
    --output-spaces MNI152NLin2009cAsym:res-2 T1w \
    --write-graph \
    --fs-no-reconall \
    --nthreads 16 --omp-nthreads 8 \
    --stop-on-first-crash

#-----------------------------------------------------------
# Add some info to the job output at the end
#-----------------------------------------------------------
end=$(date +%s)
echo Time elapsed: "$(TZ=UTC0 printf '%(%H:%M:%S)T\n' $((end - start)))"

