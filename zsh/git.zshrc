[ -x "$(which hub)" ] && alias git=hub
#zstyle ':completion:*:*:git:*' script ~/.git-completion.sh
#fpath=(~/.zsh $fpath) # Doesn't work :(

export EDITOR=vim
export GIT_EDITOR=$EDITOR # Not sure why I need to do this