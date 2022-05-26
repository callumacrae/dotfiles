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

g() {
	if [ "${#*[@]}" -ne 0 ]
		then git $@
		else git status
	fi
}

alias gp="git push"
alias gpu="git push -u origin HEAD"
alias gpf="git push --force-with-lease origin HEAD"
alias gpr="git pr create --web"

# using nvim for git commit so gc is available for checkout
alias gc="git checkout"

_fzf_complete_gc() {
	local branches=$(git branch -v --color=always)
	_fzf_complete --reverse --multi --ansi -- "$@" < <(echo $branches)
}

_fzf_complete_gc_post() {
	awk '{print $1}'
}

_fzf_complete_g() {
	ARGS="$@"
	if [[ $ARGS == 'g revert'* ]]; then
		local commits=$(
			git log --pretty='format:%C(auto)%h %s %C(dim)%ad%Creset' --date=relative --color=always
		)
		_fzf_complete --reverse --multi --ansi -- "$@" < <(echo $commits)
	else
		eval "zle ${fzf_default_completion:-expand-or-complete}"
	fi
}

_fzf_complete_g_post() {
	awk '{print $1}'
}

alias gs="git stash"
alias gsa="git stash apply"
alias gsl="git stash list"

_fzf_complete_gsa() {
	local stashes=$(
		git stash list --pretty="%C(yellow)%h %>(14)%Cgreen%cr %C(blue)%gs" --color=always
	)
	_fzf_complete --reverse --multi --ansi -- "$@" < <(echo $stashes)
}

_fzf_complete_gsa_post() {
	awk '{print $1}'
}
