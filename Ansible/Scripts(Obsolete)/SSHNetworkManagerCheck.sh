#!/bin/bash
# I WARN YOU THAT THIS SCRIPT EXPECTS YOU TO USE SSHPASS WHICH IS NOT A GOOD PRACTICE, YOU CAN ADAPT IT TO KEY AUTHENTICATION INSTEAD
echo "I WARN YOU THAT THIS SCRIPT EXPECTS YOU TO USE SSHPASS WHICH IS NOT A GOOD PRACTICE, YOU CAN ADAPT IT TO KEY AUTHENTICATION INSTEAD"
SCRIPT='
if systemctl is-active --quiet NetworkManager
then
    echo "NM (Y) $(hostname)"
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
fi'
HOSTS=("192.168.1.121" "192.168.1.122" "192.168.1.123")
USERNAME="cloud_user"
echo "Now enter password"
read -s PASSWORD
for i in ${!HOSTS[*]} ; do
     echo "Connecting to: ${HOSTS[i]}"
     sleep 2
     sshpass -p ${PASSWORD} ssh -l ${USERNAME} -oStrictHostKeyChecking=no -oUserKnownHostsFile=/dev/null ${HOSTS[i]} "${SCRIPT}" | tee -a /Users/danielvazome/Documents/file2.log
done
# I WARN YOU THAT THIS SCRIPT EXPECTS YOU TO USE SSHPASS WHICH IS NOT A GOOD PRACTICE, YOU CAN ADAPT IT TO KEY AUTHENTICATION INSTEAD
