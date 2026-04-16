useHist() {
	HISTSIZE=10000
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
	alias grep="grep --color=auto"
	alias vi="nvim"
	alias vim="nvim"
	alias aura="sudo"
	alias hypr="exec uwsm start hyprland-uwsm.desktop"
	alias ls="eza -lh --group-directories-first --icons=auto"
}

usePlugins() {
	source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
	source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

	zvm_config() {
		ZVM_SYSTEM_CLIPBOARD_ENABLED=true
		ZVM_INSERT_MODE_CURSOR=$ZVM_CURSOR_BEAM
		ZVM_NORMAL_MODE_CURSOR=$ZVM_CURSOR_BLOCK
		ZVM_OPPEND_MODE_CURSOR=$ZVM_CURSOR_UNDERLINE

	}

	zvm_after_select_vi_mode() {
		case $ZVM_MODE in
			$ZVM_MODE_NORMAL)
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
		echo -n "\e[1A"
	fi
}

useHist
useCompletions
makeAliases
usePlugins
use3rdParty

runLogin
