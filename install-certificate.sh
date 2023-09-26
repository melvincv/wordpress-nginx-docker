#!/bin/bash
# For Debian like systems
# Define Variables
# Domains to generate the certificate for, comma separated list
# Eg: domain1,domain2
DOMAINS=wp.awsl.melvincv.com
# email id for certificate renewal
EMAILID=
# Staging CA for testing?
STAGING=1

# Check if run as root
if [ ${EUID} -ne 0 ]; then
    echo "This script needs to be run as root. Exiting..."
    exit 1
fi

# Function to install Certbot
install_certbot () {
    # Install snapd if it does not exist
    if [ ! -e "$(which snapd)" ]; then
    apt install snapd
    fi
    # Update Snapd Core
    snap install core && snap refresh core
    # Install Certbot
    snap install --classic certbot
    ln -s /snap/bin/certbot /usr/bin/certbot
}

# Install Certbot if it does not exist
if [ ! -e "$(which certbot)" ]; then
    install_certbot
fi

# Get certs with a built-in web server
if [ ${STAGING} -eq 1 ]; then
    certbot certonly --standalone -d ${DOMAINS} --agree-tos --email ${EMAILID} --server https://acme-staging-v02.api.letsencrypt.org/directory
else
    certbot certonly --standalone -d ${DOMAINS} --agree-tos --email ${EMAILID}
fi