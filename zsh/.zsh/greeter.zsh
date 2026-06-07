# shellcheck shell=bash

if [[ -o interactive && "$COLUMNS" -ge 54 ]]; then
	fastfetch
	printf "\e[1A"
fi
