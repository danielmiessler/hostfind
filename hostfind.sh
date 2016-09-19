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

usage () {
    echo "$PROGRAM_NAME: usage: $PROGRAM_NAME [[-f file] domain_name] | -h"
	echo
	echo "-f|--file		a file of host names. optional. Defaults to Miessler original"
	echo "-h|--help		display this help and exit"
	echo "domain		the domain to test"
	echo
	echo "Examples:"		
	echo "			hostfind.sh -f mylist microsoft.com"
	echo "			hostfind.sh microsoft.com"
    return
}

PROGRAM_NAME=$(basename $0)
hostnames="access citrix dns extranet firewall fw gateway mail mail1 mail2 ns ns1 ns2 pop3 proxy remote secure smtp ssh test www"
domain=

while [[ -n $1 ]]; do
	case $1 in
		-f|--file)
			shift
			hostnames=$(cat $1)
			shift
			;;
		-h|--help)
			usage
			exit
			;;
		*)
			domain=$1
			shift
			;;
	esac
done

if [ -z "$domain" ]; then
    usage >&2
    exit 1
fi

for hostname in $hostnames; do
    host $hostname.$domain 2> /dev/null | grep "has address" | awk -v n=$hostname.$domain '{ print n, $4 }' &
done
