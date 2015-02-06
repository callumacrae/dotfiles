[ -x "$(which hub)" ] && alias git=hub
fpath=(~/.zsh $fpath)

export EDITOR=vim
export GIT_EDITOR=$EDITOR # Not sure why I need to do this

# https://gist.github.com/sindresorhus/8435329
np() {
		trash node_modules &>/dev/null;
		git pull --rebase &&
		npm install &&
		npm test &&
		npm version ${1:-patch} &&
		npm publish &&
		git push --follow-tags
}
