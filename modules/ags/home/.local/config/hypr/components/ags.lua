hl.on("hyprland.start", function ()
	hl.exec_cmd("uwsm app -- ags run")
end)

hl.bind("SUPER + Space", hl.dsp.exec_cmd("ags toggle launcher"))
