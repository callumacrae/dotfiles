#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
export $(cat $CURRENT_DIR/../../secrets.sh | xargs)

curl 'https://www.notion.so/api/v3/getUserNotifications' \
  -H 'content-type: application/json' \
  -H "cookie: $NOTION_COOKIE" \
  --silent \
  --data-raw '{"size":1000}' | jq -r '
  def unreadForSpace:
    reduce (.unread | to_entries[]) as {$key,$value} (0; . += $value);
  reduce .results[] as $space (0; . += ($space | unreadForSpace))'
