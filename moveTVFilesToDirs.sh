#! /bin/bash
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
    dir=`echo $filename|awk -F\- '{print $1}'|sed -e 's/ The //g' -e 's/ /\\ /g'`
    echo mv `echo $filename|sed -e 's/ /\\\ /g'` `echo $dir|sed -e 's/ /\\\ /g'`>> rm.tmp 
done 
bash rm.tmp 
rm rm.tmp
