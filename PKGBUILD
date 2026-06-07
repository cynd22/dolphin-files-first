# Maintainer: cynd22
#
# A drop-in replacement for KDE's Dolphin file manager, patched so that
# FILES are listed before FOLDERS. Based on the official Arch Linux PKGBUILD.
# Builds against your own system's KDE libraries, so it always matches.

_pkgbase=dolphin
pkgname=dolphin-files-first
pkgver=26.04.2
pkgrel=1
pkgdesc='KDE File Manager, patched to sort files before folders'
arch=(x86_64)
url='https://apps.kde.org/dolphin/'
license=(LGPL-2.0-or-later)
# Don't emit a separate -debug package (keeps output to a single file and
# matches a typical desktop makepkg.conf).
options=(!debug)
depends=(baloo
         baloo-widgets
         glibc
         kbookmarks
         kcmutils
         kcodecs
         kcolorscheme
         kcompletion
         kconfig
         kconfigwidgets
         kcoreaddons
         kcrash
         kdbusaddons
         kfilemetadata
         kguiaddons
         ki18n
         kiconthemes
         kio
         kio-extras
         kjobwidgets
         knewstuff
         knotifications
         kparts
         kservice
         ktextwidgets
         kuserfeedback
         kwidgetsaddons
         kwindowsystem
         kxmlgui
         libstdc++
         qt6-base
         qt6-multimedia
         solid)
makedepends=(extra-cmake-modules
             kdoctools)
optdepends=('dolphin-plugins: extra plugins'
            'ffmpegthumbs: video thumbnails'
            'filelight: detailed disk usage statistics'
            'kde-cli-tools: for editing file type options'
            'kdegraphics-thumbnailers: PDF and PS thumbnails'
            'kdenetwork-filesharing: samba usershare properties menu'
            'kdf: view disk usage'
            'kio-admin: for managing files as administrator'
            'kompare: comparing files menu action'
            'konsole: terminal panel'
            'purpose: share context menu')
# Take the place of the regular dolphin package. This stops a routine
# "pacman -Syu" from silently swapping the patched build back to stock
# dolphin (nothing depends on the literal name once we "provide" it).
provides=("dolphin=$pkgver")
conflicts=(dolphin)
replaces=(dolphin)
source=(https://download.kde.org/stable/release-service/$pkgver/src/$_pkgbase-$pkgver.tar.xz
        files-first.patch)
sha256sums=('c7e90beb8ce13aea091494ae7ddfabde999b1297986a596403828010bec59346'
            'da7dc91dea566147c756d1f126f6c6d8861a4a07312c4baa6137e7b66b04f05d')

prepare() {
  patch -d $_pkgbase-$pkgver -p1 < files-first.patch
}

build() {
  cmake -B build -S $_pkgbase-$pkgver \
    -DBUILD_TESTING=OFF
  cmake --build build
}

package() {
  DESTDIR="$pkgdir" cmake --install build
}
