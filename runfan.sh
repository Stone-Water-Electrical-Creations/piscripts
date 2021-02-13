#!/bin/bash
# turn on the fanwhen its warm, turn it off when cold
while :
do
	sleep 15
	TEMP=$(printf "%.0f" `vcgencmd measure_temp | tr -d "temp='C'"`)

	if [ $TEMP -ge 59 ] ; then 
		echo $TEMP Fanon
		gpio -g mode 18 out
		gpio -g write 18 1
	
	elif [ $TEMP -lt 50 ]; then
		echo $TEMP Fanoff
		gpio -g mode 18 out
		gpio -g mode 18 0
	fi
done
