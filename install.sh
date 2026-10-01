#!/bin/bash

install()
{
	command declare base

	base="$(command dirname ${BASH_SOURCE[0]})"

	command declare distribution

	if command test -f "/etc/os-release" > "/dev/null" 2>&1
	then
		command source "/etc/os-release"

		distribution="${ID}"
	fi

	command declare module
	command declare -a modules

	modules=("${@}")

	if command test -z "${modules}"
	then
		for module in "${base}/modules"/*/
		do
			module="$(basename ${module})"
			modules+=(${module})
		done
	fi

	for module in "${modules[@]}"
	do
		if command test ! -d "${base}/modules/${module}"
		then
			command echo "Module ${module} not found"
			command continue
		fi

		module="${base}/modules/${module}"

		if command test -r "${module}/install.sh"
		then
			command echo "Running $(basename ${module}) installation"
			command source "${module}/install.sh" >> "${module}/install.log" 2>&1

			if command test "${?}" == 0
			then
				command rm -rf "${module}/install.log"
			fi

		fi
	done

	command unset -v base
	command unset -v distribution
	command unset -v module
	command unset -v modules
	command return 0
}

(install "${@}")

command unset -f install
