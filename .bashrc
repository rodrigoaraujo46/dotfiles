#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

#ALIASES
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias vi='nvim'
alias vim='nvim'
alias aura='sudo'

#COMMAND COMPLETION
if [ -f /usr/share/bash-completion/bash_completion ]; then
  . /usr/share/bash-completion/bash_completion
fi

#PROMPT
PS1='[\u@\h \W]\$ '
eval "$(starship init bash)"

#FZF
export FZF_COMPLETION_TRIGGER="**"
source <(fzf --bash)

#GO
export GOPATH=$HOME/.go
export PATH=$GOPATH/bin:$PATH
