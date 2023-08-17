#!/bin/bash
# ======================================================================
# Recommended study directory structure
# ======================================================================

# study_name                     
#    └── code
#        └── analysis             # analysis code can live here
#        └── preprocessing        # this is where heudiconv, fmriprep, mriqc scripts live
#        └── task                 # task code can live here
#    └── data
#        └── bids                 # this is where raw BIDS data will be saved by HeuDiConv
#        └── dicom                # raw dicoms copied from the scanner go here
#        └── doc                  # manuscript, notebooks 
#        └── results              # summary result files

new_study=$1
mkdir -p "$new_study"/{code/{analysis,preprocessing,task},data/{bids,dicom,work},doc,results}