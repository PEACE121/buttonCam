#!/bin/bash

if [ "$(id -u)" != "0" ]; then
	echo "Please execute the script with sudo"
	exit 1
fi

autoDetect=$(gphoto2 --auto-detect)
busDevice=$(echo ${autoDetect} | sed "s/.*${usb} \([^ ]*\).*$/\1/")
bus=$(echo ${busDevice} | sed 's/usb\:\(0[0-9]*\),\(0[0-9]*\)/\1/')
device=$(echo ${busDevice} | sed 's/usb\:\(0[0-9]*\),\(0[0-9]*\)/\2/')

usbreset /dev/bus/usb/$bus/$device
gphoto2 --capture-image-and-download --filename shots/shot_%y%m%d%H%M%S.jpg
processFeh=$(pidof feh)
echo "instance: $processFeh"
export DISPLAY=:0.0 
export XAUTHORITY=/home/pi/.Xauthority
/usr/bin/feh --hide-pointer --quiet --recursive --reverse --sort name --full-screen --slideshow-delay 5 'shots' &
sleep 10 && kill $processFeh &

