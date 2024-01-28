#!/bin/bash

# This script removes the first two volumes of a 4D nifti file  (dummies)
# It takes one argument: the path to the 4D nifti file
# It saves the modified file in the same path
# It uses fslroi to remove the dummies
#
# Usage: ./dummies_script.sh <path_to_4D_nifti_file>

file=$1
n_dummies=2

echo "Removing $n_dummies dummies from $file"
echo "Output will be saved in the same file"

echo "Loading FSL"
module load fsl/6.0.1

temp_file="${file%.nii.gz}_temp.nii.gz"
echo "Creating temporary file $temp_file"

echo "Running fslroi with a temporary output file"
fslroi "$file" "$temp_file" $n_dummies -1

echo "Replacing the original file with the modified file"
mv "$temp_file" "$file"

echo "Done!"