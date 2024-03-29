function download {
	info "Downloading ${1##/*}"
	if ! curl -L -O -s -f --output-dir "${DL_DOWNLOADS}" "${1}"; then
		error "Failed to download ${1}"
		return 1
	fi
	return 0
}

function verify256 {
	local SHAFILE=$1

	info "Checking ${SHAFILE} in ${DL_DOWNLOADS}"
	if ! (
		cd "${DL_DOWNLOADS}" || return 1
		sha256sum -c --status "${SHAFILE}"
	); then
		error "Checksums do not match!"
		return 1
	fi
	info "Checksums match!"
	return 0
}

function github_latest_version {
	local GITHUB=$1
	LATEST_MANIFEST=$(curl -L -s "https://api.github.com/repos/${GITHUB}/releases/latest")
	VERSION_NUMBER=$(echo "${LATEST_MANIFEST}" | jq ".tag_name" | grep -Po '\"[v]*\K[^"]*')
	echo "${VERSION_NUMBER}"
}

function get_version {
	local GITHUB=$1
	local VERSION=$2
	if [ "${VERSION}" != "" ]; then
		echo "${VERSION}"
		return 0
	fi
	github_latest_version "${GITHUB}"
}

function github_download {
	local GITHUB=$1
	local VERSION=$2
	local FILENAME=$3
	local SHAFILE=$4

	local URL=https://github.com/${GITHUB}/releases/download/${VERSION}
	if ! download "${URL}/${FILENAME}"; then
		return 1
	fi
	if [ "${SHAFILE}" == "" ]; then
		info "No checksum to verify"
		return 0
	fi
	if ! download "${URL}/${SHAFILE}"; then
		return 1
	fi
	if ! verify256 "${SHAFILE}"; then
		return 1
	fi
	return 0
}

function install_file {
	# Ensure file is executable
	local BIN_FILE=$1
	cd "${DL_DOWNLOADS}" || return 1
	chmod a+x "${BIN_FILE}"
	SUDO="sudo"
	if [ -w "${DL_BIN_DIR}" ]; then
		SUDO="" # Don't need sudo
	fi
	${SUDO} install "${BIN_FILE}" "${DL_BIN_DIR}"

}
