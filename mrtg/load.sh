#!/bin/sh
##
## Simple script to pull the 1 minute and 5 minute load averages
## as reported by 'uptime'
## Field 10 (for awk) is 1min loadavg, 11 is 5min, 12 is 15min
##
UPTIME=/usr/bin/uptime
AWK=/usr/bin/awk
#$UPTIME | $AWK -F: '{print $5}' 
$UPTIME | $AWK -F: '{print $5}' | $AWK -F',' '{ print $1*100 "\n" $2*100}'
$UPTIME | $AWK -F', ' '{print $1}' | $AWK -F' up ' '{print $2 "\nweb2.heptacube.com"}'
#
##EOF

