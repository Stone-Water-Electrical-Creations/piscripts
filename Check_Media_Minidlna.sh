#!/bin/bash
#checks to make sure the minidlna isnt empty and restarts it if it is.

files=`curl -s localhost:8200 | cut -d">" -f 22-24 | sed -e s/\>//g -e s/\<//g -e s/\\\///g | sed -e 's/td/ /g'| awk '{print $3}'`
[[ "$files" = "0" ]] && ( echo Minidlna has no files ; docker restart minidlna  ) || echo $files files available
