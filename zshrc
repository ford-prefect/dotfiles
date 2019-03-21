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

bindkey -e

## powerline shell
#. /usr/share/powerline/zsh/powerline.zsh

# Theme our prompts a bit
autoload -Uz promptinit
promptinit

# get some git in our prompt
GIT_PROMPT_EXECUTABLE="haskell"
source ~/code/misc/zsh-git-prompt/zshrc.sh
PROMPT='%B%m%~%b$(git_super_status) %# '

# get bash-style word boundaries at dir separators
autoload -U select-word-style
select-word-style bash

path+=($HOME/.local/bin $HOME/.cargo/bin $HOME/code/npm/bin)
export PATH

export EDITOR=vim

export WORKON_HOME=$HOME/code/virtualenvs
