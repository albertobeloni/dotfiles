#!/bin/bash

configure()
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

		if command test -r "${module}/configure.sh"
		then
			command echo "Running $(basename ${module}) configuration"
			command source "${module}/configure.sh" >> "${module}/configure.log" 2>&1
		fi

		if command hash "pre" > "/dev/null" 2>&1
		then
			pre >> "${module}/configure.log" 2>&1
		fi

		if command test -d "${module}/home"
		then
			command cp -a "${module}/home/." "${HOME}" >> "${module}/configure.log"
		fi

		if command test -d "${module}/root"
		then
			command sudo cp -a "${module}/root/." "/" >> "${module}/configure.log"
		fi

		if command hash "post" > "/dev/null" 2>&1
		then
			post >> "${module}/configure.log" 2>&1
		fi

		if command test "${?}" == 0
		then
			command rm -rf "${module}/configure.log"
		fi

	done

	command unset -v base
	command unset -v distribution
	command unset -v module
	command unset -v modules
	command return 0
}

(configure "${@}")

command unset -f pre
command unset -f post
command unset -f configure
