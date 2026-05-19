hl.config({
	input = {
		kb_layout = "us,us",
		kb_variant = ",intl",

		follow_mouse = 1,

		sensitivity = 0,

		touchpad = {
			natural_scroll = false,
		},
	},

	scrolling = {
		fullscreen_on_one_column = true,
	},
})

hl.gesture({
	fingers = 3,
	direction = "horizontal",
	action = "workspace",
})

hl.device({
	name = "epic-mouse-v1",
	sensitivity = -0.5,
})
