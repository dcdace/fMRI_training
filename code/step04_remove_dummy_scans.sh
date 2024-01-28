#!/bin/sh

PROJECT_PATH='/imaging/correia/da05/workshops/2024-CBU'
BIDS_DIR="$PROJECT_PATH"/data

SCRIPT_PATH="$PROJECT_PATH"/code/dummies_script.sh

echo "Removing dummy scans from BIDS directory: $BIDS_DIR"

JOB_DIR="$PROJECT_PATH"/work/dummies_job_logs
mkdir -p "$JOB_DIR"
cd "$JOB_DIR" || exit
echo "Outputting job logs to: $JOB_DIR"

# Loop over each .nii.gz file and submit a SLURM job
for run in ${BIDS_DIR}/sub-*/func/*.nii.gz; do
    sbatch \
        --job-name=dummies \
        "$SCRIPT_PATH" "$run"
done