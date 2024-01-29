# Introduction to fMRI
Materials for the "Introduction to fMRI" workshop at the [MRC CBU](https://www.mrc-cbu.cam.ac.uk/) 

Instructor: [Dr Dace Apšvalka](http://dcdace.net)

## Slides

* [Introduction](slides/fMRI_01_Introduction.pdf)
* [Experimental Design](slides/fMRI_02_Experimental-Design.pdf)
* [Data Management](slides/fMRI_03_Data-Management.pdf)
* [Pre-processing](slides/fMRI_04_Preprocessing.pdf)
* [Statistical Analysis](slides/fMRI_05_StatisticalAnalysis.pdf) 

## Example scripts

Example scripts for the fMRI analysis steps are available in the [code](code) directory. They include:

* **Step 1:** Discovering what DICOM series there are in your raw data
* **Step 2:** Converting DICOM to BIDS with HeuDiConv
* **Step 3:** Filling in events files with trial types, onsets, duration etc.
* **Step 4:** Removing dummy scans from the functional volumes
* **Step 5:** and **Step 6:**  Data quality assessment with MRIQC
* **Step 7:** Pre-processing with fMRIPrep
* **Step 8:** First-level statistical analysis with Nilearn 

## Tutorial Notebooks

You can access the tutorial notebooks in three ways:

### 1) Interactively through MyBinder [![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/dcdace/fMRI_training/1033062d5d22f52164bf6ea882254881ef5853cf?urlpath=tree/notebooks)

[MyBinder.org ](https://mybinder.org)  is a service that allows you to run Jupyter notebooks directly online. However, this service comes with a restricted computational environment (1-2GB of RAM). This means, many notebooks might be very slow and some might even crash, due to not enough memory. You can use this approach to run and test most of the notebooks. To access the MyBinder instance, click on the badge below.

[![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/dcdace/fMRI_training/1033062d5d22f52164bf6ea882254881ef5853cf?urlpath=tree/notebooks)

___
### 2) Download the notebooks and run on your computer
You can also download the notebooks from [notebooks](notebooks) section and run on your computer. The environment required for that to work is in `environment.yml` [file](environment.yml). 

The example dataset with 2 subjects can be downloaded from [Dropbox](https://dl.dropboxusercontent.com/s/q030cu844joczm6/FaceRecognition.zip).


### 3) Static notebooks
You can also view the notebooks with all solutions provided just clicking on them in the [notebooks](notebooks) directory.
