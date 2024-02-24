function install_neovim {
	local RELEASE="latest"
	local GITHUB="neovim/neovim"

	if [ "${1}" != "" ]; then
		RELEASE=${1}
	else
		info "Getting latest release version"
		VERSION=$(github_latest_version ${GITHUB})
		if [ "${VERSION}" == "" ]; then
			error "Failed to grab latest version"
			return 1
		fi
		RELEASE="v${VERSION}"
	fi

	info "Grabbing version '${RELEASE}'"
	if ! github_download "${GITHUB}" "${RELEASE}" nvim.appimage nvim.appimage.sha256sum; then
		error "Failed to download files"
		return 1
	fi

	# Check dependencies
	if ! dpkg-query -l libfuse2 >/dev/null 2>&1; then
		warn "libfuse2 needs to be installed"
		sudo apt install libfuse2
	else
		info "libfuse2 already installed"
	fi

	# Install in bin dir
	local BIN_FILE="${DL_DOWNLOADS}/nvim.appimage"
	chmod a+x "${BIN_FILE}"
	if ! sudo cp "${BIN_FILE}" "${DL_BIN_DIR}"/nvim; then
		error "Failed to install file in ${DL_BIN_DIR}"
		return 1
	fi
}
