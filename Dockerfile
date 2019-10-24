FROM jupyter/base-notebook:27ba57364579

# conda/pip/apt install additional packages here, if desired.
USER root
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      git \
      && \
    apt-get purge && apt-get clean && \
    apt-get -y --allow-unauthenticated install vim build-essential wget gfortran bison libibverbs-dev libibmad-dev libibumad-dev librdmacm-dev libmlx5-dev libmlx4-dev graphviz gcc make


# pin jupyterhub to match the Hub version
# set via --build-arg in Makefile
ARG JUPYTERHUB_VERSION=0.8



ADD requirements.txt /tmp/requirements.txt

ADD tutorial_files.py /srv/tutorial_files.py

RUN pip install --no-cache-dir \
         https://s3.us-east-2.amazonaws.com/globusworldk8.nick.globuscs.info/jupyterhub-0.8.1.tar.gz \
         -r /tmp/requirements.txt


ADD requirements.txt /tmp/requirements.txt

RUN wget https://downloads.globus.org/globus-connect-personal/linux/stable/globusconnectpersonal-latest.tgz -O /tmp/globusconnectpersonal-latest.tgz

RUN tar -xzvf /tmp/globusconnectpersonal-latest.tgz -C /opt

ADD setup-gcp.py /srv/setup-gcp.py
ADD start-gcp.sh /srv/start-gcp.sh
RUN chmod +x /srv/start-gcp.sh
ADD gcp_config_additions.py /srv/gcp_config_additions.py
RUN cat /srv/gcp_config_additions.py >> /etc/jupyter/jupyter_notebook_config.py
