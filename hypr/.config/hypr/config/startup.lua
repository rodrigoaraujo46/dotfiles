---@param cmd string
---@param rules? table<string, string|number|boolean>
local function uwsm_scope(cmd, rules)
	hl.exec_cmd("uwsm-app --" .. cmd, rules)
end

local function uwsm_service(cmd, rules)
	hl.exec_cmd("uwsm-app -t service --" .. cmd, rules)
end

hl.on("hyprland.start", function()
	uwsm_service("waybar")
	uwsm_service("walker --gapplication-service")
	uwsm_service("mako")
	uwsm_service("hyprpaper")
	uwsm_scope("ghostty --quit-after-last-window-closed=false", { workspace = "1 silent" })
	uwsm_scope("spotify-launcher", { workspace = "2 silent" })
	uwsm_scope("zen-browser", { workspace = "3 silent" })
end)
