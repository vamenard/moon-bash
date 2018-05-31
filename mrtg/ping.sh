#!/bin/sh
PING="/bin/ping"
ADDR="heptacube.ca"
DATA=`$PING -c10 -s500 $ADDR -q `
LOSS=`echo $DATA | awk '{print $18 }' | tr -d %`
echo $LOSS
if [ $LOSS = 100 ];
then echo 0
else
echo $DATA | awk -F/ '{print $5 }'
fi
