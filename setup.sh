#!/bin/bash

if [ "$(id -u)" != "0" ]; then
	echo "Please execute the script with sudo"
	exit 1
fi

# Install the dependencies
sudo apt-get install build-essential libgphoto2-2-dev libexif-dev libboost-dev libboost-system-dev libmicrohttpd-dev gphoto2 feh

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
	# Delete the exit 0 line
	sed -i '/exit 0/d' /etc/rc.local
	# Configure that the log of the trigger.py script is saved in the file 
	echo "exec 2> $currentFolder/trigger.log      # send stderr from rc.local to a log file" >> /etc/rc.local
	echo "exec 1>&2                      # send stdout to the same log file" >> /etc/rc.local
	echo "set -x                         # tell sh to display commands before execution" >> /etc/rc.local
   	# Execute trigger.py script
	echo "cd $currentFolder" >> /etc/rc.local
	echo "sudo python trigger.py &" >> /etc/rc.local
	# Restore the exit 0	
	echo "exit 0" >> /etc/rc.local
else
	echo "An entry for trigger.py was already found in rc.local. If it does not work delete the line in /etc/rc.local and execute this script again!"
fi

echo "Setup finished. Check the log for errors"
