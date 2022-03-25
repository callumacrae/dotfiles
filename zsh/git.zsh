[ -x "$(which hub)" ] && alias git=hub
fpath=(~/.zsh $fpath)

# todo - zsh specific
BASEDIR=$(dirname "${(%):-%x}")

# TODO LIST:
# - quit when zero notifications
# - multi-select?
ghn() {
	[ ! -x "$(which gh)" ] && echo "ghn relies on gh" && return 1
	[ ! -x "$(which fzf)" ] && echo "ghn relies on fzf" && return 1

	$BASEDIR/git_scripts/ghn_raw.sh | fzf \
		--bind "enter:execute-silent($BASEDIR/git_scripts/ghn_open.sh {1})+reload:$BASEDIR/git_scripts/ghn_raw.sh" \
		--bind "ctrl-t:execute-silent($BASEDIR/git_scripts/ghn_open.sh {1})+reload:$BASEDIR/git_scripts/ghn_raw.sh" \
		--bind "ctrl-x:execute-silent($BASEDIR/git_scripts/ghn_mark_read.sh {1})+reload:$BASEDIR/git_scripts/ghn_raw.sh" \
		--bind "ctrl-r:reload:$BASEDIR/git_scripts/ghn_raw.sh" \
		--header 'enter: open in browser, ctrl+x: mark as read, ctrl+r: reload, esc: exit' \
		--ansi --exit-0
}

ghpr() {
	[ ! -x "$(which gh)" ] && echo "ghpr relies on gh" && return 1
	[ ! -x "$(which fzf)" ] && echo "ghpr relies on fzf" && return 1

	$BASEDIR/git_scripts/ghpr_raw.sh \
		| fzf \
				--bind "ctrl-t:execute-silent(gh pr view {1} --web)"  \
				--header 'enter: checkout, ctrl+t: open in browser, esc: exit' \
				--ansi \
		| awk 'NF>1{print $NF}' \
		| xargs git checkout
}
