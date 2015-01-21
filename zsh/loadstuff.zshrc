# Source Prezto if available
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Mac stuff
if [[ `uname` == 'Darwin' ]]; then

	[[ -s `brew --prefix`/etc/autojump.sh ]] && . `brew --prefix`/etc/autojump.sh
elif [[ -s /usr/share/autojump/autojump.sh ]]; then
	. /usr/share/autojump/autojump.sh
fi
