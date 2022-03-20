[ -x "$(which hub)" ] && alias git=hub
fpath=(~/.zsh $fpath)

ghn_raw() {
	PR_OPEN=""
	PR_MERGED=""
	ISSUE=""

	gh api notifications -q '
		def colors: {
			"reset": "\033[0m", "dim": "\033[2m", "green": "\033[0;32m", "white": "\033[1;37m"
		};
		map(
			colors.dim + .id + " " + colors.reset + colors.green + .repository.full_name
				+ " " + colors.white + .subject.title + colors.reset + colors.dim
				+ "(" + .reason + ")" + colors.reset
		)
			| join("\n")'
}

# this could probably use graphql to save a request?
ghn_open() {
	thread_url=$(gh api notifications/threads/{1} -q ".subject.url[23:]")
	pr_url=$(gh api "${thread_url}" -q ".html_url")
	open "${pr_url}?notifications_query=is%3Aunread"
}

ghn_mark_read() {
	gh api -X PATCH notifications/threads/{1}
}

# TODO LIST:
# - performance improvements
# - quit when zero notifications
# - show status: e.g. merged, unmerged (icon? :D)
ghn() {
	[ ! -x "$(which gh)" ] && echo "ghn relies on gh" && return 1
	[ ! -x "$(which fzf)" ] && echo "ghn relies on fzf" && return 1

	# export -f isn't supported in ZSH D:
	notifications_cmd="$(typeset -f ghn_raw | sed '1,1d;$d')"
	open_cmd="$(typeset -f ghn_open | sed '1,1d;$d')"
	read_cmd="$(typeset -f ghn_mark_read | sed '1,1d;$d')"

	ghn_raw | fzf \
		--bind "enter:execute-silent(${open_cmd})+reload:${notifications_cmd}" \
		--bind "ctrl-x:execute-silent(${read_cmd})+reload:${notifications_cmd}" \
		--bind "ctrl-r:reload:${notifications_cmd}" \
		--header 'enter: open, ctrl+x: mark as read, ctrl+r: reload, esc: exit' \
		--ansi
}
