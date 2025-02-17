"""
This script downloads specific data from the OpenNeuro dataset ds000117.
It targets MRI session data for subjects 01 to 16 and excludes DWI and FLASH files.
The data is saved to a specified directory.

It uses the openneuro Python package to download the data; https://github.com/hoechenberger/openneuro-py
"""

import os
import openneuro as on

dataset = "ds000117" # https://openneuro.org/datasets/ds000117/versions/1.1.0/
output_directory = "/imaging/correia/da05/workshops/2025-CBU/sandbox/FaceRecognition/data"

# subject IDs from 01 to 16
subjects = [f"sub-{i:02d}" for i in range(1, 17)]

# only mri session
session = "ses-mri"

# create the output directory if it does not exist
os.makedirs(output_directory, exist_ok=True)

# download the data for each subject
for subject in subjects:

    # Only include the mri session and from that, exclude dwi and FLASH files
    on.download(
        dataset=dataset,
        target_dir=output_directory,
        include=f"{subject}/{session}",
        exclude=[f"{subject}/{session}/dwi", f"{subject}/{session}/anat/*FLASH*"],
    )