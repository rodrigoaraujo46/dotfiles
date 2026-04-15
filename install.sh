#!/bin/sh
#SCRIPTS ASSUMES YOU HAVE CLONED THE DOTFILES AND DIRECTORY IS DOTFILES

fail() {
	echo "Error: $1"
	exit 1
}

setupPKGManagers() {
	#Add color to pacman, specially usefull for paru, it will be able to properlly use bat
	PACMAN_CONF=/etc/pacman.conf
	[ -f "$PACMAN_CONF" ] && sudo sed -i 's/^#\s*Color/Color/' "$PACMAN_CONF"

	#disable debug
	MAKEPKG_CONF="/etc/makepkg.conf"
	[ -f "$MAKEPKG_CONF" ] && sudo sed -i '/^OPTIONS=(/ s/\bdebug\b/!debug/' "$MAKEPKG_CONF"

	git clone https://aur.archlinux.org/paru.git || fail "paru clone failed"
	(cd paru && makepkg -si) || {
		rm -rf paru
		fail "paru build failed"
	}
	rm -rf paru
}

installPackages() {
	cat ./pacman.packages | sudo pacman -S --needed --noconfirm -
	cat ./aur.packages | paru -S --needed --noconfirm -
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

setupPKGManagers
install_packages
stowDots
setupDrivers
handleAppSetup
promptReboot
