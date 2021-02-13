#!/bin/bash

usage() {
cat <<EOM
Usage: 

$(basename $0)  "USB disk name"

EOM
exit 0
}
[ $# -lt 1 ] && { usage; }
#First lets check for the options
disk=$1
if [ -d /media/pi/${disk}1 ] ; then
	docker stop minidlna
	hw_addr=`df | grep ${disk}1 | awk '{print $1}'`
    eatit=`df | grep $disk | grep -v grep | awk '{print $1}'`
	[[ $eatit != "" ]] && sudo umount $hw_addr
    sudo rm -rf /media/pi/$disk
	udisksctl mount -b  $hw_addr
	docker start minidlna
fi	
