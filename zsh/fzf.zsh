# Setup fzf
# ---------
if [[ ! "$PATH" == */usr/local/opt/fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/usr/local/opt/fzf/bin"
fi

# Use ag to respect gitignore
export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'
export FZF_DEFAULT_OPTS='--no-mouse
    --bind "ctrl-u:preview-half-page-up"
    --bind "ctrl-d:preview-half-page-down"
    --bind "shift-up:preview-top"
    --bind "shift-down:preview-bottom"'

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/usr/local/opt/fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/usr/local/opt/fzf/shell/key-bindings.zsh"

_fzf_complete_git() {
    ARGS="$@"
    if [[ $ARGS == 'git checkout'* ]]; then
        local branches
        branches=$(git branch -v --color=always)
        _fzf_complete --reverse --multi --ansi -- "$@" < <(
            echo $branches
        )
    elif [[ $ARGS == 'git revert'* ]]; then
        local commits
        commits=$(git log --pretty='format:%C(auto)%h %s %C(dim)%ad%Creset' --date=relative --color=always)
        _fzf_complete --reverse --multi --ansi -- "$@" < <(
            echo $commits
        )
    else
        eval "zle ${fzf_default_completion:-expand-or-complete}"
    fi
}

_fzf_complete_git_post() {
    awk '{print $1}'
}
