#! /bin/bash

# Turns the blade off before the wardrobe burns

OUT=$(sensors | awk -F':' '{ print $2 }' | awk -F'+' '{ print $2 }' | awk -F'°C' '{print $1}')
core1=$(echo $OUT | awk -F' ' '{ print $1 }')
int=${core1%.*}

if [ $int -gt 65 ];then

    sh -c "echo -e '\a' > /dev/console"
    sleep 1
fi

if [ $int -gt 75 ];then

    sh -c "echo -e '\a' > /dev/console"
    sleep 1
fi

if [ $int -gt 85 ];then

    sh -c "echo -e '\a' > /dev/console"
    sleep 1
    shutdown -h now
fi

if [ $int -gt 90 ];then

    shutdown -h now
fi

