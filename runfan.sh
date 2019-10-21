#!/sbin/bash
# turn on the fanwhen its warm, turn it off when cold
while :
do
	sleep 15
	TEMP=$(printf "%.0f" `vcgencmd measure_temp | tr -d "temp='C')`

	if [ $TEMP -ge 83 ] ; then 
		gpio -g mode 17 out
		gpio -g write 17 1
	
	elif [ $TEMP -le 80 ]; then
		gpio -g mode 17 out
		gpio -g mode 17 0
	fi
done
