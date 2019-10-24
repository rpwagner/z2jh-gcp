#!/bin/bash

if [ ! -z "$CREATEGCP" ]
then
    if [ "$CREATEGCP" -eq "1" ]
    then
        python /srv/setup-gcp.py
        nohup /opt/globusconnectpersonal-2.3.9/globusconnectpersonal -start &
    fi
fi
