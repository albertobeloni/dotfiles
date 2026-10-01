hl.config({

	general = {
		gaps_in = 8,
		gaps_out = 24,
		border_size = 1,
		layout = "scrolling",
	},

	group = {
		col = {
			border_active = ,
			border_inactive = ,
			border_locked_active = ,
			border_locked_inactive = ,
		},
		groupbar = {
			height = 16,
		},
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
		disable_hyprland_guiutils_check = true,
		disable_hyprland_logo = true,
		disable_splash_rendering = true,
		force_default_wallpaper = 0,
	},

})
