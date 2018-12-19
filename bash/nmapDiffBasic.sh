#!/bin/bash

# Schedule this script as a cron job and monitor /opt/nmap_diff/diff.txt for changes

mkdir /opt/nmap_diff

CIDR_NETWORK='10.0.0.0/16'

d=$(date +%Y-%m-%d)
y=$(date -d yesterday +%Y-%m-%d)

/usr/bin/nmap -T4 -oX /opt/nmap_diff/scan_$d.xml $CIDR_NETWORK > /dev/null 2>&1
if [ -e /opt/nmap_diff/scan_$y.xml ]; then
	/usr/bin/ndiff /opt/nmap_diff/scan_$y.xml /opt/nmap_diff/scan_$d.xml > /opt/nmap_diff/diff.txt
fi
