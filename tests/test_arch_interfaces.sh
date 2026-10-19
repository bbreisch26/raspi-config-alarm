#!/bin/sh
set -eu

test_dir=$(mktemp -d)
trap 'rm -rf "$test_dir"' EXIT

printf '[all]\nenable_uart=1\n' > "$test_dir/config.txt"
printf 'root=PARTUUID=abcd rw console=serial0,115200 console=tty1\n' > "$test_dir/cmdline.txt"

id() {
  printf '0\n'
}

set --
INTERACTIVE=False
. "$(dirname "$0")/../raspi-config"
CONFIG=$test_dir/config.txt
CMDLINE=$test_dir/cmdline.txt

do_spi 0
grep -qx 'dtparam=spi=on' "$CONFIG"
do_spi 1
grep -qx 'dtparam=spi=off' "$CONFIG"

do_i2c 0
grep -qx 'dtparam=i2c_arm=on' "$CONFIG"
do_i2c 1
grep -qx 'dtparam=i2c_arm=off' "$CONFIG"

do_onewire 0
grep -qx 'dtoverlay=w1-gpio' "$CONFIG"
do_onewire 1
grep -qx '#dtoverlay=w1-gpio' "$CONFIG"

do_serial_cons 1
! grep -q 'console=serial0' "$CMDLINE"
grep -q 'console=tty1' "$CMDLINE"

printf 'root=PARTUUID=abcd rw console=serial0,115200\n' > "$CMDLINE"
do_serial_cons 1
! grep -q 'console=serial0' "$CMDLINE"
grep -q 'root=PARTUUID=abcd rw' "$CMDLINE"

is_pifive() {
  return 0
}

do_serial_hw 0
grep -qx 'dtparam=uart0=on' "$CONFIG"
do_serial_hw 1
! grep -q '^dtparam=uart0=' "$CONFIG"

printf 'Arch interface configuration tests passed\n'
