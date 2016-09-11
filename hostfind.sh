#!/bin/bash

# "-------------------------------------------------------"
# "- Hostfind -- A lame tool for finding hostnames to scan"
# "- Takes a domain name and an optional dictionary file"
# "- of hostnames and does an iterative DNS lookup for"
# "- host.domain. Domains that have IPv4 address are printed"
# "- to stdout."
# "-------------------------------------------------------"

# Domain name is a requred argument.
# If not given, prompt with instructions and exit 1.
domain=$1
if [ -z "$domain" ]; then
    echo "Error: No domain specified" 1>&2
    echo "Usage: $0 domain [hostnames_file]" 1>&2
    echo "e.g. $0 microsoft.com" 1>&2
    echo "e.g $0 microsoft.com ./myhostnamefile" 1>&2
    exit 1
fi

# If no hostnames file is given as the second argument, use this default list.
hostnames=$2
if [ -z "$hostnames" ]; then
    hostnames="access citrix dns extranet firewall fw gateway mail mail1 mail2 ns ns1 ns2 pop3 proxy remote secure smtp ssh test www"
fi

for hostname in $hostnames; do
    host $hostname.$domain 2> /dev/null | grep "has address" | awk -v n=$hostname.$domain '{ print n, $4 }' &
done
