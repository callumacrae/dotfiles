start_nvim() {
	fg %start_nvim 2> /dev/null
	if [[ $? -ne 0 && $? -ne 146 ]]; then
		nvim -S
	fi
}
alias v=start_nvim

export EDITOR=nvim
export VISUAL=nvim
export GIT_EDITOR=nvim

export PATH="~/go/bin:$PATH"
