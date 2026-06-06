hl.window_rule({
	name = "suppress-maximize-events",
	match = { class = ".*" },

	suppress_event = "maximize",
})

hl.window_rule({
	name = "fix-xwayland-drags",
	match = {
		class = "^$",
		title = "^$",
		xwayland = true,
		float = true,
		fullscreen = false,
		pin = false,
	},

	no_focus = true,
})

hl.window_rule({
	match = {
		title = "^Picture-in-Picture$",
	},
	float = true,
	pin = true,
	size = { "window_h*16/9", "300" },
	move = { "monitor_w-window_w-5", "5" },
})
