FROM jupyter/base-notebook:d4e60350af15
# Built from... https://hub.docker.com/r/jupyter/base-notebook/
#               https://github.com/jupyter/docker-stacks/blob/master/base-notebook/Dockerfile
# Built from... https://github.com/jupyterhub/zero-to-jupyterhub-k8s/commit/1cd1311185a9f016608a83bb7dcd3350be8e0ae9
# 
# Built from... Ubuntu 18.04

# The jupyter/docker-stacks images contains jupyterhub, jupyterlab and the
# jupyterlab-hub extension already.

# Example install of git and nbgitpuller.
# NOTE: git is already available in the jupyter/minimal-notebook image.
USER root
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      git \
      && \
    apt-get purge && apt-get clean && \
    apt-get -y --allow-unauthenticated install vim build-essential wget gfortran bison libibverbs-dev libibmad-dev libibumad-dev librdmacm-dev graphviz gcc make

RUN wget https://downloads.globus.org/globus-connect-personal/linux/stable/globusconnectpersonal-latest.tgz -O /tmp/globusconnectpersonal-latest.tgz
RUN tar -xzvf /tmp/globusconnectpersonal-latest.tgz -C /opt
RUN mv $(find /opt -type 'd' -name 'globus*' -maxdepth 1) /opt/gcp

COPY tutorial_files.py /srv/tutorial_files.py
COPY requirements.txt /tmp/requirements.txt

USER $NB_USER
RUN pip install -r /tmp/requirements.txt
# We should probably add this at some point and replace our old puller
#RUN pip install nbgitpuller && \
#    jupyter serverextension enable --py nbgitpuller --sys-prefix
