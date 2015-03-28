#!/bin/bash

# You need to configure these parameters
# Execute 'lsusb' in the command line and search for the line of the connected camera!
bus="001"
device="004"

usbreset /dev/bus/usb/$bus/$device
gphoto2 --capture-image-and-download --filename shots/shot_%y%m%d%H%M%S.jpg
processFeh=$(pidof feh)
echo "instance: $processFeh"
/usr/bin/feh --hide-pointer --quiet --recursive --reverse --sort name --full-screen --slideshow-delay 5 'shots' &
sleep 10 && kill $processFeh &

