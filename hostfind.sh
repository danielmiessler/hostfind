#!/bin/bash

#  -------------------------------------------------------
#  Hostfind -- A lame tool for finding hostnames to scan
#
#  Takes a domain name and an optional dictionary file
#  of hostnames and does an iterative DNS lookup for
#  host.domain.
#
#  If no hostname file is provided by the user, Daniel
#  Miessler's original list is hardcoded as a default list.
#
#  Domains that have IPv4 address are printed
#  to stdout.
#
#  Original work by: Daniel Miessler
#  Refactored by: Zachary Keeton
#
#  -------------------------------------------------------

# Read in the domain name (eg. 'microsoft.com'). REQUIRED
domain=$1

# If domain name not given, prompt with instructions and exit 1.
if [ -z "$domain" ]; then
    echo "Error: No domain name specified" 1>&2
    echo "Usage: $0 domain_name [hostnames_file]" 1>&2
    exit 1
fi

# Read in the file of host names. OPTIONAL
hostnames=$2

# If no hostnames file is given as the second argument, use this default list.
if [ -z "$hostnames" ]; then
    hostnames="access citrix dns extranet firewall fw gateway mail mail1 mail2 ns ns1 ns2 pop3 proxy remote secure smtp ssh test www"
fi

for hostname in $hostnames; do
    host $hostname.$domain 2> /dev/null | grep "has address" | awk -v n=$hostname.$domain '{ print n, $4 }' &
done
