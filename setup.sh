#!/bin/bash

# Create shots folder
echo "Creating shots folder"
mkdir shots

# Compile usbreset
echo "Compiling usbreset"
cc usbreset.c -o usbreset
chmod +x usbreset
echo "Moving usbreset to /usr/local/bin"
cp usbreset /usr/local/bin

# configure autostart
currentFolder=$(pwd)
if ! grep -q trigger.py "/etc/rc.local"; then
	echo "Creating autostart entry in rc.local"
   	echo "sudo python $currentFolder/trigger.py &" >> /etc/rc.local
else
	echo "An entry for trigger.py was already found in rc.local. If it does not work delete the line in /etc/rc.local and execute this script again!"
fi
