#!/bin/bash

if [ "$(id -u)" != "0" ]; then
	echo "Please execute the script with sudo"
	exit 1
fi

/usr/bin/feh --hide-pointer --quiet --full-screen --slideshow-delay 500 'animationShoot' &
sleep 2 
/usr/bin/feh --hide-pointer --quiet --full-screen --slideshow-delay 500 'animationArrows' &
sleep 3 && /usr/bin/feh --hide-pointer --quiet --full-screen --slideshow-delay 500 'animationProcess' &

autoDetect=$(gphoto2 --auto-detect)
busDevice=$(echo ${autoDetect} | sed "s/.*${usb} \([^ ]*\).*$/\1/")
bus=$(echo ${busDevice} | sed 's/usb\:\(0[0-9]*\),\(0[0-9]*\)/\1/')
device=$(echo ${busDevice} | sed 's/usb\:\(0[0-9]*\),\(0[0-9]*\)/\2/')

usbreset /dev/bus/usb/$bus/$device

#datestring=$(date %y%m%d%H%M%S)
#fileOnCamera="shots/shot_$datestring.jpg"

gphoto2 --set-config main/capturesettings/flashmode=0

usbreset /dev/bus/usb/$bus/$device
gphoto2 --capture-image-and-download --filename shots/shot_%y%m%d%H%M%S.jpg 
processFeh=$(pidof feh)
export DISPLAY=:0.0 
echo "instance: $processFeh"
export XAUTHORITY=/home/pi/.Xauthority
/usr/bin/feh --hide-pointer --quiet --recursive --reverse --sort name --full-screen --slideshow-delay 5 'shots' &
sleep 10 && kill $processFeh &

