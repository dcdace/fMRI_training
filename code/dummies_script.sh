#!/bin/bash

file=$1
n_dummies=2

module load fsl/6.0.1

# Temporary output file
temp_file="${file%.nii.gz}_temp.nii.gz"

# Run fslroi with a temporary output file
fslroi "$file" "$temp_file" $n_dummies -1

# Replace the original file with the modified file
mv "$temp_file" "$file"