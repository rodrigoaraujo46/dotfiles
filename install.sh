#!/bin/sh
#SCRIPTS ASSUMES YOU HAVE CLONED THE DOTFILES AND DIRECTORY IS DOTFILES

fail() {
	echo "Error: $1"
	exit 1
}

setupPKGManagers() {
	sudo pacman -S --noconfirm git base-devel
	sudo pacman -S --asdeps --noconfirm cargo

	#disable debug
	MAKEPKG_CONF="/etc/makepkg.conf"
	[ -f "$MAKEPKG_CONF" ] && sudo sed -i '/^OPTIONS=(/ s/\bdebug\b/!debug/' "$MAKEPKG_CONF"

	git clone https://aur.archlinux.org/paru.git || fail "paru clone failed"
	(cd paru && makepkg -si --noconfirm) || {
		rm -rf paru
		fail "paru build failed"
	}
	rm -rf paru
}

installPackages() {
	cat ./pacman.packages | sudo pacman -S --needed --noconfirm -
	cat ./aur.packages | paru -S --needed -
}

stowDots() {
	mkdir -p "$HOME/.local/bin/" "$XDG_CONFIG_HOME/opencode" "$XDG_CONFIG_HOME/tmux" "$XDG_CONFIG_HOME/zen"
	# shellcheck disable=2035
	stow */

	chsh -s "$(which zsh)"
}

setupDrivers() {
	printf "Do you want to install NVIDIA open drivers? (y/N): "
	read -r install_choice
	case "$install_choice" in
	[yY][eE][sS] | [yY])
		echo "Installing nvidia-open..." sudo pacman -S --needed nvidia-open
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
		. ./graphics.sh
		;;
	*)
		echo "Hybrid configuration skipped."
		;;
	esac

	echo ""
	echo "-----------------------------------------------------"
	echo "Verify export AQ_DRM_DEVICES"
	echo "Should be exported based on graphics.sh success"
	echo "File path: $XDG_CONFIG_HOME/uwsm/env-hyprland"
	echo "-----------------------------------------------------"
}

handleAppSetup() {
	#WALKER
	elephant service enable

	#TMUX
	mkdir -p "$XDG_CONFIG_HOME/tmux/plugins/"
	{
		git clone https://github.com/tmux-plugins/tpm "$XDG_CONFIG_HOME/tmux/plugins/tpm" &&
			"$XDG_CONFIG_HOME/tmux/plugins/tpm/scripts/install_plugins.sh"
	} || fail "Couldn't clone tmux tpm"

	#SPOTIFY
	spicetify config spotify_path "$XDG_DATA_HOME/spotify-launcher/install/usr/share/spotify"
	mkdir -p "$XDG_CONFIG_HOME/spicetify/Themes/"
	git clone --depth=1 https://github.com/spicetify/spicetify-themes.git || fail "Failed to clone spicetify-themes.git"
	cp -r ./spicetify-themes/* "$XDG_CONFIG_HOME/spicetify/Themes"
	rm -rf ./spicetify-themes

	#BAT
	bat cache --build
}

promptReboot() {
	echo "AFTER REBOOT YOU MIGHT WANT TO EDIT '/etc/conf.d/wireless-regdom' and uncomment your location"
	printf "Want to reboot now? (y/N): "
	read -r reboot

	case "$reboot" in [yY][eE][sS] | [yY])
		reboot
		;;
	*)
		echo "Reboot to apply everything"
		;;
	esac
}

export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"

set -e
sudo -v

setupPKGManagers
installPackages
stowDots
setupDrivers
handleAppSetup
promptReboot
