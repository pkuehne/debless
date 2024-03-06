function install {
	# Check module exists
	local MODULE=$1
	if [ ! -f "${DL_MODULES}/${MODULE}.bash" ]; then
		error "Can't install ${MODULE}: ${MODULE}.bash not found"
		return 1
	fi

	# Check bin dir exists
	if [ ! -d "${DL_BIN_DIR}" ]; then
		warn "${DL_BIN_DIR} does not exist, creating..."
		mkdir -p "${DL_BIN_DIR}"
	fi

	info "Installing ${MODULE}"
	# shellcheck disable=SC1090
	source "${DL_MODULES}/${MODULE}.bash"
	if [ ! "$(type -t "install_${MODULE}")" == function ]; then
		error "${MODULE}.bash does not have an install_${MODULE} function"
		return 1
	fi

	# Call module's install function
	shift 1
	if ! "install_${MODULE}" "${@}"; then
		error "Failed to install ${MODULE}"
	else
		info "Successfully installed ${MODULE}"
	fi
}
