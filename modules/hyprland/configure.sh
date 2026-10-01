post()
{
	command systemctl --user enable hyprpaper.service
	command systemctl --user enable hypridle.service
	command sudo mkinitcpio -P

	command sudo sed -i "s/YOURUSER/${USER}/" "/etc/greetd/config.toml"
	command sudo systemctl enable greetd.service
}
