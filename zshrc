# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/arun/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# get some plugin management
source ~/code/misc/antigen/antigen.zsh
# themes
antigen use oh-my-zsh
antigen theme gianu
# now add some plugins
antigen bundle git
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions
# go go go!
antigen apply

bindkey -e

# get bash-style word boundaries at dir separators
autoload -U select-word-style
select-word-style bash

path+=($HOME/.local/bin $HOME/.cargo/bin $HOME/code/npm/bin)
export PATH

export EDITOR=vim

export WORKON_HOME=$HOME/code/virtualenvs
export GOPATH=$HOME/code/go

export R_LIBS_USER=$HOME/code/R/x86_64-redhat-linux-gnu-library/3.6

# nix-related things
if [ -f $HOME/.nix-profile/etc/profile.d/nix.sh ]; then
  source $HOME/.nix-profile/etc/profile.d/nix.sh
fi
