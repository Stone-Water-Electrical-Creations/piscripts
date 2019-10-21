#!/bin/bash
transmission-remote -l | egrep "Seeding|Done" | awk '{print $1}' | while read kill 
do 
echo $kill is seeding
   transmission-remote -t$kill --stop
   transmission-remote -t$kill --remove
done
