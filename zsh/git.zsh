[ -x "$(which hub)" ] && alias git=hub
fpath=(~/.zsh $fpath)

BASEDIR=$(dirname "$0")

preview_height() {
	if (( LINES > 20 )); then
		echo "80%"
	else
		echo "50%"
	fi
}

# TODO LIST:
# - multi-select?
# - unsubscribe
ghn() {
	[ ! -x "$(which gh)" ] && echo "ghn relies on gh" && return 1
	[ ! -x "$(which fzf)" ] && echo "ghn relies on fzf" && return 1

	$BASEDIR/git_scripts/ghn_raw.sh | fzf \
		--bind "enter:execute-silent($BASEDIR/git_scripts/ghn_open.sh {1})+reload:$BASEDIR/git_scripts/ghn_raw.sh" \
		--bind "ctrl-t:execute-silent($BASEDIR/git_scripts/ghn_open.sh {1})+reload:$BASEDIR/git_scripts/ghn_raw.sh" \
		--bind "ctrl-x:execute-silent($BASEDIR/git_scripts/ghn_mark_read.sh {1})+reload:$BASEDIR/git_scripts/ghn_raw.sh" \
		--bind "ctrl-r:reload:$BASEDIR/git_scripts/ghn_raw.sh" \
		--header "enter: open in browser, ctrl+x: mark as read, ctrl+r: reload, esc: exit" \
		--preview "$BASEDIR/git_scripts/ghn_preview.sh {1}" \
		--preview-window "up,$(preview_height),~3" \
		--bind "ctrl-u:preview-half-page-up" \
		--bind "ctrl-d:preview-half-page-down" \
		--ansi --exit-0
}

ghpr() {
	[ ! -x "$(which gh)" ] && echo "ghpr relies on gh" && return 1
	[ ! -x "$(which fzf)" ] && echo "ghpr relies on fzf" && return 1

	# todo change preview back to gh pr view when https://github.com/cli/cli/issues/5354 fixed
	$BASEDIR/git_scripts/ghpr_raw.sh \
		| fzf \
				--bind "ctrl-t:execute-silent(gh pr view {1} --web)"  \
				--header "enter: checkout, ctrl+t: open in browser, ctrl+u: scroll preview up, ctrl+d: scroll preview down, esc: exit" \
				--preview "GH_FORCE_TTY=\$FZF_PREVIEW_COLUMNS gh issue view {1} --comments" \
				--preview-window "up,$(preview_height),~3" \
				--bind "ctrl-u:preview-half-page-up" \
				--bind "ctrl-d:preview-half-page-down" \
				--ansi \
		| awk 'NF>1{print $NF}' \
		| xargs git checkout
}
