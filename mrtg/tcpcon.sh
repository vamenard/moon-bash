
if [ "$1" = "" ] ; then
	O=`/bin/netstat -nt | fgrep ESTABLISHED | wc -l`
	label='numconns'
	else
	O=`/usr/bin/netstat -nt | fgrep ESTABLISHED | fgrep "$1" | wc -l`
	                                  label="$1"
	                                    fi
	                            echo $O
	                       echo $O
	                               UPTIME=/usr/bin/uptime
	                              AWK=/usr/bin/awk

                      $UPTIME | $AWK -F', ' '{print $1}' | $AWK -F' up ' '{print $2 "\nmrtg2.heptacube.com"}'

