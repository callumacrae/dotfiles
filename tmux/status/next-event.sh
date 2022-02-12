#/bin/bash

next=$(icalBuddy -std -n -li 1 -ea -eed -nc -b '' -ps '| |' eventsToday)

if [[ ! -z "$next" ]]; then
	echo " " $next
fi
