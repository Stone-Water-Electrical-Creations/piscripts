#!/bin/bah

usage() {
cat <<EOM
Usage: 

$(basename $0) "mount dir"  ie the Disk Icon Name

EOM
}
[ $# -lt 1 ] && { usage; }

#First lets check for the options
while getopts ":ht" opt; do
  case ${opt} in
    h ) echo " process option h"
      ;;
    t ) echo " process option t"
      ;;
    \? )  { usage; }
      ;;
  esac
done
