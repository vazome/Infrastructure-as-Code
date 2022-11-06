#!/bin/bash
#This script silently checks for packages and stdouts status, you better to use it via Ansible or other deployment tool
if systemctl is-active --quiet NetworkManager
then
    echo "NM (Y): $(hostname)"
elif ! systemctl is-active --quiet NetworkManager
then
    if rpm -q initscripts  > /dev/null
    then
    echo "NM (N), initscripts (Y): $(hostname)"
    elif ! rpm -q initscripts  > /dev/null
    then
    echo "NM (N), initscripts (N): $(hostname)"
    else
    echo "NM (N), initscripts (E): $(hostname) "
    fi
else
    echo "ERROR: $(hostname)"
fi
