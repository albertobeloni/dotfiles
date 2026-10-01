post()
{
	if command test "${distribution}" = "arch"
	then
		command mkdir -p "${HOME}/.local/config/gtk-3.0"
		command mkdir -p "${HOME}/.local/config/gtk-4.0"

		command cp -a "${path}/home/.local/data/gtk/themes/lumen-maxima/nox-gtk3.css" "${HOME}/.local/config/gtk-3.0/gtk.css"
		command cp -a "${path}/home/.local/data/gtk/themes/lumen-maxima/nox-gtk4.css" "${HOME}/.local/config/gtk-4.0/gtk.css"

		if command -v flatpak > "/dev/null" 2>&1
		then
			command sudo flatpak override --filesystem=xdg-config/gtk-3.0:ro
			command sudo flatpak override --filesystem=xdg-config/gtk-4.0:ro
		fi

		if command -v gsettings > "/dev/null" 2>&1
		then
			command gsettings set org.gnome.desktop.interface gtk-theme "adw-gtk3"
			command gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"
		fi
	fi
}
