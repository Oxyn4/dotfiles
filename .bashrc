#
# ~/.bashrc
#x

export PATH="$HOME/Downloads/arena/:$PATH"

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '



. "$HOME/.cargo/env"
