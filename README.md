[![Docker Image CI](https://github.com/mattgalbraith/qiime-docker-singularity/actions/workflows/docker-image.yml/badge.svg)](https://github.com/mattgalbraith/qiime-docker-singularity/actions/workflows/docker-image.yml)

# qiime-docker-singularity

## Build Docker container for Qiime and (optionally) convert to Apptainer/Singularity.  

QIIME is an open-source bioinformatics pipeline for performing microbiome analysis from raw DNA sequencing data  
  
#### Requirements:

  
## Build docker container:  

### 1. For Qiime installation instructions:  
http://qiime.org/install/alternative.html  


### 2. Build the Docker Image

#### To build image from the command line:  
``` bash
# Assumes current working directory is the top-level qiime-docker-singularity directory
docker build -t qiime:1.9.1 . # tag should match software version
```
* Can do this on [Google shell](https://shell.cloud.google.com)

#### To test this tool from the command line:
``` bash
docker run --rm -it qiime:1.9.1 print_qiime_config.py -t 
```

## Optional: Conversion of Docker image to Singularity  

### 3. Build a Docker image to run Singularity  
(skip if this image is already on your system)  
https://github.com/mattgalbraith/singularity-docker

### 4. Save Docker image as tar and convert to sif (using singularity run from Docker container)  
``` bash
docker images
docker save <Image_ID> -o qiime1.9.1-docker.tar && gzip qiime1.9.1-docker.tar # = IMAGE_ID of <tool> image
docker run -v "$PWD":/data --rm -it singularity:1.1.5 bash -c "singularity build /data/qiime1.9.1.sif docker-archive:///data/qiime1.9.1-docker.tar.gz"
```
NB: On Apple M1/M2 machines ensure Singularity image is built with x86_64 architecture or sif may get built with arm64  

Next, transfer the <tool>.sif file to the system on which you want to run <tool> from the Singularity container  

### 5. Test singularity container on (HPC) system with Singularity/Apptainer available  
``` bash
# set up path to the Singularity container
TOOL_SIF=path/to/qiime1.9.1.sif

# Test that <tool> can run from Singularity container
singularity run $TOOL_SIF tool --help # depending on system/version, singularity may be called apptainer
```