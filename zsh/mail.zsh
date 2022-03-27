mail() {
  SEARCH_QUERY='
    if [[ "{q}" = "'\'''\''" || "{q}" = "$(echo {)q}" ]]; then
      script -t 0 -q /dev/null himalaya list -s 100 --max-width $COLUMNS
    else
      if [[ -f "$TMPDIR/fzhim_qry" ]]; then
        query=$(eval "echo {q}")
      else
        query="OR OR SUBJECT {q} FROM {q} BODY {q}"
      fi
      script -t 0 -q /dev/null himalaya search -s 100 --max-width $COLUMNS $query
    fi
  '
  FZF_DEFAULT_COMMAND=$SEARCH_QUERY fzf \
    --disabled \
    --bind 'enter:change-preview:himalaya read {1} -t html | w3m -T text/html -cols $FZF_PREVIEW_COLUMNS -o display_link_number=1' \
    --bind "enter:+reload:sleep 0.1; $SEARCH_QUERY" \
    --bind 'ctrl-j:change-preview()+down' \
    --bind 'ctrl-k:change-preview()+up' \
    --bind 'down:change-preview()+down' \
    --bind 'up:change-preview()+up' \
    --bind 'esc:change-preview()' \
    --bind 'ctrl-n:execute:himalaya reply {1}' \
    --bind "ctrl-n:+reload:sleep 0.1; $SEARCH_QUERY" \
    --bind 'ctrl-a:execute:himalaya attachments {1}' \
    --bind "ctrl-r:reload:$SEARCH_QUERY" \
    --bind "change:change-preview()+reload:sleep 0.25; $SEARCH_QUERY" \
    --bind 'ctrl-q:change-prompt(Query > )+execute-silent:touch $TMPDIR/fzhim_qry' \
    --bind 'ctrl-f:change-prompt(> )+execute-silent:rm -f $TMPDIR/fzhim_qry' \
    --preview-window "top" \
    --header "enter: read email, ctrl-n: reply, ctrl-a: attachments, ctrl-q: query mode, ctrl-f: normal mode, ctrl-r: reload, ctrl-c: exit" \
    --header-lines 2 \
    --ansi

  rm -f $TMPDIR/fzhim_qry
}
