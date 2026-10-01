post()
{
	command xdg-user-dirs-update
	command xdg-user-dirs-gtk-update

	command mkdir -p "$(xdg-user-dir PICTURES)/Screenshots"
}
