---@param cmd string
---@param rules? table<string, string|number|boolean>
local function exec_uwsm(cmd, rules)
	hl.exec_cmd("uwsm app -- " .. cmd, rules)
end

hl.on("hyprland.start", function()
	exec_uwsm("ghostty --quit-after-last-window-closed=false --initial-window=false")
	exec_uwsm("walker --gapplication-service")
	exec_uwsm("waybar")
	exec_uwsm("hyprpaper")
	exec_uwsm("mako")
	exec_uwsm("ghostty", { workspace = "1 silent" })
	exec_uwsm("spotify-launcher", { workspace = "2 silent" })
	exec_uwsm("zen-browser", { workspace = "3 silent" })
end)
