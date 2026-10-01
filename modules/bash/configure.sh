pre()
{
	if command test -f "/etc/bash.bashrc" -a ! -f "/etc/bash.bashrc.old"
	then
		command sudo cp "/etc/bash.bashrc" "/etc/bash.bashrc.old"
	fi
}

post()
{
	command mkdir -p "${HOME}/.local/state/bash"
	command test -f "${HOME}/.bashrc" && command mv -f "${HOME}/.bashrc" "${HOME}/.local/state/bash/.bashrc.old"
	command test -f "${HOME}/.bash_profile" && command mv -f "${HOME}/.bash_profile" "${HOME}/.local/state/bash/.bash_profile.old"
	command test -f "${HOME}/.bash_logout" && command mv -f "${HOME}/.bash_logout" "${HOME}/.local/state/bash/.bash_logout.old"
}
