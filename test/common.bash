_common_setup() {
	load 'test_helper/bats-support/load'
	load 'test_helper/bats-assert/load'
	DIR="$(cd "$(dirname "$BATS_TEST_FILENAME")" >/dev/null 2>&1 && pwd)"
	PATH="$DIR/../src:$PATH"
}
