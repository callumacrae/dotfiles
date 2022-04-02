#!/usr/bin/env bash

thread_id=$(cat $TMPDIR/ghn_cache_data.json | jq '.["'$1'" | gsub("/|-|#"; "")] | .threadId')
gh api -X PATCH notifications/threads/$thread_id
