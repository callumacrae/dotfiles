#!/usr/bin/env bash

repo=${1%"#"*}
number=${1#*"#"}

# todo add support for pr view when https://github.com/cli/cli/issues/5354 fixed
GH_FORCE_TTY=$FZF_PREVIEW_COLUMNS gh issue view --repo $repo $number --comments
