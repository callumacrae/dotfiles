#!/usr/bin/env bash

cache_file="${TMPDIR}/notifications-tmux-cache"

# cache for 10 seconds
if [ -f $cache_file ]; then
  cache_modified=$(date -r $cache_file +"%s")
  now=$(date +"%s")

  if (( $cache_modified > $now - 10 )); then
    cat $cache_file
    exit 0
  fi
fi

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

is_dnd=$(
  plutil -extract dnd_prefs xml1 -o - ~/Library/Preferences/com.apple.ncprefs.plist |
    xpath -q -e '//data/text()' |
    base64 -D |
    plutil -convert xml1 - -o - |
    xpath -q -e 'boolean(
        //key[text()="userPref"]
        /following-sibling::dict
        /key[text()="enabled"]
      )'
)

if [ $is_dnd -eq 1 ]; then
  echo "" > $cache_file
  exit 0
fi

dock_notifications=$(osascript $CURRENT_DIR/notifications-dock.scpt)
github_notifications=$(gh api notifications -q 'map(select(.unread)) | length')
notifications=$(( dock_notifications + github_notifications ))

output=""
if [ $notifications ]; then
  output="#[fg=brightwhite,bg=red,bold] ${notifications} "
fi
echo "$output"
echo "$output" > $cache_file
