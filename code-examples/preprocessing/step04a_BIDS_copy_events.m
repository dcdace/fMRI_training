% Copy event information from Wakeman's ds000117 to my ExampleStudy
clearvars
source = '/imaging/correia/da05/workshops/2022-09-COGNESTIC/Wakeman-ds/ds000117';
destination = '/imaging/correia/da05/workshops/2023-CBU/demo/FaceRecognition/data/bids';

nsub = 16;
nrun = 9;

for i = 1:nsub
    sub = ['sub-' num2str(i,'%02.f')];
    sourceDir = fullfile(source, sub, 'ses-mri', 'func');
    sourceList = dir(fullfile(sourceDir, '*.tsv'));
    
    destDir = fullfile(destination, sub, 'func');
    destList = dir(fullfile(destDir, '*.tsv'));
    
    for f = 1:nrun
        f1 = fullfile(sourceList(f).folder, sourceList(f).name);
        f2 = fullfile(destList(f).folder, destList(f).name);
        copyfile(f1, f2, 'f');
    end
end