#!/sbin/bash
if [ $# -lt 1 ] 
  then
  echo "Usage $0 <text to searh for>"
  exit 1
fi
while true
  do
  proc=`ps -ef | grep $1 | egrep -v "grep|keepkilling"`
  [[ -z $proc ]] && exit 1
  echo $proc | awk '{print $0}' 
  sudo kill -9 `echo $proc | awk '{print $2}'`
  sleep 1
done
