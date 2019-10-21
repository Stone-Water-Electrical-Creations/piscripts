#!/sbin/bash
echo $#   args
if [ $# -lt 1 ] ; then
echo "Usage $0 <device name>"  
echo " Where device  ex sda1 , defaults to all if left blank"
fi
disk=$1
while :
do 
echo "Device            r/s     w/s     rkB/s     wkB/s   rrqm/s   wrqm/s  %rrqm  %wrqm r_await w_await aqu-sz rareq-sz wareq-sz  svctm  %util"
iostat -dx $disk 1 10 | egrep -v "Device|mediacnterpi"
done
