mail() {
  old_IFS=$IFS

  IFS=$'\n'
  accounts=($(himalaya -o json accounts | jq -r 'map(.name) | join("\n")'))
  accounts_count="${#accounts[@]}"

  account_file=$TMPDIR/fzhim_account
  if [[ -f "$account_file" ]]; then
    current_account=$(cat "$account_file")

    if [[ ! " ${accounts[*]} " =~ " ${current_account} " ]]; then
      rm -f "$account_file"
      current_account="${accounts[@]:0:1}"
    fi
  else
    current_account="${accounts[@]:0:1}"
  fi
  echo $current_account >| $account_file

  search_query='
    IFS=$'\''\n'\'' accounts=($(echo "'"$(IFS=$'\n'; echo "${accounts[*]}")"'"))
    current_account=$(cat "'"${account_file}"'")

    if (( ${#accounts[@]} > 1 )); then
      accounts_header="${#accounts[@]} accounts:"
      for account in "${accounts[@]}"; do
        if [ "${account}" = "${current_account}" ]; then
          prefix="*\x1b[22;1m"
        else
          prefix=""
        fi
        accounts_header+=" ${prefix}${account}\x1b[0m"
      done
      echo "$accounts_header (ctrl-h / ctrl-l to switch)"
    fi

    if [[ "{q}" = "'\'''\''" || "{q}" = "$(echo {)q}" ]]; then
      script -t 0 -q /dev/null himalaya --account "${current_account}" list -s 100 --max-width $COLUMNS | tail -n +2
    else
      if [[ -f "$TMPDIR/fzhim_qry" ]]; then
        query=$(eval "echo {q}")
      else
        query="OR OR SUBJECT {q} FROM {q} BODY {q}"
      fi
      script -t 0 -q /dev/null himalaya --account "${current_account}" search -s 100 --max-width $COLUMNS $query | tail -n +2
    fi
  '

  read_email='
    current_account=$(cat "'"${account_file}"'")

    himalaya --account "${current_account}" read {1} -t html \
      | w3m -T text/html -cols $FZF_PREVIEW_COLUMNS -o display_link_number=1
  '

  account_previous='
    IFS=$'\''\n'\'' accounts=($(echo "'"$(IFS=$'\n'; echo "${accounts[*]}")"'"))
    current_account=$(cat "'"${account_file}"'")

    for i in {1..${#accounts[@]}}; do
      if [[ "${accounts[$i]}" = "${current_account}" ]]; then
        if (( i > 1 )); then
          new_account="${accounts[$i - 1]}"
          echo $new_account >| '$account_file'
        fi
      fi
    done
  '

  account_next='
    IFS=$'\''\n'\'' accounts=($(echo "'"$(IFS=$'\n'; echo "${accounts[*]}")"'"))
    current_account=$(cat "'"${account_file}"'")

    for i in {1..${#accounts[@]}}; do
      if [[ "${accounts[$i]}" = "${current_account}" ]]; then
        if (( i < ${#accounts[@]} )); then
          new_account="${accounts[$i + 1]}"
          echo $new_account >| '$account_file'
        fi
      fi
    done
  '

  FZF_DEFAULT_COMMAND="$search_query" fzf \
    --disabled \
    --bind "enter:change-preview:$read_email" \
    --bind "enter:+reload:sleep 0.4; $search_query" \
    --bind 'ctrl-j:change-preview()+down' \
    --bind 'ctrl-k:change-preview()+up' \
    --bind 'down:change-preview()+down' \
    --bind 'up:change-preview()+up' \
    --bind 'esc:change-preview()' \
    --bind 'ctrl-n:execute:himalaya reply {1}' \
    --bind "ctrl-n:+reload:sleep 0.4; $search_query" \
    --bind 'ctrl-a:execute:himalaya attachments {1}' \
    --bind "ctrl-r:reload:$search_query" \
    --bind "change:change-preview()+reload:sleep 0.25; $search_query" \
    --bind 'ctrl-q:change-prompt(Query > )+execute-silent:touch $TMPDIR/fzhim_qry' \
    --bind 'ctrl-f:change-prompt(> )+execute-silent:rm -f $TMPDIR/fzhim_qry' \
    --bind "ctrl-h:change-preview()+execute:$account_previous" \
    --bind "ctrl-h:+reload:$search_query" \
    --bind "ctrl-l:change-preview()+execute:$account_next" \
    --bind "ctrl-l:+reload:$search_query" \
    --preview-window "top" \
    --header "enter: read email, c-n: reply, c-a: attachments, c-q: query mode, c-f: normal mode, c-r: reload, c-c: exit" \
    --header-lines $(( accounts_count > 1 ? 2 : 1 )) \
    --ansi

  rm -f $TMPDIR/fzhim_qry

  IFS=$old_IFS
}
