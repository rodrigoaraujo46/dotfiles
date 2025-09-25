#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export EDITOR=nvim
export VISUAL=nvim

export export PATH="$HOME/.local/bin:$PATH"

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

#TMUX-SESSIONIZER
bind -x '"\C-f": tmux-sessionizer'

# PNPM
export PNPM_HOME="/home/animus/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# NVIDIA VAAPI + EGL fixes
export MOZ_DISABLE_RDD_SANDBOX=1
export LIBVA_DRIVER_NAME=nvidia
export __EGL_VENDOR_LIBRARY_FILENAMES=/usr/share/glvnd/egl_vendor.d/10_nvidia.json
