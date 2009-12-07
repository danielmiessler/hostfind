#!/bin/bash

# Hostfind -- A lame tool for finding hostnames to
#  include in a scan

# Variables to be used
hostnames=`cat ./list`
domain=`cat ./domain`

# Prompt them
echo ""
echo "-------------------------------------------------------"
echo "- Hostfind -- A lame tool for finding hostnames to scan"
echo "-------------------------------------------------------"
sleep 1

echo ""
echo "Searching $domain..."
# Clean the previous hosts found
if [ -f ./dischosts ]
then 
   rm ./dischosts
fi

# Loop through the possible hostnames
for i in $hostnames
do
    nmap -sL $i.$domain >> dischosts 2> /dev/null
done

# Clean up the output
grep ^Host dischosts | cut -f2 >> cleanedhosts

# Display the results
echo ""
cat cleanedhosts
echo ""
echo "Enjoy..."

# Clean up for next time
rm cleanedhosts
