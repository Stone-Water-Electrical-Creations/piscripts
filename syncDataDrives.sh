#! /bin/bash
usage() {
cat <<EOM
Usage:
  $(basename $0)  data-disk  "The name that showss up under the disk platter on your screen."
EOM
exit 0
}
[ $# -lt 1 ] && { usage; } 
remoteDir=/media/pi/$1/
# This script is used to sync data disks together with OneTB.
rsync -parzu --progress /media/pi/OneTB $remoteDir ; echo status $status
[ $? -eq 1 ] && exit "There was a failure syncing drive. please retry." || echo "$remoteDir sync successfuli, now syncing from  $remoteDir" 
rsync -parzu --progress $remoteDir /media/pi/OneTB ;echo status $status 
#get:
#    rsync -avuzb --exclude '*~' samba:samba/ .
#put:
#    rsync -Cavuzb . samba:samba/
#sync: get put
