[ -x "$(which hub)" ] && alias git=hub
fpath=(~/.zsh $fpath)

export EDITOR=vim
export GIT_EDITOR=$EDITOR # Not sure why I need to do this
