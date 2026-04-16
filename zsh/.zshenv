addToPath() {
    if [[ "$PATH" != *"$1"* ]]; then
        export PATH=$PATH:$1
    fi
}

addToPathFront() {
    if [[ ! -z "$2" ]] || [[ "$PATH" != *"$1"* ]]; then
        export PATH=$1:$PATH
    fi
}

export EDITOR="nvim"
export VISUAL="nvim"
export PAGER="bat"
export MANPAGER="bat -plman"

export BUN_INSTALL="$HOME/.bun"
export GOPATH="$HOME/.go"

addToPathFront $HOME/bin
addToPathFront $HOME/.local/bin
addToPathFront /usr/local/bin
addToPathFront $GOPATH/bin
addToPathFront $BUN_INSTALL/bin

fzf_preview() {
	foam='\e[38;2;156;207;216m'
	reset='\e[0m'

	if [[ $1 =~ "\[TMUX\]" ]]; then
		SESSION=$(echo "$1" | sed "s/\[TMUX] //")
		printf "${foam}-------- [TMUX] $SESSION ----------${reset}\n"
		tmux lsw -F $'#{?window_active,\e[38;2;246;193;119m,\e[38;2;196;167;231m} #{window_index} 󰧱 #{window_name}\e[0m'

	elif [ -d "$1" ]; then
		eza -1 -a --group-directories-first --icons=auto --color=always "$1"

	else
		bat --color=always --style=numbers "$1"
	fi
}
