#!/bin/bash

if [ ! -z "$CREATEGCP" ]
then
    if [ "$CREATEGCP" -eq "1" ]
    then
        python /srv/setup-gcp.py
        chmod -R go-rwx /home/jovyan/.globusonline

        nohup /opt/gcp/globusconnectpersonal -start &
    fi
fi
