#!/bin/sh

#SCRIPTS ASSUMES YOU HAVE CLONED THE DOTFILES
cd ~ || return

#INSTALL AUR PM
sudo pacman -S --needed git base-devel
git clone https://aur.archlinux.org/yay-bin.git
(cd yay-bin && makepkg -si)
rm -rf yay-bin

#STOW DOTFILES
sudo pacman -S stow

mkdir -p ~/.local/bin/ ~/.config/opencode ~/.config/tmux
# shellcheck disable=2035 # stow blobs are strange
(cd dotfiles && stow */)

#DRIVERS
printf "Do you want to install NVIDIA open drivers? (y/N): "
read -r install_choice
case "$install_choice" in
[yY][eE][sS] | [yY])
	echo "Installing nvidia-open..."
	sudo pacman -S --needed nvidia-open
	;;
*)
	echo "Skipping NVIDIA driver installation."
	;;
esac

printf "Do you want to configure hybrid graphics based on graphics.sh script? (y/N): "
read -r hybrid_choice

case "$hybrid_choice" in
[yY][eE][sS] | [yY])
	# shellcheck disable=1091
	. "$HOME/.local/bin/graphics.sh"
	;;
*)
	echo "Hybrid configuration skipped."
	;;
esac

echo ""
echo "-----------------------------------------------------"
echo "Verify export AQ_DRM_DEVICES"
echo "Should be exported based on graphics.sh success"
echo "File path: $HOME/.config/uwsm/env-hyprland"
echo "File path: $HOME/.local/bin/graphics.sh"
echo "-----------------------------------------------------"

#ZSH
sudo pacman -S --needed zsh
sudo pacman -S --needed fzf
sudo pacman -S --needed fastfetch
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-autosuggestions.git "$ZSH_CUSTOM"/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM"/plugins/zsh-syntax-highlighting

#HYPRLAND
yay -S --needed elephant elephant-desktopapplications elephant-bluetooth elephant-runner walker zen-browser-bin
elephant service enable
sudo pacman -S --needed ghostty waybar hyprpaper nwg-bar
sudo pacman -S --needed uwsm libnewt
sudo pacman -S --needed hyprland

#TMUX
sudo pacman -S --needed tmux lazydocker
(cd .config/tmux && git clone https://github.com/tmux-plugins/tpm plugins/tpm && ./plugins/tpm/scripts/install_plugins.sh)

#NVIM
sudo pacman -S --needed opencode
sudo pacman -S --needed nodejs npm go
sudo pacman -S --needed ripgrep wl-clipboard fd wget unzip tree-sitter-cli
yay -S --needed neovim-nightly-bin

yay -S --needed dashbinsh

sudo pacman -S --needed openssh
sudo pacman -S --needed ttf-firacode-nerd
sudo pacman -S --needed pavucontrol

sudo pacman -S --needed bun
sudo pacman -S --needed bat less man-pages man-db

printf "Want to reboot now? (y/N): "
read -r reboot

case "$reboot" in
[yY][eE][sS] | [yY])
	reboot
	;;
*)
	echo "Reboot to apply everything"
	;;
esac
