function install_lazygit {
	local GITHUB="jesseduffield/lazygit"

	VERSION=$(github_latest_version ${GITHUB})
	if [ "${VERSION}" == "" ]; then
		error "Failed to grab latest version"
		return 1
	fi

	FILENAME="lazygit_${VERSION}_Linux_x86_64.tar.gz"

	info "Grabbing version '${VERSION}'"
	if ! github_download "${GITHUB}" "v${VERSION}" "${FILENAME}"; then
		error "Failed to download files"
		return 1
	fi

	if ! (
		cd "${DL_DOWNLOADS}"
		tar xf "${FILENAME}" lazygit
	); then
		error "Failed to untar the file"
		return 1
	fi

	if ! install_file lazygit; then
		error "Failed to install"
		return 1
	fi
}
