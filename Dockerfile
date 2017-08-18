# Dockerfile to create env: build using `datmo env build`
# [1] Base environment to start from:
# Find more at https://hub.docker.com/u/datmo/
FROM mciantyre/scipy-opencv-notebook

COPY requirements.txt /tmp/
RUN pip install -r /tmp/requirements.txt

##### datmo essential ###
# Mount essential folders
VOLUME ["/home/_datmo", "/home/_datmo/files", "/home/_datmo/outputs", "/home/_datmo/snapshot", "/home/_datmo/data"]

# Setup environment variables
ENV INPUT_DIR=/home/_datmo
ENV FILES_DIR=/home/_datmo/files
ENV OUTPUT_DIR=/home/_datmo/outputs
ENV INPUT_SNAPSHOT_DIR=/home/_datmo/snapshot
ENV DATA_DIR=/home/_datmo/data
#########################


###### datmo essential ####

# Install CURL
RUN apt install curl

# Install pip
RUN curl -O https://bootstrap.pypa.io/get-pip.py && \
    python get-pip.py && \
    rm get-pip.py

# Install other useful Python packages using pip
RUN apt-get update
RUN pip install --upgrade ipython && \
        pip install \
                ipykernel \
                jupyter \
                && \
        python -m ipykernel.kernelspec

# Notebook requirements
RUN apt-get install -y  ipython \
                ipython-notebook

#Jupyter notebook related configs
COPY jupyter_notebook_config.py /root/.jupyter/
EXPOSE 8888

# Jupyter has issues with being run directly: https://github.com/ipython/ipython/issues/7062
COPY run_jupyter.sh /home/

RUN pip install flask
EXPOSE 5000
RUN mkdir -p /home/

# Setting working directory
# Working directory: this is where unix scripts will run from
WORKDIR /home/

###########################
