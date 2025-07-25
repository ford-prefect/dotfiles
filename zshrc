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

path+=($HOME/bin $HOME/.local/bin $HOME/.cargo/bin $HOME/code/npm/bin $HOME/.cabal/bin $HOME/local/go/bin)

# asdf for version management
export ASDF_DATA_DIR=/home/arun/.asdf
path=("$ASDF_DATA_DIR/shims" $path)

export PATH

export EDITOR=nvim

export WORKON_HOME=$HOME/code/virtualenvs
export GOPATH=$HOME/code/go

export R_LIBS_USER=$HOME/code/R/x86_64-redhat-linux-gnu-library/3.6

[ -f "/home/arun/.ghcup/env" ] && source "/home/arun/.ghcup/env" # ghcup-env

if [ -e /home/arun/.nix-profile/etc/profile.d/nix.sh ]; then . /home/arun/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
