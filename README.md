# Introduction to fMRI
Materials for the "Introduction to fMRI" workshop at the [MRC CBU](https://www.mrc-cbu.cam.ac.uk/) 

Instructor: [Dr Dace Apšvalka](http://dcdace.net)

## Slides

* [Introduction](slides/fMRI_01_Introduction.pdf)
* [Experimental Design](slides/fMRI_02_Experimental-Design.pdf)
* Data Management
* Pre-processing
* Statistical Analysis 

## Example scripts

Example scripts for the fMRI analysis steps are available in the [code](code) directory. They include:
1. Converting DICOM to BIDS with HeuDiConv, 
2. Data quality assessment with MRIQC, 
3. Pre-processing with fMRIPrep, and 
4. First-level statistical analysis with Nilearn. 

## Hands-On Notebooks

You can access the hands-on notebooks in two ways:

## 1) Interactively through MyBinder [![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/dcdace/fMRI_training/HEAD)

[MyBinder.org ](https://mybinder.org)  is a service that allows you to run Jupyter notebooks directly online. However, this service comes with a restricted computational environment (1-2GB of RAM). This means, many notebooks might be very slow and some might even crash, due to not enough memory. You can use this approach to run and test most of the notebooks. To access the MyBinder instance, click on the badge below.

[![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/dcdace/fMRI_training/HEAD)

___
## 2) Download the notebooks and run on your computer
You can also download the notebooks from [notebooks](notebooks) section and run on your computer. The environment required for that to work is in `environment.yml` [file](environment.yml). 

The example dataset with 2 subjects can be downloaded from [Dropbox](https://dl.dropboxusercontent.com/s/q030cu844joczm6/FaceRecognition.zip).
