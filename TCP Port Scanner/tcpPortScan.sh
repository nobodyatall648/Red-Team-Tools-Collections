#!/bin/bash

#Script will scan for open ports on the target host

#global var
host="$1"
counter=0

# this function is called when Ctrl-C is sent
function trap_ctrlc ()
{
    # perform cleanup here
    echo
    echo
    echo "[^C] Ctrl-C Captured."
 
    echo "[*] Exiting TCP Port Scanner..."
 
    exit 2
}
 
trap "trap_ctrlc" 2

#perform TCP port scanning from 1-65535 port ranges
for port in {1..65535}; do
	if timeout 5 bash -c "(</dev/tcp/$host/$port) &>/dev/null " ; then
		echo "[*] $port Port Open."
		((counter++))
	# un-comment this block of code: include close port statement printing 
	# else
	# 	echo "[!] $port Port Closed."
	fi
done

echo "================================="
echo "[*] Completed All Ports Scanning."
echo "Port Detected Open: $counter"
