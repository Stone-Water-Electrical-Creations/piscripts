for d in extdata 4TB
do
export totalsize=0 
  for size in `du -sk /media/pi/$d/Movies | awk '{print $1}' | sed -e s/M//g `
    do 
      totalsize=$[ totalsize + size ] 
    done 
var=${d}totalsize
echo $var
  echo $totalsize 
$var=`echo $totalsize`
done
echo $extdatatotalsize $4TBtotalsize
