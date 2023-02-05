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
    -o $projectpath/data/bids/ \
    -f $projectpath/code/preprocessing/heudiconv_heuristic.py \
    -s $sid \
    -c dcm2niix \
    -b --overwrite