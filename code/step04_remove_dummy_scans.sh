#!/bin/sh

# ============================================================
# Remove dummy scans from BIDS directory's functional images
# ============================================================

# ------------------------------------------------------------
# Define variables
# ------------------------------------------------------------

PROJECT_PATH='/imaging/correia/da05/workshops/2024-CBU'
BIDS_DIR="$PROJECT_PATH"/data

SCRIPT_PATH="$PROJECT_PATH"/code/dummies_script.sh

# ------------------------------------------------------------
# Do some checks before running the script
# ------------------------------------------------------------
# Check if the BIDS directory exists
if [ ! -d "$BIDS_DIR" ]; then
    echo "BIDS directory does not exist: $BIDS_DIR"
    exit 1
fi

# Check if the script exists
if [ ! -f "$SCRIPT_PATH" ]; then
    echo "Script does not exist: $SCRIPT_PATH"
    exit 1
fi

#-----------------------------------------------------------
# Where to output job logs
#-----------------------------------------------------------
JOB_DIR="$PROJECT_PATH"/work/dummies_job_logs
mkdir -p "$JOB_DIR"
cd "$JOB_DIR" || exit
echo "Outputting job logs to: $JOB_DIR"

# ------------------------------------------------------------
# Loop over each functional .nii.gz file and submit a SLURM job
# ------------------------------------------------------------
echo "Removing dummy scans from BIDS directory: $BIDS_DIR"

for run in ${BIDS_DIR}/sub-*/func/*.nii.gz; do
    sbatch \
        --job-name=dummies \
        "$SCRIPT_PATH" "$run"
done