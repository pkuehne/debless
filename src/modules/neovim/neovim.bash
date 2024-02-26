function install_neovim {
	local GITHUB="neovim/neovim"

	VERSION=$(get_version "${GITHUB}" "${1}")
	if [ "${VERSION}" == "" ]; then
		error "Failed to identify a version"
		return 1
	fi

	info "Grabbing version '${VERSION}'"
	if ! github_download "${GITHUB}" "v${VERSION}" nvim.appimage nvim.appimage.sha256sum; then
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
	mv "${DL_DOWNLOADS}/nvim.appimage" "${DL_DOWNLOADS}/nvim"
	if ! install_file nvim; then
		error "Failed to install"
		return 1
	fi
}
