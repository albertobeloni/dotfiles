post()
{
	command sudo mkinitcpio -P
	command sudo systemctl enable greetd.service
}
