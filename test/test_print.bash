setup() {
  load 'common'
  _common_setup
  load print.bash
}

@test "info prints --" {
  run info "Hello"
  assert_output -p '-- Hello'
}

@test "warn prints ??" {
  run warn "Hello"
  assert_output -p '?? Hello'
}

@test "err prints !!" {
  run error "Hello"
  assert_output -p '!! Hello'
}
