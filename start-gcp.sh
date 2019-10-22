#!/bin/bash

echo 'Running start-gcp.sh' > $HOME/isitrunning.txt

python /srv/setup-gcp.py
nohup /opt/globusconnectpersonal-2.3.9/globusconnectpersonal -start &
