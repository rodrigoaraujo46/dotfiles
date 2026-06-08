# shellcheck shell=bash

alias ls='eza --grid --color=always --icons --group-directories-first'
alias lS='ls -1'
alias lt='ls -a --tree --level=2'

alias l='eza --long --header --git --color=always --icons --group-directories-first'
alias l.='l -d .*'
alias ll='l -a'
alias llm='eza --long --all --header --git --color=always --sort=modified --icons --reverse'
alias -g -- -h='-h 2>&1 | bat -plhelp'
alias -g -- --help='--help 2>&1 | bat -plhelp'
alias -g help='help 2>&1 | bat -plhelp'

alias grep="grep --color=auto"
alias vi="nvim"
alias vim="nvim"
alias rm="rm -i"
alias cp="cp -i"
alias mv="mv -i"

alias amend="git commit --amend"
