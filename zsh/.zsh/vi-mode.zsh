# shellcheck shell=bash

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
	source <(fzf --zsh)
	bindkey -s ^f "^utmux-sessionizer\n"

	bindkey -M menuselect 'h' vi-backward-char
	bindkey -M menuselect 'j' vi-down-line-or-history
	bindkey -M menuselect 'k' vi-up-line-or-history
	bindkey -M menuselect 'l' vi-forward-char
}

source /usr/share/zsh/plugins/zsh-vi-mode/zsh-vi-mode.zsh
