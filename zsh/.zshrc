export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"

plugins=(git zsh-autosuggestions zsh-syntax-highlighting vi-mode)

fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src

autoload -U compinit && compinit
source $ZSH/oh-my-zsh.sh

export FZF_DEFAULT_OPTS="
    --color=fg:#908caa,bg:-1,hl:#ea9a97
    --color=fg+:#e0def4,bg+:#232136,hl+:#ea9a97
    --color=border:#44415a,header:#3e8fb0,gutter:#232136
    --color=spinner:#f6c177,info:#9ccfd8
    --color=pointer:#c4a7e7,marker:#eb6f92,prompt:#908caa
    --height 50% --preview-window=right:50%
    --preview 'if [ -d {} ]; then ls -p --color=always {} | bat -p --color=always; else bat -p --color=always {}; fi'
    "
export FZF_CTRL_R_OPTS="--no-preview"

source <(fzf --zsh)

KEYTIMEOUT=1
VI_MODE_SET_CURSOR=true
VI_MODE_CURSOR_VISUAL=2
MODE_INDICATOR=""

bindkey -s ^f "^utmux-sessionizer\n"

alias grep="grep --color=auto"
alias vi="nvim"
alias vim="nvim"
alias aura="sudo"
alias hypr="exec uwsm start hyprland-uwsm.desktop"

[ -s "/home/animus/.bun/_bun" ] && source "/home/animus/.bun/_bun"

_opencode_yargs_completions()
{
  local reply
  local si=$IFS
  IFS=$'
' reply=($(COMP_CWORD="$((CURRENT-1))" COMP_LINE="$BUFFER" COMP_POINT="$CURSOR" opencode --get-yargs-completions "${words[@]}"))
  IFS=$si
  if [[ ${#reply} -gt 0 ]]; then
    _describe 'values' reply
  else
    _default
  fi
}
if [[ "'${zsh_eval_context[-1]}" == "loadautofunc" ]]; then
  _opencode_yargs_completions "$@"
else
  compdef _opencode_yargs_completions opencode
fi

fastfetch
