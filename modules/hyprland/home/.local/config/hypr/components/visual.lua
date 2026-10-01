hl.config({

	general = {
		gaps_in = 8,
		gaps_out = 24,
		border_size = 1,

		col = {
			active_border = 0xfff2eada,
			inactive_border = 0xff22242d,
		},

		layout = "scrolling",
	},

	decoration = {
		rounding = 0,

		active_opacity = 1.0,
		inactive_opacity = 1.0,

		shadow = {
			enabled = false,
		},

		blur = {
			enabled = true,
			size = 16,
			passes = 3,
		},
	},

	animations = {
		enabled = true,
	},

	misc = {
		background_color = 0xff181b25,
		disable_hyprland_guiutils_check = true,
		disable_hyprland_logo = true,
		disable_splash_rendering = true,
		force_default_wallpaper = 0,
	},

})
