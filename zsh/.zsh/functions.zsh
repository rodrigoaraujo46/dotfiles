# shellcheck shell=bash

fuck() {
	local cmd_array
	read -rA cmd_array <<<"$(fc -ln -1)"
	sudo "${cmd_array[@]}"
}

vibecommit() {
	echo "OpenCode is vibing the commit..."

	local diff
	diff=$(git diff --cached 2>/dev/null)
	if [ -z "$diff" ]; then
		echo "Nothing staged! Stage your changes first with 'git add'."
		return 1
	fi

	local msg
	msg=$(opencode run "vibecommit using this diff $diff" 2>/dev/null)

	if [ -z "$msg" ]; then
		echo "Failed to generate a commit message."
		return 1
	fi

	echo -e "\nProposed Commit Message:"
	echo -e "------------------------"
	echo -e "\033[1;32m$msg\033[0m"
	echo -e "------------------------\n"

	if read -rq "choice?Confirm and commit? (y/n): "; then
		echo -e "\n\nCommitting..."
		git commit -m "$msg"
	else
		echo -e "\n\nCommit aborted."
		return 1
	fi
}

mirrors() {
	local tmp="/tmp/mirrorlist.tmp"

	if curl -s "https://archlinux.org/mirrorlist/?country=PT&country=ES&protocol=https&use_mirror_status=on" |
		sed -e 's/^#Server/Server/' -e '/^#/d' |
		rankmirrors -n 5 - >"$tmp" && [ -s "$tmp" ]; then

		cat "$tmp" | sudo tee /etc/pacman.d/mirrorlist
		rm -f "$tmp"
		echo "Mirrorlist updated successfully."
	else
		echo "Error: Mirrorlist update failed." >&2
		rm -f "$tmp"
		return 1
	fi
}
