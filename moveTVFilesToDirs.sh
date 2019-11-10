#! /bin/bash
if [ "$2" = "debug" ] ; then
    set -xv
fi
usage() {
cat <<EOM
Usage:
$(basename $0) your-data-disk  "The name that showss up under the disk platter on your screen."
EOM
exit 0
}
[ $# -lt 1 ] && { usage; }
sourceDir=/media/pi/$1/TV
cd $sourceDir
touch rm.tmp 
find .  -maxdepth 1 -type f | egrep -v '.fuse|rm.tmp' | while read filename
do 
set -xv
    dir=`echo $filename|awk -F\- '{print $1}'`
    dir=`echo $dir |sed -e 's/ The//g' | sed -e 's/ /\\ /g' | sed -e 's/.\///g' |sed -e 's/ ^//g'`
    ls "$dir" &>/dev/null
    if [ $? = 2 ] ; then
        echo "$dir"
        echo mkdir "$dir">> rm.tmp
    fi
    echo mv `echo $filename|sed -e 's/ /\\\ /g'` `echo $dir|sed -e 's/ /\\\ /g'`>> rm.tmp 
    set +xv
done 
if [ "$2" = "debug" ] ; then
   more rm.tmp
   rm rm.tmp
   set +xv
   exit 0
else
    bash rm.tmp 
    rm rm.tmp
fi
