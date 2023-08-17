#!/bin/bash
dicompath=$1
projectpath=$2
sid="01"
# -d, --dicom_dir_template
# -o, --outdir
# -f, --heuristic
# -s, --subjects
# -c, --converter
# -b, --bids
heudiconv \
    -d $dicompath/{subject}/*/*/*.dcm \
    -o $projectpath/data/work/dicom_discovery/ \
    -f convertall \
    -s $sid \
    -c none \
    -b --overwrite