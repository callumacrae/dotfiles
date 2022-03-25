#!/usr/bin/env bash

pr_url=$(cat $TMPDIR/ghn_cache_data.json | jq -r ".[\"$1\" | gsub(\"/|-|#\"; \"\")] | .url")
open "${pr_url}?notifications_query=is%3Aunread"
