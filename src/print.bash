function output {
	cat=$1
	shift 1
	echo "$(date +%T) $cat $*"
}

function info {
	output "--" "$@"
}

function warn {
	output "??" "$@"
}

function error {
	output "!!" "$@"
}

function debug {
	if [ ! "${DL_DEBUG}" -eq 1 ]; then
		return
	fi
	output "~~" "$@"
}
