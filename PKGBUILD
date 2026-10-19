pkgname=raspi-config-git
pkgver=20260925.r0.293f4bb
pkgrel=1
pkgdesc='Raspberry Pi hardware interface configuration for Arch Linux ARM'
arch=('any')
url='https://github.com/bbreisch26/raspi-config-alarm'
license=('MIT')
depends=('libnewt' 'ncurses' 'pacman' 'util-linux')
makedepends=('git')
provides=('raspi-config')
conflicts=('raspi-config')
source=("raspi-config-alarm::git+$url#branch=arch-trixie")
sha256sums=('SKIP')

pkgver() {
  cd "$srcdir/raspi-config-alarm"
  printf '%s.r%s.%s' \
    "$(git log -1 --date=format:%Y%m%d --format=%ad)" \
    "$(git rev-list --count HEAD)" \
    "$(git rev-parse --short=7 HEAD)"
}

package() {
  cd "$srcdir/raspi-config-alarm"
  install -Dm755 raspi-config "$pkgdir/usr/bin/raspi-config"
  install -Dm644 LICENSE "$pkgdir/usr/share/licenses/$pkgname/LICENSE"
}
