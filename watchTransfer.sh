#!/bin/bash
usage() {
cat <<EOM
  Usage:
    $(basename $0) [-c 5] -o Full-Dir -n Copy-to-Dir 

        -c Count  - optional, if ommmited it will run continuosly
        -o the Old Directory or directory transferring from 
        -n  the new directory you are copying to.
        -h or ? This message
EOM
exit 0
}
[ $# -lt 2 ] && { usage; }
export time=1
while [[ "$#" -gt 0 ]]
do
    arg=$1
    case $arg in
        -c)
            count=$2 ; shift ;shift;;
        -o)
            fullDir=$2 ; shift ; shift ;;
        -n) 
            newDir=$2 ; shift;shift;;
        -h|\?)
            usage
            exit 0
    esac    
done
echo "Remaining Files   Disk Space" 
mycount=0
realcount=0
[[ $count -eq "" ]] && realcount=`expr $mycount + 1` || realcount=$count
while [ $realcount -gt $mycount ]
do
sleep 10
  for d in $fullDir $newDir
  do
    case "$time"  in
      1)  Firstsize=`du -sk $d | awk '{print $1}' | sed -e s/M//g` ;
         Firstfiles=`find $d -type f  | wc -l` ;;
      2) Secondsize=`du -sk $d | awk '{print $1}' | sed -e s/M//g` ;
         Secondfiles=`find $d -type f  | wc -l` ;;

    esac
    ((time++))
  done
  if  (( "$Firstsize" > "$Secondsize" )) ; then
      files=`expr $Firstfiles - $Secondfiles` 
      size=`expr $Firstsize - $Secondsize` 
  else 
      files=`expr $Secondsfiles - $Firstfiles` 
      size=`expr $Secondsize - $Firstsize `
  fi
      echo $files"               " $size 
  ((mycount++))
[[ $count -eq "" ]] && realcount=`expr $mycount + 1`
done
