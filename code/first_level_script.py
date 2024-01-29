#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# ======================================================================
# Dace Apšvalka (MRC CBU 2024)
# First level fMRI analysis using Nilearn
# 
# This script requres step08_first_level_analysis.sh, unless you define ds
# and sID here manually 
#
# ======================================================================

# ======================================================================
# IMPORT RELEVANT PACKAGES
# ======================================================================
import os
import sys
import pandas as pd
import numpy as np
from bids.layout import BIDSLayout
from nilearn.glm.first_level import FirstLevelModel
import time
import warnings
warnings.filterwarnings("ignore")

# ======================================================================
# DEFINE PATHS
# arguments passed from step07_first_level_analysis.sh
# ======================================================================
ds = sys.argv[1] # dataset location
sID = sys.argv[2].split("sub-")[1] # subject id

# ======================================================================
print("Running first-level analysis for subject " + sID)
start_time = time.time()
print("Started at: " + time.strftime("%H:%M:%S", time.localtime()))

# ======================================================================
# DEFINE PARAMETERS
# =====================================================================
model_name = 'first-level'

bids_path = os.path.join(ds, 'data')
outdir = os.path.join(ds, 'results', model_name, 'sub-' + sID)
if not os.path.exists(outdir):
    os.makedirs(outdir)

print("BIDS data location: " + bids_path)
print("Output directory: " + outdir)

# ======================================================================
# PERFORM SUBJECT LEVEL GLM ANALYSIS
# ======================================================================

# Initialize the BIDS layout and include the derivatives in it
layout = BIDSLayout(bids_path, derivatives=True)

# Get the TR value
TR = layout.get_tr()

# Define the GLM model
fmri_glm = FirstLevelModel(
    t_r = TR,
    noise_model = 'ar1',
    hrf_model = 'spm',
    drift_model = 'Cosine',
    high_pass = 1./128,
    slice_time_ref = 0.5, 
    smoothing_fwhm = 6,
    signal_scaling = False,
    minimize_memory = False
    )

# Get the preprocessed functional files
bold = layout.get(
    subject=sID, 
    datatype='func', 
    space='MNI152NLin2009cAsym', 
    desc='preproc', 
    extension='.nii.gz',
    return_type='filename'
    )
print("Found " + str(len(bold)) + " preprocessed functional files")

# Get the event files
events = layout.get(
    subject=sID, 
    datatype='func', 
    suffix='events', 
    extension=".tsv", 
    return_type='filename'
    )
print("Found " + str(len(events)) + " event files")

# Get the confounds and select which ones to include in the design
confounds = layout.get(
    subject=sID, 
    datatype='func', 
    desc='confounds', 
    extension=".tsv", 
    return_type='filename'
    )
print("Found " + str(len(confounds)) + " confounds files")

confounds_of_interest = ['trans_x', 'trans_y', 'trans_z', 'rot_x', 'rot_y', 'rot_z']
confounds_glm = []
for conf_file in confounds:
    this_conf = pd.read_table(conf_file)
    conf_subset = this_conf[confounds_of_interest].fillna(0) # replace NaN with 0
    confounds_glm.append(conf_subset)

# Fit the model
fmri_glm = fmri_glm.fit(bold, events, confounds_glm)

# Create contrasts
design_matrices = fmri_glm.design_matrices_

contrast_list = []
for design_matrix in design_matrices:
    """A small routine to append zeros in contrast vectors"""
    n_columns = design_matrix.shape[1] #number of predictors in our model
    def pad_vector(contrast_, n_columns):    
        return np.hstack((contrast_, np.zeros(n_columns - len(contrast_))))
    contrasts = {
        'Famous': pad_vector([1, 0, 0], n_columns),
        'Unfamiliar': pad_vector([0, 0, 1], n_columns),
        'Scrambled': pad_vector([0, 1, 0], n_columns),
        'FamousUnfamiliar': pad_vector([1, 0, -1], n_columns),
        'UnfamiliarFamous': pad_vector([-1, 0, 1], n_columns),
        'FacesScrambled': pad_vector([1/2, -1, 1/2], n_columns),
        'ScrambledFaces': pad_vector([-1/2, 1, -1/2], n_columns),
        'EffectsOfInterest': np.eye(n_columns)[[0,1,2]]
        }
    contrast_list.append(contrasts)

# Compute the contrasts
stats_type = ['stat', 'effect_size']
for stats in stats_type:
    for contrast_id in contrast_list[0].keys():    
        stats_map = fmri_glm.compute_contrast(
            [c[contrast_id] for c in contrast_list], 
            output_type = stats)
        # Save results following BIDS standart
        res_name = os.path.basename(bold[0]).split("run")[0]
        # from stats get only the part before _ for the BIDS file name
        stats_suffix = stats.split("_")[0]
        stats_map.to_filename(os.path.join(outdir, res_name + 'desc-' + contrast_id + '_' + stats_suffix + '.nii.gz'))

# ======================================================================
# CREATE THIS MODEL'S dataset_description.json FILE
# This is needed to use the results directory as BIDS data. 
# We will save our model parameters in the file as well, which is very useful
# ======================================================================

jason_file = os.path.join(ds, 'results', model_name, "dataset_description.json")

if not os.path.exists(jason_file):
    import json
    import datetime
    from importlib.metadata import version

    nilearn_version = version('nilearn')
    date_created = datetime.datetime.now()
    
    # Data to be written
    content = {
        "Name": "First-level GLM analysis",
        "BIDSVersion": "1.8.0",
        "DatasetType": "results",
        "GeneratedBy": [
            {
                "Name": "Nilearn",
                "Version": nilearn_version,
                "CodeURL": "https://nilearn.github.io"
            }
        ],    
        "Date": date_created,
        "FirstLevelModel": [
            fmri_glm.get_params()
        ], 
    }
    
    # Serializing json
    json_object = json.dumps(content, indent=4, default=str)
    
    # Writing to .json
    with open(jason_file, "w") as outfile:
        outfile.write(json_object)

# ======================================================================
print("Finished first-level analysis for subject " + sID)
print("Finished at: " + time.strftime("%H:%M:%S", time.localtime()))
print("Processing time: " + str(round((time.time() - start_time)/60, 2)) + " minutes")