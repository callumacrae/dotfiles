alias reload=". ~/.zshrc" # Reloads ZSH config
alias phpstorm="open -a phpstorm ." # Opens current directory in PhpStorm
[ -x "$(which ack-grep)" ] && alias ack=ack-grep # ack sometimes ack-grep
[ ! -x "$(which j)" ] && alias j=autojump

# Shut the fuck up, ZSH
alias vim="nocorrect vim"
alias trash="nocorrect trash"