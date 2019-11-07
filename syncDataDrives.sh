#! /bin/bash 
usage() {
cat <<EOM
Use Case : when you need to sync the master drive with remote drives for new content
Usage:
  $(basename $0)  source-disk your-data-disk  "The name that showss up under the disk platter on your screen."
EOM
exit 0
}
[ $# -lt 1 ] && { usage; } 
remoteDir=/media/pi/$2/
sourceDir=/media/pi/$1/
# This script is used to sync data disks together with a master disk.
rsync -parz --progress $sourceDir  $remoteDir
echo "Sync to $remoteDir successful, now syncing from $remoteDir" 
rsync -parz --progress $remoteDir $sourceDir
