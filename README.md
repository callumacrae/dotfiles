# callumacrae/dotfiles

My dotfiles repository, with magic installation.

Installs:

- Git if not already installed
- [hub](http://hub.github.com/)
- [ZSH](http://www.zsh.org/)
- [Prezto](https://github.com/sorin-ionescu/prezto)
- [Pure](https://github.com/sindresorhus/pure)
- Vim
- Node.js and npm, along with some global modules I use
- Some small miscellaneous stuff

Will install:

- irssi

- Optionally will install PhpStorm and other graphical applications such as Virtualbox and Vagrant


## Magic installation

To set stuff up automatically, do this:

```
cd ~/.dotfiles/install
chmod +x install.sh
./install.sh
```

Might not work on your machine.

## Vagrant

Includes a Vagrantfile for testing. Run `vagrant up`, and then follow the steps
above to test shit.
