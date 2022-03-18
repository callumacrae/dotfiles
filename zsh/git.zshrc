[ -x "$(which hub)" ] && alias git=hub
fpath=(~/.zsh $fpath)

# TODO LIST:
# - nicer formatting
# - performance improvements
# - quit when zero notifications
ghn() {
	[ ! -x "$(which gh)" ] && echo "ghn relies on gh" && return 1

	notifications_cmd='gh api notifications -q "map(.id + \" \" + .repository.full_name + \" \" + .subject.title + \" (\" + .reason + \")\") | join(\"\\n\")"'

	# this could probably use graphql to save a request?
	get_thread_url="gh api notifications/threads/{1} -q '.subject.url[23:]'"
	get_pr_url="gh api \$(${get_thread_url}) -q '.html_url'"
	open_cmd="open \"\$(${get_pr_url})?notifications_query=is%3Aunread\""

	read_cmd="gh api -X PATCH notifications/threads/{1}"

	eval $notifications_cmd | fzf \
		--bind "enter:execute-silent(${open_cmd})+reload(${notifications_cmd}),ctrl-x:execute-silent(${read_cmd})+reload(${notifications_cmd}),ctrl-r:reload(${notifications_cmd})" \
		--header 'enter: open, ctrl+x: mark as read, ctrl+r: reload, ctrl+c: exit'
}
