<?php

echo shell_exec("/usr/sbin/hddtemp -f /usr/share/hddtemp/hddtemp.db -n /dev/hda -q")
    .shell_exec("/usr/sbin/hddtemp -f /usr/share/hddtemp/hddtemp.db -n /dev/hda -q");
