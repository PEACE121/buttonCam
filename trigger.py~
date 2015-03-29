#!/usr/bin/env python

import time
import RPi.GPIO as GPIO
import os
import subprocess
from time import sleep     # this lets us have a time delay (see line 12)

#sleep(10)
GPIO.setmode(GPIO.BCM)     # set up BCM GPIO numbering
GPIO.setup(25, GPIO.IN)    # set GPIO 25 as input

pressed = False

lt = time.localtime()
jahr, monat, tag, stunde, minute, sekunde = lt[0:6]
timestring = "shots/%04i%02i%02i_%02i%02i%02i" % (jahr,monat,tag,stunde,minute,sekunde)

if not os.path.exists("shots"):	
	os.mkdir("shots")
#os.mkdir(timestring)
os.environ.setdefault('XAUTHORITY', '/home/pi/.Xauthority') 
os.environ.setdefault('DISPLAY', ':0.0') 

os.system("killall feh")
os.system("gphoto2 --auto-detect")
try:
    while True:            # this will carry on until you hit CTRL+C
        if GPIO.input(25): # if port 25 == 1
	    if not pressed:
		os.system("buttonPressed.sh")

		pressed = True;
            	print "Port 25 is 1/GPIO.HIGH/True - button pressed"
        else:
	    pressed = False;
        sleep(0.1)         # wait 0.1 seconds

except KeyboardInterrupt:
    GPIO.cleanup()         # clean up after yourself

