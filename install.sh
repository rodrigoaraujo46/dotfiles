#!/bin/sh
#SCRIPTS ASSUMES YOU HAVE CLONED THE DOTFILES AND DIRECTORY IS DOTFILES

fail() {
	echo "Error: $1"
	exit 1
}

setupPKGManagers() {
	sudo pacman -S --noconfirm git base-devel || fail "git/base-devel failed"
	sudo pacman -S --asdeps --noconfirm cargo || fail "cargo install failed"

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
	cat ./pacman.packages | sudo pacman -S --needed --noconfirm - || fail "pacman packages failed"
	cat ./aur.packages | paru -S --needed - || fail "aur packages failed"
}

stowDots() {
	mkdir -p "$HOME/.local/bin/" "$XDG_CONFIG_HOME/opencode" "$XDG_CONFIG_HOME/tmux" "$XDG_CONFIG_HOME/zen"
	# shellcheck disable=2035
	stow */ || fail "stow failed"

	chsh -s "$(which zsh)" || fail "chsh failed"
}

setupDrivers() {
	printf "Do you want to install NVIDIA open drivers? (y/N): "
	read -r install_choice
	case "$install_choice" in
	[yY]*)
		echo "Installing nvidia-open..."
		sudo pacman -S --needed nvidia-open || echo "Warning: nvidia-open install failed"

		printf "Do you want to configure hybrid graphics based on graphics.sh script? (y/N): "
		read -r hybrid_choice

		case "$hybrid_choice" in
		[yY]*)
			# shellcheck disable=1091
			. ./graphics.sh || echo "Warning: graphics.sh failed"

			echo ""
			echo "-----------------------------------------------------"
			echo "Verify export AQ_DRM_DEVICES"
			echo "Should be exported based on graphics.sh success"
			echo "File path: $XDG_CONFIG_HOME/uwsm/env-hyprland"
			echo "-----------------------------------------------------"
			;;
		*)
			echo "Hybrid configuration skipped."
			;;
		esac
		;;
	*)
		echo "Skipping Driver installation."
		;;
	esac
}

nbfc_setup() {
	if ! sudo nbfc config --set auto; then
		echo "Warning: couldn't set nbfc config"
		return 0
	fi
	if ! sudo nbfc restart; then
		echo "Warning: couldn't restart nbfc service"
		return 0
	fi
	if ! sudo nbfc --auto; then
		echo "Warning: couldn't set nbfc to auto"
		return 0
	fi
	if ! sudo systemctl enable nbfc_service; then
		echo "Warning: couldn't enable nbfc_service"
	fi
}

handleAppSetup() {
	#WALKER
	elephant service enable || echo "Warning: elephant failed"

	#TMUX
	mkdir -p "$XDG_CONFIG_HOME/tmux/plugins/"
	{
		git clone https://github.com/tmux-plugins/tpm "$XDG_CONFIG_HOME/tmux/plugins/tpm" &&
			"$XDG_CONFIG_HOME/tmux/plugins/tpm/scripts/install_plugins.sh"
	} || echo "Warning: tmux tpm failed"

	#SPOTIFY
	if command -v spicetify >/dev/null 2>&1; then
		spicetify config spotify_path "$XDG_DATA_HOME/spotify-launcher/install/usr/share/spotify" 2>/dev/null || true
		mkdir -p "$XDG_CONFIG_HOME/spicetify/Themes/"
		{
			git clone --depth=1 https://github.com/spicetify/spicetify-themes.git &&
				cp -r ./spicetify-themes/* "$XDG_CONFIG_HOME/spicetify/Themes" &&
				rm -rf ./spicetify-themes
		} || echo "Warning: spicetify themes failed"
	else
		echo "Warning: spicetify not installed, skipping"
	fi

	#BAT
	if command -v bat >/dev/null 2>&1; then
		bat cache --build || echo "Warning: bat cache failed"
	else
		echo "Warning: bat not installed, skipping"
	fi

	sudo systemctl enable --now docker.service || echo "Warning: docker.service not started, skipping"
	sudo usermod -aG docker "$USER"

	#NBFC-LINUX
	nbfc_setup

	#CPUFREQ
	if command -v auto-cpufreq >/dev/null 2>&1; then
		sudo auto-cpufreq --install || echo "Warning: auto-cpufreq install failed"
	else
		echo "Warning: auto-cpufreq not installed, skipping"
	fi
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
