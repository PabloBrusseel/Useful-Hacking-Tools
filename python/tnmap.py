#!/bin/python

# Use: python tnmap.py 10.0.0.0/16

import subprocess
import sys
import time
import netaddr

SUBNET_PREFIXLEN = 24 # Split into /24 networks. If you change this, remember to change the --min-hostgroup flag
ip = netaddr.IPNetwork(sys.argv[1])

if SUBNET_PREFIXLEN < ip.prefixlen:
	subnet_list = [ip,]
else:
	subnet_list = ip.subnet(SUBNET_PREFIXLEN)
	
for sub in subnet_list:
	cmd = ['nmap',
			'T4',		# use aggressive timings
			'--open',	# only return open ports
			'-sT',		# SYN scan
			'-n',		# don't attempt DNS sesolution
			'-vvv',		# super verbose
			' --min-rate=1000' # set min packet transmission rate
			' --min-hostgroup=254' # how many hosts to scan at the same time
			' --max-retries=2' # how many retries per hostgroup
			' -sC' # run script defaults
			' -PN',		# Treat all hosts as online (don't ping)
			' -oX', '~/out/%s_%s' % (sub.ip, sub.prefixlen), # XML output to stdout
			str(sub)
			]
	print ' '.join(cmd)
