#!/usr/bin/env bash

cache_file="/tmp/next-event-tmux-cache"

# icalBuddy isn't very CPU friendly so cache until next 10 minutes (HH:M*)
if [ -f $cache_file ]; then
  cache_modified=$(date -r $cache_file +"%H:%M")
  now=$(date +"%H:%M")

  if [[ ${cache_modified:0:4} = ${now:0:4} ]]; then
    cat $cache_file
    exit 0
  fi
fi

next=($(icalBuddy -nrd -std -n -li 1 -ea -eed -nc -b '' -iep "title,datetime" -po "datetime,title" -ps '| |' -tf "%Y-%m-%d %H:%M" eventsToday))

if [ -z $next ]; then
  echo "" > $cache_file
  exit 0
fi

timestampNext=$(date -j -f "%Y-%m-%d %H:%M:%S" "${next[0]} ${next[1]}:00" +%s)
timestampNow=$(date +%s)

(( until=(timestampNext - timestampNow) / 60 ))

if [ $until -lt 0 ]; then
  color="#[fg=red]"
elif [ $until -lt 10 ]; then
  color="#[fg=yellow]"
fi
output="$color  "
if [ $until -lt 60 ]; then
  output="$output ${next[@]:1:21}"
fi
echo $output
echo $output > $cache_file
