#/bin/bash

next=($(icalBuddy -nrd -std -n -li 1 -ea -eed -nc -b '' -iep "title,datetime" -po "datetime,title" -ps '| |' -tf "%Y-%m-%d %H:%M" eventsToday))

timestampNext=$(date -j -f "%Y-%m-%d %H:%M:%S" "${next[0]} ${next[1]}:00" +%s)
timestampNow=$(date +%s)

(( until=(timestampNext - timestampNow) / 60 ))

if [ $until -lt 10 ]; then
	echo "#[fg=yellow]\c"
fi
if [ $until -lt 60 ]; then
	echo " " ${next[@]:1:21}
fi
