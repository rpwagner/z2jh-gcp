FROM jupyter/base-notebook:814ef10d64fb
# Built from... https://hub.docker.com/r/jupyter/base-notebook/
#               https://github.com/jupyter/docker-stacks/blob/master/base-notebook/Dockerfile
# Built from... Ubuntu 18.04

# The jupyter/docker-stacks images contains jupyterhub, jupyterlab and the
# jupyterlab-hub extension already.

# Example install of git and nbgitpuller.
# NOTE: git is already available in the jupyter/minimal-notebook image.
USER root
RUN apt-get update && apt-get install --yes --no-install-recommends \
    git \
 && rm -rf /var/lib/apt/lists/*
USER $NB_USER

RUN pip install nbgitpuller && \
    jupyter serverextension enable --py nbgitpuller --sys-prefix

# Uncomment the line below to make nbgitpuller default to start up in JupyterLab
#ENV NBGITPULLER_APP=lab

# conda/pip/apt install additional packages here, if desired.
USER root
RUN apt-get -y --allow-unauthenticated install vim build-essential wget gfortran bison libibverbs-dev libibmad-dev libibumad-dev librdmacm-dev libmlx5-dev libmlx4-dev graphviz gcc make

ADD requirements.txt /tmp/requirements.txt

ADD tutorial_files.py /srv/tutorial_files.py

RUN wget https://downloads.globus.org/globus-connect-personal/linux/stable/globusconnectpersonal-latest.tgz -O /tmp/globusconnectpersonal-latest.tgz

RUN tar -xzvf /tmp/globusconnectpersonal-latest.tgz -C /opt
RUN mv $(find /opt -type 'd' -name 'globus*' -maxdepth 1) /opt/gcp

ADD setup-gcp.py /srv/setup-gcp.py
ADD start-gcp.sh /srv/start-gcp.sh
RUN chmod +x /srv/start-gcp.sh
ADD gcp_config_additions.py /srv/gcp_config_additions.py
RUN cat /srv/gcp_config_additions.py >> /etc/jupyter/jupyter_notebook_config.py
