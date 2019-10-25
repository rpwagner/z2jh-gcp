#!/bin/bash

if [ ! -z "$CREATEGCP" ]
then
    if [ "$CREATEGCP" -eq "1" ]
    then
        python /srv/setup-gcp.py
        nohup /opt/gcp/globusconnectpersonal -start &
    fi
fi
