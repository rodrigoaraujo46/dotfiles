$env.config.buffer_editor = 'nvim'
$env.config.edit_mode = 'vi'
$env.config.show_banner = false

# EDITOR / VISUAL
$env.EDITOR = 'nvim'
$env.VISUAL = 'nvim'

$env.PATH ++= [($'($env.HOME)/.local/bin')]

#ALIASES
alias grep = grep --color=auto
alias vi = nvim
alias vim = nvim
alias aura = sudo

#STARSHIP
mkdir ($nu.data-dir | path join "vendor/autoload")
starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")

#FZF
#export FZF_COMPLETION_TRIGGER="**"
#source <(fzf --nu) THIS IS NOT CORRENTLY AVAILABLE FROM FZF

#GO
$env.GOPATH = $env.HOME + '/.go'
$env.PATH ++= [$'($env.GOPATH)/bin']

$env.config.keybindings ++= [{
    name: completion_menu
    modifier: control
    keycode: char_f
    mode: [emacs, vi_normal, vi_insert]
    event: { send: executehostcommand cmd: tmux-sessionizer}
}]

# PNPM
$env.PNPM_HOME = $env.HOME + '/.local/share/pnpm'
$env.PATH = ($env.PATH | split row (char esep) | prepend $env.PNPM_HOME )

# NVIDIA VAAPI + EGL fixes
$env.MOZ_DISABLE_RDD_SANDBOX = 1
$env.LIBVA_DRIVER_NAME = 'nvidia'
$env.__EGL_VENDOR_LIBRARY_FILENAMES = '/usr/share/glvnd/egl_vendor.d/10_nvidia.json'

source $"($nu.cache-dir)/carapace.nu"
