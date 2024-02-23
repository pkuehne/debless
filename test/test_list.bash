setup() {
	load 'common'
	_common_setup
	load list.bash
  export DL_MODULES="${DIR}/../src/modules"
}

@test "module list includes neovim" {
  run available_modules
  assert_output -p "neovim"
}
