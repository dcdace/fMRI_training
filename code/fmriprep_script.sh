#!/bin/sh

# ============================================================
# This script requires step07_fmriprep.sh, unless you define PROJECT_PATH
# and subject here manually 
#
# This script uses fmriprep Singularity image
# To get the latest Docker image (or Singluarity/Apptainer) use: 
# docker pull nipreps/fmriprep:<latest-version>
# ============================================================


#-----------------------------------------------------------
# The passed variables from step06_fmriprep.sh
#-----------------------------------------------------------
PROJECT_PATH=${1}
subject=${2}

#-----------------------------------------------------------
# Add some info to the job output at the start
#-----------------------------------------------------------
# processing start time
start=$(date +%s)
date
echo Submitted subject: "$subject"

# ======================================================================
# FMRIPrep with Singularity
# ======================================================================

singularity run --cleanenv -B "$PROJECT_PATH":/"$PROJECT_PATH" \
    /imaging/local/software/singularity_images/fmriprep/fmriprep-21.0.1.simg \
    "$PROJECT_PATH"/data "$PROJECT_PATH"/data/derivatives/fmriprep \
    --work-dir "$PROJECT_PATH"/work/fmriprep \
    participant \
    --participant-label "$subject" \
    --skip-bids-validation \
    --fs-license-file "$PROJECT_PATH"/code/freesurfer_license.txt \
    --output-spaces MNI152NLin2009cAsym:res-2 \
    --write-graph \
    --fs-no-reconall \
    --nthreads 16 --omp-nthreads 8 \
    --stop-on-first-crash

#-----------------------------------------------------------
# Add some info to the job output at the end
#-----------------------------------------------------------
end=$(date +%s)
echo Time elapsed: "$(TZ=UTC0 printf '%(%H:%M:%S)T\n' $((end - start)))"