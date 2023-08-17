#!/bin/bash
set -eu

destpath=$1
sourcepath="/mridata/cbu/"

projectCode="MR09029"
CBUid=("CBU090942" "CBU090938" "CBU090964" "CBU090928" "CBU090931" "CBU090935" "CBU090970" "CBU090956" "CBU090958" "CBU090968" "CBU090957" "CBU090966" "CBU090951" "CBU090945" "CBU090962" "CBU090967")
nr=0
for id in "${CBUid[@]}"; do
    nr=$((nr + 1))
    # change sub id to be 01 02 ...
    newid=$(printf "%02d" "$nr")

    source="$sourcepath""$id"_"$projectCode"
    destination="$destpath""$newid"

    srun -N1 -n1 -c1 cp -R "$source" "$destination" &
    echo "$source"  being copied
done