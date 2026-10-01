pre()
{
	if command test ! -r "/etc/locale.conf.backup" && command test -r "/etc/locale.conf"
	then
		command sudo cp "/etc/locale.conf" "/etc/locale.conf.backup"
	fi
}

post()
{
	if command test -r "${path}/data/locale.conf"
	then
		command sudo cp --no-preserve=ownership "${path}/data/locale.conf" "/etc/locale.conf"
	fi

	command sudo sed -i -e "s/\#en_US\.UTF-8/en_US\.UTF-8/g" "/etc/locale.gen"
	command sudo sed -i -e "s/\#pt_BR\.UTF-8/pt_BR\.UTF-8/g" "/etc/locale.gen"
	command sudo locale-gen
}
