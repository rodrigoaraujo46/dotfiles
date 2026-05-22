---@param keys string
---@param dispatcher HL.Dispatcher|function
---@param opts? HL.BindOptions
---@return HL.Keybind
function MAIN_BIND(keys, dispatcher, opts)
	return hl.bind("SUPER + " .. keys, dispatcher, opts)
end

MAIN_BIND("Q", hl.dsp.exec_cmd(TERMINAL))
MAIN_BIND("C", hl.dsp.window.close())

MAIN_BIND("M", function()
	hl.dispatch(hl.dsp.window.float({ action = "toggle" }))
	hl.dispatch(hl.dsp.window.resize({ x = 1400, y = 800 }))
	hl.dispatch(hl.dsp.window.center())
end)

MAIN_BIND("E", hl.dsp.exec_cmd(POWER))
MAIN_BIND("V", hl.dsp.window.float({ action = "toggle" }))
MAIN_BIND("R", hl.dsp.exec_cmd(MENU))
MAIN_BIND("F", hl.dsp.window.fullscreen({ action = "toggle" }))
MAIN_BIND("P", hl.dsp.window.pseudo())
MAIN_BIND("T", hl.dsp.layout("togglesplit"))

MAIN_BIND("W", hl.dsp.exec_cmd("killall -SIGUSR1 waybar"))

hl.bind("ALT + T", function()
	local focused = hl.get_active_window()
	if focused and focused.class and focused.class:find("zen") then
		hl.dispatch(hl.dsp.send_shortcut({ mods = "CTRL", key = "l" }))
		hl.timer(function()
			hl.dispatch(hl.dsp.send_shortcut({ mods = "SHIFT", key = "5" }))
			hl.dispatch(hl.dsp.send_shortcut({ key = "space" }))
		end, { type = "oneshot", timeout = 50 })
	end
end)

MAIN_BIND("H", hl.dsp.focus({ direction = "left" }))
MAIN_BIND("L", hl.dsp.focus({ direction = "right" }))
MAIN_BIND("K", hl.dsp.focus({ direction = "up" }))
MAIN_BIND("J", hl.dsp.focus({ direction = "down" }))

for i = 1, 10 do
	local key = i % 10
	MAIN_BIND("" .. key, hl.dsp.focus({ workspace = i }))
	MAIN_BIND("SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

MAIN_BIND("mouse:272", hl.dsp.window.drag(), { mouse = true })
MAIN_BIND("mouse:273", hl.dsp.window.resize(), { mouse = true })

hl.bind("XF86MenuKB", hl.dsp.exec_cmd("hyprctl switchxkblayout current next"))
hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMicMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
	{ locked = true, repeating = true }
)
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })

hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
