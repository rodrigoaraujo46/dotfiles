#!/bin/sh
#SCRIPTS ASSUMES YOU HAVE CLONED THE DOTFILES AND DIRECTORY IS DOTFILES

fail() {
	echo "Error: $1"
	exit 1
}

installYAY() {
	git clone https://aur.archlinux.org/yay-bin.git || fail "yay clone failed"
	(cd yay-bin && makepkg -si) || {
		rm -rf yay-bin
		fail "yay build failed"
	}
	rm -rf yay-bin
}

installPackages() {
	cat ./pacman.packages | sudo pacman -S --needed --noconfirm -
	cat ./aur.packages | yay -S --noconfirm --needed --answerdiff None --answerclean None --provides=false -
}

stowDots() {
	mkdir -p "$HOME/.local/bin/" "$HOME/.config/opencode" "$HOME/.config/tmux"
	# shellcheck disable=2035
	stow */
}

setupDrivers() {
	printf "Do you want to install NVIDIA open drivers? (y/N): "
	read -r install_choice
	case "$install_choice" in
	[yY][eE][sS] | [yY])
		echo "Installing nvidia-open..."
		sudo pacman -S --needed nvidia-open
		;;
	*)
		echo "Skipping Driver installation."
		return
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
}

handleAppSetup() {
	#WALKER
	elephant service enable

	#TMUX
	(git clone https://github.com/tmux-plugins/tpm plugins/tpm "$HOME/.config/tmux/" && ./plugins/tpm/scripts/install_plugins.sh) || fail "Couldn't clone tmux tpm"

	#SPOTIFY
	spicetify config spotify_path "$HOME/.local/share/spotify-launcher/install/usr/share/spotify"
	mkdir -p "$HOME/.config/spicetify/Themes/"
	git clone --depth=1 https://github.com/spicetify/spicetify-themes.git || fail "Failed to clone spicetify-themes.git"
	cp -r ./spicetify-themes/* "$HOME/.config/spicetify/Themes"
	sudo rm -rf ./spicetify-themes
}

promptReboot() {
	echo "'AFTER REBOOT YOU MIGHT WANT TO EDIT '/etc/conf.d/wireless-regdom' and uncomment your location"
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
}

set -e
sudo -v

install_yay
install_packages
stowDots
setupDrivers
handleAppSetup
promptReboot
