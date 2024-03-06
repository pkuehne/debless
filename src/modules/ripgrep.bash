function install_ripgrep {
	local GITHUB="BurntSushi/ripgrep"
	VERSION=$(get_version "${GITHUB}" "${1}")
	if [ "${VERSION}" == "" ]; then
		error "Failed to identify a version"
		return 1
	fi

	BASENAME="ripgrep-${VERSION}-x86_64-unknown-linux-musl"
	FILENAME="${BASENAME}.tar.gz"
	info "Grabbing version '${VERSION}'"
	if ! github_download "${GITHUB}" "${VERSION}" "${FILENAME}" "${FILENAME}.sha256"; then
		error "Failed to download files"
		return 1
	fi

	if ! (
		cd "${DL_DOWNLOADS}"
		tar xf "${FILENAME}"
	); then
		error "Failed to untar the file"
		return 1
	fi

	if ! install_file ${BASENAME}/rg; then
		error "Failed to install"
		return 1
	fi

}
