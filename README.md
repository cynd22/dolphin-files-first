# Dolphin — Files First

A version of KDE's **Dolphin** file manager patched so that **files are listed _above_ folders**, instead of the usual folders-on-top.

Stock Dolphin can only do "folders first" or "all mixed together" — there is no built-in "files first" option. This is a tiny 2-line source change that adds it. ([see the patch](files-first.patch))

> **For Arch-based systems only** (Arch, **CachyOS**, EndeavourOS, Manjaro, …). It will not work on Ubuntu, Fedora, etc.

---

## Install (recommended — builds on your machine)

This compiles Dolphin against *your own* system's libraries, so it always works and survives updates correctly. Copy-paste this whole block into a terminal:

```bash
sudo pacman -S --needed base-devel git
git clone https://github.com/cynd22/dolphin-files-first.git
cd dolphin-files-first
makepkg -si
```

When it asks **"dolphin … in conflict … Remove dolphin? [y/N]"**, type **`y`** and press Enter. (It's just swapping the official Dolphin for this patched one.)

The first build takes a few minutes. When it finishes, log out and back in (or run `kquitapp6 plasmashell; kstart plasmashell` / just reboot).

### ⚠️ One setting you must check
In Dolphin, open the menu (☰) → **Sort By** and make sure **“Folders First” is ticked (ON)**.
The patch *flips the meaning* of that toggle, so:

| "Folders First" toggle | Result with this build |
| --- | --- |
| **ON** (default) | **Files first** ✅ |
| OFF | Files and folders mixed together |

---

## Install (quick — prebuilt package)

If you'd rather not compile, download the latest `dolphin-files-first-*.pkg.tar.zst` from the [**Releases**](https://github.com/cynd22/dolphin-files-first/releases) page and run:

```bash
sudo pacman -U ~/Downloads/dolphin-files-first-*.pkg.tar.zst
```

> ⚠️ The prebuilt package was compiled on a different machine. If Dolphin **won't open** or you see a library/version error after installing it, that just means your KDE version differs — use the **recommended** build method above instead. It can't hurt anything to try this first.

---

## Updating

Because this package *replaces* the official `dolphin`, a normal `sudo pacman -Syu` will **not** automatically update or overwrite it — which is what we want. To pull in a newer Dolphin version later, just rebuild:

```bash
cd dolphin-files-first
git pull
makepkg -si
```

…or grab the latest prebuilt package from [Releases](https://github.com/cynd22/dolphin-files-first/releases) and `sudo pacman -U` it.

**This repo keeps itself current automatically.** A weekly GitHub Action checks for new Dolphin releases, rebuilds the patched package, and publishes a new Release — so `git pull` / the latest Release is always up to date. If a future Dolphin moves the code the patch targets, the build fails safely and an issue is filed instead of shipping something broken. (The `pkgver` bump is automatic; the patch itself rarely needs touching.)

## Going back to normal Dolphin

```bash
sudo pacman -S dolphin
```

That removes this build and restores the stock file manager.

---

## What it actually changes

Dolphin decides folder-vs-file order in `KFileItemModel::lessThan()`. The patch swaps the two return values in its "folders first" comparison so files win the tie instead of folders. That's the whole change — see [`files-first.patch`](files-first.patch).

Built from the official Arch [`dolphin`](https://gitlab.archlinux.org/archlinux/packaging/packages/dolphin) packaging. Dolphin is © KDE, licensed LGPL-2.0-or-later. This repo only adds the patch and packaging.
