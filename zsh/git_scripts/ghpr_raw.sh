#!/usr/bin/env bash

BASEDIR=$(dirname "$0")

gh pr list \
	-L 100 \
	--author "@me" \
	--state "open" \
	--json "number,title,reviewDecision,reviews,statusCheckRollup,headRefName" \
	-q "$(cat $BASEDIR/ghpr_raw_jq.jq)" \
	| column -t -s "@@"
