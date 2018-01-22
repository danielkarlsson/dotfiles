#!/bin/bash
# alias.sh

# NVim
alias vim="nvim"
alias vi="nvim"

# Kubectl
alias kc="kubectl"

# Emacs
alias em="emacs -nw"

# Docker
alias dm="docker-machine"

# git
alias git='/usr/local/bin/git'

git config --global alias.s status
git config --global alias.su 'submodule update --init --recursive'
git config --global alias.a 'add -A'
git config --global alias.cm 'commit -m'

# Typora
alias typora="open -a typora"
