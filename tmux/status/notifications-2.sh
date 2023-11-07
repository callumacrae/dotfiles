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

week_day=$((10#$(date +"%u")))
hour=$((10#$(date +"%H")))

office_hours=$(( week_day < 6 && hour >= 9 && hour < 18))

notifications=""

dock_notifications=$(osascript $CURRENT_DIR/notifications-dock.scpt)
[[ "$dock_notifications" -gt 0 ]] && notifications="${notifications}  ${dock_notifications}"

if [ $office_hours -eq 1 ]; then
  github_notifications=$(gh api notifications -q 'map(select(.unread)) | length')
  [[ "$github_notifications" -gt 0 ]] && notifications="${notifications}  ${github_notifications}"

  # notion_notifications=$($CURRENT_DIR/notifications-notion.sh)
  # [[ "$notion_notifications" -gt 0 ]] && notifications="${notifications}  ${notion_notifications}"
fi

# email_notifications=$(cat $TMPDIR/himalaya-counter)
# [[ "$email_notifications" -gt 0 ]] && notifications="${notifications}  ${email_notifications}"

output=""
if [[ ! -z "$notifications" ]]; then
  output="#[fg=brightwhite,bg=red,bold]${notifications} "
fi
echo "$output"
echo "$output" > $cache_file
