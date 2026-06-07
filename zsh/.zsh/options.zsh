# shellcheck shell=bash

HISTSIZE=10000
SAVEHIST=10000
HISTFILE=$HOME/.zsh_history

zstyle ':completion:*' menu select
autoload -U compinit && compinit
zmodload zsh/complist
_comp_options+=(globdots)
