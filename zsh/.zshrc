# shellcheck shell=bash

HISTSIZE=10000
# shellcheck disable=SC2034
SAVEHIST=10000
HISTFILE=$HOME/.zsh_history

zstyle ':completion:*' menu select
autoload -U compinit && compinit
zmodload zsh/complist
_comp_options+=(globdots)

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

fuck() {
	local cmd_array
	read -rA cmd_array <<<"$(fc -ln -1)"
	sudo "${cmd_array[@]}"
}

vibecommit() {
	echo "OpenCode is vibing the commit..."

	local diff
	diff=$(git diff --cached 2>/dev/null)
	if [ -z "$diff" ]; then
		echo "Nothing staged! Stage your changes first with 'git add'."
		return 1
	fi

	local msg
	msg=$(opencode run "vibecommit using this diff $diff" 2>/dev/null)

	if [ -z "$msg" ]; then
		echo "Failed to generate a commit message."
		return 1
	fi

	echo -e "\nProposed Commit Message:"
	echo -e "------------------------"
	echo -e "\033[1;32m$msg\033[0m"
	echo -e "------------------------\n"

	if read -rq "choice?Confirm and commit? (y/n): "; then
		echo -e "\n\nCommitting..."
		git commit -m "$msg"
	else
		echo -e "\n\nCommit aborted."
		return 1
	fi
}

mirrors() {
	local tmp="/tmp/mirrorlist.tmp"

	if curl -s "https://archlinux.org/mirrorlist/?country=PT&country=ES&protocol=https&use_mirror_status=on" |
		sed -e 's/^#Server/Server/' -e '/^#/d' |
		rankmirrors -n 5 - >"$tmp" && [ -s "$tmp" ]; then

		cat "$tmp" | sudo tee /etc/pacman.d/mirrorlist
		rm -f "$tmp"
		echo "Mirrorlist updated successfully."
	else
		echo "Error: Mirrorlist update failed." >&2
		rm -f "$tmp"
		return 1
	fi
}

alias grep="grep --color=auto"
alias vi="nvim"
alias vim="nvim"
alias rm="rm -i"
alias cp="cp -i"
alias mv="mv -i"

# shellcheck disable=SC1094
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
# shellcheck disable=SC1094
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# shellcheck disable=SC2034
zvm_config() {
	ZVM_SYSTEM_CLIPBOARD_ENABLED=true
	ZVM_INSERT_MODE_CURSOR=$ZVM_CURSOR_BEAM
	ZVM_NORMAL_MODE_CURSOR=$ZVM_CURSOR_BLOCK
	ZVM_OPPEND_MODE_CURSOR=$ZVM_CURSOR_UNDERLINE
}

zvm_after_select_vi_mode() {
	case $ZVM_MODE in
	"$ZVM_MODE_NORMAL")
		echo -ne "\e[2 q"
		;;
	esac
}

zvm_after_init() {
	# shellcheck disable=SC1090
	source <(fzf --zsh)
	bindkey -s ^f "^utmux-sessionizer\n"

	bindkey -M menuselect 'h' vi-backward-char
	bindkey -M menuselect 'j' vi-down-line-or-history
	bindkey -M menuselect 'k' vi-up-line-or-history
	bindkey -M menuselect 'l' vi-forward-char
}

# shellcheck disable=SC1094
source /usr/share/zsh/plugins/zsh-vi-mode/zsh-vi-mode.zsh

export FZF_DEFAULT_OPTS="
	--color=fg:#908caa,bg:-1,hl:#ea9a97
	--color=fg+:#e0def4,bg+:#232136,hl+:#ea9a97
	--color=border:#44415a,header:#3e8fb0,gutter:#232136
	--color=spinner:#f6c177,info:#9ccfd8
	--color=pointer:#c4a7e7,marker:#eb6f92,prompt:#908caa
	--height 50% --preview-window=right:50%
	--preview 'fzf_preview {}'
	"
export FZF_CTRL_R_OPTS="--no-preview"

eval "$(zoxide init zsh)"
eval "$(starship init zsh)"

if [[ -o interactive ]]; then
	fastfetch
	printf "\e[1A"
fi
