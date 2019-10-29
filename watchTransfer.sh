#!/bin/bash
usage() {
cat <<EOM
  Usage:
    $(basename $0) Full-Dir Copy-to-Dir

EOM
exit 0
}
[ $# -lt 2 ] && { usage; }
export time=1
for d in $1 $2
do
  case "$time"  in
      1)  Firstsize=`du -sk $d | awk '{print $1}' | sed -e s/M//g` ;
         Firstfiles=`find $d -type f  | wc -l` ;;
      2) Secondsize=`du -sk $d | awk '{print $1}' | sed -e s/M//g` ;
         Secondfiles=`find $d -type f  | wc -l` ;;

  esac
 ((time++))
done
echo "Files,Disk  -  Files, Disk  -  Remaining Files Disk" 
if  (( "$Firstsize" > "$Secondsize" )) ; then
    echo -n $Firstfiles $Firstsize $Secondfiles $Secondsize"  =  "
    echo `expr $Firstfiles - $Secondfiles`" " `expr $Firstsize - $Secondsize` "  Remaining"
else 
    echo -n $Secondsfiles $Secondsize  $Rirstfiles $Firstsize "  =  "
    echo `expr $Secondsfiles - $Firstfiles` " " `expr $Secondsize - $Firstsize ` "  Remaining"
fi
