#!/bin/bash
set -eu

dicompath=$1

# get all BOLD directories
bold_dirs=($(ls -d "$dicompath"/*/*/*BOLD*))

# loop through each directory and 
for dir in "${bold_dirs[@]}"; do
    
    # delete first 2 files
    dummies=($(ls "$dir" | head -2))
    for dcm in "${dummies[@]}"; do
        rm "$dir"/"$dcm"
    done

done


