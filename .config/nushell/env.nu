use std/util "path add"

# Carapace autocomplete
$env.CARAPACE_BRIDGES = 'zsh,fish,bash,inshellisense' # optional

# Editor environment
$env.config.buffer_editor = 'nvim'
$env.config.edit_mode = 'vi'
$env.config.show_banner = false

$env.EDITOR = 'nvim'
$env.VISUAL = 'nvim'

# Add ~/.local/bin to PATH
path add ($env.HOME | path join ".local/bin")

# Go environment
$env.GOPATH = $env.HOME + '/.go'
path add ($env.GOPATH | path join "bin")

# Bun environment
$env.BUN_INSTALL = ($env.HOME | path join ".bun")
path add ($env.BUN_INSTALL | path join "bin")

# Bob (neovim version manager)
path add ($env.HOME | path join "/home/animus/.local/share/bob/nvim-bin")
