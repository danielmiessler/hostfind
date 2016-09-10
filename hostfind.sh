#!/bin/bash

# Hostfind -- A lame tool for finding hostnames to
#  include in a scan

# Variables to be used
hostnames=$(cat ./list)

domain=$(cat ./domain)

# Banner
echo ""
echo "-------------------------------------------------------"
echo "- Hostfind -- A lame tool for finding hostnames to scan"
echo "-------------------------------------------------------"

echo ""
echo "Searching $domain..."

# Loop through the given hostnames
for hostname in $hostnames
do
    ipaddress=$(host $hostname.$domain 2> /dev/null | grep "has address" | cut -d" " -f4)

    if [ ! -z "$ipaddress" ]; then

        #echo $hostname.$domain:$ipaddress

	#Keep original functionality
        echo $hostname.$domain
    fi

done
