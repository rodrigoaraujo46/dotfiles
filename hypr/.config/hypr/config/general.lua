hl.config({
	general = {
		gaps_out = 22,
		gaps_in = 8,
		border_size = 2,
		col = {
			active_border = "#c4a7e7",
		},
		resize_on_border = true,
	},

	decoration = {
		rounding = 14,
		rounding_power = 3,

		blur = {
			passes = 4,
		},
	},

	misc = {
		force_default_wallpaper = 0,
		disable_hyprland_logo = true,
	},

	dwindle = {
		preserve_split = true,
	},

	input = { kb_options = "compose:caps" },
})
