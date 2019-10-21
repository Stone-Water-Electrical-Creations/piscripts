tmpfile=$(mktemp)
chmod a+x $tmpfile
echo "killall transmission-cli" > $tmpfile
transmission-cli -f $tmpfile $1
