#!/bin/bash
# Define your domain name
NEWDOMAIN=test.example.com
# Replace
sed -i "s/wp.awsl.melvincv.com/${NEWDOMAIN}/g" ./wp.conf