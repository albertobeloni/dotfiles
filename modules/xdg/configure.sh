post()
{
	xdg-user-dirs-update --force
	xdg-user-dirs-gtk-update --force

	command mkdir -p "$(xdg-user-dir PICTURES)/Screenshots"
}
