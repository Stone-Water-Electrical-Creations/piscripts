ls -lA | grep ^dr |sed -e s/"   "/" "/g -e s/"  "/" "/g|cut -d" " -f9- | while read dir ; 
do
  dup=`ls | grep "$dir" | wc -l`
  if [ $dup -gt 1 ] ; then
    ls -lA| grep "$dir" | grep -v ^d |sed -e s/"   "/" "/g -e s/"  "/" "/g|cut -d" " -f9- | while read line
    do
    dir=`echo "$line" | cut -d"-" -f1`
  echo   mv "$line" "$dir" 
    done
  #else
    #echo "$dir: no files to move"
  fi
done
