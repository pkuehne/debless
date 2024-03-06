function available_modules {
	DL_ALL_MODULES=""
	shopt -s nullglob # Empty result if nothing matches glob
	for module_path in "${DL_MODULES}"/*.bash; do
		module=$(basename "${module_path%.*}")
		DL_ALL_MODULES="${DL_ALL_MODULES} ${module}"
	done
	echo "${DL_ALL_MODULES}"
}
