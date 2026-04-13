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
