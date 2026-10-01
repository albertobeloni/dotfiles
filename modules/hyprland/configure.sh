post()
{
	command systemctl --user enable --now hyprpaper.service
	command systemctl --user enable --now hypridle.service
	command sudo mkinitcpio -P
	command sudo systemctl enable greetd.service

	message "set your username on \"/etc/greetd/config.toml\""
}
