import os

def create_key(template, outtype=('nii.gz',), annotation_classes=None):
    if template is None or not template:
        raise ValueError('Template must be a valid format string')
    return template, outtype, annotation_classes

# Dictionary to specify options to populate the 'IntendedFor' field of the fmap jsons.
POPULATE_INTENDED_FOR_OPTS = {
    'matching_parameters': ['ImagingVolume', 'Shims'],
    'criterion': 'Closest'
}
# ----
def infotodict(seqinfo):
    # BIDS keys
    anat = create_key('sub-{subject}/anat/sub-{subject}_acq-mprage_T1w')
    fmap_mag = create_key('sub-{subject}/fmap/sub-{subject}_magnitude')
    fmap_phase = create_key('sub-{subject}/fmap/sub-{subject}_phasediff')
    func_task = create_key('sub-{subject}/func/sub-{subject}_task-facerecognition_run-0{item:01d}_bold')

    info = {anat: [], fmap_mag: [], fmap_phase: [],
            func_task: []}

    # Unique identifiers for the sequences
    for idx, s in enumerate(seqinfo):
        # anat T1w
        if (s.dim1 == 256) and ("MPRAGE" in s.protocol_name):
            info[anat].append(s.series_id)
        # Field map Magnitude
        if (s.dim3 == 66) and ('FieldMapping' in s.protocol_name):
            info[fmap_mag].append(s.series_id)
        # Field map PhaseDiff
        if (s.dim3 == 33) and ('FieldMapping' in s.protocol_name):
            info[fmap_phase].append(s.series_id)        
        # Functional Bold
        if (s.dim1 == 64) and (s.dim4 > 100):
            info[func_task].append(s.series_id)

    return info