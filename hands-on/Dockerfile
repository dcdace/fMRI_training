FROM continuumio/miniconda3

# Copy your Jupyter notebooks and environment.yml file into the container
COPY . /home/cbu/fmri-workshop

# RUN set -xe \
#     && apt-get update -y \
#     && apt-get install -y python3-pip
# RUN pip install --upgrade pip

RUN conda env create -f /home/cbu/fmri-workshop/environment.yml --verbose && \
    conda clean --all -f -y
RUN echo "source activate fMRI" >> ~/.bashrc
ENV PATH /opt/conda/envs/fMRI/bin:$PATH

WORKDIR /home/cbu/fmri-workshop

# Expose the Jupyter Notebook port
EXPOSE 8888
