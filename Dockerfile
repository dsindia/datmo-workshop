# Dockerfile to create env: build using `datmo env build`
# [1] Base environment to start from:
# Find more at https://hub.docker.com/u/datmo/
FROM kaggle/python:latest


#Jupyter notebook related configs
COPY jupyter_notebook_config.py /root/.jupyter/
EXPOSE 8888

# Jupyter has issues with being run directly: https://github.com/ipython/ipython/issues/7062
COPY run_jupyter.sh /home/

#Adding flask
RUN pip install flask
EXPOSE 5000

WORKDIR /workspace
RUN chmod -R a+w /workspace
###########################
