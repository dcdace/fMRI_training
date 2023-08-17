#!/usr/bin/env python3
# -*- coding: utf-8 -*-

from cmath import nan
import os
import glob
import sys
import numpy as np
import pandas as pd

path_root = sys.argv[1]
path_events = os.path.join(path_root, '*', 'func', '*_events.tsv')

# get all fieldmap files in the data-set:
files_events = glob.glob(path_events)
# loop over all event files:
for file_path in files_events:
    # read in the event file
    events = pd.read_table(file_path)
    # rename the column
    events.rename(columns={"stim_type": "trial_type"}, inplace=True)
    # fill empty trial type as REST
    events["trial_type"].replace(nan, 'REST', inplace=True)
    # save the updated file
    events.to_csv(file_path, sep="\t", index=False)
    print(file_path, " updated")