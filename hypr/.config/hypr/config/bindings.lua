MAIN_BIND("Q", hl.dsp.exec_cmd(TERMINAL))
MAIN_BIND("E", hl.dsp.exec_cmd(POWER))
MAIN_BIND("R", hl.dsp.exec_cmd(MENU))
MAIN_BIND("C", hl.dsp.window.close())
MAIN_BIND("M", function()
	DSP(hl.dsp.window.float({ action = "on" }))
	DSP(hl.dsp.window.resize({ x = 1280, y = 720 }))
	DSP(hl.dsp.window.center())
end)
MAIN_BIND("V", hl.dsp.window.float({ action = "toggle" }))
MAIN_BIND("F", hl.dsp.window.fullscreen({ action = "toggle" }))
MAIN_BIND("T", hl.dsp.layout("togglesplit"))

MAIN_BIND("SHIFT + P", function()
	hl.exec_cmd("mkdir -p ~/Pictures/screenshots")
	hl.exec_cmd('grim -g "$(slurp)" ~/Pictures/screenshots/$(date +%Y-%m-%d_%H%M%S).png')
end)
MAIN_BIND("SHIFT + Y", hl.dsp.exec_cmd('grim -g "$(slurp)" - | wl-copy'))

MAIN_BIND("W", hl.dsp.exec_cmd("killall -SIGUSR1 waybar"))

--Zen fuzzy tab switcher
hl.bind("ALT + T", function()
	local focused = hl.get_active_window()
	if focused and focused.class and focused.class:find("zen") then
		DSP(hl.dsp.send_shortcut({ mods = "CTRL", key = "L" }))
		hl.timer(function()
			DSP(hl.dsp.send_shortcut({ mods = "SHIFT", key = "5" }))
			DSP(hl.dsp.send_shortcut({ mods = "", key = "SPACE" }))
		end, { type = "oneshot", timeout = 50 })
	end
end)

MAIN_BIND("K", hl.dsp.focus({ direction = "up" }))
MAIN_BIND("L", hl.dsp.focus({ direction = "right" }))
MAIN_BIND("J", hl.dsp.focus({ direction = "down" }))
MAIN_BIND("H", hl.dsp.focus({ direction = "left" }))

MAIN_BIND("SHIFT + K", hl.dsp.window.move({ direction = "up" }))
MAIN_BIND("SHIFT + L", hl.dsp.window.move({ direction = "right" }))
MAIN_BIND("SHIFT + J", hl.dsp.window.move({ direction = "down" }))
MAIN_BIND("SHIFT + H", hl.dsp.window.move({ direction = "left" }))

for i = 1, 10 do
	local key = i % 10
	MAIN_BIND("" .. key, hl.dsp.focus({ workspace = i }))
	MAIN_BIND("SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

MAIN_BIND("mouse:272", hl.dsp.window.drag(), { mouse = true })

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
