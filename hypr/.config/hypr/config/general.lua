hl.config({
	general = {
		gaps_out = 22,
		gaps_in = 8,
		border_size = 2,
		col = {
			active_border = "#c4a7e7",
		},
		resize_on_border = false,
		allow_tearing = false,
		layout = "dwindle",
	},

	decoration = {
		rounding = 14,
		rounding_power = 3,

		shadow = {
			enabled = true,
			range = 4,
			render_power = 3,
			color = "rgba(1a1a1aee)",
		},

		blur = {
			enabled = true,
			size = 6,
			ignore_opacity = true,
			passes = 5,
			noise = 0.01,
		},
	},

	misc = {
		force_default_wallpaper = 0,
		disable_hyprland_logo = true,
	},

	dwindle = {
		preserve_split = true,
	},

	master = {
		new_status = "master",
	},
})
