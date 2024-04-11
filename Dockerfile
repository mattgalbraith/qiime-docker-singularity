################# BASE IMAGE ######################
FROM --platform=linux/amd64 mambaorg/micromamba:1.3.1-focal
# Micromamba for fast building of small conda-based containers.
# https://github.com/mamba-org/micromamba-docker
# The 'base' conda environment is automatically activated when the image is running.

################## METADATA ######################
LABEL base_image="mambaorg/micromamba:1.3.1-focal"
LABEL version="1.0.0"
LABEL software="Qiime"
LABEL software.version="1.9.1"
LABEL about.summary="QIIME is an open-source bioinformatics pipeline for performing microbiome analysis from raw DNA sequencing data."
LABEL about.home="http://qiime.org/index-qiime1.html"
LABEL about.documentation="http://qiime.org/install/alternative.html"
LABEL about.license_file=""
LABEL about.license=""

################## MAINTAINER ######################
MAINTAINER Matthew Galbraith <matthew.galbraith@cuanschutz.edu>

################## INSTALLATION ######################

# Copy the yaml file to your docker image and pass it to micromamba
COPY --chown=$MAMBA_USER:$MAMBA_USER env.yaml /tmp/env.yaml
RUN micromamba install -y -n base -f /tmp/env.yaml && \
    micromamba clean --all --yes

