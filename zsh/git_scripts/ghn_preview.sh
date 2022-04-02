#!/usr/bin/env bash

repo=${1%"#"*}
number=${1#*"#"}

notif_type=$(cat $TMPDIR/ghn_cache_data.json | jq '.["'$1'" | gsub("/|-|#"; "")] | .type')
if [ $notif_type = "PullRequest" ]; then
	cmd="pr"
else
	cmd="issue"
fi
GH_FORCE_TTY=$FZF_PREVIEW_COLUMNS gh $cmd view --repo $repo $number --comments
