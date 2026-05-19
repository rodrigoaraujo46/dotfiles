local function exec_uwsm(s)
	hl.exec_cmd("uwsm app -- " .. s)
end

hl.on("hyprland.start", function()
	exec_uwsm("ghostty --gtk-single-instance=true --quit-after-last-window-closed=false --initial-window=false")
	exec_uwsm("walker --gapplication-service")
	exec_uwsm("waybar")
	exec_uwsm("hyprpaper")
	exec_uwsm("tmux")
end)
