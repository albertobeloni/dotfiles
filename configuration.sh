#!/bin/bash

(
	command set -uo pipefail

	command readonly base="$(command cd "$(command dirname "${BASH_SOURCE[0]}")" && command pwd)"
	command readonly distribution="$(source /etc/os-release && echo ${ID:-})"

	if command test -r "${base}/distributions/${distribution}.sh"
	then
		command source "${base}/distributions/${distribution}.sh"
	fi

	usage() {
		command echo "Usage: ${0##*/} [install|configure] [module...]" >&2
		command exit 2
	}

	distribution() {
		command test "${1:-}" == "${distribution}"
	}

	run() {
		command local action
		command local module
		command local path
		command local log

		action="${1}"
		module="${2}"
		path="${base}/modules/${module}"
		log="${path}/${action}.log"

		command echo "${module}: ${action}"

		(
			command set -e
			command cd "${path}"

			case "${action}" in
				"install")
					if command test -r "install.sh"
					then
						command source "install.sh"
					fi
					;;
				"configure")
					if command test -r "configure.sh"
					then
						command source "configure.sh"
					fi

					if command declare -F "pre" > "/dev/null"
					then
						pre
					fi

					if command test -d "home"
					then
						command cp -r "home/." "${HOME}"
					fi

					if command test -d "root"
					then
						command sudo cp -r --no-preserve=ownership "root/." "/"
					fi

					if command declare -F "post" > "/dev/null"
					then
						post
					fi
					;;
			esac

		) > "${log}" 2>&1

		command local status="${?}"

		if command test "${status}" -gt 0
		then
			command echo "${module}: failed (${log})" >&2
		else
			command rm -f "${log}"
		fi

		return "${status}"
	}

	main() {
		command local action

		action="${1:-}"

		command shift

		if command test "${action}" != "install" -a "${action}" != "configure"
		then
			usage
		fi

		command local -a modules
		command local module

		modules=("${@}")

		if command test "${#modules[@]}" -eq 0
		then
			for module in "${base}/modules"/*/
			do
				modules+=("$(command basename "${module}")")
			done
		fi

		command local failed

		failed=0

		for module in "${modules[@]}"
		do
			if command test ! -d "${base}/modules/${module}"
			then
				command echo "${module}: module not found" >&2

				failed=1

				command continue
			fi

			run "${action}" "${module}"

			if command test "${?}" != 0
			then
				failed=1
			fi
		done

		return "${failed}"
	}

	main "${@}"
)
