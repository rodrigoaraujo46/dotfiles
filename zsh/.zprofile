# shellcheck shell=bash

if [[ -z "$DISPLAY" && -z "$WAYLAND_DISPLAY" && "$XDG_VTNR" -eq 1 ]]; then
	exec uwsm start hyprland-uwsm.desktop
fi
