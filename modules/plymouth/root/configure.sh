post()
{
	command sudo mkinitcpio -P
	command sudo systemctl disable greetd.service
	command sudo systemctl enable greetd.service
}
