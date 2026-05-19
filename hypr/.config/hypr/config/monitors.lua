local MONITORS = {
	{ output = "eDP-1", mode = "1920x1080@144", position = "1920x0" },
	{ output = "HDMI-A-1", mode = "1920x1080@144", position = "0x0" },
}

local mirror = false

local function second_monitor()
	hl.monitor({
		output = "HDMI-A-1",
		mode = "1920x1080@144",
		position = "0x0",
		mirror = mirror and "eDP-1" or "",
	})
end

local function setup_workspaces()
	for i = 1, 10 do
		local target = i <= 5 and "HDMI-A-1" or "eDP-1"

		hl.workspace_rule({ monitor = target, workspace = tostring(i) })

		hl.timer(function()
			hl.dispatch(hl.dsp.workspace.move({ monitor = target, workspace = tostring(i) }))
		end, { timeout = 1, type = "oneshot" })
	end
end

local function toggle_mirror()
	mirror = not mirror
	second_monitor()
	setup_workspaces()
end

for _, m in ipairs(MONITORS) do
	hl.monitor(m)
end
second_monitor()
setup_workspaces()

MAIN_BIND("SHIFT + M", toggle_mirror)
