# shellcheck shell=bash

useHist() {
	HISTSIZE=10000
	# shellcheck disable=SC2034
	SAVEHIST=10000
	HISTFILE=$HOME/.zsh_history
}

useCompletions() {
	zstyle ':completion:*' menu select
	autoload -U compinit && compinit
	zmodload zsh/complist
	_comp_options+=(globdots)
}

makeAliases() {
	alias ls='eza --grid --color=always --icons --group-directories-first'
	alias lS='ls -1'
	alias lt='ls -a --tree --level=2'

	alias l='eza --long --header --git --color=always --icons --group-directories-first'
	alias l.='l -d .*'
	alias ll='l -a'
	alias llm='eza --long --all --header --git --color=always --sort=modified --icons --reverse'

	fuck() {
		local cmd_array
		read -rA cmd_array <<<"$(fc -ln -1)"
		sudo "${cmd_array[@]}"
	}

	clear() {
		command clear
		printf "\033[1A"
	}

	vibecommit() {
		echo "OpenCode is vibing the commit..."

		diff=$(git diff --cached 2>/dev/null)
		if [ -z "$diff" ]; then
			echo "Nothing staged! Stage your changes first with 'git add'."
			return 1
		fi

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

	alias grep="grep --color=auto"
	alias vi="nvim"
	alias vim="nvim"
	alias rm="rm -i"
	alias cp="cp -i"
	alias mv="mv -i"
}

# shellcheck disable=SC1094
usePlugins() {
	source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
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
		useBinds
	}

	source /usr/share/zsh/plugins/zsh-vi-mode/zsh-vi-mode.zsh
}

use3rdParty() {
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
}

useBinds() {
	#shellcheck disable=SC1090
	source <(fzf --zsh)
	bindkey -s ^f "^utmux-sessionizer\n"

	bindkey -M menuselect 'h' vi-backward-char
	bindkey -M menuselect 'j' vi-down-line-or-history
	bindkey -M menuselect 'k' vi-up-line-or-history
	bindkey -M menuselect 'l' vi-forward-char
}

runLogin() {
	if [[ -o interactive ]]; then
		fastfetch
		printf "\e[1A"
	fi
}

useHist
useCompletions
makeAliases
usePlugins
use3rdParty

runLogin
