local MONITORS = {
	{ output = "eDP-1", mode = "1920x1080@144", position = "1920x0" },
	{ output = "HDMI-A-1", mode = "1920x1080@144", position = "0x0" },
}

local mirror = false

local second_monitor = function()
	hl.monitor({
		output = "HDMI-A-1",
		mode = "1920x1080@144",
		position = "0x0",
		mirror = mirror and "eDP-1" or "",
	})
end

local setup_workspaces = function()
	for i = 1, 10 do
		local target = i <= 5 and "HDMI-A-1" or "eDP-1"

		hl.workspace_rule({ monitor = target, workspace = tostring(i) })

		hl.timer(function()
			hl.dispatch(hl.dsp.workspace.move({ monitor = target, workspace = tostring(i) }))
		end, { timeout = 1, type = "oneshot" })
	end
end

local toggle_mirror = function()
	mirror = not mirror
	second_monitor()
	setup_workspaces()
end

for _, m in ipairs(MONITORS) do
	hl.monitor(m)
end
second_monitor()
setup_workspaces()

_G.toggle_mirror = toggle_mirror
