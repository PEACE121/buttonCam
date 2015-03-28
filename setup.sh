#!/bin/bash

# Compile usbreset
cc usbreset.c -o usbreset
chmod +x usbreset
cp usbreset /usr/local/bin

# configure autostart
currentFolder=$(pwd)
if ! grep -q trigger.py "/etc/rc.local"; then
   echo "sudo python $currentFolder/trigger.py &" >> /etc/rc.local
fi
