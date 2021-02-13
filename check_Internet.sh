#!/bin/bash
# turn on the fanwhen its warm, turn it off when cold
	check_internet=`ifconfig usb0`
              
	if [ $? = 0  ] ; then 
         #this means internet is up/green
		raspi-gpio  set 16 out
		raspi-gpio set  16 pu
		raspi-gpio set 12 out
		raspi-gpio write 12 dl
		mpg123 -q /media/pi/mediafiles/internet-up.mp3
	else 
         #this means internet is down/red
		raspi-gpio set 16 out
		raspi-gpio set 16 dl
		raspi-gpio set 12 out
		raspi-gpio set 12 pu
		mpg123 -q /media/pi/mediafiles/internet-down.mp3
	fi
