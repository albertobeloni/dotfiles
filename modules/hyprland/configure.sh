post()
{
	command sudo mkinitcpio -P

	command sudo sed -i "s/YOURUSER/${USER}/" "/etc/greetd/config.toml"
	command sudo systemctl enable greetd.service

	command ln -sf "${HOME}/.local/config/hypr/themes/nox-maxima.lua" "${HOME}/.local/config/hypr/components/theme.lua"
}
