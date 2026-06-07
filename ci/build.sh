#!/usr/bin/env bash
# Runs inside an archlinux container (as root), bumps the PKGBUILD to the
# requested Dolphin version, refreshes checksums, and builds the package.
# Building (and updpkgsums) must run as a non-root user, so we drop to one.
set -euo pipefail

NEW="${1:?usage: build.sh <pkgver>}"

pacman -Syu --noconfirm --needed \
  archlinux-keyring base-devel git pacman-contrib \
  extra-cmake-modules kdoctools \
  baloo baloo-widgets kbookmarks kcmutils kcodecs kcolorscheme kcompletion \
  kconfig kconfigwidgets kcoreaddons kcrash kdbusaddons kfilemetadata \
  kguiaddons ki18n kiconthemes kio kio-extras kjobwidgets knewstuff \
  knotifications kparts kservice ktextwidgets kuserfeedback kwidgetsaddons \
  kwindowsystem kxmlgui qt6-base qt6-multimedia solid

useradd -m builder 2>/dev/null || true
chown -R builder:builder /work

su builder -c "cd /work && \
  sed -i 's/^pkgver=.*/pkgver=$NEW/' PKGBUILD && \
  sed -i 's/^pkgrel=.*/pkgrel=1/' PKGBUILD && \
  updpkgsums && \
  makepkg -f"
