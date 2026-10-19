# raspi-config for Arch Linux ARM

This branch starts from Raspberry Pi OS `trixie` commit
`293f4bb0bfe0efba41b0a8260b52b161239f2a33` (2026-09-25), rather than
replaying the Arch fork's 2020 patches onto outdated Raspberry Pi OS code.
It preserves the upstream MIT license and attribution in `LICENSE`.

## Supported menu

Run `sudo raspi-config` on a Raspberry Pi 4B or 5 with the firmware partition
mounted at `/boot`. The menu currently exposes SPI, I2C, serial and 1-Wire.
Raspberry Pi OS service, desktop, network and update menus are hidden because
their Debian-specific commands are not safe on Arch Linux ARM. Unsupported
non-interactive actions are rejected.

The menu writes `/boot/config.txt` and `/boot/cmdline.txt`. I2C and SPI changes
take effect after reboot in this port; no live `dtparam` invocation is attempted.
On Pi 4B, `serial0` is normally the GPIO-header UART. On Pi 5, the serial
console is on the debug header while `dtparam=uart0` enables UART0 on GPIO14/15.
Serial changes also require reboot. The tool does not manage device permissions
or install GPIO/I2C/SPI development tools.

## Validation

Run `sh tests/test_arch_interfaces.sh` for boot-file edits. `PKGBUILD` produces
an Arch package from this branch. Physical Pi 4B and Pi 5 tests are required
before release, including UART console/data behaviour, I2C and SPI devices,
and 1-Wire enumeration. The package is not yet integrated into the Omarchy Pi
image or published to AUR.
