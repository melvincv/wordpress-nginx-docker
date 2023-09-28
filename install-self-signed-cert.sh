#!/bin/bash
# Define Variables
CERTPATH="/etc/nginx/ssl"

# Check if run as root
if [ ${EUID} -ne 0 ]; then
    echo "This script needs to be run as root. Exiting..."
    exit 1
fi

# make dir for cert storage
mkdir -p ${CERTPATH}
# create self signed certificate
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout ${CERTPATH}/selfsigned.key -out ${CERTPATH}/selfsigned.crt
