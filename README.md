# callumacrae/dotfiles

My dotfiles repository, with magic installation.

Installs:

- Git if not already installed
- [hub](http://hub.github.com/)
- [ZSH](http://www.zsh.org/)
- [Prezto](https://github.com/sorin-ionescu/prezto)
- [Pure](https://github.com/sindresorhus/pure)
- Vim
- [Node.js](http://nodejs.org/) with [nvm](https://github.com/creationix/nvm), along with some global modules I use
- [irssi](http://www.irssi.org/) with modified [weed](https://github.com/ronilaukkarinen/weed) theme and some awesome scripts
- Some small miscellaneous stuff

- Optionally will install PhpStorm and other graphical applications such as Virtualbox and Vagrant


## Magic installation

To set stuff up automatically, do this:

```
git clone git@github.com:callumacrae/dotfiles.git ~/.dotfiles
~/.dotfiles/install/install.sh
```

Might not work on your machine.

## Todo

irssi should load notifier, queryresume, and vim-mode.

## Vagrant

Includes a Vagrantfile for testing. Run `vagrant up`, and then follow the steps
above to test shit.
